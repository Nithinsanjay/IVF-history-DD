<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.COSTESTIMATIONMDL>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <script src="../Scripts/PatList.js"></script>
     <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
    <script type="text/javascript">
        var QTDAYSVALUE = "";
        var COMPCODE = "";
        var TARIFF = "";
        var SURGERYCD = "";
        var ASSOSURGERYCD = "";
        var GIPSASURGERYCD = "";
        var ActionMode = '<%:ViewBag.RGaction%>';
        var TOTALSUM = 0;
        var DOCTNAME = "";
        var DOCTCODE = "";
        var PATNAME = "";
        var MRNO = "";
        var lastSel = "";
        var surgCd = '<%:Model.STRSURGEDOCTCODE%>'
        var str = new Array();
        var strNew = new Array();
        var selectedRowId;
        function pageLoad() {
            <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
            GRIDESTIMATEDCOMP();
            if (ActionMode != "N") {
                var CTYPE = '<%=Model.STRGETTYPE%>';
                SERVLIST = $.parseJSON('<%:Html.Raw(Samp.Serialize(ViewBag.SERVGETSETDATA))%>');
                COMPLIST = $.parseJSON('<%:Html.Raw(Samp.Serialize(ViewBag.COMPGETSETDATA))%>');
                $('#ESTIMATEDCOMP').jqGrid('setGridParam', { data: COMPLIST }).trigger("reloadGrid");

                for (var i = 0; i < SERVLIST.length; i++) {
                    $('#ESTIMATEDCOMP').setCell(SERVLIST[i].COMPCODE, 'B' + SERVLIST[i].BEDCATGCD, SERVLIST[i].CHARGES);
                    jQuery("#ESTIMATEDCOMP").jqGrid('showCol', ["B" + SERVLIST[i].BEDCATGCD]);
                }
                if (ActionMode == "D" || ActionMode == "C") {

                    $('#TXTSTRREMARKS').prop('readonly', true);
                    $('#TXTSTRPATNAME').prop('readonly', true);
                    $('#BedcatDiv').css('display', 'none');
                    $('#btnEstimate').prop('disabled', true);
                    $('#CMBSTRDOCTCODE').prop('disabled', true);
                }
                else if (ActionMode == "E") {
                }

                if (CTYPE == "G") {
                    $('#RBTNGISPA')[0].checked = true;
                    $('#tdGIPSA').css('display', 'block');
                    $('#divGIPSA').css('display', 'block');
                    $('#divCompany').css('display', 'none');
                }
                else if (CTYPE == "C") {
                    $('#RBTNCASH')[0].checked = true;
                }
                else if (CTYPE == "T") {
                    $('#RBTNPRIVATETPA')[0].checked = true;
                }
                else if (CTYPE == "O") {
                    $('#RBTNCORPORATE')[0].checked = true;
                }
                $('#rbtndiv *').prop('disabled', true);


                calculateAmt();
            }
        }

        $(document).ready(function () {
            SetPatientDtl();
            DOCTNAME = '<%:Session["gDoctName"]%>';
            PATNAME = $.session.get('PatName');
            MRNO = $.session.get('PatMRNO');
            BEDCATGLIST = $.parseJSON('<%:Html.Raw(Samp.Serialize(ViewBag.BEDCATGITEMLIST))%>');
            var leng = BEDCATGLIST.length;
            var btn = "";
            for (var i = 0; i < leng; i++) {
                btn += "<input type='button' id='" + BEDCATGLIST[i].BEDCATGCD + "' class='btn btn-primary form-group' value='" + BEDCATGLIST[i].BEDCATGNM + "' />";
            }
            $("#bedbtn").append(btn);
            $('#CMBSTRCOMPCODE').prop('disabled', true);

            $(':radio[name=CSTESTMN]').on('change', function () {
                $('#dblGIPSASergeryHelp input:checkbox').removeAttr('checked');
                $('#dblSergeryHelp input:checkbox').removeAttr('checked');
                $('#txtSergery').val("");
                $('#TXTSTRGIPSACODE').val("");

                $('#CMBSTRCOMPCODE').select2('val', '');
                if ($('#RBTNGISPA')[0].checked == true) {
                    $('#tdGIPSA').css('display', 'block');
                    $('#divGIPSA').css('display', 'block');
                    $('#divCompany').css('display', 'none');
                }
                else if ($('#RBTNCORPORATE')[0].checked == true || $('#RBTNPRIVATETPA')[0].checked == true) {
                    $('#tdGIPSA').css('display', 'none');
                    $('#divGIPSA').css('display', 'none');
                    $('#divCompany').css('display', 'block');
                    $('#CMBSTRCOMPCODE').prop('disabled', false);
                }
                else {
                    $('#tdGIPSA').css('display', 'none');
                    $('#divGIPSA').css('display', 'none');
                    $('#divCompany').css('display', 'block');
                    $('#CMBSTRCOMPCODE').prop('disabled', true);
                }
                GRIDESTIMATEDCOMP();

            });

            $("#CMBSTRCOMPCODE").select2();

            $("#txtAsoSergery").click(function (e) {
                this.select();
                $("#dblAsoSergeryHelp").show();
                e.stopPropagation();
            });

            $("#dblAsoSergeryHelp").click(function (e) {
                $("#dblAsoSergeryHelp").show();
                e.stopPropagation();
            });

            $('#txtAsoSergery').keyup(function (e) {
                var searchtext = $(this).val();
                var allinput = document.getElementById('AsoSergerydata').getElementsByTagName('label');
                var regX = new RegExp("\\s(" + searchtext + "[^\\s]*)|^(" + searchtext + "[^\\s]*)", "gi");

                for (i = 0; i < allinput.length; i++) {
                    if (allinput[i].textContent.match(regX)) {
                        allinput[i].style.display = 'block';
                    }
                    else {
                        allinput[i].style.display = 'none';
                    }
                }
            });

            $("#txtSergery").click(function (e) {
                this.select();
                $("#dblSergeryHelp").show();
                e.stopPropagation();
            });

            $("#dblSergeryHelp").click(function (e) {
                $("#dblSergeryHelp").show();
                e.stopPropagation();
            });

            $('#txtSergery').keyup(function (e) {
                var searchtext = $(this).val();
                var allinput = document.getElementById('Sergerydata').getElementsByTagName('label');
                var regX = new RegExp("\\s(" + searchtext + "[^\\s]*)|^(" + searchtext + "[^\\s]*)", "gi");
                for (i = 0; i < allinput.length; i++) {
                    if (allinput[i].textContent.match(regX)) {
                        allinput[i].style.display = 'block';
                    }
                    else {
                        allinput[i].style.display = 'none';
                    }
                }
            });

            $("#txtGIPSASergery").click(function (e) {
                this.select();
                $("#dblGIPSASergeryHelp").show();
                e.stopPropagation();
            });

            $("#dblGIPSASergeryHelp").click(function (e) {
                $("#dblGIPSASergeryHelp").show();
                e.stopPropagation();
            });

            $('#txtGIPSASergery').change(function (e) {
                var searchtext = $(this).val();
                var allinput = document.getElementById('GIPSASergerydata').getElementsByTagName('label');
                var regX = new RegExp("\\s(" + searchtext + "[^\\s]*)|^(" + searchtext + "[^\\s]*)", "gi");

                for (i = 0; i < allinput.length; i++) {
                    if (allinput[i].textContent.match(regX)) {
                        allinput[i].style.display = 'block';
                    }
                    else {
                        allinput[i].style.display = 'none';
                    }
                }
            });

            $(document).click(function () {
                $("#dblAsoSergeryHelp").hide();
                $("#dblSergeryHelp").hide();
                $("#dblGIPSASergeryHelp").hide();
                $('#txtGIPSASergery').val("");
            });

            createSearchAssoSurgeryControl('dblAsoSergeryHelp');
            createSearchSergeryControl('dblSergeryHelp');
            createSearchControl('dblGIPSASergeryHelp');

            $(".btn-primary").click(function (e) {
                jQuery("#ESTIMATEDCOMP").jqGrid('saveRow', lastSel);
                if ($(this).hasClass("active")) {
                    $(this).removeClass("active");
                    ID = this.id;
                    jQuery("#ESTIMATEDCOMP").jqGrid('hideCol', ["B" + ID]);
                    remove(strNew, ID);
                }
                else {
                    $(this).addClass("active");
                    ID = this.id;
                    NAME = this.value;
                    str = { BEDCATGCD: ID, BEDCATGNM: NAME };
                    strNew.push(str);
                }
            });

        });

        function filldata(rowdata) {
            $('#TXTSTRPATNAME').attr("readonly", "readonly");
            if (ActionMode == "N") {

                TARIFF = rowdata.TARIFF.substring(rowdata.TARIFF.length - 3, rowdata.TARIFF.length).trim();
                COMPCODE = rowdata.COMPANY.substring(rowdata.COMPANY.length - 10, rowdata.COMPANY.length).trim();

                $('#TXTSTRPATNAME').attr("readonly", "readonly");
                $('#dblGIPSASergeryHelp input:checkbox').removeAttr('checked');
                $('#dblSergeryHelp input:checkbox').removeAttr('checked');
                $('#dblAsoSergeryHelp input:checkbox').removeAttr('checked');
                $('#txtSergery').val("");
                $('#TXTSTRGIPSACODE').val("");
                $('#txtAsoSergery').val("");
                $('#CMBSTRCOMPCODE').select2('val', COMPCODE);
                $('#CMBSTRDOCTCODE').val(doctName);
                $('#cbox')[0].checked = false;
                SelectUnSelectAll();
                GRIDESTIMATEDCOMP();
            }
        }

        function createSearchAssoSurgeryControl(name) {
            $.ajax({
                type: 'post',
                url: '../DoctorDesk/GetAssoSergSearchInfo',
                cache: false,
                dataType: "json",
                async: false,
                success: function (result) {

                    var $newDiv = $('<div>');
                    $newDiv.attr("id", name);
                    $newDiv.attr("name", name);
                    $newDiv.addClass("searchdivclass");
                    $newDiv.css('height', '100px');
                    $newDiv.css('overflow', 'auto');
                    $newDiv.css('display', 'none');
                    $newDiv.css('border-color', '#f47b02;')
                    $newDiv.css(' border-style', 'solid');
                    $newDiv.css('background', 'azure')
                    var $newul = $('<ul>');
                    $newul.attr("id", "AsoSergerydata");
                    $newul.css("list-style-type", "none");
                    $newul.addClass("searchlistclass");
                    var options = "";
                    //Iterated over the IEnumerable list.
                    var i = 0;
                    $.each(result, function (i, item) {
                        var title = item.Text;
                        var idstring = name + "_" + item.Value;
                        //Each option represents a value in dropdown. For each element in the list, option element is created and appended to the stringBuilder object.
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.Value + "'>" + title + "</label><li>";
                    });
                    $newul.append(options);
                    $newDiv.append($newul);
                    $('#' + name).remove();
                    $('#AsoSergerydivMultiSelect').append($newDiv);

                    $("#dblAsoSergeryHelp li input").click(function (e) {
                        //  GRIDESTIMATEDCOMP();
                        if (e.currentTarget.checked === true) {
                            // if (gblRemoveval == "") {
                            if (PATNAME == "") {
                                $.messager.alert("Information", "Please select patient.");
                                e.preventDefault();
                                return false;
                            }
                            var ASSOSURGCODE = e.currentTarget.value;
                            var ASSOSURGNAME = e.currentTarget.parentElement.textContent;
                            var space = "                                                                                         ";
                            $('#txtAsoSergery').val(ASSOSURGNAME + space + ASSOSURGCODE);
                            $('#dblAsoSergeryHelp input:checkbox').removeAttr('checked');
                            e.currentTarget.checked = true;

                        }
                        else {
                            var strser = e.currentTarget.value;
                            $('#txtAsoSergery').val("");

                        }

                        $("#dblAsoSergeryHelp").show();
                        e.stopPropagation();
                    });


                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error Information", textStatus);
                }
            });
        }

        function createSearchSergeryControl(name) {
            $.ajax({
                type: 'post',
                //data: datatosend, // $("#OpBill").serialize(),
                url: '../DoctorDesk/GetSergerySearchInfo',
                cache: false,
                //contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (result) {

                    var $newDiv = $('<div>');
                    $newDiv.attr("id", name);
                    $newDiv.attr("name", name);
                    $newDiv.addClass("searchdivclass");
                    //$newDiv.css('width', '275px');
                    $newDiv.css('height', '100px');
                    $newDiv.css('overflow', 'auto');
                    $newDiv.css('display', 'none');
                    $newDiv.css('border-color', '#f47b02;')
                    $newDiv.css(' border-style', 'solid');
                    $newDiv.css('background', 'azure')
                    var $newul = $('<ul>');
                    $newul.attr("id", "Sergerydata");
                    $newul.css("list-style-type", "none");
                    $newul.addClass("searchlistclass");
                    var options = "";
                    //Iterated over the IEnumerable list.
                    var i = 0;
                    $.each(result, function (i, item) {
                        var title = item.Text;
                        var idstring = name + "_" + item.Value;
                        //Each option represents a value in dropdown. For each element in the list, option element is created and appended to the stringBuilder object.
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.Value + "'>" + title + "</label><li>";
                    });
                    $newul.append(options);
                    $newDiv.append($newul);
                    $('#' + name).remove();
                    $('#SergerydivMultiSelect').append($newDiv);

                    $("#dblSergeryHelp li input").click(function (e) {
                        //GRIDESTIMATEDCOMP();
                        $("#txtAsoSergery").val("");
                        if (e.currentTarget.checked === true) {
                            // if (gblRemoveval == "") {
                            if (PATNAME == "") {
                                $.messager.alert("Information", "Please select patient.");
                                e.preventDefault();
                                return false;
                            }
                            var SURGCODE = e.currentTarget.value;
                            var SURGNAME = e.currentTarget.parentElement.textContent;
                            GETSERVICEDATA(SURGCODE, "SURGERY");
                            var space = "                                                                                         ";
                            $('#txtSergery').val(SURGNAME + space + SURGCODE);
                            $('#dblSergeryHelp input:checkbox').removeAttr('checked');
                            e.currentTarget.checked = true;
                            for (var k = 0; k < strNew.length; k++) {
                                jQuery("#ESTIMATEDCOMP").jqGrid('hideCol', ["B" + strNew[k].BEDCATGCD]);
                            }

                        }
                        else {
                            var strser = e.currentTarget.value;
                            $('#txtSergery').val("");
                        }

                        $("#dblSergeryHelp").show();
                        e.stopPropagation();
                    });

                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error Information", textStatus);
                }
            });
        }

        function createSearchControl(name) {
            $.ajax({
                type: 'post',
                //  data: datatosend, // $("#OpBill").serialize(),
                url: '../DoctorDesk/GetGIPSASergerySearchInfo',
                cache: false,
                //   contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (result) {

                    var $newDiv = $('<div>');
                    $newDiv.attr("id", name);
                    $newDiv.attr("name", name);
                    $newDiv.addClass("searchdivclass");
                    $newDiv.css('width', '200px');
                    $newDiv.css('height', '100px');
                    $newDiv.css('overflow', 'auto');
                    $newDiv.css('display', 'none');
                    $newDiv.css('border-color', '#f47b02;')
                    $newDiv.css(' border-style', 'solid');
                    $newDiv.css('background', 'azure')
                    var $newul = $('<ul>');
                    $newul.attr("id", "GIPSASergerydata");
                    $newul.addClass("searchlistclass");
                    var options = "";
                    //Iterated over the IEnumerable list.
                    var i = 0;
                    $.each(result, function (i, item) {
                        var title = item.Text;
                        var idstring = name + "_" + item.Value;
                        //Each option represents a value in dropdown. For each element in the list, option element is created and appended to the stringBuilder object.
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.Value + "'>" + title + "</label><li>";
                    });
                    $newul.append(options);
                    $newDiv.append($newul);
                    $('#' + name).remove();
                    $('#GIPSASergerydivMultiSelect').append($newDiv);

                    $("#dblGIPSASergeryHelp li input").click(function (e) {
                        // GRIDESTIMATEDCOMP();
                        if (e.currentTarget.checked === true) {
                            // if (gblRemoveval == "") {
                            if (PATNAME === "") {
                                $.messager.alert("Information", "Please select patient.");
                                e.preventDefault();
                                return false;
                            }

                            var GIPSASURGCODE = e.currentTarget.value;
                            var GIPSASURGNAME = e.currentTarget.parentElement.textContent;
                            GETSERVICEDATA(GIPSASURGCODE, "GIPSA");
                            var space = "                                                                                         ";
                            $('#TXTSTRGIPSACODE').val(GIPSASURGNAME + space + GIPSASURGCODE);
                            $('#dblGIPSASergeryHelp input:checkbox').removeAttr('checked');
                            e.currentTarget.checked = true;

                        }
                        else {
                            var strser = e.currentTarget.value;
                            $('#TXTSTRGIPSACODE').val("");
                        }

                        $("#dblGIPSASergeryHelp").show();
                        e.stopPropagation();
                    });

                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error Information", textStatus);
                }
            });
        }

        function GETSERVICEDATA(SERVICECODE, FROMSEARCH) {
            // ajaxindicatorstart("Processing..")
            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/GETSERVICEDATA?SERVCODE=' + SERVICECODE + '&&FROMSEARCH=' + FROMSEARCH,
                async: false,
                dataType: 'json',
                success: function (response) {
                    SETSERVICES(response, FROMSEARCH);
                    // ajaxindicatorstop();
                },
                onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error Information", 'An error occurred while processing your request.');
                    // ajaxindicatorstop();
                }
            })
        }

        function SETSERVICES(response, FROMSEARCH) {
            var space = "                                                                                         ";

            if (FROMSEARCH == "GIPSA") {

                $('#ESTIMATEDCOMP').jqGrid('setGridParam', { data: response[1] }).trigger("reloadGrid");


                $('#txtSergery').val(response[3] + space + response[2]);
                $('#dblSergeryHelp input:checkbox').removeAttr('checked');
                $('#dblSergeryHelp_' + response[2]).attr('checked', true);
                if (response[6] != "") {
                    var ASOSURGNM = $('#dblAsoSergeryHelp_' + response[6])[0].title;
                    $('#txtAsoSergery').val(ASOSURGNM + space + response[6]);
                    $('#dblAsoSergeryHelp input:checkbox').removeAttr('checked');
                    //$('#dblAsoSergeryHelp_' + response[6]).attr('checked', true);
                    $('#dblAsoSergeryHelp_' + response[6])[0].checked = true;
                }
            }
            else {

                $('#ESTIMATEDCOMP').jqGrid('setGridParam', { data: response[1] }).trigger("reloadGrid");

                $('#TXTSTRGIPSACODE').val(response[5] + space + response[4]);
                $('#dblGIPSASergeryHelp input:checkbox').removeAttr('checked');
                $('#dblGIPSASergeryHelp__' + response[4]).attr('checked', true);

                if (response[6] != "") {

                    if (($('#dblAsoSergeryHelp_' + response[6])[0]) != undefined) {
                        ASOSURGNM = $('#dblAsoSergeryHelp_' + response[6])[0].title;
                        $('#txtAsoSergery').val(ASOSURGNM + space + response[6]);
                        $('#dblAsoSergeryHelp input:checkbox').removeAttr('checked');
                        //$('#dblAsoSergeryHelp_' + response[6]).attr('checked', true);
                        $('#dblAsoSergeryHelp_' + response[6])[0].checked = true;
                    }
                }
            }
        }



        function GRIDESTIMATEDCOMP() {
            $("#ESTIMATEDCOMP").jqGrid('GridUnload');

            //var CompltGridData = jQuery("#BEDCATGLIST").jqGrid('getRowData');
            colnames = ['id', 'COMPONENT', 'QTY/DAYS']
            var colmodel = [
                 { name: 'id', index: 'id', formatter: 'text', hidden: true },
                 { name: 'COMPONENT', index: 'COMPONENT', width: 185, sortable: false, align: "left", formatter: 'text', editable: false, hidden: false, },
                 {
                     name: 'QTYDAYS', index: 'QTYDAYS', width: 65, sortable: false, align: "right", formatter: 'text', editable: true, editoptions: {
                         dataInit: function (e) {
                             if (e.type == 'text') {
                                 $(e).keyup(function () {
                                     QTDAYSVALUE = Number($(this)[0].value);
                                     selectedRowId = $("#ESTIMATEDCOMP").jqGrid('getGridParam', 'selrow'),
                                      GetEstimation();
                                 });
                             }
                             else {
                                 $(e).change(function () {
                                     QTDAYSVALUE = Number($(this)[0].value);
                                     selectedRowId = $("#ESTIMATEDCOMP").jqGrid('getGridParam', 'selrow'),
                                     GetEstimation();
                                 });
                             }
                         }
                     },

                 }];
            var leng = BEDCATGLIST.length;
            for (var i = 0; i < leng; i++) {
                colnames.push(BEDCATGLIST[i].BEDCATGNM);
                var ResColNm = 'B' + BEDCATGLIST[i].BEDCATGCD;
                var responColNM = { name: ResColNm, index: ResColNm, width: 102, editable: false, sortable: false, align: "right", hidden: true, classes: 'not-editable-cell', formatter: 'number' }
                colmodel.push(responColNM);
            }
            jQuery("#ESTIMATEDCOMP").jqGrid({
                colNames: colnames,
                colModel: colmodel,
                shrinkToFit: false,
                mtype: 'GET',
                //viewrecords: true,
                //forceFit: true,
                //hidegrid: false,
                datatype: 'local',
                //loadtext: "Loading...",
                cellEdit: true,
                //sortable: true,
                cellsubmit: 'clientArray',
                loadonce: true,
                height: 230,
                width: 761,//843,
                footerrow: true,
                loadComplete: function () {
                    TOTALSUM = 0;
                },
                onCellSelect: function (id, val, name, col) {
                    var cm = jQuery("#ESTIMATEDCOMP").jqGrid('getGridParam', 'colModel');
                    if (id == 01 || id == 02) {
                        jQuery("#ESTIMATEDCOMP").jqGrid('saveRow', lastSel);
                        var cm = jQuery("#ESTIMATEDCOMP").jqGrid('getGridParam', 'colModel');
                        cm[2].editable = false;
                    }
                    if (id == 03 || id == 04 || id == 05 || id == 06) {
                        jQuery("#ESTIMATEDCOMP").jqGrid('saveRow', lastSel);
                        var cm = jQuery("#ESTIMATEDCOMP").jqGrid('getGridParam', 'colModel');
                        cm[2].editoptions.value = getAllSelectOptions();
                        cm[2].edittype = 'select';
                        cm[2].formatter = 'select';
                        cm[2].editable = true;
                        //cm[2].editable = false;
                        jQuery("#ESTIMATEDCOMP").jqGrid('editRow', id, true);
                    }

                    else if (id == 07 || id == 08 || id == 09 || id == 10) {
                        jQuery("#ESTIMATEDCOMP").jqGrid('saveRow', lastSel);
                        var cm = jQuery("#ESTIMATEDCOMP").jqGrid('getGridParam', 'colModel');
                        cm[2].formatter = 'text';
                        cm[2].edittype = 'text';
                        cm[2].editable = true;
                        jQuery("#ESTIMATEDCOMP").jqGrid('editRow', id, true);
                    }
                    sessionStorage.setItem("ID", id);
                    lastSel = sessionStorage.getItem("ID");
                }


            }).trigger("reloadGrid");
            $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
            $('.ui-jqgrid-sdiv').addClass('AddFooterClass');
            //jQuery("#ESTIMATEDCOMP").jqGrid('setColProp', 'COMPONENT', { frozen: true });
            //jQuery("#ESTIMATEDCOMP").jqGrid('setColProp', 'QTYDAYS', { frozen: true });
            jQuery("#ESTIMATEDCOMP").jqGrid('setFrozenColumns');
        }

        function calculateAmt() {
            var $grid = $('#ESTIMATEDCOMP');
            $grid.jqGrid('footerData', 'set', { COMPONENT: "Totals:" });

            //var CompltGridData = jQuery("#BEDCATGLIST").jqGrid('getRowData');
            //var SELGRIDDATA = $.grep(CompltGridData, function (e) { return e.CHECK == "True" });
            var SELGRIDDATA = $.grep(jQuery("#ESTIMATEDCOMP").jqGrid('getGridParam', 'colModel'), function (e) { return e.hidden == false });
            TOTALSUM = 0
            if (SELGRIDDATA.length > 0) {
                for (var m = 2; m < SELGRIDDATA.length; m++) {

                    var totAMOUNT = $grid.jqGrid('getCol', SELGRIDDATA[m].name, false, 'sum');
                    TOTALSUM = TOTALSUM + totAMOUNT;
                    var ColNm = SELGRIDDATA[m].name;
                    var obj = '[{"' + ColNm + '": "' + Number(totAMOUNT).toFixed(2) + '"}]';
                    var colFoot = JSON.parse(obj);
                    $('#ESTIMATEDCOMP').jqGrid('footerData', 'set', colFoot[0]);
                }
            }
        }

        function GetEstimation() {
            if (MRNO != "" || PATNO != "") {
                if (checkrequirefield()) {
                    if (strNew.length > 0 && strNew.length < 6) {
                        $('#TXTSTRBEDLIST').val(JSON.stringify(strNew));

                        for (var k = 0; k < strNew.length; k++) {
                            jQuery("#ESTIMATEDCOMP").jqGrid('showCol', ["B" + strNew[k].BEDCATGCD]);
                        }

                    }
                    else {
                        if (strNew.length == 0) {
                            $.messager.alert("Information", "Please Select Atleast one BedCategory");
                        }
                        else if (strNew.length > 5)
                            $.messager.alert("Information", "Please Select Maximum 5 BedCategories");
                        return;
                        //$('#TXTSTRBEDLIST').val(JSON.stringify(CompltGridData))
                    }



                    var FORMDATA = $("#FRMCOSTESTIMATION").serializeArray();
                    var SELECTCOMP = $('#CMBSTRCOMPCODE').val();
                    var urls = "";
                    urls = '../DoctorDesk/GETCOSTESTIMATION?TARIFF= ' + TARIFF + '&&COMPCODE=' + SELECTCOMP;

                    $.ajax({
                        type: "POST",
                        url: urls,
                        async: false,
                        dataType: "json",
                        data: FORMDATA,
                        success: function (response) {
                            DisplayUpdateData(response);
                            //ajaxindicatorstop();
                        }, onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                            $.messager.alert("Error Information", 'An error occurred while processing your request.');
                            $('td[aria-describedby=Consultingdoct_RD]').html('<span class="ui-icon ui-icon-cancel">Remove</span>');
                            // ajaxindicatorstop();
                        }
                    });
                }
            }
            else {
                $.messager.alert("Information", "please Select Patient Or Enter Patient Name.")
            }
        }

        function DisplayUpdateData(response) {

            if (response[0] == "SUCCESS") {
                var ICUDATA = $.grep(response[1], function (e) { return e.ICUYN == 'Y' });
                var VisitIcuSetvalue = 0;
                var BedIcuSetvalue = 0;


                var ProcCode = $('#txtSergery').val().substr($('#txtSergery').val().length - 12, 12).trim()
                var AssoProcCode = $('#txtAsoSergery').val().substr($('#txtAsoSergery').val().length - 12, 12).trim()

                if (strNew.length > 0) {
                    for (var m = 0; m < strNew.length; m++) {

                        var Servdata = $.grep(response[2], function (e) { return e.BEDCATGCD == strNew[m].BEDCATGCD && e.SERVCODE == ProcCode });
                        if (Servdata.length > 0) {
                            $('#ESTIMATEDCOMP').setCell('01', 'B' + strNew[m].BEDCATGCD, Number(Servdata[0].SERVCOST).toFixed(2));
                        }
                        else {
                            $('#ESTIMATEDCOMP').setCell('01', 'B' + strNew[m].BEDCATGCD, "0.00");
                        }


                        var AssoServdata = $.grep(response[2], function (e) { return e.BEDCATGCD == strNew[m].BEDCATGCD && e.SERVCODE == AssoProcCode });
                        if (AssoServdata.length > 0) {
                            $('#ESTIMATEDCOMP').setCell('02', 'B' + strNew[m].BEDCATGCD, Number(AssoServdata[0].SERVCOST).toFixed(2));
                        }
                        else {
                            $('#ESTIMATEDCOMP').setCell('02', 'B' + strNew[m].BEDCATGCD, "0.00");
                        }

                        var BEDCATDATA = $.grep(response[1], function (e) { return e.BEDCATGCD == strNew[m].BEDCATGCD });

                        if (BEDCATDATA.length > 0) {
                            if (QTDAYSVALUE != "") {
                                var charges = 0;
                                if (selectedRowId == '03') {
                                    charges = QTDAYSVALUE * Number(BEDCATDATA[0].BEDCHRG);
                                }
                                if (selectedRowId == '04') {
                                    charges = QTDAYSVALUE * Number(ICUDATA[0].BEDCHRG);
                                }
                                if (selectedRowId == '05') {
                                    charges = QTDAYSVALUE * Number(BEDCATDATA[0].VISITCHRG);
                                }
                                if (selectedRowId == '06') {
                                    charges = QTDAYSVALUE * Number(ICUDATA[0].VISITCHRG);
                                }
                                if (selectedRowId == '07') {
                                    charges = QTDAYSVALUE + (QTDAYSVALUE * Number(BEDCATDATA[0].INVESTICHARGE)) / 100;
                                }
                                if (selectedRowId == '09') {
                                    charges = QTDAYSVALUE + (QTDAYSVALUE * Number(BEDCATDATA[0].BLDBNKCHARGE)) / 100;
                                }
                                if (selectedRowId == '08') {
                                    charges = QTDAYSVALUE;
                                }
                                if (selectedRowId == '10') {
                                    charges = QTDAYSVALUE;
                                }
                                $('#ESTIMATEDCOMP').setCell(selectedRowId, 'B' + strNew[m].BEDCATGCD, charges.toFixed(2));
                            }
                            else {
                                var Bedcellval = Number(jQuery("#ESTIMATEDCOMP").jqGrid('getCell', '03', 'QTYDAYS'));
                                var BedSetvalue = Bedcellval * Number(BEDCATDATA[0].BEDCHRG);
                                $('#ESTIMATEDCOMP').setCell('03', 'B' + strNew[m].BEDCATGCD, BedSetvalue.toFixed(2));


                                var Visitcellval = Number(jQuery("#ESTIMATEDCOMP").jqGrid('getCell', '05', 'QTYDAYS'));
                                var VisitSetvalue = Visitcellval * Number(BEDCATDATA[0].VISITCHRG);
                                $('#ESTIMATEDCOMP').setCell('05', 'B' + strNew[m].BEDCATGCD, VisitSetvalue.toFixed(2));

                                var Investicellval = Number(jQuery("#ESTIMATEDCOMP").jqGrid('getCell', '07', 'QTYDAYS'));
                                var InvestiSetvalue = Investicellval + (Investicellval * Number(BEDCATDATA[0].INVESTICHARGE)) / 100;
                                $('#ESTIMATEDCOMP').setCell('07', 'B' + strNew[m].BEDCATGCD, InvestiSetvalue.toFixed(2));

                                var BBcellval = Number(jQuery("#ESTIMATEDCOMP").jqGrid('getCell', '09', 'QTYDAYS'));
                                var BBSetvalue = BBcellval + (BBcellval * Number(BEDCATDATA[0].BLDBNKCHARGE)) / 100;
                                $('#ESTIMATEDCOMP').setCell('09', 'B' + strNew[m].BEDCATGCD, BBSetvalue.toFixed(2));

                                var Medcellval = Number(jQuery("#ESTIMATEDCOMP").jqGrid('getCell', '08', 'QTYDAYS'));
                                $('#ESTIMATEDCOMP').setCell('08', 'B' + strNew[m].BEDCATGCD, Medcellval.toFixed(2));

                                var Othercellval = Number(jQuery("#ESTIMATEDCOMP").jqGrid('getCell', '10', 'QTYDAYS'));
                                $('#ESTIMATEDCOMP').setCell('10', 'B' + strNew[m].BEDCATGCD, Othercellval.toFixed(2));

                                if (ICUDATA.length > 0) {
                                    // var VisitIcucellval = QTDAYSVALUE;
                                    var VisitIcucellval = Number(jQuery("#ESTIMATEDCOMP").jqGrid('getCell', '06', 'QTYDAYS'));
                                    VisitIcuSetvalue = VisitIcucellval * Number(ICUDATA[0].VISITCHRG);

                                    var BedIcucellval = Number(jQuery("#ESTIMATEDCOMP").jqGrid('getCell', '04', 'QTYDAYS'));
                                    BedIcuSetvalue = BedIcucellval * Number(ICUDATA[0].BEDCHRG);

                                    // ICU RATES
                                    $('#ESTIMATEDCOMP').setCell('04', 'B' + strNew[m].BEDCATGCD, BedIcuSetvalue.toFixed(2));
                                    $('#ESTIMATEDCOMP').setCell('06', 'B' + strNew[m].BEDCATGCD, VisitIcuSetvalue.toFixed(2));
                                }

                            }
                        }
                        else {

                            $('#ESTIMATEDCOMP').setCell('03', 'B' + strNew[m].BEDCATGCD, "0.00");
                            $('#ESTIMATEDCOMP').setCell('05', 'B' + strNew[m].BEDCATGCD, "0.00");
                            $('#ESTIMATEDCOMP').setCell('07', 'B' + strNew[m].BEDCATGCD, "0.00");
                            $('#ESTIMATEDCOMP').setCell('09', 'B' + strNew[m].BEDCATGCD, "0.00");
                        }

                    }
                    calculateAmt();
                }
                QTDAYSVALUE = "";
            }

        }

        function checkrequirefield() {

            var i = 0;
            if (checkText('txtSergery')) {

                i = 1;
                $('#txtSergery').focus();
            }


            if ($('#RBTNPRIVATETPA')[0].checked == true || $('#RBTNCORPORATE')[0].checked == true) {
                if (checkText('CMBSTRCOMPCODE')) {
                    $('#s2id_CMBSTRCOMPCODE a').css("border-color", "red");
                    i = 1;
                    $('#CMBSTRCOMPCODE').focus();
                }
                else {
                    $('#s2id_CMBSTRCOMPCODE a').css("border-color", "");
                }
            }

            if ($('#RBTNGISPA')[0].checked == true) {
                if (checkText('TXTSTRGIPSACODE')) {
                    i = 1;
                    //$('#TXTSTRGIPSACODE').focus();
                }
            }

            if (i == 1) {

                return false;
            }
            else {

                return true;
            }
        }

        function checkText(obj) {
            if (document.getElementById(obj).value == null || ("" + document.getElementById(obj).value).trim() == "") {
                $('#' + obj).css("border-color", "red");
                return true;

            }
            else {
                $('#' + obj).css("border-color", "");
            }
        }

        function SaveEstimation() {
            jQuery("#ESTIMATEDCOMP").jqGrid('saveRow', lastSel);
            if (PATNAME != "") {

                $('#btnSave').prop('disabled', true);
                $('#CMBSTRDOCTCODE').prop('disabled', false);
                $('#CMBSTRSURGEDOCTCODE').prop('disabled', false);
                $('#CMBSTRCOMPCODE').prop('disabled', false);

                var GridData = jQuery("#ESTIMATEDCOMP").jqGrid('getRowData');
                if (GridData.length > 0 && TOTALSUM > 0) {
                    // ajaxindicatorstart("Processing...");
                    $('#TXTSTRESTIMATIONLIST').val(JSON.stringify(GridData));
                    $('#TXTSTRBEDCATLIST').val(JSON.stringify(strNew));

                    var CTYPE = "";
                    if ($('#RBTNGISPA')[0].checked == true) {
                        CTYPE = "G";

                    } else if ($('#RBTNPRIVATETPA')[0].checked == true) {
                        CTYPE = "T";
                    }
                    else if ($('#RBTNCORPORATE')[0].checked == true) {
                        CTYPE = "O";
                    }
                    else if ($('#RBTNCASH')[0].checked == true) {
                        CTYPE = "C";
                    }

                    var TRANNO = "";
                    if (ActionMode != "N") {
                        TRANNO = $('#TXTSTRESTIMATIONNO').val();
                    }
                    var FORMDATA = $("#FRMCOSTESTIMATION").serialize();
                    var urls = '../DoctorDesk/SaveCostEstimate?ACTIONMODE=' + ActionMode + '&&TRANNO=' + TRANNO + '&&CTYPE=' + CTYPE + '&&MRNO=' + MRNO + '&&PATNAME=' + PATNAME;
                    $.ajax({
                        type: "POST",
                        url: urls,
                        async: false,
                        dataType: "json",
                        data: FORMDATA,
                        success: function (response) {
                            DisplayUpdateStatus(response);
                            $('#btnSave').prop('disabled', false);
                            // ajaxindicatorstop();
                        }, onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                            $.messager.alert("Error Information", 'An error occurred while processing your request.');
                            $('td[aria-describedby=Consultingdoct_RD]').html('<span class="ui-icon ui-icon-cancel">Remove</span>');
                            $('#btnSave').prop('disabled', false);
                            // ajaxindicatorstop();
                        }
                    });

                }
                else {
                    $.messager.alert("Information", "There is No Estimation Cost.");
                    $('#btnSave').prop('disabled', false);
                }

            }
            else {
                $.messager.alert("Information", "Please Select Patient Or Enter Patient Name.");
                $('#btnSave').prop('disabled', false);
            }

        }

        function DisplayUpdateStatus(jsondate) {
            var conYN = jsondate[0].message.toUpperCase().search("SUCCESSFUL");

            if (conYN != -1) {
                // ajaxindicatorstop();
                $('#TXTSTRESTIMATIONNO').val(jsondate[0].TransactionNo);
                $('#TXTSTRESTIMATIONDATE').val(jsondate[0].TranDate);
                $('#TXTSTRESTIMATIONTIME').val(jsondate[0].TranTime);
                $.messager.alert("Confirmation", jsondate[0].message, "../DoctorDesk/CostEstimation");
                PrintAction();
                clearData();
            }
            else {
                $.messager.alert('Error Information', jsondate[0].message);
                $('#btnSave').prop('disabled', false);
            }

        }

        function PrintAction(ACTION) {
            var_TRANNO = $('#TXTSTRESTIMATIONNO').val();
            var_TRANDATE = $('#TXTSTRESTIMATIONDATE').val();
            var_TRANTIME = $('#TXTSTRESTIMATIONTIME').val();
            var patName = PATNAME;
            var doctnm = DOCTNAME;
            var strSurgon = DOCTNAME;
            var strSurgNm = $('#txtSergery').val();
            var data = JSON.stringify($("#ESTIMATEDCOMP").jqGrid('getGridParam', 'data'));
            var datatosend = { DATA: data, STRPATNM: patName, STRDOCTNAME: doctnm, STRSURGONNM: strSurgon, STRSRGRYNM: strSurgNm, TRANNO: var_TRANNO, TRANDATE: var_TRANDATE, TRANTIME: var_TRANTIME, ACTIONMODE: ActionMode };
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/PrintCostEstmn",
                dataType: "json",
                data: datatosend,
                async: false,
                success: function (response) {
                    var Html = PrintData1(response);

                    PrintListAJAXCommon('<%:Url.Action("PrintPatientReport","DoctorDesk")%>', { strHtml: Html }, "ABDSKFLSDF", "");

                }, onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error Information", textStatus);
                    $('#btnSave').prop('disabled', false);
                }
            });

        }


        function PrintData1(response) {
            return "Setup Pending";
            var data = $("#ESTIMATEDCOMP").jqGrid('getGridParam', 'data');
            var footer = $("#ESTIMATEDCOMP").jqGrid('footerData', 'get');
            var comp = $('.ui-jqgrid-htable thead tr th')[1].innerText;
            var qty = $('.ui-jqgrid-htable thead tr th')[2].innerText;
            var strPrindData = [];
            strPrindData.push("<html><body>");
            strPrindData.push(" <style>.cltable {border-collapse: collapse;} table.cltable td, th {}  </style>"
                );
            var Patcatg = "";
            var doctName = "";
            var assoSurgery = "";
            doctName = DOCTNAME;
            if ($('#txtAsoSergery').val() != "") {
                assoSurgery = "<td style=color:blue;>Asso. Surgery</td><td>:</td><td>" + $('#txtAsoSergery').val().substr(0, $('#txtAsoSergery').val().length - 8).trim() + "</td>"
            }
            var img = "";
            if (response.jsonComplaints[0].HospLogo != "") {
                img = "<img src=data:image/png;base64," + response.jsonComplaints[0].HospLogo + " style='width: 100%;'>"
            }
            strPrindData.push("<div class='top'>" +
               "<table style='width:100%;'><tbody><tr><td style='width: 20%;'><div style='width:100%;'>" + img + "</div></td>" +
"<td style='text-align: center;'><div style='width:100%;'><div><label style='font-weight:bold;font-size:35px;color:blue;'>" + response.jsonComplaints[0].HospName + "</label></div>" +
"<div style='width: 100%;text-align: center;'><label style='font-weight:bold;font-size:23px;color:blue;'>" + response.jsonComplaints[0].HospAdd + "</label></div>" +
"<div><label style='font-weight:bold;font-size:23px;color:blue;'>" + response.jsonComplaints[0].FormName + "</label></div></div></td></tr>" +
"</tbody></table><hr color='black'>" +
"<table style='width:100%;font-family:Times New Roman'>" +  //Heading start( Patient Info)
"<tr>" +
"<td style=color:blue>Name</td>" +
"<td style='width:1%'>:</td>" +
"<td style=font-weight:bold;width:40%>" + PATNAME + "</td>" +
"<td style=color:blue;width=5% >Surgeon</td><td style='width:1%'>:</td>" +
"<td width=35%> Dr. " + DOCTNAME + "</td>" +
"</tr>" +
"<tr>" +
"<td style=color:blue>MR No.</td>" +
"<td style='width:1%'>:</td>" +
"<td style=font-weight:bold;width:40%>" + MRNO + "</td>" +
"<td style=color:blue;>Surgery</td><td>:</td><td>" + $('#txtSergery').val().substr(0, $('#txtSergery').val().length - 8).trim() + "</td>" +
"</tr>" +
"<tr>" +
"<td style=color:blue >Doctor</td><td >:</td><td> Dr. " + DOCTNAME + "</td>" +
assoSurgery +
"</tr></table>")
            strPrindData.push("</div><hr color=black>") //Heading end
            var str = "";
            var head = "";
            var bed = "";
            var name = "";
            var bind = "";
            var bind1 = "";
            var total = "";
            var str1 = new Array();
            var str2 = new Array();
            var strtotal = new Array();
            strPrindData.push("<table cellspacing='5' style='border-collapse: collapse;' ><tr style='border-bottom: 1px solid #949393;'>");

            for (k = 0; k < strNew.length; k++) {
                name = strNew[k].BEDCATGNM;
                bed = "B" + strNew[k].BEDCATGCD;
                bind1 = "<th style='width:102px;text-align: center;border-right:1px solid #949393;'>" + name + " </th>"
                total = "<td style='width:120px; text-align:center;font-weight:bold;border-right:1px solid #949393;'>" + footer[bed] + " </td>"
                str2.push(bind1);
                strtotal.push(total);
            }
            var strHeader = "<th style='width:250;text-align: center;border-right:1px solid #949393;'>COMPONENT</th><th style='width:65;text-align: center;border-right:1px solid #949393;' >QTY/DAYS</th>" + str2
            var strRepComma = strHeader.replace(/,/g, "");
            strPrindData.push(strRepComma);
            strPrindData.push("</tr>");
            for (i = 0; i < data.length; i++) {
                for (j = 0; j < strNew.length; j++) {
                    bed = "B" + strNew[j].BEDCATGCD;
                    bind = "<td style='width:102; text-align:right;border-right: 1px solid #949393;padding:10px;'>" + data[i][bed] + " </td>"
                    str1.push(bind);
                }

                str = "<tr> <td style='width:250;border-right:1px solid #949393;padding:10px;'>" + data[i].COMPONENT + " </td><td style='width:65; text-align:right;border-right:1px solid #949393;padding:10px;'>" + data[i].QTYDAYS + "</td>" + str1 + "</tr>"
                //strPrindData.push("<div> <table> " + str + "</table> </div>")
                var strRepComma1 = str.replace(/,/g, "");
                strPrindData.push(strRepComma1);
                str1 = [];
                str2 = [];
            }
            strPrindData.push("</table><hr color=black>");
            var sum = "<table style='border-collapse: collapse;padding:10px;'><tr> <td style='width:268;font-weight:bold;border-right:1px solid #949393;'>Total </td> <td style='width:83px; text-align:right;border-right:1px solid #949393;'></td>" + strtotal + "</tr></table>"
            var strRepComma2 = sum.replace(/,/g, "");
            strPrindData.push(strRepComma2);
            strPrindData.push("<hr color=black><br><div style='width:100%; height:30px'> <table> <tr> <td style='width:20px;font-weight:bold'>Remarks</td><td style='width:1%'>:</td><td>" + $("#TXTSTRREMARKS").val() + " </td> </td>" +

                "</tr></table> </div>" +
                "<br>"

                );
            strPrindData.push("<div> <label>" +
                                    "*Implant /Mesh /Stent Charges extra, it is not included in Estimate</label>" +
                                "<br>" +
                                "<label>" +
                                   " *Pre Operative Investigation, not included in Estimate</label>  </div>" +
                                   "<br>"

                );
            strPrindData.push("<div> <label style='font-weight:bold'>NOTE : </label><br>" +
                          "<p>  1) This is only an ESTIMATE and not the actual cost, cost may vary depending on the complexity of the case.</p>" +
                        "<p>2) Estimated charges of medicines,consumable & investigation may vary based on the medical condition of the patient" +
                         "and doctors recommendations.</p>" +
            "<p>3) This estimate is based on standard recommended bed stay, however in case of prolonged stay charges will vary" +
            "based on the length of stay.</p>" +
            "<p>4) 80% of total estimated cost of surgery needs to be deposited 24 hours before the surgery or at the time of" +
            " Addmission.Payments in Cash/Card/Demand Drafts.</p>" +
            "<p>5) Demand Drafts to be in favour of JUPITER LIFE LINE HOSPITALS LTD.</p>" +
             "<p>6) Emergency Surgeries,cases after 8 pm to 8 am & on Sunday/Holidays will be 33% extra on procedure charges.</p></div>"
                );
            strPrindData.push("<br> <hr color=black>" +
            "<table style='width:100%;font-family:Times New Roman'>" +
"<tr>" +
"<td style=color:blue>Printed By</td>" +
"<td style='width:1%'>:</td>" +
"<td style=font-weight:bold;width:40%>" + response.jsonComplaints[0].PrintedBy + "</td>" +
"<td style='color:blue;width=125px;' >Printed Date/Time</td><td style='width:1%'>:</td>" +
"<td style='width:20%;text-align:right' >" + response.jsonComplaints[0].PrintDateTime + "</td>" +
"</tr></table>");




            strPrindData.push("<body></html>");
            return strPrindData.join("");
        }
        function PrintListAJAXCommon(Url, data, fileName, dispurl) {
            var oReq = new XMLHttpRequest();
            oReq.open("post", Url, true);
            oReq.responseType = "blob";
            oReq.onload = function (oEvent) {
                var blob = oReq.response;
                var imgSrc = URL.createObjectURL(blob);
                var isfrem = document.getElementById("myIframe");
                if (isfrem != null) {
                    isfrem.parentNode.removeChild(isfrem);
                }
                var $iframe = $('<iframe id="myIframe"   name="myIframe" src=' + imgSrc + '#page=2" style=width:100%;height:100%></iframe>')
                $('#iframe').append($iframe);
                $("#myIframe").load(function () {
                    window.frames["myIframe"].focus();
                    window.frames["myIframe"].print();
                    $('#mdPrint').modal('show')
                    //  $.loader.close();
                });
            };
            var fdata = new FormData();
            fdata.append('strHtml', data.strHtml);
            oReq.send(fdata);
        }
        function GetLoginInformation() {
            var strTranNo = ("" + document.getElementById("TXTSTRESTIMATIONNO").value);
            var LogType = "I";
            funcLogInfo(strTranNo, LogType);
        }
        function remove(arr, item) {
            for (var i = arr.length; i-- ;) {
                if (arr[i].BEDCATGCD === item) {
                    arr.splice(i, 1);
                }
            }
        }
        function getAllSelectOptions() {
            var states = {
                '0': '0', '1': '1', '2': '2', '3': '3', '4': '4', '5': '5', '6': '6', '7': '7', '8': '8', '9': '9', '10': '10',
                '11': '11', '12': '12', '13': '13', '14': '14', '15': '15', '16': '15', '17': '17', '18': '18', '19': '19', '20': '20', '21': '21',
                '22': '22', '23': '23', '24': '24', '25': '25', '26': '26', '27': '27', '28': '28', '29': '29', '30': '30', '31': '31'
            };
            return states;
        }

        function clearData() {
            GRIDESTIMATEDCOMP();
            $('#txtSergery').val("");
            $('#txtAsoSergery').val("");
            $(".btn-primary").removeClass("active");
            $('#TXTSTRREMARKS').val("");
            $('#btnSave').prop('disabled', false);
            $('#dblSergeryHelp input:checkbox').removeAttr('checked');
            $('#dblAsoSergeryHelp input:checkbox').removeAttr('checked');
            strNew = [];
        }
    </script>
       <style>
        .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
        }

        .searchdivclass {
            top: 20px;
            z-index: 100;
            background: radial-gradient(#f47b02, #ff7b00);
            display: inline-block;
            border-style: solid;
            border-color: #f47b02;
            width: 272px;
        }

        ul.searchlistclass li {
            position: relative;
            left: -20px;
        }

        .btn-primary.active {
            color: #fff;
            background-color: #204d74;
            border-color: #122b40;
        }

            .btn-primary.active:hover {
                color: #fff;
                background-color: #204d74;
                border-color: #122b40;
                margin: 2px;
            }

        .btn-primary:focus, .btn-primary.focus {
            color: #fff;
            background-color: #3c8dbc;
            border-color: #3c8dbc;
            margin: 2px;
        }
        /*.ui-jqgrid-btable .ui-state-highlight {
            color: black;
        }*/
        .ui-state-default, .ui-widget-content .ui-state-default {
            background: #3c8dbc;
            border: 1px solid #D3D3D3;
            line-height: 15px;
            color: #ffffff;
            font-weight: normal;
        }

        .form-group {
            margin-top: 5px;
        }

        .form-control {
            border-radius: 5px;
            border-color: rgba(51, 122, 183, 0.55);
            -webkit-box-shadow: 0 8px 6px -6px black;
            -moz-box-shadow: 0 8px 6px -6px black;
            box-shadow: 0 7px 4px -6px rgb(181, 181, 181);
        }

        .row {
            margin-top: 10px;
        }

        .btn-primary {
            color: #fff;
            background-color: #3c8dbc;
            border-color: #3c8dbc;
            margin: 2px;
        }

        .btn-outline-primary {
            background: white;
            color: #3c8dbc;
            border-color: #3c8dbc;
        }

        /*.table-responsive {
            margin-left: -23px;
            width: 325px;
        }*/

        th {
            text-align: center;
        }

        @media only screen and (min-width : 992px) {
            .well-lg {
                padding: 24px;
                border-radius: 6px;
                width: 895px;
            }

            .row {
                margin-right: 0;
                margin-left: 0;
            }

            .searchdivclass {
                top: 20px;
                z-index: 100;
                background: radial-gradient(#f47b02, #ff7b00);
                display: inline-block;
                border-style: solid;
                border-color: #f47b02;
                width: auto;
            }


            .form-inline .form-control {
                display: inline-block;
                vertical-align: middle;
                margin-bottom: 2px;
            }

            .table-responsive {
                margin-left: 0px;
                width: 763px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="MainDiv" class="well well-lg">
        <div id="ContentHolderDiv">
            <div class="HeadDiv" style="width: 845px; display: none">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 43%;" id="POBlbl" class="h4">
                            <%if (ViewBag.RGaction == "N")
                              { %>
                    Cost Estimation - New
                <%} %>
                            <% else if (ViewBag.RGaction == "D")
                              { %>
                    Cost Estimation - Display
                <%} %>
                            <% else if (ViewBag.RGaction == "E")
                              { %>
                    Cost Estimation - Edit
                <%} %>
                            <% else if (ViewBag.RGaction == "C")
                              { %>
                    Cost Estimation - Cancel
                <%} %>
                        </td>
                        <td id="DisPOBno" style="display: none; margin-top: -3px;">

                            <label>Cost Estimation No.</label>
                            <%= Html.TextBoxFor(x => Model.STRESTIMATIONNO, new { @class = "TextBxFormat",@readonly=true, style = "width:120px", id = "TXTSTRESTIMATIONNO" })%>
                    Date / Time  :
                    <%= Html.TextBoxFor(x => Model.STRESTIMATIONDATE, new { @class = "TextBxFormat",@readonly=true, style = "width:70px", id = "TXTSTRESTIMATIONDATE" })%>
                            <%= Html.TextBoxFor(x => Model.STRESTIMATIONTIME, new { @class = "TextBxFormat", @readonly = true, style = "width:70px", id = "TXTSTRESTIMATIONTIME" })%>
                        </td>
                    </tr>
                </table>
            </div>
            <%if (ViewBag.RGaction == "N" || ViewBag.RGaction == "E")
              { %>
            <div id="Patserchdiv" style="width: 847px; display: none">
              <%--  <% Html.RenderPartial("PatientInfoSearch", new OncologyEMR.Models.UserControlModel { }); %>--%>
            </div>
            <%} %>
            <form id="FRMCOSTESTIMATION" action="./" runat="server" class="form-inline">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <div class="panel-heading" id="rbtndiv" style="width: 844px; display: none">
                    <input type="radio" id="RBTNCASH" name="CSTESTMN" checked="checked" /><label style="vertical-align: top;"> Cash </label>
                    <input type="radio" id="RBTNGISPA" name="CSTESTMN" /><label style="vertical-align: top;"> GIPSA </label>
                    <input type="radio" id="RBTNPRIVATETPA" name="CSTESTMN" /><label style="vertical-align: top;"> Private TPA </label>
                    <input type="radio" id="RBTNCORPORATE" name="CSTESTMN" /><label style="vertical-align: top;"> Corporate </label>
                </div>
                <% if (ViewBag.RGaction == "N" || ViewBag.RGaction == "E")
                   { %>
                <div class="row">
                    <div class="col-md-6 form-group">
                        <div id="SergerydivMultiSelect">
                            <%= Html.TextBoxFor(x => Model.STRSURGECODE , new { @class = "form-control", placeholder="Search For Surgery....",  id = "txtSergery" })%>
                        </div>
                    </div>
                    <div class="col-md-6 form-group">
                        <div id="AsoSergerydivMultiSelect">
                            <%= Html.TextBoxFor(x => Model.STRASSOSURGECODE, new { @class = "form-control", placeholder="Search For Asso.Service....", id = "txtAsoSergery"})%>
                        </div>
                    </div>

                </div>
                <%} %>
                <fieldset>
                    <div class="row">
                        <div id="bedbtn" class="col-md-12">
                        </div>

                        <%= Html.TextBoxFor(x => Model.STRBEDLIST, new { @class = "form-control", style = "display:none;", id = "TXTSTRBEDLIST"})%>
                        <%= Html.TextBoxFor(x => Model.STRESTIMATIONLIST, new { @class = "form-control", style = "display:none;", id = "TXTSTRESTIMATIONLIST"})%>
                        <%= Html.TextBoxFor(x => Model.STRBEDCATLIST, new { @class = "form-control", style = "display:none;", id = "TXTSTRBEDCATLIST"})%>
                        <%= Html.TextBoxFor(x => Model.STRVIEWSTATE, new { @class = "form-control", style = "display:none;", id = "TXTSTRVIEWSTATE" })%>


                        <table style="width: 100%;">
                            <tr id="ButtonRow">
                                <td>
                                    <div id="btndiv" class="row">
                                        <div class="col-md-12 center-block">
                                            <% if (ViewBag.RGaction == "N" || ViewBag.RGaction == "E")
                                               {%>
                                            <input type="button" id="btnEstimate" class="btn btn-outline-primary center-block" value="Estimate" onclick="GetEstimation();" />
                                            <%}%>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>

                    </div>
                </fieldset>
                <fieldset>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table id="ESTIMATEDCOMP" class="table"></table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label style="position: relative; top: 5px;">Remarks</label>
                            </div>
                            <br>
                            <%= Html.TextAreaFor(x => Model.STRREMARKS, new { @class = "form-control", style = "width: 95%;margin-left: 18px; resize: none;height: 75px;position: relative;", id = "TXTSTRREMARKS",MaxLength="100"})%>
                            <div style="position: relative; top: 5px; margin-left: 18px;">
                                <label>
                                    *Implant /Mesh /Stent Charges extra, it is not included in Estimate</label>
                                <br>
                                <br>
                                <label>
                                    *Pre Operative Investigation, not included in Estimate</label>
                            </div>

                        </div>
                    </div>
                </fieldset>
                <div id="buttongrp">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="2">
                                <table style="width: 100%">
                                    <tr id="ButtonRow1">
                                        <td>
                                            <div id="btndiv1" class="row">
                                                <div class="col-md-12 center-block">
                                                    <%if (ViewBag.RGaction == "N")
                                                      {%>
                                                    <input type="button" id="btnSave" class="btn btn-outline-primary center-block" value="Save" onclick="SaveEstimation();" />
                                                    <%}
                                                      else if (ViewBag.RGaction == "E")
                                                      { %>
                                                    <input type="button" id="btnSave" class="btn btn-outline-primary center-block" value="Update" onclick="SaveEstimation();" />
                                                    <%}
                                                      else if (ViewBag.RGaction == "C")
                                                      { %>
                                                    <input type="button" id="btnSave" class="btn btn-outline-primary center-block" value="Cancel" onclick="SaveEstimation();" />
                                                    <%}
                                                      else if (ViewBag.RGaction == "D")
                                                      { %>
                                                    <a id="lnkPrint" href="#">
                                                        <input type="button" class="Nbutton" value="Print" onclick="PrintAction()" /></a>
                                                    <%} %>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width: 42PX; text-align: right;">
                                <div id="CSList" style="cursor: pointer; position: relative; float: right; top: 0px; zoom: 1.2; margin-right: 3px; text-decoration: none"
                                    title="List View">
                                </div>

                                <%if (ViewBag.RGaction != "N")
                                  { %>
                                <div id="getloginInfo" class="ui-icon ui-icon-info" onclick="GetLoginInformation()" style="cursor: pointer; position: relative; float: right; top: -1.5px; zoom: 1.2; margin-right: 3px;"
                                    title="Get Transaction Info">
                                </div>
                                <%} %>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="display: none;">
                   <%-- <% Html.RenderPartial("UserLogInfo", new OncologyEMR.Models.LogInfo { });%>--%>
                </div>
            </form>
        </div>
    </div>
</asp:Content>


