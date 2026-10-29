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
                <%--    <div class="InputWrapper">--%>
                  <div class="StuckInput" style="margin-top: -18px;">
                    <label id="myAdd" style="background-color: transparent; float: left; margin-left: -8px;  margin-right: 24px; border-color: transparent;" title="Go to top"> <%-- r margntop--%>
                        <img src="../Images/add.png" style="background-color: white; border-radius: 50%;margin-top: 4px; position: fixed;">
                    </label>
                    <%----%>
                      <input type="text" id="DiagnosisInput" onkeyup="SearchDiagnosis()" placeholder="&#xF002; Search Diagnosis" style="float: left; height: 28px; width: 50%; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-left: 10px; margin-top: 4px;" class="empty"><%----%>
                      <div style="display: flex; justify-content: flex-start; width: 100%;display:none" id="ICDDiagnosis">
                          <input type="text" id="ICDDiagnosisInput" onkeyup="SearchICDDiagnosis('ICDDiagnosisInput','tblICDdiagno')" placeholder="&#xF002; Search ICD Diagnosis" style="float: left; height: 28px; width: 200px; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 4px;" class="empty">
                          <input type="text" id="ICDDiagnosisOInput" onkeyup="SearchICDDiagnosis('ICDDiagnosisOInput','tblICDdiagnoO')" placeholder="&#xF002; Search ICD Diagnosis - O" style="margin-left: 15px;float: left; height: 28px; width: 200px; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 4px;" class="empty">
                      </div>
                        <button id='btnProvDiag' style="display:none; border-radius: 50%; height: 30px; width: 28px; color: white; margin-top: 3px; margin-left:3px; background-color: #398ebd; border-color: transparent; outline-style: none;" title="Save Provisional Diagnosis"><span><i class="fa fa-pencil"></i></span></button>
                  </div>
                <%--   </div>--%>
                <div style="height: 5px"></div>
                <div class="nav-tabs-custom" style="margin-bottom: 0px !important;margin-top:13px;">
                    <ul class="nav nav-tabs">
                        <li class="active"><a id="Diagno" class="Diagnosis" data-toggle="tab" aria-expanded="true">Diagnosis</a></li>
                        <li class=""><a id="ICDDiag" href="#DateWise" class="ICDDiagno" data-toggle="tab" aria-expanded="false">ICD Diagnosis</a></li>
                        <li class=""><a id="ICDTNM" class="ICDTNM" data-toggle="tab" aria-expanded="false">TNM</a></li>
                        <%--Added By Priyanka--%>
                        <li class="">
                        <%--<label id="PersICDDiag" style="background-color: transparent;border-color: transparent; display:block;" title="Save" onclick="CreateICDDiagSetupList()" class="PersBtn"></label>--%>
                        <%--<button type="button" id="PersICDDiag" class="btn btn-info margin" style="position: fixed; display:none; padding: 2px 12px; font-size: 14px; margin-left: 5px; margin-top:auto;""  onclick="CreateICDDiagSetupList()">Pers ICD Diag...</button>--%>
                        <button type="button" id="PersICDDiag" class="btn btn-info margin" style="font-size: 14px; margin-top:auto;"  onclick="CreateICDDiagSetupList()">Pers ICD Diag...</button>

                        </li>
                         <%--Added By Priyanka on 13/02/2025--%>
                        <li class="">
                        <%--<button type="button" id="PersDiag" class="btn btn-info margin" style="position: fixed; display:none; padding: 2px 12px; font-size: 14px; margin-left: 5px; margin-top:auto;""  onclick="CreateDiagnosisSetupList()">Pers Diag...</button>--%>
                        <button type="button" id="PersDiag" class="btn btn-info margin" style="font-size: 14px;margin-top:auto;"  onclick="CreateDiagnosisSetupList()">Pers Diag...</button>
                        </li>
                        <li class="" style="float: right;">
                            <label id="myBtn" style="background-color: transparent; float: right; margin-right: 25%; border-color: transparent;" title="Save" onclick="backtoHome();">
                                <img src="../Images/check-round.png" style="float: right; margin-bottom: 10px; background-color: white; border-radius: 50%;">
                            </label>
                        </li>
                    </ul>
                    <!-- /.tab-content -->
                </div>
                    <div id="wrapper" style="overflow: hidden; width: 100%">
                    <div class="tableDiv" style="padding-top: 5px;">

                        <%-- 4/22/19--%>
                         <table class="HeadPatTab" style="text-align:center" id="HeadDiog"><thead> <tr style="background-color:#fffdc8"><th style="width: 90%;">Diagnosis</th><th class='HeadRemark' style="">Remark</th></tr></thead>
                        
                        </table><%-- 4/22/19--%>
                        <table id="tbldiagno" class="table HeadPatTab" style="width: 100%;font-size: 14px;">
                            <tbody id="tblsort" style="height:100%;"></tbody><%--tblsort added vijeta 19/4/19--%>
                        </table>
                         <table class="HeadPatTab" style="text-align:center;display:none" id="HeadDiog1"><thead> <tr style="background-color:#fffdc8"><th style="width: 101%;">Diagnosis</th></tr></thead>
                        
                        </table><%-- 4/11/19--%>
                        <table id="tblICDdiagno" class="table HeadPatTab" style="width: 100%;display:none;font-size: 14px;"> <%----%>
                            <tbody id="tblsort1" style="height:100%;"></tbody><%--tblsort added vijeta 19/4/19--%>
                            </table>
                        <%-- end--%>

                        <table class="HeadPatTab" style="text-align:center;" id="HeadDiog2"><thead> <tr style="background-color:#fffdc8"><th style="width: 101%;">Diagnosis - O</th></tr></thead></table>
                        <table id="tblICDdiagnoO" class="table HeadPatTab" style="width: 100%;font-size: 14px;">
                            <tbody id="tblsort2" style="height:100%;"></tbody>
                        </table>

                        <div id="DivICDTNM" class="TMNMainDiv" style="display:none;">
                            <div class="col-xs-12" style="padding: 0px;">
                                <div class="col-md-4" style="padding: 0px 0px 0px 15px;background-color: #ffffff;">
                                    <div class="TMNDiv">
                                        <label class="TMNLabel">Site</label>
                                        <select id="CmbSiteList" onchange="GetSubSiteList();ClearDescTable();" class="form-control"></select>
                                    </div>
                                    <div class="TMNDiv">
                                        <label class="TMNLabel">Sub-Site</label>
                                        <select id="CmbSubSiteList" onchange="GetTNMList();FilterTList();ClearDescTable();BindDescriptionList();" class="form-control"></select>
                                    </div>
                                    <div class="TMNDiv">
                                        <label class="TMNLabel">T</label>
                                        <select id="ICDTList" onchange="FilterNList();" class="form-control"></select>
                                    </div>
                                    <div class="TMNDiv">
                                        <label class="TMNLabel">N</label>
                                        <select id="ICDNList" onchange="FilterMList();"  class="form-control"></select>
                                    </div>
                                    <div class="TMNDiv">
                                        <label class="TMNLabel">M</label>
                                        <select id="ICDMList" onchange="FilterStageList();"  class="form-control"></select>
                                    </div>
                                    <div class="TMNDiv">
                                        <label class="TMNLabel">Stage</label>
                                        <select id="CmbStageList" class="form-control"></select>
                                    </div>
                                </div>
                                <div class="col-md-8" style="padding: 0px 0px 0px 15px;display:none;" id="DIV_TNMDesc">
                                    <div class="TNMDescDiv" style="padding: 0px;">
                                        <div class="table-responsive custom-scroll-container">
                                            <table id="TDescTbl" class="table custom-table">
                                                <thead id="TTHead"><tr><td colspan="2">Primary Tumor(T)</td></tr></thead>
                                                <tbody id="TTBody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="TNMDescDiv" style="padding: 0px;">
                                        <div class="table-responsive custom-scroll-container">
                                            <table id="NDescTbl" class="table custom-table">
                                                <thead id="NTHead"><tr><td colspan="2">Regional Lymph Nodes(N)</td></tr></thead>
                                                <tbody id="NTBody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="TNMDescDiv" style="padding: 0px;">
                                        <div class="table-responsive custom-scroll-container">
                                            <table id="MDescTbl" class="table custom-table">
                                                <thead id="MTHead"><tr><td colspan="2">Distant Metastasis(M)</td></tr></thead>
                                                <tbody id="MTBody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                  <div id="griddet" class="jqGrid" style="display:none;"> <%--style="display:none;" added by vijeta on 24th may 2018 --%>
                    <label id="closebtn" style="background-color: transparent; float: right; margin-right: 25px; margin-top: 0px;border-color: transparent;" title="Close">
                    <img src="../Images/icon.png" style="background-color: white; border-radius: 50%; position: fixed; z-index: 1000;">
                        </label>
                    <table id="gvtable">
                    </table>
                    <div id="Pagerr"></div>
                </div>
                <div id="layer-demo" class="po__layer list">
                    <%--<a href="javascript:;">0</a>   --%>
                </div>
                <div id="layer-DMY" class="po__layer list">
                    <a href="javascript:;" style="text-decoration: none;" onclick="SetText('D')">Days</a>
                    <a href="javascript:; " style="text-decoration: none;" onclick="SetText('M')">Months</a>
                    <a href="javascript:;" style="text-decoration: none;" onclick="SetText('Y')">Years</a>
                </div>
            </div>
        </div>
    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .nav-tabs-custom > .nav-tabs > li.active >a{
        background-color:#d2d6de;
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
            font-size: 16px !important; /*added by vijeta on 22nd march 2018*/
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

        /*added by vijeta on 22nd march 2018*/
        .empty {
            width: 62%;
        }

        /*added by vijeta on 22nd march 2018*/
     
        /*added by vijeta on 22nd march 2018*/
        @media only screen and (min-width : 992px) {
            .empty {
                width: 59%;
            }
        }

                .HeadRemark{
  width:10.5%;
        }
        
        /*4/22/19*/
        @media only screen and (min-device-width : 1024px)and (max-device-width : 1152px){

             .HeadRemark{
 width:10.8% 
        }
        }
        /*added by vijeta on 22nd march 2018*/
        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            .empty{
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
            text-align:center;
        }
         #tbldiagno tr td:not(:first-child) a{
            width: 98%;
            /*display:block;*/
        }
         /*4/22/19*/
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
                    border-color:white;
                }
        }



        .divtblICDDiagnosisSetup {
            height: 600px;
            /*border-color:white;*/
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
            /*border-color:white;*/
        }

        div.divtblICDDiagnosisSetup:hover {
            overflow-y: scroll;
        }

         @media (min-width: 992px) {
             .jconfirm-box-container {
                margin-left: 25.333333%;
            }
        }/*//3/28/19*/
        @media only screen and (min-width: 1400px) {
            .jc-bs3-row {
                margin-left: -6px;
            }
        }




         /*#tblinvestigate tr td:not(:first-child) {
            width: 10%;
            text-align:center;
        }
         #tblinvestigate tr td:not(:first-child) a{
            width: 98%;
            display:block;
        }*/

        #tblPersICDDiagnolist > tbody > tr > td {
            /*border-top: 1px solid rgba(234, 228, 228, 0.32) !important;*/
           border: 1px solid rgba(234, 228, 228, 0.32) !important;
        }
        .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
            color: #000;
            font-weight: normal;
            font-size: small; /*added by vijeta on 22nd sep 2018*/
        }

         #tblPersDiagnolist > tbody > tr > td {
            /*border-top: 1px solid rgba(234, 228, 228, 0.32) !important;*/
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
                    border-color:white;
                }
        }



        .divtblDiagnosisSetup {
            height: 600px;
            /*border-color:white;*/
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
            /*border-color:white;*/
        }

        div.divtblDiagnosisSetup:hover {
            overflow-y: scroll;
        }
    </style>

    <%-- TNM Style --%>
    <style>
        .TMNMainDiv {
            display: flex;
            align-items: flex-start;
            min-width: 250px;
            flex-direction: column;
        }

        .TMNDiv {
            display: flex;
            align-items: center;
            min-width: 250px;
            padding: 10px 0px;
        }

        .TMNLabel {
            min-width: 60px;
        }

        .custom-table {
            width: 100%;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
            font-size: 14px;
            background-color: #fff;
        }
            .custom-table thead {
                position: sticky;
                top: 0;
            }

            .custom-table thead td {
                text-align: center;
                background-color: #3b5998;
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

        .FirstTDClass{
            width:60px;
        }
    </style>

    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/jquery-ui-touch-punch.js"></script>
    <script src="../Scripts/PatList.js"></script>
     <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>

    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var newlyAddedDiagno = "";
        var idOfDMY = "";
        var FreqDataSetupList = "";
        var gporvFiagnosis = "";
        var gCompositStage = "";
        var gTtStage = "";
        var gNtStage = "";
        var gMtStage = "";
        var addclick = false;
        var OpenProvDiagOnLoad = '<%:@System.Configuration.ConfigurationManager.AppSettings["OpenProvDiagOnLoad"]%>'; //meenakshi 
        var srvcgrpname = "dblServiceHelpsrvcgrp"; //Added By Priyanka
        var srvcdiaggrpname = "dblServiceDiagHelpsrvcgrp";//Added By Priyanka on 14/02/2025
        var addedDiagSetupCodes = []; // added by priyanka on 18/02/2025
        var addedIcdSetupCodes = []; // added by priyanka on 18/02/2025
        var SetupNameICDDiagText = ""; //added by priyanka on 20/02/2025
        var SetupNameDiagText = ""; //added by priyanka on 20/02/2025
        var MapDiagSetupCodes = new Map();//added by priyanka on 20/02/2025
        var MapICDDiagSetupCodes = new Map();//added By Priyanka on 20/02/2025
        $(document).ready(function (e) {
            HoldOn.open();//
            SetPatientDtl();
            LoadFormTNM();
            document.getElementById('DiagnosisInput').focus(); //added by kavita
            // AddClinics(urls);//commented vijeta 30/4/19
            AddDiagnosis(addclick);
            AddICDDiagnosis();
            $("#PersICDDiag").hide(); //Added By Priyanka
            $("#PersDiag").show(); //Added By Priyanka on 13/02/2025
            //debugger;
            //Added By Priyanka Activate Tab Start on 28/01/2025
            var activeTab = sessionStorage.getItem('activeTab');
            if (activeTab == null || activeTab == "") {
                activeTab = "Diagnosis";
            }

            if (activeTab == "ICDDiag") {
                $('#' + activeTab).tab('show');
                $("#myAdd").css('display', 'none');
                $("#DiagnosisInput").css('display', 'none');
                $("#ICDDiagnosis").css('display', 'flex');
                $('#HeadDiog').hide();
                $('#tbldiagno').hide();
                $('#HeadDiog1').show();
                $('#tblICDdiagno').show();
                $('#HeadDiog2').show();
                $('#tblICDdiagnoO').show();
                $("#PersICDDiag").show();
                $("#PersDiag").hide();
                $('#DivICDTNM').hide();
            }
            else if (activeTab == "ICDTNM") {
                $('#' + activeTab).tab('show');
                $("#myAdd").css('display', 'none');
                $("#DiagnosisInput").css('display', 'none');
                $("#ICDDiagnosis").css('display', 'none');
                $('#HeadDiog').hide();
                $('#tbldiagno').hide();
                $('#HeadDiog1').hide();
                $('#tblICDdiagno').hide();
                $('#HeadDiog2').hide();
                $('#tblICDdiagnoO').hide();
                $("#PersICDDiag").hide();
                $("#PersDiag").hide();
                $('#DivICDTNM').show();
            }
            else {
                // Default to the Diagnosis tab (or any other default tab)
                $('#Diagno').tab('show');
                $('#HeadDiog').show();
                $('#tbldiagno').show();
                $('#HeadDiog1').hide();
                $('#tblICDdiagno').hide();
                $('#HeadDiog2').hide();
                $('#tblICDdiagnoO').hide();
                $('#DivICDTNM').hide();
                $("#ICDDiagnosis").css('display', 'none');
            }
            sessionStorage.setItem('activeTab', "");
            // When a tab is clicked, store the tab ID in sessionStorage
            $('a[data-toggle="tab"]').on('click', function () {
                sessionStorage.setItem('activeTab', $(this).attr('id'));
            });

            //Activate Tab Closed 

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                <%--var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
                AddClinics(urls);--%>

                var dispLst = document.getElementById('sideList');
                //kavita 12-aug-2019
                // dispLst.style.display = "block";  
                $("#slide_sdList").click();

                //$("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018
                //$("#tabMenu").css("display", "block");// added by vijeta on 27th sep 2018
                //ActiveMenu("Diagnosis");
                $("#tabMenu").css("display", "block");// added by vijeta on 27th sep 2018
                ActiveMenu(activeTab);
            }

            for (var i = 0; i <= 30; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' style='text-decoration: none;' id='NumDaysSc'>" + i + "</a>";
                $("#layer-demo").append(s);
            }

            //commented by vijeta on 22nd march 2018
            //
            //$('#DiagnosisInput').on('keyup', function () {
            //    var input = $(this);
            //    if (input.val().length === 0) {
            //        input.addClass('empty');
            //    } else {
            //        input.removeClass('empty');
            //    }
            //});
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

            //$('.trigger1').click(function (e) {
            //    e.stopPropagation();
            //});
            //$('.trigger2').click(function (e) {
            //    e.stopPropagation();
            //});

            $("#layer-demo .NumDaysCls").click(function (e) {
                var txt = $(this).text();
                SetText(txt);
            });

            $("#myBtn").click(function () {
                //debugger;
                SaveDiagnosis("N");
                //SaveICDDiagnosis("N");
            });

            $("#closebtn").click(function () {
                //debugger;
                $("#griddet").css('display', 'none');
                $('#ICDDiagnosisInput').val('');
                $('#ICDDiagnosisOInput').val('');
                SearchICDDiagnosis('ICDDiagnosisInput', 'tblICDdiagno');
                SearchICDDiagnosis('ICDDiagnosisOInput', 'tblICDdiagnoO');
            });

            $("#myAdd").click(function () {
                $.confirm({
                    title: '',
                    content: '' +
                    '<form action="" class="formName" style="height:134px">' +
                    '<div class="form-group">' +
                  //  
                  '<label>Diagnosis</label>' +
                      //'<input  type="varchar" id="txtDiagnosis" maxlength="50"  placeholder="Diagnosis" autofocus="autofocus" class="complaint form-control" required />' + //added length by kavita
                           '<textarea type="varchar" id="txtDiagnosis" maxlength="50"  placeholder="Diagnosis" autofocus="autofocus" class="complaint form-control" required rows="5" cols="30"/>' + //added length by kavita
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var digno = this.$content.find('.complaint').val().trim().replace(/\s/g, ' '); //Meenakshi  30/11/2019;
                                var grpCode = "";
                                if (digno == "") {
                                    $.alert('Enter Diagnosis'); //
                                    return false;
                                }
                                if (digno != "") {
                                    $.ajax({
                                        type: "post",
                                        datatype: "json",
                                        url: 'AddDiagnosis', //
                                        data: { strDiagnosis: digno },
                                        success: function (response) {
                                            if (("" + response).toUpperCase().indexOf("SUCCESS") != -1) {
                                                $("#txtDiagnosis").val("");
                                                //$.messager.alert("Information", response);
                                                //  $.messager.alert("Information", "Record inserted successfully");  //commented by 10/12/2019
                                                // SaveDiagnosis("Y");
                                                // AddDiagnosis();

                                                newlyAddedDiagno = response.split(' ').pop().trim(); //13/12/2019 15:09    

                                                // 18-12-19
                                                var rows = "<tr class='clickable-row' id='" + newlyAddedDiagno + "'>" + "<td style='padding:5px; width:90%   font-size: 13px;text-align:left;' class='DiagnoNm'>" + digno + "</td>" +
                                   "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                    "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                                         "<td class='RemarkText' style='display:none;'></td>" + //06-12-2019 10:47
                                   "</tr>";
                                                $("#tbldiagno tbody").prepend(rows).closest('tr');
                                                $('#tbldiagno tr#' + newlyAddedDiagno).trigger('click');
                                                //  $('#tbldiagno tbody').append(rows);

                                                //end
                                            }
                                            else if (("" + response).toUpperCase().indexOf("PRESENT.") != -1) {
                                                var jc = this;
                                                //jc.$formSubmit.trigger('click');
                                                // $.messager.alert("Information", "This Diagnosis is already Present.");
                                                $("#DiagnosisInput").val(digno);//
                                                // SearchDiagnosis();//
                                                AfterpresentSearchDiagnosis(digno); //added by 10/12/2019 
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
                            //close
                            //$('.FoodItems input:checked').focus();
                        },
                    },
                    onContentReady: function () {
                        $('#txtDiagnosis').focus();
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

            $('.Diagnosis').click(function () {
                if (ValidationTNM("Y")) {
                    // $("#tbldiagno").css('display', 'block');
                    $("#tbldiagno").show();//4/22/19
                    // $("#tblICDdiagno").css('display', 'none');
                    $("#HeadDiog").show();
                    $('#myAdd').css({ 'margin-right': '34px' });
                    $('#DiagnosisInput').width('50%');
                    $("#tblICDdiagno").hide();//4/22/19
                    $("#HeadDiog1").hide();
                    $('#HeadDiog2').hide();
                    $('#tblICDdiagnoO').hide();
                    $("#DiagnosisInput").css('display', 'block');

                    $("#DiagnosisInput").focus();//kavita
                    $("#myAdd").css('display', 'block');
                    $("#ICDDiagnosis").css('display', 'none');
                    $("#PersICDDiag").hide(); //Added By Priyanka 
                    $("#PersDiag").show();//Added By Priyanka on 13/02/2025
                    $("#DivICDTNM").hide();
                }
                else {
                    $('.ICDTNM').trigger("click");
                }
            });
            $('.ICDDiagno').click(function () {
                if (ValidationTNM("Y")) {
                    //debugger;
                    // $("#tblICDdiagno").css('display', 'block');
                    $("#tblICDdiagno").show();//4/22/19
                    $("#HeadDiog1").show();
                    $('#HeadDiog2').show();
                    $('#tblICDdiagnoO').show();
                    //$("#tbldiagno").css('display', 'none');
                    $("#tbldiagno").hide();//4/22/19
                    $("#HeadDiog").hide();

                    $("#DiagnosisInput").css('display', 'none');
                    $("#ICDDiagnosis").css('display', 'flex');
                    $("#ICDDiagnosisInput").focus();//kavita
                    $("#myAdd").css('display', 'none');
                    $("#closebtn").css('display', 'none');
                    $("#griddet").css('display', 'none');
                    $("#PersICDDiag").show();
                    $("#PersDiag").hide();//Added By Priyanka on 13/02/2025
                    $("#DivICDTNM").hide();
                    SaveDiagnosis("Y");
                }
                else {
                    $('.ICDTNM').trigger("click");
                }
            });

            $('.ICDTNM').click(function () {
                if (ValidationTNM("N")) {
                    $("#DivICDTNM").show();
                    $("#tblICDdiagno").hide();
                    $("#HeadDiog1").hide();
                    $("#tbldiagno").hide();
                    $('#HeadDiog2').hide();
                    $('#tblICDdiagnoO').hide();
                    $("#HeadDiog").hide();
                    $("#DiagnosisInput").css('display', 'none');
                    $("#ICDDiagnosis").css('display', 'none');
                    $("#myAdd").css('display', 'none');
                    $("#closebtn").css('display', 'none');
                    $("#griddet").css('display', 'none');
                    $("#PersICDDiag").hide();
                    $("#PersDiag").hide();
                    SaveDiagnosis("Y");
                }
                else {
                    $("#DivICDTNM").show();
                    $("#tblICDdiagno").hide();
                    $("#HeadDiog1").hide();
                    $("#tbldiagno").hide();
                    $('#HeadDiog2').hide();
                    $('#tblICDdiagnoO').hide();
                    $("#HeadDiog").hide();
                    $("#DiagnosisInput").css('display', 'none');
                    $("#ICDDiagnosis").css('display', 'none');
                    $("#myAdd").css('display', 'none');
                    $("#closebtn").css('display', 'none');
                    $("#griddet").css('display', 'none');
                    $("#PersICDDiag").hide();
                    $("#PersDiag").hide();
                }
            });

            // register the handler 
            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys  

            //modified by priyanka on 18/02/2025
            $(document.body).on('click', '#tbldiagno td a,#tbldiagno td,#tbldiagno tr', function (e) {
                //debugger;
                //commented by priyanka on 18/02/2025
                //if (!$(this).is('.DiagnoNm'))
                //{
                //    e.stopPropagation();
                //} 
                //Added By Priyanka on 18/02/2025
                console.log($(this).hasClass('DiagnoNm'));
                if (!$(this).is('.DiagnoNm')) {
                    e.stopPropagation();
                }
                else if ($(this).is('.DiagnoNm')) {
                    var $row = $(this).closest('tr');

                    // Toggle 'active' class on the row
                    $row.toggleClass('active');

                    if ($row.hasClass('active')) {

                        $row.find('.DiagnosisRemark').show();
                        $row.find('.DiagnosisRemark a').show();

                        var selRows = $('#tbldiagno > tbody > tr.active').get(); //group of selected rows

                        if (selRows.length === 1) {
                            // If this is the first selected row, move it to the top
                            $("#tbldiagno tbody").prepend($row);
                        } else {
                            // If there are already selected rows, insert this one after the last selected row
                            //$(selRows[selRows.length - 1]).after($row);
                            //prepend to top
                            $.each(selRows, function (index, row) {
                                // Prepend each active row to the top of the tbody
                                $(row).detach().prependTo('#tbldiagno tbody');
                            });
                        }
                        $row.find('a').show();
                    } else {
                        //$row.find('.DiagnosisRemark').hide();
                        $row.find('.DiagnosisRemark a').hide();
                    }
                    moveDiagnosisActiveRowsToTop();
                    e.stopPropagation();
                }
            });


            $("#btnProvDiag").click(function () {
                var Mrno = ($.session.get('PatMRNO'));
                var strTran = ($.session.get('PatTRANNO'));

                $.confirm({
                    title: '',
                    content: '' +
                    '<form action="" class="formFreeText" >' +
                    '<div class="form-group">' +
                    '<label>Provisional Diagnosis : </label>' +
                    '<textarea id="txtProvDiagnos" maxlength="500"  placeholder="Provisional Diagnosis" autofocus="autofocus" class="diagnosis form-control" required rows="5" cols="30" />' +
                    '<textarea id="txtCompositStag" maxlength="5"  placeholder="Stage" class="CompoStag form-control" required rows="1" cols="30" />' +//added by meenakshi on 3 may 2021
                    '<textarea id="txtTStage" maxlength="5"  placeholder="T" class="TStag form-control" required rows="1" cols="30" />' +//added by meenakshi on 3 may 2021
                    '<textarea id="txtNStage" maxlength="5"  placeholder="N" class="NStag form-control" required rows="1" cols="30" />' +//added by meenakshi on 3 may 2021
                    '<textarea id="txtMStage" maxlength="5"  placeholder="M" class="MStag form-control" required rows="1" cols="30" />' +//added by meenakshi on 3 may 2021
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var provDiagnosis = this.$content.find('.diagnosis').val().toString().trim().replace(/\s/g, ' ');
                                var compoStaging = this.$content.find('.CompoStag').val().toString().trim().replace(/\s/g, ' ');
                                var tStage = this.$content.find('.TStag').val().toString().trim().replace(/\s/g, ' ');;
                                var NStage = this.$content.find('.NStag').val().toString().trim().replace(/\s/g, ' ');;
                                var MStage = this.$content.find('.MStag').val().toString().trim().replace(/\s/g, ' ');;
                                if ($("#btnProvDiag").css("background-color") != "rgb(0, 128, 0)") {
                                    //if (cmplnt.length == 0) {
                                    //    $.alert('Enter provisional diagnosis');
                                    //    this.$content.find('.diagnosis').val(""); 
                                    //    return false;
                                    //}
                                }
                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'AddDiagnosisDet',
                                    data: { strProvDiagnosis: provDiagnosis, strTran: strTran, strMrNo: Mrno, CompositStag: compoStaging, TStage: tStage, NStage: NStage, MStage: MStage },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                                            $.messager.alert("Information", "Record Not Inserted.");
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT.") != -1) {
                                            var jc = this;
                                            $.messager.alert("Information", "This complaint is already Present.");
                                        }
                                        else {
                                            $("#txtProvDiagnos").val(provDiagnosis);
                                            $("#txtCompositStag").val(compoStaging);
                                            $("#txtTStage").val(tStage);
                                            $("#txtNStage").val(NStage);
                                            $("#txtMStage").val(MStage);

                                            gporvFiagnosis = provDiagnosis;
                                            gCompositStage = compoStaging;
                                            gTtStage = tStage;
                                            gNtStage = NStage;
                                            gMtStage = MStage;



                                            if (provDiagnosis != "" || compoStaging != "" || tStage != "") {
                                                //  $.messager.alert("Information", "Record inserted successfully");
                                                //$("#tblCmplts tr").prop("disabled", true); //commented by vijeta on 18th mrch 19
                                                $("#btnProvDiag").css("background-color", "green");
                                                //$("#tblCmplts tr").removeClass("active");//commented by vijeta on 18th mrch 19
                                                //$("#tblCmplts tr a").hide();//commented by vijeta on 18th mrch 19
                                                $.session.set('Diag', "Y");
                                            }
                                            else {
                                                //  $.messager.alert("Information", "Complaint removed");
                                                //$("#tblCmplts tr").removeProp("disabled", true); //commented by vijeta on 18th mrch 19
                                                $("#btnProvDiag").css("background-color", "#398ebd");
                                                $.session.set('Diag', "N");
                                            }

                                            //$.session.set('ProvDiag', provDiagnosis);

                                        }
                                    },

                                });
                                // }
                            }
                        },
                        REMOVE: function () {
                            $("#txtProvDiagnos").val("");
                            $("#txtCompositStag").val("");
                            $("#txtTStage").val("");
                            $("#txtNStage").val("");
                            $("#txtMStage").val("");
                            $('.formFreeText').submit();
                        },
                        CLOSE: function () {
                            //close
                            //$('.FoodItems input:checked').focus();
                        },
                    },
                    onContentReady: function () {
                        $('#txtProvDiagnos').focus();
                        $('#txtProvDiagnos').val(gporvFiagnosis);
                        $("#txtCompositStag").val(gCompositStage);
                        $("#txtTStage").val(gTtStage);
                        $("#txtNStage").val(gNtStage);
                        $("#txtMStage").val(gMtStage);

                        var jc = this;

                        this.$content.find('form').on('submit', function (e) {
                            // if the user submits the form by pressing enter in the field.
                            e.preventDefault();
                            jc.$$formSubmit.trigger('click'); // reference the button and click it
                        });

                        if ($('#txtProvDiagnos').val() == "" && $("#txtCompositStag").val() == "" && $("#txtTStage").val() == "") {
                            jc.$$REMOVE.attr("style", "display:none")
                        }
                    }
                });
            });

            SetDataForDiagnosis();

        });

        function SetText(str) {
            $("#" + idOfDMY).text(str);
        }

        function AddDiagnosis(addclick) {
            //debugger;
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
                                     "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                                            "<td class='RemarkText' style='display:none;'></td>" +
                                    "</tr>";

                        $('#tbldiagno tbody').append(rows);
                    });

                },
                complete: function () {
                    // SetDataForDiagnosis();// commntd
                    //if ($('#tbldiagno').height() < 600) {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "hidden");
                    //} else {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "visible");
                    //}
                }
                , error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function AddICDDiagnosis() {
            //debugger;
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
                    //if ($('#tbldiagno').height() < 600) {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "hidden");
                    //} else {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "visible");

                    //}
                }
                , error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        //function SearchDiagnosis() {

        //    var input, filter, table, tr, td, i;
        //    input = document.getElementById("DiagnosisInput");  //
        //    filter = input.value.toUpperCase();
        //    table = document.getElementById("tbldiagno");
        //    tr = table.getElementsByTagName("tr");


        //    for (i = 0; i < tr.length; i++) {
        //        td = tr[i].getElementsByTagName("td")[0];
        //        if (td) {
        //            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        //                tr[i].style.display = "";
        //            } else {
        //                tr[i].style.display = "none";
        //            }
        //        }
        //    }


        //    if ($(input).val().length >= 3) {
        //        getDiagnoListFrmDB(filter, tr);
        //    }
        //}



        function SearchDiagnosis() {
            // Declare variables 
            //debugger;
            var input, filter, table, tr, td, i;
            input = document.getElementById("DiagnosisInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tbldiagno");
            var tr = $("#tbldiagno  tr");

            // Loop through all table rows, and hide those who don't match the search query

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
                                     "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                                          "<td class='RemarkText' style='display:none;'></td>" + //06-12-2019 10:47
                                    "</tr>";

                    $('#tbldiagno tbody').append(rows);
                });
            }
            // tr = table.getElementsByTagName("tr");
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
        //pradnay 11/12/2019
        function AfterpresentSearchDiagnosis(digno) {
            //debugger;
            var table = document.getElementById("tbldiagno");
            var tr = table.getElementsByTagName("tr");

            var strClinincode = $.session.get('ClinicCode').toString().trim();

            HoldOn.open();//
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
                                //Do not bind
                                //  GetDatabaseComplain(filter, tr);
                                if ($('#tbldiagno tr#' + MatchElement[0].id).hasClass("active") == false)
                                    $('#tbldiagno  tr#' + MatchElement[0].id).trigger('click');
                                //  $('#tblCmplts tr#').parents('td').nextAll('td.Complaint').find('a.trigger1').trigger('click');
                            }
                            else {
                                var rows = "<tr class='clickable-row' id='" + result.Table1[i].CODE + "'>" + "<td style='padding:5px; width:90%   font-size: 13px;text-align:left;' class='DiagnoNm'>" + result.Table1[i].NAME.trim() + "</td>" +
                                    "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                     "<td class='tdSetUpYn' style='display:none;'></td>" +
                                          "<td class='RemarkText' style='display:none;'></td>" +
                                    "</tr>";
                                // $('#tbldiagno tbody').prepend(rows).closest('tr');//commented by vijeta 17/4/19
                                $('#tbldiagno tbody').append(rows).closest('tr');//added 17/4/19
                                $('#tbldiagno tr#' + result.Table1[i].CODE.trim()).trigger('click');// 18-12-19

                            }//4/22/19

                        });
                    }
                },
                complete: function () {
                    HoldOn.close();//
                    //if ($('#tblCmplts').height() < 600) {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "hidden");
                    //} else {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "visible");

                    //}

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function SearchICDDiagnosis(ID, TblId) {
            // Declare variables 
            //debugger;
            var mystring = document.getElementById(ID).value;
            if (!mystring.match(/\S/)) {
                $("#griddet").css('display', 'none');
                $("#closebtn").css('display', 'none');
                $("#tblICDdiagno").css('display', 'block');
                $("#tblICDdiagnoO").css('display', 'block');
            }
            else {
                $("#griddet").css('display', 'block');
                $("#closebtn").css('display', 'block');
                if (TblId == "tblICDdiagno") {
                    $("#tblICDdiagnoO").css('display', 'block');
                    $("#tblICDdiagno").css('display', 'none');
                }
                else {
                    $("#tblICDdiagno").css('display', 'block');
                    $("#tblICDdiagnoO").css('display', 'none');
                }
            }
            var input, filter, table, tr, td, i;
            input = document.getElementById(ID);  //
            filter = input.value.toUpperCase();
            table = document.getElementById("gvtable");
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
            if (TblId == "tblICDdiagno") {
                getICDdiagnoList(filter, TblId);
            }
            else {
                getICDOdiagnoList(filter, TblId);
            }
        }

        function getICDdiagnoList(filter, ID) {

            //debugger;

            if (filter.length >= 4 && filter.length != "") {
                HoldOn.open();//
                $.ajax({
                    type: "POST",
                    url: "<%=Url.Action("GetNonFregqentICDList","DoctorDesk")%>",
                    data: { NonFreqICD: filter },
                    asycn: false,
                    success: function (response) {
                        if (response != "") {
                            var result = JSON.parse(response);
                            BindReport(result.Table, ID);
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

        function getICDOdiagnoList(filter, ID) {
            if (filter.length >= 4 && filter.length != "") {
                HoldOn.open();
                $.ajax({
                    type: "POST",
                    url: "<%=Url.Action("GetNonFregqentICDOList","DoctorDesk")%>",
                    data: { NonFreqICDO: filter },
                    asycn: false,
                    success: function (response) {
                        if (response != "") {
                            var result = JSON.parse(response);
                            BindReport(result.Table, ID);
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
            //debugger;
            var tranNo = $.session.get('PatTRANNO');
            $.ajax({
                type: 'post',
                datatype: 'json',
                data: { strTranNo: tranNo },
                url: 'SetDataForDiagnosis',
                async: true,
                success: function (data) {
                    if (data != "") {
                        if (data[0] != null) {
                            for (var i = 0; i < data[0].length; i++) {
                                if ($('#tbldiagno tr#' + data[0][i]["DESCCD"]).length > 0) {
                                    $('#tbldiagno tr#' + data[0][i]["DESCCD"]).trigger('click');
                                    //commented by 17/12/2019
                                    //var colRemark = "<td class='RemarkText' style='display:none'>" + data[0][i]["REMARKS"].toString().trim() + "</td>";
                                    //$('#tbldiagno tr#' + data[0][i]["DESCCD"]).append(colRemark);

                                    $('#tbldiagno tr#' + data[0][i]["DESCCD"]).find('.RemarkText')[0].innerHTML = data[0][i]["REMARKS"].toString().trim(); //17/12/2019
                                    if (data[0][i]["REMARKS"].toString().trim() != "") {
                                        var DiagnosiswithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><spa>' + data[0][i]["REMARKS"].toString().trim() + '</span>'
                                        $('#tbldiagno tr#' + data[0][i]["DESCCD"]).find('td:nth-child(1)').append(DiagnosiswithRemark);
                                    }
                                    $('#tbldiagno tr#' + data[0][i]["DESCCD"] + ' td.tdSetUpYn')[0].innerHTML = data[0][i]["SETUPYN"]; //added on 25th July 2019
                                }
                                else {//vijeta 4/4/19
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
                            for (var i = 0; i < data[1].length; i++) {
                                var NonFrqRows = '';
                                var DiagID = (data[1][i]["ICDCODE"]); //.replace(/[^0-9a-zA-Z]/gi, '');
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
                            gporvFiagnosis = data[2][0]["PROVDIAGNOS"].toString().trim();
                            gCompositStage = data[2][0]["COMPOSTAGE"].toString().trim();
                            gTtStage = data[2][0]["TSTAGE"].toString().trim();
                            gNtStage = data[2][0]["NSTAGE"].toString().trim();
                            gMtStage = data[2][0]["MSTAGE"].toString().trim();
                            gSite = data[2][0]["SITE"].toString().trim();
                            gSubSite = data[2][0]["SUBSITE"].toString().trim();
                            $("#CmbSiteList").val(gSite);
                            $("#CmbSiteList").trigger('change');
                            $("#CmbSubSiteList").val(gSubSite);
                            $("#CmbSubSiteList").trigger('change');
                            $("#ICDTList").val(gTtStage);
                            $("#ICDTList").trigger('change');
                            $("#ICDNList").val(gNtStage);
                            $("#ICDNList").trigger('change');
                            $("#ICDMList").val(gMtStage);
                            $("#ICDMList").trigger('change');
                            $("#CmbStageList").val(gCompositStage);
                            $("#CmbStageList").trigger('change');
                            //var provDet = gporvFiagnosis + gCompositStage + gTtStage + gNtStage + gMtStage;
                            //if (provDet != "") {
                            //    $("#btnProvDiag").css("background-color", "green");
                            //    $("#btnProvDiag").trigger('click');
                            //}
                            //else if (OpenProvDiagOnLoad == "Y" && ($("#btnProvDiag").css("background-color") != "green")) {
                            //    $("#btnProvDiag").trigger('click');
                            //}
                            // $("#btnProvDiag").trigger('click');
                        }
                        if (data[3] != null) {
                            for (var i = 0; i < data[3].length; i++) {
                                var NonFrqRows = '';
                                var DiagID = (data[3][i]["ICDCODE"] + "_" + data[3][i]["ICDOCODE"]); //.replace(/[^0-9a-zA-Z]/gi, '');
                                var ICDOName = data[3][i].NAME;
                                var row = $('#tblICDdiagnoO tr' + CSS.escape(DiagID)).get();
                                if (row.length > 0) {
                                    $("#tblICDdiagnoO tbody").prepend(row).closest('tr');
                                    $('#tblICDdiagnoO tr' + CSS.escape(DiagID)).addClass('active');
                                }
                                else {
                                    NonFrqRows += "<tr class='clickable-row display active' id='" + DiagID + "'>" + "<td style='padding:5px;width:100%; text-align:left;font-size: 13px;'>" + ICDOName + "</td>";
                                    NonFrqRows += "</tr>";
                                    $('#tblICDdiagnoO tbody').prepend(NonFrqRows).closest('tr');
                                }
                            }
                        }
                    }
                    else {
                        //if (OpenProvDiagOnLoad == "Y" && ($("#btnProvDiag").css("background-color") != "green")) {
                        //    $("#btnProvDiag").trigger('click');
                        //}
                    }
                },
                //added on 19th sep 2018
                complete: function () {
                    //if (newlyAddedDiagno != "")
                    // $('#tbldiagno tr#' + newlyAddedDiagno).trigger('click');

                    HoldOn.close();//
                    //if ($('#tbldiagno').height() < 600 ) {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "hidden");
                    //} else {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "visible");

                    //}

                    //if ($('#tblICDdiagno').height() < 600) {
                    //    $(".HeadPatTab1 > tbody").css("overflow-y", "hidden");
                    //} else {
                    //    $(".HeadPatTab1 > tbody").css("overflow-y", "visible");

                    //}
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });
        }
        function AddDiagnosisRemark(object, e) {
            e.stopPropagation();

            //Reverted this changed to origin Meenakshi 30/11/2019
            var RemarkText = "";
            //var RemarkText = $(object).parent().next().text();
            //if (RemarkText != "") {
            //    RemarkText = $(object).parent().siblings('.RemarkText')[0].innerText;//added 25/7/19
            //}

            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label>Add Diagnosis Remark</label>' +
                '<textarea rows="5" cols="50"  id="txtDiagnosisRemark" maxlength="200" placeholder="Remark" autofocus="autofocus" class="complaint form-control" required></textarea>' +//kavita 
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            //17/12/2019 13:27
                            var cmplnt = this.$content.find('.complaint').val().toString().trim().replace(/\s/g, ' ');
                            if ($(object).parent().siblings('.RemarkText')[0].innerText == "") {
                                if (cmplnt.length == 0) {
                                    $.alert('Enter Remark');
                                    this.$content.find('.complaint').val(""); //added by 10/12/2019 12:37
                                    return false;
                                }

                            }
                            if (RemarkText != "" || RemarkText != "undefined") {
                                // $(object).parent().next().remove();
                                $(object).parent().siblings('.RemarkText').remove();
                            }

                            var CurrentRow = $(object).parent().parent();
                            stringRemarkTd = "<td class='RemarkText' style='display:none'>" + $('#txtDiagnosisRemark').val() + "</td>";
                            var firstChildVal = $(CurrentRow).find('td:nth-child(1)').text().trim();
                            var ComplainwithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + $('#txtDiagnosisRemark').val() + '</span>'
                            $(CurrentRow).find('td:nth-child(1)').children().remove();
                            //$(CurrentRow).find('td:nth-child(1)').append(ComplainwithRemark); //commented by 06-12-2019 11:59
                            if ($("#txtDiagnosisRemark").val() != "") { $(CurrentRow).find('td:nth-child(1)').append(ComplainwithRemark); }  //06-12-2019 10:51
                            CurrentRow.append(stringRemarkTd);
                        }
                    },
                    Remove: function () {
                        $("#txtDiagnosisRemark").val("");
                        $('.formName').submit();
                    },
                    close: function () {
                        //close
                        //$('.FoodItems input:checked').focus();
                    },
                },
                onContentReady: function () {
                    $('#txtDiagnosisRemark').focus();
                    //if (RemarkText != "") {
                    RemarkText = $(object).parent().siblings('.RemarkText')[0].innerText;//added by Meenakshi 30/11/19
                    $('#txtDiagnosisRemark').val(RemarkText);
                    //  }
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                    //29-11-2019  18:37
                    if ($('#txtDiagnosisRemark').val() == "") {
                        jc.$$Remove.attr("style", "display:none")
                    }
                }
            });

        }

        function SaveDiagnosis(strPlusBtn) {
            //debugger;
            HoldOn.open();//
            var mrno = ($.session.get('PatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var diagnoArr = [];
            var ICDdiagnoArr = [];
            var ICDOdiagnoArr = [];
            var rows = $('#tbldiagno > tbody > tr.active').get();

            //if (rows.length > 0) {

            for (var i = 0; i < rows.length; i++) {

                var code = rows[i].id
                var RemarkElement = $(rows[i]).children('.RemarkText');
                var DignosisRemark = $(RemarkElement).text();
                var setupYn = $(rows[i]).children('td.tdSetUpYn')[0].innerText; //added on 25/7/19
                var a = {
                    DESCCD: code,
                    REMARKS: "" + DignosisRemark,
                    SETUPYN: setupYn,//added on 25/7/19
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

            var rows2 = $('#tblICDdiagnoO > tbody > tr.active').get();
            for (var i = 0; i < rows2.length; i++) {
                var code = rows2[i].id.split('_').length > 1 ? rows2[i].id.split('_')[1].trim() : rows2[i].id.split('_')[0].trim();
                var b = {
                    DESCCD: code,
                };
                ICDOdiagnoArr.push(b);
            }

            //Added the below condition by Murali on 10/07/2024
            var PDiag = $.session.get('Diag');
            if (rows.length > 0 || rows1.length > 0 || PDiag == "Y" || PDiag == undefined) {
                $.session.set('Diag', "Y");
            }
            else {
                $.session.set('Diag', "N");
            }
            //Added By Priyanka on 29/01/2025
            if ($.session.get('Diag') == "Y") {
                if (($.session.get('Diag') == "Y" && rows1.length == 0) && rows.length > 0) //if array is []
                {
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

            var Site = $("#CmbSiteList").val();
            var SubSite = $("#CmbSubSiteList").val();
            var T = $("#ICDTList").val();
            var N = $("#ICDNList").val();
            var M = $("#ICDMList").val();
            var Stage = $("#CmbStageList").val();

            $.ajax({
                type: "POST",
                url: 'SaveDiagnosis',
                datatype: "json",
                data: { Site: Site, SubSite: SubSite, Stage: Stage, strDiagnosis: JSON.stringify(diagnoArr), strICDDiagnosis: JSON.stringify(ICDdiagnoArr), strMRNO: mrno, strTranNo: tranNo, Tlst: T, Nlst: N, Mlst: M, strICDODiagnosis: JSON.stringify(ICDOdiagnoArr), },
                success: function (result) {


                    if (strPlusBtn == "N")
                        window.location.href = 'PatientEntry';
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });

        }

        function BindReport(result, ID) {
            var colnames = "";
            var colmodel = "";

            var footerrow = false;

            colnames = ['Code', ID == "tblICDdiagnoO" ? 'ICDO Diag. Name' : 'ICD Diag. Name'];
            colmodel = [

                   { index: ID == "tblICDdiagnoO" ? 'OCODE' : 'CODE', name: ID == "tblICDdiagnoO" ? 'OCODE' : 'CODE', width: 10, sortable: true, resizable: false, hidden: true },
                   { index: 'NAME', name: 'NAME', width: 830, sortable: true, resizable: false, sorttype: 'number' }];

            $("#gvtable").jqGrid('GridUnload');
            jQuery("#gvtable").jqGrid({
                colNames: colnames,
                colModel: colmodel,
                data: result,
                datatype: 'local',
                //sortname: sortnm,
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
                //scrollerbar: true,
                viewrecords: true,
                footerrow: footerrow,
                rowattr: function (rd) {
                    return { "class": "column-title" }
                },
                beforeRequest: function () {
                    responsive_jqgrid($('.jqGrid'));
                },//footer row data 
                gridComplete: function () {

                },
                onSelectRow: function (selRowId) {//suamyya
                    var rowData = $("#gvtable").jqGrid("getRowData", selRowId);
                    var code = "";
                    var id = ID == "tblICDdiagnoO" ? ("" + rowData.OCODE).trim() : ("" + rowData.CODE).trim();//.replace(/[^0-9a-zA-Z]/gi, '');
                    var rows = "<tr class='clickable-row display active'  id='" + id + "'>" + "<td style='padding:5px;width:100%; text-align:left;font-size: 13px;'>" + rowData.NAME + "</td>" +
                        "</tr>";
                    var row = $('#' + ID + ' tr[id="' + id + '"]').get();
                    //var row = $('#' + ID + ' tr#' + id).get();
                    if (row.length <= 0) {
                        $('#' + ID + ' tbody').prepend(rows);
                    }
                    if (ID == "tblICDdiagno") {
                        GetICDDiagnosisO(rowData.CODE);
                    }
                    if (ID == "tblICDdiagnoO") {
                        AddICDDiagnosisCheck(rowData.OCODE);
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

        //jqgrid css here 
        function responsive_jqgrid(jqgrid) {
            jqgrid.find('.ui-jqgrid').addClass('clear-margin span12').css('width', '');
            jqgrid.find('.ui-jqgrid-view').addClass('clear-margin span12').css('width', '');
            jqgrid.find('.ui-jqgrid-view > div').eq(1).addClass('clear-margin span12').css('width', '').css('min-height', '0');
            jqgrid.find('.ui-jqgrid-view > div').eq(2).addClass('clear-margin span12').css('width', '').css('min-height', '0');
            jqgrid.find('.ui-jqgrid-sdiv').addClass('clear-margin span12').css('width', '');
            jqgrid.find('.ui-jqgrid-pager').addClass('clear-margin span12').css('width', '');
        }
        jQuery(document).ready(function ($) {
            //debugger;

            if (window.history && window.history.pushState) {
                //debugger;

                window.history.pushState('forward', null, './Diagnosis');

                $(window).on('popstate', function () {
                    //debugger;
                    SaveDiagnosis("N");
                });

            }
        });

        //vijeta 19th march 19
        function getDiagnoListFrmDB(filter, obj) {
            //debugger;
            //new
            var strClinincode = $.session.get('ClinicCode').toString().trim();
            //HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetNonFregqentDiagnoList","DoctorDesk")%>",
                data: { NonFreqDiagno: filter, strClinincode: strClinincode },
                asycn: false,
                success: function (response) {
                    if (response != "") //condition added vijeta 16/4/19
                    {
                        var result = JSON.parse(response)

                        var rows = "";

                        for (i = 0; i < result.Table1.length; i++) {

                            var MatchElement = jQuery.grep(obj, function (element, index) {
                                // Name = element.getElementsByTagName("td")[0].innerHTML;
                                Name = $(element)[0].cells[0].innerText.split("-")[0];

                                return ((result.Table1[i].NAME).toString().trim() == Name.toString().trim());
                            });

                            if (MatchElement.length > 0) {
                                //Do not bind
                            }
                            else {

                                //var rows = "<tr class='clickable-row' id='" + result.Table1[i].CODE + "'>" + "<td style='padding:5px;width:90%; text-align:left; font-size: 13px;' class='DiagnoNm'>" + result.Table1[i].NAME.trim() + "</td>" +
                                //           "<td class='DiagnosisRemark'><a href='javascript:;' style='display:none;' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                //           "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                                //               "<td class='RemarkText' style='display:none;'></td>" + //06-12-2019 10:47
                                //           "</tr>";
                                //rows += "</tr>";//
                                //// $('#tbldiagno tbody').prepend(rows).closest('tr');//commented by vijeta 17/4/19
                                //$('#tbldiagno tbody').append(rows).closest('tr');//added 17/4/19



                                var rows = "<tr class='clickable-row' id='" + result.Table1[i].CODE + "'>" + "<td style='padding:5px; width:90%   font-size: 13px;text-align:left;' class='DiagnoNm'>" + result.Table1[i].NAME.trim() + "</td>" +
                                  "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                   "<td class='tdSetUpYn' style='display:none;'></td>" +
                                        "<td class='RemarkText' style='display:none;'></td>" +
                                  "</tr>";

                                $('#tbldiagno tbody').append(rows).closest('tr');

                            }
                        }
                    }

                    //}




                },
                complete: function () {
                    // HoldOn.close();//
                    //if ($('#tbldiagno').height() < 600) {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "hidden");
                    //} else {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "visible");

                    //}


                },


                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });

        }

        //ICD Diagnosis Setup Start
        //Added By Priyanka
        function CreateICDDiagSetupList() {
            //debugger;
            $.confirm({
                title: 'ICD Diagnosis Setup',
                theme: 'supervan',
                // theme: 'material',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                //  columnClass: 'col-md-6',
                content: '' + //
                 '<form action="" class="formName" style="height:410px;"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:-16px" class="form-control" id="ICDDiagnosisSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtICDDiagSetup" type="text" id="input-name" placeholder="Search Setup" class="form-control" onkeyup="SearchICDDiagnosisSetUpList()" style="" autofocus></td></tr></table></div>' +
                '<div id="divtblICDDiagnosisSetup" class="divtblICDDiagnosisSetup" style=""><table id="tblPersICDDiagnolist" style="width:100%;border-top:1px solid #29884bd6 !important;" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {
                    Add: {//Added By Priyanka on 12/02/2025
                        text: '<i class="fa fa-plus-circle"></i>',
                        action: function () {
                            stringcode = '';
                            SetupNameICDDiagText = '';
                            var row = $('#tblPersICDDiagnolist tr')
                            for (r = 0; r < row.length; r++) {
                                var Chk = $(row[r]).find('.chkPersDis')
                                if (Chk[0].checked) {
                                    //stringcode += "'" + $(row[r]).attr('id') + "'" + ','
                                    stringcode += $(row[r]).attr('id') + ','
                                    SetupNameICDDiagText += $(row[r]).text().trim() + ','
                                    //console.log(SetupNameICDDiagText);
                                }
                            }
                            var strSetUpCode = stringcode.substr(0, stringcode.length - 1);
                            var strSetUpCode = strSetUpCode;
                            var strIcdDiagSetupName = SetupNameICDDiagText.substr(0, SetupNameICDDiagText.length - 1);
                            var strIcdDiagSetupName = strIcdDiagSetupName;
                            //debugger;
                            ApendICDDiagData(strSetUpCode, strIcdDiagSetupName);//added by priyanka on 20/02/2025
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
                                    //CodeTosend.push($(row[r]).attr('id'));
                                    stringcode += "'" + $(row[r]).attr('id') + "'" + ','
                                    // stringcode +=  $(row[r]).attr('id') +  ','
                                }
                            }
                            var codeT = stringcode.slice(1)
                            var strCode = codeT.substr(0, codeT.length - 2);
                            debugger;
                            SavePersICDDiagnosisList(strCode);
                        }
                    },

                    Closed: {
                        text: '<i class="fa fa-close "></i>',
                        btnClass: 'btn-default',
                        //close
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

                    $(defaultbtn[2]).attr('id', 'btnAdd');//Added By Priyanka on 12/02/2025

                    $('.jc-bs3-row').removeClass('row')
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1')
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                    $('.jconfirm-bg').css('background-color', 'rgba(255, 255, 255, 0.62)');
                    $('.jconfirm-box').css('background-color', 'rgba(43, 43, 60, 0.98)');
                    $('.jconfirm-box').css('box-shadow', '#868686 0px -1px 14px 4px');

                }
            });

        }

        function SearchICDDiagnosisSetUpList() {
            // Declare variables 
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("txtICDDiagSetup");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblPersICDDiagnolist");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
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
            //debugger;
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">ICD Diagnosis SetUp</label>' +
                 '<input  type="varchar" id="txtICDDiagSetUp" maxlength="50"  placeholder="Enter SetUp Name" autofocus="autofocus" class="setUp form-control" required />' +//added length kavita
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
                            //debugger;
                            var strICDDiagArry = chlBoxValLst.join(",");

                            if (strICDDiagArry == "") {
                                $.alert('Select at least one test ');
                                return false;
                            }

                            //added on 19th may 2018
                            var chlBoxTitleLst = null;
                            chlBoxTitleLst = [];
                            $('#dblServiceHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxTitleLst.push($(this).attr('title'));
                            });
                            var strICDDiagArry2 = chlBoxTitleLst.join(",");

                            //------------------

                            //added on 7/3/19
                            //debugger;
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil")) {
                                strSetUpCode = $(obj).parents("tr")[0].id;
                            }
                            //--------------------

                            //debugger;
                            if (setUp != "") {
                                //$('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").

                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: '../DoctorDesk/AddICDDiagnosisSetUp',
                                    data: { strICDDiagnSetUpName: setUp, strICDDiagnLst: strICDDiagArry, strICDDiagNameLst: strICDDiagArry2, strICDDiagSetUpCode: strSetUpCode },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtICDDiagSetUp").val("");
                                            $("#txtICDDiagSetup").val("");//added on 07/03/19
                                            $.alert('Record inserted successfully');
                                            //GetpersonalisedList();
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

                        //close
                        //$('.FoodItems input:checked').focus();
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
                    //debugger;
                    ICDDiagnosisSerivceGrpData(srvcgrpname);

                    //debugger;
                    //added by priyanka on 25/01/2025
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectedSetUpsICDDiagno($(obj).parents('tr')[0].id);
                    }

                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                    $(".jconfirm-box-container").last().css('width', '480px');// added by vijeta on 22nd sep 2018
                }
            });

        }


        function SearchICDDiagServiceGroup() {
            //debugger;
            input = document.getElementById("txtIcdDiagServiceGrpsearch");
            filter = input.value.toUpperCase();
            //var elem = $("#SrvcGrpdata li");
            var elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent();// added by vijeta on 24th sep 2018
            var search = false;//added on  19th may 2018


            //added on 19th may 2018
            search = $(elem).hasClass('display');
            if ($(input).val().length >= 3) {
                //AddICDDiagnosis(filter);
                //getICDdiagnoList(filter);
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
                    //  return FreqDataSetupList[index]["DESCCD"].toString().trim() == label.defaultValue.toString().trim();
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
            //debugger;
            var $newDiv = $('<div>');
            $newDiv.attr("id", srvcgrpname);
            $newDiv.attr("name", srvcgrpname);
            $newDiv.addClass("searchdivclass");
            //$newDiv.css('width', '188px');
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
            //Iterated over the IEnumerable list.
            var abc = "<a id=btnsrvgrp style=color:blue;cursor:pointer float:right;>ClearSelection</a>"
            var i = 0;
            //$.each(SRVCGRPLIST, function (i, item) {
            //    var title = item.Text;
            //    var idstring = name + i;
            //    //Each option represents a value in dropdown. For each element in the list, option element is created and appended to the stringBuilder object.
            //    options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.Value + "'>" + title + "</label><li>";
            //});
            //added on 18th may 2018
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetICDDiagnoList","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {
                    FreqDataSetupList = response;// 18-12-19
                    if (response != "") {
                        //var result = JSON.parse(response);
                        $.each(response, function (i, item) {
                            var title = item.NAME;
                            var idstring = item.CODE;
                            options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.CODE + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>";
                        });
                    }
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                },

            });
            //-------------------------------------
            $newul.append(abc);
            $newul.append(options);
            $newDiv.append($newul);
            $('#divIcdDiagSrvcGrpSelect').append($newDiv);
        }

        $(document.body).on('click', '#dblServiceHelpsrvcgrp li input', function (e) {
            //debugger;
            if (e.currentTarget.checked === true) {
                //var SrvGrpCode = e.currentTarget.value;

                $(this).parent().parent().remove();

                var element = $("#dblServiceHelpsrvcgrp li input:checkbox:checked");
                //if (element.length == 0) {
                $($(this).parent().parent()).insertAfter('a[id="btnsrvgrp"]');
                //}
                //else {

                // $('#dblServiceHelpsrvcgrp li:eq(' + (element.length - 1) + ')').after($(this).parent().parent());
                //}
                $(this).focus();

            }
            else {

            }
            $("#dblServiceHelpsrvcgrp").show();
            $("#txtIcdDiagServiceGrpsearch").val("").trigger("keyup");
            e.stopPropagation();
        });


        //added on 22nd sep 2018
        $(document.body).on({
            'click': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
            },
            'focus': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
            },

        }, '#txtIcdDiagServiceGrpsearch');

        //added on 2nd may 2018
        $(document.body).on('click', '#btnsrvgrp', function (e) {
            //debugger;
            $('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);
        });

        function handleChange(obj) {
            //debugger;
            var parentRow = $(obj).parent().parent();
            $('#tblPersICDDiagnolist tbody').prepend(parentRow).closest('tr');
            $('table tr:nth-child(1)').find('input:first').focus(); // added by vijeta on 7th july 2018
            CountCheckBoxChecked();
        }

        function CountCheckBoxChecked() {
            //debugger;
            var CheckBoxCount = $('.chkPersDis:checked').size();
            if (CheckBoxCount > 0) {
                $('#btnSubmit').removeClass('disable-clicks');
            }
            else {
                $('#btnSubmit').addClass('disable-clicks');
            }
        }



        //added by priyanka on 25/01/2025
        function getNonFrequentICDDiagList(filter) {
            //debugger;
            HoldOn.open();//
            $.ajax({
                type: "POST",
                datatype: "json",
                url: "<%=Url.Action("GetNonFregqentICDDiagnosisList","DoctorDesk")%>",
                data: { NonFreqICD: filter },
                asycn: false,
                success: function (response) {
                    NonFreqDataSetupList = response;// 18-12-19
                    var result = response;
                    var options = "";
                    $.each(result, function (i, item) {
                        var title = item.NAME;
                        var idstring = item.CODE;
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.CODE + "'>" + title + "</label><li>";
                        // $('#tblinvestigate tbody').prepend(rows);
                    });
                    //$(options).insertAfter('a[id="btnsrvgrp"]');
                    $("ul#SrvcGrpdata").append(options);//added on 24th sep 2018
                    //$('ul#SrvcGrpdata').prepend(options).closest('li');
                    //ResponseCheck1 = result;

                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });

        }

        function FillSelectedSetUpsICDDiagno(strSetUpCode) {
            HoldOn.open();//
            //debugger;

            $.ajax({
                url: '../DoctorDesk/GetICDDiagnoListBySetupCode',
                data: { strSetUpCode: strSetUpCode },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    console.log(response);
                    if (response != "") {

                        $.each(response, function (i, val) {
                            if (val["CODE"] != "")//vijeta 30/3/19
                            {
                                var checkboxSelectorForIcd = "#dblServiceHelpsrvcgrp li input[value='" + val["CODE"] + "']";
                                if ($(checkboxSelectorForIcd).length === 0) {
                                    var element = "<li><label><input type='checkbox' id='' title='" + val["NAME"] + "' value='" + val["CODE"] + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label></li>";
                                    $(element).insertAfter('a[id="btnsrvgrp"]');
                                    $("#dblServiceHelpsrvcgrp li input#" + val["CODE"]).trigger("click");
                                }
                                    //commented by priyanka on 15/02/2025 showing duplicate records
                                    //if (response.length === 1) {
                                    //    //var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["NAME"] + "' value='" + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label><li>";
                                    //    var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["NAME"] + "' value='" + val["CODE"] + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label><li>";
                                    //    $("#dblServiceHelpsrvcgrp li input#" + val["CODE"]).trigger("click");
                                    //}
                                else {
                                    var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["NAME"] + "' value='" + val["CODE"] + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label><li>";
                                    $(elemnet).insertAfter('a[id="btnsrvgrp"]');
                                    //$("#dblServiceHelpsrvcgrp li input#" + val["CODE"]).trigger("click");
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
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            })
        }

        function GetpersonalisedICDDiagList() {
            //debugger;
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersICDDiagnoList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "" && response != "UNSUCCESSFULL") {//added vijeta 26/4/19
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);'></td><td class='ICDDiagnosisName' style='padding:5px;font-size: 13px;vertical-align:middle;width:80%' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='ICDDiagnosisSetUpAddEdit(this);'></i></span></td>";
                            // rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td><input class='chkPersDis' type='checkbox' style='margin-left:10px'></td><td><div class='icheckbox_flat-green' aria-checked='false' aria-disabled='false' style='position: relative;'><input type='checkbox' class='flat-red' style='position: absolute; opacity: 0;'><ins class='iCheck-helper' style='position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;'></ins></div></td><td class='MaterialName' style='padding:5px;font-size: 13px;'>" + $.trim(result.Table1[i].DESC) + "</td>";

                            rows += "</tr>";
                        }
                        $('#tblPersICDDiagnolist tbody').empty();// added by vijeta on 2nd may 2018
                        $('#tblPersICDDiagnolist tbody').append(rows).closest('tr');
                    }



                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();//
                },

            });


        }

        function SavePersICDDiagnosisList(strCode) {
            //debugger;
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/SavePersonICDDiagnosis',
                datatype: "json",
                aysc: false,
                data: { Code: strCode, strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                success: function (result) {
                    if (result.length > 0) {
                        if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            //window.location.href = 'Diagnosis';
                            //window.location.reload();

                            //window.history.pushState(null, null, '#${ICDDiagno}');
                            var activeTab = sessionStorage.getItem('activeTab');
                            if (activeTab) {
                                sessionStorage.setItem('activeTab', activeTab);  // Ensure it's stored before reload
                            }

                            // Reload the page
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
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }

            });
        }
        //debugger;
        $(document).on('click', '.clickable-row', function () {
            var TableId = $(this).closest('table').attr('id');
            var rowId = $(this).attr('id');
            var rowName = $(this).find('td').text();
            console.log('Clicked Row:', rowId, rowName);

            //added by priyanka on 18/02/2025
            var $row = $(this).closest('tr');

            if ($row.hasClass('active')) {

                var selRows = $('#' + TableId + ' > tbody > tr.active').get(); //group of selected rows

                if (selRows.length === 1) {
                    // If this is the first selected row, move it to the top
                    $("#" + TableId + " tbody").prepend($row);
                } else {
                    $.each(selRows, function (index, row) {
                        // Prepend each active row to the top
                        $(row).detach().prependTo('#' + TableId + ' tbody');
                    });
                }
            }

        });

        function ApendICDDiagData(strSetUpCode, strIcdDiagSetupName) {
            //debugger;
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
                                else//Added By Priyanka on 17/02/2025
                                {
                                    // If the row already exists, we can optionally move it to the top
                                    var existingRow = $("#" + item.CODE);
                                    existingRow.detach();
                                    existingRow.find('td').css('color', '#de4a04')
                                    $('#tblICDdiagno tbody').prepend(existingRow);
                                }

                                //setTimeout(function () {
                                //    $("#" + item.CODE.trim()).trigger('click');
                                //}, 0);

                                moveICDDiagnosisActiveRowsToTop();
                            });
                        },
                        complete: function () {



                        }
                        , error: function (XMLHttpRequest, textStatus, errorThrown) {
                            HoldOn.close();//
                            $.messager.alert("Error", errorThrown);
                        }
                    });
                }
                else {

                    //var existingSetupName = MapICDDiagSetupCodes.get(strSetUpCode);
                    //$.messager.alert("Setup Code Already Added",
                    // 'The setup "' + existingSetupName + '" with Setup Code "' + strSetUpCode + '" has already been added.');

                    var existingSetupName = MapICDDiagSetupCodes.get(strSetUpCode);
                    alreadyAddedSetupCodes.push(existingSetupName);

                }
            });
            if (alreadyAddedSetupCodes.length > 0) {
                var message = "The following setups have already been added:\n" + alreadyAddedSetupCodes.join(", ");
                $.messager.alert("Setup Already Added", message);
            }

        }
        //ICD Diagnosis Setup End

        //Added By Priyanka on 13/02/2025
        //Diagnosis Setup Start
        function CreateDiagnosisSetupList() {
            //debugger;
            $.confirm({
                title: 'Diagnosis Setup',
                theme: 'supervan',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                content: '' + //
                 '<form action="" class="formName" style="height:410px;"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:-16px" class="form-control" id="DiagnosisSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtDiagSetup" type="text" id="input-name" placeholder="Search Setup" class="form-control" onkeyup="SearchDiagnosisSetUpList()" style="" autofocus></td></tr></table></div>' +
                '<div id="divtblDiagnosisSetup" class="divtblDiagnosisSetup" style=""><table id="tblPersDiagnolist" style="width:100%;border-top:1px solid #29884bd6 !important;" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {
                    Add: {//Added By Priyanka on 12/02/2025
                        text: '<i class="fa fa-plus-circle"></i>',
                        action: function () {
                            stringcode = '';
                            SetupNameDiagText = '';
                            var row = $('#tblPersDiagnolist tr')
                            for (r = 0; r < row.length; r++) {
                                var Chk = $(row[r]).find('.chkPersDis')
                                if (Chk[0].checked) {
                                    //stringcode += "'" + $(row[r]).attr('id') + "'" + ','
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
                                    //CodeTosend.push($(row[r]).attr('id'));
                                    stringcode += "'" + $(row[r]).attr('id') + "'" + ','
                                    // stringcode +=  $(row[r]).attr('id') +  ','
                                }
                            }
                            var codeT = stringcode.slice(1)
                            var strCode = codeT.substr(0, codeT.length - 2);
                            //debugger;
                            SavePersDiagnosisList(strCode);
                        }
                    },

                    Closed: {
                        text: '<i class="fa fa-close "></i>',
                        btnClass: 'btn-default',
                        //close
                    },

                },

                onOpen: function () {
                    $('jconfirm-box').css('margin-top', '10px !important;')
                },
                onContentReady: function () {
                    //debugger;
                    GetpersonalisedDiagList();

                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    var defaultbtn = $('.jconfirm-buttons>button');
                    $.each(defaultbtn, function (index, val) {
                        $(defaultbtn[index]).css('font-size', '35px');
                        $(defaultbtn[index]).css('margin-right', '10px');
                    })
                    $(defaultbtn[0]).attr('id', 'btnSubmit');
                    $(defaultbtn[0]).addClass('disable-clicks');

                    $(defaultbtn[2]).attr('id', 'btnAdd');//Added By Priyanka on 12/02/2025

                    $('.jc-bs3-row').removeClass('row')
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1')
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
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
            //debugger;
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
                            //debugger;
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
                            //debugger;
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil")) {
                                strSetUpCode = $(obj).parents("tr")[0].id;
                            }
                            //--------------------

                            //debugger;
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
                                            //debugger;
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
                    //debugger;
                    DiagnosisSerivceGrpData(srvcdiaggrpname);

                    //debugger;
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectedSetUpsDiagnosis($(obj).parents('tr')[0].id);
                    }

                    // bind to events
                    //debugger;
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                    $(".jconfirm-box-container").last().css('width', '480px');// added by vijeta on 22nd sep 2018
                }
            });

        }


        function DiagnosisSerivceGrpData(srvcdiaggrpname) {
            //debugger;
            var $newDiv = $('<div>');
            $newDiv.attr("id", srvcdiaggrpname);
            $newDiv.attr("name", srvcdiaggrpname);
            $newDiv.addClass("searchdivclass");
            //$newDiv.css('width', '188px');
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
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetMainDiagnoList","DoctorDesk")%>",
                data: DataToSend,
                async: false,
                success: function (response) {
                    FreqDataSetupList = response;// 18-12-19
                    if (response != "") {
                        //var result = JSON.parse(response);
                        $.each(response, function (i, item) {
                            var title = item.DESC;
                            var idstring = item.DESCCD;
                            options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.DESCCD + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>";
                        });
                    }
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                },

            });
            //-------------------------------------
            $newul.append(abc);
            $newul.append(options);
            $newDiv.append($newul);
            $('#divDiagSrvcGrpSelect').append($newDiv);
        }


        $(document.body).on('click', '#dblServiceDiagHelpsrvcgrp li input', function (e) {
            debugger;
            if (e.currentTarget.checked === true) {
                $(this).parent().parent().remove();
                var element = $("#dblServiceDiagHelpsrvcgrp li input:checkbox:checked");
                $($(this).parent().parent()).insertAfter('a[id="btnDiagsrvgrp"]');
                $(this).focus();
            }
            else {

            }
            $("#dblServiceDiagHelpsrvcgrp").show();
            $("#txtDiagServiceGrpsearch").val("").trigger("keyup");
            e.stopPropagation();
        });

        //debugger;
        $(document.body).on({

            'click': function (e) {
                $("#dblServiceDiagHelpsrvcgrp").show();
            },
            'focus': function (e) {
                $("#dblServiceDiagHelpsrvcgrp").show();
            },

        }, '#txtDiagServiceGrpsearch');

        //debugger;
        $(document.body).on('click', '#btnDiagsrvgrp', function (e) {
            //debugger;
            $('#dblServiceDiagHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);
        });

        function SearchDiagServiceGroup() {
            //debugger;
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
                //debugger;
                $.each(checdelem, function (j, item) {

                    var label = checdelem[j].getElementsByTagName("input")[0];
                    if (label)
                        FreqDataSetupList = FreqDataSetupList.filter(function (e, index) {

                            return FreqDataSetupList[index]["DESCCD"].toString().trim() != label.defaultValue.toString().trim();
                        });
                });
                //debugger;
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
            //debugger;
            var ClinicCode = $.session.get('ClinicCode').toString().trim();
            HoldOn.open();//
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
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });

        }


        function GetpersonalisedDiagList() {
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersDiagnoList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "" && response != "UNSUCCESSFULL") {//added vijeta 26/4/19
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChangeDiagSetup(this);'></td><td class='DiagnosisName' style='padding:5px;font-size: 13px;vertical-align:middle;width:80%' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='DiagnosisSetUpAddEdit(this);'></i></span></td>";
                            // rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td><input class='chkPersDis' type='checkbox' style='margin-left:10px'></td><td><div class='icheckbox_flat-green' aria-checked='false' aria-disabled='false' style='position: relative;'><input type='checkbox' class='flat-red' style='position: absolute; opacity: 0;'><ins class='iCheck-helper' style='position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;'></ins></div></td><td class='MaterialName' style='padding:5px;font-size: 13px;'>" + $.trim(result.Table1[i].DESC) + "</td>";

                            rows += "</tr>";
                        }
                        $('#tblPersDiagnolist tbody').empty();// added by vijeta on 2nd may 2018
                        $('#tblPersDiagnolist tbody').append(rows).closest('tr');
                    }



                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();//
                },

            });


        }


        function FillSelectedSetUpsDiagnosis(strSetUpCode) {
            HoldOn.open();//
            //debugger;

            $.ajax({
                url: '../DoctorDesk/GetDiagnosisListBySetupCode',
                data: { strSetUpCode: strSetUpCode },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    console.log(response);
                    if (response != "") {

                        $.each(response, function (i, val) {
                            if (val["CODE"] != "")//vijeta 30/3/19
                            {
                                var checkboxSelector = "#dblServiceDiagHelpsrvcgrp li input[value='" + val["CODE"] + "']";
                                if ($(checkboxSelector).length === 0) {
                                    var element = "<li><label><input type='checkbox' id='' title='" + val["NAME"] + "' value='" + val["CODE"] + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label></li>";
                                    $(element).insertAfter('a[id="btnDiagsrvgrp"]');
                                    $("#dblServiceDiagHelpsrvcgrp li input#" + val["CODE"]).trigger("click");
                                }
                                    //commented by priyanka on 15/02/2025 showing duplicate records
                                    //if (response.length === 1) {
                                    //    //var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["NAME"] + "' value='" + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label><li>";
                                    //    var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["NAME"] + "' value='" + val["CODE"] + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["NAME"] + "</label></label><li>";
                                    //    $("#dblServiceDiagHelpsrvcgrp li input#" + val["CODE"]).trigger("click");
                                    //}
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
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            })
        }

        function handleChangeDiagSetup(obj) {
            //debugger;
            var parentRow = $(obj).parent().parent();
            $('#tblPersDiagnolist tbody').prepend(parentRow).closest('tr');
            $('table tr:nth-child(1)').find('input:first').focus();
            CountCheckBoxChecked();
        }


        function SavePersDiagnosisList(strCode) {
            //debugger;
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/SavePersonDiagnosisSetup',
                datatype: "json",
                aysc: false,
                data: { Code: strCode, strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                success: function (result) {
                    if (result.length > 0) {
                        if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            //window.location.href = 'Diagnosis';
                            //window.location.reload();

                            ////window.history.pushState(null, null, '#${ICDDiagno}');
                            //var activeTab = sessionStorage.getItem('activeTab');
                            //if (activeTab) {
                            //    sessionStorage.setItem('activeTab', activeTab);  // Ensure it's stored before reload
                            //}

                            // Reload the page
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
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }

            });
        }
        function ApendDiagData(strSetUpCode, strDiagSetupName) {
            //debugger;
            var setupname = $("#txtDiagSetUp").val();
            var splitsetupcode = strSetUpCode.split(',');
            var splitsetupname = strDiagSetupName.split(',');
            var alreadyAddedDiagSetupCodes = [];
            //var setUp = this.$content.find('.setUp').val();
            $.each(splitsetupcode, function (index, strSetUpCode) {
                strSetUpCode = strSetUpCode.trim();
                var currentDiagSetupName = splitsetupname[index].trim();
                if (addedDiagSetupCodes.indexOf(strSetUpCode) === -1) {
                    //if (!addedSetupCodes.has(strSetUpCode)){
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
                                if ($("#" + item.CODE.trim()).length === 0) {//check for duplicate rows

                                    var row = "<tr class='clickable-row' id='" + item.CODE.trim() + "'>" +
                                              //"<td style='padding:5px; width:90%;font-size: 13px;text-align:left; color:'#de4a04;''class='DiagnoNm'>" + item.NAME.trim() + "</td>" +
                                              "<td style='padding:5px; width:90%; font-size: 13px; text-align:left; color:#de4a04;' class='DiagnoNm'>" + item.NAME.trim() + "</td>" +
                                              "<td class='DiagnosisRemark' style='width:10%'><a href='javascript:;' style='display:none' onclick='AddDiagnosisRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                              "<td class='tdSetUpYn' style='display:none;'></td>" +
                                              "<td class='RemarkText' style='display:none;'></td>" +
                                              //"<td class='SetupCode' style='display:none;'>" + strSetUpCode + "</td>" +
                                              "</tr>";
                                    $('#tbldiagno tbody').prepend(row);

                                    //$("#" + item.CODE.trim()).trigger('click');
                                }
                                else {   //Added by priyanka on 17/02/2025
                                    // If the row already exists, we can optionally move it to the top
                                    var existingRow = $("#" + item.CODE);
                                    existingRow.detach();
                                    existingRow.find('td').css('color', '#de4a04')
                                    $('#tbldiagno tbody').prepend(existingRow);
                                }
                                moveDiagnosisActiveRowsToTop();//added by priyanka on 20/02/2025
                            });

                        },
                        complete: function () {

                        }
                        , error: function (XMLHttpRequest, textStatus, errorThrown) {
                            HoldOn.close();//
                            $.messager.alert("Error", errorThrown);
                        }
                    });
                }
                else {
                    //$.messager.alert("Setup code " + strSetUpCode + " is already added.");
                    var existingSetupName = MapDiagSetupCodes.get(strSetUpCode);
                    alreadyAddedDiagSetupCodes.push(existingSetupName);
                    //$.messager.alert("Setup Code Already Added",
                    //    'The setup "' + existingSetupName + '" with Setup Code "' + strSetUpCode + '" has already been added.');
                }
            });

            if (alreadyAddedDiagSetupCodes.length > 0) {
                var message = "The following setups have already been added:\n" + alreadyAddedDiagSetupCodes.join(", ");
                $.messager.alert("Setup Already Added", message);
            }
        }
        //Added By Priyanka on 20/02/2025
        function moveDiagnosisActiveRowsToTop() {
            var activeRows = $('#tbldiagno tbody tr.active').get();
            if (activeRows.length > 0) {
                $(activeRows).each(function () {
                    $(this).detach().prependTo('#tbldiagno tbody');
                });
            }
        }


        //Added By Priyanka on 20/02/2025
        function moveICDDiagnosisActiveRowsToTop() {
            var activeRows = $('#tblICDdiagno tbody tr.active').get();
            if (activeRows.length > 0) {
                $(activeRows).each(function () {
                    $(this).detach().prependTo('#tblICDdiagno tbody');
                });
            }
        }

        function SearchDiagnosisSetUpList() {
            // Declare variables 
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("txtDiagSetup");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblPersDiagnolist");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
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
        //Diagnosis Setup End
    </script>

    <script type="text/javascript" >
        var AllStageList = [];
        var AllDescList = [];
        function LoadFormTNM() {
            ClearTNMFields();
            GetSiteList();
            DisableTNM();
        }

        function GetSiteList() {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetSiteSubSiteList","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {
                    BindComboList('CmbSiteList', response, "Value", "Text");
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
                },
            });
        }

        function GetSubSiteList() {
            if ($("#CmbSiteList").val() != "") {
                var DataToSend = {
                    SiteCd: $("#CmbSiteList").val()
                }
                $.ajax({
                    type: "POST",
                    url: "<%=Url.Action("GetSiteSubSiteList","DoctorDesk")%>",
                    data: DataToSend,
                    async: false,
                    success: function (response) {
                        BindComboList('CmbSubSiteList', response, "Value", "Text");
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
                BindComboList('CmbSubSiteList', [], "");
            }
            DisableTNM();
        }

        function ClearTNMFields() {
            BindComboList('CmbSiteList', [], "", "");
            BindComboList('CmbSubSiteList', [], "", "");
            BindComboList('ICDTList', [], "", "");
            BindComboList('ICDNList', [], "", "");
            BindComboList('ICDMList', [], "", "");
            BindComboList('CmbStageList', [], "", "");
            AllStageList = [];
            //   = [];
            ClearDescTable();
            DisableTNM();
        }

        function DisableTNM() {
            if ($("#CmbSiteList").val() == "" || $("#CmbSubSiteList").val() == "") {
                $("#ICDTList").prop("disabled", true);
                $("#ICDNList").prop("disabled", true);
                $("#ICDMList").prop("disabled", true);
                $("#CmbStageList").prop("disabled", true);
                BindComboList('ICDTList', [], "", "");
                BindComboList('ICDNList', [], "", "");
                BindComboList('ICDMList', [], "", "");
                BindComboList('CmbStageList', [], "", "");
            }
            else if ($("#ICDTList").val() == "") {
                $("#ICDTList").prop("disabled", false);
                $("#ICDNList").prop("disabled", true);
                $("#ICDMList").prop("disabled", true);
                $("#CmbStageList").prop("disabled", true);
                BindComboList('ICDNList', [], "", "");
                BindComboList('ICDMList', [], "", "");
                BindComboList('CmbStageList', [], "", "");
            }
            else if ($("#ICDNList").val() == "") {
                $("#ICDTList").prop("disabled", false);
                $("#ICDNList").prop("disabled", false);
                $("#ICDMList").prop("disabled", true);
                $("#CmbStageList").prop("disabled", true);
                BindComboList('ICDMList', [], "", "");
                BindComboList('CmbStageList', [], "", "");
            }
            else if ($("#ICDMList").val() == "") {
                $("#ICDTList").prop("disabled", false);
                $("#ICDNList").prop("disabled", false);
                $("#ICDMList").prop("disabled", false);
                $("#CmbStageList").prop("disabled", true);
                BindComboList('CmbStageList', [], "", "");
            }
            else {
                $("#ICDTList").prop("disabled", false);
                $("#ICDNList").prop("disabled", false);
                $("#ICDMList").prop("disabled", false);
                $("#CmbStageList").prop("disabled", false);
            }
        }

        function ClearDescTable() {
            document.getElementById("DIV_TNMDesc").style.display = "none";
            //$("#TTHead").empty();
            $("#TTBody").empty();
            //$("#NTHead").empty();
            $("#NTBody").empty();
            //$("#MTHead").empty();
            $("#MTBody").empty();
        }

        function GetTNMList() {
            if ($("#CmbSiteList").val() != "" && $("#CmbSubSiteList").val() != "") {
                var DataToSend = {
                    SiteCode: $("#CmbSiteList").val(),
                    SubSiteCode: $("#CmbSubSiteList").val()
                }
                $.ajax({
                    type: "POST",
                    url: "<%=Url.Action("GetStagingList","DoctorDesk")%>",
                    data: DataToSend,
                    async: false,
                    success: function (response) {
                        AllStageList = response[0] == null ? [] : response[0];
                        AllDescList = response[1] == null ? [] : response[1];
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
                BindComboList('ICDTList', [], "", "");
                BindComboList('ICDNList', [], "", "");
                BindComboList('ICDMList', [], "", "");
                BindComboList('CmbStageList', [], "", "");
            }
        }

        function FilterTList() {
            var FilterLst = [];
            var siteVal = $("#CmbSiteList").val();
            var subSiteVal = $("#CmbSubSiteList").val();
            if (siteVal != "" && subSiteVal != "") {
                let uniqueMap = new Map();
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() === siteVal &&
                        e.SUBSITE.toString().trim() === subSiteVal &&
                        !uniqueMap.has(e.T)
                    ) {
                        uniqueMap.set(e.T, e);
                    }
                });
                FilterLst = Array.from(uniqueMap.values());

            }
            BindComboList('ICDTList', FilterLst, "T", "T");
            DisableTNM();
        }

        function FilterNList() {
            var FilterLst = [];
            var siteVal = $("#CmbSiteList").val();
            var subSiteVal = $("#CmbSubSiteList").val();
            var TVal = $("#ICDTList").val();
            if (siteVal != "" && subSiteVal != "" && TVal != "") {
                let uniqueMap = new Map();
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() == siteVal &&
                        e.SUBSITE.toString().trim() == subSiteVal &&
                        e.T.toString().trim() == TVal &&
                        !uniqueMap.has(e.N)
                    ) {
                        uniqueMap.set(e.N, e);
                    }
                });
                FilterLst = Array.from(uniqueMap.values());
            }
            BindComboList('ICDNList', FilterLst, "N", "N");
            DisableTNM();
        }

        function FilterMList() {
            var FilterLst = [];
            var siteVal = $("#CmbSiteList").val();
            var subSiteVal = $("#CmbSubSiteList").val();
            var TVal = $("#ICDTList").val();
            var NVal = $("#ICDNList").val();
            if (siteVal != "" && subSiteVal != "" && TVal != "" && NVal != "") {
                let uniqueMap = new Map();
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() == siteVal &&
                        e.SUBSITE.toString().trim() == subSiteVal &&
                        e.T.toString().trim() == TVal &&
                        e.N.toString().trim() == NVal &&
                        !uniqueMap.has(e.M)
                    ) {
                        uniqueMap.set(e.M, e);
                    }
                });
                FilterLst = Array.from(uniqueMap.values());
            }
            BindComboList('ICDMList', FilterLst, "M", "M");
            DisableTNM();
        }

        function FilterStageList() {
            var FilterLst = [];
            var siteVal = $("#CmbSiteList").val();
            var subSiteVal = $("#CmbSubSiteList").val();
            var TVal = $("#ICDTList").val();
            var NVal = $("#ICDNList").val();
            var MVal = $("#ICDMList").val();
            var SVal = "";
            if (siteVal != "" && subSiteVal != "" && TVal != "" && NVal != "" && MVal != "") {
                let uniqueMap = new Map();
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() == siteVal &&
                        e.SUBSITE.toString().trim() == subSiteVal &&
                        e.T.toString().trim() == TVal &&
                        e.N.toString().trim() == NVal &&
                        e.M.toString().trim() == MVal &&
                        !uniqueMap.has(e.STAGE)
                    ) {
                        uniqueMap.set(e.STAGE, e);
                    }
                });
                FilterLst = Array.from(uniqueMap.values());
            }
            if (FilterLst.length == 1) {
                SVal = FilterLst[0].STAGE;
            }
            BindComboList('CmbStageList', FilterLst, "STAGE", "STAGE");
            $("#CmbStageList").val(SVal);
            DisableTNM();
        }
        function BindComboList(ComboId, ListData, PropVal, PropText) {
            $(("#" + ComboId)).empty();
            var Option = '<option value="{VALUE}">{TEXT}</option>';
            var DefSel = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
            $("#" + ComboId).append(DefSel);
            jQuery.grep(ListData, function (e) {
                var Options = Option.replace("{VALUE}", e[PropVal]).replace("{TEXT}", e[PropText]);
                $("#" + ComboId).append(Options);
            });
            $("#" + ComboId).val("");
        }

        function BindDescriptionList() {
            var siteVal = $("#CmbSiteList").val();
            var subSiteVal = $("#CmbSubSiteList").val();

            if (siteVal != "" && subSiteVal != "")
                document.getElementById("DIV_TNMDesc").style.display = "block";
            else
                document.getElementById("DIV_TNMDesc").style.display = "none";

            var FilterTListDesc = AllDescList.filter(function (e) { return e.TNM.toString().trim().includes("T"); });
            var FilterNListDesc = AllDescList.filter(function (e) { return e.TNM.toString().trim().includes("N"); });
            var FilterMListDesc = AllDescList.filter(function (e) { return e.TNM.toString().trim().includes("M"); });
            var TR = "<tr>{TRCONTENT}</tr>";
            var TD = "<td {CLASS}>{TDCONTENT}</td>";
            jQuery.grep(FilterTListDesc, function (e) {
                var TNMName = TD.replace("{TDCONTENT}", e.TNM.toString().trim()).replace("{CLASS}", "class='FirstTDClass'");
                var Desc = TD.replace("{TDCONTENT}", e.DESCRIPTION.toString().trim());
                var RplTR = TR.replace("{TRCONTENT}", (TNMName + Desc));
                $("#TTBody").append(RplTR);
            });
            jQuery.grep(FilterNListDesc, function (e) {
                var TNMName = TD.replace("{TDCONTENT}", e.TNM.toString().trim()).replace("{CLASS}", "class='FirstTDClass'");
                var Desc = TD.replace("{TDCONTENT}", e.DESCRIPTION.toString().trim());
                var RplTR = TR.replace("{TRCONTENT}", (TNMName + Desc));
                $("#NTBody").append(RplTR);
            });
            jQuery.grep(FilterMListDesc, function (e) {
                var TNMName = TD.replace("{TDCONTENT}", e.TNM.toString().trim()).replace("{CLASS}", "class='FirstTDClass'");
                var Desc = TD.replace("{TDCONTENT}", e.DESCRIPTION.toString().trim());
                var RplTR = TR.replace("{TRCONTENT}", (TNMName + Desc));
                $("#MTBody").append(RplTR);
            });
        }

        function AppendListToCombo(ComboId, ListData) {
            var Option = '<option value="{VALUE}">{TEXT}</option>';
            var DefSel = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
            $("#" + ComboId).append(DefSel);
            jQuery.grep(ListData, function (e) {
                var Options = Option.replace("{VALUE}", e.Value).replace("{TEXT}", e.Text);
                $("#" + ComboId).append(Options);
            });
        }

        function ValidationTNM(MsgYN) {
            var Site = $("#CmbSiteList").val();
            var SubSite = $("#CmbSubSiteList").val();
            var T = $("#ICDTList").val();
            var N = $("#ICDNList").val();
            var M = $("#ICDMList").val();
            var Stage = $("#CmbStageList").val();
            if (Site != "") {
                if (SubSite == "") {
                    $("#CmbSubSiteList").focus();
                    $("#CmbSubSiteList").css("border-color", "red");
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
    </script>



</asp:Content>