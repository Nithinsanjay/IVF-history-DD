<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.IPMedication>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="MainDiv">
        <div id="ContentHolderDiv" class="contentHoldClass" style="width: 100%">
            <div id="NewDiv">
            <%--    <label id="myAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-top: 3px; margin-right: 24px; border-color: transparent;display:none" title="Add new Medicine">
                    <img src="../Images/add.png" id="addAdvice" style="background-color: white; border-radius: 50%; position: fixed;">
                </label>
                <input type="text" id="ComplaintInput" placeholder="&#xF002; Search Medicines" style="border-radius: 5px; margin-top: 2px; margin-left: 14px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); height: 28px; position: fixed;"
                    class="empty">
                <label id="FillButton" style="background-color: transparent; float: right; border-color: transparent;" title="Refill Medicines" class="fillBtn">
                    <button type="button" class="btn bg-olive margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 14px; margin-top: 3px;">ReFill</button>
                </label>
                <label id="PersMedi" style="background-color: transparent; float: right; border-color: transparent;" title="Create Personalised list" onclick="CreatePersonalList()" class="PersBtn">
                    <button type="button" class="btn btn-info margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 14px; margin-top: 3px;">Pers...</button>
                </label>
                <label style="background-color: transparent; float: right; border-color: transparent;" title="Severity" onclick="GetSeverity()" class="SeverityBtn">
                    <button type="button" id="btnInteraction" class="btn btn-info margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 14px; margin-top: 3px;border-radius: 50%;height: 28px;width: 28px;background-color:green;"></button>
                </label>--%>
                 <table style="width: 100%;margin: 1% 0 1% 0;"><!--kavita-->
                <tr style="width: 100%;">
                    <td style="width: 50%;">
                        <label style=" display: inline-block;margin-left:3%">Provisional Diagnosis</label>
                       
                        <%=Html.TextAreaFor(x => Model.ProvDiagno, new { id = "txtProvDiagno", @class = "TextBxFormat", maxlength = "1000", Style = "width: 72%;height:30px;vertical-align: middle;",@rows = "5",@readonly="True"})%></td>
                    <td  style="width: 50%;">
                        <label style=" display: inline-block;">Allergies</label>
                        
                        <%: Html.TextAreaFor(x => Model.Allergies, new { id = "txtAllergies", @class = "TextBxFormat", maxlength = "1000", Style = "width: 85%;height:30px;vertical-align: middle;",@rows = "5" ,@readonly="True"})%>
                    </td>
                  <%--  vishal 16th Nov--%>
                     <td style="display:none">                    <%--<input type="button" id="btnCancelShwHide" class="Nbutton" value ="" />--%>
                        <label id="PersMedi" style="background-color: transparent; float: right; border-color: transparent;display:none" title="Create Personalised list" onclick="CreatePersonalList()" class="PersBtn">
                    <button type="button" class="btn btn-info margin" style="position: fixed; padding: 2px 12px; font-size: 14px; margin-top: -1%;">Pers...</button>
                </label>
                         <%-- <button id="btnSearch" class="btn btn-primary" style="background-color: #337ab7; border-color: #2e6da4;"><i class="fa fa-search" aria-hidden="true"></i></button>--%>
                    </td>
                </tr>
            </table>
               
            </div>
            <div class="StuckInput">
                 <label id="myAdd" style="background-color: transparent; float: left;  margin-right: 24px; border-color: transparent;" title="Add new Medicine">
                    <img src="../Images/add.png" id="addAdvice" style="background-color: white; border-radius: 50%; position: fixed;">
                </label>
                <input type="text" id="ComplaintInput" <%--onkeyup="SearchComplaint()"--%> placeholder="&#xF002; Search Medicines" style="border-radius: 5px;float:left; margin-left: 7px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); height: 28px; position: fixed;"
                    class="empty">
                  <table style="width: 100%; background-color: #909d9044; border: 1px solid grey;width: 46%;float: right;">
            <tr style="line-height: 20px;vertical-align: middle;">
                <td style="width: 11px;">
                    <div class="tsStatus" style="background-color: #e02c0f !important;margin-top: -5px;"></div>
                </td>
                <td style="width: 70px">
                    <label class="LBLFormat">High Alert</label>
                </td>
                <td style="width: 11px;">
                    <div class="tsStatus PlanedOmitt" style="margin-top: -5px;"></div>
                </td>
                <td style="width: 115px">
                    <label class="LBLFormat  ">Planned & Omitted</label>
                </td>
                <td style="width: 11px;">
                    <div class="tsStatus " style="background-color: #61f4235c !important;margin-top: -5px;"></div>
                </td>
                <td style="width: 50px">
                    <label class="LBLFormat  ">Omitted</label>
                </td>
                <td style="width: 11px;">
                    <div class="tsStatus" style="background-color: #f4d6f4c7 !important;margin-top: -5px;"></div>
                </td>
                <td style="width: 60px">
                    <label class="LBLFormat  ">Planned</label>
                </td>
                <td style="width: 11px;">
                    <div class="tsStatus cancellation" style="margin-top: -5px;"></div>
                </td>
                <td style="width: 60px">
                    <label class="LBLFormat  ">Cancelled</label>
                </td>
              
            </tr>
        </table>
            </div>

            
            <label id="btnSave" style="background-color: transparent;   border-color: transparent;" title="Save" class="rightbtn">
                <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;margin-left: 70%;">
            </label>


            <div id="wrapper" style=" width: 79.5%; margin-left: 5px;padding-top:0.5%" class="wrapperWidth">
                <div class="tableDiv" style="padding-top: 1%;">
                    <%----%>
                    <table class="HeadRxMainDiv">
                     
                         <thead>
                            <tr style="font-size: 12px; background-color: #fffdc8">
                                <th style="width: 17%" id="medcn">Medicine</th>
                                <th style="width: 3%"></th>
                                <th style="width: 8%;">Frequency</th>
                                <th id="Duration" text-align: center" colspan="2" style="width: 8%;">Duration</th>
                               <%-- <th style="width: 4%">Type</th>--%>
                                <th id="tRoutHead">Route</th>
                                <th style="width: 5%">Dosage</th>
                                <th style="width: 10%">Remark</th>
                                 <th style="width: 6%">Diluent</th>
                                 <th style="width: 6%">>Dil<sup>n</sup> / Vol.</th>
                                 <th style="width: 6%">Dur.of Admin </th>
                                 <th style="width: 8%">Startdate</th>
                                 <th style="width: 8%">Omit/Cancel</th>

                                 <th style="width: 6.45%" id="orderBy">Order By</th>
                              


                               <%-- <th style="width: 4%"></th>
                                <th style="width: 4.4%" id="EmptyHead"></th>--%>
                            </tr>
                        </thead>

                    </table>
                    <%-- 4/11/19--%>
                    <table id="tblMedicineList" class="table HeadRxMainDiv" style="width: 100%">
                        <tbody id="tblsort"></tbody>
                    </table>
                </div>
                <%--added by vijeta 1/7/19--%>
                <div style="margin-top: -20px;">
                    <table id="tblMtrlNewSearch" style="display: none; width: 100%">
                        <tbody id="tblsort1"></tbody>
                    </table>
                </div>
            </div>


            <div id="layer-intake" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <%--4/01/19--%>
                <a href="javascript:;" style="font-size: 14px">Intak1</a>
                <a href="javascript:; " style="font-size: 14px">Intak2</a>
                <a href="javascript:; " style="font-size: 14px">Intak3</a>
                <a href="javascript:;" style="font-size: 14px">Intak4</a>
            </div>
            <div id="layer-durationNum" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <%--4/01/19--%>
            </div>
            <div id="layer-durationWords" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <%--4/01/19--%>
                <%--<a href="javascript:;" onclick="SetText('D')" style="font-size: 14px">Days</a>
                <a href="javascript:; " onclick="SetText('W')" style="font-size: 14px">Weeks</a>
                <a href="javascript:; " onclick="SetText('M')" style="font-size: 14px">Months</a>
                <a href="javascript:;" onclick="SetText('Y')" style="font-size: 14px">Years</a>--%>
            </div>
            <div id="layer-Food" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <%--4/01/19--%>
                <a href="javascript:; " onclick="SetText('-')" style="font-size: 14px">-</a>       <%--Added by Tejashri on 24/12/2018--%>
                <a href="javascript:;" onclick="SetText('A')" style="font-size: 14px">After Food</a>
                <a href="javascript:; " onclick="SetText('B')" style="font-size: 14px">Before Food</a>
            </div>

             <!--kavita 08-aug-2019-->
               <div id="layer-Route" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
              
            </div>
             <!--kavita 08-aug-2019-->
            <div id="layer-Remark" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <%--4/01/19--%>
            </div>
            <div id="layer-Vol" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <%--4/01/19--%>
            </div>
             <div id="layer-ADur" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <%--4/01/19--%>
            </div>
            <div id="layer-Type" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <%--4/01/19--%>
            </div>
        </div>

        <div id="MonographMaterail" style="display: none">         
           <%-- <%=Html.Raw(HttpUtility.HtmlDecode("<html xmlns:mims=\"http://www.mims.com\"><head><META http-equiv=\"Content-Type\" content=\"text/html; charset=utf-16\"><link type=\"text/css\" href=\"../css/redmond/jquery-ui-1.8.6.custom.css\" rel=\"stylesheet\"><link type=\"text/css\" href=\"../css/mims.css\" rel=\"stylesheet\"><script type=\"text/javascript\" src=\"../Scripts/jquery-1.4.4.min.js\"></script><script type=\"text/javascript\" src=\"../Scripts/jquery-ui-1.8.6.custom.min.js\"></script><script type=\"text/javascript\" src=\"../Scripts/monograph.js\"></script><style>\n\t\t\t\tdiv.drug-label {\n\t\t\t\t\t\twidth: 90mm;\n\t\t\t\t\t\theight: 35mm;\n\t\t\t\t    border: 1pt solid;\n\t\t\t\t    border-radius: 5pt;\n\t\t\t\t\t\tpadding: 5pt;\n\t\t\t\t\t\tmargin-bottom: 5pt;\n\t\t\t\t}\n\t\t\t\t.drug-label h4 {\n\t\t\t\t\tfont-size: 10pt;\n\t\t\t\t\tfont-weight: bold;\n\t\t\t\t\tfont-family: Arial;\n\t\t\t\t\tmargin: 2pt;\n\t\t\t\t}\n\t\t\t\t.drug-label p {\n\t\t\t\t\tfont-size: 8pt;\n\t\t\t\t\tfont-weight: normal;\n\t\t\t\t\tfont-family: Arial;\n\t\t\t\t\tmargin: -1pt 2pt 2pt 2pt;\n\t\t\t\t}\n\t\t\t\t.cals-details p {\n\t\t\t\t\tmargin-bottom: 0pt;\n\t\t\t\t}\n\t\t\t\t.cal-details li a {\n\t\t\t\ttext-decoration: none;\n\t\t\t\t}\n\n\t\t\t\t.cal-details strong { margin-right: 2pt; }\n\n\t\t\t\tol.allergy-list { padding-left: 1.33em; }\n\t\t\t\tol.allergy-list > li { padding-top: 0.5em; }\n\t\t\t\tol.allergy-list h4.subheading { margin-top: 0.2em; }\n\t\t\t\t</style></head><body><div id=\"tabs\"><ul><li><a href=\"#tab-generic\">Generic</a></li></ul><div id=\"tab-generic\"><h4 class=\"subheading\">WARF TAB 2mg</h4><table class=\"ui-widget monograph\"><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">Dosage</span></td><td class=\"ui-widget-content\"><I>Oral</I><BR><B>Prevention and treatment of venous thromboembolism</B><BR><B><I>Adult: </I></B>Initially, 5 mg daily. Rapid anti-coagulation: Initially, 10 mg daily for 2 days. Adjust subsequent doses based on PT/INR. Usual maintenance dose: 2-10 mg daily.\r\n<BR><B><I>Elderly: </I></B>Lower initial dose. <BR><B><I>Renal impairment: </I></B>Severe: Avoid. <BR><B><I>Hepatic impairment: </I></B>Severe: Avoid.<BR><I>Intravenous</I><BR><B>Prevention and treatment of venous thromboembolism</B><BR><B><I>Adult: </I></B>Given as slow bolus Inj over 1-2 min into peripheral vein. Initially, 5 mg daily. Rapid anti-coagulation: Initially, 10 mg daily for 2 days. Adjust subsequent doses based on PT/INR. Usual maintenance dose: 2-10 mg daily.<BR><B><I>Elderly: </I></B>Lower initial dose. <BR><B><I>Renal impairment: </I></B>Severe: Avoid. <BR><B><I>Hepatic impairment: </I></B>Severe: Avoid.</td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">Administration</span></td><td class=\"ui-widget-content\">May be taken with or without food.<br></td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">Contraindications</span></td><td class=\"ui-widget-content\">Hypersensitivity; haemorrhagic tendencies or blood dyscrasia; recent surgery; peptic ulcer; severe hypertension; bacterial endocarditis; cerebrovascular disorders; psychosis; senility; aneurysms; pericarditis; pericardial effusion; eclampsia; pre-eclampsia; threatened abortion; alcoholism; severe renal and hepatic impairment; pregnancy.</td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">Special precautions</span></td><td class=\"ui-widget-content\">Heparin induced thrombocytopenia, DVT, infectious disease, disturbances of intestinal flora, surgery or trauma, indwelling catheters, hypertension, Vit C, Vit K, protein C or S deficiency. Elderly, lactation, alcoholics. Purple toes syndrome (due to cholesterol microembolisation) may occur between 3-10 wk after start of therapy. Discontinue therapy if necrosis develops. Periodic determination of PT/INR. Patient to report any signs of bleeding, symptoms of blood clot and avoid activities or sports that can cause injuries. An INR &lt;2 generally represents insufficient anticoagulation while INR&gt;4 represents higher risk of bleeding.</td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">Adverse reactions</span></td><td class=\"ui-widget-content\">Hypersensitivity, rash, alopecia, diarrhoea, drop in haematocrit, purple toes syndrome, skin necrosis, jaundice, nausea, vomiting, hepatic dysfunction, pancreatitis, increased LFT.<BR/> <B>Potentially Life-Threatening Adverse Drug Reaction: </B>Haemorrhage (narrow therapeutic index).</td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">Drug interactions</span></td><td class=\"ui-widget-content\"> <B>Potentially Hazardous Interaction: </B>Acute alcoholism, allopurinol, NSAIDs, anabolic steroids, amiodarone, propafenone, quinidine, chloramphenicol, ciprofloxacin, co-trimoxazole, erythromycin, metronidazole, ofloxacin, sulfonamides, azithromycin, clarithromycin, norfloxacin, tetracyclines, SSRI, fluconazole, itraconazole, miconazole, ketoconazole, proguanil, cisapride, ifosfamide, disulfiram, piracetam, zafirlukast, interferon-&alpha;, isoniazid, tramadol, glucagon, doxycycline, propylthiouracil, danazol, flutamide, tamoxifen, clofibrate, simvastatin, cimetidine, sulfinpyrazone enhance anticoagulant effect of warfarin. Drugs eg, rifampicin, carbamazepine, phenobarbital, barbiturates, bosentan, nafcillin, azathioprine, menthol, primidone, griseofulvin and aminoglutethimide, oral contraceptives containing oestrogens, corticosteroids, sucralfate, vit K as well as chronic alcoholism reduce anticoagulant effect. Cholestyramine may reduce anticoagulant effect, avoid admin of warfarin 1 hr before or 4-6 hr after cholestyramine.</td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">Mechanism of action</span></td><td class=\"ui-widget-content\">Warfarin inhibits synthesis of vit K-dependent coagulation factors VII, IX, X and II and anticoagulant protein C and its cofactor protein S. No effects on established thrombus but further extension of the clot can be prevented. Secondary embolic phenomena are avoided.<BR><B>Onset: </B>24 hr<BR><B>Duration: </B>2-5 days.<BR><B>Absorption: </B>Absorbed readily from the GI tract (oral); used as racemic isomers, S-isomers more potent. Peak plasma concentration: within first 4 hr.<BR><B>Distribution: </B>Protein binding: Extensive (99%) to albumin. Crosses placenta.<BR><B>Metabolism: </B>Hepatic; mainly by the cytochrome P450 isoenzyme CYP2C9, which shows genetic polymorphism. Other enzymes involved include CYP2C19, CYP2C8, CYP2C18, CYP1A2, and CYP3A4. S-isomer is metabolised more rapidly than R-isomer.<BR><B>Excretion: </B>Via urine (as metabolites after reabsorption from the bile); 37 hr (elimination half-life).</td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">Lab Interference</span></td><td class=\"ui-widget-content\">May cause false decrease in serum theophylline concentrations with the Schack and Waxler ultraviolet method.</td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">Food Interaction</span></td><td class=\"ui-widget-content\">Avoid major changes in dietary intake of Vit K (green vegetables eg broccoli, spinach). Increased anticoagulant effects with chamomile, cranberry, gingko biloba, alfalfa, dong quai, black cohosh, celery, capsicum, clove, omega 3 triglycerides, fenugreek, ginger. Reduced anticoagulant effect with St John''s wort, Panax ginseng, coenzyme Q10, mistletoe.</td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">MIMS Class</span></td><td class=\"ui-widget-content\">Anticoagulants, Antithrombotics, Fibrinolytics</td></tr><tr><td class=\"monograph-heading ui-widget-content\"><span style=\"font-weight: bold\">ATC Classification</span></td><td class=\"ui-widget-content\">B01AA03 - Warfarin; Belongs to the class of vitamin K antagonists. Used in the treatment of thrombosis.<BR></td></tr></table></div></div></body></html>")) %>--%>
            <%--<%:Html.Action("GetHtmlPage","DoctorDesk", new { path = "~/Views/Shared/Interaction.html" }) %>--%>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
   <%-- <script src="../Scripts/PatList.js"></script>--%>

      <style>
       
       
        table {
            width: 100%;
        }

        
        .mediAddspan{
               float: right;
        margin-right: 6px;
        margin-top: -28px;
        position: relative;
        z-index: 2;
        color: #3d7da3;
        cursor:pointer;
        }
       .intakeImageSpan{
            color: #4086bf;
            margin-top: -3px;
            pointer-events: auto; cursor: pointer;
        }

          .shadow {
            box-shadow: 2px 2px 2px 2px red;
            }

            .empty {
            width: 62%;
             }

        .OuterRoundWhiteRight {
            background-color: white;
            width: 46px;
            height: 22px;
            border-radius: 2px 12px 12px 2px;
            color: black;
            text-align: center;
            border-width: 1px;
        }


     

        /* added by vijeta on 30th april 2018*/
        .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
            color: #000;
            font-weight: normal;
        }

      /*added by vijeta on 15th may 2018*/
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
        .BtnInke {
            width: 40px;
            border-radius: 20px 20px 20px 20px;
            height: 38px;
            text-align: center;
            margin-right: 20px;
            background-color: rgba(76, 228, 76, 0.67);
            cursor: pointer;
        }
        .borderC:first-child {
            border-radius: 16px 0px 0px 16px;
        }

        .borderC:last-child {
            border-radius: 0 16px 16px 0;
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
       /*-----------19th oct-----4/11/19--------------*/
        /*.triggerInputIntake {
            
            height: 27px;
            font-size: 14px;
        }
.MaterialName {
            padding: 5px !important;
            font-size: 13px;
            width: 26% 
        }
        td.tdNewMedSpan {
           width: 4%;
        }

        td.tdIntake {
            width: 15%;
        }

        td.durationNum {
            width: 5%;
        }

        td.durationWord {
            width: 5%;
        }

        td.tdBeforeAfter {
            width: 5%;
        }

        td.tdDosses {
            width: 10%;
            font-size: 14px;
        }

        .tdRemark {
            width: 19% !important;
        }

        .triggerInputDosses {
            width: 100%;
            height: 27px;
        }
        
         td.sortTD1 {
           width:4%;
        }
        td.sortTD2{
            width:4%;
        }
       tbody::after {
        content: ''; display: block;
        page-break-after: always;
        page-break-inside: avoid;
        page-break-before: avoid;        
    }*/
        /*.intakeImage
         {
             width:16px;
             height:16px;
         }*/
        /*-----------19th oct-------------------*/

        /*----------------------------------*/
            @media only screen and (min-width : 992px) {
            /*.empty {
                width: 48%; 
            }*/

            /*.fillBtn {
                margin-right: -31px !important;
            }

            .PersBtn {
                margin-right: -87px !important;
            }*/


            /*.wrapperWidth {
                width: 122% !important;
            }*/

            .divtblDisease {
                height: 500px !important;
                /*overflow-y: hidden !important;*/
            }

                .divtblDisease:hover {
                    overflow-y: scroll !important;
                }
                
        }
         @media only screen and (min-width:1400px) {
              /*.wrapperWidth {
                width: 122% !important;
            }*/
  .empty {
                width: 47.2%; /**/
            }
  .PersBtn {
                margin-right: -5.40% !important;/*//3/28/19*/
            }
              .fillBtn{
                  margin-right: 20.6%;
              }
              
           
             .StuckInput button{/*//*/
             margin-left: 1%;
         }

             .SeverityBtn {
                margin-right: -15.30% !important;
               
            }
        }
    @media only screen and (min-width: 1366px) and  (max-width: 1399px){/*//4/11/19*/
             /*.wrapperWidth {
                width: 117% !important;
            }*/
             .fillBtn{
                  margin-right: 17%;/*//3/28/19*/
              }
               .empty {
                width: 49.2%; /**/
            }
               .PersBtn {
                margin-right: -7.40% !important;/*//3/28/19*/
            }

                .SeverityBtn {
                margin-right: -15.30% !important;
                
            }
          
        }

       #medcn{
                  width:28.1%;
              }
       #Duration{
           width:10.1%;
       }
           @media only screen and (min-width: 1024px) and  (max-width: 1365px) {
               .empty {
                width: 46.2%; /**/
            }
             /*.wrapperWidth {
                width: 87% !important;
            }*/
             .fillBtn{
                 margin-right: 21%;/*//3/28/19*/
                 
              }
             .PersBtn {
    margin-right: -10.4% !important;
}
                .SeverityBtn {
                margin-right: -18.30% !important;              
            }
              #EmptyHead {
          width:4.8% !important;
      }  

              #medcn{
                  width:29.2%;
              }
               #Duration{
           width:10%;
       }
               .MaterialName {
            padding: 5px !important;/*//3/28/19*/
            font-size: 13px;
            /*width: 27% !important;*/
        }
        }
             
        .sortTD {
            width: 20px !important;
        }

 
        .JsBtnPostion {
            text-align: center !important;
        }

        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            font-size: 14px !important;
            text-decoration: inherit;
        }

        .tdDe {
            width: 5px !important;
        }

        .disable-clicks {
            pointer-events: none;
            color: red;
        }

        @media (min-width: 1200px) {
            .container {
               /* width: 1422px !important;*/
            }
        }

       /*.jconfirm-box {
            margin-top: 50px !important;
        }*/ /* 3/28/19 commntd*/

        .divtblDisease {
            height: 300px;
            overflow-y: scroll;
        }

        div.divtblDisease::-webkit-scrollbar {
            width: 8px;
        }

        div.divtblDisease::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        div.divtblDisease::-webkit-scrollbar-thumb {
            background: #b4b6f2;
            border-radius: 3px;
        }

        #tblPersDiseaselist > tbody > tr > td {
            border-top: 1px solid rgba(234, 228, 228, 0.32) !important;
        }

        /*added by vijeta on 7th July 2018*/
        .ui-jqgrid tr.jqgrow td {
            word-wrap: break-word; /* IE 5.5+ and CSS3 */
            white-space: pre-wrap; /* CSS3 */
            white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
            white-space: -pre-wrap; /* Opera 4-6 */
            white-space: -o-pre-wrap; /* Opera 7 */
            /*overflow: hidden;*/
            height: auto;
            vertical-align: middle;
            padding-top: 3px;
            padding-bottom: 3px;
        }

        .RemarkSelc {
            /*-webkit-appearance: none;*/
            -moz-appearance: none;
            text-indent: 1px;
            width: 77px;
            background-color: white;
            /*border-radius: 10px 10px 10px 10px;*/
            margin-bottom: 3px;
            margin-right: 3px;
            border: none;
            height: 26px;
            outline: 0;
        }

         #tblMaterialList tr td:not(:first-child) a{
            width: 100%;
            display:block;
        }
          @media (min-width: 992px) {
            .jconfirm-box-container {
                margin-left: 24.333333%;

            }
        }/*//3/28/19*/
          .jconfirm .jconfirm-scrollpane {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
     overflow-y: hidden; 
    -webkit-perspective: 500px;
    perspective: 500px;
    -webkit-perspective-origin: center;
    perspective-origin: center;
}/*//3/28/19*/
 .jc-bs3-container{
     /* width: 1500px !important;*/
    }/*//3/29/19*/
   
    .table > tbody > tr.active > td:not(.MaterialName):not(.tdRemark){   /*:not added vijeta 10/4/19*/
     border-left:1px solid #bbbbbb;
     /*padding:0px;*/
     padding-left: 0px;
    padding-right: 0px;
    padding-top: 3px;
    padding-bottom: 0px;
     text-align: center;
    vertical-align: middle;
 } /**/
        .table > tbody > tr.active > td > a {
            width: 100%;
            display: table;
        } /**/ 
      
          
       
.HeadRxMainDiv { min-width: 500px; }

.HeadRxMainDiv > thead,
.HeadRxMainDiv > tbody >tr{
/*thead, tbody tr {*/
    display: table;
    width: 100%;
    table-layout: fixed;
}
.HeadRxMainDiv > tbody{
/*tbody {*/
    display: block;
    max-height: 500px;
    overflow-x: hidden;
    overflow-y: scroll;
}

.HeadRxMainDiv > tbody > tr > td {
    overflow: hidden;
    text-overflow: ellipsis;
}
.HeadRxMainDiv > thead > tr > th{
    text-align:center;
    border: 1px solid #a33f3f;
}
.HeadRxMainDiv > thead > tr,
.HeadRxMainDiv > tbody > tr
{
    width:100%;
}
        @media (min-width: 1400px) {
            .HeadRxMainDiv  { min-width: 600px; }
            .HeadRxMainDiv > tbody {
    display: block;
    max-height: 600px;
    overflow-x: hidden;
    overflow-y: scroll;
}

        }



        .has-feedback .form-control {
    padding-right: 27.5px;
} 
.formintakecontrol{
    position: absolute;
    top: 4px;
    right: 0;
    z-index: 2;
    display: block;
    width: 27px;
    height: 25px;
    
    text-align: center;
    
    line-height: 28px !important;
    background: #ffebf6;
    border-radius:0px 5px 5px 0px;
}
        /*end*/
        .JsBoxCss{

            width:400px;
            height:160px;
        }
        .JsBoxCssButtons {
            margin-top:50px;
        }
        /*end*/

        .fillBtn {
    margin-right: 50.6%;
}
    
      #tRoutHead{
                  width:9%
              }

          @media only screen and (max-width : 1366px) {
              .tabcontainer {
                  font-size: 10px;
              }
              #tRoutHead{
                  width:8.88%
              }
          }
          #NewDiv{
    width:79.5%;
}
           .StuckInput table{
                  /*width:95% !important;*/
                  margin-right: 23%;
              }
            #ComplaintInput{
                  width:28%;
              }
          @media only screen and (max-width : 1024px) {
              .content-wrapper {
                 margin-left: 0px !important;
              }
              .menuButton {
  
    padding: 10px;
   
}
              #anchrSignOut{
                  margin-left: 13px;
              }
              .tabcontainer {
                  margin-left: 2px;
              }
              #ICU_Pat_Name{
                  font-size: 10px !important;
              }
             .nav-tabs > li > a {
   
    line-height: 1.42857143;
    border: 1px solid transparent;
    border-radius: 4px 4px 0 0;
}
              /*#tRoutHead{
               width: 9%;
              }*/
               #orderBy{
width:6.5% !important;
     }
              .wrapperWidth{
                  width:100% !important;
              }

  .StuckInput table{
                  width:46% !important;
                  margin-right: 2.6%;
              }
              #ComplaintInput{
                  width:46%;
              }

#NewDiv{
    width:100%;
}

          }
           .Omited {
            background: #b3eb9c !important;
        }
           .Canceled{
              background: #f9af8e !important;
           }

           .planclass{
 background: #f5dff6 !important;
           }


           .plannedAndOmitted{
                background: #FEE188 !important;
               
           }
 .table > tbody > tr > td:not(.MaterialName):not(.tdRemark){   /*:not added vijeta 10/4/19*/
    
     /*padding:0px;*/
     padding-left: 0px;
    padding-right: 0px;
    padding-top: 3px;
    padding-bottom: 0px;
     text-align: center;
    vertical-align: middle;
 } /**/


    .table > tbody > tr > td > a {
            width: 100%;
            display: table;
        } /**/ 

tr.Omited ,tr.planclass,tr.plannedAndOmitted, tr.Canceled {

     border-left:1px solid #bbbbbb;
}
   .ui-autocomplete {
              max-height: 300px;
              overflow-y: auto; /* prevent horizontal scrollbar */
              overflow-x: hidden; /* add padding to account for vertical scrollbar */
              z-index: 1000 !important;
          } 
   
   a.disabled {
  pointer-events: none;
  cursor: default;
}  
   .Omited {
    background-color: #c4faae !important;
}   
    
         @media only screen and (max-width : 1024px) {
             .content-wrapper {
                 margin-left: 0px !important;
             }
         }


    
    </style>
  <%--  <script src="../../js/Ipmedication.js"></script>--%>
      <script src="../Scripts/ICUPatList.js"></script>
    <script src="../js/Ipmedication.js"></script>
   <%-- <script src="..//RxNewSearch.js"></script>--%>
    <script>
        var MaxForMedStat = [];
        var stopProp = true;
        var ResponseCheck = '';
        var ResponseCheck1 = '';//adde by vijeta on 19th may 2018      
        var srvcgrpname = "dblServiceHelpsrvcgrp"; //added on 30th april 2018
        //added on 15th may 2018
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
        var rowNoFrMedTaper = 0;
        var todayfor = "";
        var todayfor = "";
        var gact = "N";
        //......flags while clicking on row for color indication 
        var flagactv = 0;
        var flagforomit = 0;
        var flagforplanng = 0;
        var flagforpalnAndOmit = 0;
        var flagforCancel = 0;
        //-----------------------------------

        var ItakesArray = [];
        //var RemarkArray = [];
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var LoginUser = '<%:  ("" + Session["gOncoUserId"]).ToString().Trim() %>';
        GetSetUpList("RxNew");
        var RemarkArray = "<%:ViewData["RemarkArray"] as System.Collections.Generic.List<object>%>";
         <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var RemarkArray = '<%:Html.Raw(Samp.Serialize(ViewBag.RemarkArray))%>';
        var MedRoute = '<%:Html.Raw(Samp.Serialize(ViewBag.MedRoute))%>';
        var RxNewSetDataflag = 0;
        var PlanData = ""; 
        var CIMSYN = '<%:  ("" + Session["CIMYN"]).ToString().Trim() %>';  //Meenakshi
        $(document).ready(function () {
            todayfor = new Date();
            var dd = todayfor.getDate();
            var mm = todayfor.getMonth() + 1;
            var yyyy = todayfor.getFullYear();
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }
            todayfor = dd + '/' + mm + '/' + yyyy;


            //$("#tblMedicineList").find("tr").each(function () {
            //    $(this).find("td.tdSDate input").datepicker();
            //});

            //$(".triggerInputSDate").datepicker(
            //           {
            //               showButtonPanel: true,
            //               changeMonth: true,
            //               yearRange: "c-150:c+99",
            //               changeYear: true,
            //               dateFormat: "dd/mm/yy",
            //               maxDate: new Date(),
            //               // minDate: admissiondate
            //           });
            //$(".triggerInputSDate").val(todayfor);

            $.session.set('ADDButton', "");
            var myArray;
            GetNursStationsNPAtients();
            $("#tabMenu").css("display", "block");


           
            if (($.session.get('IPStatOrdersflag')) == "Stat")
                ActiveMenu("IPStatOrders");
            else
                ActiveMenu("IPMedication");


            SetPatientDtl();
            // document.getElementById('ComplaintInput').focus() //added by kavita
            LoadAllpopUps();
           

            BindIntakeCombination();
           

            if ($(window).width() >= 1025) {
                //screen width size comparion
               
                $("#PatAdviceSetUpList").css("display", "block");// added by vijeta on 4th oct 2018
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                //kavita 12-aug-2019
                // dispLst.style.display = "block";  
                $("#slide_sdList").click();

                //$("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018
              
                //kavita 10-aug-2019
                var tblheadHeight = $("#PatAdviceSetUpList").height();
                var menulistheight = $("#menuList").height();
                $('#divMenuList').css("height", (menulistheight - (tblheadHeight + 7)) + "px");
                //kavita 10-aug-2019
            }
            if ($(window).width() >= 1200) {
                $("#tabMenu").css("display", "block");
            }
            /*---------------------------------Fill Medicine---------------------------------*/
            $("#FillButton").click(function () {
                var Mrno = ($.session.get('PatMRNO'));
                var strTran = ($.session.get('PatTRANNO'))
                var RefillResult;
                $.confirm({
                    title: 'Medicine Fill Confirmation',
                    content: 'Are you sure want to override privious transaction Medicine ?',
                    buttons: {
                        confirm: function () {
                            $.ajax({
                                type: "POST",
                                url: "<%=Url.Action("RefillMedicine","DoctorDesk")%>",
                                data: { strTranNO: strTran, strMRNo: Mrno, cimsYN: CIMSYN },
                                async: false,
                                success: function (response) {
                                    RefillResult = response
                                    //if (("" + RefillResult).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                    //    window.location.reload();
                                    //   // GetSavedData();
                                    //}

                                    //else {
                                    //    $.alert('No medicine present to refill for current transaction');
                                    //}

                                },
                                complete: function () {
                                    if (("" + RefillResult).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                        //window.location.reload();
                                        GetSavedData();
                                    }

                                    else {
                                        $.alert('No medicine present to refill for current transaction');
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.loader.close();
                                    $.messager.alert("Error", errorThrown);
                                },


                            });
                        },
                        cancel: function () {
                            $.alert('Canceled!');
                        },
                    }
                });
            });

            $("#btnSave").click(function () {
                // window.location.href = 'PatientEntry';
                SaveAllMedicines("N");
            });

            $("#myAdd").click(function () {

                $.confirm({
                    title: '',
                    content: '' +
                    '<form action="" class="formName" style="height:60px">' +
                    '<div class="form-group">' +
                    '<label>Medicine</label>' +
                     '<input  type="varchar" id="txtMedicine" maxlength="70"  placeholder="Medicine" autofocus="autofocus" class="medicine form-control" required />' +//kavita
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                $.session.set('ADDButton', "Click");
                                var medicine = this.$content.find('.medicine').val();
                                var grpCode = "";
                                if (medicine == "") {
                                    $.alert('Enter Medicine');
                                    return false;
                                }
                                if (medicine != "") {
                                    jQuery.expr[':'].contains = function (a, i, m) {
                                        return jQuery(a).text().toUpperCase()
                                            .indexOf(m[3].toUpperCase()) >= 0;
                                    };

                                    rowNoFrMedTaper = rowNoFrMedTaper + 1; //vijeta 12/4/19
                                    var medCode = "NEW" + rowNoFrMedTaper; //vijeta 12/4/19

                                    if ($('#tblMedicineList tr.active > td.MaterialName:contains(' + medicine + ')').length == 0) {
                                        var row = "";
                                        var MaxSeqMedStat;
                                        if (MaxForMedStat.length > 0) {
                                            MaxSeqMedStat = Math.max.apply(Math, MaxForMedStat);

                                        } else {
                                            MaxSeqMedStat = 0;
                                        }

                                        MaxForMedStat.push(MaxSeqMedStat + 1);

                                        var result = {
                                            MTRLCODE: medCode,
                                            MTRLNAME: medicine,
                                            GENERICNAM: "",
                                            GENERICID: "",
                                            RESEQ: MaxSeqMedStat +1,
                                        };
                                        row = MedicinesRow(result, false);
                                        //row += "<tr class='' id='" + medCode + "'>" +

                                        //"<td class='MaterialName' style='padding:5px;font-size: 13px;width:28%'>" + medicine + "</td><td class='tdNewMedSpan'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td><td class='GenriName' style='display:none'>" + "" + "</td><td class='GenricID' style='display:none'>" + "" + "</td>" +                                       
                                        //"<td class='tdIntake' style='width:15%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='frequency' id='intake" + medCode + "' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add new intake'></span></div></td>" +
                                        //"<td class='durationNum' style='width:5%'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + medCode + "' style='display:none;font-size:16px'>0</a></td>" +
                                        //"<td class='durationWord' style='width5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + medCode + "' style='display:none;font-size:16px'>D</a></td>" +
                                        //"<td class='tdBeforeAfter style='width:5%' ><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + medCode + "' style='display:none;font-size:16px'>-</a></td>" +//after food before food
                                        //"<td class='tdDosses' style='width:10%'><input type='text'class='triggerInputDosses form-control'  style='display:none;'  placeholder='Dosage' id='dossage" + medCode + "'/></td>" + //dosses
                                        //"<td class='tdRemark' style='width:25%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + medCode + "' style='display:none;font-size:16px'>Remark</a><input type='hidden' id='hdn" + medCode + "' /></td>" +
                                        //"<td class='setupyn' style='display:none'>N</td>" +
                                        //"<td class='refillyn' style='display:none'>N</td>" +

                                        //"<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                                        //"<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";
                                        //row += "</tr>";

                                        $("#tblMedicineList tbody").prepend(row).closest('tr');
                                        $('#tblMedicineList tr#' + medCode).trigger('click');
                                        $("#tblMedicineList tr#" + medCode + " input.triggerInputIntake").autocomplete({  //vijeta 5/4/19
                                            source: ItakesArray,
                                            autoFocus: false,
                                            minLength: 0,
                                            select: function (event, ui) { //on select added vijeta 8/4/19

                                                var txtval = ui.item.value;
                                                var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                                                var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();//added 15/4/19
                                                var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();//added 15/4/19
                                                var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();//added 15/4/19
                                                var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;//added 15/4/19
                                                var remark =  $(this).parents('td').siblings('.tdRemark').find('input')[0].value;//added 15/4/19
                                                var Vol = $(this).parents('td').siblings('.tdVol').find('a').text();
                                                var ADur = $(this).parents('td').siblings('.tdADur').find('a').text();
                                                var Dilnt = $(this).parents('td').siblings('.tdDilnt').find('input')[0].value;
                                                var SDate = $(this).parents('td').siblings('.tdSDate').find('input')[0].value;


                                                var DrugCode = $(this).parents('td').prevAll('.tdDrugCode').text();
                                                var TypeCode = $(this).parents('td').prevAll('.tdTypeCode').text();
                                                var OmittedBy = $(this).parents('td').prevAll('.tdOmittedBy').text();
                                                var OmittedDate = $(this).parents('td').prevAll('.tdOmittedDate').text();
                                                var OmittedTime = $(this).parents('td').prevAll('.tdOmittedTime').text();
                                                var OrderedDate = $(this).parents('td').prevAll('.tdOrderedDate').text();
                                                var OrderedTime = $(this).parents('td').prevAll('.tdOrderedTime').text();
                                                var DrugSequenceNo = $(this).parents('td').prevAll('.tdDrugSequenceNo').text();
                                                var HighAlertDrug = $(this).parents('td').prevAll('.tdHighAlertDrug').text();
                                                var NotifyYN = $(this).parents('td').prevAll('.tdNotifyYN').text();
                                                var Status = $(this).parents('td').prevAll('.tdStatus').text();
                                                var ADMINYN = $(this).parents('td').prevAll('.tdADMINYN').text();


                                                var tableRow = $("#tblMedicineList tr").filter(function () {
                                                    return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim() && $(this).find('td.tdVol a').text().trim() == Vol.trim() && $(this).find('td.tdADur a').text().trim() == Dil.trim() && ($(this).find('td.tdDilnt input')[0].value).toUpperCase().trim() == Dilnt.toUpperCase().trim() && ($(this).find('td.tdSDate input')[0].value).trim() == SDate.trim()
                                                    && $(this).find('td.tdDrugCode').text().trim() == DrugCode.trim() && $(this).find('td.tdTypeCode').text().trim() == TypeCode.trim() && $(this).find('td.tdOmittedBy').text().trim() == OmittedBy.trim() && $(this).find('td.tdOmittedDate').text().trim() == OmittedDate.trim() && $(this).find('td.tdOmittedTime').text().trim() == OmittedTime.trim() && $(this).find('td.tdOrderedDate').text().trim() == OrderedDate.trim()
                                                    && $(this).find('td.tdOrderedTime').text().trim() == OrderedTime.trim() && $(this).find('td.tdDrugSequenceNo').text().trim() == DrugSequenceNo.trim() && $(this).find('td.tdHighAlertDrug').text().trim() == HighAlertDrug.trim() && $(this).find('td.tdNotifyYN').text().trim() == NotifyYN.trim() && $(this).find('td.tdStatus').text().trim() == Status.trim() && $(this).find('td.tdADMINYN').text().trim() == ADMINYN.trim()
                                                }).closest("tr");

                                                if (tableRow.length > 0) {
                                                    $.messager.alert('Information', 'This medicine and Frequency already present');
                                                    $(this).val('');
                                                    $(this).focus();
                                                    return false;
                                                }
                                                else {
                                                    if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                                                       
                                                        $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "0";
                                                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                                                        //$(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                                                        //  $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                                                    }

                                                    else {

                                                        $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "1";
                                                        
                                                        // $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                                                        $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                                                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                                                    }
                                                }


                                            }
                                        }).focus(function () {
                                            /* Only search if the autocomplete menu is hidden: */
                                            if ($("ul.ui-autocomplete").is(":hidden")) {
                                                $(this).autocomplete('search', '');
                                            }
                                        });

                                        $("#tblMaterialList tr#" + medCode + "" + " input.triggerInputIntake").trigger("focus"); //

                                        $("#tblMedicineList tr#" + medCode + "").find("input.triggerInputIntake").trigger("keydown");//
                                    }
                                    else {
                                        $.messager.alert("Information", "This Medicine already selected");
                                        // $('#ComplaintInput').val(medicine);
                                        //  SearchComplaint();

                                        $("#tblNonFreqMtrlList").hide();
                                    }
                                }

                            }
                        },
                        cancel: function () {

                        },
                    },
                    onContentReady: function () {
                        $('#txtMedicine').focus();
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

            $(".removeMedicine").click(function (e) {
                e.stopPropagation();
                var CurrenRow = ($(this)[0].closest('tr'));
                var CurrenRowId = $(CurrenRow).attr('id');
                var strTranNo = $.session.get("PatTRANNO");
                RemoveMedicine(CurrenRowId, strTranNo);
                // var MedicineName = $(CurrenRow).children("td.MaterialName").text();

                //$.confirm({
                //    title: 'Medicine delete confirmation!',
                //    content: 'Are you sure you want to delete Medicine :' + '  <strong>' + MedicineName + '  </strong>' + '?',
                //    buttons: {
                //        confirm: {
                //            text: 'Yes, sure!',
                //            btnClass: 'btn-orange',
                //            action: function () {
                //                RemoveMedicine(CurrenRowId, strTranNo);
                //            }
                //        },
                //        cancel: function () {
                //            $.alert('canceled');trigg
                //        }
                //    }
                //});
            });



            $('.triggerIntake,.triggerNum,.triggerDays,.triggerFood,.triggerRemark,.triggerRoute,.triggerVol,.triggerADur,.triggerType').po({
                alignment: 'center'
            });

            $("#layer-durationNum .NumDaysCls").click(function (e) {
                var txt = $(this).text();
                SetText(txt);
              
            });
            $("#layer-durationWords .NumDaysCls").click(function (e) {

                var txt = $(this).text();
                SetText(txt);
                // $('.triggerFood').focus();//4/1/19
            });

            $("#layer-Food").click(function (e) {

                // $('.triggerInputDosses').focus();//4/1/19
            });


            $(document.body).on('click', '#layer-Remark .anchorRemark', function (e) {
                var txt = $(this).text();
                var code = $(this)[0].id;
                SetRemarkText(txt, code);
            });
            $(document.body).on('click', '#layer-Type .anchorType', function (e) {
                var txt = $(this).text();
                var code = $(this)[0].id;
                SetTypeText(txt, code);
            });
            //kavita 08-aug
            $(document.body).on('click', '#layer-Route .anchorRoute', function (e) {
                var txt = $(this).text();
                var code = $(this)[0].id;
                SetRouteText(txt, code);
            });
            $(document.body).on('click', '#layer-Vol .anchorVol', function (e) {
                var txt = $(this).text();
                var code = $(this)[0].id;
                SetVolText(txt, code);
            });
            $(document.body).on('click', '#layer-ADur .anchorADur', function (e) {
                var txt = $(this).text();
                var code = $(this)[0].id;
                
                SetADurText(txt, code);
            });


          
            //kavita 08-aug
            $(document.body).on('click', '.triggerIntake,.triggerNum,.triggerDays,.triggerFood,.triggerInputDosses,.triggerInputIntake,.triggerRoute,.triggerRemark,.triggerType, .triggerNewIntake,.triggerPrepend,.triggerAppend,.triggerVol,.triggerADur,.triggerDiltn,.triggerSDate', function (e) {
                e.stopPropagation();
                idOfPopUpAnchor = $(this).attr("id");

                if ($(this).is('.triggerPrepend')) {

                    var currntRow = $(this).closest('tr');
                    if (currntRow.hasClass('active')) {
                        if (currntRow.prev().length) {
                            if ($(currntRow.prev()).hasClass('active'))
                                currntRow.prev().before(currntRow);
                        }
                    }
                    stopProp = false;
                }

                if ($(this).is('.triggerAppend')) {
                    var currntRow = $(this).closest('tr');
                    if (currntRow.next().length) {
                        if ($(currntRow.next()).hasClass('active'))
                            currntRow.next().after(currntRow);
                    }
                    stopProp = false;
                }
                $("#searchType").val("");
                $("#searchRemark").val("");
               
                $("#searchRoute").val("");
                
                $("#searchVol").val("");
                $("#searchADur").val("");

                searchRemark();
                searchType();
                searchRoute();
                searchVol();
                searchADur();
            });

            $(document.body).on('click', '#tblMedicineList td a,#tblMedicineList td', function (e) {
                var elm = $(this).parents("tr")[0].id;
                $.each($("tr#" + elm + " td a"), function (i, val) {
                    var divId = $(this).attr("data-layer-id");
                    if (divId != "" && divId !=null)
                        $("div#" + divId + "").css("display", "none");
                });
                if ($(this).attr("data-layer-id") != "" && $(this).attr("data-layer-id") != null) {
                    $("div#" + $(this).attr("data-layer-id") + "").css("display", "block");
                    $('#' + $(this).data('layer-id')).removeClass('is-active');
                }
                if (!$(this).is('.MaterialName'))
                    e.stopPropagation();


                if ($(this).is('.tdSDate')) {

                    todayfor = new Date();
                    var dd = todayfor.getDate();
                    var mm = todayfor.getMonth() + 1;
                    var yyyy = todayfor.getFullYear();
                    if (dd < 10) {
                        dd = '0' + dd
                    }
                    if (mm < 10) {
                        mm = '0' + mm
                    }
                    todayfor = dd + '/' + mm + '/' + yyyy;


                    //$("#tblMedicineList").find("tr").each(function () {
                    //    $(this).find("td.tdSDate input").datepicker();
                    //});

                    //$(this).find('td.tdSDate input').datepicker(
                    //           {
                    //               showButtonPanel: true,
                    //               changeMonth: true,
                    //               yearRange: "c-150:c+99",
                    //               changeYear: true,
                    //               dateFormat: "dd/mm/yy",
                    //               maxDate: new Date(),
                    //               // minDate: admissiondate
                    //           });
                    //$(".triggerInputSDate").val(todayfor);

                }
            });

            $(document.body).on('click', '#tblMedicineList td.tdIntake span.intakeImageSpan', function (e) {
                e.stopPropagation();
                NewIntake("Out", e); //added on 1/4/19
                //var rowId = $(this)[0].closest('tr').id;
                //var mediName = $("#tblMedicineList tr#" + rowId + " .MaterialName")[0].innerText;
                //var row = "";
                //var timestamp = new Date().getUTCMilliseconds();//by vijeta on 11th march 19
                //row += "<tr class='' id='NEW" + timestamp + "'>" +
                //          //"<td class='AddNewIntake'><a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/add.png'  class='intakeImage'></a></td>" +//27th oct 2018
                //          "<td class='MaterialName'>" + mediName + "</td><td class='GenriName' style='display:none'></td>" +
                //          "<td class='tdIntake'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Intake' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add medicine with new intake' ></span></div></td>" +//intake
                //          "<td class='durationNum'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + timestamp + "' style='display:none;font-size:16px'>0</a></td>" +
                //          "<td class='durationWord' ><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + timestamp + "' style='display:none;font-size:16px'>D</a></td>" +
                //           "<td class='tdBeforeAfter'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + timestamp + "' style='display:none;font-size:16px'>A</a></td>" +//after food before food
                //          "<td class='tdDosses' ><input type='text' class='triggerInputDosses form-control'   style='display:none;' placeholder='Dosage'/></td>" + //dosses
                //          "<td class='tdRemark' ><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + timestamp + "' style='display:none;font-size:16px'>Remark</a><input type='hidden' id='hdn" + timestamp + "' /></td>" +
                // "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                //            "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";

                //row += "</tr>";

                //$(row).insertAfter($("#tblMedicineList tr#" + rowId));
                //$("#tblMedicineList tr#NEW" + timestamp + "").trigger("click");

                //$("#tblMedicineList tr#NEW" + timestamp + "").insertAfter($("#tblMedicineList tr#" + rowId));//by vijeta on 12th march19
            });

            //vijeta 1/4/19
            $(document.body).on('click', '#tblMedicineList td span.addMedFrDiffIntk', function (e) {
                var DrugCode = "" + $(this).parents('td').siblings(".tdDrugCode")[0].innerText.trim();
                var rowId = ($(this)[0].closest('tr').id).trim();
                var mediName = $("#tblMedicineList tr#" + rowId + " .MaterialName")[0].firstChild.data;
                var genericId = $("#tblMedicineList tr#" + rowId + " .GenricID")[0].innerText;
                var genericName = $("#tblMedicineList tr#" + rowId + " .GenriName")[0].innerText;
                var SDate = $(this).parents('td').siblings('.tdSDate').find('input')[0].value;
                var row = "";
                var dt = new Date();
                rowNoFrMedTaper = Number(rowNoFrMedTaper) + 1;
                var newCode = rowId + "_" + rowNoFrMedTaper;
                var DruGText = $(this).parents('td').siblings(".tdDrugForm")[0].innerText.trim();
                if (typeof DruGText == "undefined" || typeof genericId == "undefined" || DruGText == "" || genericId == "" ) {
                    $.session.set('ADDButton', "Click");
                } else {
                    $.session.set('ADDButton', "");
                }
                var MaxSeqMedStat;
                if (MaxForMedStat.length > 0) {
                    MaxSeqMedStat = Math.max.apply(Math, MaxForMedStat);

                } else {
                    MaxSeqMedStat = 0;
                }

                MaxForMedStat.push(MaxSeqMedStat + 1);

                var result = {
                   
                    MTRLCODE: newCode,
                    MTRLNAME: mediName,
                    GENERICNAM: genericName,
                    GENERICID: genericId,
                    RESEQ: rowNoFrMedTaper,
                    DRUGFORM: DruGText,
                    DRUGCODE: DrugCode,
                    SDATE: SDate,
                    TYPE: DruGText,
                    RESEQ: MaxSeqMedStat+1
                };
                row = MedicinesRow(result, false, "N");

                $(row).insertAfter($("#tblMedicineList tr#" + rowId));
                $("#tblMedicineList tr#" + newCode + "").trigger("click");

                $("#tblMedicineList tr#" + newCode + "").insertAfter($("#tblMedicineList tr#" + rowId));
                $("#tblMedicineList tr#" + newCode + "" + " input.triggerInputIntake").autocomplete({  //vijeta 5/4/19
                    source: ItakesArray,
                    autoFocus: false,
                    minLength: 0,
                    select: function (event, ui) { //on select added vijeta 8/4/19

                        var txtval = ui.item.value;
                        var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                        var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();//added 15/4/19
                        var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();
                        //   var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();//added 15/4/19
                        var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;

                        var route = $(this).parents('td').siblings('.tdRoute').find('a').text();
                        var remark = $(this).parents('td').siblings('.tdRemark').find('input')[0].value;
                        var Type = $(this).parents('td').siblings('.tdType').find('a').text();
                        var Vol = $(this).parents('td').siblings('.tdVol').find('a').text();
                        var ADur = $(this).parents('td').siblings('.tdADur').find('a').text();
                        var Diltn = $(this).parents('td').siblings('.tdDiltn').find('input')[0].value;
                        var SDate = $(this).parents('td').siblings('.tdSDate').find('input')[0].value;
                        var OrderBy = $(this).parents('td').prevAll('.OrderBy').text();


                        var DrugCode = $(this).parents('td').prevAll('.tdDrugCode').text();
                        var TypeCode = $(this).parents('td').prevAll('.tdTypeCode').text();
                        var OmittedBy = $(this).parents('td').prevAll('.tdOmittedBy').text();
                        var OmittedDate = $(this).parents('td').prevAll('.tdOmittedDate').text();
                        var OmittedTime = $(this).parents('td').prevAll('.tdOmittedTime').text();
                        var OrderedDate = $(this).parents('td').prevAll('.tdOrderedDate').text();
                        var OrderedTime = $(this).parents('td').prevAll('.tdOrderedTime').text();
                        var DrugSequenceNo = $(this).parents('td').prevAll('.tdDrugSequenceNo').text();
                        var HighAlertDrug = $(this).parents('td').prevAll('.tdHighAlertDrug').text();
                        var NotifyYN = $(this).parents('td').prevAll('.tdNotifyYN').text();
                        var Status = $(this).parents('td').prevAll('.tdStatus').text();
                        var ADMINYN = $(this).parents('td').prevAll('.tdADMINYN').text();


                        var tableRow = $("#tblMedicineList tr").filter(function () {
                            return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim() && $(this).find('td.tdRoute a').text().trim() == route.trim() && $(this).find('td.tdVol a').text().trim() == Vol.trim() && $(this).find('td.tdADur a').text().trim() == ADur.trim() && ($(this).find('td.tdDiltn input')[0].value).toUpperCase().trim() == Diltn.toUpperCase().trim() && ($(this).find('td.tdSDate input')[0].value).trim() == SDate.trim() && $(this).find('td.OrderBy').text().trim() == OrderBy.trim()
                            && $(this).find('td.tdDrugCode').text().trim() == DrugCode.trim() && $(this).find('td.tdTypeCode').text().trim() == TypeCode.trim() && $(this).find('td.tdOmittedBy').text().trim() == OmittedBy.trim() && $(this).find('td.tdOmittedDate').text().trim() == OmittedDate.trim() && $(this).find('td.tdOmittedTime').text().trim() == OmittedTime.trim() && $(this).find('td.tdOrderedDate').text().trim() == OrderedDate.trim()
                           && $(this).find('td.tdOrderedTime').text().trim() == OrderedTime.trim() && $(this).find('td.tdDrugSequenceNo').text().trim() == DrugSequenceNo.trim() && $(this).find('td.tdHighAlertDrug').text().trim() == HighAlertDrug.trim() && $(this).find('td.tdNotifyYN').text().trim() == NotifyYN.trim() && $(this).find('td.tdStatus').text().trim() == Status.trim() && $(this).find('td.tdADMINYN').text().trim() == ADMINYN.trim()


                        }).closest("tr");

                        if (tableRow.length > 0) {
                            $.messager.alert('Information', 'This medicine and Frequency already present');
                            $(this).val('');
                            $(this).focus();
                            return false;
                        }
                        else {
                            if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                               
                                $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "0";
                                $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                                // $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                                //$(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                            }
                            else {
                                $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "1";
                                //$(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                                $(this).parents('td').nextAll('td.durationWord').find('a.triggerDays').trigger('click');
                                $(this).parents('td').siblings('td.durationNum,,td.durationWord').find('a').css('pointer-events', 'none');
                            }
                        }

                    }
                }).focus(function () {
                    /* Only search if the autocomplete menu is hidden: */
                    if ($("ul.ui-autocomplete").is(":hidden")) {
                        $(this).autocomplete('search', '');
                    }
                });
                $("#tblMedicineList tr#" + newCode + "" + " input.triggerInputIntake").trigger("focus");//
                $("#tblMedicineList tr#" + newCode + "").find("input.triggerInputIntake").trigger("keydown");
            });
            // register the handler 
            //  document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys



            var options = {
                source: ItakesArray,
                autoFocus: false,
                minLength: 0,
                select: function (event, ui) { //on select added vijeta 8/4/19

                    var txtval = ui.item.value;

                    idOfPopUpAnchor = $(this).parents('td').find('input')[0].id;//vijeta 15/4/19

                    if (ValidateUniqueRow(txtval)) {
                        if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                           
                            $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "0";
                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                            // $(this).parents('td').siblings('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                            //  $(this).parents('td').siblings('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                        }
                        else {
                            $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "1";
                            // $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                            $(this).parents('td').siblings('td.durationWord').find('a.triggerDays').trigger('click');
                            // $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                        }
                    }
                    else {
                        event.preventDefault();
                    }

                },

            };
            $(document).on('keydown.autocomplete ', '.triggerInputIntake', function () {
                $(this).autocomplete(options);
            });

            //vijeta 18th march19
            $('.triggerInputIntake').autocomplete(
               options
            ).focus(function () {
                /* Only search if the autocomplete menu is hidden: */
                if ($("ul.ui-autocomplete").is(":hidden")) {
                    $(this).autocomplete('search', '');
                }
            });
            $(".triggerInputIntake").blur(function () {
                var keyEvent = $.Event("keydown");
                keyEvent.keyCode = $.ui.keyCode.ENTER;
                $(this).trigger(keyEvent);
                var txtval = $(this).val();
            }).autocomplete(options);

            //by vij on 28 nov
            $(document).on('change', '.triggerInputIntake ', function (e) {
                var txtval = $(this).val();

                //by vijeta on 11th march 19
                //var mediName = $(this).parents('td').prev().prev().text();
                var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                var tableRow = $("#tblMedicineList tr").filter(function () {

                    return $(this).find('td.MaterialName').text() == mediName && $(this).find('td.tdIntake input').val() == txtval && $(this).find('td.tdIntake input').val() != "" ;
                }).closest("tr");

                if (tableRow.length > 1) {
                    $.messager.alert('This medicine and intake already present');
                    $(this).val('')
                }
                else {
                    if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD.") {
                       
                        $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "0";
                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                        // $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                    }
                    else {
                        $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "1";
                        // $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                        $(this).parents('td').siblings('td.durationWord').find('a.triggerDays').trigger('focus');
                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                    }
                }



            });
            $(".triggerInputDosses").attr('maxlength', '15');//

            //vijeta 29/03/19
            $(document.body).on("click", "#spanAddNewMedInSetUp", function (e) {
                $.confirm({
                    title: '',
                    closeIcon: true,
                    offsetTop: 10,
                    type: 'orange',
                    backgroundDismissAnimation: 'glow',
                    theme: 'bootstrap',
                    content: '' +
                    '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">New Medicine</label><br>' +
                    '<input  type="varchar" id="txtNewMed"  placeholder="Enter Medicine" autofocus="autofocus" class="setUp form-control" required />' +
                    '</div>' +

                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var medName = $("#txtNewMed").val();
                                var newRow = {
                                    act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                                    CODE: "NEW",
                                    NAME: medName
                                    //INTAKE: '----select----',//commenyed by vijeta on 7th dec 2018
                                    //GENERICID: $(this)[0].parentNode.nextSibling.innerText,
                                    //GENERICNAM: $(this)[0].parentNode.nextSibling.nextSibling.innerText
                                };
                                //$("#tblGrid").jqGrid('addRow', "new");
                                //var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                                //if ($.inArray($(this)[0].defaultValue, ids) == -1)
                                $('#tblGrid').addRowData("NEW", newRow, 'last');

                                $("#dblServiceHelpsrvcgrp").show();
                                $("#divSrvcGrpGrid").show();
                            }
                        },
                        Closed: {
                            text: 'Cancel'
                            //close
                        }
                    }

                });
            });

            //vijeta 11/4/19
            (function ($) {
                $.fn.extend({
                    donetyping: function (callback, timeout) {
                        timeout = timeout || 1e3; // 1 second default timeout
                        var timeoutReference,
                            doneTyping = function (el) {
                                if (!timeoutReference) return;
                                timeoutReference = null;
                                callback.call(el);
                            };
                        return this.each(function (i, el) {
                            var $el = $(el);
                            // Chrome Fix (Use keyup over keypress to detect backspace)
                            // thank you @palerdot
                            $el.is(':input') && $el.on('keyup keypress paste', function (e) {
                                // This catches the backspace button in chrome, but also prevents
                                // the event from triggering too preemptively. Without this line,
                                // using tab/shift+tab will make the focused element fire the callback.
                                if (e.type == 'keyup' && e.keyCode != 8) {

                                    if ($(this).val() != "")//vijeta 3/5/19
                                        return;
                                }

                                // Check if timeout has been set. If it has, "reset" the clock and
                                // start over again.
                                if (timeoutReference) clearTimeout(timeoutReference);
                                timeoutReference = setTimeout(function () {
                                    // if we made it here, our timeout has elapsed. Fire the
                                    // callback
                                    doneTyping(el);
                                }, timeout);
                            }).on('blur', function () {
                                // If we can, fire the event since we're leaving the field
                                doneTyping(el);
                            });
                        });
                    }
                });
            })(jQuery);

            $('#ComplaintInput').donetyping(function () {
                SearchComplaint();
                //  $("#tblMtrlNewSearch").hide();//vijeta 1/7/19
            });

            //vijeta 11/4/19

            $(document.body).on("change blur", ".triggerInputDosses", function () {//2222222222222222222
                idOfPopUpAnchor = $(this)[0].id;

                if (idOfPopUpAnchor.toUpperCase().indexOf("DOSSAGE") != -1)
                    //  $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdRemark').find('a.triggerRemark').trigger('click');//vijeta 20/4/19

                    ValidateUniqueRow();
            });
            //$(document.body).on("change blur", ".triggerVol", function () {
            //    idOfPopUpAnchor = $(this)[0].id;

            //    if (idOfPopUpAnchor.toUpperCase().indexOf("VOL") != -1)
            //        $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdADur').find('a.triggerADur').trigger('click');//vijeta 20/4/19

            //    ValidateUniqueRow();
            //});



            //todayfor = new Date();
            // var dd = todayfor.getDate();
            // var mm = todayfor.getMonth() + 1;
            // var yyyy = todayfor.getFullYear();
            // if (dd < 10) {
            //     dd = '0' + dd
            // }
            // if (mm < 10) {
            //     mm = '0' + mm
            // }
            // todayfor = dd + '/' + mm + '/' + yyyy;
           
          

            //$(".triggerInputSDate").datepicker(
            //            {
            //                showButtonPanel: true,
            //                changeMonth: true,
            //                yearRange: "c-150:c+99",
            //                changeYear: true,
            //                dateFormat: "dd/mm/yy",
            //                maxDate: new Date(),
            //               // minDate: admissiondate
            //            });
            //$(".triggerInputSDate").val(todayfor);
            //$("table").find("tr").each(function () {
            //    $(this).find("td .triggerInputSDate").datepicker({
            //        showButtonPanel: true,
            //        changeMonth: true,
            //        yearRange: "c-150:c+99",
            //        changeYear: true,
            //        dateFormat: "dd/mm/yy",
            //        maxDate: new Date(),
            //        // minDate: admissiondate
            //    });
            //});
            //.............................
            //$('.checkboxomit').click(function () {
            //    if ($(this).is(':checked')) {
                   
            //        $(this).parent().parent().removeClass("active")
            //        $(this).parent().parent().addClass("Omited");
            //        $(this).parents('td').siblings('td.tdOmittedBy')[0].innerText = userid;
            //        $(this).parents('td').siblings('td.tdOmittedDate')[0].innerText = GetTodaysDate();
            //        $(this).parents('td').siblings('td.tdOmittedTime')[0].innerText = GetTimewithAMPM();
            //      //  $(this).parents('td').siblings('td.durationNum')[0].innerText = "";
            //    }
            //    else {
            //        $(this).parent().parent().removeClass("Omited");
            //        $(this).parent().parent().addClass("active");
            //        $(this).parents('td').siblings('td.tdOmittedBy')[0].innerText = "";
            //        $(this).parents('td').siblings('td.tdOmittedDate')[0].innerText = "";
            //        $(this).parents('td').siblings('td.tdOmittedTime')[0].innerText = "";
            //    }
            //});

            //.................................

            GetTreat();
            // AddMedicines();
            //SetGridDataInvestigation(resultofal);
            //SetGridDataMedicine(resultofal)
            load_MedicineType();
            RxNewSetData(resultofal);
          

            $(document.body).on("keydown", ".triggerInputIntake", function (e) {
                if (e.shiftKey || e.ctrlKey || e.altKey) {
                    e.preventDefault();
                } else {
                    var key = e.keyCode;
                    //if (keyCodeEntered == 45) {
                    // Allow only 1 minus sign ('-')...
                    //if ((elementRef.value) && (elementRef.value.indexOf('-') >= 0))
                    //    return false;
                    //else
                    //    return true;
                    if (typeof key != "undefined") {
                        if ((key >= 48 && key <= 90) || (key >= 96 && key <= 105) || key == 109 || key == 189 || key == 8 || key == 110 || key == 190 || key == 191 || key == 111) {

                            return true;
                        }
                        else {

                            //$.alert("Enter Proper Format. eg: 1-1-1");
                            return false
                        }
                    }
                    //  }

                }

            });

            $('#tblMedicineList > tbody > tr > td.tdOmit').find("input.triggerInputOmit").change(function () {
            ///$(".triggerInputOmit").change(function () {
                //if (this.checked) {
                //    $(this).parents('td').siblings('td.tdOmittedBy')[0].innerText = "";
                //    $(this).parents('td').siblings('td.tdOmittedDate')[0].innerText = "";
                //    $(this).parents('td').siblings('td.tdOmittedTime')[0].innerText = "";
                //    $(this).parents('td').siblings('td.durationNum')[0].innerText = "";
                //} else {

                //}


                if (this.checked) {

                    $(this).parent().parent().removeClass("active");
                    $(this).parent().parent().removeClass("planclass");
                    $(this).parent().parent().addClass("Omited");
                    //var pid = $(this).parent().parent()[0].id.toString().trim();
                    if ($(this).parents('td').siblings('td.tdPlannedYN')[0].innerText == "Y") {
                        $(this).parent().parent().removeClass("Omited");
                        $(this).parent().parent().addClass("plannedAndOmitted");
                        $(this).parents('td.tdOmit').find('span').show();
                    } 
                    $(this).parents('td.tdOmit').find('span').hide();
                    // element.find("span").remove();
                    //   $(this).parents('td.tdOmit')[0].innerHTML = "<input type='checkbox'  style=''  id='Omit" + pid + "' value='N' class='triggerInputOmit checkboxomit' />"
                    // $(this).parents('td').siblings('td.tdOmittedBy')[0].innerText
                    $(this).parents('td').siblings('td.tdOmitYN')[0].innerText = "Y";
                    $(this).parents('td').siblings('td.tdOmittedBy')[0].innerText = userid;
                    $(this).parents('td').siblings('td.tdOmittedDate')[0].innerText  = GetTodaysDate();
                    $(this).parents('td').siblings('td.tdOmittedTime')[0].innerText = GetTimewithAMPM();
                    //  $(this).parents('td').siblings('td.durationNum')[0].innerText = "";
                }
                else {
                    if ($(this).parents('td').siblings('td.tdADMINYN')[0].innerText != "Y") {

                        $(this).parents('td.tdOmit').find('span').show();
                    }
                    
                    $(this).parent().parent().removeClass("plannedAndOmitted");
                    $(this).parent().parent().removeClass("Omited");
                    $(this).parent().parent().addClass("active");

                    if ($(this).parents('td').siblings('td.tdPlannedYN')[0].innerText == "Y") {

                        $(this).parent().parent().removeClass("active");
                        $(this).parent().parent().addClass("planclass");

                    }
                    $(this).parents('td').siblings('td.tdOmitYN')[0].innerText = "N";
                    $(this).parents('td').siblings('td.tdOmittedBy')[0].innerText = "";
                    $(this).parents('td').siblings('td.tdOmittedDate')[0].innerText = "";
                    $(this).parents('td').siblings('td.tdOmittedTime')[0].innerText = "";
                }
            });



            //$('#tblMedicineList > tbody > tr > td.tdDiltn').find("input.triggerInputDiltn").keyup(function () {
            //    alert("fdfdf");
            //});
        });
        function CancellFun(newval) {
            $(newval).parent().parent().removeClass("active");
            $(newval).parent().parent().removeClass("Omited");
            $(newval).parent().parent().removeClass("planclass");
            $(newval).parent().parent().removeClass("plannedAndOmitted");
            $(newval).parent().parent().addClass("Canceled");

           

            $(newval).parents('td').siblings('td.tdStatus')[0].innerText = "C";
            $(newval).parents('td').siblings('td.tdOmittedBy')[0].innerText = userid;
            $(newval).parents('td').siblings('td.tdOmittedDate')[0].innerText = GetTodaysDate();
            $(newval).parents('td').siblings('td.tdOmittedTime')[0].innerText = GetTimewithAMPM();
            //  $(newval).parent().parent().prop("disabled", true);

            $("tr.Canceled input, tr.Canceled select, tr.Canceled textarea, tr.Canceled a, tr.Canceled span, tr.Canceled div").prop('disabled', true);
           // $(newval).parents('td').siblings('td.tdOmit')[0].innerText = "";
            $(newval).parents('td.tdOmit')[0].innerHTML = "";

           
        }
        //vijeta 15/4/19
        function load_MedicineType() {
            var s;
            var MediciTypeLst
            //MediciTypeLStr
            $.ajax({
                url: '../ICUMob/GetMedicineType',
                data: {},
                type: 'get',
                async: false,
                success: function (Response) {
                    MediciTypeLst = Response;
                    s = " : ;"; $.each(MediciTypeLst, function () {
                        s += this.Value + ":" + this.Text + ";";
                    });
                    s = s.substring(0, s.length - 2);
                }
            });
            MediciTypeLStr = s;
            return s;
        }
        function ValidateUniqueRow(txtval) {
            var intakeVal = "";

            if (txtval != undefined)
                intakeVal = txtval
            else
                intakeVal = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdIntake')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdIntake').find('input')[0].value

            var mediName = $("#" + idOfPopUpAnchor).parents('td').prevAll('.MaterialName').text();
            var durationNum = ($("#" + idOfPopUpAnchor).parents('td').hasClass('durationNum')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.durationNum').find('a').text();
            var durationWord = ($("#" + idOfPopUpAnchor).parents('td').hasClass('durationWord')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.durationWord').find('a').text();
          //  var food = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdBeforeAfter')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdBeforeAfter').find('a').text();
            var dossage = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdDosses')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdDosses').find('input')[0].value;
            var route = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdRoute')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdRoute').find('a').text();//kavita 08-aug-2019
            var remark = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdRemark')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdRemark').find('input')[0].value;
            var Vol = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdVol')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdVol').find('a').text();
            var ADur = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdADur')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdADur').find('a').text();
            var Type = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdType')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdType').find('a').text();


            var Diltn = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdDiltn')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdDiltn').find('input')[0].value;
            var SDate = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdSDate')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdSDate').find('input')[0].value;
            var OrderBy = $("#" + idOfPopUpAnchor).parents('td').prevAll('.OrderBy').text();


            var DrugCode = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdDrugCode').text();
            var TypeCode = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdTypeCode').text();
            var OmittedBy = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdOmittedBy').text();
            var OmittedDate = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdOmittedDate').text();
            var OmittedTime = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdOmittedTime').text();
            var OrderedDate = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdOrderedDate').text();
            var OrderedTime = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdOrderedTime').text();
            var DrugSequenceNo = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdDrugSequenceNo').text();
            var HighAlertDrug = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdHighAlertDrug').text();
            var NotifyYN = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdNotifyYN').text();
            var Status = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdStatus').text();
            var ADMINYN = $("#" + idOfPopUpAnchor).parents('td').prevAll('.tdADMINYN').text();

            var tableRow = $("#tblMedicineList tr").filter(function () {
                return $(this).find('td.MaterialName').text() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (intakeVal).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim() && $(this).find('td.tdRoute a').text().trim() == route.trim() && $(this).find('td.tdVol a').text().trim() == Vol.trim() && $(this).find('td.tdDil a').text().trim() == Vol.trim() && $(this).find('td.OrderBy').text() == OrderBy.trim()
                && $(this).find('td.tdDrugCode').text().trim() == DrugCode.trim() && $(this).find('td.tdTypeCode').text().trim() == TypeCode.trim() && $(this).find('td.tdOmittedBy').text().trim() == OmittedBy.trim() && $(this).find('td.tdOmittedDate').text().trim() == OmittedDate.trim() && $(this).find('td.tdOmittedTime').text().trim() == OmittedTime.trim() && $(this).find('td.tdOrderedDate').text().trim() == OrderedDate.trim()
                          && $(this).find('td.tdOrderedTime').text().trim() == OrderedTime.trim() && $(this).find('td.tdDrugSequenceNo').text().trim() == DrugSequenceNo.trim() && $(this).find('td.tdHighAlertDrug').text().trim() == HighAlertDrug.trim() && $(this).find('td.tdNotifyYN').text().trim() == NotifyYN.trim() && $(this).find('td.tdStatus').text().trim() == Status.trim() && $(this).find('td.tdADMINYN').text().trim() == ADMINYN.trim()

            }).closest("tr");

            if ((tableRow.length > 1 && txtval == undefined) || (tableRow.length > 0 && txtval != undefined)) {
                $.messager.alert('Information', 'This medicine and intake already present');
                ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdIntake')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value = "" : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdIntake').find('input')[0].value = "";
                return false;
            }

            return true;
        }
        function SaveAllMedicines(strPlusButton) {

            var mrno = ($.session.get('ICUPatMRNO')).toString();
            var tranNo = ($.session.get('ICUPatIPNO')).toString();
            var medicineArr = [];

            var rows = [];
           

            for (i = 0; i < $('#tblMedicineList > tbody > tr.Omited').get().length; i++) rows.push($('#tblMedicineList > tbody > tr.Omited').get()[i]);
            for (i = 0; i < $('#tblMedicineList > tbody > tr.Canceled').get().length; i++) rows.push($('#tblMedicineList > tbody > tr.Canceled').get()[i])
            for (i = 0; i < $('#tblMedicineList > tbody > tr.planclass').get().length; i++) rows.push($('#tblMedicineList > tbody > tr.planclass').get()[i])
            for (i = 0; i < $('#tblMedicineList > tbody > tr.plannedAndOmitted').get().length; i++) rows.push($('#tblMedicineList > tbody > tr.plannedAndOmitted').get()[i])
            for (i = 0; i < $('#tblMedicineList > tbody > tr.active').get().length; i++) rows.push($('#tblMedicineList > tbody > tr.active').get()[i])
            
            for (var i = 0; i < rows.length; i++) {
                // var code = rows[i].id //commented vijeta 6/5/19
                var code = $(rows[i]).children('td.tdDrugCode')[0].innerText.trim();//vijeta 4/5/19
                var medGenName = $(rows[i]).children('td.MaterialName')[0].firstChild.textContent;
                var MedicineName = medGenName.substr(0, medGenName.lastIndexOf("(")).trim();//$(rows[i]).children('td.MaterialName')[0].firstChild.textContent;//$(rows[i]).children('td.MaterialName')[0].innerText;
                if (typeof MedicineName == "undefined" || MedicineName == "")
                    MedicineName = medGenName;
                var Intake = $(rows[i]).children('td.tdIntake').find('input.triggerInputIntake')[0].value.replace(/-{2,}/g, '-');//
                //var Intake = $(rows[i]).children('td.tdIntake').find('input.triggerInputIntake')[0].value; //rows[i].cells[3].firstElementChild.firstElementChild.value
                var Duration = $(rows[i]).children('td.durationWord')[0].innerText;// rows[i].cells[4].innerText;
                var Days = $(rows[i]).children('td.durationNum')[0].innerText; //rows[i].cells[5].innerText;
               // var Food = $(rows[i]).children('td.tdBeforeAfter')[0].innerText; //rows[i].cells[6].innerText;
                var Dosses = $(rows[i]).children('td.tdDosses').find('input.triggerInputDosses')[0].value; // rows[i].cells[7].firstElementChild.value;
                var Route = $(rows[i]).children('td.tdRoute').find('a').text(); //kavita 08-aug-2019
               
                var Remark = $(rows[i]).children('td.tdRemark').children('input')[0].value; //rows[i].cells[8].children[1].value;
                var Vol = $(rows[i]).children('td.tdVol').children('input')[0].value;
                var setupyn = $(rows[i]).children('td.setupyn')[0].innerText; //added on 1/7/19
                var refillyn = $(rows[i]).children('td.refillyn')[0].innerText; //added on 1/7/19
                var drugForm = $(rows[i]).children('td.tdDrugForm')[0].innerText;
                var ADur = $(rows[i]).children('td.tdADur').children('input')[0].value;
                var Diltn = $(rows[i]).children('td.tdDiltn').find('input.triggerInputDiltn')[0].value;
                var SDate = $(rows[i]).children('td.tdSDate').find('input.triggerInputSDate')[0].value;

                //var Type = $(rows[i]).children('td.tdType').children('input.triggerType')[0].value;

                var Type = $(rows[i]).children('td.tdType')[0].textContent;  //vishal
               // var OrderBy = $(rows[i]).children('td.OrderBy')[0].firstChild.textContent;
                var OrderBy = userid;
                //var OrderBy = LoginUser;
                var OrderedDate = GetTodaysDate();
                var OrderedTime = GetTimewithAMPM();
                var DrugCode = $(rows[i]).children('td.tdDrugCode')[0].firstChild.textContent;
               
                var TypeCode = $(rows[i]).children('td.tdtableType')[0].innerText; // $(rows[i]).children('td.tdTypeCode')[0].firstChild.textContent;
                var OmittedBy = $(rows[i]).children('td.tdOmittedBy')[0].innerText;//$(rows[i]).children('td.tdOmittedBy')[0].firstChild.textContent;
                var OmittedDate = $(rows[i]).children('td.tdOmittedDate')[0].innerText;//$(rows[i]).children('td.tdOmittedDate')[0].firstChild.textContent;
                var OmittedTime = $(rows[i]).children('td.tdOmittedTime')[0].innerText;//$(rows[i]).children('td.tdOmittedTime')[0].firstChild.textContent;
               // var OrderedDate = $(rows[i]).children('td.tdOrderedDate')[0].innerText; //$(rows[i]).children('td.tdOrderedDate')[0].firstChild.textContent;
                //var OrderedTime = $(rows[i]).children('td.tdOrderedTime')[0].innerText;//$(rows[i]).children('td.tdOrderedTime')[0].firstChild.textContent;
                var DrugSequenceNo = $(rows[i]).children('td.tdDrugSequenceNo')[0].innerText;//$(rows[i]).children('td.tdDrugSequenceNo')[0].firstChild.textContent;
                var HighAlertDrug = $(rows[i]).children('td.tdHighAlertDrug')[0].innerText;// $(rows[i]).children('td.tdHighAlertDrug')[0].firstChild.textContent;
                var NotifyYN = $(rows[i]).children('td.tdNotifyYN')[0].innerText;//$(rows[i]).children('td.tdNotifyYN')[0].firstChild.textContent;
                var Status = $(rows[i]).children('td.tdStatus')[0].innerText;//$(rows[i]).children('td.tdStatus')[0].firstChild.textContent;
                var ADMINYN = $(rows[i]).children('td.tdADMINYN')[0].innerText;//$(rows[i]).children('td.tdADMINYN')[0].firstChild.textContent;

                var OmitYn = $(rows[i]).children('td.tdOmitYN')[0].innerText;

                var fd = "";
                //Added by Tejashri on 24/12/2018
                //if (Food.substring(0, 1) == "B")
                //    fd = "E";
                //else if (Food.substring(0, 1) == "A")
                //    fd = "A";
                //else if (Food.substring(0, 1) == "-")
                //    fd = "-";
                //End


             
                
                var a = {
                    DayOfDrug: Days,
                    Duration: Duration,
                    Type: Type,

                    DrugName: medGenName,
                   
                    Dose: Dosses,
                   
                    Route: Route,  //kavita 08-aug-2019
                   
                    Freq: Intake.toUpperCase(),
                    Remark: Remark,
                    INFRATE: "",
                    Diluent: Diltn,
                   // MACROSET:"",
                   // MICROSET: "",

                    DilutionVolume: Vol,
                    AdminstrDuration: ADur,
                  
                    DGSTARTDATE: SDate,
                   


                   
                    Omit: OmitYn,
                    DrugCode: code,
                    TypeCode: TypeCode,
                    OmittedBy: OmittedBy,
                    OmittedDate: OmittedDate,
                    OmittedTime: OmittedTime,
                    OrderedBy: OrderBy,
                    OrderedDate:OrderedDate,
                    OrderedTime: OrderedTime,
                    SQNumber: DrugSequenceNo,
                    HighAlert: "",
                    NOTIFYN: NotifyYN,
                    STATUS: Status,
                    ADMINYN: ADMINYN,
                    MEDSTAT: $('#tabMenuUl1').children('li.active')[0].id == "IPStatOrders" ? "S" : "M",
                   

                   // GENERICID: $(rows[i]).children('td.GenricID')[0].innerText,//vijeta 17/4/19
                   // GENERICNAME: $(rows[i]).children('td.GenriName')[0].innerText, // rows[i].cells[1].innerText,
                   
                    //INTAKECD: '',
                
                    TAMPERING: rows[i].id.trim().includes("_") ? "Y" : "N",
                   
                    
                };
                medicineArr.push(a);
            }

            var strMsg = "";
            var flag = true;
            $.each(medicineArr, function () {

                var intake = $(this)[0].Freq.toUpperCase();

                if ($(this)[0].Freq == "") {
                    flag = false;
                    strMsg = "Please select frequency for all medicines";
                }
                    //kavita 13-aug-2019
                else if ($(this)[0].Route == "" || $(this)[0].Route == "Route") {
                    flag = false;
                    strMsg = "Please select Route for all medicines";
                }
                else if ($(this)[0].Dose == "") {
                    flag = false;
                    strMsg = "Please select Dossage for all medicines";
                }
                    //else if ($(this)[0].DAYS == "0" && ($(this)[0].INTAKEDESC != "SOS" && $(this)[0].INTAKEDESC != "STAT" && $(this)[0].INTAKEDESC != "CONTD.")) {
                else if ($(this)[0].DayOfDrug == "0"){ //&& (intake != "SOS" && intake != "STAT" && intake != "CONTD." && intake != "CONTD" && intake != "CONT." && intake != "CONT")) {
                    flag = false;
                    strMsg = "Please select duration of selected medicine";
                }
                //else if ($(this)[0].DilutionVolume == "") {

                //    if ($('#tabMenuUl1').children('li.active')[0].id == "IPStatOrders") {

                //        flag = false;
                //        strMsg = "Please select Diluent Volume of selected medicine";
                //    }
                //}
                //else if ($(this)[0].AdminstrDuration == "") { //&& (intake != "SOS" && intake != "STAT" && intake != "CONTD." && intake != "CONTD" && intake != "CONT." && intake != "CONT")) {

                //    if ($('#tabMenuUl1').children('li.active')[0].id == "IPStatOrders") {
                //        flag = false;
                //        strMsg = "Please select Admin. Duration of selected medicine";
                //    }
                //}


            });
            HoldOn.open();
            if ($('#tractiondropdown').val() != "" && $('#tractiondropdown').val() != null) {
                gact= "E";
            }else
                gact= "N";
            IpNo = '' + $.session.get('ICUPatIPNO');
            MrNo = '' + $.session.get('ICUPatMRNO');
            PatName = '' + $.session.get('ICUPatName');

      


            var statMed = ($('#tabMenuUl1').children('li.active')[0].id == "IPStatOrders") ? "S" : "M";
            if (flag) {
                $.ajax({
                    url: '../ICUMob/SaveTreatmentIPMedication',
                    type: 'POST',
                    datatype: 'json',
                    data: { action: gact, tableMedicationData: JSON.stringify(medicineArr), TranctionId: $('#tractiondropdown').val(), IpNo: IpNo, MrNo: MrNo, PatName: PatName, Prov: "prov", Allergy: "allrgy", statMed: statMed },
                    success: function (response) {
                       
                        if (response.indexOf('Successful') >= 0) {
                            var splitval = response.toString().split('.');
                            if (splitval.length == 2) {
                                var TranNum = splitval[1].toString().trim();
                                if (TranNum.length > 0) {
                                    TranNo = TranNum;
                                    gact = 'E';
                                    IsrolloverData = 'N';
                                    $('#btnSave').val('Update');
                                    // $('#lblModeIndicator').text("Update");
                                    // $('#getloginInfo').removeClass('hide');
                                    // $('#btnPrint').show().removeClass('hide');
                                    $('#tractiondropdown').empty();
                                    $('#tractiondropdown').val(TranNum);

                                }
                            }
                            //var CurrTab = localStorage.getItem('CurrentTabIndex');
                            //if (Number(CurrTab) != 6) {
                            //    SetValidateTabIndex(Number(CurrTab) + 1);
                            //    tabseq = Number((tabseq) + 1);
                            //}
                            GetTreat();
                            
                            RxNewSetData(resultofal);
                            if (!resultofal.hasOwnProperty("jsonMedicineData") || resultofal.jsonDetailsData[0].VITALSIGNS.toString().trim() == "" || resultofal.jsonDetailsData[0].HGT.toString().trim() == "" || resultofal.jsonDetailsData[0].OXYGENADMIN.toString().trim() == "") {

                                window.location.href = '../ICUMob/NonDrugOrder';
                            }else if (strPlusButton != "Y")
                                MsgDia(response, "Information");
                        } else {
                           // MsgDia(response, "Information");
                            MsgDia(response, "Error");
                            return false;
                        }
                      

                    },
                    complete: function () { HoldOn.close(); },//
                    error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
                });
                return true;//added on 30th nov 2018
            }
            else {
                $.alert(strMsg);
                HoldOn.close();
                return false;//added on 30th nov 2018
            }

        }
        function BindIntakeCombination() {
            $.ajax({
                type: "get",
                datatype: "json",
                url: '../DoctorDesk/GetMedicineInTake',
                success: function (response) {
                    if (response != "Unsucessfull") {
                        IntakeREsult = JSON.parse(response);
                        for (i = 0; i < IntakeREsult.Intake.length; i++) {
                            ItakesArray.push(IntakeREsult.Intake[i].INTAKE);
                        }
                    }
                }
            });
        }

        function SetText(str) {
            $("#" + idOfPopUpAnchor).text(str);

            if (idOfPopUpAnchor.toUpperCase().indexOf("INTAKE") != -1)
              //  $("#" + idOfPopUpAnchor).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');//vijeta 19/4/19
           // else if (idOfPopUpAnchor.toUpperCase().indexOf("NUM") != -1)
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.durationWord').find('a.triggerDays').trigger('click');//vijeta 19/4/19
            //else if (idOfPopUpAnchor.toUpperCase().indexOf("DAY") != -1) {
                //if ($("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdType').find('a.triggerType').text() == "Type" ||typeof $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdType').find('a.triggerType').text() == undefined)
                    //$("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdType').find('a.triggerType').trigger('click');//vijeta 19/4/19
                
           // }
            else if (idOfPopUpAnchor.toUpperCase().indexOf("DAY") != -1) {

               if( $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdRoute').find('a.triggerRoute')[0].innerText.toString().trim() == "Route")
                
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdRoute').find('a.triggerRoute').trigger('click')  //kavita 13-aug-2019
            }

            ValidateUniqueRow();//vijeta 15/4/19
        }

        function SetRemarkText(str, code) {

            $("#" + idOfPopUpAnchor).text(str);
            $("#" + idOfPopUpAnchor).siblings("input")[0].value = code;
            if (idOfPopUpAnchor.toUpperCase().indexOf("REMARK") != -1)//kavita 13-aug-2019
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdDiltn').find('input').trigger('focus');//kavita 13-aug-2019
            ValidateUniqueRow();//vijeta 15/4/19
        }
        function SetRouteText(str, code) {
            $("#" + idOfPopUpAnchor).text(str);
            $("#" + idOfPopUpAnchor).siblings("input")[0].value = str.replace(/[^0-9a-zA-Z]/gi, '');
            if (idOfPopUpAnchor.toUpperCase().indexOf("ROUTE") != -1)//kavita 13-aug-2019
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdDosses').find('input').trigger('focus');//kavita 13-aug-2019



            ValidateUniqueRow();//kavita 08-aug-2019
        }
        function SetVolText(str, code) {

            $("#" + idOfPopUpAnchor).text(str);
            $("#" + idOfPopUpAnchor).siblings("input")[0].value = code;

            //if (idOfPopUpAnchor.toUpperCase().indexOf("VOL") != -1)
            //    $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdADur').find('input').trigger('focus');

            if (idOfPopUpAnchor.toUpperCase().indexOf("VOL") != -1)
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdADur').find('a.triggerADur').trigger('click');//vijeta 19/4/19
            ValidateUniqueRow();//vijeta 15/4/19
        }
        function SetADurText(str, code) {
            todayfor = new Date();
            var dd = todayfor.getDate();
            var mm = todayfor.getMonth() + 1;
            var yyyy = todayfor.getFullYear();
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }
            todayfor = dd + '/' + mm + '/' + yyyy;


            //$("#tblMedicineList").find("tr").each(function () {
            //    $(this).find("td.tdSDate input").datepicker();
            //});

            $(".triggerInputSDate").datepicker(
                       {
                           showButtonPanel: true,
                           changeMonth: true,
                           yearRange: "c-150:c+99",
                           changeYear: true,
                           dateFormat: "dd/mm/yy",
                           maxDate: new Date(),
                           // minDate: admissiondate
                       });
            $(".triggerInputSDate").val(todayfor);



            $("#" + idOfPopUpAnchor).text(str);
            $("#" + idOfPopUpAnchor).siblings("input")[0].value = code;
            if (idOfPopUpAnchor.toUpperCase().indexOf("ADUR") != -1)//kavita 13-aug-2019
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdSDate').find('input.triggerInputSDate').datepicker('show');
                //$("#" + idOfPopUpAnchor).parents('td').nextSibling('td.tdSDate').find('input.triggerInputSDate').datepicker('show');
            ValidateUniqueRow();//vijeta 15/4/19
        }
        function SetTypeText(str, code) {

            $("#" + idOfPopUpAnchor).text(str);
            $("#" + idOfPopUpAnchor).siblings("input")[0].value = code;

            //if (idOfPopUpAnchor.toUpperCase().indexOf("VOL") != -1)
            //    $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdADur').find('input').trigger('focus');

            if (idOfPopUpAnchor.toUpperCase().indexOf("TYPE") != -1)
               // $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdRoute').find('a.triggerRoute').trigger('click')  //kavita 13-aug-2019
            ValidateUniqueRow();//vijeta 15/4/19
        }
        function LoadAllpopUps() {
            //duration 1 to 30
            for (var i = 0; i <= 130; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' id='NumDaysSc' style='font-size:14px'>" + i + "</a>";
                $("#layer-durationNum").append(s);
            }
            for (var i = 0; i <= 130; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' id='NumDaysSc' style='font-size:14px'>" + i + "</a>";
                $("#layer-durationWords").append(s);
            }
            GetDurationVolList();
            GetADurList();
           GetRemarkList();
           GetRouteList();
           GetTypeList();
        }




        function intakeDiv(obj) {
            var DurgIntakeCode = $(obj).attr('id')
            $('.Next').css("visibility", "visible");
            var label;
            $('.shadow').removeClass("shadow");
            $(obj).find('label').addClass("shadow")
        }

        function showInputDiv() {
            // $('.Intakeinputs').css('visibility','visible')
        }

       <%-- function AddMedicines() {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetFregqentMaterialCIMS","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {
                    if (response.toString().toUpperCase() != "UNSUCESSFULL") {
                        var result = JSON.parse(response)
                        var rows = "";
                        $('#tblMedicineList tbody').empty();
                        for (i = 0; i < result.Table.length; i++) {

                            rows = MedicinesRow(result.Table[i], true);
                            $('#tblMedicineList tbody').append(rows);
                        }
                    }



                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                },

                complete: function () {
                    //GetRemarkList();
                    GetSavedData();
                },
            });
        }--%>


        function GetRemarkList() {
            var response = JSON.parse(RemarkArray.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
            var staticOther = "<div><input type='text' id='searchRemark' onkeyup='searchRemark()' style='width: 80%;height: 27px;' placeholder='Search...'/><span class='fa fa-plus fa-2x' onclick='OtherRemarkClicked()'  id='divOther' title='Add new Remark' style=' position: absolute; width: 39px; height: 27px;text-align: center; background: #4086bf;border-radius: 0px 5px 5px 0px;color: #f9f9f9;'></span><div>";

            $("#layer-Remark").append(staticOther);
            for (var i = 0; i < response.length; i++) {
                var s = "<a href='javascript:;' id='" + response[i].Value + "' class='anchorRemark' style='font-weight:500;font-size:14px;border-bottom:1px solid #cecece;'>" + response[i].Text + "</a>";
                $("#layer-Remark").append(s);
            }
        }
            function GetTypeList() {
                var s;
                var MediciTypeLst;
                
                $.ajax({
                    url: '../ICUMob/GetMedicineType',
                    data: {},
                    type: 'get',
                    async: false,
                    success: function (Response) {
                        MediciTypeLst = Response;
                //        s = " : ;"; $.each(MediciTypeLst, function () {
                //            s += this.Value + ":" + this.Text + ";";
                //        });
                //        s = s.substring(0, s.length - 2);
                //    }
                //});
                //MediciTypeLStr = s;


                //DiluVolumelst = Response;

                var staticOther = "<div><input type='text' id='searchType' onkeyup='searchType()' style='width: 95%;height: 27px;' placeholder='Search...'/><div>";
                $("#layer-Type").append(staticOther);

                var s = " : ;"; $.each(MediciTypeLst, function () {
                    // s += this.Value + ":" + this.Text + ";";


                    s = "<a href='javascript:;' id='" + this.Value + "' class='anchorType' style='font-weight:500;font-size:14px;border-bottom:1px solid #cecece;'>" + this.Text + "</a>";
                    $("#layer-Type").append(s);
                });
                s = s.substring(0, s.length - 1);

                    }
                    });


                return s;
        }

        function searchRemark() {
            // Declare variables
            var input, filter, div, a, i;
            input = document.getElementById("searchRemark");
            filter = input.value.toUpperCase();
            div = document.getElementById("layer-Remark");
            a = div.getElementsByTagName("a");

            // Loop through all list items, and hide those who don't match the search query
            for (i = 0; i < a.length; i++) {
                // a =a[i];
                if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }
        function searchType() {
            // Declare variables
            var input, filter, div, a, i;
            input = document.getElementById("searchType");
            filter = input.value.toUpperCase();
            div = document.getElementById("layer-Type");
            a = div.getElementsByTagName("a");

            // Loop through all list items, and hide those who don't match the search query
            for (i = 0; i < a.length; i++) {
                // a =a[i];
                if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }
        function GetRouteList() {
            var response = JSON.parse(MedRoute.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
            var staticOther = "<div><input type='text' id='searchRoute' onkeyup='searchRoute()' style='width: 95%;height: 27px;' placeholder='Search...'/><div>";
            $("#layer-Route").append(staticOther);
            for (var i = 0; i < response.length; i++) {
                var s = "<a href='javascript:;' id='" + response[i].Text.replace(/[^0-9a-zA-Z]/gi, '') + "' class='anchorRoute' style='font-weight:500;font-size:14px;border-bottom:1px solid #cecece;'>" + response[i].Text + "</a>";
                $("#layer-Route").append(s);
            }

          
        }
        function GetDurationVolList() {
            var s;
            var DiluVolumeTypelst
            var DiluVolumelst
            $.ajax({
                url: '../ICUMob/GetDilutionVolumList',
                data: {},
                type: 'get',
                async: false,
                success: function (Response) {
                    DiluVolumelst = Response;

                    var staticOther = "<div><input type='text' id='searchVol' onkeyup='searchVol()' style='width: 95%;height: 27px;' placeholder='Search...'/><div>";
                    $("#layer-Vol").append(staticOther);

                   var s = " : ;"; $.each(DiluVolumelst, function () {
                       // s += this.Value + ":" + this.Text + ";";


                       s = "<a href='javascript:;' id='" + (this.Value).replace(/[^0-9a-zA-Z]/gi, '') + "' class='anchorVol' style='font-weight:500;font-size:14px;border-bottom:1px solid #cecece;'>" + this.Text + "</a>";
                        $("#layer-Vol").append(s);
                    });
                    s = s.substring(0, s.length - 1);


                    //.......................
                  
                    //for (var i = 0; i < DiluVolumelst.length; i++) {
                       
                    //}
                    //.....................
                }
            });
            return s;
        }
        function GetADurList() {
            var s;
            var DiluVolumeTypelst
            var DiluVolumelst
            $.ajax({
                url: '../ICUMob/GetAdminiStrDur',
                data: {},
                type: 'get',
                async: false,
                success: function (Response) {
                    Durlst = Response;

                    var staticOther = "<div><input type='text' id='searchADur' onkeyup='searchADur()' style='width: 95%;height: 27px;' placeholder='Search...'/><div>";
                    $("#layer-ADur").append(staticOther);

                    var s = " : ;"; $.each(Durlst, function () {
                        // s += this.Value + ":" + this.Text + ";";


                        s = "<a href='javascript:;' id='" + (this.Value).replace(/[^0-9a-zA-Z]/gi, '') + "' class='anchorADur' style='font-weight:500;font-size:14px;border-bottom:1px solid #cecece;'>" + this.Text + "</a>";
                        $("#layer-ADur").append(s);//newchanges
                    });
                    s = s.substring(0, s.length - 1);
                }
            });
            return s;
        }
        function searchRoute() {
            // Declare variables
            var input, filter, div, a, i;
            input = document.getElementById("searchRoute");
            filter = input.value.toUpperCase();
            div = document.getElementById("layer-Route");
            a = div.getElementsByTagName("a");

            // Loop through all list items, and hide those who don't match the search query
            for (i = 0; i < a.length; i++) {
                // a =a[i];
                if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }
        function searchVol() {
            // Declare variables
            var input, filter, div, a, i;
            input = document.getElementById("searchVol");
            filter = input.value.toUpperCase();
            div = document.getElementById("layer-Vol");
            a = div.getElementsByTagName("a");

            // Loop through all list items, and hide those who don't match the search query
            for (i = 0; i < a.length; i++) {
                // a =a[i];
                if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }
        function searchADur() {
            // Declare variables
            var input, filter, div, a, i;
            input = document.getElementById("searchADur");
            filter = input.value.toUpperCase();
            div = document.getElementById("layer-ADur");
            a = div.getElementsByTagName("a");

            // Loop through all list items, and hide those who don't match the search query
            for (i = 0; i < a.length; i++) {
                // a =a[i];
                if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }

        function OtherRemarkClicked() {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group"><textarea rows="4" cols="50" maxlength="500"  id="txtRemark"   placeholder="Remark" autofocus="autofocus" class="complaint form-control" required></textarea>' //kavita
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
                                    url: '../DoctorDesk/saveIntakeRemark',
                                    data: { strNewRemark: NewRemark, },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {

                                            var strCode = "" + response.toString();
                                            strCode = strCode.substring(strCode.length - 3, strCode.length);

                                            //$.alert("Record Inserted Successfully", "Information");
                                            var s = "<a href='javascript:;' id='" + strCode + "' class='anchorRemark' style='font-weight:500;font-size:14px'>" + NewRemark + "</a>";
                                            $(s).insertBefore("#divOther");
                                            //setTimeout(function () { $("#" + strCode).click() }, 500);
                                            $("#layer-Remark a#" + strCode + "").trigger("click");
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
        }

        function AddMedicineRemark(object, e) {
            e.stopPropagation();
            var RemarkText = $(object).parent().next().text();

            if (RemarkText != "" || RemarkText != "undefined") {

            }
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label>Medicine Remark</label>' +
                '<textarea rows="4" cols="50"  id="txtMedicineRemark" maxlength="200" placeholder="Enter Remark" autofocus="autofocus" class="complaint form-control" required></textarea>' +//kavita
                //'<input  type="varchar" id="txtComplaintRemark" maxlength="200"  placeholder="Complaint" autofocus="autofocus" class="complaint form-control" required />' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {

                            if (RemarkText != "" || RemarkText != "undefined") {
                                $(object).parent().next().remove();
                            }

                            var CurrentRow = $(object).parent().parent();
                            stringRemarkTd = "<td class='RemarkText' style='display:none'>" + $('#txtMedicineRemark').val() + "</td>";
                            var firstChildVal = $(CurrentRow).find('td:nth-child(1)').text().trim();
                            var ComplainwithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + $('#txtMedicineRemark').val() + '</span>'
                            $(CurrentRow).find('td:nth-child(1)').children().remove();
                            $(CurrentRow).find('td:nth-child(1)').append(ComplainwithRemark);
                            CurrentRow.append(stringRemarkTd);
                        }
                    },
                    cancel: function () {
                    },
                },
                onContentReady: function () {
                    $('#txtMedicineRemark').focus();
                    if (RemarkText != "" || RemarkText != "undefined") {
                        $('#txtMedicineRemark').val(RemarkText);
                    }
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });

        }
        function GetSavedData() {
            $.loader.open();
            //var consNo = $.session.get('PatTRANNO');
            var consNo = $('#tractiondropdown').val()
            var ReSeqCnt = 0;
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetSavedMediList",
                data: { strConsNo: consNo },
                datatype: "json",
                async: false,
                success: function (response) {
                    if (response != "") {
                        var result = JSON.parse(response);
                        var len = result.length;//vijeta 12/4/19
                        ReSeqCnt = result[len - 1].RESEQ;//vijeta 12/4/19
                        // var RamrkList = JSON.parse(RemarkArray);

                      //  RxNewSetData(resultofal);
                    }
                    $.loader.close();
                },


                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }, complete: function () {
                    rowNoFrMedTaper = ReSeqCnt;//vijeta 12/4/19
                },
            });
        }

        function SearchComplaint() {
            // Declare variables 
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("ComplaintInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblMedicineList");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.MaterialName")[0];
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
            if ($(input).val().length >= 3) {
                SearchMaterial(filter, tr);
            }

        }

        function SearchMaterial(filter, tr) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                <%--    url: "<%=Url.Action("SearchMaterial","DoctorDesk")%>",--%>
                url: "<%=Url.Action("GetNonFreqDrugLstFrRxDesktop","DoctorDesk")%>",
                data: { NonFreqDrug: filter },
                asycn: false,
                success: function (response) {
                    if (response != "") {
                        $('#tblMtrlNewSearch').show();
                        $('#tblMtrlNewSearch tbody').empty();

                        for (i = 0; i < JSON.parse(response).Table.length - 1; i++) {

                            //var mtrlCode = (response[i].CODE).trim();
                            //var mtrlName = (response[i].NAME).trim();

                            var mtrlCode = (JSON.parse(response).Table[i].MTRLCODE).trim();
                            var mtrlName = (JSON.parse(response).Table[i].MTRLNAME).trim();

                            var rows = "<tr id='" + mtrlCode.replace(/[^0-9a-zA-Z]/gi, '').trim() + "' style='border-bottom:1px solid #ddd;'><td class='mtrlName' style='width:90%;color:black;font-size:14px;'>" + mtrlName + "</td><td style='display:none' class='mtrlCode'>" + mtrlCode + "</td>/tr>"

                            if ($("#tblMedicineList td:contains('" + mtrlCode + "')").length == 0)
                                $('#tblMtrlNewSearch tbody').append(rows).closest('tr');

                        }

                    }
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                    HoldOn.close();
                },
            });
        }
      <%--  function gerDrugList(filter, obj) {
            //$.loader.open();

            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetNonFregqentDrugList","DoctorDesk")%>",
                data: { NonFreqDrug: filter },
                asycn: false,
                success: function (response) {
                    var result = JSON.parse(response)
                    var checker = '';


                    for (i = 0; i < result.Table.length; i++) {
                        var rows = "";
                        var MatchElement = jQuery.grep(obj, function (element, index) { //added vijeta 10/4/19
                            Name = element.getElementsByTagName("td")[0].innerHTML;
                            return (($.trim(result.Table[i].MTRLNAME)).toString().trim() == Name.toString().trim());
                        });

                        //if (MatchElement.length > 0) {
                        //    //Do not bind
                        //}
                        //else {
                        var DurgidASClass = ''
                        DurgidASClass = (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                        DurgidASClass = DurgidASClass.replace(/\//g, '');
                        var code = $.trim(result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                        code = code.replace(/\//g, '');

                        rows += "<tr  class='" + DurgidASClass + "' id='" + $.trim(code) + "'>" +
                            "<td class='MaterialName'>" + $.trim(result.Table[i].MTRLNAME) + "</td><td class='tdNewMedSpan'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td><td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td>" +
                            "<td class='tdIntake'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' id='intake" + code + "' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add new intake' ></span></div></td>" +//intake
                            //"<td class='AddNewIntake'><a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/right.png'  class='intakeImage'></a></td>" +//27th oct 2018
                            "<td class='durationNum'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + code + "' style='display:none;font-size:16px'>0</a></td>" +
                            "<td class='durationWord' ><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + code + "' style='display:none;font-size:16px'>D</a></td>" +
                             "<td class='tdBeforeAfter'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + code + "' style='display:none;font-size:16px'>A</a></td>" +//after food before food
                            "<td class='tdDosses' ><input type='text'class='triggerInputDosses form-control' style='display:none;' placeholder='Dosage' id='dossage" + code + "'/></td>" + //dosses
                            "<td class='tdRemark' ><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + code + "' style='display:none;font-size:16px'>Remark</a><input type='hidden' id='hdn" + code + "' /></td>" +

                            //added 29/6/19
                          "<td class='setupyn' style='display:none'>N</td>" +
                         "<td class='refillyn' style='display:none'>N</td>" +


                         "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                            "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";
                        rows += "</tr>";
                        // }

                        if (rows != "") {
                            $('#tblMedicineList tbody').append(rows).closest('tr');

                            //vijeta 13/4/19
                            $("#tblMedicineList tr#" + code + "" + " input.triggerInputIntake").autocomplete({  //vijeta 5/4/19
                                source: ItakesArray,
                                autoFocus: false,
                                minLength: 0,
                                select: function (event, ui) { //on select added vijeta 8/4/19

                                    var txtval = ui.item.value;
                                    var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                                    var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();//added 15/4/19
                                    var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();//added 15/4/19
                                    var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();//added 15/4/19
                                    var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;//added 15/4/19
                                    var remark = $(this).parents('td').siblings('.tdRemark').find('a').text();//added 15/4/19
                                    var tableRow = $("#tblMedicineList tr").filter(function () {

                                        return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim();
                                    }).closest("tr");

                                    if (tableRow.length > 0) {
                                        $.messager.alert('This medicine and frequency already present');
                                        $(this).val('');
                                        $(this).focus();
                                        return false;
                                    }
                                    else {
                                        if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                                            $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                                            $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                                            // $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                                            $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                                        }
                                        else {
                                            //$(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                                            $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                                        }
                                    }


                                }
                            }).focus(function () {
                                /* Only search if the autocomplete menu is hidden: */
                                if ($("ul.ui-autocomplete").is(":hidden")) {
                                    $(this).autocomplete('search', '');
                                }
                            });
                        }


                    }
                    //}

                    ResponseCheck = result;

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //$.loader.close();
                    $.messager.alert("Error", errorThrown);
                },
                //complete: function (jqXHR, status) {

            });

        }--%>




        function GetpersonalisedList() {

            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersDiseaseList","DoctorDesk")%>",
                data: { CIMS: CIMSYN },
                asycn: false,
                success: function (response) {
                    var result = JSON.parse(response)
                    var rows = "";
                    for (i = 0; i < result.Table1.length; i++) {
                        rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);'></td><td class='DiseaseName' style='padding:5px;font-size: 14px;vertical-align:middle' onclick='CheckedSetUp(this);'><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='SetUpAddEdit(this);'></i></span></td>";
                        //3/29/19 chngd font size
                        rows += "</tr>";
                    }
                    $('#tblPersDiseaselist tbody').empty();// added by vijeta on 17th may 2018
                    $('#tblPersDiseaselist tbody').prepend(rows).closest('tr');

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            });

        }

        //function CreatePersonalList() {

        //    $.confirm({
        //        title: 'SetUp Disease',
        //        theme: 'supervan',
        //        // theme: 'material',
        //        closeIcon: true,
        //        offsetTop: 10,
        //        type: 'orange',
        //        backgroundDismissAnimation: 'glow',
        //        //  columnClass: 'col-md-6',
        //        content: '' +
        //        '<form action="" class="formName"><div class="form-group"><input id="txtDisease" type="text" id="input-name" placeholder="Search Disease" class="form-control" onkeyup="SearchDiseases()"></div>' +
        //        '<div id="divtblDisease" class="divtblDisease"><table id="tblPersDiseaselist" style="width:100%;" class="table"><tbody></tbody></table></div>' +
        //        '</form>',
        //        buttons: {
        //            formSubmit: {
        //                text: '<i class="fa fa-check-circle-o"></i>',
        //                btnClass: 'btn-default',
        //                action: function () {
        //                    stringcode = '';
        //                    var row = $('#tblPersDiseaselist tr')
        //                    for (r = 0; r < row.length; r++) {
        //                        var Chk = $(row[r]).find('.chkPersDis')
        //                        if (Chk[0].checked) {
        //                            //CodeTosend.push($(row[r]).attr('id'));
        //                            stringcode += "'" + $(row[r]).attr('id') + "'" + ','
        //                            // stringcode +=  $(row[r]).attr('id') +  ','
        //                        }
        //                    }
        //                    var codeT = stringcode.slice(1)
        //                    var strCode = codeT.substr(0, codeT.length - 2);
        //                    SavePersDiseaseList(strCode);
        //                }
        //            },
        //            Closeed: {
        //                text: '<i class="fa fa-close "></i>'
        //                //close
        //            }
        //        },

        //        onOpen: function () {
        //            $('jconfirm-box').css('margin-top', '10px !important;')
        //        },
        //        onContentReady: function () {
        //            GetpersonalisedList()

        //            $('.jconfirm-buttons').addClass('JsBtnPostion')
        //            var defaultbtn = $('.jconfirm-buttons>button');
        //            $.each(defaultbtn, function (index, val) {
        //                $(defaultbtn[index]).css('font-size', '35px');
        //                $(defaultbtn[index]).css('margin-right', '10px');
        //            })
        //            $(defaultbtn[0]).attr('id', 'btnSubmit');
        //            $(defaultbtn[0]).addClass('disable-clicks');

        //            $('.jc-bs3-row').removeClass('row')
        //            $('.jconfirm-box-container').removeClass('col-xs-offset-1')
        //            $('.jconfirm-box-container').removeClass('col-xs-10');
        //            $('.jconfirm-box-container').removeClass('col-md-4');
        //            var jc = this;
        //            this.$content.find('form').on('submit', function (e) {
        //                // if the user submits the form by pressing enter in the field.
        //                e.preventDefault();
        //                jc.$$formSubmit.trigger('click'); // reference the button and click it
        //            });

        //        }
        //    });

        //}


        function CreatePersonalList() {

            $.confirm({
                title: 'SetUp Disease',
                theme: 'supervan',
                // theme: 'material',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                //  columnClass: 'col-md-6',
                content: '' +
                '<form action="" class="formName" style="height:410px;"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:0px" class="form-control" id="RxSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtDisease" type="text" id="input-name" placeholder="Search Disease" class="form-control" onkeyup="SearchDiseases()"  style="margin-left:10px" ></td></tr></table></div>' +
                '<div id="divtblDisease" class="divtblDisease" style=""><table id="tblPersDiseaselist" style="width:100%;border-top:1px solid #29884bd6 !important" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: '<i class="fa fa-check-circle-o"></i>',
                        btnClass: 'btn-default',
                        action: function () {
                            stringcode = '';
                            var row = $('#tblPersDiseaselist tr')
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
                            SavePersDiseaseList(strCode);
                        }
                    },
                    Closed: {
                        text: '<i class="fa fa-close "></i>'
                        //close
                    }
                },

                onOpen: function () {
                    $('jconfirm-box').css('margin-top', '10px !important;')
                },
                onContentReady: function () {
                    GetpersonalisedList()

                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    var defaultbtn = $('.jconfirm-buttons>button');
                    $.each(defaultbtn, function (index, val) {
                        $(defaultbtn[index]).css('font-size', '35px');
                        $(defaultbtn[index]).css('margin-right', '10px');
                    })
                    $(defaultbtn[0]).attr('id', 'btnSubmit');
                    $(defaultbtn[0]).addClass('disable-clicks');

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
                    $('.jconfirm-box').css('box-shadow', 'rgb(62, 62, 50) 0px -1px 14px 4px');

                }
            });

        }

        function SavePersDiseaseList(strCode) {
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/SavePersonDises',
                datatype: "json",
                aysc: false,
                data: { Code: strCode, strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                success: function (result) {
                    if (result.length > 0) {
                        if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            window.location.href = 'IPMedication';
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
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }

            });
        }
        function handleChange(obj) {
            var parentRow = $(obj).parent().parent();
            $('#tblPersDiseaselist tbody').prepend(parentRow).closest('tr');
            $('table tr:nth-child(1)').find('input:first').focus(); // added by vijeta on 7th july 2018
            CountCheckBoxChecked();
        }
        function CheckedSetUp(obj) {
            var CurrentChkBox = $(obj).prev().children();
            if (CurrentChkBox.prop("checked") == true)
                CurrentChkBox.prop('checked', false);
            else
                CurrentChkBox.prop('checked', true);

            CountCheckBoxChecked();

            var parentRow = $(obj).parent();
            $('#tblPersDiseaselist tbody').prepend(parentRow).closest('tr');
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
        function RemoveMedicine(CurrenRowId, strTranNo) {
            $.ajax({
                url: '../DoctorDesk/DeleteMedicine',
                type: 'POST',
                datatype: 'json',
                data: { strMaterialCode: CurrenRowId.toString().trim(), strTranNo: strTranNo },
                success: function (response) {
                    if (response.indexOf("successful") != -1) {

                        $("tr#" + CurrenRowId).removeClass('active');
                        $("tr#" + CurrenRowId).children('td').children('i').hide();
                        $("tr#" + CurrenRowId).children('td.sortTD').hide();
                        //CurrenRow.removeClass('active');
                    }

                },
            })
        }
        function SaveMedicineResequence(str) {
            var mrno = ($.session.get('ICUPatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var MaterlstArr = [];
            var rows = $('#tblMedicineList > tbody > tr.active').get();
            //if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                var strDrugcode = rows[i].id

                if (strDrugcode.toString().trim().toUpperCase() != "NEW") {
                    var strResquence = i + 1;
                    var a = {
                        DRUGCD: strDrugcode,
                        RESEQ: strResquence,
                    };
                    MaterlstArr.push(a);
                }
            }

            $.ajax({
                type: "POST",
                url: '../DoctorDesk/SaveMedicineResequence',
                datatype: "json",
                data: { strMedicineList: JSON.stringify(MaterlstArr), strTranNO: tranNo, strMRNo: mrno },
                success: function (result) {
                    if (str != "Y") //added on 18th april 2018
                        window.location.href = '../DoctorDesk/PatientEntry';
                },
            });

        }
        function SearchDiseases() {
            // Declare variables 
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("txtDisease");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblPersDiseaselist");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.DiseaseName")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";

                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }

        }

        //added on 30th April 2018
        $(document.body).on('click', '#RxSetUpAdd', function (e) {

            SetUpAddEdit(this);//added on 6th march 2019
        });

        //added on 30th April 2018
        //$(document.body).on('click', '#txtServiceGrpsearch', function (e) {
        //    $("#dblServiceHelpsrvcgrp").show();

        //    $("#divSrvcGrpGrid").show();// added by vijeta on 14th May 2018
        //});

        //added on 22nd sep 2018
        $(document.body).on({
            'click': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
                $("#divSrvcGrpGrid").show();
            },
            'focus': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
                $("#divSrvcGrpGrid").show();
            },

        }, '#txtServiceGrpsearch');

        //added on 30th April 2018
        $(document.body).on('click', '#btnsrvgrp', function (e) {
            $('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);

            $('#tblGrid').jqGrid('clearGridData'); // added by vijeta on1 16th may 2018
        });

        //added on 30th April 2018
        //$(document.body).on('click', '.formName', function (e) {
        //    if (e.target.id != "txtServiceGrpsearch" && !$(event.target).closest('#divSrvcGrpSelect').length && !$(event.target).closest('#divSrvcGrpGrid').length && !$(event.target).closest('#formDetails').length) {
        //        $('#dblServiceHelpsrvcgrp').hide();

        //        $('#divSrvcGrpGrid').hide();// added by vijeta on 14th May 2018
        //    }

        //});//3/29/19comntd

        //added on 30th april 2018
        function SerivceGrpData(srvcgrpname) {
            var $newDiv = $('<div>');
            $newDiv.attr("id", srvcgrpname);
            $newDiv.attr("name", srvcgrpname);
            $newDiv.addClass("searchdivclass");
            //$newDiv.css('width', '188px');
            $newDiv.css('height', '200px');//3/28/19
            $newDiv.css('margin-left', '0px');
            $newDiv.css('overflow', 'auto');
            $newDiv.css('display', 'none');
            $newDiv.css('border-color', '#f47b02;')
            $newDiv.css(' border-style', 'solid');
            $newDiv.css('background', 'azure')
            var $newul = $('<ul>');
            $newul.attr("id", "SrvcGrpdata");
            $newul.addClass("searchlistclass");
            var options = "";
            //Iterated over the IEnumerable list.
            var abc = "<a id=btnsrvgrp style=color:blue;cursor:pointer float:right;>ClearSelection</a>"
            var i = 0;

            //added on 17th may 2018
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetFregqentMaterialCIMS","DoctorDesk")%>",//change by kavita GetFregqentMaterial to GetFregqentMaterialCIMS
                data: {},
                async: false,
                success: function (response) {

                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);
                        for (i = 0; i < result.Table.length; i++) {
                            var title = result.Table[i].MTRLNAME;
                            var idstring = result.Table[i].MTRLCODE;
                            options += "<li><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + result.Table[i].MTRLCODE + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'>" + result.Table[i].GENERICID + "</label><label id='genericName' style='display:none'>" + result.Table[i].GENERICNAM + "</label><li>";
                        }
                    }



                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                },

            });
            //-------------------------------------


            $newul.append(abc);
            $newul.append(options);
            $newDiv.append($newul);
            $('#divSrvcGrpSelect').append($newDiv);
        }

        function BindSelectedMedicineGrid() {
            function getColumnIndexByName(grid, columnName) {
                var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
                for (i = 0; i < l; i++) {
                    if (cm[i].name === columnName) {
                        return i; // return the index
                    }
                }
                return -1;
            }
            jQuery("#tblGrid").jqGrid({
                datatype: 'local',
                //colNames: ['', 'Code', 'Medicine Name', 'Dose', '<label>Frequency</label><span style="float:right;width: 22px;font-size: large;color: #3d7da3" title="Add Frequency" id="btnNewIntake" onclick="NewIntake()"> <i class="fa fa-plus"></i></span>', 'Intake Calculated', 'Days', 'Duration', 'Food', 'Route', 'Remark','Dil Vol','Admin Duration', 'Generic Id', 'Generic Name', 'Drug Form'],
                colNames: ['', 'Code', 'Medicine Name', 'Dose', '<label>Frequency</label><span style="float:right;width: 22px;font-size: large;color: #3d7da3" title="Add Frequency" id="btnNewIntake" onclick="NewIntake()"> <i class="fa fa-plus"></i></span>', 'Intake Calculated', 'Days', 'Duration', 'Food', 'Route', 'Remark', 'Dil Vol', 'Admin Duration', 'Order By', 'Generic Id', 'Generic Name', 'Drug Form', 'Drug Code', 'Type Code',
                    'Omitted By', 'Omitted Date', 'Omitted Time', 'Ordered Date', 'Ordered Time', 'Drug Sequence No', 'High Alert', 'NotifyYN', 'Status', 'ADMINYN'],
                colModel: [
                    {
                        name: 'act',
                        name: 'act',
                        width: 25,//50,
                        editable: false,
                        formatter: CancelImg
                    },
                     { name: 'CODE', index: 'CODE', width: 10, hidden: true, align: "right", sortable: false, searchoptions: { clearSearch: false } },
                  {
                      name: 'NAME', index: 'NAME', width: 100, align: "left", sortable: false, searchoptions: { clearSearch: false }//3/29/19 width chngd
                  },
                  {
                      name: 'DOSAGE', index: 'DOSAGE', width: 80, align: "left", sortable: false, hidden: false, editable: true
                  },
                  
                  
                   {
                       name: 'INTAKE', index: 'INTAKE', width: 100, align: "left", sortable: false, searchoptions: { clearSearch: false }, edittype: 'select', editable: true,
                       editoptions: {
                           value: load_Intake(),
                           defaultvalue: "--select--",
                           style: "width:88px;font-size: 12px;",
                           dataInit: function (e) {
                               jQuery("#tblGrid").setColProp("INTAKE", {
                                   editoptions: {
                                       value: load_Intake(),
                                   }//......................
                               });//3/29/19 width chngd
                               //$(e).width(155).height(20).select2({
                               //    dropdownCssClass: "ui-widget ui-jqdialog"
                               //});
                               //$(e).change(function (evnt) {
                               //    var rowId = $("#tblGrid").jqGrid('getGridParam', 'selrow');
                               //    AddMedicineDetail(evnt.target.value, rowId);
                               //});
                           },
                           dataEvents: [{
                               type: 'change',
                               // type:'click',
                               fn: function (e) {
                                   //e.stopPropagation();
                                 
                                   var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                   jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 7, true);//3/29/19
                                  
                                   // AddMedicineDetail(e.target.value, rowId);// commented by vij on 7th dec 2018

                               }
                           }]
                       }
                   },
                    {
                        name: 'INTAKECALC', index: 'INTAKECALC', width: 100, align: "left", sortable: false, hidden: true
                    },
                     {
                         name: 'DAYS', index: 'DAYS', width: 60, align: "left", sortable: false, searchoptions: { clearSearch: false }, hidden: false, edittype: 'select', editable: true,
                         editoptions: {
                             value: load_Days(),
                             defaultvalue: "--select--",
                             style: "width:50px;font-size: 12px;",
                             dataInit: function (e) {
                                 jQuery("#tblGrid").setColProp("DAYS", {
                                     editoptions: {
                                         value: load_Days(),
                                     }
                                 });

                             },
                             dataEvents: [
                                {
                                    type: 'change',
                                    fn: function (e) {

                                        var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                        jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 8, true);//3/29/19

                                    }
                                }
                             ]
                         }
                     },
                    {
                        name: 'DURATION', index: 'DURATION', width: 60, align: "left", sortable: false, searchoptions: { clearSearch: false }, hidden: false, edittype: 'select', editable: true,
                        editoptions: {
                            value: load_Duration(),
                            defaultvalue: "--select--",
                            style: "width:57px;font-size: 12px;",
                            dataInit: function (e) {
                                jQuery("#tblGrid").setColProp("DURATION", {
                                    editoptions: {
                                        value: load_Duration(),
                                    }
                                });

                            },
                            dataEvents: [
                               {
                                   type: 'change',
                                   fn: function (e) {

                                       var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                       jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 9, true);//3/29/19

                                   }
                               }
                            ]
                        }
                    },
                    {
                        name: 'FOOD', index: 'FOOD', width: 80, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true,
                        editoptions: {
                            value: load_Food(),
                            defaultvalue: "--select--",

                            dataInit: function (e) {
                                jQuery("#tblGrid").setColProp("FOOD", {
                                    editoptions: {
                                        value: load_Food(),
                                    }
                                });

                            },
                            dataEvents: [
                              {
                                  type: 'change',
                                  fn: function (e) {

                                      var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                      jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 10, true);//3/29/19

                                  }
                              }
                            ]
                        }
                    },
                     {
                         name: 'ROUTE', index: 'ROUTE', width: 150, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true, formatter: 'select',
                         editoptions: {
                             value: load_Route(),
                             defaultvalue: "--select--",
                             style: "width:140px;font-size: 12px;",
                             dataInit: function (e) {
                                 jQuery("#tblGrid").setColProp("ROUTE", {
                                     editoptions: {
                                         value: load_Route(),
                                     }
                                 });
                             },
                             dataEvents: [{
                                 type: 'change',
                               
                                 fn: function (e) {
                                 
                                     var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                     jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 11, true);



                                 }
                             }]
                         }
                     },
                    {
                        name: 'REMARK', index: 'REMARK', width: 150, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true, formatter: 'select',
                        editoptions: {
                            value: load_Remarks(),
                            defaultvalue: "--select--",
                            style: "width:140px;font-size: 12px;",
                            dataInit: function (e) {
                                jQuery("#tblGrid").setColProp("REMARK", {
                                    editoptions: {
                                        value: load_Remarks(),
                                    }
                                });

                            },
                        }
                    },
                     {
                         name: 'DVOL', index: 'DVOL', width: 150, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true, formatter: 'select',
                         editoptions: {
                             value: load_DiluVolume(),
                             defaultvalue: "--select--",
                             style: "width:140px;font-size: 12px;",
                             dataInit: function (e) {
                                 jQuery("#tblGrid").setColProp("DVOL", {
                                     editoptions: {
                                         value: load_DiluVolume(),
                                     }
                                 });

                             },
                         }
                     },
                      {
                          name: 'ADUR', index: 'ADUR', width: 150, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true, formatter: 'select',
                          editoptions: {
                              value: load_AdminDurData(),
                              defaultvalue: "--select--",
                              style: "width:140px;font-size: 12px;",
                              dataInit: function (e) {
                                  jQuery("#tblGrid").setColProp("DIL", {
                                      editoptions: {
                                          value: load_AdminDurData(),
                                      }
                                  });

                              },
                          }
                      },
                       {
                           name: 'ORDERBY', index: 'ORDERBY', width: 100, align: "left", sortable: false, searchoptions: { clearSearch: false }//3/29/19 width chngd
                       },
                     {
                         name: 'GENERICID', index: 'GENERICID', width: 120, align: "left", sortable: false, hidden: true
                     },
                      {
                          name: 'GENERICNAM', index: 'GENERICNAM', width: 220, align: "left", sortable: false, hidden: false
                      },
                      {
                          name: 'DRUGFORM', index: 'DRUGFORM', width: 80, align: "left", sortable: false, hidden: false, editable: false
                      },
                       {
                           name: 'DrugCode', index: 'DrugCode', width: 80, align: "left", sortable: false, hidden: true, editable: false
                       },
                        {
                            name: 'TypeCode', index: 'TypeCode', width: 80, align: "left", sortable: false, hidden: true, editable: false
                        },
                         
              {
                  name: 'OmittedBy', index: 'OmittedBy', width: 80, align: "left", sortable: false, hidden: true, editable: false
              },
              {
                  name: 'OmittedDate', index: 'OmittedDate', width: 80, align: "left", sortable: false, hidden: true, editable: false
              },
              {
                  name: 'OmittedTime', index: 'OmittedTime', width: 80, align: "left", sortable: false, hidden: true, editable: false
              },
              {
                  name: 'OrderedDate', index: 'OrderedDate', width: 80, align: "left", sortable: false, hidden: true, editable: false
              },
              {
                  name: 'OrderedTime', index: 'OrderedTime', width: 80, align: "left", sortable: false, hidden: true, editable: false
              },
              {
                  name: 'DrugSequenceNo', index: 'DrugSequenceNo', width: 80, align: "left", sortable: false, hidden: true, editable: false
              },
              {
                  name: 'HighAlertDrug', index: 'HighAlertDrug', width: 80, align: "left", sortable: false, hidden: true, editable: false
              },
              {
                  name: 'NotifyYN', index: 'NotifyYN', width: 80, align: "left", sortable: false, hidden: true, editable: false
              },
              {
                  name: 'Status', index: 'Status', width: 80, align: "left", sortable: false, hidden: true, editable: false
              },
               {
                   name: 'ADMINYN', index: 'ADMINYN', width: 80, align: "left", sortable: false, hidden: true, editable: false
               }   
                ],

                rowNum: 9999999999,
                sortname: 'id',
               // width: 440,//3/28/19
                //footerrow: true,
               // height: 200,//3/28/19
                viewrecords: true,
                sortorder: "desc",
                loadtext: 'Loading...',
                loadonce: true,
                rownumbers: true,
                shrinkToFit: false,
                cellEdit: true,
                //footerrow: true,
                ignoreCase: true,
                cellsubmit: 'clientArray',
                loadComplete: function () {
                    $("#tblGrid").css('font-size', '11.1px');
                    //var iCol = getColumnIndexByName($("#tblGrid"), 'act'); var inc = 0;
                    //$("#tblGrid").find(">tbody>tr.jqgrow>td:nth-child(" + (iCol + 1) + ")")
                    //             .each(function () {


                    //                         $("<div>", {
                    //                             title: "Remove",
                    //                             mouseover: function () {
                    //                                 $(this).addClass('ui-state-hover');
                    //                             },
                    //                             mouseout: function () {
                    //                                 $(this).removeClass('ui-state-hover');
                    //                             },
                    //                             click: function (e) {
                    //                                 l_orowId = $(e.target).closest("tr.jqgrow").attr("id");
                    //                                 var rowData = jQuery("#tblGrid").getRowData(l_orowId);

                    //                             }
                    //                         }
                    //                    ).css({ "margin-right": "5px", float: "left", cursor: "pointer" })
                    //                     .addClass("ui-pg-div ui-inline-custom")
                    //                     .append('<span class="ui-icon  ui-icon-cancel"></span>')
                    //                     .prependTo($(this));



                    //             });
                },
                gridComplete: function () {
                    $("#tblGrid").css('font-size', '11.1px');
                    // totbed = $("#gvBedOccup").jqGrid('getCol', 'TOTBED', false, 'sum');
                },
                ondblClickRow: function (rowId) {
                    //GetMedicineDetails(rowId);// commented by vijeta on 6th July 2018
                    var rowdat = $('#tblGrid').getRowData(rowId);// added by vijeta on 6th july 2018
                    var intakesList = IntakeREsult.Table;
                    var InTKNAME = rowdat["INTAKE"];
                    value = jQuery.grep(IntakeREsult.Table, function (n, i) {
                        return (n.INTAKE == InTKNAME);
                    });
                    // AddMedicineDetail(value[0].CODE, rowId);// added by vijeta on 6th july 2018
                },
                onCellSelect: function (rowId, iCol, content, event) {
                    rows = $('#tblGrid')[0].rows;
                    var rowdat = $('#tblGrid').getRowData(rowId);

                    if (iCol == 1) {

                        $('#tblGrid').jqGrid('delRowData', rowId);

                        $("ul#SrvcGrpdata input[value='" + rowId + "']").prop('checked', false);// changed by vij on 24th sep 2018
                    }
                },
            }).trigger("reloadGrid");
            $("#tblGrid").jqGrid('bindKeys');
            $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
            //$('.ui-jqgrid-sdiv').addClass('AddFooterClass');
            jQuery('#tblGrid').closest('.ui-jqgrid-view')
        .find(".ui-jqgrid-htable .ui-search-toolbar .ui-th-column")
        .find("input, select")
        .focus(function (e) {
            var $header = $(e.target).closest('.ui-jqgrid-hdiv'),
                $body = $header.siblings('.ui-jqgrid-bdiv');
            setTimeout(function () {
                $body[0].scrollLeft = $header[0].scrollLeft;
            }, 0);
        });


            var cdiv = $('#ContentHolderDiv').width();
            $("#tblGrid").jqGrid("setGridWidth", cdiv - 700, false);
            $("#tblGrid").jqGrid("setGridHeight", "200", true);
        }



        //added on 14th may 2018
        $(document.body).on('click', 'ul#SrvcGrpdata input', function (e) {

            if (CIMSYN = "Y") {
                if ($(this)[0].checked) {

                    $.ajax({

                        url: '../DoctorDesk/GetMaterialInfo',
                        data: { mtrlCode: $(this)[0].defaultValue },
                        type: 'post',
                        datatype: 'json',
                        success: function (response) {

                            //var result = {
                            //    MTRLCODE: response.CODE,
                            //    MTRLNAME: response.NAME,
                            //    GENERICNAM: response.Generic,
                            //    GENERICID: response.GenericCode,
                            //    DRUGFORM: response.Form,
                            //    Strength: response.Strength,
                            //    StrengthUnit: response.StrengthUnit
                            //};
                            //var newRow = {
                            //    act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                            //    CODE: $(this)[0].defaultValue,
                            //    NAME: $(this)[0].parentNode.innerText,

                            //    GENERICID: $(this)[0].parentNode.nextSibling.innerText,
                            //    GENERICNAM: $(this)[0].parentNode.nextSibling.nextSibling.innerText
                            //};
                            var newRow = {
                                act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                                CODE: response.CODE,
                                NAME: response.NAME,
                                DRUGFORM: response.Form,
                                GENERICID: response.GenericCode,
                                GENERICNAM: response.Generic,
                            };
                            var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                            if ($.inArray($(this)[0].defaultValue, ids) == -1)
                                $('#tblGrid').addRowData($(this)[0].defaultValue, newRow, 'last');
                        },
                        complete: function () {
                            // GetMaterialInteraction(mtrlCode);
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            $.messager.alert("Error", errorThrown);
                        }
                    });
                    //$("#tblGrid").jqGrid('addRow', "new");

                }
            }
            else {
                $('#tblGrid').jqGrid('delRowData', $(this)[0].defaultValue);
            }
        });

        //added on 14th may 2018
        function load_Intake() {
            var s;
            $.ajax({
                url: '../DoctorDesk/GetMedicineInTake',
                data: {},
                type: 'get',
                datatype: 'json',
                async: false,
                success: function (response) {
                    if (response != "Unsucessfull") {
                        IntakeREsult = JSON.parse(response);
                        s = ":--select--;";
                        for (i = 0; i < IntakeREsult.Intake.length; i++) {
                            s += IntakeREsult.Table[i].CODE + ":" + IntakeREsult.Table[i].INTAKE + ";";
                        }
                        s = s.substring(0, s.length - 1);
                    }


                }
            });
            return s;
        }

        //added on 7th dec 2018
        function load_Days() {
            var s;
            s = ":--select--;";
            for (i = 0; i <= 30; i++) {
                s += i + ":" + i + ";";
            }
            s = s.substring(0, s.length - 1);
            return s;
        }

        //added on 7th dec 2018
        function load_Duration() {
            var s;
            s = ":--select--;";
            s += "Days:Days;";
            s += "Weeks:Weeks;";
            s += "Months:Months;";
            s += "Years:Years;";

            s = s.substring(0, s.length - 1);

           
            return s;
        }

        //added on 7th dec 2018
        function load_Food() {
            var s;
            s = ":--select--;";
            s += "After:After;";
            s += "Before:Before;";

            s = s.substring(0, s.length - 1);
            return s;
        }

        //added on 7th dec 2018
        function load_Remarks() {
            var arry = JSON.parse(RemarkArray.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));//vijeta 13/4/19
            var s = "";
            for (i = 0; i < arry.length; i++) {
                s += arry[i].Value + ":" + arry[i].Text + ";";
            }
            s = s.substring(0, s.length - 1);
            return s;
        }
        function load_Route() {
            var arry = JSON.parse(MedRoute.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));//vijeta 13/4/19
            var s = "";
            for (i = 0; i < arry.length; i++) {
                s += arry[i].Text.replace(/[^0-9a-zA-Z]/gi, '') + ":" + arry[i].Text + ";";
            }
            s = s.substring(0, s.length - 1);
            return s;
        }
        function load_DiluVolume() {
            var s;
            var DiluVolumeTypelst
            var DiluVolumelst
            $.ajax({
                url: 'GetDilutionVolumList',
                data: {},
                type: 'get',
                async: false,
                success: function (Response) {
                    DiluVolumelst = Response;
                    s = " : ;"; $.each(DiluVolumelst, function () {
                        s += this.Value + ":" + this.Text + ";";
                    });
                    s = s.substring(0, s.length - 1);
                }
            });
            return s;
        }
        function load_AdminDurData() {
            var s;
            var AdminDurDatalst
            $.ajax({
                url: 'GetAdminiStrDur',
                data: {},
                type: 'get',
                async: false,

                success: function (Response) {
                    AdminDurDatalst = Response;
                    s = " : ;"; $.each(AdminDurDatalst, function () {
                        s += this.Value + ":" + this.Text + ";";
                    });
                    s = s.substring(0, s.length - 1);
                }
            });
            return s;
        }
        //added on 14th may 2018
        function AddMedicineDetail(IntakeId, rowId) {
            var medicineData = $("#tblGrid").getRowData(rowId);
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

            var Id = IntakeId;
            value = jQuery.grep(IntakeREsult.Table, function (n, i) {
                return (n.CODE == Id);
            });

            var InatkeCombi = value[0].INTAKE;
            strx = InatkeCombi.split('-');

            for (m = 0; m < strx.length; m++) {
                labelVal += '<label class="BtnInke"><span style="font-size: 27px;">' + strx[m] + '</span></label>'
            }

            //added on 6th july 2018
            //food
            var aftrfd = medicineData.FOOD == "After Food" ? "active" : "";
            var bfrfd = medicineData.FOOD == "Before Food" ? "active" : "";

            //DAYS
            var activeDay = medicineData.DAYS;

            //duration
            var dura = medicineData.DURATION
            //
            $.confirm({
                theme: 'material',
                type: 'orange',
                columnClass: 'medium',
                closeIcon: true,
                title: '' + medicineData.NAME + '',
                content: '' +
                '<form action="" class="formName" style="text-align:center" id="formDetails">' +
                 '<div style="margin-bottom:15px;"><div class="btn-group groupCombi" data-toggle="buttons" style="padding-top: 6px" id="GropSeelect">' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="0.5" autocomplete="off" checked="">0.5</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="1" autocomplete="off" checked="">1</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="5" autocomplete="off" checked="">5</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="10" autocomplete="off" checked="">10</label>' +
                  '</div></div>' +
                '<div class="form-group" id="btnCalulatedIntaKe">' + labelVal + '</div>' +
                 '<div style="margin-bottom:15px;"><div class="btn-group Food" data-toggle="buttons" style="padding-top: 6px" id="foodIntake">' +
               '<label class="btn btn-default borderC ' + bfrfd + '" onclick="StoreABFoodVal(this)"><input type="radio" name="FoodInfo" value="E" autocomplete="off" checked="">Befor Meal</label>' +
              '<label class="btn btn-default borderC ' + aftrfd + '" onclick="StoreABFoodVal(this)"><input type="radio" name="FoodInfo" value="A" autocomplete="off" checked="">After Meal</label>' +
            '</div></div>' +

             '<div style="margin-bottom:15px;" class=""><div class="btn-group IntkeStatement" data-toggle="buttons" style="padding-top: 6px" id="IntkeStatement">' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraConti"><input type="radio" name="IntkeStatement" value="Contd" autocomplete="off" checked="">Contd</label>' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraSOS"><input type="radio" name="IntkeStatement" value="SOS" autocomplete="off" checked="">SOS</label>' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraStat"><input type="radio" name="IntkeStatement" value="STAT" autocomplete="off" checked="">STAT</label>' +//added on 4th sep 2018
               '<label class="btn btn-default active" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraOther"><input type="radio" name="IntkeStatement" value="Other" autocomplete="off" checked="">Other</label>' +
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
                            AddMedicineRow(rowId);
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

                    //added on 6th July 18
                    if (activeDay != " ")
                        CallSelectedNumber($("#D" + activeDay)[0]);

                    if (dura == "Contd")
                        StoreINTStatementVal($("#lblDuraConti")[0]);
                    else if (dura == "SOS")
                        StoreINTStatementVal($("#lblDuraSOS")[0]);
                    else if (dura == "STAT")//added on 4th sep 2018
                        StoreINTStatementVal($("#lblDuraStat")[0]);//added on 4th sep 2018
                    else
                        StoreINTStatementVal($("#lblDuraOther")[0]);


                    //for days weeks months n years
                    if (dura == "DAYS")
                        StoreDaysValue($("#DAYS")[0]);
                    else if ((dura == "WEEK"))
                        StoreDaysValue($("#WEEK")[0]);
                    else if ((dura == "MONTH"))
                        StoreDaysValue($("#MONTH")[0]);
                    else if ((dura == "YEAR"))
                        StoreDaysValue($("#YEAR")[0]);
                }
            });
        }

        //added on 15th may 2018
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

        //added on 15th may 2018
        function ValueToStore(obj) {
            IncrementalValue = (obj).children[0].value;
            RalVal = (obj).children[0].value;
        }

        //added on 15th may 2018
        function StoreABFoodVal(obj) {
            SelectedBAFood = (obj).children[0].value;
        }

        //added on 15th may 2018
        function StoreINTStatementVal(obj) {
            SelectedINTStemnt = (obj).children[0].value;
            if (SelectedINTStemnt.length > 0) {
                $("#lblDuraOther").removeClass("active");//added on 4th sep 2018
                obj.className = "btn btn-default active"; //added on 6th July 2018
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
                    SelectedNumber = "";//added on 6th July 2018
                }
                else {
                    $('.ParentDivDN').removeClass('disable-clicks')
                }
            }

        }

        //added on 15th may 2018
        function StoreDaysValue(obj) {
            obj.className = "btn btn-default NoBorder active";// added by vijeta on 6th July 2018
            SelectedDWM = (obj).children[0].value;
            SelectedDWMText = $(obj).attr('id');
        }

        //added on 15th may 2018
        function AddMedicineRow(rowId) {

            // calculated intake
            var calIntk = "";
            if (CalculatdIntake.length > 0) {
                calIntk = CalculatdIntake.slice(0, -1);
            }
            else {
                calIntk = '';
            }

            // Food status
            var FoodStatus = ''
            if (SelectedBAFood == "A") {
                FoodStatus = "After Food";
            }
            else if (SelectedBAFood == "E") {
                FoodStatus = "Before Food";
            }

            // Days
            var days = " ";
            days = SelectedNumber;

            //Duration 
            var duration = "";
            if (SelectedINTStemnt.length > 0) {
                if (SelectedINTStemnt.substring(0, 1) == "S" || SelectedINTStemnt.substring(0, 1) == "C") {
                    duration = SelectedINTStemnt;
                    days = " ";//added on 6th july 2018
                }
                else {
                    duration = SelectedDWMText;
                }
            }
            else {
                duration = SelectedDWMText;
            }

            jQuery("#tblGrid").jqGrid('setCell', rowId, "INTAKECALC", calIntk);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DAYS", days);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DURATION", duration);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "FOOD", FoodStatus);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DOSAGE", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "ROUTE", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "REMARK", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DVOL", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "ADUR", "");

            jQuery("#tblGrid").jqGrid('setCell', rowId, "DrugCode", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "TypeCode", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "OmittedBy", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "OmittedDate", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "OmittedTime", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "OrderedDate", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "OrderedTime", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DrugSequenceNo", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "HighAlertDrug", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "NotifyYN", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "Status", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "ADMINYN", "");


           

        }


        //added on 15th may 2018
        function ChangeCombinationVal(obj) {

            obj.text(Number(obj.text()) + Number(RalVal))
        }

        //added on 15th may 2018
        function GetMedicineDetails(rowId) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:60px">' +
                '<div class="form-group">' +
                '<table style="width: 100%; margin-bottom: 5px; margin-left: 5px; font-size: 14px;" id="MediTbl">' +
                            '<tr>' +
                                '<th class="hide">Code</th>' +
                                '<th class="">Intake</th>' +
                                '<th class="">Duration</th>' +
                                '<th style="width: 18%">Food</th>' +

                            '</tr>' +
                        '</table>' +
                        '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'OK',
                        btnClass: 'btn-blue',
                        action: function () {

                        }
                    },
                    //cancel: function () {
                    //    text: 'OK'
                    //},
                },
                onContentReady: function () {
                    fillData(rowId);
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });
        }

        //added on 15th may 2018
        function fillData(rowId) {
            var table = $('#MediTbl');
            var rowCount = table[0].rows.length;
            var row = table[0].insertRow(rowCount);

            var data = $('#tblGrid').jqGrid('getRowData', rowId);
            var FoodStatus = ''


            var cell1 = row.insertCell(0);
            if (data["INTAKECALC"].length > 0) {
                cell1.innerHTML = data["INTAKECALC"].toString();
            }
            else {
                cell1.innerHTML = '';
            }

            var cell2 = row.insertCell(1);
            if (data["DURATION"].length > 0) {
                if (data["DAYS"] != "")
                    cell2.innerHTML = data["DAYS"] + " " + data["DURATION"];
                else
                    cell2.innerHTML = data["DURATION"];
            }

            var Cell3 = row.insertCell(2)
            Cell3.innerHTML = data["FOOD"].toString();
            Cell3.setAttribute('style', 'width:18%');

        }

        //added on 16th may 2018
        function CancelImg(value, options, rowObject) {
            var flag = false;
            var radioHtml = "";
            radioHtml = '<span class="ui-icon ui-icon-cancel">Remove</span>';
            return radioHtml;
        }

        // added by vijeta on 17th may 2018
        function MedicineFilter() {
            //document.removeEventListener('keyup', doc_keyUpForShortCutMenus, false);//added on 24th sep 2018
            input = document.getElementById("txtServiceGrpsearch");
            filter = input.value.toUpperCase();
            var elem = $("#SrvcGrpdata li");
            var search = false;

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

            search = $(elem).hasClass('display');
            if (search) {

            }
            else {
                getNonFreqInChkBxList(filter);
            }
        }

        //added on 18th May 2018
        function getNonFreqInChkBxList(filter) {
            $.ajax({
                type: "POST",
                datatype: "json",
                url: "<%=Url.Action("SearchMaterial","DoctorDesk")%>",
                data: { NonFreqDrug: filter },
                asycn: false,
                success: function (response) {

                    //var result = JSON.parse(response)
                    var result = response;
                    var checker = '';
                    //if (ResponseCheck1.hasOwnProperty("Table")) {
                    //    if (ResponseCheck1.Table.length > 0) {
                    //        checker = $.grep(ResponseCheck1.Table, function (n, i) {
                    //            return (n.MTRLCODE = result.Table[i].MTRLCODE);
                    //        });
                    //    }
                    //}
                    //if (checker.length == 0) {
                    var rows = "";
                    var options = "";
                    for (i = 0; i < result.length; i++) {
                        var title = result[i].NAME;
                        var idstring = result[i].CODE;
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + result[i].CODE + "'>" + title + "</label><label id='genericId' style='display:none'>" + result[i].GENERICID + "</label><label id='genericName' style='display:none'>" + result[i].GENERICNAM + "</label><li>";
                        //var DurgidASClass = ''
                        //DurgidASClass = (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                        //rows += "<tr onclick='myFunction(this);' class='" + DurgidASClass + "' id='" + $.trim(result.Table[i].MTRLCODE) + "'>" +
                        //     "<td class='tdDe'><i class='fa fa-trash-o removeMedicine fa-2x' style='display:none'></i></td>" +
                        //    "<td class='MaterialName' style='padding:5px;font-size: 13px;'>" + $.trim(result.Table[i].MTRLNAME) + "</td>" +
                        //    "<td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td>" +
                        //    "<td class='sortTD' style='line-height:0px !important;display:none;vertical-align:middle'><a href='#' id='SortMe'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                        //    "<td class='sortTD' style='line-height:0px !important;display:none;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";

                        //rows += "</tr>";
                    }
                    //}
                    $(options).insertAfter('a[id="btnsrvgrp"]');
                    //$('ul#SrvcGrpdata').prepend(options).closest('li');
                    ResponseCheck1 = result;

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            });

        }

        function SetUpAddEdit(obj) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">Medicine SetUp</label>' +
                '<input  type="varchar" id="txtSetUp"  placeholder="Enter SetUp Name" autofocus="autofocus" class="setUp form-control" required />' +
                //'<br><input id="txtServiceGrpsearch" type="varchar" style="" placeholder="Search For Medicines...." title="Search For Medicines" class="form-control" onkeyup="MedicineFilter()" />' +
                '<br><input id="txtServiceGrpsearch" type="varchar" style="" placeholder="Search For Medicines" class="form-control" onkeyup="MedicineFilter()" /><span class="fa fa-plus fa-2x mediAddspan" style="" title="Add new Medicine" id="spanAddNewMedInSetUp"></span>' + //vijeta 29/03/19
                '<div id="divSrvcGrpSelect" style="border:1px solid gray;"></div>' +
                '<div id="divSrvcGrpGrid"  style="display:none;margin-top:5px"><table id="tblGrid"></table></div>' +
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
                            var strArry = chlBoxValLst.join(",");

                            //added on 17th may 2018
                            var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                            myDataWithIds = $.map(ids, function (index, key) {
                                $('#tblGrid').jqGrid("editCell", 0, 0, false);
                                DRUGNM = $("#tblGrid").jqGrid('getCell', index, 'NAME');

                                DRUGFORM = $("#tblGrid").jqGrid('getCell', index, 'DRUGFORM');
                                if ($("#tblGrid").jqGrid('getCell', index, 'DAYS') != "--select--")//
                                    DAYS = $("#tblGrid").jqGrid('getCell', index, 'DAYS');
                                else
                                    DAYS = '';
                                DRUGCD = $("#tblGrid").jqGrid('getCell', index, 'CODE');
                                if ($("#tblGrid").jqGrid('getCell', index, 'DURATION') != "--select--")//
                                    DURATION = $("#tblGrid").jqGrid('getCell', index, 'DURATION');
                                else
                                    DURATION = '';
                                if ($("#tblGrid").jqGrid('getCell', index, 'FOOD') != "--select--")//
                                    ABFOOD = $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "B" ? "E" : $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "A" ? "A" : "";
                                else
                                    ABFOOD = '';
                                if ($("#tblGrid").jqGrid('getCell', index, 'INTAKE') != "--select--")//
                                    INTAKEDESC = $("#tblGrid").jqGrid('getCell', index, 'INTAKE');
                                else
                                    INTAKEDESC = '';

                                if ($("#tblGrid").jqGrid('getCell', index, 'INTAKE') != "--select--")//

                                    INTAKECD = $("#tblGrid").jqGrid('getCell', index, 'INTAKE');
                                else
                                    INTAKECD = '';



                                SOSYN = $("#tblGrid").jqGrid('getCell', index, 'DURATION').substring(0, 1) == "S" ? "Y" : "N";
                                GENERICID = $("#tblGrid").jqGrid('getCell', index, 'GENERICID');
                                GENERICNAM = $("#tblGrid").jqGrid('getCell', index, 'GENERICNAM');
                                DOSSAGE = $("#tblGrid").jqGrid('getCell', index, 'DOSAGE');
                                ROUTE = $("#tblGrid").jqGrid('getCell', index, 'ROUTE');
                                REMARKS = $("#tblGrid").jqGrid('getCell', index, 'REMARK');
                                DVOL = $("#tblGrid").jqGrid('getCell', index, 'DVOL');
                                ADUR = $("#tblGrid").jqGrid('getCell', index, 'ADUR');
                                DIL = $("#tblGrid").jqGrid('getCell', index, 'DIL');
                                SDATE = $("#tblGrid").jqGrid('getCell', index, 'SDATE');

                                DrugCode = $("#tblGrid").jqGrid('getCell', index, 'DrugCode');
                                TypeCode = $("#tblGrid").jqGrid('getCell', index, 'TypeCode');
                                OmittedBy = $("#tblGrid").jqGrid('getCell', index, 'OmittedBy');
                                OmittedDate = $("#tblGrid").jqGrid('getCell', index, 'OmittedDate');
                                OmittedTime = $("#tblGrid").jqGrid('getCell', index, 'OmittedTime');
                                OrderedDate = $("#tblGrid").jqGrid('getCell', index, 'OrderedDate');
                                OrderedTime = $("#tblGrid").jqGrid('getCell', index, 'OrderedTime');
                                DrugSequenceNo = $("#tblGrid").jqGrid('getCell', index, 'DrugSequenceNo');
                                HighAlertDrug = $("#tblGrid").jqGrid('getCell', index, 'HighAlertDrug');
                                NotifyYN = $("#tblGrid").jqGrid('getCell', index, 'NotifyYN');
                                Status = $("#tblGrid").jqGrid('getCell', index, 'Status');
                                ADMINYN = $("#tblGrid").jqGrid('getCell', index, 'ADMINYN');

                               

                                if (DURATION == "STAT")//added on 4th sep 2018
                                    DURATION = "T";

                                return { DRUGNM: DRUGNM, DRUGFORM: DRUGFORM, DOSSAGE: DOSSAGE, DAYS: DAYS, Remarks: REMARKS, ROUTE: ROUTE, GENERICID: GENERICID, GENERICNAME: GENERICNAM, DRUGCD: DRUGCD, SOSYN: SOSYN, DURATION: DURATION, ABFOOD: ABFOOD, INTAKEDESC: INTAKEDESC, INTAKECD: "", DVOL: DVOL, ADUR: ADUR, DIL: DIL, SDATE: SDATE };
                            });

                            var servData = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC == "" || e.INTAKEDESC == "--select--") });
                            var servicedt = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC != "" || e.INTAKEDESC != "--select--") });
                            var ServiceData = (JSON.stringify(servicedt));

                            if (servData.length > 0) {
                                $.alert('Please select intake for all medicines');
                                return false;
                            }
                                //if (ServiceData == "[]") {
                                //    $.alert('Please select intake for at least one medicine');
                                //    return false;
                                //}
                            else {//by vij on 6th dec 2018
                                var emptyDays = $.grep(myDataWithIds, function (e) { return ((e.DAYS == "" || e.DAYS == "--select--") && e.INTAKEDESC != "SOS" && e.INTAKEDESC != "STAT" && e.INTAKEDESC != "CONTD.") });
                                var emptyDuration = $.grep(myDataWithIds, function (e) { return ((e.DURATION == "" || e.DURATION == "--select--") && e.INTAKEDESC != "SOS" && e.INTAKEDESC != "STAT" && e.INTAKEDESC != "CONTD.") });
                                if (emptyDays.length > 0 || emptyDuration.length > 0) {
                                    $.alert('Please select duration for all medicines');
                                    return false;
                                }
                            }
                            //---------------------------------------------

                            //added on 6th march 2019
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil"))
                                strSetUpCode = $(obj).parents("tr")[0].id;

                            if (setUp != "" && ServiceData != "[]") {
                                //$('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").
                                //var senddata = "strMedicineSetUpName=" + setUp + "&&strMedicineLst=" + ServiceData.toString();
                                $.ajax({
                                    type: "post",
                                    dataType: "json",
                                    url: '../DoctorDesk/AddMedicineSetUp',
                                    //data: { strMedicineSetUpName: setUp, strMedicineLst: ServiceData.toString() },
                                    //data: senddata,

                                    data: { strMedicineSetUpName: setUp, strMedicineLst: ServiceData.toString(), strSetUpCode: strSetUpCode, CIMSYN: CIMSYN },  //Meenakshi don't replace this if there is & in genericname it will not work  //strSetUpCode added by vijeta on 6th march 19

                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtSetUp").val("");
                                            $.alert("Record inserted successfully");
                                            GetpersonalisedList();
                                            GetSetUpList("RxNew");//vij 29th oct 2018
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {

                                            $.alert("This Set Up is already Present.");
                                        }
                                        else {
                                            $.alert("Error!!Please Contact IT Dept");
                                        }
                                    },
                                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                                        $.loader.close();
                                        $.messager.alert("Error", errorThrown);
                                    }
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
                    $('.jc-bs3-row').removeClass('row')
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1')
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    $('#txtSetUp').focus();
                    
                   
                    //added ON 6TH mARCH 2019
                    if ($(obj).hasClass("fa fa-pencil")) {
                       // $('#txtSetUp').val($(obj).parents('td')[0].previousSibling.innerText);
                       // $('#txtSetUp').text($(obj).parents('td')[0].previousSibling.innerText);
                        $('#txtSetUp').val($(obj).parents('td').prev().text());
                        $("#dblServiceHelpsrvcgrp").show();
                        $("#divSrvcGrpGrid").show();
                        // $('#divSrvcGrpSelect').show();
                    }

                    else
                        $('#txtSetUp').val("");

                    SerivceGrpData(srvcgrpname)// added by vijeta on 30th april 2018

                    load_Intake();// added by vijeta on 14th may 2018
                    BindSelectedMedicineGrid();// added by vijeta on 14th may 2018
                  
                    //added on 6th march 2019
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectedSetUpsMedi($(obj).parents('tr')[0].id);
                    }
                  
                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                    //$(".jconfirm-box-container").last().css('width', '480px');// added by vijeta on 7/3/19
                }
            });
        }

        //added on 6th march 2019
        function FillSelectedSetUpsMedi(setUpId) {
            $.ajax({
                url: '../DoctorDesk/GetMedListBySetupCode',
                data: { strSetUpCode: setUpId },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {
                        $("#tblGrid").jqGrid('setGridParam', { data: response }).trigger("reloadGrid");

                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            })
        }
        //Save on back button
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './IPMedication');

                $(window).on('popstate', function () {
                    if (stopProp)
                        SaveAllMedicines("Y");
                });

            }
        });


        //vijeta 18th march 19
        function NewIntake(location, obj) {
            $.confirm({
                title: '',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                theme: 'bootstrap',
                content: '' +
                '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">New Intake</label><br>' +
                '<input  type="varchar" id="txtNewIntake"  placeholder="Enter Intake Combination" autofocus="autofocus" class="setUp form-control" required />' +
                '</div>' +

                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                        

                            if ($("#txtNewIntake").val() == "" || $("#txtNewIntake").val() == null) {
                                
                                $('#txtNewIntake').css({ 'border-color': 'Red' });
                                return false;

                            } else {
                                $('#txtNewIntake').css({ 'border-color': '' });
                            }
                            var intake = $("#txtNewIntake").val();
                            $.ajax({
                                url: '../DoctorDesk/saveMedIntkCombintn',
                                type: 'post',
                                datatype: 'json',
                                data: { strMedIntkComb: intake },
                                success: function (response) {

                                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                        $.alert("Intake added successfully", "Information");

                                        ItakesArray.push(intake);//vijeta 30/3/19
                                        var selRowId = $('#tblGrid').jqGrid('getGridParam', 'selrow');
                                        $('#tblGrid').setCell(selRowId, 'INTAKE', intake);
                                        jQuery("#tblGrid").setColProp("INTAKE", {
                                            editoptions: {
                                                value: load_Intake(),
                                            }
                                        }).trigger("reloadGrid");//4/01/19 width chngd
                                        if (location == "Out")//added on 1/4/19
                                        {
                                            obj.currentTarget.previousSibling.value = intake;
                                        }
                                    }
                                    else {
                                        $.alert(response, "Information");
                                    }
                                }
                            });
                        }
                    },
                    Closed: {
                        text: 'Cancel'
                        //close
                    }
                }


            })
        }
        function GetSetUpList(page) {
            var strUrl = "";

            if (page.indexOf("Advice") != -1) {
                strUrl = "../DoctorDesk/GetPersPatientAdviceList";
            }
            else if (page.indexOf("Investigation") != -1) {
                strUrl = "../DoctorDesk/GetPersInvestigationList";
            }
            else if (page.indexOf("RxNew") != -1) {
                strUrl = "../DoctorDesk/GetPersDiseaseList?CIMS=" + CIMSYN;

            }
            else if (page.indexOf("RxDesk") != -1) {
                strUrl = "../DoctorDesk/GetPersDiseaseList?CIMS=" + CIMSYN;

            }


            $.ajax({
                type: "POST",
                url: strUrl,
                data: {},
                asycn: false,
                success: function (response) {
                    $(document).ready(function () {
                        if (response != "Unsucessfull") {
                            var result = JSON.parse(response)
                            var rows = "";
                            for (i = 0; i < result.Table1.length; i++) {
                                rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td class='InvestigationName' style='padding:5px;font-size: 13px;vertical-align:middle' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>";


                                rows += "</tr>";
                            }
                            $('#tblPatAdviceStUps tbody').empty();
                            $('#tblPatAdviceStUps tbody').append(rows).closest('tr');
                        }
                    });

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {

                }
            });
        }
    </script>
</asp:Content>
