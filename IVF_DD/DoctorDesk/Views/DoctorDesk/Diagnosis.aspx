<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div>
            <input style="width: 100%; background-color: #ecf0f5; margin-left: -17px; margin-top: -22px; position: fixed;display:none" class="empty">
        </div>
        <div id="MainDiv">
            <div id="ContentHolderDiv" class="contentHoldClass" style="width:100%">
                <div class="nav-tabs-custom" style="margin-bottom: 0px !important;margin-top:5px;">
                    <ul class="nav nav-tabs">
                        <li class="active"><a id="Diagno" href="#DateWise" class="Diagnosis" data-toggle="tab" aria-expanded="true">Diagnosis</a></li>
                        <li class=""><a id="ICDDiag" href="#DateWise" class="ICDDiagno" data-toggle="tab" aria-expanded="false">ICD Diagnosis</a></li>
                        <li class="" style="width: 130px;"><a id="ICDDiagO" href="#DateWise" class="ICDDiagnoO" data-toggle="tab" aria-expanded="false">ICD-O Diagnosis</a></li>
                        <li class="" id="PersICDDiag" style="display:none;">
                         <button type="button" class="btn btn-info margin" style="margin-top:auto;""  onclick="CreateICDDiagSetupList()">Pers ICD Diag...</button>
                        </li>
                        <li class="" id="PersDiag" style="display:none;">
                         <button type="button" class="btn btn-info margin" style="margin-top:auto;""  onclick="CreateDiagnosisSetupList()">Pers Diag...</button>
                        </li>
                        <li class="" style="float: right;">
                            <label id="myBtn" style="background-color: transparent; border-color: transparent;display:none;" title="Save" onclick="backtoHome();">
                                <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%;cursor: pointer;">
                            </label>
                        </li>
                        <li class="" id="ICDOEdit_LI" style="float: right;display:none;width: 70px;">
                         <button type="button" id="ICDOEdit" class="btn btn-info margin" style="margin: 0px;"  onclick="EditICDODetails('N')">Edit</button>
                        </li>
                        <li class="" id="ICDOHist_LI" style="float: right;display:none;width: 80px;">
                         <button type="button" id="ICDOHistory" class="btn btn-info margin" style="margin: 0px;"  onclick="OpenCloseICDOHistory()">History</button>
                        </li>
                    </ul>
                    
                </div>
                    <div id="wrapper" style="overflow: hidden; width: 100%">
                        <div class="tableDiv" style="padding-top: 5px;">
                            <div id="MAIN_DIAG" style="display:none;">
                                <label id="myAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-right: 24px; border-color: transparent;" title="Go to top">
                                    <img src="../Images/add.png" style="background-color: white; border-radius: 50%; margin-top: 4px; position: fixed;">
                                </label>
                                <input type="text" id="DiagnosisInput" onkeyup="SearchDiagnosis()" placeholder="&#xF002; Search Diagnosis" style="margin-bottom:10px;float: left; height: 28px; width: 50%; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-left: 10px; margin-top: 4px;" class="empty">
                                <table class="HeadPatTab" style="text-align: center" id="HeadDiog">
                                    <thead>
                                        <tr style="background-color: #fffdc8">
                                            <th style="width: 90%;">Diagnosis</th>
                                            <th class='HeadRemark' style="">Remark</th>
                                        </tr>
                                    </thead>
                                </table>
                                <table id="tbldiagno" class="table HeadPatTab" style="width: 100%; font-size: 14px;">
                                    <tbody id="tblsort" style="height: 100%;"></tbody>
                                </table>
                            </div>

                            <div id="MAIN_ICD" style="display:none;">
                                <input type="text" id="ICDDiagnosisInput" onkeyup="SearchICDDiagnosis()" placeholder="&#xF002; Search ICD Diagnosis" style="margin-bottom:10px;float: left; height: 28px; width: 50%; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 4px;" class="empty">
                                <table class="HeadPatTab" style="text-align: center;" id="HeadDiog1">
                                    <thead>
                                        <tr style="background-color: #fffdc8">
                                            <th style="width: 101%;">Diagnosis</th>
                                        </tr>
                                    </thead>
                                </table>
                                <table id="tblICDdiagno" class="table HeadPatTab" style="width: 100%; font-size: 14px;">
                                    <tbody id="tblsort1" style="height: 100%;"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                <div id="MAIN_ICDO" style="display: none;">
                    <div class="row" id="Cancer">
                        <div class="col-xs-12">
                            <div style="display: inline-block;">
                                <label class="TopoHistHeaderLbl" style="display: inline-block; font-size: 16px;width: 180px;">Diagnosed with Cancer</label>
                                <div style="display: inline-block;">
                                    <div style="display: flex; align-items: center; padding-left: 20px;">
                                        <input style="margin: 0;" name="CANCER" type="radio" id="RbtnCancerY" onclick="EnDisCancer()" />
                                        <label style="margin: 0; padding: 0px 10px;" for="RbtnCancerY">Yes</label>
                                        <input style="margin: 0;" name="CANCER" type="radio" id="RbtnCancerN" onclick="EnDisCancer()" />
                                        <label style="margin: 0; padding: 0px 10px;" for="RbtnCancerN">No</label>
                                    </div>
                                </div>
                            </div>
                            <div id="CancerOptMainDiv" style="text-align: center; display: none;">
                                <div style="display: flex; align-items: center; justify-content: center;" id="CancerOptDiv">
                                    <input style="margin: 0;" name="CANCERTYPE" type="checkbox" id="RbtnCancerTypeR" />
                                    <label style="margin: 0; padding: 0px 10px;" for="RbtnCancerTypeR">Radiation Oncology</label>
                                    <input style="margin: 0;" name="CANCERTYPE" type="checkbox" id="RbtnCancerTypeM" />
                                    <label style="margin: 0; padding: 0px 10px;" for="RbtnCancerTypeM">Medical Oncology</label>
                                    <input style="margin: 0;" name="CANCERTYPE" type="checkbox" id="RbtnCancerTypeP" />
                                    <label style="margin: 0; padding: 0px 10px;" for="RbtnCancerTypeP">Palliative Care</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row" id="Remark" style="margin-top: 10px;display:none;">
                        <div class="col-xs-12" style="vertical-align: top; display: flex;">
                            <label class="TopoHistHeaderLbl" style="display: inline-block; font-size: 16px; width: 240px;">Remark</label>
                            <textarea id="ICDORemark" class="form-control TextAreaBorder" maxlength="100"  onkeyup="$('#ICDORemark').css('border-color', '');"></textarea>    
                        </div>
                    </div>

                    <div id="SITE_1" style="display: none;">
                        <div id="Site_Header_1" class="col-xs-12 SiteHeaderDiv" style="display: none;">
                            <label class="SiteHeaderLbl">Primary Site</label>
                        </div>
                        <div id="Site_Content_1" class="col-xs-12 SiteContentDiv">
                            <div id="Search_Topo_Div_1" class="col-xs-12 SiteTopoSrchDiv">
                                <input type="text" id="SrchICDOTopography_1" placeholder="Search Topography..." class="SiteTopoSrchTxt" onkeyup="SearchTopoGraphy(this.id,'1')">
                                <div class="SearchList" id="TopographySrchLst_1" style="display: none"></div>
                            </div>
                            <div id="Search_Topo_Content_1" class="TopoContentDiv"></div>
                        </div>
                    </div>

                    <div id="SITE_2" style="margin-top: 10px; display: none;">
                        <div id="Site_Header_2" class="col-xs-12 SiteHeaderDiv" style="margin-top: 10px;">
                            <label class="SiteHeaderLbl">Secondary Site</label>
                        </div>

                        <div id="Site_Content_2" class="col-xs-12 SiteContentDiv">
                            <div id="Search_Topo_Div_2" class="col-xs-12 SiteTopoSrchDiv">
                                <input type="text" id="SrchICDOTopography_2" placeholder="Search Topography..." class="SiteTopoSrchTxt" onkeyup="SearchTopoGraphy(this.id,'2')">
                                <div class="SearchList" id="TopographySrchLst_2" style="display: none"></div>
                            </div>
                            <div id="Search_Topo_Content_2" class="TopoContentDiv"></div>
                        </div>
                    </div>
                </div>
                  <div id="griddet" class="jqGrid" style="display:none;">
                    <label id="closebtn" style="background-color: transparent; float: right; margin-right: 25px; margin-top: 0px;border-color: transparent;" title="Close">
                    <img src="../Images/icon.png" style="background-color: white; border-radius: 50%; position: fixed; z-index: 1000;">
                        </label>
                    <table id="gvtable">
                    </table>
                    <div id="Pagerr"></div>
                </div>
                <div id="layer-demo" class="po__layer list">
                </div>
                <div id="layer-DMY" class="po__layer list">
                    <a href="javascript:;" style="text-decoration: none;" onclick="SetText('D')">Days</a>
                    <a href="javascript:; " style="text-decoration: none;" onclick="SetText('M')">Months</a>
                    <a href="javascript:;" style="text-decoration: none;" onclick="SetText('Y')">Years</a>
                </div>
            </div>
        </div>
        <div id="POPUPInfoModal" class="EModal" style="justify-content: center; align-items: center;">
            <div class="modal-content" style="min-width: 300px;">
                <div class="ModelHeaderDiv ResultHeader">
                    <label id="InfoHeadLabel"></label>
                    <span id="closeARISCATBtn" class="closeMdlBtn" onclick="document.getElementById('POPUPInfoModal').style.display = 'none'; document.documentElement.style.overflow = '';">&times;</span>
                </div>
                <div class="ModelContentDiv">
                    <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                        <div class="Tablewrapper" style="font-size: 12px; background: white;">
                            <table class="tblpopupList" id="TblPrefixInfo">
                                <thead>
                                    <tr>
                                        <th>Value</th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td style="text-align: center;">c</td>
                                        <td>Clinical</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">p</td>
                                        <td>Pathological</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">yc</td>
                                        <td>Post-treatment Clinical</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">yp</td>
                                        <td>Post-treatment Pathological</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">r</td>
                                        <td>Recurrent</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="POPUPHISTOInfoModal" class="EModal" style="justify-content: center; align-items: center;">
            <div class="modal-content" style="min-width: auto;">
                <div class="ModelHeaderDiv ResultHeader">
                    <label>History</label>
                    <span class="closeMdlBtn" onclick="document.getElementById('POPUPHISTOInfoModal').style.display = 'none'; document.documentElement.style.overflow = '';">&times;</span>
                </div>
                <div class="ModelContentDiv" id="HistoryContentDiv">
                </div>
            </div>
        </div>

       <%-- Added by Dhananjay 20250926 --%>
       <div style="position: fixed; bottom: 20px; left: 25%; right: 15%; text-align: center; z-index: 1000;">
            <button id="btnSave" onclick="SaveDiagnosis('SS');"
                style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
                onmouseover="this.style.backgroundColor='#218838'"
                onmouseout="this.style.backgroundColor='#28a745'">
                Save
            </button>

       </div>

    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .nav-tabs-custom > .nav-tabs > li.active > a {
            background-color: #d2d6de;
        }

        table {
            width: 100%;
        }

        thead, tbody, tr, td, th {
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
            max-height: 280px;
            overflow-y: auto;
        }

        .StuckInput {
            width: 100%;
            position: fixed;
        }

        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-decoration: inherit;
            font-size: 16px !important;
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

        .empty {
            width: 62%;
        }

        @media only screen and (min-width : 992px) {
            .empty {
                width: 59%;
            }
        }

        .HeadRemark {
            width: 10.5%;
        }

        @media only screen and (min-device-width : 1024px)and (max-device-width : 1152px) {

            .HeadRemark {
                width: 10.8%;
            }
        }

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            .empty {
                width: 85%;
            }

            .HeadRemark {
                width: 11.9%;
            }

            .HeadPatTab > thead > tr > th {
                text-align: center;
                border: 1px solid #ede4e4;
                height: 22px;
                font-size: 10px;
            }
        }

        #tbldiagno tr td:not(:first-child) {
            width: 20%;
            text-align: center;
        }

            #tbldiagno tr td:not(:first-child) a {
                width: 98%;
            }

        .HeadPatTab > tbody > tr {
            table-layout: auto;
        }

        @media only screen and (min-device-width : 490px) and (max-device-width : 767px) {

            .HeadRemark {
                width: 10.9%;
            }

            .HeadPatTab > thead > tr > th {
                text-align: center;
                border: 1px solid #ede4e4;
                height: 22px;
                font-size: 10px;
            }
        }

        @media only screen and (min-width : 992px) {
            .divtblICDDiagnosisSetup {
                height: 500px !important;
                overflow-y: hidden !important;
            }

                .divtblICDDiagnosisSetup:hover {
                    overflow-y: scroll !important;
                    transition-duration: 0.4s;
                    transition-timing-function: cubic-bezier(0.36, 0.55, 0.19, 1);
                    border-color: white;
                }
        }



        .divtblICDDiagnosisSetup {
            height: 600px;
            overflow-y: scroll;
        }

        div.divtblICDDiagnosisSetup::-webkit-scrollbar {
            width: 7px;
        }

        div.divtblICDDiagnosisSetup::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        div.divtblICDDiagnosisSetup::-webkit-scrollbar-thumb {
            background: #b4b6f2;
            border-radius: 3px;
        }

        div.divtblICDDiagnosisSetup:hover {
            overflow-y: scroll;
        }

        @media (min-width: 992px) {
            .jconfirm-box-container {
                margin-left: 25.333333%;
            }
        }

        @media only screen and (min-width: 1400px) {
            .jc-bs3-row {
                margin-left: -6px;
            }
        }

        #tblPersICDDiagnolist > tbody > tr > td {
            border: 1px solid rgba(234, 228, 228, 0.32) !important;
        }

        .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
            color: #000;
            font-weight: normal;
            font-size: small;
        }

        #tblPersDiagnolist > tbody > tr > td {
            border: 1px solid rgba(234, 228, 228, 0.32) !important;
        }

        @media only screen and (min-width : 992px) {
            .divtblDiagnosisSetup {
                height: 500px !important;
                overflow-y: hidden !important;
            }

                .divtblDiagnosisSetup:hover {
                    overflow-y: scroll !important;
                    transition-duration: 0.4s;
                    transition-timing-function: cubic-bezier(0.36, 0.55, 0.19, 1);
                    border-color: white;
                }
        }



        .divtblDiagnosisSetup {
            height: 600px;
            overflow-y: scroll;
        }

        div.divtblDiagnosisSetup::-webkit-scrollbar {
            width: 7px;
        }

        div.divtblDiagnosisSetup::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        div.divtblDiagnosisSetup::-webkit-scrollbar-thumb {
            background: #b4b6f2;
            border-radius: 3px;
        }

        div.divtblDiagnosisSetup:hover {
            overflow-y: scroll;
        }

        .TNMHeaderDiv {
            background-color: #3b5998;
            color: white;
            padding: 5px 5px;
            font-size: 15px;
        }

        .DownUpTopoIcon {
            font-size: 20px;
            padding: 0px 10px;
            cursor: pointer;
        }
    </style>

        <%-- Info Popup --%>
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
                min-width: 50vw !important;
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
            position: sticky;
            top: 0;
            z-index: 10;
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
        table.tblpopupList {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            min-height: 30px;
        }

            table.tblpopupList thead {
                background: #314b81;
                color: white;
                font-size: 12px;
            }

            table.tblpopupList th {
                padding: 5px 15px;
                border: none;
                border: 1px solid #999999;
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

                table.tblpopupList tbody td{
                    padding:5px;
                    border: 1px solid #d7d7d7;
                }
    </style>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/jquery-ui-touch-punch.js"></script>
    <script src="../Scripts/PatList.js"></script>
     <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>

    <script type="text/javascript">
        var sessionPatStatus = sessionStorage.getItem('PatCompleted');
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var newlyAddedDiagno = "";
        var idOfDMY = "";
        var FreqDataSetupList = [];
        var gporvFiagnosis = "";
        var gCompositStage = "";
        var gTtStage = "";
        var gNtStage = "";
        var gMtStage = "";
        var gSite = "";
        var gSubSite = "";
        var addclick = false;
        var OpenProvDiagOnLoad = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("OpenProvDiagOnLoad")%>';
        var srvcgrpname = "dblServiceHelpsrvcgrp";
        var srvcdiaggrpname = "dblServiceDiagHelpsrvcgrp";
        var addedDiagSetupCodes = [];
        var addedIcdSetupCodes = [];
        var SetupNameICDDiagText = "";
        var SetupNameDiagText = "";
        var MapDiagSetupCodes = new Map();
        var MapICDDiagSetupCodes = new Map();
        var TNMNotFilter = "N";
        var OtherFieldList = [
    { ID: "GEOGRAPHIC", LABEL: "Grade" },
    { ID: "LOCATION", LABEL: "Location" },
    { ID: "MITOTIC", LABEL: "Mitotic" },
    { ID: "PSA", LABEL: "PSA" },
    { ID: "SERUMMARKERS", LABEL: "Serum Markers" },
    { ID: "HERITABLETRAIT", LABEL: "Heritable Trait" },
    { ID: "HER2", LABEL: "HER2" },
    { ID: "ER", LABEL: "ER" },
    { ID: "PR", LABEL: "PR" },
    { ID: "BLOODINVL", LABEL: "Blood invl." },
        ];
        $(document).ready(function (e) {
            HoldOn.open();
            SetPatientDtl();
            document.getElementById('DiagnosisInput').focus();
            LoadICDO();
            //AddDiagnosis(addclick);
            AddICDDiagnosis();
            var activeTab = sessionStorage.getItem('activeTab');
            if (activeTab == null || activeTab == "") {
                activeTab = "Diagno";
            }
            if (activeTab == "Diagno") {
                $('#' + activeTab).tab('show');
                $("#MAIN_ICD").hide();
                $("#MAIN_ICDO").hide();
                $("#PersICDDiag").hide();
                $("#ICDOEdit_LI").hide();
                $("#ICDOHist_LI").hide();
                $("#PersDiag").show();
                $("#MAIN_DIAG").show();
            }
            if (activeTab == "ICDDiag") {
                $('#' + activeTab).tab('show');
                $("#MAIN_DIAG").hide();
                $("#MAIN_ICDO").hide();
                $("#PersDiag").hide();
                $("#ICDOEdit_LI").hide();
                $("#ICDOHist_LI").hide();
                $("#PersICDDiag").show();
                $("#MAIN_ICD").show();
            }
            else if (activeTab == "ICDDiagO") {
                $('#' + activeTab).tab('show');
                $("#MAIN_DIAG").hide();
                $("#MAIN_ICD").hide();
                $("#PersICDDiag").hide();
                $("#PersDiag").hide();
                $("#MAIN_ICDO").show();
                $("#ICDOEdit_LI").show();
                $("#ICDOHist_LI").show();
            }
            sessionStorage.setItem('activeTab', activeTab);
            $('a[data-toggle="tab"]').on('click', function () {
                sessionStorage.setItem('activeTab', $(this).attr('id'));
            });
            if ($(window).width() >= 996) {
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                var dispLst = document.getElementById('sideList');
                $("#slide_sdList").click();
                ActiveMenu(activeTab);
            }
            if ($(window).width() >= 1200) {
                $("#tabMenu").css("display", "block");
            }

            for (var i = 0; i <= 30; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' style='text-decoration: none;' id='NumDaysSc'>" + i + "</a>";
                $("#layer-demo").append(s);
            }

            $('#ICDDiagnosisInput').on('keyup', function () {
                var input = $(this);
                if (input.val().length === 0) {
                    input.addClass('empty');
                } else {
                    input.removeClass('empty');
                }
            });
            $('.trigger1').po({
                alignment: 'center'
            });
            $('.trigger2').po({
                alignment: 'center'
            });

            $("#layer-demo .NumDaysCls").click(function (e) {
                var txt = $(this).text();
                SetText(txt);
            });

            $("#myBtn").click(function () {
                SaveDiagnosis("N");
            });

            $("#closebtn").click(function () {
                $("#griddet").css('display', 'none');
                $('#ICDDiagnosisInput').val('');
                SearchICDDiagnosis();
            });

            $("#myAdd").click(function () {
                $.confirm({
                    title: '',
                    boxWidth: '90%',
                    useBootstrap: false,
                    content: '' +
                         '<style>' +
                         '.custom-popup .jconfirm-box { min-width: 300px !important; }' +
                         '</style>' +
                    '<form action="" class="formName" style="height:134px">' +
                    '<div class="form-group">' +
                  '<label>Diagnosis</label>' +
                           '<textarea type="varchar" id="txtDiagnosis" maxlength="50"  placeholder="Diagnosis" autofocus="autofocus" class="complaint form-control  TextAreaBorder " required rows="5" cols="30"/>' +
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var digno = this.$content.find('.complaint').val().trim().replace(/\s/g, ' ');
                                var grpCode = "";
                                if (digno == "") {
                                    $.alert('Enter Diagnosis');
                                    return false;
                                }
                                if (digno != "") {
                                    $.ajax({
                                        type: "post",
                                        datatype: "json",
                                        url: 'AddDiagnosis',
                                        data: { strDiagnosis: digno },
                                        success: function (response) {
                                            if (("" + response).toUpperCase().indexOf("SUCCESS") != -1) {
                                                $("#txtDiagnosis").val("");
                                                newlyAddedDiagno = response.split(' ').pop().trim();
                                                var rows = "<tr class='clickable-row' id='" + newlyAddedDiagno + "'>" + "<td style='padding:5px; width:90%   font-size: 13px;text-align:left;' class='DiagnoNm'>" + digno + "</td>" +
                                   "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                    "<td class='tdSetUpYn' style='display:none;'></td>" +
                                         "<td class='RemarkText' style='display:none;'></td>" +
                                   "</tr>";
                                                $("#tbldiagno tbody").prepend(rows).closest('tr');
                                                $('#tbldiagno tr#' + newlyAddedDiagno).trigger('click');
                                            }
                                            else if (("" + response).toUpperCase().indexOf("PRESENT.") != -1) {
                                                var jc = this;
                                                $("#DiagnosisInput").val(digno);
                                                AfterpresentSearchDiagnosis(digno);
                                            }
                                            else {
                                                $.messager.alert("Information", response);
                                            }
                                        },
                                    });
                                }
                            }
                        },
                        CLOSE: function () {
                        },
                    },
                    onContentReady: function () {
                        $('#txtDiagnosis').focus();
                        var jc = this;
                        this.$content.find('form').on('submit', function (e) {
                            e.preventDefault();
                            jc.$$formSubmit.trigger('click');
                        });
                    }
                });
            });
            $('.Diagnosis').click(function (e) {
                $("#MAIN_ICD").hide();
                $("#MAIN_ICDO").hide();
                $("#PersICDDiag").hide();
                $("#ICDOEdit_LI").hide();
                $("#ICDOHist_LI").hide();
                $("#PersDiag").show();
                $("#MAIN_DIAG").show();
                if (sessionPatStatus && sessionPatStatus == 'Y')
                    SaveDiagnosis("Y");
                if (EditICDOFlag == true) {
                    ValidationForICDODiag();
                    if (AllowSaveDiagnosis != true) {
                        e.stopPropagation();
                        e.preventDefault();
                        $('.ICDDiagnoO').trigger('click');
                    }
                }
                if (sessionStorage.getItem('PatCompleted') == "Y") {
                    $("#btnSave").hide();
                }
                else {
                    $("#btnSave").show();
                }
            });
            $('.ICDDiagno').click(function (e) {
                $("#MAIN_DIAG").hide();
                $("#MAIN_ICDO").hide();
                $("#PersDiag").hide();
                $("#ICDOEdit_LI").hide();
                $("#ICDOHist_LI").hide();
                $("#PersICDDiag").show();
                $("#MAIN_ICD").show();
                if (sessionPatStatus && sessionPatStatus == 'Y')
                    SaveDiagnosis("Y");
                if (EditICDOFlag == true) {
                    ValidationForICDODiag();
                    if (AllowSaveDiagnosis != true) {
                        e.stopPropagation();
                        e.preventDefault();
                        $('.ICDDiagnoO').trigger('click');
                    }
                }
                if (sessionStorage.getItem('PatCompleted') == "Y") {
                    $("#btnSave").hide();
                }
                else {
                    $("#btnSave").show();
                }
            });
            $('.ICDDiagnoO').click(function () {
                $("#MAIN_DIAG").hide();
                $("#MAIN_ICD").hide();
                $("#PersICDDiag").hide();
                $("#PersDiag").hide();
                $("#MAIN_ICDO").show();
                $("#ICDOEdit_LI").show();
                $("#ICDOHist_LI").show();
                if (BindDataTopoList.length == 0) {
                    $("#btnSave").show();
                }
                else {
                    $("#btnSave").hide();
                }
                if (sessionPatStatus && sessionPatStatus == 'Y')
                    SaveDiagnosis("Y");
            });
            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);
            $(document.body).on('click', '#tbldiagno td a,#tbldiagno td,#tbldiagno tr', function (e) {
                if (!$(this).is('.DiagnoNm')) {
                    e.stopPropagation();
                }
                else if ($(this).is('.DiagnoNm')) {
                    var $row = $(this).closest('tr');
                    $row.toggleClass('active');
                    if ($row.hasClass('active')) {
                        $row.find('.DiagnosisRemark').show();
                        $row.find('.DiagnosisRemark a').show();
                        var selRows = $('#tbldiagno > tbody > tr.active').get();
                        if (selRows.length === 1) {
                            $("#tbldiagno tbody").prepend($row);
                        } else {
                            $.each(selRows, function (index, row) {
                                $(row).detach().prependTo('#tbldiagno tbody');
                            });
                        }
                        $row.find('a').show();
                    } else {
                        $row.find('.DiagnosisRemark a').hide();
                    }
                    moveDiagnosisActiveRowsToTop();
                    e.stopPropagation();
                }
            });
            SetDataForDiagnosis();

            document.addEventListener('click', function (event) {
                var Topocontainer = document.getElementById('Search_Topo_Div_1');
                document.getElementById('TopographySrchLst_1').style.display = "none";
                document.getElementById('TopographySrchLst_1').innerHTML = "";
                document.getElementById('TopographySrchLst_2').style.display = "none";
                document.getElementById('TopographySrchLst_2').innerHTML = "";
                $("#SrchICDOTopography_1").val("");
                $("#SrchICDOTopography_2").val("");
                document.querySelectorAll('.TopoHistSrchTxt').forEach(function (container) {
                    $('[id="' + container.id + '"]').val("");
                });
                document.querySelectorAll('.SearchList').forEach(function (container) {
                    container.style.display = "none";
                    container.innerHTML = "";
                });
            });



        });

        function SetText(str) {
            $("#" + idOfDMY).text(str);
        }

        function AddDiagnosis(addclick) {
            var strClinincode = $.session.get('ClinicCode').toString().trim();
            var DataToSend = {
                ClinicCode: strClinincode
            };
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetMainDiagnoList","DoctorDesk")%>",
                data: DataToSend,
                async: false,
                success: function (result) {
                    var rows = "";
                    $('#tbldiagno tbody').empty();
                    FreqDataSetupList = result;
                    $.each(result, function (i, item) {
                        var rows = "<tr class='clickable-row' id='" + item.DESCCD.trim() + "'>" + "<td style='padding:5px; width:90%   font-size: 13px;text-align:left;' class='DiagnoNm'>" + item.DESC + "</td>" +
                                    "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                     "<td class='tdSetUpYn' style='display:none;'></td>" +
                                            "<td class='RemarkText' style='display:none;'></td>" +
                                    "</tr>";
                        $('#tbldiagno tbody').append(rows);
                    });
                },
                complete: function () {
                }
                , error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function AddICDDiagnosis() {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetICDDiagnoList","DoctorDesk")%>",
                data: {},
                async: true,
                success: function (result) {
                    var rows = "";
                    $('#tblICDdiagno tbody').empty();
                    $.each(result, function (i, item) {
                        var rows = "<tr class='clickable-row' id='" + item.CODE.trim() + "'>" + "<td style='padding:5px;text-align:left;width:100% font-size: 13px;'>" + item.NAME + "</td>" +
                        "</tr>";
                        $('#tblICDdiagno tbody').append(rows);
                    });
                },
                complete: function () {
                }
                , error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function SearchDiagnosis() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("DiagnosisInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tbldiagno");
            var tr = $("#tbldiagno  tr");
            if ($(input).val().length >= 3) {
                getDiagnoListFrmDB(filter, tr);
            } else {
                var tr = $("#tbldiagno  tr").not(".active").remove();
                var checdelem = $("#tbldiagno  tr.active");
                if ($(input).val().length == 0) {
                    for (var i = 0; i < checdelem.length; i++) {
                        checdelem[i].style.display = "";
                        if (!$(checdelem[i]).hasClass('display')) {
                            $(checdelem[i]).addClass('display')
                        }
                    }
                } else {
                    for (i = 0; i < checdelem.length; i++) {
                        $(checdelem[i]).removeClass('display');
                        td = checdelem[i].getElementsByTagName("td")[0];
                        if (td) {
                            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                                checdelem[i].style.display = "";
                                if (!$(checdelem[i]).hasClass('display')) {
                                    $(checdelem[i]).addClass('display')
                                }
                            } else {
                                checdelem[i].style.display = "none";
                            }
                        }
                    }
                }
                $.each(checdelem, function (j, item) {
                    td = checdelem[j].getElementsByTagName("td")[0];
                    if (td)
                        FreqDataSetupList = FreqDataSetupList.filter(function (e, index) {
                            return FreqDataSetupList[index]["DESCCD"].toString().trim() != td.parentElement.id.toString().trim();
                        });
                });
                i = checdelem.length;
                $.each(FreqDataSetupList, function (i, item) {
                    var rows = "<tr class='clickable-row' id='" + item.DESCCD.trim() + "'>" + "<td style='padding:5px; width:90%   font-size: 13px;text-align:left;' class='DiagnoNm'>" + item.DESC + "</td>" +
                                    "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                     "<td class='tdSetUpYn' style='display:none;'></td>" +
                                          "<td class='RemarkText' style='display:none;'></td>" +
                                    "</tr>";
                    $('#tbldiagno tbody').append(rows);
                });
            }
            var tr = $("#tbldiagno  tr");
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
        }

        function AfterpresentSearchDiagnosis(digno) {
            var table = document.getElementById("tbldiagno");
            var tr = table.getElementsByTagName("tr");
            var strClinincode = $.session.get('ClinicCode').toString().trim();
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetNonFregqentDiagnoList","DoctorDesk")%>",
                async: false,
                data: { NonFreqDiagno: digno, ClinicCode: strClinincode },
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);
                        var rows = "";
                        var AllreadyPresent = jQuery.grep(result.Table1, function (element, index) {
                            Name = digno;;
                            return ((element.NAME).toString().trim().toUpperCase() == digno.toString().trim().toUpperCase());
                        });
                        $.each(AllreadyPresent, function (i, item) {
                            $('#DiagnosisInput').val("");
                            var MatchElement = jQuery.grep(tr, function (element, index) {
                                Name = element.getElementsByTagName("td")[0].innerText;
                                return ((item.NAME).toString().trim().toUpperCase() == Name.toString().trim().toUpperCase());
                            });
                            if (MatchElement.length > 0) {
                                if ($('#tbldiagno tr#' + MatchElement[0].id).hasClass("active") == false)
                                    $('#tbldiagno  tr#' + MatchElement[0].id).trigger('click');
                            }
                            else {
                                var rows = "<tr class='clickable-row' id='" + result.Table1[i].CODE + "'>" + "<td style='padding:5px; width:90%   font-size: 13px;text-align:left;' class='DiagnoNm'>" + result.Table1[i].NAME.trim() + "</td>" +
                                    "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                     "<td class='tdSetUpYn' style='display:none;'></td>" +
                                          "<td class='RemarkText' style='display:none;'></td>" +
                                    "</tr>";
                                $('#tbldiagno tbody').append(rows).closest('tr');
                                $('#tbldiagno tr#' + result.Table1[i].CODE.trim()).trigger('click');
                            }
                        });
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function SearchICDDiagnosis() {
            var mystring = document.getElementById('ICDDiagnosisInput').value;
            if (!mystring.match(/\S/)) {
                $("#griddet").css('display', 'none');
                $("#closebtn").css('display', 'none');
                $("#tblICDdiagno").css('display', 'block');
            }
            else {
                $("#griddet").css('display', 'block');
                $("#closebtn").css('display', 'block');
                $("#tblICDdiagno").css('display', 'none');
            }
            var input, filter, table, tr, td, i;
            input = document.getElementById("ICDDiagnosisInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("gvtable");
            tr = table.getElementsByTagName("tr");
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
                getICDdiagnoList(filter);
            }
            else {
                getICDdiagnoList(filter);
            }
        }

        function getICDdiagnoList(filter) {
            if (filter.length >= 4 && filter.length != "") {
                HoldOn.open();
                $.ajax({
                    type: "POST",
                    url: "<%=Url.Action("GetNonFregqentICDList","DoctorDesk")%>",
                    data: { NonFreqICD: filter },
                    asycn: false,
                    success: function (response) {
                        if (response != "") {
                            var result = JSON.parse(response);
                            BindReport(result.Table);
                        }
                    },
                    complete: function () { HoldOn.close(); },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        HoldOn.close();
                        $.messager.alert("Error", errorThrown);
                    }
                });
            }
        }

        function SetDataForDiagnosis() {
            var tranNo = $.session.get('PatTRANNO');
            var MRNo = $.session.get('PatMRNO');
            ICDOTopoList = [];
            ICDOHistoList = [];
            $.ajax({
                type: 'post',
                datatype: 'json',
                data: { strTranNo: tranNo, strMRNO: MRNo },
                url: 'SetDataForDiagnosis',
                async: true,
                success: function (data) {
                    if (data != "") {
                        if (data[0] != null) {
                            for (var i = 0; i < data[0].length; i++) {
                                if ($('#tbldiagno tr#' + data[0][i]["DESCCD"]).length > 0) {
                                    //$('#tbldiagno tr#' + data[0][i]["DESCCD"]).trigger('click');
                                    $('#tbldiagno tr#' + data[0][i]["DESCCD"]).find('.RemarkText')[0].innerHTML = data[0][i]["REMARKS"].toString().trim();
                                    if (data[0][i]["REMARKS"].toString().trim() != "") {
                                        var DiagnosiswithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><spa>' + data[0][i]["REMARKS"].toString().trim() + '</span>'
                                        $('#tbldiagno tr#' + data[0][i]["DESCCD"]).find('td:nth-child(1)').append(DiagnosiswithRemark);
                                    }
                                    $('#tbldiagno tr#' + data[0][i]["DESCCD"] + ' td.tdSetUpYn')[0].innerHTML = data[0][i]["SETUPYN"];
                                }
                                else {
                                    var rows = "<tr class='clickable-row' id='" + data[0][i]["DESCCD"] + "'>" + "<td style='padding:5px;font-size: 13px;width:90%;text-align:left;' class='DiagnoNm'>" + data[0][i]["NAME"];
                                    if (data[0][i]["REMARKS"].toString().trim() != "") {
                                        rows = rows + '<strong><span style="font-size:14px;">   -  </span></strong><spa>' + data[0][i]["REMARKS"].toString().trim() + '</span>';
                                    }
                                    rows = rows + "</td>" +
                                       "<td class='DiagnosisRemark' style='width:10%;'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                        "<td class='tdSetUpYn' style='display:none;'>" + data[0][i]["SETUPYN"] + "</td>" +
                                          "<td class='RemarkText' style='display:none;'>" + data[0][i]["REMARKS"] + "</td>" +
                                       "</tr>";
                                    $('#tbldiagno tbody').append(rows);
                                    $('#tbldiagno tr#' + data[0][i]["DESCCD"]).trigger('click');
                                }
                            }
                        }
                        if (data[1] != null) {
                            $("#tblICDdiagno tbody").empty();
                            for (var i = 0; i < data[1].length; i++) {
                                var NonFrqRows = '';
                                var DiagID = (data[1][i]["ICDCODE"]);
                                var row = $('#tblICDdiagno tr' + DiagID).get();
                                if (row.length > 0) {
                                    $("#tblICDdiagno tbody").prepend(row).closest('tr');
                                    $('#tblICDdiagno tr' + DiagID).addClass('active');
                                }
                                else {
                                    NonFrqRows += "<tr class='clickable-row display active' id='" + DiagID + "'>" + "<td style='padding:5px;width:100%; text-align:left;font-size: 13px;'>" + data[1][i].NAME + "</td>";
                                    NonFrqRows += "</tr>";
                                    $('#tblICDdiagno tbody').prepend(NonFrqRows).closest('tr');
                                }
                            }
                        }
                        if (data[2] != null) {
                            //gporvFiagnosis = data[2][0]["PROVDIAGNOS"].toString().trim();
                            //gCompositStage = data[2][0]["COMPOSTAGE"].toString().trim();
                            //gTtStage = data[2][0]["TSTAGE"].toString().trim();
                            //gNtStage = data[2][0]["NSTAGE"].toString().trim();
                            //gMtStage = data[2][0]["MSTAGE"].toString().trim();
                            //gSite = data[2][0]["SITE"].toString().trim();
                            //gSubSite = data[2][0]["SUBSITE"].toString().trim();
                            //$("#CmbSiteList").val(gSite);
                            //$("#CmbSiteList").trigger('change');
                            //$("#CmbSubSiteList").val(gSubSite);
                            //$("#CmbSubSiteList").trigger('change');
                            //$("#ICDTList").val(gTtStage);
                            //$("#ICDTList").trigger('change');
                            //$("#ICDNList").val(gNtStage);
                            //$("#ICDNList").trigger('change');
                            //$("#ICDMList").val(gMtStage);
                            //$("#ICDMList").trigger('change');
                            //$("#CmbStageList").val(gCompositStage);
                            //$("#CmbStageList").trigger('change');
                        }
                        if (data[4] != null) {
                            BindDataTopoList = data[4];
                        }
                        if (data[5] != null) {
                            BindDataHistoList = data[5];
                        }
                        BindICDODtls();
                        $("#RbtnCancerN").prop("checked", true);
                        if (data[2] != null) {
                            if (data[2][0]["CANCERYN"].toString() == "Y" || BindDataTopoList.length > 0) {
                                $("#RbtnCancerY").prop("checked", true);
                                $("#RbtnCancerTypeR").prop("checked", data[2][0]["RADIATIONONCOYN"].toString() == "Y" ? true : false);
                                $("#RbtnCancerTypeM").prop("checked", data[2][0]["MEDICALONCOYN"].toString() == "Y" ? true : false);
                                $("#RbtnCancerTypeP").prop("checked", data[2][0]["PALLIATIVECAREYN"].toString() == "Y" ? true : false);
                            }
                        }
                        else if (BindDataTopoList.length > 0) {
                            $("#RbtnCancerY").prop("checked", true);
                        }
                        EnDisCancer();
                    }
                    EditICDODetails('Y');
                    if (BindDataTopoList.length == 0) {
                        $("#ICDOEdit").trigger('click');
                    }
                    else {
                        var activeTab = sessionStorage.getItem('activeTab');
                        if (activeTab == "ICDDiagO") {
                            $("#btnSave").hide();
                        }
                        else {
                            if (sessionStorage.getItem('PatCompleted') == "Y") {
                                $("#btnSave").hide();
                            }
                            else {
                                $("#btnSave").show();
                            }
                        }
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });
        }
        function EnDisCancer() {
            if ($("#RbtnCancerY").prop("checked") == true) {
                $("#CancerOptDiv *").removeAttr("disabled", "disabled");
                document.getElementById("CancerOptMainDiv").style.display = "inline-block";
                document.getElementById("SITE_1").style.display = "block";
            }
            else {
                $("#CancerOptDiv *").attr("disabled", "disabled");
                $("#RbtnCancerTypeR").prop("checked", false);
                $("#RbtnCancerTypeM").prop("checked", false);
                $("#RbtnCancerTypeP").prop("checked", false);
                document.getElementById("CancerOptMainDiv").style.display = "none";
                 document.getElementById("SITE_1").style.display = "none";
            }
        }
        function AddDiagnosisRemark(object, e) {
            e.stopPropagation();
            var RemarkText = "";
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label>Add Diagnosis Remark</label>' +
                '<textarea rows="5" cols="50"  id="txtDiagnosisRemark" maxlength="200" placeholder="Remark" autofocus="autofocus" class="complaint form-control  TextAreaBorder " required></textarea>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var cmplnt = this.$content.find('.complaint').val().toString().trim().replace(/\s/g, ' ');
                            if ($(object).parent().siblings('.RemarkText')[0].innerText == "") {
                                if (cmplnt.length == 0) {
                                    $.alert('Enter Remark');
                                    this.$content.find('.complaint').val("");
                                    return false;
                                }
                            }
                            if (RemarkText != "" || RemarkText != "undefined") {
                                $(object).parent().siblings('.RemarkText').remove();
                            }
                            var CurrentRow = $(object).parent().parent();
                            stringRemarkTd = "<td class='RemarkText' style='display:none'>" + $('#txtDiagnosisRemark').val() + "</td>";
                            var firstChildVal = $(CurrentRow).find('td:nth-child(1)').text().trim();
                            var ComplainwithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + $('#txtDiagnosisRemark').val() + '</span>'
                            $(CurrentRow).find('td:nth-child(1)').children().remove();
                            if ($("#txtDiagnosisRemark").val() != "") { $(CurrentRow).find('td:nth-child(1)').append(ComplainwithRemark); }
                            CurrentRow.append(stringRemarkTd);
                        }
                    },
                    Remove: function () {
                        $("#txtDiagnosisRemark").val("");
                        $('.formName').submit();
                    },
                    close: function () {
                    },
                },
                onContentReady: function () {
                    $('#txtDiagnosisRemark').focus();
                    RemarkText = $(object).parent().siblings('.RemarkText')[0].innerText;
                    $('#txtDiagnosisRemark').val(RemarkText);
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    if ($('#txtDiagnosisRemark').val() == "") {
                        jc.$$Remove.attr("style", "display:none")
                    }
                }
            });
        }

        function SaveDiagnosis(strPlusBtn) {
            if (EditICDOFlag == true) {
                ValidationForICDODiag();
                if (AllowSaveDiagnosis != true) {
                    return;
                }
            }
            HoldOn.open();
            var mrno = ($.session.get('PatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var diagnoArr = [];
            var ICDdiagnoArr = [];
            var rows = $('#tbldiagno > tbody > tr.active').get();
            for (var i = 0; i < rows.length; i++) {
                var code = rows[i].id
                var RemarkElement = $(rows[i]).children('.RemarkText');
                var DignosisRemark = $(RemarkElement).text();
                var setupYn = $(rows[i]).children('td.tdSetUpYn')[0].innerText;
                var a = {
                    DESCCD: code,
                    REMARKS: "" + DignosisRemark,
                    SETUPYN: setupYn,
                };
                diagnoArr.push(a);
            }
            var rows1 = $('#tblICDdiagno > tbody > tr.active').get();
            for (var i = 0; i < rows1.length; i++) {
                var code = rows1[i].id
                var b = {
                    DESCCD: code,
                };
                ICDdiagnoArr.push(b);
            }
            var PDiag = $.session.get('Diag');
            if (rows.length > 0 || rows1.length > 0 || PDiag == "Y" || PDiag == undefined) {
                $.session.set('Diag', "Y");
            }
            else {
                $.session.set('Diag', "N");
            }
            if ($.session.get('Diag') == "Y") {
                if (($.session.get('Diag') == "Y" && rows1.length == 0) && rows.length > 0) {
                    localStorage.setItem('ICDDiagSelYN', "N");
                    localStorage.setItem('DiagnosisSelYN', "Y");
                }
                else if ($.session.get('Diag') == "Y" && rows1.length > 0 && rows.length == 0) {
                    localStorage.setItem('ICDDiagSelYN', "Y");
                    localStorage.setItem('DiagnosisSelYN', "N");
                }
                else if ($.session.get('Diag') == "Y" && rows.length > 0 && rows1.length > 0) {
                    localStorage.setItem('DiagnosisSelYN', "Y");
                    localStorage.setItem('ICDDiagSelYN', "Y");
                }
                else if ($.session.get('Diag') == "Y" && rows.length == 0 && rows1.length == 0) {
                    localStorage.setItem('DiagnosisSelYN', "N");
                    localStorage.setItem('ICDDiagSelYN', "N");
                }
            }
            else {
                localStorage.setItem('DiagnosisSelYN', "N");
                localStorage.setItem('ICDDiagSelYN', "N");
            }

            var CancerYN = $("#RbtnCancerY").prop("checked") == true ? "Y" : "N";
            //if (CancerYN == "Y" && $("#RbtnCancerTypeR").prop("checked") == false && $("#RbtnCancerTypeM").prop("checked") == false && $("#RbtnCancerTypeP").prop("checked") == false) {
            //    $.messager.alert("Information", "Please Select Cancer.");
            //    HoldOn.close();
            //    return false;
            //}
            if (ICDOTopoList.length > 0) {
                jQuery.grep(ICDOTopoList, function (e) {
                    e.REMARKS = $("#ICDORemark").val();
                });
            }
            var DataToSend = {
                strDiagnosis: JSON.stringify(diagnoArr),
                strICDDiagnosis: JSON.stringify(ICDdiagnoArr),
                strMRNO: mrno,
                strTranNo: tranNo,
                ICDOTopoList: JSON.stringify(ICDOTopoList),
                ICDOHistoList: JSON.stringify(ICDOHistoList),
                CancerYN: CancerYN,
                RadOnco: $("#RbtnCancerTypeR").prop("checked") == true ? "Y" : "N",
                MedOnco: $("#RbtnCancerTypeM").prop("checked") == true ? "Y" : "N",
                Palliative: $("#RbtnCancerTypeP").prop("checked") == true ? "Y" : "N"
            }

            $.ajax({
                type: "POST",
                url: 'SaveDiagnosis',
                datatype: "json",
                data: DataToSend,
                success: function (result) {
                    if (strPlusBtn == 'SS') {
                        if (result != true) {
                            $.messager.alert("Info", 'Please try again');
                        }
                        else {
                            window.location.reload();
                        }
                        //$.messager.alert("Info", result == true ? 'Saved Successfully' : 'Please try again');
                        //window.location.reload();
                    }
                    else {
                        if (strPlusBtn == "N")
                            window.location.href = 'PatientEntry';
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });
        }

        function BindReport(result) {
            var colnames = "";
            var colmodel = "";
            var footerrow = false;
            colnames = ['Code', 'ICD Diag. Name'];
            colmodel = [
                   { index: 'CODE', name: 'CODE', width: 10, sortable: true, resizable: false, hidden: true },
                   { index: 'NAME', name: 'NAME', width: 830, sortable: true, resizable: false, sorttype: 'number' }];
            $("#gvtable").jqGrid('GridUnload');
            jQuery("#gvtable").jqGrid({
                colNames: colnames,
                colModel: colmodel,
                data: result,
                datatype: 'local',
                sortorder: "desc",
                rownumbers: false,
                shrinkToFit: false,
                forceFit: true,
                loadtext: "Loading...",
                hidegrid: false,
                cellEdit: false,
                loadonce: true,
                sortable: true,
                ignoreCase: true,
                rowNum: 100000,
                width: 830,
                height: 500,
                viewrecords: true,
                footerrow: footerrow,
                rowattr: function (rd) {
                    return { "class": "column-title" }
                },
                beforeRequest: function () {
                    responsive_jqgrid($('.jqGrid'));
                },
                gridComplete: function () {

                },
                onSelectRow: function (selRowId) {
                    var rowData = $("#gvtable").jqGrid("getRowData", selRowId);
                    var code = "";
                    var id = (rowData.CODE)
                    var rows = "<tr class='clickable-row display active'  id='" + id + "'>" + "<td style='padding:5px;width:100%; text-align:left;font-size: 13px;'>" + rowData.NAME + "</td>" +
                        "</tr>";
                    var row = $('#tblICDdiagno tr#' + id).get();
                    if (row.length <= 0) {
                        $('#tblICDdiagno tbody').prepend(rows);
                    }
                    $("#closebtn").click();
                }
            });
            $("#gvtable").jqGrid('bindKeys');
            jQuery('#gvtable').closest('.ui-jqgrid-view')
        .find(".ui-jqgrid-htable .ui-search-toolbar .ui-th-column")
        .find("input, select")
        .focus(function (e) {
            var $header = $(e.target).closest('.ui-jqgrid-hdiv'),
                $body = $header.siblings('.ui-jqgrid-bdiv');
            setTimeout(function () {
                $body[0].scrollLeft = $header[0].scrollLeft;
            }, 0);
        });
        }

        function responsive_jqgrid(jqgrid) {
            jqgrid.find('.ui-jqgrid').addClass('clear-margin span12').css('width', '');
            jqgrid.find('.ui-jqgrid-view').addClass('clear-margin span12').css('width', '');
            jqgrid.find('.ui-jqgrid-view > div').eq(1).addClass('clear-margin span12').css('width', '').css('min-height', '0');
            jqgrid.find('.ui-jqgrid-view > div').eq(2).addClass('clear-margin span12').css('width', '').css('min-height', '0');
            jqgrid.find('.ui-jqgrid-sdiv').addClass('clear-margin span12').css('width', '');
            jqgrid.find('.ui-jqgrid-pager').addClass('clear-margin span12').css('width', '');
        }
        jQuery(document).ready(function ($) {
            if (window.history && window.history.pushState) {
                window.history.pushState('forward', null, './Diagnosis');
                $(window).on('popstate', function () {
                    SaveDiagnosis("N");
                });

            }
        });

        function getDiagnoListFrmDB(filter, obj) {
            var strClinincode = $.session.get('ClinicCode').toString().trim();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetNonFregqentDiagnoList","DoctorDesk")%>",
                data: { NonFreqDiagno: filter, strClinincode: strClinincode },
                asycn: false,
                success: function (response) {
                    if (response != "") {
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            var MatchElement = jQuery.grep(obj, function (element, index) {
                                Name = $(element)[0].cells[0].innerText.split("-")[0];
                                return ((result.Table1[i].NAME).toString().trim() == Name.toString().trim());
                            });
                            if (MatchElement.length > 0) {
                            }
                            else {
                                var rows = "<tr class='clickable-row' id='" + result.Table1[i].CODE + "'>" + "<td style='padding:5px; width:90%   font-size: 13px;text-align:left;' class='DiagnoNm'>" + result.Table1[i].NAME.trim() + "</td>" +
                                  "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                   "<td class='tdSetUpYn' style='display:none;'></td>" +
                                        "<td class='RemarkText' style='display:none;'></td>" +
                                  "</tr>";
                                $('#tbldiagno tbody').append(rows).closest('tr');
                            }
                        }
                    }
                },
                complete: function () {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function CreateICDDiagSetupList() {
            $.confirm({
                title: 'ICD Diagnosis Setup',
                theme: 'supervan',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                content: '' +
                 '<form action="" class="formName" style="height:410px;"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:-16px" class="form-control" id="ICDDiagnosisSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtICDDiagSetup" type="text" id="input-name" placeholder="Search Setup" class="form-control" onkeyup="SearchICDDiagnosisSetUpList()" style="" autofocus></td></tr></table></div>' +
                '<div id="divtblICDDiagnosisSetup" class="divtblICDDiagnosisSetup" style=""><table id="tblPersICDDiagnolist" style="width:100%;border-top:1px solid #29884bd6 !important;" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {
                    Add: {
                        text: '<i class="fa fa-plus-circle"></i>',
                        action: function () {
                            stringcode = '';
                            SetupNameICDDiagText = '';
                            var row = $('#tblPersICDDiagnolist tr')
                            for (r = 0; r < row.length; r++) {
                                var Chk = $(row[r]).find('.chkPersDis')
                                if (Chk[0].checked) {
                                    stringcode += $(row[r]).attr('id') + ','
                                    SetupNameICDDiagText += $(row[r]).text().trim() + ','
                                }
                            }
                            var strSetUpCode = stringcode.substr(0, stringcode.length - 1);
                            var strSetUpCode = strSetUpCode;
                            var strIcdDiagSetupName = SetupNameICDDiagText.substr(0, SetupNameICDDiagText.length - 1);
                            var strIcdDiagSetupName = strIcdDiagSetupName;
                            ApendICDDiagData(strSetUpCode, strIcdDiagSetupName);
                        }
                    },
                    formSubmit: {
                        text: '<i class="fa fa-check-circle-o"></i>',
                        btnClass: 'btn-default',
                        action: function () {
                            stringcode = '';
                            var row = $('#tblPersICDDiagnolist tr')
                            for (r = 0; r < row.length; r++) {
                                var Chk = $(row[r]).find('.chkPersDis')
                                if (Chk[0].checked) {
                                    stringcode += "'" + $(row[r]).attr('id') + "'" + ','
                                }
                            }
                            var codeT = stringcode.slice(1)
                            var strCode = codeT.substr(0, codeT.length - 2);
                            //debugger;
                            SavePersICDDiagnosisList(strCode);
                        }
                    },
                    Closed: {
                        text: '<i class="fa fa-close "></i>',
                        btnClass: 'btn-default',
                    },
                },
                onOpen: function () {
                    $('jconfirm-box').css('margin-top', '10px !important;')
                },
                onContentReady: function () {
                    GetpersonalisedICDDiagList();
                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    var defaultbtn = $('.jconfirm-buttons>button');
                    $.each(defaultbtn, function (index, val) {
                        $(defaultbtn[index]).css('font-size', '35px');
                        $(defaultbtn[index]).css('margin-right', '10px');
                    })
                    $(defaultbtn[0]).attr('id', 'btnSubmit');
                    $(defaultbtn[0]).addClass('disable-clicks');
                    $(defaultbtn[2]).attr('id', 'btnAdd');
                    $('.jc-bs3-row').removeClass('row')
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1')
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    $('.jconfirm-bg').css('background-color', 'rgba(255, 255, 255, 0.62)');
                    $('.jconfirm-box').css('background-color', 'rgba(43, 43, 60, 0.98)');
                    $('.jconfirm-box').css('box-shadow', '#868686 0px -1px 14px 4px');
                }
            });
        }

        function SearchICDDiagnosisSetUpList() {
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("txtICDDiagSetup");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblPersICDDiagnolist");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.ICDDiagnosisName")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";

                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        $(document.body).on('click', '#ICDDiagnosisSetUpAdd', function (e) {
            ICDDiagnosisSetUpAddEdit(this);

        });

        function ICDDiagnosisSetUpAddEdit(obj) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">ICD Diagnosis SetUp</label>' +
                 '<input  type="varchar" id="txtICDDiagSetUp" maxlength="50"  placeholder="Enter SetUp Name" autofocus="autofocus" class="setUp form-control" required />' +
                '<br><input id="txtIcdDiagServiceGrpsearch" type="varchar" style="" placeholder="Search For Freq Diagnosis"  class="form-control" onkeyup="SearchICDDiagServiceGroup()" />' +
                '<div id="divIcdDiagSrvcGrpSelect" style="border:1px solid gray;" ></div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var setUp = this.$content.find('.setUp').val();
                            var grpCode = "";
                            if (setUp == "") {
                                $.alert('Enter SetUp Name');
                                return false;
                            }
                            var chlBoxValLst = null;
                            chlBoxValLst = [];
                            $('#dblServiceHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxValLst.push($(this).attr('value'));
                            });
                            var strICDDiagArry = chlBoxValLst.join(",");
                            if (strICDDiagArry == "") {
                                $.alert('Select at least one test ');
                                return false;
                            }
                            var chlBoxTitleLst = null;
                            chlBoxTitleLst = [];
                            $('#dblServiceHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxTitleLst.push($(this).attr('title'));
                            });
                            var strICDDiagArry2 = chlBoxTitleLst.join(",");
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil")) {
                                strSetUpCode = $(obj).parents("tr")[0].id;
                            }
                            if (setUp != "") {
                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: '../DoctorDesk/AddICDDiagnosisSetUp',
                                    data: { strICDDiagnSetUpName: setUp, strICDDiagnLst: strICDDiagArry, strICDDiagNameLst: strICDDiagArry2, strICDDiagSetUpCode: strSetUpCode },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtICDDiagSetUp").val("");
                                            $("#txtICDDiagSetup").val("");
                                            $.alert('Record inserted successfully');
                                            GetpersonalisedICDDiagList();
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {
                                            $.alert("This Set Up is already Present.");
                                        }
                                        else {
                                            $.alert("Error!!Please Contact IT Dept");
                                        }
                                    },
                                });
                            }
                            else {
                                $.messager.alert("Information", "Please select at least one test");
                            }
                        }
                    },
                    close: function () {
                    },
                },
                onContentReady: function () {
                    if ($(obj).hasClass("fa fa-pencil")) {
                        $('#txtICDDiagSetUp').val($(obj).parents('td').prev().text());
                    }
                    else {
                        $('#txtICDDiagSetUp').focus();
                        $('#txtICDDiagSetUp').val("");
                    }
                    ICDDiagnosisSerivceGrpData(srvcgrpname);
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectedSetUpsICDDiagno($(obj).parents('tr')[0].id);
                    }
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    $(".jconfirm-box-container").last().css('width', '480px');
                }
            });

        }

        function SearchICDDiagServiceGroup() {
            input = document.getElementById("txtIcdDiagServiceGrpsearch");
            filter = input.value.toUpperCase();
            var elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent();
            var search = false;
            search = $(elem).hasClass('display');
            if ($(input).val().length >= 3) {
                getNonFrequentICDDiagList(filter);
            } else {
                elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent().parent().remove();
                var checdelem = $("#SrvcGrpdata li input[type='checkbox']:checked").parent();
                $.each(checdelem, function (j, item) {
                    var label = checdelem[j].getElementsByTagName("input")[0];
                    if (label)
                        FreqDataSetupList = FreqDataSetupList.filter(function (e, index) {
                            return FreqDataSetupList[index]["CODE"].toString().trim() != label.defaultValue.toString().trim();
                        });
                });
                $.each(FreqDataSetupList, function (i, item) {
                    var title = item.NAME;
                    var idstring = item.CODE;
                    $("#SrvcGrpdata").append("<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + idstring + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>");
                });
            }
            var elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent();
            for (i = 0; i < elem.length; i++) {
                $(elem[i]).removeClass('display');
                label = elem[i].getElementsByTagName("input")[0];
                if (label) {
                    if (label.title.toUpperCase().indexOf(filter) > -1) {
                        elem[i].style.display = "";
                        if (!$(elem[i]).hasClass('display')) {
                            $(elem[i]).addClass('display')
                        }
                    } else {
                        elem[i].style.display = "none";
                    }
                }
            }
        }

        function ICDDiagnosisSerivceGrpData(srvcgrpname) {
            var $newDiv = $('<div>');
            $newDiv.attr("id", srvcgrpname);
            $newDiv.attr("name", srvcgrpname);
            $newDiv.addClass("searchdivclass");
            $newDiv.css('height', '300px');
            $newDiv.css('margin-left', '0px');
            $newDiv.css('overflow', 'auto');
            $newDiv.css('display', 'none');
            $newDiv.css('border-color', '#f47b02;');
            $newDiv.css(' border-style', 'solid');
            $newDiv.css('background', 'azure')
            var $newul = $('<ul>');
            $newul.attr("id", "SrvcGrpdata");
            $newul.addClass("searchlistclass");
            var options = "";
            var abc = "<a id=btnsrvgrp style=color:blue;cursor:pointer float:right;>ClearSelection</a>"
            var i = 0;
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetICDDiagnoList","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {
                    FreqDataSetupList = response;
                    if (response != "") {
                        $.each(response, function (i, item) {
                            var title = item.NAME;
                            var idstring = item.CODE;
                            options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.CODE + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>";
                        });
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },

            });
            $newul.append(abc);
            $newul.append(options);
            $newDiv.append($newul);
            $('#divIcdDiagSrvcGrpSelect').append($newDiv);
        }

        $(document.body).on('click', '#dblServiceHelpsrvcgrp li input', function (e) {
            if (e.currentTarget.checked === true) {
                $(this).parent().parent().remove();
                var element = $("#dblServiceHelpsrvcgrp li input:checkbox:checked");
                $($(this).parent().parent()).insertAfter('a[id="btnsrvgrp"]');
                $(this).focus();
            }
            $("#dblServiceHelpsrvcgrp").show();
            $("#txtIcdDiagServiceGrpsearch").val("").trigger("keyup");
            e.stopPropagation();
        });

        $(document.body).on({
            'click': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
            },
            'focus': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
            },
        }, '#txtIcdDiagServiceGrpsearch');

        $(document.body).on('click', '#btnsrvgrp', function (e) {
            $('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);
        });

        function handleChange(obj) {
            var parentRow = $(obj).parent().parent();
            $('#tblPersICDDiagnolist tbody').prepend(parentRow).closest('tr');
            $('table tr:nth-child(1)').find('input:first').focus();
            CountCheckBoxChecked();
        }

        function CountCheckBoxChecked() {
            var CheckBoxCount = $('.chkPersDis:checked').size();
            if (CheckBoxCount > 0) {
                $('#btnSubmit').removeClass('disable-clicks');
            }
            else {
                $('#btnSubmit').addClass('disable-clicks');
            }
        }

        function getNonFrequentICDDiagList(filter) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                datatype: "json",
                url: "<%=Url.Action("GetNonFregqentICDDiagnosisList","DoctorDesk")%>",
                data: { NonFreqICD: filter },
                asycn: false,
                success: function (response) {
                    NonFreqDataSetupList = response;
                    var result = response;
                    var options = "";
                    $.each(result, function (i, item) {
                        var title = item.NAME;
                        var idstring = item.CODE;
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.CODE + "'>" + title + "</label><li>";
                    });
                    $("ul#SrvcGrpdata").append(options);
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function FillSelectedSetUpsICDDiagno(strSetUpCode) {
            HoldOn.open();
            $.ajax({
                url: '../DoctorDesk/GetICDDiagnoListBySetupCode',
                data: { strSetUpCode: strSetUpCode },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    console.log(response);
                    if (response != "") {
                        $.each(response, function (i, val) {
                            if (val["CODE"] != "") {
                                var checkboxSelectorForIcd = "#dblServiceHelpsrvcgrp li input[value='" + val["CODE"] + "']";
                                if ($(checkboxSelectorForIcd).length === 0) {
                                    var element = "<li><label><input type='checkbox' id='' title='" + val["NAME"] + "' value='" + val["CODE"] + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label></li>";
                                    $(element).insertAfter('a[id="btnsrvgrp"]');
                                    $("#dblServiceHelpsrvcgrp li input#" + val["CODE"]).trigger("click");
                                }
                                else {
                                    var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["NAME"] + "' value='" + val["CODE"] + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label><li>";
                                    $(elemnet).insertAfter('a[id="btnsrvgrp"]');
                                }
                            }
                            else {
                                var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["NAME"] + "' value='" + val["CODE"] + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label><li>";
                                $(elemnet).insertAfter('a[id="btnsrvgrp"]');
                            }
                        });
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            })
        }

        function GetpersonalisedICDDiagList() {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersICDDiagnoList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "" && response != "UNSUCCESSFULL") {
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);'></td><td class='ICDDiagnosisName' style='padding:5px;font-size: 13px;vertical-align:middle;width:80%' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='ICDDiagnosisSetUpAddEdit(this);'></i></span></td>";
                            rows += "</tr>";
                        }
                        $('#tblPersICDDiagnolist tbody').empty();
                        $('#tblPersICDDiagnolist tbody').append(rows).closest('tr');
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
                },
            });
        }

        function SavePersICDDiagnosisList(strCode) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/SavePersonICDDiagnosis',
                datatype: "json",
                aysc: false,
                data: { Code: strCode, strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                success: function (result) {
                    if (result.length > 0) {
                        if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            var activeTab = sessionStorage.getItem('activeTab');
                            if (activeTab) {
                                sessionStorage.setItem('activeTab', activeTab);
                            }
                            window.location.reload();
                        }
                        else if (("" + result).toUpperCase().indexOf("FAILED") != -1) {
                            $.alert({
                                title: 'Transaction Failed!',
                                animation: 'scale',
                                closeAnimation: 'scale',
                                buttons: {
                                    okay: {
                                        text: 'Okay',
                                        btnClass: 'btn-blue'
                                    }
                                }
                            });
                        }
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }

            });
        }

        $(document).on('click', '.clickable-row', function () {
            var rowId = $(this).attr('id');
            var rowName = $(this).find('td').text();
            console.log('Clicked Row:', rowId, rowName);
            var $row = $(this).closest('tr');
            if ($row.hasClass('active')) {
                var selRows = $('#tblICDdiagno > tbody > tr.active').get();
                if (selRows.length === 1) {
                    $("#tblICDdiagno tbody").prepend($row);
                } else {
                    $.each(selRows, function (index, row) {
                        $(row).detach().prependTo('#tblICDdiagno tbody');
                    });
                }
            }
        });

        function ApendICDDiagData(strSetUpCode, strIcdDiagSetupName) {
            var splitsetupcode = strSetUpCode.split(',');
            var spliticdsetupname = strIcdDiagSetupName.split(',');
            var alreadyAddedSetupCodes = [];
            $.each(splitsetupcode, function (index, strSetUpCode) {
                strSetUpCode = strSetUpCode.trim();
                var currentICDDiagSetupName = spliticdsetupname[index].trim();
                if (addedIcdSetupCodes.indexOf(strSetUpCode) === -1) {
                    $.ajax({
                        type: "POST",
                        url: '../DoctorDesk/GetICDDiagnoListBySetupCode',
                        data: { strSetUpCode: strSetUpCode },
                        datatype: 'get',
                        async: true,
                        success: function (response) {
                            var rows = "";
                            addedIcdSetupCodes.push(strSetUpCode);
                            MapICDDiagSetupCodes.set(strSetUpCode, currentICDDiagSetupName);
                            $.each(response, function (i, item) {
                                if ($("#" + item.CODE.trim()).length === 0) {
                                    var row = "<tr class='clickable-row' id='" + item.CODE.trim() + "'>" +
                                           "<td style='padding:5px;text-align:left;width:100%; font-size: 13px; color:#de4a04'>" + item.NAME + "</td>" +
                                           "</tr>";

                                    $('#tblICDdiagno tbody').prepend(row);
                                }
                                else {
                                    var existingRow = $("#" + item.CODE);
                                    existingRow.detach();
                                    existingRow.find('td').css('color', '#de4a04')
                                    $('#tblICDdiagno tbody').prepend(existingRow);
                                }
                                moveICDDiagnosisActiveRowsToTop();
                            });
                        },
                        complete: function () {
                        }
                        , error: function (XMLHttpRequest, textStatus, errorThrown) {
                            HoldOn.close();
                            $.messager.alert("Error", errorThrown);
                        }
                    });
                }
                else {
                    var existingSetupName = MapICDDiagSetupCodes.get(strSetUpCode);
                    alreadyAddedSetupCodes.push(existingSetupName);
                }
            });
            if (alreadyAddedSetupCodes.length > 0) {
                var message = "The following setups have already been added:\n" + alreadyAddedSetupCodes.join(", ");
                $.messager.alert("Setup Already Added", message);
            }
        }

        function CreateDiagnosisSetupList() {
            $.confirm({
                title: 'Diagnosis Setup',
                theme: 'supervan',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                content: '' +
                 '<form action="" class="formName" style="height:410px;"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:-16px" class="form-control" id="DiagnosisSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtDiagSetup" type="text" id="input-name" placeholder="Search Setup" class="form-control" onkeyup="SearchDiagnosisSetUpList()" style="" autofocus></td></tr></table></div>' +
                '<div id="divtblDiagnosisSetup" class="divtblDiagnosisSetup" style=""><table id="tblPersDiagnolist" style="width:100%;border-top:1px solid #29884bd6 !important;" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {
                    Add: {
                        text: '<i class="fa fa-plus-circle"></i>',
                        action: function () {
                            stringcode = '';
                            SetupNameDiagText = '';
                            var row = $('#tblPersDiagnolist tr')
                            for (r = 0; r < row.length; r++) {
                                var Chk = $(row[r]).find('.chkPersDis')
                                if (Chk[0].checked) {
                                    stringcode += $(row[r]).attr('id') + ','
                                    SetupNameDiagText += $(row[r]).text().trim() + ','
                                    console.log(SetupNameDiagText);
                                }
                            }
                            var strSetUpCode = stringcode.substr(0, stringcode.length - 1);
                            var strSetUpCode = strSetUpCode;
                            var strDiagSetupName = SetupNameDiagText.substr(0, SetupNameDiagText.length - 1);
                            var strDiagSetupName = strDiagSetupName;
                            ApendDiagData(strSetUpCode, strDiagSetupName);
                        }
                    },
                    formSubmit: {
                        text: '<i class="fa fa-check-circle-o"></i>',
                        btnClass: 'btn-default',
                        action: function () {
                            stringcode = '';
                            var row = $('#tblPersDiagnolist tr')
                            for (r = 0; r < row.length; r++) {
                                var Chk = $(row[r]).find('.chkPersDis')
                                if (Chk[0].checked) {
                                    stringcode += "'" + $(row[r]).attr('id') + "'" + ','
                                }
                            }
                            var codeT = stringcode.slice(1)
                            var strCode = codeT.substr(0, codeT.length - 2);
                            SavePersDiagnosisList(strCode);
                        }
                    },
                    Closed: {
                        text: '<i class="fa fa-close "></i>',
                        btnClass: 'btn-default',
                    },
                },

                onOpen: function () {
                    $('jconfirm-box').css('margin-top', '10px !important;')
                },
                onContentReady: function () {
                    GetpersonalisedDiagList();
                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    var defaultbtn = $('.jconfirm-buttons>button');
                    $.each(defaultbtn, function (index, val) {
                        $(defaultbtn[index]).css('font-size', '35px');
                        $(defaultbtn[index]).css('margin-right', '10px');
                    })
                    $(defaultbtn[0]).attr('id', 'btnSubmit');
                    $(defaultbtn[0]).addClass('disable-clicks');
                    $(defaultbtn[2]).attr('id', 'btnAdd');
                    $('.jc-bs3-row').removeClass('row')
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1')
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    $('.jconfirm-bg').css('background-color', 'rgba(255, 255, 255, 0.62)');
                    $('.jconfirm-box').css('background-color', 'rgba(43, 43, 60, 0.98)');
                    $('.jconfirm-box').css('box-shadow', '#868686 0px -1px 14px 4px');
                }
            });
        }

        $(document.body).on('click', '#DiagnosisSetUpAdd', function (e) {
            DiagnosisSetUpAddEdit(this);
        });

        function DiagnosisSetUpAddEdit(obj) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">Diagnosis SetUp</label>' +
                 '<input  type="varchar" id="txtDiagSetUp" maxlength="50"  placeholder="Enter SetUp Name" autofocus="autofocus" class="setUp form-control" required />' +
                '<br><input id="txtDiagServiceGrpsearch" type="varchar" style="" placeholder="Search For Diagnosis"  class="form-control" onkeyup="SearchDiagServiceGroup()" />' +
                '<div id="divDiagSrvcGrpSelect" style="border:1px solid gray;" ></div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var setUp = this.$content.find('.setUp').val();
                            var grpCode = "";
                            if (setUp == "") {
                                $.alert('Enter SetUp Name');
                                return false;
                            }
                            var chlBoxValLst = null;
                            chlBoxValLst = [];
                            $('#dblServiceDiagHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxValLst.push($(this).attr('value'));
                            });
                            var strDiagArry = chlBoxValLst.join(",");
                            if (strDiagArry == "") {
                                $.alert('Select at least one test ');
                                return false;
                            }
                            var chlBoxTitleLst = null;
                            chlBoxTitleLst = [];
                            $('#dblServiceDiagHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxTitleLst.push($(this).attr('title'));
                            });
                            var strDiagArry2 = chlBoxTitleLst.join(",");
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil")) {
                                strSetUpCode = $(obj).parents("tr")[0].id;
                            }
                            if (setUp != "") {
                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: '../DoctorDesk/AddDiagnosisSetUp',
                                    data: { strDiagnSetUpName: setUp, strDiagnLst: strDiagArry, strDiagNameLst: strDiagArry2, strDiagSetUpCode: strSetUpCode },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtDiagSetUp").val("");
                                            $("#txtDiagSetup").val("");
                                            $.alert('Record inserted successfully');
                                            GetpersonalisedDiagList();
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {
                                            $.alert("This Set Up is already Present.");
                                        }
                                        else {
                                            $.alert("Error!!Please Contact IT Dept");
                                        }
                                    },
                                });
                            }
                            else {
                                $.messager.alert("Information", "Please select at least one test");
                            }
                        }
                    },
                    close: function () {
                    },
                },
                onContentReady: function () {
                    if ($(obj).hasClass("fa fa-pencil")) {
                        $('#txtDiagSetUp').val($(obj).parents('td').prev().text());
                    }
                    else {
                        $('#txtDiagSetUp').focus();
                        $('#txtDiagSetUp').val("");
                    }
                    DiagnosisSerivceGrpData(srvcdiaggrpname);
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectedSetUpsDiagnosis($(obj).parents('tr')[0].id);
                    }
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    $(".jconfirm-box-container").last().css('width', '480px');
                }
            });

        }

        function DiagnosisSerivceGrpData(srvcdiaggrpname) {
            var $newDiv = $('<div>');
            $newDiv.attr("id", srvcdiaggrpname);
            $newDiv.attr("name", srvcdiaggrpname);
            $newDiv.addClass("searchdivclass");
            $newDiv.css('height', '300px');
            $newDiv.css('margin-left', '0px');
            $newDiv.css('overflow', 'auto');
            $newDiv.css('display', 'none');
            $newDiv.css('border-color', '#f47b02;');
            $newDiv.css(' border-style', 'solid');
            $newDiv.css('background', 'azure')
            var $newul = $('<ul>');
            $newul.attr("id", "DiagSrvcGrpdata");
            $newul.addClass("searchlistclass");
            var options = "";
            var abc = "<a id=btnDiagsrvgrp style=color:blue;cursor:pointer float:right;>ClearSelection</a>"
            var i = 0;
            var strClinincode = $.session.get('ClinicCode').toString().trim();
            var DataToSend = {
                ClinicCode: strClinincode
            };
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetMainDiagnoList","DoctorDesk")%>",
                data: DataToSend,
                async: false,
                success: function (response) {
                    FreqDataSetupList = response;
                    if (response != "") {
                        $.each(response, function (i, item) {
                            var title = item.DESC;
                            var idstring = item.DESCCD;
                            options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.DESCCD + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>";
                        });
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
            });
            $newul.append(abc);
            $newul.append(options);
            $newDiv.append($newul);
            $('#divDiagSrvcGrpSelect').append($newDiv);
        }

        $(document.body).on('click', '#dblServiceDiagHelpsrvcgrp li input', function (e) {
            if (e.currentTarget.checked === true) {
                $(this).parent().parent().remove();
                var element = $("#dblServiceDiagHelpsrvcgrp li input:checkbox:checked");
                $($(this).parent().parent()).insertAfter('a[id="btnDiagsrvgrp"]');
                $(this).focus();
            }
            $("#dblServiceDiagHelpsrvcgrp").show();
            $("#txtDiagServiceGrpsearch").val("").trigger("keyup");
            e.stopPropagation();
        });

        $(document.body).on({
            'click': function (e) {
                $("#dblServiceDiagHelpsrvcgrp").show();
            },
            'focus': function (e) {
                $("#dblServiceDiagHelpsrvcgrp").show();
            },
        }, '#txtDiagServiceGrpsearch');

        $(document.body).on('click', '#btnDiagsrvgrp', function (e) {
            $('#dblServiceDiagHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);
        });

        function SearchDiagServiceGroup() {
            input = document.getElementById("txtDiagServiceGrpsearch");
            filter = input.value.toUpperCase();
            var elem = $("#DiagSrvcGrpdata li input[type='checkbox']").not(":checked").parent();
            var search = false;
            search = $(elem).hasClass('display');
            if ($(input).val().length >= 3) {
                getDiagListForSearchInDiagSetup(filter);
            } else {
                elem = $("#DiagSrvcGrpdata li input[type='checkbox']").not(":checked").parent().parent().remove();
                var checdelem = $("#DiagSrvcGrpdata li input[type='checkbox']:checked").parent();
                $.each(checdelem, function (j, item) {
                    var label = checdelem[j].getElementsByTagName("input")[0];
                    if (label)
                        FreqDataSetupList = FreqDataSetupList.filter(function (e, index) {
                            return FreqDataSetupList[index]["DESCCD"].toString().trim() != label.defaultValue.toString().trim();
                        });
                });
                $.each(FreqDataSetupList, function (i, item) {
                    var title = item.DESC;
                    var idstring = item.DESCCD;
                    $("#DiagSrvcGrpdata").append("<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + idstring + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>");
                });
            }
            var elem = $("#DiagSrvcGrpdata li input[type='checkbox']").not(":checked").parent();
            for (i = 0; i < elem.length; i++) {
                $(elem[i]).removeClass('display');
                label = elem[i].getElementsByTagName("input")[0];
                if (label) {
                    if (label.title.toUpperCase().indexOf(filter) > -1) {
                        elem[i].style.display = "";
                        if (!$(elem[i]).hasClass('display')) {
                            $(elem[i]).addClass('display')
                        }
                    } else {
                        elem[i].style.display = "none";
                    }
                }
            }
        }

        function getDiagListForSearchInDiagSetup(filter) {
            var ClinicCode = $.session.get('ClinicCode').toString().trim();
            HoldOn.open();
            $.ajax({
                type: "POST",
                datatype: "json",
                url: "<%=Url.Action("GetNonFregqentDiagnosisListForDiagSetup","DoctorDesk")%>",
                data: { NonFreqDiagno: filter, strClinincode: ClinicCode },
                asycn: false,
                success: function (response) {
                    NonFreqDataSetupList = response;
                    var result = response;
                    var options = "";
                    $.each(result, function (i, item) {
                        var title = item.NAME;
                        var idstring = item.CODE;
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.CODE + "'>" + title + "</label><li>";
                    });
                    $("ul#DiagSrvcGrpdata").append(options);
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });

        }

        function GetpersonalisedDiagList() {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersDiagnoList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "" && response != "UNSUCCESSFULL") {
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChangeDiagSetup(this);'></td><td class='DiagnosisName' style='padding:5px;font-size: 13px;vertical-align:middle;width:80%' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='DiagnosisSetUpAddEdit(this);'></i></span></td>";
                            rows += "</tr>";
                        }
                        $('#tblPersDiagnolist tbody').empty();
                        $('#tblPersDiagnolist tbody').append(rows).closest('tr');
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
                },
            });
        }

        function FillSelectedSetUpsDiagnosis(strSetUpCode) {
            HoldOn.open();
            $.ajax({
                url: '../DoctorDesk/GetDiagnosisListBySetupCode',
                data: { strSetUpCode: strSetUpCode },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    console.log(response);
                    if (response != "") {
                        $.each(response, function (i, val) {
                            if (val["CODE"] != "") {
                                var checkboxSelector = "#dblServiceDiagHelpsrvcgrp li input[value='" + val["CODE"] + "']";
                                if ($(checkboxSelector).length === 0) {
                                    var element = "<li><label><input type='checkbox' id='' title='" + val["NAME"] + "' value='" + val["CODE"] + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label></li>";
                                    $(element).insertAfter('a[id="btnDiagsrvgrp"]');
                                    $("#dblServiceDiagHelpsrvcgrp li input#" + val["CODE"]).trigger("click");
                                }
                                else {
                                    var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["NAME"] + "' value='" + val["CODE"] + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label><li>";
                                    $(elemnet).insertAfter('a[id="btnDiagsrvgrp"]');
                                }
                            }
                            else {
                                var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["NAME"] + "' value='" + val["CODE"] + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label><li>";
                                $(elemnet).insertAfter('a[id="btnDiagsrvgrp"]');
                            }
                        });
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            })
        }

        function handleChangeDiagSetup(obj) {
            var parentRow = $(obj).parent().parent();
            $('#tblPersDiagnolist tbody').prepend(parentRow).closest('tr');
            $('table tr:nth-child(1)').find('input:first').focus();
            CountCheckBoxChecked();
        }

        function SavePersDiagnosisList(strCode) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/SavePersonDiagnosisSetup',
                datatype: "json",
                aysc: false,
                data: { Code: strCode, strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                success: function (result) {
                    if (result.length > 0) {
                        if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            window.location.reload();
                        }
                        else if (("" + result).toUpperCase().indexOf("FAILED") != -1) {
                            $.alert({
                                title: 'Transaction Failed!',
                                animation: 'scale',
                                closeAnimation: 'scale',
                                buttons: {
                                    okay: {
                                        text: 'Okay',
                                        btnClass: 'btn-blue'
                                    }
                                }
                            });
                        }
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function ApendDiagData(strSetUpCode, strDiagSetupName) {
            var setupname = $("#txtDiagSetUp").val();
            var splitsetupcode = strSetUpCode.split(',');
            var splitsetupname = strDiagSetupName.split(',');
            var alreadyAddedDiagSetupCodes = [];
            $.each(splitsetupcode, function (index, strSetUpCode) {
                strSetUpCode = strSetUpCode.trim();
                var currentDiagSetupName = splitsetupname[index].trim();
                if (addedDiagSetupCodes.indexOf(strSetUpCode) === -1) {
                    $.ajax({
                        type: "POST",
                        url: '../DoctorDesk/GetDiagnosisListBySetupCode',
                        data: { strSetUpCode: strSetUpCode },
                        datatype: 'get',
                        async: true,
                        success: function (response) {
                            var rows = "";
                            NonFreqDataSetupList = response;
                            addedDiagSetupCodes.push(strSetUpCode);
                            MapDiagSetupCodes.set(strSetUpCode, currentDiagSetupName);
                            $.each(response, function (i, item) {
                                if ($("#" + item.CODE.trim()).length === 0) {
                                    var row = "<tr class='clickable-row' id='" + item.CODE.trim() + "'>" +
                                              "<td style='padding:5px; width:90%; font-size: 13px; text-align:left; color:#de4a04;' class='DiagnoNm'>" + item.NAME.trim() + "</td>" +
                                              "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                              "<td class='tdSetUpYn' style='display:none;'></td>" +
                                              "<td class='RemarkText' style='display:none;'></td>" +
                                              "</tr>";
                                    $('#tbldiagno tbody').prepend(row);
                                }
                                else {
                                    var existingRow = $("#" + item.CODE);
                                    existingRow.detach();
                                    existingRow.find('td').css('color', '#de4a04')
                                    $('#tbldiagno tbody').prepend(existingRow);
                                }
                                moveDiagnosisActiveRowsToTop();
                            });
                        },
                        complete: function () {

                        }
                        , error: function (XMLHttpRequest, textStatus, errorThrown) {
                            HoldOn.close();
                            $.messager.alert("Error", errorThrown);
                        }
                    });
                }
                else {
                    var existingSetupName = MapDiagSetupCodes.get(strSetUpCode);
                    alreadyAddedDiagSetupCodes.push(existingSetupName);
                }
            });
            if (alreadyAddedDiagSetupCodes.length > 0) {
                var message = "The following setups have already been added:\n" + alreadyAddedDiagSetupCodes.join(", ");
                $.messager.alert("Setup Already Added", message);
            }
        }

        function moveDiagnosisActiveRowsToTop() {
            var activeRows = $('#tbldiagno tbody tr.active').get();
            if (activeRows.length > 0) {
                $(activeRows).each(function () {
                    $(this).detach().prependTo('#tbldiagno tbody');
                });
            }
        }

        function moveICDDiagnosisActiveRowsToTop() {
            var activeRows = $('#tblICDdiagno tbody tr.active').get();
            if (activeRows.length > 0) {
                $(activeRows).each(function () {
                    $(this).detach().prependTo('#tblICDdiagno tbody');
                });
            }
        }

        function SearchDiagnosisSetUpList() {
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("txtDiagSetup");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblPersDiagnolist");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.DiagnosisName")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }

        }
    </script>

    <%-- ICD O Style --%>
    <style>
        .SiteHeaderDiv {
            padding: 0px;
            background-color: #034c7d;
            color: white;
        }

        .SiteHeaderLbl {
            margin: 0;
            padding: 5px 5px;
            font-size: 15px;
        }

        .SiteContentDiv {
            padding: 0px;
            display: block;
            height: -webkit-fill-available;
            margin-bottom: 10px;
        }

        .SiteTopoSrchDiv {
            padding: 0px;
            background-color: #ffffff;
        }

        .SiteTopoSrchTxt {
            margin-bottom: 10px;
            float: left;
            height: 28px;
            border-radius: 5px;
            border-color: rgba(51, 122, 183, 0.55);
            -webkit-box-shadow: 0 8px 6px -6px black;
            -moz-box-shadow: 0 8px 6px -6px black;
            box-shadow: 0 7px 4px -6px rgb(181, 181, 181);
            margin-top: 4px;
            width: 100%;
        }

        .TopoContentDiv {
        }

        .MainHistoTNMDiv {
            padding: 0px;
            background-color: #ffffff;
            border: 1px solid #719b76;
            display: flex;
            flex-direction: column;
            margin-top: 10px;
        }

        .TopoHistHeaderDiv {
            padding: 5px;
            background-color: #95cf9b;
            color: black;
            font-size: 13px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .TopoHistHeaderLbl {
            margin: 0px;
        }

        .DelTopoIcon {
            font-size: 20px;
            margin-right: 10px;
            cursor: pointer;
            color: #b30000;
        }

        .TNMInfoIcon {
            font-size: 20px;
            margin-right: 10px;
            cursor: pointer;
            color: #0059ff;
        }

        .MainHistoContentTNMDiv {
            padding: 0px;
        }

        .TopoHistSrchDiv {
            padding: 0px;
        }

        .TopoHistSrchTxt {
            margin-bottom: 10px;
            float: left;
            height: 28px;
            border-radius: 5px;
            border-color: rgba(51, 122, 183, 0.55);
            -webkit-box-shadow: 0 8px 6px -6px black;
            -moz-box-shadow: 0 8px 6px -6px black;
            box-shadow: 0 7px 4px -6px rgb(181, 181, 181);
            margin-top: 4px;
            width: 100%;
        }

        .MainHistoContent {
            padding: 5px;
            background-color: #ffffff;
            border-right: 2px solid #b9b9b940;
        }

        .HistoTbl {
            width: max-content;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
            font-size: 14px;
            background-color: #fff;
            min-width: 100%;
        }

            .HistoTbl thead {
                position: sticky;
                top: 0;
            }

                .HistoTbl thead td {
                    text-align: center;
                    background-color: #3b5998;
                    color: white;
                    font-weight: bold;
                    padding: 10px;
                    border: 1px solid #d5d5d5;
                }

            .HistoTbl tbody td {
                padding: 10px;
                border: 1px solid #d5d5d5;
                color: #333;
            }

            .HistoTbl tr:hover {
                background-color: #f9f9f9;
            }

        .HistoTbl-scroll-container {
            max-height: 300px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .TMNMainDiv {
            padding: 5px;
            display: flex;
            align-items: flex-start;
            min-width: 250px;
            flex-direction: column;
        }

        .TMNDiv {
            display: flex;
            align-items: center;
            /*width: 100%;*/
            padding: 10px 0px;
        }

        .TMNLabel {
            min-width: 65px;
            padding-left: 5px;
        }


        .SearchList {
            width: 100%;
            display: block;
            position: absolute;
            z-index: 2147483647;
            top: 25px;
            background-color: rgb(255 255 255);
            border: 1px solid;
            max-height: 250px;
            overflow: auto;
        }

        .SearchListItem {
            padding: 5px;
            cursor: pointer;
            border-bottom: 1px solid;
        }

            .SearchListItem:hover {
                background-color: #eee;
            }

        .DelHisto {
            font-size: 20px;
        }

        .PrimaryClass {
            font-weight: 800;
        }

        .ToggleUpDownIcon {
            float: right;
            color: black;
            font-size: 20px;
            cursor: pointer;
        }



    </style>

    <%-- ICD O --%>
    <script type="text/javascript">
        var ICDOTopoList = [];
        var ICDOHistoList = [];
        var SrchTopologyList = [];
        var SrchHistoList = [];
        var GradeOptList = [];
        var PrefixOpt = "";
        var BindDataTopoList = [];
        var BindDataHistoList = [];
        var DefTListOption = [{ T: "TX" }, { T: "T0" }];
        var DefNListOption = [{ N: "NX" }];
        var DefMListOption = [];
        var AllowSaveDiagnosis = false;
        var EditICDOFlag = false;
        var DefValueYN = "N";
        //Form Load
        function LoadICDO() {
            GetDiagLoadList();
        }
        //Disable All the ICD-O Field
        function EditICDODetails(FlagYN) {
            if (FlagYN != "Y") {
                if (document.getElementById("ICDOEdit").innerText == "Edit") {
                    document.getElementById("ICDOEdit").innerText = "Cancel";
                    FlagYN = "N";
                    $("#btnSave").show();
                }
                else {
                    SetDataForDiagnosis();
                    document.getElementById("ICDOEdit").innerText = "Edit";
                    FlagYN = "Y";
                    $("#btnSave").hide();
                }
            }
            var div = document.getElementById('MAIN_ICDO');
            var fields = div.querySelectorAll('input, textarea, select, button');
            fields.forEach(function (field) {
                field.disabled = FlagYN == "Y" ? true : false;
            });
            //var icon = div.querySelector('.DelTopoIcon');
            //if (icon) {
            //    icon.style.pointerEvents = FlagYN == "Y" ? 'none' : 'auto';
            //    icon.style.opacity = FlagYN == "Y" ? '0.5' : '1';
            //}
            //icon = div.querySelector('.DelHisto');
            //if (icon) {
            //    icon.style.pointerEvents = FlagYN == "Y" ? 'none' : 'auto';
            //    icon.style.opacity = FlagYN == "Y" ? '0.5' : '1';
            //}
            var icon = div.querySelectorAll('.DelTopoIcon');
            jQuery.grep(icon, function (e) {
                e.style.pointerEvents = FlagYN == "Y" ? 'none' : 'auto';
                e.style.opacity = FlagYN == "Y" ? '0.5' : '1';
            });
            var icons = div.querySelectorAll('.DelHisto');
            jQuery.grep(icons, function (e) {
                e.style.pointerEvents = FlagYN == "Y" ? 'none' : 'auto';
                e.style.opacity = FlagYN == "Y" ? '0.5' : '1';
            });

            EditICDOFlag = FlagYN == "Y" ? false : true;
            if (EditICDOFlag){
                document.getElementById("Remark").style.display = "block";
            }
            else {
                document.getElementById("Remark").style.display = "none";
                $("#ICDORemark").val("");
            }

            div = document.getElementById('CancerOptDiv');
            fields = div.querySelectorAll('input, textarea, select, button');
            fields.forEach(function (field) {
                field.disabled = false;
            });
        }
        //Set Grade Options
        function GetGradeString(ListData) {
            var Option = '<option value="{VALUE}">{TEXT}</option>';
            var AllOption = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
            jQuery.grep(ListData, function (e) {
                var Options = Option.replace("{VALUE}", e.Value.trim()).replace("{TEXT}", e.Text.trim());
                AllOption = AllOption + Options;
            });
            return AllOption;
        }
        //Set Prefix Options
        function GetPrefixString(ListData) {
            var Option = '<option value="{VALUE}">{TEXT}</option>';
            var AllOption = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
            jQuery.grep(ListData, function (e) {
                var Options = Option.replace("{VALUE}", e.Value.trim()).replace("{TEXT}", e.Text.trim());
                AllOption = AllOption + Options;
            });
            return AllOption;
        }
        //Get List of Topology ,Histology , Grade , Prefix
        function GetDiagLoadList() {
            $.ajax({
                type: 'post',
                datatype: 'json',
                url: 'GetToplogyHistoDefList',
                async: false,
                success: function (data) {
                    SrchTopologyList = data[0];
                    SrchHistoList = data[1];
                    GradeOptList = data[2];
                    PrefixOpt = GetPrefixString(data[3]);
                }
            });
        }

        //Bind Saved Data
        function BindICDODtls() {
            HoldOn.open();
            $("#Search_Topo_Content_1").empty();
            $("#Search_Topo_Content_2").empty();
            jQuery.grep(BindDataTopoList, function (e) {
                BindTopGraphy(e.TOPOCODE.trim(), e.TOPODESC.trim(), e.SITELEVEL, e.TOPOTYPE.trim());
                AddRemoveTopoGraphy("A", e.TOPOCODE.trim(), e.TOPODESC.trim(), e.SITELEVEL, e.TOPOTYPE.trim());
                $('[id="' + e.SITELEVEL + '_CmbSiteList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.TNMSITECODE);
                $('[id="' + e.SITELEVEL + '_CmbSiteList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_CmbSubSiteList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.TNMSUBSITECODE);
                $('[id="' + e.SITELEVEL + '_CmbSubSiteList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_CmbPrefixList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.TNMPREFIX);
                $('[id="' + e.SITELEVEL + '_CmbPrefixList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_ICDTList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.T);
                $('[id="' + e.SITELEVEL + '_ICDTList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_ICDNList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.N);
                $('[id="' + e.SITELEVEL + '_ICDNList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_ICDMList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.M);
                $('[id="' + e.SITELEVEL + '_ICDMList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');

                $('[id="' + e.SITELEVEL + '_GEOGRAPHIC_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.GEOGRAPHIC);
                $('[id="' + e.SITELEVEL + '_GEOGRAPHIC_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_LOCATION_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.LOCATION);
                $('[id="' + e.SITELEVEL + '_LOCATION_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_MITOTIC_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.MITOTIC);
                $('[id="' + e.SITELEVEL + '_MITOTIC_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_PSA_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.PSA);
                $('[id="' + e.SITELEVEL + '_PSA_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_SERUMMARKERS_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.SERUMMARKERS);
                $('[id="' + e.SITELEVEL + '_SERUMMARKERS_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_HERITABLETRAIT_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.HERITABLETRAIT);
                $('[id="' + e.SITELEVEL + '_HERITABLETRAIT_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_HER2_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.HER2);
                $('[id="' + e.SITELEVEL + '_HER2_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_ER_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.ER);
                $('[id="' + e.SITELEVEL + '_ER_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_PR_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.PR);
                $('[id="' + e.SITELEVEL + '_PR_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_BLOODINVL_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.BLOODINVL);
                $('[id="' + e.SITELEVEL + '_BLOODINVL_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
                $('[id="' + e.SITELEVEL + '_CmbStageList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.STAGE);
                $('[id="' + e.SITELEVEL + '_CmbStageList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            });
            jQuery.grep(BindDataHistoList, function (e) {
                BindHistologyTbl(e.TOPOCODE.trim(), e.TOPODESC.trim(), e.HCODE.trim(), e.HDESC.trim(), e.SITELEVEL, e.HISTOGRADETYPE);
                AddRemoveHisto("A", e.TOPOCODE.trim(), e.TOPODESC.trim(), e.HCODE.trim(), e.HDESC.trim(), e.SITELEVEL, e.HTYPE, e.TOPOTYPE);
                var GradeId = e.SITELEVEL + "_CmbGrade_" + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + "_" + e.HCODE.trim();
                $('[id="' + GradeId + '"]').val(e.HGRADE);
                $('[id="' + GradeId + '"]').trigger('change');
            });
            HoldOn.close();
        }
        //Search For Topology
        function SearchTopoGraphy(Id, SiteLevel) {
            var input = document.getElementById(Id).value.toLowerCase();
            var filteredList = SrchTopologyList.filter(function (item) {
                var FiltExists = ICDOTopoList.filter(function (e) { return e.SITELEVEL.trim() == SiteLevel && e.TOPOCODE.trim().toLowerCase().includes(item.Value.trim().toLowerCase()) && e.TOPODESC.trim().toLowerCase().includes(item.Text.trim().toLowerCase()); });
                if (FiltExists.length == 0)
                    return item.Value.trim().toLowerCase().includes(input) || item.Text.trim().toLowerCase().includes(input);
            });
            BindSrchTopoList(filteredList, SiteLevel);
        }
        //Bind Search Topology to List
        function BindSrchTopoList(lst, SiteLevel) {
            var container = document.getElementById('TopographySrchLst_' + SiteLevel);
            container.innerHTML = "";
            if (lst.length === 0) {
                container.innerHTML = "<div style='font-size: 14px;padding: 5px;'>No results found.</div>";
                container.style.display = "block";
                return;
            }
            lst.forEach(function (item) {
                var div = document.createElement('div');
                div.textContent = item.Value.trim() + " - " + item.Text.trim();
                div.className = "SearchListItem " + (item.Type == "P" ? "PrimaryClass" : "");
                div.onclick = function () {
                    BindTopGraphy(item.Value.trim(), item.Text.trim(), SiteLevel, item.Type);
                    AddRemoveTopoGraphy("A", item.Value.trim(), item.Text.trim(), SiteLevel, item.Type);
                };
                container.appendChild(div);
            });
            container.style.display = "block";
        }
        //Bind Selected Topology 
        function BindTopGraphy(TopoCode, TopoName, SiteLevel, TopoType) {
            var MainDiv = '<div id="{MAINDIVID}" class="col-xs-12 MainHistoTNMDiv">{MAINDIVCONTENT}</div>';
            var TopoHeadDiv = '<div id="{TOPOHEADDIVID}" class="col-xs-12 TopoHistHeaderDiv"><label class="TopoHistHeaderLbl">Topography - {TOPOLOGYCODE} - {TOPOLOGYNAME}</label><input type="text" id="{TOPOCODETXTID}" style="display: none;" /><div><input type="checkbox" id="{FINALCHKID}" style="margin-right:4px;" /><label for="{FINALCHKID}" style="margin-right:10px;">Final Diagnosis</label><i class="fa fa-trash DelTopoIcon" onclick=\'RemoveTopoGraphy("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' aria-hidden="true"></i>{ARROWCONTENT}</div></div>';
            var ArrowContent = '<i class="fa fa-chevron-circle-down DownUpTopoIcon" style="display:none" id="{DOWNARROWID}" onclick=\'ToggleHistologyContent("D","{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' ></i><i id="{UPARROWID}" class="fa fa-chevron-circle-up DownUpTopoIcon" onclick=\'ToggleHistologyContent("U","{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' ></i>';
            var TNMArrowContent = '<i class="fa fa-chevron-circle-down DownUpTopoIcon" style="display:none" id="{DOWNARROWID}" onclick=\'ToggleTNMAllContent("D","{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' ></i><i id="{UPARROWID}" class="fa fa-chevron-circle-up DownUpTopoIcon" onclick=\'ToggleTNMAllContent("U","{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' ></i>';
            var HistoTNMContDiv = '<div class="col-xs-12 MainHistoContentTNMDiv" id="{HISTOMAINCONTENTID}">{HISTOTNMCONTENTDIV}</div>';
            var HistoContDiv = '<div class="col-xs-12 col-md-7 MainHistoContent">{HISTCONTENTDIV}</div>';
            var HistoSrchDiv = '<div class="col-xs-12 TopoHistSrchDiv"><input type="text" id="{HISTOSRCHTXTID}" onkeyup=\'SearchHistology("{TOPOCODE}","{TOPONAME}","{TOPOTYPE}","{SITELEVEL}")\' placeholder="Search Histology/Behaviour..." class="TopoHistSrchTxt"><div class="SearchList" style="display:none;" id="{HISTOSRCHLISTID}"></div></div>';
            var HistoTable = '<div class="table-responsive HistoTbl-scroll-container"><table id="{HISTOTBLID}" class="HistoTbl"><thead><tr><td style="width: 40px">Act</td><td style="width: 100px">Code</td><td style="width: 120px">Histo/Behaviour</td><td>Description</td><td style="width: 200px;">Grade</td></tr></thead><tbody id="{HISTOTBLBODYID}"></tbody></table></div>';
            var TNMDesc = '<div class="col-xs-12 col-md-5 TMNMainDiv"><div class="TNMHeaderDiv col-xs-12"><label style="margin: 0px;" id="{TNMDESCHEADLBL}"></label><div style="display: inline-block;float: right;">{ARROWTNM}</div></div>{TNMDESC}</div>';
            var TDesc = '<div class="TNMDescDiv" style="padding: 0px;" id="{TDESCMAINDIV}"><div class="table-responsive custom-scroll-container"><table id="{TDESCTBL}" class="table custom-table"><thead><tr><td colspan="2">Primary Tumor(T) {DOWNUPICON}</td></tr></thead><tbody id="{TBODYID}"></tbody></table></div></div>';
            var NDesc = '<div class="TNMDescDiv" style="padding: 0px;" id="{NDESCMAINDIV}"><div class="table-responsive custom-scroll-container"><table id="{NDESCTBL}" class="table custom-table"><thead><tr><td colspan="2">Regional Lymph Nodes(N) {DOWNUPICON}</td></tr></thead><tbody id="{NBODYID}"></tbody></table></div></div>';
            var MDesc = '<div class="TNMDescDiv" style="padding: 0px;" id="{MDESCMAINDIV}"><div class="table-responsive custom-scroll-container"><table id="{MDESCTBL}" class="table custom-table"><thead><tr><td colspan="2">Distant Metastasis(M) {DOWNUPICON}</td></tr></thead><tbody id="{MBODYID}"></tbody></table></div></div>';
            var TNMDiv = '<div class="col-xs-12">{TNMCONTENT}</div>';
            var SiteDiv = '<div class="TMNDiv col-xs-12 col-md-12 col-lg-6"><label class="TMNLabel">Site</label><select id="{SITECMBID}" onchange=\'GetSubSiteList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
            //var SubSiteDiv = '<div class="TMNDiv col-xs-12 col-md-12 col-lg-6"><label class="TMNLabel">Sub-Site</label><select id="{SUBSITECMBID}" onchange=\'GetTNMList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}");FilterTList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
            //var PrefixDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label class="TMNLabel">Prefix<i class="fa fa-question-circle" style="font-size: 14px;margin-right: 10px;color: #000000;cursor: pointer;padding-left: 5px;" id="PopPrefix" title="Prefix Information" onclick=\'OpenPopInfoGuide("P")\' aria-hidden="true"></i></label><select id="{PREFIXCMBID}" onchange=\'UpdateTNM("{SITELEVEL}","{TOPOCODE}","{TOPONAME}")\' class="form-control">{PREFIXOPT}</select></div>';
            var SubSiteDiv = '<div class="TMNDiv col-xs-12 col-md-12 col-lg-6"><label class="TMNLabel">Sub-Site</label><select id="{SUBSITECMBID}" onchange=\'GetTNMList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}");\' class="form-control"></select></div>';
            var PrefixDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label class="TMNLabel">Prefix<i class="fa fa-question-circle" style="font-size: 14px;margin-right: 10px;color: #000000;cursor: pointer;padding-left: 5px;" id="PopPrefix" title="Prefix Information" onclick=\'OpenPopInfoGuide("P")\' aria-hidden="true"></i></label><select id="{PREFIXCMBID}" onchange=\'FilterTList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}");\' class="form-control"></select></div>';
            var TDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label style="text-align: center;" class="TMNLabel">T</label><select id="{TCMBID}" onchange=\'FilterNList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
            var NDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label style="text-align: center;" class="TMNLabel">N</label><select id="{NCMBID}" onchange=\'FilterMList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
            var MDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label style="text-align: center;" class="TMNLabel">M</label><select id="{MCMBID}" onchange=\'FilterOthrList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
            var OthrDiv = '<div id="{OTHERDIVID}" style="width:100%;display: flex;flex-wrap: wrap;"></div>';
            var StageDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label class="TMNLabel">Stage</label><select id="{STAGECMBID}" onchange=\'UpdateTNM("{SITELEVEL}","{TOPOCODE}","{TOPONAME}")\' class="form-control"></select></div>';
            var DownUpIcon = '<i class="fa fa-chevron-circle-down ToggleUpDownIcon" id="{DOWNID}" onclick=\'ToggleTNM("D",this.id,"{BODYID}","{UPID}")\' style="float:right;display:none;" aria-hidden="true"></i><i class="fa fa-chevron-circle-up ToggleUpDownIcon" id="{UPID}" onclick=\'ToggleTNM("U",this.id,"{BODYID}","{DOWNID}")\' aria-hidden="true"></i>';
            var MainDivId = SiteLevel + "_Main_Topo_Div_" + TopoCode + "_" + TopoName;
            var TopoHeadDivId = SiteLevel + "_Topo_Header_" + TopoCode + "_" + TopoName;
            var TopoCodeTxtId = SiteLevel + "_txtTopo_" + TopoCode + "_" + TopoName;
            var HistoSrchid = SiteLevel + "_Srch_Topo_Histo_" + TopoCode + "_" + TopoName;
            var HistoSrchListid = SiteLevel + "_Srch_Topo_Histo_List_" + TopoCode + "_" + TopoName;
            var HistoTblId = SiteLevel + "_Hist_Tbl_" + TopoCode + "_" + TopoName;
            var HistoTblBodyId = SiteLevel + "_Hist_Tbl_Body_" + TopoCode + "_" + TopoName;
            var SiteComboId = SiteLevel + "_CmbSiteList_" + TopoCode + "_" + TopoName;
            var SubSiteComboId = SiteLevel + "_CmbSubSiteList_" + TopoCode + "_" + TopoName;
            var PrefixComboId = SiteLevel + "_CmbPrefixList_" + TopoCode + "_" + TopoName;
            var TComboId = SiteLevel + "_ICDTList_" + TopoCode + "_" + TopoName;
            var NComboId = SiteLevel + "_ICDNList_" + TopoCode + "_" + TopoName;
            var MComboId = SiteLevel + "_ICDMList_" + TopoCode + "_" + TopoName;
            var OtherDivId = SiteLevel + "_OTHRDIVID_" + TopoCode + "_" + TopoName;
            var StageComboId = SiteLevel + "_CmbStageList_" + TopoCode + "_" + TopoName;
            var TNMHeaderLblId = SiteLevel + "_TNM_HEADER_LBL_" + TopoCode + "_" + TopoName;
            var TDescTbl = SiteLevel + "_TDescTbl_" + TopoCode + "_" + TopoName;
            var NDescTbl = SiteLevel + "_NDescTbl_" + TopoCode + "_" + TopoName;
            var MDescTbl = SiteLevel + "_MDescTbl_" + TopoCode + "_" + TopoName;
            var TBodyId = SiteLevel + "_TTBody_" + TopoCode + "_" + TopoName;
            var NBodyId = SiteLevel + "_NTBody_" + TopoCode + "_" + TopoName;
            var MBodyId = SiteLevel + "_MTBody_" + TopoCode + "_" + TopoName;
            var TDownId = SiteLevel + "_TDOWN_" + TopoCode + "_" + TopoName;
            var TUpId = SiteLevel + "_TUP_" + TopoCode + "_" + TopoName;
            var NDownId = SiteLevel + "_NDOWN_" + TopoCode + "_" + TopoName;
            var NUpId = SiteLevel + "_NUP_" + TopoCode + "_" + TopoName;
            var MDownId = SiteLevel + "_MDOWN_" + TopoCode + "_" + TopoName;
            var MUpId = SiteLevel + "_MUP_" + TopoCode + "_" + TopoName;
            var MainContentId = SiteLevel + "_MAINCONTENT_" + TopoCode + "_" + TopoName;
            var DownArrowID = SiteLevel + "_DOWNARROW_" + TopoCode + "_" + TopoName;
            var UpArrowID = SiteLevel + "_UPARROW_" + TopoCode + "_" + TopoName;
            var FinalChkId = SiteLevel + "_FINALCHK_" + TopoCode + "_" + TopoName;
            var RplArrowContent = ArrowContent.replace("{DOWNARROWID}", DownArrowID).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel)
                                              .replace("{UPARROWID}", UpArrowID).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
            var RplTDownUpIcon = DownUpIcon.replace("{DOWNID}", TDownId).replace("{BODYID}", TBodyId).replace("{UPID}", TUpId)
                                           .replace("{UPID}", TUpId).replace("{BODYID}", TBodyId).replace("{DOWNID}", TDownId);
            var RplNDownUpIcon = DownUpIcon.replace("{DOWNID}", NDownId).replace("{BODYID}", NBodyId).replace("{UPID}", NUpId)
                                           .replace("{UPID}", NUpId).replace("{BODYID}", NBodyId).replace("{DOWNID}", NDownId);
            var RplMDownUpIcon = DownUpIcon.replace("{DOWNID}", MDownId).replace("{BODYID}", MBodyId).replace("{UPID}", MUpId)
                                           .replace("{UPID}", MUpId).replace("{BODYID}", MBodyId).replace("{DOWNID}", MDownId);
            var RplTopoHeadDiv = TopoHeadDiv.replace("{TOPOHEADDIVID}", TopoHeadDivId).replace("{TOPOLOGYCODE}", TopoCode).replace("{TOPOLOGYNAME}", TopoName).replace("{TOPOCODETXTID}", TopoCodeTxtId).replace("{FINALCHKID}", FinalChkId)
                .replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel)
                .replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel)
                .replace("{ARROWCONTENT}", RplArrowContent);
            var RplHistoSrchDiv = HistoSrchDiv.replace("{HISTOSRCHTXTID}", HistoSrchid).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{TOPOTYPE}", TopoType).replace("{HISTOSRCHLISTID}", HistoSrchListid).replace("{SITELEVEL}", SiteLevel);
            var RplHistoTable = HistoTable.replace("{HISTOTBLID}", HistoTblId).replace("{HISTOTBLBODYID}", HistoTblBodyId);
            var RplSiteDiv = SiteDiv.replace("{SITECMBID}", SiteComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
            var RplSubSiteDiv = SubSiteDiv.replace("{SUBSITECMBID}", SubSiteComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel).replace("{SITELEVEL}", SiteLevel);
            var RplPrefixDiv = PrefixDiv.replace("{PREFIXCMBID}", PrefixComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel)
                .replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
            var RplTDiv = TDiv.replace("{TCMBID}", TComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
            var RplNDiv = NDiv.replace("{NCMBID}", NComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
            var RplMDiv = MDiv.replace("{MCMBID}", MComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
            var RplOthrDiv = OthrDiv.replace("{OTHERDIVID}", OtherDivId);
            var RplStageDiv = StageDiv.replace("{STAGECMBID}", StageComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel); 
            var RplTNMDiv = TNMDiv.replace("{TNMCONTENT}", (RplSiteDiv + RplSubSiteDiv + RplPrefixDiv + RplTDiv + RplNDiv + RplMDiv + RplOthrDiv + RplStageDiv));
            var RplHistoContDiv = HistoContDiv.replace("{HISTCONTENTDIV}", (RplHistoSrchDiv + RplHistoTable + RplTNMDiv));
            var TDescMainDivId = SiteLevel + "_TDESCDIV_" + TopoCode + "_" + TopoName;
            var NDescMainDivId = SiteLevel + "_NDESCDIV_" + TopoCode + "_" + TopoName;
            var MDescMainDivId = SiteLevel + "_MDESCDIV_" + TopoCode + "_" + TopoName;
            var TNMDownArrowID = SiteLevel + "_TNMDOWNARROW_" + TopoCode + "_" + TopoName;
            var TNMUpArrowID = SiteLevel + "_TNMUPARROW_" + TopoCode + "_" + TopoName;
            var RplTDesc = TDesc.replace("{TDESCTBL}", TDescTbl).replace("{TBODYID}", TBodyId).replace("{DOWNUPICON}", RplTDownUpIcon).replace("{TDESCMAINDIV}", TDescMainDivId);
            var RplNDesc = NDesc.replace("{NDESCTBL}", NDescTbl).replace("{NBODYID}", NBodyId).replace("{DOWNUPICON}", RplNDownUpIcon).replace("{NDESCMAINDIV}", NDescMainDivId);
            var RplMDesc = MDesc.replace("{MDESCTBL}", MDescTbl).replace("{MBODYID}", MBodyId).replace("{DOWNUPICON}", RplMDownUpIcon).replace("{MDESCMAINDIV}", MDescMainDivId);
            var RplArrowTNMContent = TNMArrowContent.replace("{DOWNARROWID}", TNMDownArrowID).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel)
                                  .replace("{UPARROWID}", TNMUpArrowID).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
            var RplTNMDesc = TNMDesc.replace("{TNMDESCHEADLBL}", TNMHeaderLblId).replace("{TNMDESC}", (RplTDesc + RplNDesc + RplMDesc)).replace("{ARROWTNM}", (RplArrowTNMContent));
            var RplHistoTNMContDiv = HistoTNMContDiv.replace("{HISTOMAINCONTENTID}", MainContentId).replace("{HISTOTNMCONTENTDIV}", (RplHistoContDiv + RplTNMDesc))
            var AllContent = RplTopoHeadDiv + RplHistoTNMContDiv;
            var RplMainDiv = MainDiv.replace("{MAINDIVID}", MainDivId).replace("{MAINDIVCONTENT}", AllContent)
            $("#Search_Topo_Content_" + SiteLevel).append(RplMainDiv);
            LoadNewTNM(SiteLevel, TopoCode, TopoName);
        }
        //Open Popup For Prefix Information
        function OpenPopInfoGuide(Type) {
            if (Type == "P") {
                document.getElementById("InfoHeadLabel").innerText = "Prefix Info";
                $("#TblPrefixInfo").show();
            }
            document.getElementById("POPUPInfoModal").style.display = "flex";
            document.documentElement.style.overflow = 'hidden';
        }

        //Toggle Histology
        function ToggleHistologyContent(Type, TopoCode, TopoName, SiteLevel) {
            var MainContentId = SiteLevel + "_MAINCONTENT_" + TopoCode + "_" + TopoName;
            var DownArrowID = SiteLevel + "_DOWNARROW_" + TopoCode + "_" + TopoName;
            var UpArrowID = SiteLevel + "_UPARROW_" + TopoCode + "_" + TopoName;
            if (Type == "D") {
                document.getElementById(MainContentId).style.display = "inline-block";
                document.getElementById(DownArrowID).style.display = "none";
                document.getElementById(UpArrowID).style.display = "inline-block";
            }
            else {
                document.getElementById(MainContentId).style.display = "none";
                document.getElementById(UpArrowID).style.display = "none";
                document.getElementById(DownArrowID).style.display = "inline-block";
            }
        }
        //Toggle TNM Whole Content
        function ToggleTNMAllContent(Type, TopoCode, TopoName, SiteLevel) {
            var TDescMainDivId = SiteLevel + "_TDESCDIV_" + TopoCode + "_" + TopoName;
            var NDescMainDivId = SiteLevel + "_NDESCDIV_" + TopoCode + "_" + TopoName;
            var MDescMainDivId = SiteLevel + "_MDESCDIV_" + TopoCode + "_" + TopoName;
            var DownArrowID = SiteLevel + "_TNMDOWNARROW_" + TopoCode + "_" + TopoName;
            var UpArrowID = SiteLevel + "_TNMUPARROW_" + TopoCode + "_" + TopoName;
            if (Type == "D") {
                document.getElementById(TDescMainDivId).style.display = "block";
                document.getElementById(NDescMainDivId).style.display = "block";
                document.getElementById(MDescMainDivId).style.display = "block";
                document.getElementById(DownArrowID).style.display = "none";
                document.getElementById(UpArrowID).style.display = "inline-block";
            }
            else {
                document.getElementById(TDescMainDivId).style.display = "none";
                document.getElementById(NDescMainDivId).style.display = "none";
                document.getElementById(MDescMainDivId).style.display = "none";
                document.getElementById(UpArrowID).style.display = "none";
                document.getElementById(DownArrowID).style.display = "inline-block";
            }
        }
        //Remove Topology
        function RemoveTopoGraphy(TopoCode, TopoName, SiteLevel) {
            var DivId = SiteLevel + "_Main_Topo_Div_" + TopoCode + "_" + TopoName;
            var elem = document.getElementById(DivId);
            if (elem) {
                elem.remove();
            }
            AddRemoveTopoGraphy("R", TopoCode, "", SiteLevel, "");
        }
        //Add or Remove Topology in the Array
        function AddRemoveTopoGraphy(Type, TopoCode, TopoName, SiteLevel, PType) {
            if (Type == "A") {
                var NewD = {
                    SITELEVEL: SiteLevel,
                    TOPOCODE: TopoCode.trim(),
                    TOPODESC: TopoName.trim(),
                    TOPOTYPE: PType,
                    TNMSITECODE: "",
                    TNMSUBSITECODE: "",
                    TNMPREFIX: "",
                    T: "",
                    N: "",
                    M: "",
                    STAGE: ""
                }
                ICDOTopoList.push(NewD);
            }
            else {
                var TempD = ICDOTopoList.filter(function (e) { return e.SITELEVEL.toString().trim() != SiteLevel && e.TOPOCODE.toString().trim() != TopoCode && e.TOPODESC.toString().trim() != TopoName; });
                ICDOTopoList = JSON.parse(JSON.stringify(TempD));
                var TempDO = ICDOHistoList.filter(function (e) { return e.SITELEVEL.toString().trim() != SiteLevel && e.TOPOCODE.toString().trim() != TopoCode && e.TOPODESC.toString().trim() != TopoName; });
                ICDOHistoList = JSON.parse(JSON.stringify(TempDO));
            }
        }
        //Search Histology
        function SearchHistology(TopoCode, TopoName, TopoType, SiteLevel) {
            var SrchTxtId = SiteLevel + "_Srch_Topo_Histo_" + TopoCode + "_" + TopoName;
            var input = $('[id="' + SrchTxtId + '"]').val().toLowerCase();
            var filteredList = SrchHistoList.filter(function (item) {
                var FiltExists = ICDOHistoList.filter(function (e) {
                    if (TopoCode == e.TOPOCODE && TopoName == e.TOPODESC && SiteLevel == e.SITELEVEL) {
                        if (e.HCODE && e.HDESC) {
                            return e.HCODE.trim() == item.Value.trim() && e.HDESC.trim() == item.Text.trim();
                        }
                        return false;
                    }
                    return false;
                });
                if (FiltExists.length == 0) {
                    return item.Value.toLowerCase().includes(input) || item.Text.toLowerCase().includes(input);
                }
            });
            BindSrchHistoList(filteredList, TopoCode, TopoName, TopoType, SiteLevel);
        }
        //Bind Search Histology in List
        function BindSrchHistoList(lst, TopoCode, TopoName, TopoType, SiteLevel) {
            var HistSrchListId = SiteLevel + "_Srch_Topo_Histo_List_" + TopoCode + "_" + TopoName;
            var container = document.getElementById(HistSrchListId);
            container.innerHTML = "";
            if (lst.length === 0) {
                container.innerHTML = "<div style='font-size: 14px;padding: 5px;'>No results found.</div>";
                container.style.display = "block";
                return;
            }
            lst.forEach(function (item) {
                var div = document.createElement('div');
                div.textContent = item.Value + " - " + item.Text;
                div.className = "SearchListItem " + (item.Type == "P" ? "PrimaryClass" : "");
                div.onclick = function () {
                    BindHistologyTbl(TopoCode, TopoName, item.Value, item.Text, SiteLevel, item.GradeType);
                    AddRemoveHisto("A", TopoCode, TopoName, item.Value, item.Text, SiteLevel, item.Type, TopoType);
                };
                container.appendChild(div);
            });
            container.style.display = "block";
        }
        //Bind Selected Histology
        function BindHistologyTbl(TopoCode, TopoName, HistoCode, HistoName, SiteLevel,HistoGradeType) {
            var FiltGrade = GradeOptList.filter(function (e) { return e.GradeType.toString().trim() == HistoGradeType; });
            var GradeOpt = GetGradeString(FiltGrade);
            var TblBodyId = SiteLevel + "_Hist_Tbl_Body_" + TopoCode + "_" + TopoName;
            var TrId = SiteLevel + "_TR_Histo_" + TopoCode + "_" + TopoName + "_" + HistoCode;
            var GradeId = SiteLevel + "_CmbGrade_" + TopoCode + "_" + TopoName + "_" + HistoCode;
            var GenCodeLblId = SiteLevel + "_GenCode_" + TopoCode + "_" + TopoName + "_" + HistoCode;
            var ActTd = '<td style="text-align: center;"><i class="fa fa-trash DelHisto" aria-hidden="true" onclick=\'RemoveHistology("{TOPOCODE}","{TOPONAME}","{HCODE}","{SITELEVEL}")\'></i></td>';
            var GenCodeTd = '<td style="padding: 0px;"><label id="{GENCODEID}">' + (TopoCode.trim() + HistoCode.trim()) + '</label></td>';
            var CodeTd = '<td style="text-align: center;padding: 0px;">' + HistoCode + '</td>';
            var DescTd = '<td style="padding: 0px;padding-left: 5px;">' + HistoName + '</td>';
            var GradeTd = '<td style="padding: 0px;"><select id="' + GradeId + '" class="form-control" style="padding: 0px;" onchange=\'ChangeGrade("{TOPOCODE}","{TOPONAME}","{HCODE}","{SITELEVEL}")\' >{GRADEOPT}</select></td>';
            var RplActTd = ActTd.replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{HCODE}", HistoCode).replace("{SITELEVEL}", SiteLevel);
            var RplGenCodeTd = GenCodeTd.replace("{GENCODEID}", GenCodeLblId);
            var RplGradeTd = GradeTd.replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{HCODE}", HistoCode).replace("{GRADEOPT}", GradeOpt).replace("{SITELEVEL}", SiteLevel);
            var AllTd = RplActTd + RplGenCodeTd + CodeTd + DescTd + RplGradeTd;
            var TR = "<tr id='" + TrId + "'>" + AllTd + "</tr>";
            $('[id="' + TblBodyId + '"]').append(TR);
        }
        //Update List While Change the Grade
        function ChangeGrade(TopoCode, TopoName, HistoCode, SiteLevel) {
            var GradeId = SiteLevel + "_CmbGrade_" + TopoCode + "_" + TopoName + "_" + HistoCode;
            jQuery.grep(ICDOHistoList, function (e) {
                if (e.SITELEVEL == SiteLevel && e.TOPOCODE == TopoCode && e.TOPODESC == TopoName && e.HCODE == HistoCode) {
                    e.HGRADE = $('[id="' + GradeId + '"]').val() == null ? "" : $('[id="' + GradeId + '"]').val();
                    var GenCodeLblId = SiteLevel + "_GenCode_" + TopoCode + "_" + TopoName + "_" + HistoCode;
                    document.getElementById(GenCodeLblId).innerText = (TopoCode.trim() + HistoCode.trim() + " " + e.HGRADE.trim());
                }
            });
        }
        //Remove Histology
        function RemoveHistology(TopoCode, TopoName, HistoCode, SiteLevel) {
            var RowId = SiteLevel + "_TR_Histo_" + TopoCode + "_" + TopoName + "_" + HistoCode;
            var elem = document.getElementById(RowId);
            if (elem) {
                elem.remove();
            }
            AddRemoveHisto("R", TopoCode, TopoName, HistoCode, "", SiteLevel, "", "");
        }
        //Add or Remove Histology From the Array
        function AddRemoveHisto(Type, TopoCode, TopoName, HistoCode, HistoName, SiteLevel, HType, TopoType) {
            if (Type == "A") {
                var NewD = {
                    SITELEVEL: SiteLevel,
                    TOPOCODE: TopoCode,
                    TOPODESC: TopoName,
                    TOPOTYPE: TopoType,
                    HCODE: HistoCode,
                    HDESC: HistoName,
                    HGRADE: "",
                    HTYPE: HType
                }
                ICDOHistoList.push(NewD);
            }
            else {
                var TempD = ICDOHistoList.filter(function (e) { return e.SITELEVEL.toString().trim() != SiteLevel || e.TOPOCODE.toString().trim() != TopoCode || e.TOPODESC.toString().trim() != TopoName || e.HCODE.toString().trim() != HistoCode; });
                ICDOHistoList = JSON.parse(JSON.stringify(TempD));
            }
        }

        //Validation For the Save ICD-O Diagnosis
        function ValidationForICDODiag() {
            AllowSaveDiagnosis = true;
            if ($("#ICDORemark").val().trim() == "" && BindDataTopoList.length > 0) {
                AllowSaveDiagnosis = false;
                $("#ICDORemark").focus().css("border-color", "red");
                $.messager.alert("Information", "Please Enter Remark.");
                return false;
            }
            return true;
        }
    </script>

    <%-- TNM Info Style --%>
    <style>
        .custom-table {
            width: 100%;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
            font-size: 14px;
            background-color: #fff;
            margin: 0px;
        }

            .custom-table thead {
                position: sticky;
                top: 0;
            }

                .custom-table thead td {
                    text-align: center;
                    background-color: #95cf9b;
                    color: white;
                    font-weight: bold;
                    padding: 10px;
                    border-bottom: 2px solid #ddd;
                }

            .custom-table tbody td {
                padding: 10px;
                border-bottom: 1px solid #eee;
                color: #333;
            }

            .custom-table tr:hover {
                background-color: #f9f9f9;
            }

        .custom-scroll-container {
            max-height: 300px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .FirstTDClass {
            width: 60px;
        }
    </style>

    <%-- TNM --%>
    <script type="text/javascript">
        var AllStageList = [];
        var AllDescList = [];

        function LoadNewTNM(SiteLevel, TopoCode, TopoName) {
            var TopoId = TopoCode + "_" + TopoName;
            ClearTNMFields(SiteLevel, TopoId);
            GetSiteList(SiteLevel, TopoId, TopoName);
            DisableTNM(SiteLevel, TopoId);
            UpdateTNM(SiteLevel, TopoCode, TopoName);
        }

        function GetSiteList(SiteLevel, TopoCode, TopoName) {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetSiteSubSiteList","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {
                    BindComboList((SiteLevel + '_CmbSiteList_' + TopoCode), response, "Value", "Text");
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
                },
            });
        }

        function GetSubSiteList(TopoCode, TopoName, SiteLevel) {
            if ($('[id="' + (SiteLevel + "_CmbSiteList_" + TopoCode + "_" + TopoName) + '"]').val() != "") {
                var DataToSend = {
                    SiteCd: $('[id="' + (SiteLevel + "_CmbSiteList_" + TopoCode + "_" + TopoName) + '"]').val()
                }
                $.ajax({
                    type: "POST",
                    url: "<%=Url.Action("GetSiteSubSiteList","DoctorDesk")%>",
                    data: DataToSend,
                    async: false,
                    success: function (response) {
                        BindComboList((SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName), response, "Value", "Text");
                    }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                        HoldOn.close();
                        $.messager.alert("Error", errorThrown);
                    },
                    complete: function () {
                        HoldOn.close();
                    },
                });
            }
            else {
                BindComboList((SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName), [], "");
            }
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            UpdateTNM(SiteLevel, TopoCode, TopoName);
            BindDescriptionList(TopoCode, TopoName, SiteLevel);
            $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoCode + "_" + TopoName + '"]').empty();
        }

        function ClearTNMFields(SiteLevel, TopoId) {
            BindComboList((SiteLevel + '_CmbSiteList_' + TopoId), [], "", "");
            BindComboList((SiteLevel + '_CmbSubSiteList_' + TopoId), [], "", "");
            BindComboList((SiteLevel + '_ICDTList_' + TopoId), [], "", "");
            BindComboList((SiteLevel + '_ICDNList_' + TopoId), [], "", "");
            BindComboList((SiteLevel + '_ICDMList_' + TopoId), [], "", "");
            BindComboList((SiteLevel + '_CmbStageList_' + TopoId), [], "", "");
            DisableTNM(SiteLevel, TopoId);
        }

        function DisableTNM(SiteLevel, TopoId) {
            var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoId + '"]').val();
            var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoId + '"]').val();
            var Prefix = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').val();
            var t = $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').val();
            var n = $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').val();
            var m = $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').val();
            if (site == "" || subsite == "") {
                $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
                BindComboList(SiteLevel + '_CmbPrefixList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_ICDTList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_ICDNList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_ICDMList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
                $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
            }
            else if (Prefix == "") {
                $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
                BindComboList(SiteLevel + '_ICDTList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_ICDNList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_ICDMList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
                $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
            }
            else if (TNMNotFilter == "Y") {
                $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", false);
            }
            else if (t == "") {
                $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
                BindComboList(SiteLevel + '_ICDNList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_ICDMList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
            } else if (n == "") {
                $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
                $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
                BindComboList(SiteLevel + '_ICDMList_' + TopoId, [], "", "");
                BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
            } else if (m == "") {
                $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
                BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
            } else {
                $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", false);
                $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", false);
            }
        }

        function FilterPrefixList(TopoCode, TopoName, SiteLevel) {
            if (TNMNotFilter != "Y") {
                var FilterLst = [];
                var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
                var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
                if (site != "" && subsite != "") {
                    let uniqueMap = new Map();
                    AllStageList.forEach(function (e) {
                        if (
                            e.SITE.toString().trim() === site &&
                            e.SUBSITE.toString().trim() === subsite &&
                            !uniqueMap.has(e.PC)
                        ) {
                            uniqueMap.set(e.PC, e);
                        }
                    });
                    FilterLst = Array.from(uniqueMap.values());
                }
                BindComboList(SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName, FilterLst, "PC", "PC");
                DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            }
            else {
                DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            }
            UpdateTNM(SiteLevel, TopoCode, TopoName);
        }

        function GetTNMList(TopoCode, TopoName, SiteLevel) {
            var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var FlagSetDef = false;
            if (site != "" && subsite != "") {
                var FilterDT = AllStageList.filter(function (a) { return a.SITE.toString().trim() == site && a.SUBSITE.toString().trim() == subsite; });
                if (FilterDT.length == 0) {
                    var DataToSend = {
                        SiteCode: site,
                        SubSiteCode: subsite
                    }
                    $.ajax({
                        type: "POST",
                        url: "<%=Url.Action("GetStagingList","DoctorDesk")%>",
                        data: DataToSend,
                        async: false,
                        success: function (response) {
                            if (response[0] != null && response[0].length > 0) {
                                AllStageList = AllStageList.concat(response[0]);
                            }
                            else {
                                FlagSetDef = true;
                            }
                            if (response[1] != null) {
                                AllDescList = AllDescList.concat(response[1]);
                            }
                        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                            HoldOn.close();
                            $.messager.alert("Error", errorThrown);
                        },
                        complete: function () {
                            HoldOn.close();
                        },
                    });
                } else {
                    BindComboList(SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName, [], "", "");
                    BindComboList(SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName, [], "", "");
                    BindComboList(SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName, [], "", "");
                    BindComboList(SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName, [], "", "");
                    BindComboList(SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName, [], "", "");
                }
            }
            UpdateTNM(SiteLevel, TopoCode, TopoName);
            if(FlagSetDef)
                SetDataForDefTNM(TopoCode, TopoName, SiteLevel);
            else
                FilterPrefixList(TopoCode, TopoName, SiteLevel)
        }

        function SetDataForDefTNM(TopoCode, TopoName, SiteLevel) {
            var EmptyLst = [{ Value: "NA" }];
            var TopoId = TopoCode + "_" + TopoName;
            BindComboList(SiteLevel + '_CmbPrefixList_' + TopoId, EmptyLst, "Value", "Value");
            BindComboList(SiteLevel + '_ICDTList_' + TopoId, EmptyLst, "Value", "Value");
            BindComboList(SiteLevel + '_ICDNList_' + TopoId, EmptyLst, "Value", "Value");
            BindComboList(SiteLevel + '_ICDMList_' + TopoId, EmptyLst, "Value", "Value");
            BindComboList(SiteLevel + '_CmbStageList_' + TopoId, EmptyLst, "Value", "Value");
            $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
            UpdateTNM(SiteLevel, TopoCode, TopoName);
            $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').val(EmptyLst[0].Value);
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').val(EmptyLst[0].Value);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').val(EmptyLst[0].Value);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').val(EmptyLst[0].Value);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').val(EmptyLst[0].Value);
        }

        function FilterTList(TopoCode, TopoName, SiteLevel) {
            if (TNMNotFilter != "Y") {
                var FilterLst = [];
                var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
                var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
                if (site != "" && subsite != "") {
                    let uniqueMap = new Map();
                    AllStageList.forEach(function (e) {
                        if (
                            e.SITE.toString().trim() === site &&
                            e.SUBSITE.toString().trim() === subsite &&
                            !uniqueMap.has(e.T)
                        ) {
                            uniqueMap.set(e.T, e);
                        }
                    });
                    FilterLst = Array.from(uniqueMap.values());
                }
                var FList = FilterLst;
                if (DefValueYN == "Y") {
                    jQuery.grep(DefTListOption, function (e) {
                        var FilterDefT = FilterLst.filter(function (a) { return a.T.toString().trim() == e.T.toString().trim(); });
                        if (FilterDefT.length == 0) {
                            FList.push(e);
                        }
                    });
                }
                BindComboList(SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName, FList, "T", "T");
                DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            }
            else {
                DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            }
            UpdateTNM(SiteLevel, TopoCode, TopoName);
            BindDescriptionList(TopoCode, TopoName, SiteLevel);
        }

        function FilterNList(TopoCode, TopoName, SiteLevel) {
            if (TNMNotFilter != "Y") {
                var FilterLst = [];
                var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
                var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
                var t = "" + $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
                if (site != "" && subsite != "" && t != "") {
                    let uniqueMap = new Map();
                    AllStageList.forEach(function (e) {
                        if (
                            e.SITE.toString().trim() == site &&
                            e.SUBSITE.toString().trim() == subsite &&
                            e.T.toString().trim() == t &&
                            !uniqueMap.has(e.N)
                        ) {
                            uniqueMap.set(e.N, e);
                        }
                    });
                    FilterLst = Array.from(uniqueMap.values());
                }
                var FList = FilterLst;
                if (DefValueYN == "Y") {
                    jQuery.grep(DefNListOption, function (e) {
                        var FilterDefN = FilterLst.filter(function (a) { return a.N.toString().trim() == e.N.toString().trim(); });
                        if (FilterDefN.length == 0) {
                            FList.push(e);
                        }
                    });
                }
                BindComboList(SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName, FList, "N", "N");
                DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
                if (DefTListOption.filter(function (a) { return a.T.toString().trim() == t.toString().trim(); }).length > 0)
                        FilterStageList(TopoCode, TopoName, SiteLevel)
            }
            else {
                DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            }
            UpdateTNM(SiteLevel, TopoCode, TopoName);
        }

        function FilterMList(TopoCode, TopoName, SiteLevel) {
            if (TNMNotFilter != "Y") {
                var FilterLst = [];
                var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
                var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
                var t = "" + $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
                var n = "" + $('[id="' + SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName + '"]').val();
                if (site != "" && subsite != "" && t != "" && n != "") {
                    let uniqueMap = new Map();
                    AllStageList.forEach(function (e) {
                        if (
                            e.SITE.toString().trim() == site &&
                            e.SUBSITE.toString().trim() == subsite &&
                            e.T.toString().trim() == t &&
                            e.N.toString().trim() == n &&
                            !uniqueMap.has(e.M)
                        ) {
                            uniqueMap.set(e.M, e);
                        }
                    });
                    FilterLst = Array.from(uniqueMap.values());
                }
                var FList = FilterLst;
                if (DefValueYN == "Y") {
                    jQuery.grep(DefMListOption, function (e) {
                        var FilterDefM = FilterLst.filter(function (a) { return a.M.toString().trim() == e.M.toString().trim(); });
                        if (FilterDefM.length == 0) {
                            FList.push(e);
                        }
                    });
                }
                BindComboList(SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName, FList, "M", "M");
                DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
                if (DefNListOption.filter(function (a) { return a.N.toString().trim() == n.toString().trim(); }).length > 0)
                    FilterStageList(TopoCode, TopoName, SiteLevel)
            }
            else {
                DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            }
            UpdateTNM(SiteLevel, TopoCode, TopoName);
        }

        function BindOtherDivContent(Label, Id, TopoCd, TopoNM, SiteLvl, Lst, MainDivId, PropID) {
            var ODiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label style="text-align: center;" class="TMNLabel">{OTHRLABEL}</label><select id="{OTHRCMBID}" onchange=\'FilterStageList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
            var RplODiv = ODiv.replace("{OTHRLABEL}", Label).replace("{OTHRCMBID}", Id).replace("{TOPOCODE}", TopoCd).replace("{TOPONAME}", TopoNM).replace("{SITELEVEL}", SiteLvl);
            $('[id="' + Id + '"]').remove();
            $('[id="' + MainDivId + '"]').append(RplODiv);
            BindComboList(SiteLvl + '_' + PropID + '_' + TopoCd + "_" + TopoNM, Lst, PropID, PropID);
        }

        function FilterOthrList(TopoCode, TopoName, SiteLevel) {
            var TopoId = TopoCode + "_" + TopoName;
            var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var prefix = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName + '"]').val();
            var t = $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
            var n = $('[id="' + SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName + '"]').val();
            var m = $('[id="' + SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName + '"]').val();
            var FilterLst = AllStageList.filter(function (a) {
                return a.SITE.toString().trim() == site && a.SUBSITE.toString().trim() == subsite && a.PC.toString().trim() == prefix
                    && a.T.toString().trim() == t && a.N.toString().trim() == n && a.M.toString().trim() == m;
            });
            var MainDID = SiteLevel + '_OTHRDIVID_' + TopoCode + "_" + TopoName;
            $('[id="' + MainDID + '"]').empty();
            if (FilterLst.length > 0) {
                jQuery.grep(OtherFieldList, function (I) {
                    var uniqueMap = new Map();
                    FilterLst.forEach(function (e) {
                        if (e[I.ID].toString().trim() != "" && e[I.ID].toString().trim() != "-" && !uniqueMap.has(e[I.ID])) {
                            uniqueMap.set(e[I.ID], e);
                        }
                    });
                    var FiltLst = Array.from(uniqueMap.values());
                    if (FiltLst.length > 0) {
                        var CMBID = SiteLevel + '_' + I.ID + '_' + TopoId;
                        BindOtherDivContent(I.LABEL, CMBID, TopoCode, TopoName, SiteLevel, FiltLst, MainDID, I.ID);
                    }
                });
            }
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            FilterStageList(TopoCode, TopoName, SiteLevel);
            UpdateTNM(SiteLevel, TopoCode, TopoName);
        }

        function FilterStageList(TopoCode, TopoName, SiteLevel, FlagN) {
            var FilterLst = [];
            var AllFilterLst = [];
            var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var prefix = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName + '"]').val();
            var t = $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
            var n = $('[id="' + SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName + '"]').val();
            var m = $('[id="' + SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName + '"]').val();
            var Geographic = $('[id="' + SiteLevel + '_GEOGRAPHIC_' + TopoCode + "_" + TopoName + '"]').val();
            var Location = $('[id="' + SiteLevel + '_LOCATION_' + TopoCode + "_" + TopoName + '"]').val();
            var Mitotic = $('[id="' + SiteLevel + '_MITOTIC_' + TopoCode + "_" + TopoName + '"]').val();
            var PSA = $('[id="' + SiteLevel + '_PSA_' + TopoCode + "_" + TopoName + '"]').val();
            var SerumMarkers = $('[id="' + SiteLevel + '_SERUMMARKERS_' + TopoCode + "_" + TopoName + '"]').val();
            var HeritableTrait = $('[id="' + SiteLevel + '_HERITABLETRAIT_' + TopoCode + "_" + TopoName + '"]').val();
            var HER2 = $('[id="' + SiteLevel + '_HER2_' + TopoCode + "_" + TopoName + '"]').val();
            var ER = $('[id="' + SiteLevel + '_ER_' + TopoCode + "_" + TopoName + '"]').val();
            var PR = $('[id="' + SiteLevel + '_PR_' + TopoCode + "_" + TopoName + '"]').val();
            var Bloodinvl = $('[id="' + SiteLevel + '_BLOODINVL_' + TopoCode + "_" + TopoName + '"]').val();
            var SVal = "";
            let uniqueMap = new Map();
            var FiltLst = [];
            if (site != "" && subsite != "" && prefix != "" && t != "" && n != "" && m != "") {
                if (TNMNotFilter != "Y") {
                    AllStageList.forEach(function (e) {
                        if (
                            e.SITE.toString().trim() == site &&
                            e.SUBSITE.toString().trim() == subsite &&
                            e.PC.toString().trim() == prefix &&
                            e.T.toString().trim() == t &&
                            e.N.toString().trim() == n &&
                            e.M.toString().trim() == m &&
                            !uniqueMap.has(e.STAGE)
                        ) {
                            uniqueMap.set(e.STAGE, e);
                        }
                        if (e.SITE.toString().trim() == site &&
                            e.SUBSITE.toString().trim() == subsite &&
                            e.PC.toString().trim() == prefix &&
                            e.T.toString().trim() == t &&
                            e.N.toString().trim() == n &&
                            e.M.toString().trim() == m)
                            FiltLst.push(e);
                    });
                    //FilterLst = Array.from(uniqueMap.values());
                    FilterLst = FiltLst;
                    AllFilterLst = Array.from(uniqueMap.values());
                }
                else {
                    AllStageList.forEach(function (e) {
                        if (
                            e.SITE.toString().trim() == site &&
                            e.SUBSITE.toString().trim() == subsite &&
                            e.PC.toString().trim() == prefix &&
                            !uniqueMap.has(e.STAGE)
                        ) {
                            uniqueMap.set(e.STAGE, e);
                        }
                        if (
                            e.SITE.toString().trim() == site &&
                            e.SUBSITE.toString().trim() == subsite &&
                            e.PC.toString().trim() == prefix
                            )
                            FiltLst.push(e);
                    });
                }
                //FilterLst = Array.from(uniqueMap.values());
                FilterLst = FiltLst;
                AllFilterLst = Array.from(uniqueMap.values());
            }
            else {
                if (TNMNotFilter == "Y") {
                    AllStageList.forEach(function (e) {
                        if (
                            e.SITE.toString().trim() == site &&
                            e.SUBSITE.toString().trim() == subsite &&
                            e.PC.toString().trim() == prefix &&
                            !uniqueMap.has(e.STAGE)
                        ) {
                            uniqueMap.set(e.STAGE, e);
                        }
                        if (
                            e.SITE.toString().trim() == site &&
                            e.SUBSITE.toString().trim() == subsite &&
                            e.PC.toString().trim() == prefix
                            )
                            FiltLst.push(e);
                    });
                    //FilterLst = Array.from(uniqueMap.values());
                    FilterLst = FiltLst;
                    AllFilterLst = Array.from(uniqueMap.values());
                }
            }
            var FRows = FilterLst.filter(function (a) {
                return (Geographic == undefined || Geographic == "" || Geographic == "-" || a.GEOGRAPHIC.toString().trim() == Geographic)
                    && (Location == undefined || Location == "" || Location == "-" || a.LOCATION.toString().trim() == Location)
                    && (Mitotic == undefined || Mitotic == "" || Mitotic == "-" || a.MITOTIC.toString().trim() == Mitotic)
                    && (PSA == undefined || PSA == "" || PSA == "-" || a.PSA.toString().trim() == PSA)
                    && (SerumMarkers == undefined || SerumMarkers == "" || SerumMarkers == "-" || a.SERUMMARKERS.toString().trim() == SerumMarkers)
                    && (HeritableTrait == undefined || HeritableTrait == "" || HeritableTrait == "-" || a.HERITABLETRAIT.toString().trim() == HeritableTrait)
                    && (HER2 == undefined || HER2 == "" || HER2 == "-" || a.HER2.toString().trim() == HER2)
                    && (ER == undefined || ER == "" || ER == "-" || a.ER.toString().trim() == ER)
                    && (PR == undefined || PR == "" || PR == "-" || a.PR.toString().trim() == PR)
                    && (Bloodinvl == undefined || Bloodinvl == "" || Bloodinvl == "-" || a.BLOODINVL.toString().trim() == Bloodinvl);
            });
            var Flag = false;
            if (FRows.length == 1) {
                SVal = FRows[0].STAGE;
            }
            else if (FRows.length == 0) {
                FRows = AllFilterLst;
                //var DefOpt = {
                //    STAGE: "Cannot be Assessed",
                //    CODE: "-"
                //}
                //Flag = true;
                //FilterLst.push(DefOpt);
                //SVal = FilterLst[0].CODE;
            }
            else if (FRows.length != AllFilterLst.length) {
                let uniqueRMap = new Map();
                FRows.forEach(function (e) {
                    if (
                        !uniqueRMap.has(e.STAGE)) {
                        uniqueRMap.set(e.STAGE, e);
                    }
                });
                FRows = Array.from(uniqueRMap.values());
            }
            else {
                FRows = AllFilterLst;
            }
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            if (TNMNotFilter != "Y") {
                BindComboList(SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName, FRows, (Flag == true ? "CODE" : "STAGE"), "STAGE");
                $('[id="' + SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName + '"]').val(SVal);
            }
            else {
                if (FlagN == "Y") {
                    BindComboList(SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName, FRows, (Flag == true ? "CODE" : "STAGE"), "STAGE");
                    $('[id="' + SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName + '"]').val(SVal);
                }
            }

            UpdateTNM(SiteLevel, TopoCode, TopoName);
        }

        function BindComboList(ComboId, ListData, PropVal, PropText) {
            $('[id="' + ComboId + '"]').empty();
            var Option = '<option value="{VALUE}">{TEXT}</option>';
            var DefSel = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
            $('[id="' + ComboId + '"]').append(DefSel);
            jQuery.grep(ListData, function (e) {
                var Options = Option.replace("{VALUE}", e[PropVal]).replace("{TEXT}", e[PropText]);
                $('[id="' + ComboId + '"]').append(Options);
            });
            $('[id="' + ComboId + '"]').val("");
        }

        function BindDescriptionList(TopoCode, TopoName, SiteLevel) {
            var TNMHeaderLblId = SiteLevel + "_TNM_HEADER_LBL_" + TopoCode + "_" + TopoName;
            var TBodyId = SiteLevel + "_TTBody_" + TopoCode + "_" + TopoName;
            var NBodyId = SiteLevel + "_NTBody_" + TopoCode + "_" + TopoName;
            var MBodyId = SiteLevel + "_MTBody_" + TopoCode + "_" + TopoName;
            $('[id="' + TBodyId + '"]').empty();
            $('[id="' + NBodyId + '"]').empty();
            $('[id="' + MBodyId + '"]').empty();
            var siteVal = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var subSiteVal = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var PrefixVal = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName + '"]').val();
            document.getElementById(TNMHeaderLblId).innerText = "";
            if (siteVal == "" || subSiteVal == "" || PrefixVal == "") {
                return false;
            }
            document.getElementById(TNMHeaderLblId).innerText = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"] option:selected').text() + " - " + $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"] option:selected').text();
            var FilterTListDesc = AllDescList.filter(function (e) { return e.SITE.toString().trim() == siteVal && e.SUBSITE.toString().trim() == subSiteVal && e.PC.toString().trim() == PrefixVal && e.TNM.toString().trim().includes("T"); });
            var FilterNListDesc = AllDescList.filter(function (e) { return e.SITE.toString().trim() == siteVal && e.SUBSITE.toString().trim() == subSiteVal && e.PC.toString().trim() == PrefixVal && e.TNM.toString().trim().includes("N"); });
            var FilterMListDesc = AllDescList.filter(function (e) { return e.SITE.toString().trim() == siteVal && e.SUBSITE.toString().trim() == subSiteVal && e.PC.toString().trim() == PrefixVal && e.TNM.toString().trim().includes("M"); });
            var TR = "<tr>{TRCONTENT}</tr>";
            var TD = "<td {CLASS}>{TDCONTENT}</td>";
            jQuery.grep(FilterTListDesc, function (e) {
                var TNMName = TD.replace("{TDCONTENT}", e.TNM.toString().trim()).replace("{CLASS}", "class='FirstTDClass'");
                var Desc = TD.replace("{TDCONTENT}", e.DESCRIPTION.toString().trim()).replace("{CLASS}", "");
                var RplTR = TR.replace("{TRCONTENT}", (TNMName + Desc));
                $('[id="' + TBodyId + '"]').append(RplTR);
            });
            jQuery.grep(FilterNListDesc, function (e) {
                var TNMName = TD.replace("{TDCONTENT}", e.TNM.toString().trim()).replace("{CLASS}", "class='FirstTDClass'");
                var Desc = TD.replace("{TDCONTENT}", e.DESCRIPTION.toString().trim()).replace("{CLASS}", "");
                var RplTR = TR.replace("{TRCONTENT}", (TNMName + Desc));
                $('[id="' + NBodyId + '"]').append(RplTR);
            });
            jQuery.grep(FilterMListDesc, function (e) {
                var TNMName = TD.replace("{TDCONTENT}", e.TNM.toString().trim()).replace("{CLASS}", "class='FirstTDClass'");
                var Desc = TD.replace("{TDCONTENT}", e.DESCRIPTION.toString().trim()).replace("{CLASS}", "");
                var RplTR = TR.replace("{TRCONTENT}", (TNMName + Desc));
                $('[id="' + MBodyId + '"]').append(RplTR);
            });
            var P = SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName;
            var t = SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName;
            var n = SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName; 
            var m = SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName;
            var Stage = SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName;
            if (TNMNotFilter == "Y") {
                var FilterPrefix = AllStageList.filter(function (e) { return e.SITE.toString().trim() == siteVal && e.SUBSITE.toString().trim() == subSiteVal; });
                BindComboList(P, FilterPrefix, "PC", "PC");
                BindComboList(t, FilterTListDesc, "TNM", "TNM");
                BindComboList(n, FilterNListDesc, "TNM", "TNM");
                BindComboList(m, FilterMListDesc, "TNM", "TNM");
                FilterStageList(TopoCode, TopoName, SiteLevel, "Y");
            }
        }

        function AppendListToCombo(ComboId, ListData) {
            var Option = '<option value="{VALUE}">{TEXT}</option>';
            var DefSel = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
            $('[id="' + ComboId + '"]').append(DefSel);
            jQuery.grep(ListData, function (e) {
                var Options = Option.replace("{VALUE}", e.Value).replace("{TEXT}", e.Text);
                $('[id="' + ComboId + '"]').append(Options);
            });
        }

        function ValidationTNM(MsgYN, TopoCode, TopoName, SiteLevel) {
            var Site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var SubSite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var Stage = $('[id="' + SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName + '"]').val();

            if (Site != "") {
                if (SubSite == "") {
                    $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').focus().css("border-color", "red");
                    HoldOn.close();
                    return false;
                }
                if (Stage == "") {
                    if (MsgYN == "Y")
                        $.messager.alert("Information", "Please Select T , N , M.");
                    HoldOn.close();
                    return false;
                }
            }
            return true;
        }

        function UpdateTNM(SiteLevel, TopoCode, TopoName) {
            var Site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var SubSite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var T = $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
            var N = $('[id="' + SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName + '"]').val();
            var M = $('[id="' + SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName + '"]').val();
            var Stage = $('[id="' + SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName + '"]').val();
            var PrefixComboId = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName + '"]').val();
            var Geographic = $('[id="' + SiteLevel + '_GEOGRAPHIC_' + TopoCode + "_" + TopoName + '"]').val();
            var Location = $('[id="' + SiteLevel + '_LOCATION_' + TopoCode + "_" + TopoName + '"]').val();
            var Mitotic = $('[id="' + SiteLevel + '_MITOTIC_' + TopoCode + "_" + TopoName + '"]').val();
            var PSA = $('[id="' + SiteLevel + '_PSA_' + TopoCode + "_" + TopoName + '"]').val();
            var SerumMarkers = $('[id="' + SiteLevel + '_SERUMMARKERS_' + TopoCode + "_" + TopoName + '"]').val();
            var HeritableTrait = $('[id="' + SiteLevel + '_HERITABLETRAIT_' + TopoCode + "_" + TopoName + '"]').val();
            var HER2 = $('[id="' + SiteLevel + '_HER2_' + TopoCode + "_" + TopoName + '"]').val();
            var ER = $('[id="' + SiteLevel + '_ER_' + TopoCode + "_" + TopoName + '"]').val();
            var PR = $('[id="' + SiteLevel + '_PR_' + TopoCode + "_" + TopoName + '"]').val();
            var Bloodinvl = $('[id="' + SiteLevel + '_BLOODINVL_' + TopoCode + "_" + TopoName + '"]').val();
            jQuery.grep(ICDOTopoList, function (e) {
                if (e.SITELEVEL == SiteLevel && e.TOPOCODE == TopoCode && e.TOPODESC == TopoName) {
                    e.TNMSITECODE = Site;
                    e.TNMSUBSITECODE = SubSite;
                    e.TNMPREFIX = PrefixComboId;
                    e.T = T;
                    e.N = N;
                    e.M = M;
                    e.STAGE = Stage;
                    e.GEOGRAPHIC = Geographic == undefined || Geographic == null ? "" : Geographic;
                    e.LOCATION = Location == undefined || Location == null ? "" : Location;
                    e.MITOTIC = Mitotic == undefined || Mitotic == null ? "" : Mitotic;
                    e.PSA = PSA == undefined || PSA == null ? "" : PSA;
                    e.SERUMMARKERS = SerumMarkers == undefined || SerumMarkers == null ? "" : SerumMarkers;
                    e.HERITABLETRAIT = HeritableTrait == undefined || HeritableTrait == null ? "" : HeritableTrait;
                    e.HER2 = HER2 == undefined || HER2 == null ? "" : HER2;
                    e.ER = ER == undefined || ER == null ? "" : ER;
                    e.PR = PR == undefined || PR == null ? "" : PR;
                    e.BLOODINVL = Bloodinvl == undefined || Bloodinvl == null ? "" : Bloodinvl;
                }
            });
        }

        function ToggleTNM(ToggleType, HideId, BodyId, ShowId) {
            document.getElementById(HideId).style.display = "none";
            document.getElementById(BodyId).style.display = ToggleType == "D" ? "table-row-group" : "none";
            document.getElementById(ShowId).style.display = "inline-block";
        }
    </script>

    <style>
        #TNMInfoPopup {
            display: none;
            position: fixed;
            z-index: 1050;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            width: 80%;
            max-width: 800px;
            padding: 20px;
            animation: fadeIn 0.3s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translate(-50%, -45%);
            }

            to {
                opacity: 1;
                transform: translate(-50%, -50%);
            }
        }

        .TNMDescDiv {
            width: 100%;
        }

        .TNMHeadDiv {
            background-color: #005289;
            color: white;
            font-size: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .TNMHeadLbl {
            margin: 0px;
            padding: 5px;
        }

        .TNMCloseIcon {
            color: white;
            padding-right: 5px;
            font-size: 25px;
            cursor: pointer;
        }

            .TNMCloseIcon:hover {
                color: red;
            }
    </style>

    <%-- ICD-O History --%>
    <script type="text/javascript">
        var Test = [];
        function OpenCloseICDOHistory() {
            GetICDOHist();
            document.getElementById("POPUPHISTOInfoModal").style.display = "flex";
            document.documentElement.style.overflow = 'hidden';
        }

        function GetICDOHist() {
            var DataToSend = {
                MRNo: sessionStorage.getItem('PatMRNO')
            }
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetICDOHistoList",
                data: DataToSend,
                async: false,
                success: function (response) {
                    if (response[0] != null) {
                        Test = response;
                        BindICDOHist(response);
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
                },
            });
        }

        function BindICDOHist(HistoryLst) {
            $("#HistoryContentDiv").empty();
            var FDiv = '<div class="SepMainHistory">{FINALCONTENT}</div>';
            var SepMainHeaderLbl = '<label class="SepMainHeaderLbl">Consultation No.: {CONSULTNO} </label>';
            var ArrowDiv = '<div><i class="fa fa-chevron-circle-down DownUpHistoryIcon" style="display:none" id="{DOWNARROWID}"  onclick=\'ToggleHistoryContent("D","{INDEX}")\' ></i><i id="{UPARROWID}" class="fa fa-chevron-circle-up DownUpHistoryIcon" onclick=\'ToggleHistoryContent("U","{INDEX}")\' ></i></div>';
            var HeaderDiv = '<div class="SepMainHeaderDiv">{HEADERDIVCONT}</div>';
            var ContentDiv = '<div class="SepMainContentDiv" id="{CONTENTDIVID}">{CONTENTDIVCONT}</div>';
            var TopologyDiv = '<div class="SepTopoDiv"> <label class="SepTopoLbl">Topography - {HEADERTOPOCODE} - {HEADERTOPODESC}</label></div>';
            var HistoTblDiv = '<div class="SepHistoDiv"><div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto;"><div class="Tablewrapper" style="font-size: 12px; background: white;">{HISTOTABLECONTENT}</div></div></div>';
            var HistoTbl = '<table class="tblpopupList"><thead><tr><th>Code</th><th>Histo/Behaviour</th><th>Description</th><th>Grade</th></tr></thead><tbody>{HISTOTBODYCONTENT}</tbody></table>';
            var SiteSubSiteDiv = '<div class="SepSitSubMainDiv">{SITESUBSITECONTENT}</div>';
            var SiteDiv = '<div class="SepSitSubDiv"><label class="SepHistLbl">Site</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{SITECONTENT}</label></div>';
            var SubSiteDiv = '<div class="SepSitSubDiv"><label class="SepHistLbl">Sub-Site</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{SUBSITECONTENT}</label></div>';
            var PTNMDiv = '<div class="SepPTNMMainDiv">{PTNMMAINDIV}</div>';
            var PDiv = '<div class="SepPDiv"><label class="SepHistLbl">Prefix</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{PREFIX}</label></div>';
            var TDiv = '<div class="SepTDiv"><label class="SepTHistLbl">T</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{TCONTENT}</label></div>';
            var NDiv = '<div class="SepNDiv"><label class="SepTHistLbl">N</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{NCONTENT}</label></div>';
            var MDiv = '<div class="SepMDiv"><label class="SepTHistLbl">M</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{MCONTENT}</label></div>';
            var StageMainDiv = '<div class="SepStageMainDiv">{STAGEMAINCONTENT}</div>';
            var StageDiv = '<div class="SepStageDiv"><label class="SepHistLbl">Stage</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{STAGECONTENT}</label></div>';
            var DotHr = '<hr style="border-top: 1px dotted black;" />';
            var LineHr = '<hr style="border-top: 1px solid black;margin: 0px;" />';
            var HistoryTList = HistoryLst[0];
            var HistoryHList = HistoryLst[1] == null ? [] : HistoryLst[1];
            var HistoryCList = HistoryLst[2];
            var Ind = 1;
            jQuery.grep(HistoryCList, function (C) {
                var FilterHistoryTList = HistoryTList.filter(function (a) {
                    return a.REFTRANNO.toString().trim() == C.REFTRANNO.toString().trim();
                });
                var AllData = "";
                var DownArrowId = "HIST_DOWNID_" + Ind;
                var UpArrowId = "HIST_UPID_" + Ind;
                var ContentId = "HIST_CONTENT_" + Ind;
                var ConsultInfo = C.REFTRANNO + " - " +C.CREATEDBY + " (" + C.CREATEDON + " - " + C.CREATEDAT + ")";
                //var RplSepMainHeaderLbl = SepMainHeaderLbl.replace("{CONSULTNO}", (C.REFTRANNO + " (" + C.CREATEDON + " - " + C.CREATEDAT + ")"));
                var RplSepMainHeaderLbl = SepMainHeaderLbl.replace("{CONSULTNO}", ConsultInfo);
                var RplArrowDiv = ArrowDiv.replace("{DOWNARROWID}", DownArrowId).replace("{INDEX}", Ind).replace("{UPARROWID}", UpArrowId).replace("{INDEX}", Ind);
                var RplHeaderDiv = HeaderDiv.replace("{HEADERDIVCONT}", (RplSepMainHeaderLbl + RplArrowDiv));
                jQuery.grep(FilterHistoryTList, function (e) {
                    var RplTopologyDiv = TopologyDiv.replace("{HEADERTOPOCODE}", (e.TOPOCODE)).replace("{HEADERTOPODESC}", (e.TOPODESC));
                    var FilterHisto = HistoryHList.filter(function (h) {
                        return e.MRNO.toString().trim() == h.MRNO.toString().trim() && e.SITELEVEL.toString().trim() == h.SITELEVEL.toString().trim()
                            && e.TOPOCODE.toString().trim() == h.TOPOCODE.toString().trim() && e.TOPOTYPE.toString().trim() == h.TOPOTYPE.toString().trim() && e.REFTRANNO.toString().trim() == h.REFTRANNO.toString().trim();
                    });
                    var HistoDtls = "";
                    var Tr = '<tr><td style="text-align: center;">{ICDOCODE}</td><td style="text-align: center;">{HISTOCODE}</td><td>{HISTODESC}</td><td>{HISTOGRADE}</td></tr>';
                    jQuery.grep(FilterHisto, function (k) {
                        var ICDOCode = k.TOPOCODE + k.HCODE + " " + k.HGRADE;
                        var RplTr = Tr.replace("{ICDOCODE}", (ICDOCode)).replace("{HISTOCODE}", (k.HCODE)).replace("{HISTODESC}", (k.HDESC)).replace("{HISTOGRADE}", (k.GRADENAME));
                        HistoDtls = HistoDtls + RplTr;
                    });
                    var RplHistoTblDiv = "";
                    if (HistoDtls != "") {
                        var RplHistoTbl = HistoTbl.replace("{HISTOTBODYCONTENT}", (HistoDtls));
                        RplHistoTblDiv = HistoTblDiv.replace("{HISTOTABLECONTENT}", (RplHistoTbl));
                    }
                    var RplSiteDiv = SiteDiv.replace("{SITECONTENT}", (e.TNMSITE));
                    var RplSubSiteDiv = SubSiteDiv.replace("{SUBSITECONTENT}", (e.TNMSUBSITE));
                    var RplSiteSubSiteDiv = SiteSubSiteDiv.replace("{SITESUBSITECONTENT}", (RplSiteDiv + RplSubSiteDiv));
                    var RplPDiv = PDiv.replace("{PREFIX}", (e.TNMPREFIX));
                    var RplTDiv = TDiv.replace("{TCONTENT}", (e.T));
                    var RplNDiv = NDiv.replace("{NCONTENT}", (e.N));
                    var RplMDiv = MDiv.replace("{MCONTENT}", (e.M));
                    var RplPTNMDiv = PTNMDiv.replace("{PTNMMAINDIV}", (RplPDiv + RplTDiv + RplNDiv + RplMDiv));
                    var RplOthrDiv = BindotherFieldHistory(e);
                    var RplStageDiv = StageDiv.replace("{STAGECONTENT}", (e.STAGE));
                    var RplStageMainDiv = StageMainDiv.replace("{STAGEMAINCONTENT}", RplStageDiv);
                    AllData = AllData + (AllData == "" ? "" : DotHr) + RplTopologyDiv + RplHistoTblDiv + RplSiteSubSiteDiv + RplPTNMDiv + RplOthrDiv + RplStageMainDiv;
                });
                var RemarkDiv = '<div class="SepStageMainDiv"><div class="SepRemarkDiv"><label class="SepRemarkLbl">Remark</label><label class="SeparateHistory">:</label><label class="SepRemarkTxt">{REMARKCONTENT}</label></div></div>'
                var RplRemarkDiv = LineHr + RemarkDiv.replace("{REMARKCONTENT}", (C.REMARKS));
                AllData = AllData + RplRemarkDiv;
                var RplContentDiv = ContentDiv.replace("{CONTENTDIVID}", (ContentId)).replace("{CONTENTDIVCONT}", (AllData));
                var RplFDiv = FDiv.replace("{FINALCONTENT}", (RplHeaderDiv + RplContentDiv));
                $("#HistoryContentDiv").append(RplFDiv);
                Ind++;
            });
        }

        function BindotherFieldHistory(OtherFLst) {
            var Div = '<div class="SepODiv" {STYLE}><label class="SepHistLbl">{LABEL}</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{CONTENT}</label></div>';
            var Count = 0;
            var MaxCount = 4;
            var filledList = [];
            var emptyList = [];
            $.each(OtherFieldList, function (i, O) {
                var val = OtherFLst[O.ID];
                if (val != undefined && val != null && val.toString().trim() != "" && val.toString().trim() != "-") {
                    filledList.push(O);
                } else {
                    emptyList.push(O);
                }
            });
            var AllCont = "";
            var orderedList = filledList.concat(emptyList);
            var groupContent = "";
            var hasVisibleItem = false;
            $.each(orderedList, function (i, O) {
                var val = OtherFLst[O.ID];
                var isFilled = (val != undefined && val != null && val.toString().trim() != "" && val.toString().trim() != "-");
                if (Count === 0) {
                    groupContent = "";
                    hasVisibleItem = false;
                }
                var content = isFilled ? val : "";
                var visibility = isFilled ? "" : ' style="visibility:hidden;"';
                var RplCont = Div.replace("{LABEL}", O.LABEL)
                                 .replace("{CONTENT}", content)
                                 .replace("{STYLE}", visibility);
                groupContent += RplCont;
                if (isFilled) hasVisibleItem = true;
                Count++;
                if (Count === MaxCount || i === orderedList.length - 1) {
                    if (hasVisibleItem) {
                        AllCont += '<div class="SepPTNMMainDiv">' + groupContent + '</div>';
                    }
                    Count = 0;
                }
            });
            return AllCont;
        }

        function ToggleHistoryContent(Type, Ind) {
            var ContentId = "HIST_CONTENT_" + Ind;
            var DownArrowId = "HIST_DOWNID_" + Ind;
            var UpArrowId = "HIST_UPID_" + Ind;
            document.getElementById(ContentId).style.display = Type == "U" ? "none" : "block";
            document.getElementById(DownArrowId).style.display = Type == "U" ? "inline-block" : "none";
            document.getElementById(UpArrowId).style.display = Type == "U" ? "none" : "inline-block";
        }
    </script>

    <style>
        .SepMainHistory {
            margin: 0px 5px 10px 5px;
        }

        .SepMainHeaderDiv {
            background-color: #006015;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 5px;
            border: 1px solid #686868;
        }

        .SepMainHeaderLbl {
            margin: 0px;
            font-size: 14px;
        }

        .DownUpHistoryIcon {
            font-size: 16px;
        }

        .SepMainContentDiv {
            border:1px solid #898989;
        }

        .SepTopoDiv {
            padding: 5px;
            font-size: 12px;
        }

        .SepTopoLbl {
            margin: 0px;
        }

        .SepHistoDiv {
            padding: 5px;
        }

        .SepSitSubMainDiv {
            display: flex;
            padding: 5px;
            font-size: 12px;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .SepHistLbl {
            margin: 0px;
            width: 90px;
        }

        .SepTHistLbl {
            margin: 0px;
            width: 25px;
        }

        .SepHistTxt {
            margin: 0px;
            min-width: 60px;
        }

        .SeparateHistory {
            margin: 0px;
            padding: 0px 5px;
        }

        .SepPTNMMainDiv {
            display: flex;
            padding: 5px;
            font-size: 12px;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .SepStageMainDiv {
            display: flex;
            padding: 5px;
            font-size: 12px;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .SepRemarkDiv{
                display: flex;
        }
        .SepRemarkLbl {
            margin: 0px;
            width: 50px;
        }
        .SepRemarkTxt{
            text-wrap-mode: wrap;
        }
    </style>
</asp:Content>