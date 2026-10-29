<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.Clinicalnotes>" %>



<asp:Content ID="Content3" ContentPlaceHolderID="Head" runat="server">
    <style>
        .dropdown {
            position: relative;
            display: inline-block;
            width: 100%;
            /*//;*/
        }
        #DoctorInput{
            width:90% !important;
        } 
        .column-title {
            font-weight: normal;
            font-size: small;
        }
        .ui-jqgrid .ui-jqgrid-htable th div {
            height: 30px;
            overflow: hidden;
            padding-right: 4px;
            padding-top: 2px;
            position: relative;
            vertical-align: middle;
            white-space: normal !important;
            font-weight: bold;
            font-size: 12px;
            text-align: center;
        }

         .ui-jqgrid tr.jqgrow td {
        word-wrap: break-word; /* IE 5.5+ and CSS3 */
        white-space: pre-wrap; /* CSS3 */
        white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
        white-space: -pre-wrap; /* Opera 4-6 */
        white-space: -o-pre-wrap; /* Opera 7 */
        overflow: hidden;
        height: auto;
        vertical-align: middle;
        padding-top: 3px;
        padding-bottom: 3px
     }
        .TextBxFormat {
            font-family: Calibri,Arial;
            font-size: 13.5px;
            height: 22px;
            border-bottom-color: #075366;
            border-right-color: #075366;
            border-width: 1px;
            background: white;
            color: #075366;
            background: white;
            border-top-left-radius: 3px;
            border-top-right-radius: 3px;
            border-bottom-left-radius: 3px;
            border-bottom-right-radius: 3px;
        }

        .errtextbox {
            border-color: red;
        }

        .ui-jqgrid tr.jqgrow {
            /*height: 25px;*/
        }

        tr.ui-jqgrid-labels {
            /*height: 40px;*/
        }

        .ui-jqgrid .ui-jqgrid-sdiv .footrow {
            font-size: 14px;
        }


        /*select tag */
        .select_join {
            width: 170px;
            height: 28px;
            overflow: hidden;
            /*background: url('http://s24.postimg.org/lyhytocf5/dropdown.png') no-repeat right #FEFEFE;*/
            border: Black 1px solid;
            -webkit-border-radius: 3px;
            border-radius: 3px;
            -webkit-box-shadow: inset 0px 0px 10px 1px #FEFEFE;
            box-shadow: inset 0px 0px 10px 1px #FEFEFE;
        }

            .select_join select {
                background: transparent;
                width: 170px;
                font-size: 11pt;
                color: grey;
                border: 0;
                border-radius: 0;
                height: 28px;
                -webkit-appearance: none;
            }

                .select_join select:focus {
                    outline: none;
                }

        /*save button */
        .save_button {
            background: #4f8edd;
            color: #fff;
            border: 1px solid black;
            border-radius: 20px;
            box-shadow: 5px 5px 5px #eee;
            text-shadow: none;
            width: 80px;
            height: 30px;
            text-align: center;
            font-size: 18px;
        }

        /*.content-wrapper {
            width: 100%;
        }*/


        table {
            width: 100%;
        }

            tr:after {
                content: ' ';
                display: block;
                visibility: hidden;
                clear: both;
            }

            thead th {
                height: 30px;
                text-align: left;
            }

        tbody {
            /*height: 280px;*/
            overflow-y: auto;
        }

        .StuckInput {
            width: 100%;
            position: fixed;
            /*top: 0;
            left: 0;*/
        }


        #remarks {
            width: 500px;
        }

            #remarks option {
                width: 500px;
            }


        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-decoration: inherit;
        }


        .spinner {
            width: 100px;
        }

            .spinner input {
                text-align: right;
            }

        .input-group-btn-vertical {
            position: relative;
            white-space: nowrap;
            width: 1%;
            vertical-align: middle;
            display: table-cell;
        }

            .input-group-btn-vertical > .btn {
                display: block;
                float: none;
                width: 100%;
                max-width: 100%;
                padding: 8px;
                margin-left: -1px;
                position: relative;
                border-radius: 0;
            }

                .input-group-btn-vertical > .btn:first-child {
                    border-top-right-radius: 4px;
                }

                .input-group-btn-vertical > .btn:last-child {
                    margin-top: -2px;
                    border-bottom-right-radius: 4px;
                }

            .input-group-btn-vertical i {
                position: absolute;
                top: 0;
                left: 4px;
            }

        a:hover {
            color: #555;
        }

        Label {
            margin-left: 5px;
        }
        /*added by vijeta on 16/7/19 fr vaccination*/
          .row {
                margin-left: 0px;
            }

          #tblAgeGrpFrm td{
                 padding-bottom: 7px;
          }

         #tblAgeGrpFrm{
                  font-size: larger;
         }
         
         .panel-heading{padding-top:3px;margin-left:0; margin-right:0; 
               font-size: 15.5px;background-color:#2D94D0;color:#fff;
               height:26px;font-family:Calibri;font-weight: bold;
               
               background: radial-gradient(#58bcff, #056aa9);
               /*background-color:#4a5056;*/
}
         #divAllControl{
             font-size:14px;
         }

         .CancelClass td{
         color:rgb(220, 9, 9) !important; 
            background-image:none; 
           font-weight: bold !important;
            background:rgba(190, 53, 51, 0.04);     
    }
    </style>




  <%--  <script src="../JS/jqGrid/jquery.jqGrid.js"></script>
    <script src="../JS/jqGrid/grid.locale-en.js"></script>--%>
    
    <script src="../plugins/alert/jquery-confirm.js"></script>
    <link href="../plugins/alert/jquery-confirm.css" rel="stylesheet" />
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/Doctorlist.js"></script>
   <script src="<%=ResolveUrl("~/js/i18n/grid.locale-en.js")%>"></script>
   <script src="../js/jquery.jqGrid.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.js"></script>
    <%-- <link href="~/js/fancybox/jquery.fancybox2.0.5.css" rel="stylesheet" type="text/css" />--%>
    <link href="../Scripts/fancybox/jquery.fancybox2.0.5.css" rel="stylesheet" />
    <%--<script src="<%=ResolveUrl("~/js/fancybox/jquery.fancybox.pack2-0-5.js" )%>"></script>--%>
    <script src="../Scripts/fancybox/jquery.fancybox.pack2-0-5.js"></script>
    <script type="text/javascript">
        <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var AllergyTypeList = '<%:Html.Raw(Samp.Serialize(ViewBag.AllergyTypeLst))%>';
        AllergyTypeList = JSON.parse(AllergyTypeList);
        var strType = "";
        var strHindi = "";
        var strMarathi = "";
        var strGujrati = "";
        var stype = "";
        var NAME = "";
        var strUser = "";
        var strNew = new Array();
        var strNew1 = new Array();
        var strNew2 = new Array();
        var strNew3 = new Array();
        var str1 = new Array();
        var str2 = new Array();
        var str3 = new Array();
        var str4 = new Array();
        var str = new Array();
        var str1 = "";
        var str2 = "";
        var str3 = "";
        var str4 = "";
        var ResultOfClinic = "";
        var opt1 = "";
        var opt2 = "";
        var select = "";
        var globalVcnCdCnt = 0;
        var pathFrom = "";
        var CalcQtyYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CALCQTYBASEDFREQRX")%>';

        $(document).ready(function (e) {
            $("#divTblAgeGrpgrid").hide();
            $("#divtblOPLISTgrid").show();

            SetPatientDtl();
            BindAgeGroupGrid();//added 17/7/19
            FillVaccinationGrid();//added 17/7/19

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                //var dispLst = document.getElementById('sideList');
                //dispLst.style.display = "block";

            }
            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');

            if (pathFrom != "") {
                var doctCd = ('<%:Session["gDoctCode"]%>').toString();
            SearchFunction(doctCd);
            $("#DoctorInput").css("display", "none");
            var menuL = document.getElementById('menuList');
            menuL.style.display = "none";
            //
            var leftSideNenuLst = document.getElementById('menuList');
            var rightSideMenuLst = document.getElementById('sideList');
            leftSideNenuLst.style.display = "none";
            rightSideMenuLst.style.display = "none";
            $("#divForBack").show();
            $("#iformenubar").hide();
            $("#menuBar").css("margin-top", "11px")
            //end
        }
        else {
            $("#DoctorInput").val(doctName);
            $("#divForBack").hide();
            $("#iformenubar").show();
            $("#menuBar").css("margin-top", "0px")

        }


            $("#save_btn").on("click", function () {
                var ids = jQuery("#tblOPLISTgrid").jqGrid('getDataIDs');
                for (var i = 1; i <= ids.length; i++) {
                    $('#tblOPLISTgrid').jqGrid("editCell", 0, 0, false);
                }
                var data = $.grep($('#tblOPLISTgrid').getRowData(), function (e) { return e.Check == 'Yes' });
                if (document.getElementById('sel').value == "L") {
                    data.forEach(function (item) {
                        item.FIELD3COL = item.ALLERGYTYPE;
                        delete item.ALLERGYTYPE;
                        delete item.TABCOUNT;
                    });
                }
                stype = document.getElementById('sel').value;
                var datatosend = {
                    data: JSON.stringify(data),
                    strType: stype
                };
                $.ajax({
                    type: 'post',
                    data: datatosend,
                    url: 'SendData',
                    cache: false,
                    dataType: "json",
                    async: false,
                    success: function (result) {
                        if (result.search("Success") > -1)
                            $.messager.alert("Information", "Saved Successfully");
                        else
                            $.messager.alert("Information", result);
                        GetReportData();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $.messager.alert('An error occurred while processing your request.', 'Error Information');
                    }
                });
            });

            $(function () {

                $("#btnTrandiv").fancybox({
                    openeffect: 'elastic',
                    openspeed: 100,
                    closeeffect: 'elastic',
                    closespeed: 100,

                    helpers: {
                        overlay: { closeclick: false }
                    }

                });
            });
            //$(window).on("resize", function () {
            //    var $grid = $("#tblOPLISTgrid"),
            //        newWidth = $grid.closest(".ui-jqgrid").parent().width();
            //    $grid.jqGrid("setGridWidth", newWidth, true);
            //});

            $("#myAdd").click(function () {
                ClinicIndexChanged();
                var Height = "195px"; var TabletCountDisplay = "none";
                if (stype == "" || stype == 'S') {
                    return false;
                }
                if (stype == 'C') {
                    var comp = "Complaints";
                }
                if (stype == 'D') {
                    var comp = "Diagnosis";
                }
                if (stype == 'A') {
                    var comp = "Patient Advice";
                }
                if (stype == 'R') {
                    var comp = "Medicine Remarks";
                }
                if (stype == 'T') {
                    var comp = "Route";
                }
                if (stype == 'H') {
                    var comp = "Personal History(Addiction/Habit)";
                }
                if (stype == 'F' && CalcQtyYN == "Y") {
                    Height = "250px";
                    TabletCountDisplay = "block";
                }
                if (stype == 'L') {
                    comp = "Allergy";
                    Height = "300px";   
                }
                if (stype != "G") //added 15/7/19 fr Vaccination
                {
                    $.confirm({
                        title: '',
                        content: '' +
                        '<form action="" class="formName" style="height:' + Height + '">' +
                        '<div class="form-group">' +
                      // 
                       '<label> New ' + comp + ' Entry </label>' +
                       '<br/>' +
                       '<label id="Label47" style="display:block;" class="LBLFormat">Clinic</label>' +
                       select +
                       '<label id="Label48" style="display: block;" class="LBLFormat">Allergy Type</label>' +
                        '<select id="cmbAllergyType" style="display:' + (document.getElementById('sel').value == "L" ? "block" : "none") + ';" class="form-control">' + BindAllergyTypeList("") + '</select>' +
                       '<input  type="varchar" id="english"  placeholder="English" autofocus="autofocus" class="complaint form-control" style="margin-top: 4px"  required />' +
                        '<input  type="varchar" id="marathi"  placeholder="Marathi" autofocus="autofocus" class="complaint form-control" style="margin-top: 4px" required />' +
                        '<input  type="varchar" id="hindi"  placeholder="Hindi" autofocus="autofocus" class="complaint form-control" style="margin-top: 4px" required />' +
                        '<input  type="varchar" id="gujrati"  placeholder="Gujrati" autofocus="autofocus" class="complaint form-control" style="margin-top: 4px" required />' +
                        '<input  type="varchar" id="TabletCount"  placeholder="Tablet Count" autofocus="autofocus" class="complaint form-control" style="margin-top: 4px;display:' + TabletCountDisplay + '" value="1.00" onkeyup="NumberOnly(this)" onblur="NumberFixed2(this)"  required />' +
                        '</form>',
                        buttons: {
                            formSubmit: {
                                text: 'Save',
                                btnClass: 'btn-blue',
                                btnid: 'save_update',
                                action: function () {
                                    var english = this.$content.find('#english').val();
                                    var marathi = this.$content.find('#marathi').val();
                                    var hindi = this.$content.find('#hindi').val();
                                    var gujrati = this.$content.find('#gujrati').val();
                                    var Field3 = CalcQtyYN == "Y" ? this.$content.find('#TabletCount').val() : "1.00";
                                    var selec = this.$content.find('#selec').val();
                                    var AllergyTypeCD = "";
                                    if (selec == "--Select--") {
                                        $.alert('Please Select Clinic');
                                        return false;
                                    }
                                    if (document.getElementById('sel').value == "L") {
                                        if($("#cmbAllergyType").val() == ""){
                                            $.alert('Please Select Allergy Type.');
                                            return false;
                                        }
                                        Field3 = $("#cmbAllergyType").val();
                                    }
                                    if (english == "") {
                                        $.alert('Please Enter ' + comp + ' in English');//
                                        return false;
                                    }

                                    if (english != "" && selec != "") {
                                        stype = document.getElementById('sel').value;
                                        var urls = '../Clinicalnotes/AddLanguageEntry';
                                        var datatosend = {
                                            NAME: english,
                                            strType: stype,
                                            strHindi: hindi,
                                            strMarathi: marathi,
                                            strGujrati: gujrati,
                                            Field3: Field3
                                        }
                                        $.ajax({
                                            type: "POST",
                                            data: datatosend,
                                            url: urls,
                                            dataType: "json",
                                            success: function (result) {
                                                $.messager.alert("Information", result);
                                                GetReportData();
                                            },
                                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                $.messager.alert('An error occurred while processing your request.', 'Error Information');
                                            }
                                        });

                                    }
                                }
                            },
                            close: function () {
                                //close
                                //$('.FoodItems input:checked').focus();
                            },
                        },

                    });
                }
                else {
                    SaveOrUpdateAgeGroup();
                }
            });

            BindLanguageEntryGrid(strNew);

            if (stype == 'S') {
                $("#myAdd".removeAttr("disabled"));
            }

            $("#tblOPLISTgrid").hideCol("Code")


            // added by vijeta on 7th april 2018
            var lst = document.getElementById('sideList');
            //window.onclick = function (event) {

            //    if (event.target == document.getElementById('menuDots')) {
            //        lst.style.display = "block";
            //    }
            //    else {
            //        if ($(window).width() >= 996) {
            //            lst.style.display = "block";
            //        }
            //        else
            //            lst.style.display = "none";
            //    }

            //}
        });

    function SetpageDirctn() {
        if (pathFrom == "") {
            window.location.href = '../ClinicalNotes/ClinicEntry';
        } else
            window.location.href = '../DoctorDesk/PatientEntry';
    }
    function ClinicIndexChanged() {

        var urls = '../Clinicalnotes/ClinicIndexChanged';
        $.ajax({
            type: "POST",
            url: urls,
            async: false,
            dataType: "json",
            success: function (response) {
                if (response != null) {
                    ResultOfClinic = response;
                    opt1 += '<option id="option1">' + '--Select--' + '</option>'
                    for (var m = 0; m < ResultOfClinic.length; m++) {

                        opt2 += '<option >' + ResultOfClinic[m].Text + '</option>'
                    }

                    select = '<select id="selec" class="form-control">' + opt1 + opt2 + '</select>'
                }
                else {

                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                MsgDia('An error occurred while processing your request.', "Error Information");
            }
        });
    }


    function GetReportData() {
        stype = document.getElementById('sel').value;
        $("#save_btn").hide();//
        if (stype == 'S') {
            $("#divtblOPLISTgrid").show();//added 15/7/19 fr Vaccination
            $("#divTblAgeGrpgrid").hide();
            jQuery("#tblOPLISTgrid").clearGridData(true).trigger("reloadGrid");

        }

        //added 13/7/19 fr Vaccination
        if (stype == 'G') {

            $("#divtblOPLISTgrid").hide();
            $("#divTblAgeGrpgrid").show();
            $("#vaccinenote").css('display', 'block')  //27-11-2019  13:16
            //   $("#save_btn").hide(); //11/12/2019

            GetAgeLst();
        }

        if (stype != 'S' && stype != "G") {
            $("#divtblOPLISTgrid").show(); //added 15/7/19 fr Vaccination
            $("#divTblAgeGrpgrid").hide();
            $("#vaccinenote").css('display', 'none')  //09/12/2019 18:40
            $("#save_btn").show(); //12/11/2019
            $.ajax({
                type: "GET",
                url: "../Clinicalnotes/GetReportData",
                data: { strType: stype },
                async: false,
                datatype: "json",
                success: function (result) {
                    if (result != "null") {
                        var res = JSON.parse(result);

                    }
                    BindLanguageEntryGrid(res);
                }
            });
        }

    }

    //Complaints Diagnosis Patient Advice Medicine Remarks  GRID function response, str
    function BindLanguageEntryGrid(res) {

        var colnames = "";
        var colmodel = "";
        var sortnm = ''
        var footerrow = false;
        var TypeLst = BindAllergyTypeList("Grid");
        //if (str == 1) {
        colnames = ['Check', 'Code', 'Type', 'Name', 'Tablet Count', 'Hindi', 'Marathi', 'Gujrati', 'Created By', 'Status'];
        colmodel = [
             {
                 name: "Check", index: 'Check', width: 70, align: "center",
                 formatter: "checkbox", formatoptions: { disabled: false },
                 edittype: "checkbox", editoptions: { value: "Yes:No", defaultValue: "Yes" },
                 stype: "select", searchoptions: {
                     sopt: ["eq", "ne"],
                     value: ":Any;true:Yes;false:No"
                 }
             },
                { name: 'CODE', index: 'CODE', width: 50, sortable: true, resizable: false, sorttype: 'number', hidden: true },
                {
                    name: 'ALLERGYTYPE',
                    index: 'ALLERGYTYPE',
                    width: 160,
                    hidden :  document.getElementById('sel').value == "L" ? false: true,
                    sortable: true,
                    resizable: true,
                    editable: true,
                    edittype: 'select',
                    editoptions: {
                        value: TypeLst,
                        style: "width: 100%;"
                    },
                    formatter: 'select',
                    stype: 'select',
                    searchoptions: {
                        value: ":All;" + TypeLst
                    }
                },
                { name: 'NAME', index: 'NAME', width:  document.getElementById('sel').value == "L" ? 500 : 160, sortable: true, resizable: true },
                {
                    name: 'TABCOUNT', index: 'TABCOUNT', width: 160, sortable: true, resizable: true, hidden: (stype == "F" && CalcQtyYN == "Y" ? false : true), editable: true, edittype: 'text',
                    editrules: {
                        number: true
                    },
                    editoptions: {
                        dataEvents: [
                            {
                                type: 'input',
                                fn: function (e) {
                                    NumberOnly(this);
                                    //var value = this.value;
                                    //this.value = value.replace(/[^0-9\.]/g, '');
                                    //if ((this.value.match(/\./g) || []).length > 1) {
                                    //    this.value = this.value.slice(0, -1);
                                    //}
                                }
                            }
                        ]
                    },
                    formatter: 'number',
                    formatoptions: {
                        decimalSeparator: '.',
                        thousandsSeparator: ',',
                        defaultValue: "1.00"
                    }
                },
                { name: 'HINDI', index: 'HINDI', width: 160, sortable: true, resizable: true, hidden: document.getElementById('sel').value == "L" ? true : false, },
                { name: 'MARATHI', index: 'MARATHI', width: 160, sortable: true, resizable: true, hidden: document.getElementById('sel').value == "L" ? true : false, },
                { name: 'GUJRATI', index: 'GUJRATI', width: 160, sortable: true, resizable: true, hidden: document.getElementById('sel').value == "L" ? true : false, },
                { name: 'CREATEDBY', index: 'CREATEDBY', width: 100, sortable: true, resizable: true },
                  {
                      name: 'STATUS', index: 'STATUS', width: 90, align: "left",
                      edittype: 'select', formatter: 'select', editrules: { required: true },
                      editoptions: { value: "A:Active;I:Inactive", style: " width: 85px; height: 22px; " }, searchoptions: { sopt: ["eq", "ne"], value: ":All;A:Active;I:Inactive" }
                  },
        ],
        sortnm = 'Complaints';


        $("#tblOPLISTgrid").jqGrid('GridUnload');
        jQuery("#tblOPLISTgrid").jqGrid({
            colNames: colnames,
            colModel: colmodel,
            data: res,
            datatype: 'local',
            sortname: sortnm,
            sortorder: "desc",
            //rownumbers: 99999,
            shrinkToFit: false,
            forceFit: true,
            loadtext: "Loading...",
            hidegrid: false,
            //multiselect: true,
            ondblClickRow: false,
            cellEdit: true,
            loadonce: true,
            sortable: true,
            ignoreCase: true,
            rowNum: 1000000,
            //width: 800,//
            //height: 615,// changd
            cellsubmit: 'clientArray',
            scrollerbar: true,
            viewrecords: true,
            footerrow: footerrow,
            rowattr: function (rd) {
                //return { "class": "column-title" }
                if (rd.STATUS == "I") {
                    return { "class": "CancelClass" };
                }
            },
            beforeRequest: function () {

                responsive_jqgrid($('.jqGrid'));
            },//footer row data 
            loadComplete: function () {

            },
            beforeSelectRow: function (rowid, e) {


                var rowdata = jQuery("#tblOPLISTgrid").jqGrid('getRowData', rowid);
                if (rowdata["Check"] == "Yes") {
                    var cm = jQuery("#tblOPLISTgrid").jqGrid("getGridParam", "colModel");
                    cm[2].editable = true;
                    cm[3].editable = true
                    cm[4].editable = true;
                    cm[5].editable = true;
                    cm[6].editable = true;
                    cm[8].editable = true;
                    cm[9].editable = true;
                    //jQuery("#JQgrid").trigger('reloadGrid');
                }
                else {
                    var cm = jQuery("#tblOPLISTgrid").jqGrid("getGridParam", "colModel");
                    cm[2].editable = false;
                    cm[3].editable = false
                    cm[4].editable = false;
                    cm[5].editable = false;
                    cm[6].editable = false;
                    cm[8].editable = false;
                    cm[9].editable = false;
                }

                return true;
            },

            gridComplete: function () {
                // $("#tblOPLISTgrid").hideCol("Code")

            }
        });
        $("#tblOPLISTgrid").jqGrid('bindKeys');

        jQuery('#tblOPLISTgrid').closest('.ui-jqgrid-view')
       .find(".ui-jqgrid-htable .ui-search-toolbar .ui-th-column")
       .find("input, select")
       .focus(function (e) {
           var $header = $(e.target).closest('.ui-jqgrid-hdiv'),
               $body = $header.siblings('.ui-jqgrid-bdiv');

           setTimeout(function () {

               $body[0].scrollLeft = $header[0].scrollLeft;
           }, 0);
       });

        $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
        $('.ui-jqgrid-sdiv').addClass('AddFooterClass');
        $("#tblOPLISTgrid").jqGrid('filterToolbar', {
            searchOnEnter: false,
            ignoreCase: true,
            searchOperators: false,
            defaultSearch: "cn",
            beforeSearch: function () { searchGDYN = "Y"; }
        });



        var newWidth = $("#secCont").width();
        $("#tblOPLISTgrid").jqGrid("setGridWidth", newWidth - 40, false);
        $("#tblOPLISTgrid").jqGrid("setGridHeight", $("#secCont").height() - 150, true);
        // $("#GVMultiPaymode").jqGrid("setGridWidth", newWidth - 10, false);
    }

    function responsive_jqgrid(jqgrid) {
        jqgrid.find('.ui-jqgrid').addClass('clear-margin span12').css('width', '');
        jqgrid.find('.ui-jqgrid-view').addClass('clear-margin span12').css('width', '');
        jqgrid.find('.ui-jqgrid-view > div').eq(1).addClass('clear-margin span12').css('width', '').css('min-height', '0');
        jqgrid.find('.ui-jqgrid-view > div').eq(2).addClass('clear-margin span12').css('width', '').css('min-height', '0');
        jqgrid.find('.ui-jqgrid-sdiv').addClass('clear-margin span12').css('width', '');
        jqgrid.find('.ui-jqgrid-pager').addClass('clear-margin span12').css('width', '');
    }


    //added 15/7/19
    function FillVaccinationGrid() {
        //var colnames = "";
        //var colmodel = "";
        // var sortnm = ''
        //var footerrow = false;
        //if (str == 1) {
        //colnames = [ 'Code', 'Name', 'Age Group',  'Sequence', 'Status'];
        //colmodel = [


        //{ name: 'CODE', index: 'CODE', width: 50, sortable: true, resizable: false,  hidden: false , editable:false },
        //{ name: 'NAME', index: 'NAME', width: 400, sortable: true, resizable: false, editable: true, },
        //{ name: 'AGEGRPCD', index: 'AGEGRPCD', width: 50, sortable: true, resizable: false, hidden: true },                       
        //{ name: 'SEQ', index: 'SEQ', width: 70, sortable: true, resizable: false, editable: true, },
        //{ name: 'STATUS', index: 'STATUS', width: 60, sortable: true, resizable: false, editable: true, },

        //],



        $("#tblVaccineGrid").jqGrid('GridUnload');
        jQuery("#tblVaccineGrid").jqGrid({
            //colNames:colnames,
            //colModel:colmodel,
            datatype: 'local',
            colModel: [
                         {
                             label: 'Code', name: 'CODE', index: 'CODE', width: 70, editable: false, sortable: false
                         },
                         {
                             label: 'Vaccine ', name: 'NAME', index: 'NAME', width: 430, editable: true, sortable: false,
                             editoptions: {
                                 maxlength: 150,  //added by 10/12/2019 10:14
                                 dataEvents: [
                                 {
                                     type: 'keyup',
                                     fn: function (e) {
                                         var rowid = (e.target).closest('tr.jqgrow').id;
                                         if (e.target.value == "" && e.keyCode == 13) {

                                         }
                                         else if (e.target.value == "" && e.keyCode != 13) {
                                             var rowObject = {};
                                             //rowObject.CODE = "";
                                             rowObject.NAME = "";
                                             //rowObject.STATUS = "";
                                             //rowObject.AGEGRPCD = ""                                                  
                                             $('#tblVaccineGrid').jqGrid('setRowData', rowid, rowObject);
                                             // $("#tblVaccineGrid").resetSelection();
                                         }
                                         else {
                                             //last Four character not containing charater
                                             var rowObject = $('#tblVaccineGrid').jqGrid('getRowData', rowid);
                                             if (rowObject.CODE == 0) {

                                                 //var max = rowid;
                                                 //var ageGrpcode = $('#txtAgeGrpCode').val().trim().substr($('#txtAgeGrpCode').val().trim().length - 2, 2);
                                                 //var maxNumber = Number(max.toString().replace(Number(ageGrpcode).toString(), ''));
                                                 //var TestCodeDes = $('#txtAgeGrpName').val().trim().substr(0, 2).toUpperCase();

                                                 //$('#tblVaccineGrid').jqGrid('setCell', rowid, 'CODE', TestCodeDes.concat(ageGrpcode.concat(maxNumber)));
                                                 globalVcnCdCnt = Number(globalVcnCdCnt) + 1;
                                                 var vaccinecode = "00" + globalVcnCdCnt;
                                                 if (vaccinecode.length == 4) {
                                                     vaccinecode = vaccinecode.substr(1);
                                                 }
                                                 else if (vaccinecode.length == 5) {
                                                     vaccinecode = vaccinecode.substr(2);
                                                 }
                                                 $('#tblVaccineGrid').jqGrid('setCell', rowid, 'CODE', vaccinecode);

                                                 $('#tblVaccineGrid').jqGrid('setCell', rowid, 'STATUS', 'A');
                                                 var grpCode = $("#txtAgeGrpCode").val();
                                                 $('#tblVaccineGrid').jqGrid('setCell', rowid, 'AGEGRPCD', grpCode);

                                             }

                                         }
                                     }
                                 }
                                 ]
                             }
                         },
                         //{
                         //    label: 'SEQ', name: 'SEQ', index: 'SEQ', width: 70, editable: false, sortable: false
                         //},
                         {
                             label: 'STATUS', name: 'STATUS', index: 'STATUS', width: 80, editable: true, sortable: false,
                             edittype: 'select', formatter: 'select', editrules: { required: true },
                             editoptions: { value: "A:Active;I:Inactive", style: " width: 148px; height: 22px; " }

                         },
                         {
                             label: 'AGEGRPCD', name: 'AGEGRPCD', index: 'AGEGRPCD', width: 55, hidden: true, sortable: false
                         },
            ],
            autoencode: false,
            rownumbers: true,
            shrinkToFit: false,
            rowNum: 1000000,
            cellEdit: true,
            cellsubmit: 'clientArray',
            loadtext: "Loading...",

            loadonce: true,
            sortable: true,
            ignoreCase: true,
            width: 640,
            height: 300,
            scrollerbar: true,
            viewrecords: true,
            rowattr: function (rd) {
                //return { "class": "column-title" }
            },
            //beforeRequest: function () {

            //    responsive_jqgrid($('.jqGrid'));
            //},//footer row data 
            onSelectRow: function (rowid, rowData, rowelem) {
                jQuery("#tblVaccineGrid").jqGrid('saveRow', lastSel); jQuery("#tblVaccineGrid").jqGrid('editRow', rowid, { keys: true });
            },

            afterEditCell: function (id, name, val, iRow, iCol) {

                $("#" + iRow + "_" + name).bind('blur', function (e) {
                    $('#tblVaccineGrid').saveCell(iRow, iCol);
                    $("#tblVaccineGrid").resetSelection();
                    jQuery("#tblVaccineGrid").jqGrid('sortableRows', {
                        items: '.jqgrow'
                    });
                });
                jQuery("#tblVaccineGrid").jqGrid('sortableRows', {
                    items: '.gridcell:not(.edit-cell)'
                });
            },
            afterSaveCell: function (rowid, name, val, iRow, iCol) {
                jQuery("#tblVaccineGrid").jqGrid('sortableRows', {
                    items: '.jqgrow'
                });
            },
            loadComplete: function () {

                //$("#tblVaccinegrid").jqGrid("setGridHeight", $("#divForSettngs").height() - 200, true);

                ////$(window).on("resize", function () {
                //var $grid = $("#tblVaccinegrid"),
                //    newWidth = $grid.closest(".ui-jqgrid").parent().width();
                //$grid.jqGrid("setGridWidth", newWidth, true);
                //HoldOn.close();
                ////});
            },


        });
        // $("#tblVaccineGrid").jqGrid('bindKeys');

        // jQuery('#tblVaccineGrid').closest('.ui-jqgrid-view')
        //.find(".ui-jqgrid-htable .ui-search-toolbar .ui-th-column")
        //.find("input, select")
        //.focus(function (e) {
        //    var $header = $(e.target).closest('.ui-jqgrid-hdiv'),
        //        $body = $header.siblings('.ui-jqgrid-bdiv');

        //    setTimeout(function () {

        //        $body[0].scrollLeft = $header[0].scrollLeft;
        //    }, 0);
        //});

        // $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
        // $('.ui-jqgrid-sdiv').addClass('AddFooterClass');
        // $("#tblVaccineGrid").jqGrid('filterToolbar', {
        //     searchOnEnter: false,
        //     ignoreCase: true,
        //     searchOperators: false,
        //     defaultSearch: "cn",
        //     beforeSearch: function () { searchGDYN = "Y"; }
        // });
    }

    function GetAgeLst() {
        HoldOn.open();
        $.ajax({
            type: "post",
            url: "../Clinicalnotes/GetAgeGroupLst",
            data: {},
            async: false,
            datatype: "json",
            success: function (result) {

                if (result != "") {
                    var res = result;

                    $('#tblAgeGrpGrid').jqGrid('setGridParam', {
                        data: res
                    }).trigger("reloadGrid");
                    HoldOn.close();
                }

            }, complete: function () { HoldOn.close(); },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                HoldOn.close();
            }
        });
    }

    function BindAgeGroupGrid() {
        getColumnIndexByName = function (grid, columnName) {
            var cm = $("#tblAgeGrpGrid").jqGrid('getGridParam', 'colModel'), i, l = cm.length;
            for (i = 0; i < l; i++) {
                if (cm[i].name === columnName) {
                    return i; // return the index
                }
            }
            return -1;
        }

        var colnames = "";
        var colmodel = "";
        var sortnm = ''
        var footerrow = false;
        //if (str == 1) {
        colnames = ['Act', 'Code', 'seq', 'Age Group', 'From Age', 'To Age', 'Remark', 'Status', 'Created By'];
        colmodel = [

                //{
                //    name: "Check", index: 'Check', width: 70, align: "center",
                //    formatter: "checkbox", formatoptions: { disabled: false },
                //    edittype: "checkbox", editoptions: { value: "Yes:No", defaultValue: "Yes" },
                //    stype: "select", searchoptions: {
                //        sopt: ["eq", "ne"],
                //        value: ":Any;true:Yes;false:No"
                //    }
                //},
                { name: 'act', index: 'act', width: 65, sortable: false, formatter: "actions", search: false, formatoptions: { editbutton: false, delbutton: false }, align: "center" },//delbutton: false,
                { name: 'CODE', index: 'CODE', width: 50, sortable: true, resizable: false, sorttype: 'number', hidden: false },
                { name: 'SEQ', index: 'SEQ', width: 50, sortable: true, resizable: false },
                { name: 'AGEGRP', index: 'AGEGRP', width: 150, sortable: true, resizable: false },
                { name: 'FRMAGE', index: 'FRMAGE', width: 100, sortable: true, resizable: false },
                { name: 'TOAGE', index: 'TOAGE', width: 100, sortable: true, resizable: false },
                { name: 'REMARK', index: 'REMARK', width: 160, sortable: true, resizable: false },
                {
                    name: 'STATUS', index: 'STATUS', width: 90, align: "left",
                    edittype: 'select', formatter: 'select', editrules: { required: true },
                    editoptions: { value: "A:Active;I:Inactive", style: " width: 148px; height: 22px; " }, searchoptions: { sopt: ["eq", "ne"], value: ":All;A:Active;I:Inactive" }
                },
                { name: 'CREATEDBY', index: 'CREATEDBY', width: 100, sortable: true, resizable: false },

        ],



        $("#tblAgeGrpGrid").jqGrid('GridUnload');
        jQuery("#tblAgeGrpGrid").jqGrid({
            colNames: colnames,
            colModel: colmodel,
            //data: res,
            datatype: 'local',
            //sortname: sortnm,
            sortorder: "desc",
            //rownumbers: 99999,
            shrinkToFit: false,
            forceFit: true,
            loadtext: "Loading...",
            hidegrid: false,
            ondblClickRow: true,
            cellEdit: false,
            loadonce: true,
            sortable: true,
            ignoreCase: true,
            rowNum: 1000000,

            height: 450,// 
            cellsubmit: 'clientArray',
            scrollerbar: true,
            viewrecords: true,
            footerrow: footerrow,
            rowattr: function (rd) {
                //return { "class": "column-title" }
                if (rd.STATUS == "I") {
                    return { "class": "CancelClass" };
                }
            },
            beforeRequest: function () {

                responsive_jqgrid($('.jqGrid'));
            },//footer row data 
            loadComplete: function () {

                var $grid = $("#tblAgeGrpGrid"),
                    newWidth = $grid.closest(".ui-jqgrid").parent().width();
                $grid.jqGrid("setGridWidth", newWidth, true);

                var iCol = getColumnIndexByName($("#tblAgeGrpGrid"), 'act'); var inc = 0;

                $("#tblAgeGrpGrid").find(">tbody>tr.jqgrow>td:nth-child(" + (iCol + 1) + ")")
                     .each(function () {
                         //if (editYN == "Y") {
                         $("<div>", {
                             title: "Edit",
                             mouseover: function () { $(this).addClass('ui-state-hover') },
                             mouseout: function () { $(this).removeClass('ui-state-hover') },
                             click: function (e) {
                                 //$("a#btnTrandiv").click();
                                 var ageGrpId = $(e.target).closest("tr.jqgrow").attr("id");
                                 var rowdata = jQuery("#tblAgeGrpGrid").jqGrid('getRowData', ageGrpId);
                                 SaveOrUpdateAgeGroup((rowdata.CODE));

                                 //var url = 'BindBillChkListData?Act=E&Id=' + $(e.target).closest("tr.jqgrow").attr("id");
                                 //window.location.href = url;
                             }
                         }).css({ "margin-right": "5px", float: "left", cursor: "pointer" })
           .addClass("ui-pg-div ui-pg-div ui-inline-edit")
            .append('<span class="ui-icon ui-icon-pencil"></span>')
           .prependTo($(this));
                         // }
                     });
            },

            gridComplete: function () {


            },

            ondblClickRow: function (rowId) {

                // $.fancybox.showLoading();
                $("a#btnTrandiv").click();
                BindRowData(rowId);

            },
        });
        $("#tblAgeGrpGrid").jqGrid('bindKeys');

        jQuery('#tblAgeGrpGrid').closest('.ui-jqgrid-view')
       .find(".ui-jqgrid-htable .ui-search-toolbar .ui-th-column")
       .find("input, select")
       .focus(function (e) {
           var $header = $(e.target).closest('.ui-jqgrid-hdiv'),
               $body = $header.siblings('.ui-jqgrid-bdiv');

           setTimeout(function () {

               $body[0].scrollLeft = $header[0].scrollLeft;
           }, 0);
       });

        $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
        $('.ui-jqgrid-sdiv').addClass('AddFooterClass');
        $("#tblAgeGrpGrid").jqGrid('filterToolbar', {
            searchOnEnter: false,
            ignoreCase: true,
            searchOperators: false,
            defaultSearch: "cn",
            beforeSearch: function () { searchGDYN = "Y"; }
        });
    }

    function BindRowData(rowId) {

        var rowData = jQuery("#tblAgeGrpGrid").getRowData(rowId); // this show selected  row objecte
        $("#txtAgeGrpCode").val(rowData.CODE);
        $("#txtAgeGrpName").val(rowData.AGEGRP);
        //$('#tblVaccineGrid').jqGrid('clearGridData');
        HoldOn.open();
        $.ajax({
            type: "POST",
            url: "GetVaccinationLst",
            data: { AgeGrpCode: rowData.CODE },
            async: false,
            success: function (result) {

                if (result[0] != null) {


                    var res = result[0];

                    $('#tblVaccineGrid').jqGrid('setGridParam', {
                        data: res
                    }).trigger("reloadGrid");
                    HoldOn.close();
                }
                if (result[1] != null) {
                    globalVcnCdCnt = Number(result[1]);
                    HoldOn.close();
                }


            },
            onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                $.messager.alert("Error Information", textStatus);
                HoldOn.close();
            }

        });

    }

    function SaveVaccines() {
        var NameCheckArray = [];
        $('#tblVaccineGrid').jqGrid("editCell", 0, 0, false);
        var vaccineData = $("#tblVaccineGrid").jqGrid('getRowData');
        exampleArray = $.grep(vaccineData, function (dt) {
            return (dt.CODE != "");
        });
        NameCheckArray = $.grep(vaccineData, function (dt) {
            return (dt.CODE != "" && dt.NAME == "");
        });

        if (exampleArray.length == 0) {
            $.alert("Please Enter Atleast One vaccine.", "Information");

            return false;
        }

        if (NameCheckArray.length > 0) {
            $.alert("Please Enter Vaccine Name For Selected.", "Information");

            return false;
        }

        else {
            HoldOn.open();
            var ageGrpCode = $("#txtAgeGrpCode").val();
            var xmlString = JSON.stringify(exampleArray);
            var datatosend = {
                ageGrpCode: $('#txtAgeGrpCode').val(),
                xmlString: JSON.stringify(exampleArray),
            }
            $.ajax({
                url: '../Clinicalnotes/SaveVaccines',
                type: "POST",
                dataType: "json",
                data: datatosend,
                success: function (response) {
                    if (response.toUpperCase().indexOf("SUCCESSFULL") != -1) {
                        $.alert('Saved Successsfully', "Information");
                        //$.messager.alert("Information", "Saved Successsfully");
                    }
                    HoldOn.close();
                },
                onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error Information", textStatus);
                    HoldOn.close();
                }
            });
        }
    }

    function SaveOrUpdateAgeGroup(ageGrpId) {
        $.confirm({
            autoOpen: false,
            modal: true,
            draggable: false,
            resizable: false,
            boxWidth: '500px',
            useBootstrap: false,
            theme: 'light',
            title: '',
            content: '' +
            '<form action="" class="formName" style="">' +

            '<table id="tblAgeGrpFrm">' +
            '<tr>' +
            '<td colspan="2">' +
            '<label style="width:80px;">Age Group</label><input type="varchar"  id="txtAgeGroup" required  style="width:300px;" maxlength="50"/>' +
            '</td>' +
            '</tr>' +

            '<tr>' +
            '<td>' +
            '<label style="width:80px;">Seq No</label><input type="number" id="txtSeqNo" required style="width:150px;"  maxlength="10"/>' +
            '</td>' +

            '<td>' +
             '<label style="width:63px;margin-left:20px;">Status</label>' +
            '<select style="width:150px;" id="selStatus"><option value="A">Active</option><option value="I">Inactive</option></select>' +
            '</td>' +
           '</tr>' +




            '<tr>' +
            '<td>' +
            '<label style="width:80px;">From Age</label><input  id="txtFrmAge" required style="width:150px;"  maxlength="10"/>' +
            '</td>' +

            '<td>' +
            '<label style="width:63px;margin-left:20px;">To Age</label><input type="varchar"  id="txtToAge" required style="width:150px;"  maxlength="10"/>' +
            '</td>' +
            '</tr>' +

            '<tr>' +
            '<td colspan="2">' +
            '<label>Remark:</label><textarea  class="form-control" id="txtRemark"  maxlength="500"></textarea>' +  //maxlengh added by 10/12/2019 
            '</td>' +
            '</tr>' +

            '</table>' +

            '</form>',
            buttons: {
                formSubmit: {
                    text: 'Save',
                    btnClass: 'btn-blue',
                    btnid: 'save_update',
                    action: function () {
                        var ageGrp = this.$content.find('#txtAgeGroup').val();
                        var frmAge = this.$content.find('#txtFrmAge').val();
                        var toAge = this.$content.find('#txtToAge').val();
                        var remark = this.$content.find('#txtRemark').val();
                        var status = this.$content.find('#selStatus').val();
                        var seqNo = this.$content.find('#txtSeqNo').val();


                        if (ageGrp == "") {
                            $.alert('Please Enter Age Group');
                            return false;
                        }
                        else if (frmAge == "") {
                            $.alert('Please Enter From Age');
                            return false;
                        }
                        else if (toAge == "") {
                            $.alert('Please Enter To Age');
                            return false;
                        }
                        else if (toAge == "") {
                            $.alert('Please Enter Sequence Number');
                            return false;
                        }

                        if (ageGrp != "" && frmAge != "" && toAge != "" && seqNo != "") {
                            // stype = document.getElementById('sel').value;
                            var urls = '../Clinicalnotes/SaveAgeGrouop';
                            var AgeGroupCode = "";
                            if (ageGrpId != undefined) {
                                AgeGroupCode = ageGrpId
                            }
                            var datatosend = {

                                ageGrp: ageGrp,
                                frmAge: frmAge,
                                toAge: toAge,
                                remark: remark,
                                status: status,
                                seq: seqNo,
                                AgeGroupCode: AgeGroupCode
                            }
                            $.ajax({
                                type: "POST",
                                data: datatosend,
                                url: urls,
                                dataType: "json",
                                success: function (result) {
                                    if (result.toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                        if (ageGrpId != undefined)
                                            $.messager.alert("Information", "Age Group updated Successfully");
                                        else
                                            $.messager.alert("Information", "Age Group added Successfully");
                                        GetAgeLst();
                                    }


                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.messager.alert('An error occurred while processing your request.', 'Error Information');
                                }
                            });

                        }
                    }
                },
                close: function () {
                    //close
                    //$('.FoodItems input:checked').focus();
                },

            },
            onContentReady: function () {
                $('input[id="txtFrmAge"]').inputmask('###:##:##');
                $('input[id="txtToAge"]').inputmask('###:##:##');

                if (ageGrpId != undefined) {
                    SetDataForAgeGroup(ageGrpId);
                }
            }
        });
    }
    //-------------------------

    function SetDataForAgeGroup(ageGrpId) {
        HoldOn.open();
        $.ajax({
            type: "post",
            url: "../Clinicalnotes/GetAgeGroupLst",
            data: { ageGrpId: ageGrpId },
            async: false,
            datatype: "json",
            success: function (result) {

                if (result != "") {
                    $("#txtAgeGroup").val(result[0].AGEGRP);
                    $("#txtSeqNo").val(result[0].SEQ);
                    $("#txtFrmAge").val(result[0].FRMAGE);
                    $("#txtToAge").val(result[0].TOAGE);
                    $("#txtRemark").val(result[0].REMARK);
                    $("#selStatus").val(result[0].STATUS);
                    HoldOn.close();
                }

            }, complete: function () { HoldOn.close(); },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                HoldOn.close();
            }
        });
    }
    //Added By Rajan
    function NumberOnly(Event) {
        var value = Event.value;
        Event.value = value.replace(/[^0-9\.]/g, '');
        if ((Event.value.match(/\./g) || []).length > 1) {
            Event.value = Event.value.slice(0, -1);
        }
    }
    function NumberFixed2(Event) {
        Event.value = Number(Event.value) == 0 ? Number(1).toFixed(2) : Number(Event.value).toFixed(2);
    }

    function BindAllergyTypeList(Type) {
        var Res = "";
        if (Type == "Grid") {
            Res = "";
            jQuery.grep(AllergyTypeList, function (e) {
                Res = Res + (Res == "" ? (e.Value + ":" + e.Text) : (";" + e.Value + ":" + e.Text));
            });
        }
        else {
            var Option = "<option value='{OPTVALUE}'>{OPTTEXT}</option>";
            var DefOption = Option.replace("{OPTVALUE}", "").replace("{OPTTEXT}", "--Select--");
            Res = DefOption;
            jQuery.grep(AllergyTypeList, function (e) {
                var RplOption = Option.replace("{OPTVALUE}", e.Value).replace("{OPTTEXT}", e.Text);
                Res = Res + RplOption;
            });
        }
        return Res;
    }
    </script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <!DOCTYPE html>
     <html>
        <head>
            <title></title>
        </head>
        <body>
                <div>
                    <%-- <div id="divForBack" style="background-image: url(../Images/backfornonPage.png);background-repeat: no-repeat; background-repeat: no-repeat;height: 65px;width: 36px;float: left;" onclick="SetpageDirctn()" title ="Go Back To Home.."> </div>
          --%>
                  <div class="select_join" style="float: left;">
                        <select name="txtSelect" id="sel" onchange='GetReportData()' >
		    		     <option id="select" value="S" style="text-align:center" >-- Select --</option>
                         <option id="complaints" value="C" style="text-align:center">Complaints</option>
                         <option id="diagnosis" value="D" style="text-align:center">Diagnosis</option>
                         <option id="patadvice" value="A" style="text-align:center">Patient Advice</option>
                         <option id="medremarks" value="R" style="text-align:center">Medicine Remarks</option>
                         <option id="PersHistMaster" value="H" style="text-align:center">Personal History(Habit)</option>
                            <option id="MedHistMaster" value="M" style="text-align:center">Medical History(Disease)</option>
                         <option id="route" value="T" style="text-align:center">Route</option>
                         <option id="ageGrp" value="G" style="text-align:center">Age Group</option>
                            <option id="Freq" value="F" style="text-align:center">Frequency</option>
                            <option id="Allergy" value="L" style="text-align:center">Allergy</option>
	        			</select>
                     <label id="myAdd" style="background-color: transparent; float: left; margin-top: -20px; margin-left: 190px; border-color: transparent;"
                    title="Add">
                    <img src="../Images/plus.png" style="background-color: white; border-radius: 50%; position: fixed; width: 26px; margin-top: -8px; margin-left: -8px;" />
                </label>
                <%----%>
               
                  </div>
                       <a class="button1 button1-green" id="divForBack"  style="margin-left: 27%;" onclick="SetpageDirctn()">
  <i class="fa fa-arrow-left"></i>
  <strong>Back</strong>
</a> <%--11-12-2019--%>
           

        <button  id="save_btn" class="save_button" type="button" style="float:right;display:none" >Save</button><%-- --%>


              
           

                    </div>

            <div  style="margin-top:25px;position:fixed;">
              <div id="divtblOPLISTgrid">
                    <table id="tblOPLISTgrid">
                    </table>
                </div>
                 <div id="divTblAgeGrpgrid">
                    <table id="tblAgeGrpGrid">
                    </table>
                </div>
                   <label id="vaccinenote" style="color:red;font-size: 12px;display:none">Note:  Double click on record to add vaccine</label> <%--27-11-2019 13:19--%>
               </div>

              <% using (Html.BeginForm(null, null, FormMethod.Post, new { id = "VaccMastTran" }))
       { %>
    <div id="divTran" style="display: none; width: 650px;">
        <a href="#divTran" id="btnTrandiv"></a>
        <fieldset>
            <div class="panel-heading">
                <label id="lblMode">Edit</label>
            </div>

            <div style="padding-top: 2px"  id="divAllControl">
                <div id="divTest">
                    <table>
                        <tr>
                            <td>
                                <label id="lblAgrGrpCode">CODE</label>
                            </td>
                            <td>
                                <input id="txtAgeGrpCode" type="text" class="TextBxFormat" readonly="readonly" />
                            </td>
                            <td>
                                <label id="lblAgeGrpName">Age Group</label>
                            </td>
                            <td>
                                <input id="txtAgeGrpName" class="TextBxFormat" type="text" readonly="readonly" />
                            </td>

                        </tr>
                        <tr>
                        </tr>
                    </table>
                </div>
                <div id="divVaccines" style="margin-top:2px;">
                    <table id="tblVaccineGrid"></table>
                </div>

              
             <%--   <div id="divOkCancel" class="center " style="display: none">
                    <input type="button" id="btnOK" class="Nbutton" value="OK" />
                    <input type="button" id="btnGridClear" class="Nbutton" value="Clear" />
                    <input type="button" id="btnClose" class="Nbutton" value="Close" />
                </div>--%>
             
            </div>   
           
            <input type="button" id="btnSave" class="btn btn-primary" value="Save" style="margin-left: 270px;margin-top: 5px;width:88px;" onclick="SaveVaccines()" />
           
        </fieldset>
    </div>
    <% } %>
            </body>
        </html>

</asp:Content>





