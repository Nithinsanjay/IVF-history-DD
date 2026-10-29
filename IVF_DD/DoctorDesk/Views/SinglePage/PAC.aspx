<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SinglePagePAC.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.PACMdl>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="MainDiv">
        <div id="ContentHolderDiv">

            <%--Priyanka 18/02/2026--%>        
           <%-- <div class="row">   
                <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; background-color: #022548; padding: 10px; color: white; gap: 10px;">

                    <div class="d-flex align-items-center justify-content-center" id="PACForm_BackBtnDiv" style="margin-left: 0.5%;">
                        <button class="btn btn-link text-white p-0 btn_Back" id="PACForm_BackBtn">
                            <i class="fa fa-chevron-left"></i>Back
                        </button>
                    </div>--%>
            <%--Abhishesh || 20260506--%>
            <div class="row sticky-top" style="z-index: 999;">
                <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; background-color: #022548; padding: 10px; color: white; gap: 10px; width: 100%;">

                    <div class="d-flex align-items-center justify-content-center" id="PACForm_BackBtnDiv" style="margin-left: 0.5%;">
                        <button class="btn btn-link text-white p-0 btn_Back" id="PACForm_BackBtn">
                            <i class="fa fa-chevron-left"></i>Back
                        </button>
                    </div>
                    <%--End--%>
                    <div style="display: flex; align-items: center; gap: 15px; flex-shrink: 0; ">
                        <label class="MDHeaderLbl" style="width: auto !important; margin-bottom: 0; white-space: nowrap;">Pre-Anesthetic Checkup</label>
                        <label class="switch mb-0" style="display:none;">
                            <input type="checkbox" id="ChkPACYN" checked>
                            <span class="slider"><span class="switch-label">No</span></span>
                        </label>
                    </div>

                    <div id="MainDivTranInfo" style="display: flex; flex-wrap: wrap; gap: 15px;    margin-right: 10px;">
                        <div style="display: flex; align-items: center;">
                            <label style="min-width: 65px; margin-bottom: 0;">Tran No:</label>
                            <input type="text" style="color: black;border-radius: 4px; border: none; background-color: #ffffff;" id="txtPAC" readonly />
                        </div>
                        <div style="display: flex; align-items: center;">
                            <label style="min-width: 80px; margin-bottom: 0;">Tran Date:</label>
                            <input type="text" style="color: black;border-radius: 4px; border: none;background-color: #ffffff;" id="txtPACDate" readonly />
                        </div>
                        <div id="PersMedi" style="display: none; align-items: center">
                            <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;" id="PACInvestigation_Setup" onclick="SetupPopupOpen('PAC Investigation','PACInvestigation',false)">Setup</button>
                        </div>
                        
                        <div id="PACHistory" style="display: none; align-items: center;">
                            <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;" id="BtnPACHistory" onclick="OpenClosePACHistory()">History</button>
                        </div>

                        <div id="PACPrint"  style="align-items: center;display:none;">
                            <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;" id="BtnPACPrint" onclick="HistoryPopupOpen('PAC Print','PACPrint')">Print</button>
                        </div>

                        <div id="PACLogInfo" style="display: none; align-items: center;">
                            <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px; margin-left: 10px;" id="BtnPACLogInfo" onclick="OpenClosePACLogInfo()">Log Info</button>
                        </div>

                    </div>
                </div>
            </div>

            <div class="row" id="divisit">
                <div style="display: flex;align-items: center;justify-content: space-between;padding: 5px 0px;color: white;background: azure;justify-content: flex-end;">
                    <div class="HeaderBtnIcon" style="display: flex; flex-wrap: wrap;">
                        <div style="display: flex;">
                            <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;" id="previousPrep">DICOM</button>
                        </div>
                         <div style="display: flex;"> <%--Priyanka 20/11/2025--%>
                            <button type="button" class="btn btn-success" style="padding: 3px 10px; margin-right: 10px;" id="CancerCareHist">Cancer Care History</button>
                        </div>
                        <div style="display: flex;">
                            <button type="button" class="btn btn-success" style="padding: 3px 10px; margin-right: 10px;" id="InvestRpt">Invest. Report</button>
                        </div>
                        <div id="PrintDiv_Top" style="display: none; align-items: center;">
                            <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;" id="BtnPrint_Top" onclick="PrintPAC('Y')">Print</button>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Patient Info --%>
            <div id="MainDivPatInfo">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('PatInfoUp', 'PatInfoDown', 'DivContentPatInfo')">Patient Info 
                        <span id="SpanInvstNotifi" style="display: none;">
                            <label id="LblInvstNotifi" style="display: none; color: black; width: auto; animation: 1s step-end 0s infinite normal none running blink; background: rgb(251, 244, 44); padding: 5px; font-weight: bold !important; display: inline-block;"></label>
                        </span>
                    </label>
                    <div class="ArrowDiv">
                        <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px; display: none;" id="BtnPACCopyAll" onclick="">Copy All</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="PatInfoDown" onclick="ToggleDiv(this.id,'PatInfoUp','DivContentPatInfo','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="PatInfoUp" onclick="ToggleDiv(this.id,'PatInfoDown','DivContentPatInfo','N')" style="display: none" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentPatInfo">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">MR No.</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACMRNO" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Patient Name</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACPatName" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Age</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACPatAge" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Gender</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACPatGen" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Admitting Doctor</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACAdmDoct" readonly />
                                    <input type="text" class="form-control" id="txtPACAdmDoctCode" style="display: none" readonly />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Weight</label>
                                <div class="col-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" maxlength="5" class="form-control" id="txtPACWeight" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">Kg</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Height</label>
                                <div class="col-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" maxlength="5" class="form-control" id="txtPACHeight" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">Cm</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">BMI</label>
                                <div class="col-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" maxlength="5" class="form-control" id="txtPACBMI" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" readonly />
                                    <span class="MeasureInd">kg/(m²)</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Advice Surgery --%>
            <div id="MainDivADVSURG">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('ADVSURGUp', 'ADVSURGDown', 'DivContentADVSURG')">Advised Surgery and Diagnosis</label>
                    <div class="ArrowDiv">
                        <i class="fa fa-chevron-circle-down DownArrow" id="ADVSURGDown" onclick="ToggleDiv(this.id,'ADVSURGUp','DivContentADVSURG','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="ADVSURGUp" onclick="ToggleDiv(this.id,'ADVSURGDown','DivContentADVSURG','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentADVSURG">
                    <div class="row EachRow">
                      <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Surgery Planned</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtPACProcdPlanCode" readonly style="display: none" />
                                    
                                    <textarea class="form-control" style="resize: none" id="txtPACProcdPlan" onchange="autoResize(this.id)" readonly></textarea>
                                </div>
                            </div>
                        </div>


                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Scheduled Date of Surgery</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtPACSchSurg" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Nature of Surgery</label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="PACNATSURG" id="rbtnPACNATSURGR" disabled />
                                        <label for="rbtnPACNATSURGR" class="RadioLbl">Elective</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="PACNATSURG" id="rbtnPACNATSURGE" disabled />
                                        <label for="rbtnPACNATSURGE" class="RadioLbl">Emergency</label>
                                    </div>
                                    <div class="RadioDiv" style="display: none">
                                        <input type="radio" name="PACNATSURG" id="rbtnPACNATSURGT" disabled />
                                        <label for="rbtnPACNATSURGT" class="RadioLbl">Tentative</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--priyanka 18/02/2026--%>
                        <div class="col-12 DivAdvisedSurgeryTables">
                            <fieldset style="background-color: white; padding-bottom: 10px;">
                                <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">ICD Diagnosis</legend>
                                <div class="MedicineDiv table-responsive" style="width: 100%; max-height: 150px; overflow: auto;">
                                    <table id="TableICD" class="MedicineTbl" style="width: 100%; min-width: 500px;">
                                        <thead>
                                            <tr style="position: relative; top: 0;">
                                                <th style="width: 150px">Code</th>
                                                <th>Description</th>
                                            </tr>
                                        </thead>
                                        <tbody id="TableICDTBody">
                                        </tbody>
                                    </table>
                                </div>
                            </fieldset>
                        </div>

                        <div class="col-12 DivAdvisedSurgeryTables">
                            <fieldset style="background-color: white; padding-bottom: 10px;">
                                <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">ICD-O Diagnosis</legend>
                                <div class="MedicineDiv table-responsive" style="width: 100%">
                                    <table id="TableICDO" class="MedicineTbl">
                                        <thead>
                                            <tr>
                                                <th style="width: 150px">Code</th>
                                                <th style="width: 250px">Topography Name</th>
                                                <th>Histology Description</th>
                                                <th id="TH_TNMICDO" style="width: 150px">TNM</th>
                                            </tr>
                                        </thead>
                                        <tbody id="TableICDOTBody"></tbody>
                                    </table>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>

                        <%-- Patient Vital Signs and Measurements --%>
            <div id="MainDivPVSM">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('PVSMUp', 'PVSMDown', 'DivContentPVSM')">Patient Vital Signs and Measurements</label>
                    <div class="ArrowDiv">
                        <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;display:none;" id="btnCopyPatientVital" onclick="">Copy</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="PVSMDown" onclick="ToggleDiv(this.id,'PVSMUp','DivContentPVSM','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="PVSMUp" onclick="ToggleDiv(this.id,'PVSMDown','DivContentPVSM','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentPVSM">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Date</label>
                                <div class="col-8 FieldDiv" style="justify-content: space-between;flex-wrap: nowrap;align-items: center;">
                                    <input type="text" class="form-control" id="txtPVSMDate" onchange="MakeNormal(this.id);" style="width: 120px;" readonly />
                                    <span style="font-weight:900">-</span>
                                    <input type="time" id="txtPVSMTime" class="form-control" style="width: 105px;padding: 5px;" onchange="MakeNormal(this.id);" />
<%--                                    <input type="text" class="form-control" id="txtPVSMTime" onchange="MakeNormal(this.id);" style="width: 100px;" readonly />--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Temp</label>
                                <div class="col-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="form-control" maxlength="4" id="txtPVSMTemp" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">°F</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Pulse</label>
                                <div class="col-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="form-control" id="txtPVSMPulse" maxlength="3" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">bpm</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Blood Pressure</label>
                                <div class="col-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="triggerInputBP form-control input-form-control form-control" style="min-width: 55px;" id="txtPVSMBldPrs1" onchange="MakeNormal(this.id);" />
                                    <label style="margin: 0px 10px !important; font-size: 25px; font-weight: bold;">/</label>
                                    <input type="text" class="triggerInputBP form-control input-form-control form-control" style="min-width: 55px;" id="txtPVSMBldPrs2" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd" style="border-radius: 5px; margin-left: 5px;">mmHg</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">SpO2</label>
                                <div class="col-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="form-control" id="txtPVSMSPO" maxlength="3" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">%</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Breath Holding Time</label>
                                <div class="col-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="form-control" id="txtPVSMBrthTime" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">SEC</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12" style="">
                            <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888;">
                                <div style="font-size: 14px;" class="panel-heading divHeads">
                                    Pain Score
                                </div>
                                <div class="Tablewrapper" style="font-size: 12px; background: white;">
                                    <table id="tblPainScore" style="font-size: 11px; width: auto;">
                                        <tbody style="text-align: center;">
                                            <tr>
                                                <td>
                                                    <label class="input-form-label" for="0PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/0pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="1PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/1pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="2PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/2pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="3PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/3pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="4PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/4pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="5PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/5pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="6PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/6pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="7PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/7pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="8PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/8pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="9PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/9pain.png"></label></td>
                                                <td>
                                                    <label class="input-form-label" for="10PainRadio" style="padding-left: 0px !important;">
                                                        <img src="../Images/PainSmiley/10pain.png"></label></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input type="radio" style="display: none;" value="0" name="radio-pain" id="0PainRadio"><label for="0PainRadio" class="painlbl">0<br>
                                                        No Pain </label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="1" name="radio-pain" id="1PainRadio"><label for="1PainRadio" class="input-form-label painlbl">1<br>
                                                        Very Mild</label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="2" name="radio-pain" id="2PainRadio"><label for="2PainRadio" class="input-form-label painlbl">2<br>
                                                        Hurts Little Bit</label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="3" name="radio-pain" id="3PainRadio"><label for="3PainRadio" class="input-form-label painlbl">3<br>
                                                        Tolerable</label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="4" name="radio-pain" id="4PainRadio"><label for="4PainRadio" class="input-form-label painlbl">4<br>
                                                        Hurts Little More</label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="5" name="radio-pain" id="5PainRadio"><label for="5PainRadio" class="input-form-label painlbl">5<br>
                                                        Very Distressing</label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="6" name="radio-pain" id="6PainRadio"><label for="6PainRadio" class="painlbl input-form-label">6<br>
                                                        Hurts Even More</label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="7" name="radio-pain" id="7PainRadio"><label for="7PainRadio" class="input-form-label painlbl">7<br>
                                                        Very Intense</label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="8" name="radio-pain" id="8PainRadio"><label for="8PainRadio" class="input-form-label painlbl">8<br>
                                                        Hurts Whole Lot</label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="9" name="radio-pain" id="9PainRadio"><label for="9PainRadio" class="input-form-label painlbl">9<br>
                                                        Unbearable</label></td>
                                                <td>
                                                    <input type="radio" style="display: none;" value="10" name="radio-pain" id="10PainRadio"><label for="10PainRadio" class="input-form-label painlbl">10<br>
                                                        Hurts Worst</label></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="col-12" style="">
                            <div class="ContentFieldDiv" style="justify-content: center;">
                                <button type="button" class="btn btn-primary" id="BtnVitalsAdd" onclick="ValidationForAddVitalsTable('N')">Add</button>
                                <button type="button" class="btn btn-primary" style="display: none;" id="BtnVitalsUpdate" onclick="ValidationForAddVitalsTable('E')">Update</button>
                                <button type="button" class="btn btn-primary" style="margin-left: 20px; display: none;" id="BtnVitalsClear" onclick="CleartPatVitalMsrmntInfo()">Clear</button>
                            </div>
                        </div>

                        <div class="col-12" style="">
                            <input type="text" id="txtSelRowId" style="display: none" />
                            <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888;">
                                <div class="Tablewrapper" style="font-size: 12px; background: white;">
                                    <table id="tblPatVitalMsrmnts">
                                        <thead>
                                            <tr>
                                                <th>Action</th>
                                                <th style="min-width: 100px;">Date - Time</th>
                                                <th>Temp(°F)</th>
                                                <th>Pulse(bpm)</th>
                                                <th>Blood Pressure(mmHg)</th>
                                                <th>SpO2(%)</th>
                                                <th>Pain Score</th>
                                                <th style="display: none">Pain Score Code</th>
                                                <th>Breath Holding Time(SEC)</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblPatVitalMsrmntsBody">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- General Physical Examination --%>
            <div id="MainDivGPE">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('GPEUp', 'GPEDown', 'DivContentGPE')">General Physical Examination</label>
                    <div class="ArrowDiv">
                     <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;display:none;" id="btnGPECopy">Copy</button>
                       
                        <i class="fa fa-chevron-circle-down DownArrow" id="GPEDown" onclick="ToggleDiv(this.id,'GPEUp','DivContentGPE','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="GPEUp" onclick="ToggleDiv(this.id,'GPEDown','DivContentGPE','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentGPE">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">General Condition <span style="color:red;font-weight: bolder;">*</span>  </label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="GPEGENCOND" id="rbtnGPEGENCOND1" />
                                        <label for="rbtnGPEGENCOND1" class="RadioLbl">Good</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="GPEGENCOND" id="rbtnGPEGENCOND2" />
                                        <label for="rbtnGPEGENCOND2" class="RadioLbl">Fair</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="GPEGENCOND" id="rbtnGPEGENCOND3" />
                                        <label for="rbtnGPEGENCOND3" class="RadioLbl">Poor</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Breathing Pattern <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTBRETPATTRM" id="rbtnCPTBRETPATTRM1" />
                                        <label for="rbtnCPTBRETPATTRM1" class="RadioLbl">Normal</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTBRETPATTRM" id="rbtnCPTBRETPATTRM2" />
                                        <label for="rbtnCPTBRETPATTRM2" class="RadioLbl">Tachypnoea</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTBRETPATTRM" id="rbtnCPTBRETPATTRM3" />
                                        <label for="rbtnCPTBRETPATTRM3" class="RadioLbl">Bradypnoea</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTBRETPATTRM" id="rbtnCPTBRETPATTRM4" />
                                        <label for="rbtnCPTBRETPATTRM4" class="RadioLbl">Obstructed</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style=" display: none">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Breathing Remark</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtGPEBreathRemark" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Respiratory Rate(BPM)</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtGPERR" onchange="MakeNormal(this.id);CheckNotif('txtGPERR',10,30,true);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Orientation <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTORT" id="rbtnCPTORT1" />
                                        <label for="rbtnCPTORT1" class="RadioLbl">Normal</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTORT" id="rbtnCPTORT2" />
                                        <label for="rbtnCPTORT2" class="RadioLbl">Confused</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTORT" id="rbtnCPTORT3" />
                                        <label for="rbtnCPTORT3" class="RadioLbl">Very Poor</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTORT" id="rbtnCPTORT4" />
                                        <label for="rbtnCPTORT4" class="RadioLbl">Agitated</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Pallor</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEPALL" onclick="EnDisChkTextbox(this.id, 'txtCPTPallor')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTPallor" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Icterus</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEICET" onclick="EnDisChkTextbox(this.id, 'txtCPTIcterus')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTIcterus" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Cyanosis</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPECYAN" onclick="EnDisChkTextbox(this.id, 'txtCPTCyanosis')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTCyanosis" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Clubbing</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPECLUB" onclick="EnDisChkTextbox(this.id, 'txtCPTClubbing')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTClubbing" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Lymphadenopathy</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPELYMP" onclick="EnDisChkTextbox(this.id, 'txtCPTLymphadenopathy')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" class="form-control ml-2" id="txtCPTLymphadenopathy" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Pedal EDEMA</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEEDEMA" onclick="EnDisChkTextbox(this.id, 'txtCPTPedalEDEMA')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" class="form-control ml-2" id="txtCPTPedalEDEMA" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Hydration Status</label>
                                <div class="col-8 FieldDiv">
                                    <select id="cmbCPTHydrationStatus" class="form-control" onchange="EnDisTextCombo('cmbCPTHydrationStatus','txtHydraStatusOther')">
                                        <option value="">---Select---</option>
                                        <option value="W">Well hydrated</option>
                                        <option value="D">Dehydrated</option>
                                        <option value="O">Other</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Hydration Status Other</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtHydraStatusOther" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Venous Access</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEVENACC" onclick="EnDisChkTextbox(this.id, 'txtCPTVenousAccess')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTVenousAccess" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">METS <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTMETS" id="rbtnCPTMETS1" />
                                        <label for="rbtnCPTMETS1" class="RadioLbl">Less than 4</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTMETS" id="rbtnCPTMETS2" />
                                        <label for="rbtnCPTMETS2" class="RadioLbl">4-7</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTMETS" id="rbtnCPTMETS3" />
                                        <label for="rbtnCPTMETS3" class="RadioLbl">7-10</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTMETS" id="rbtnCPTMETS4" />
                                        <label for="rbtnCPTMETS4" class="RadioLbl">More than 10</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Functional Capacity <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTFUNCCAP" id="rbtnCPTFUNCCAP1" />
                                        <label for="rbtnCPTFUNCCAP1" class="RadioLbl">Poor</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTFUNCCAP" id="rbtnCPTFUNCCAP2" />
                                        <label for="rbtnCPTFUNCCAP2" class="RadioLbl">Moderate</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTFUNCCAP" id="rbtnCPTFUNCCAP3" />
                                        <label for="rbtnCPTFUNCCAP3" class="RadioLbl">Good</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTFUNCCAP" id="rbtnCPTFUNCCAP4" />
                                        <label for="rbtnCPTFUNCCAP4" class="RadioLbl">Excellent</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">LRTI</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPELRTI" onclick="EnDisChkTextbox(this.id, 'txtCPTLRTI')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" class="form-control ml-2" id="txtCPTLRTI" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" maxlength="100"  />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">URTI</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEURTI" onclick="EnDisChkTextbox(this.id, 'txtCPTURTI')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTURTI" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Fever</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEFEVER" onclick="EnDisChkTextbox(this.id, 'txtCPTFever')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTFever" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Pre-Anaesthesia Evaluation History</label>
                                <div class="col-8 FieldDiv d-flex">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEPREANAHIST" onclick="EnDisChkTextbox(this.id, 'txtCPTPREANAEVALHIST')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <textarea maxlength="100" class="form-control ml-2" style="flex: 1; margin-left: 5px; resize: none;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtCPTPREANAEVALHIST"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Comorbidities & Treatment History --%>
            <div id="MainDivCTH">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('CTHUp', 'CTHDown', 'DivContentCTH')">Comorbidities & Treatment History</label>
                    <div class="ArrowDiv">
                         <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;display:none;" id="btnCTHCopy">Copy</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="CTHDown" onclick="ToggleDiv(this.id,'CTHUp','DivContentCTH','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="CTHUp" onclick="ToggleDiv(this.id,'CTHDown','DivContentCTH','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentCTH">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Hypertension</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHHYP" onclick="EnDisChkTextbox(this.id, 'txtCTHHypert')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHHypert" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Diabetes Mellitus</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHDIABMEL" onclick="EnDisChkTextbox(this.id, 'txtCTHDiabMelt')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHDiabMelt" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">NYHA</label>
                                <div class="col-8 FieldDiv style="margin-top: 10px;"">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHNYHA" id="rbtnCTHNYHA1" />
                                        <label for="rbtnCTHNYHA1" class="RadioLbl">I</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHNYHA" id="rbtnCTHNYHA2" />
                                        <label for="rbtnCTHNYHA2" class="RadioLbl">II</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHNYHA" id="rbtnCTHNYHA3" />
                                        <label for="rbtnCTHNYHA3" class="RadioLbl">III</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHNYHA" id="rbtnCTHNYHA4" />
                                        <label for="rbtnCTHNYHA4" class="RadioLbl">IV</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                     
                    
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">ECOG
                                    <i class="fa fa-question-circle InfoIconPopup" title="ARISCAT Information" onclick="OpenPopInfoGuide('E')" aria-hidden="true"></i>
                                </label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHECOG" id="rbtnCTHECOG0" />
                                        <label for="rbtnCTHECOG0" class="RadioLbl">0</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHECOG" id="rbtnCTHECOG1" />
                                        <label for="rbtnCTHECOG1" class="RadioLbl">1</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHECOG" id="rbtnCTHECOG2" />
                                        <label for="rbtnCTHECOG2" class="RadioLbl">2</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHECOG" id="rbtnCTHECOG3" />
                                        <label for="rbtnCTHECOG3" class="RadioLbl">3</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHECOG" id="rbtnCTHECOG4" />
                                        <label for="rbtnCTHECOG4" class="RadioLbl">4</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHECOG" id="rbtnCTHECOG5" />
                                        <label for="rbtnCTHECOG5" class="RadioLbl">5</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">MMRC</label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHMMRC" id="rbtnCTHMMRC0" />
                                        <label for="rbtnCTHMMRC0" class="RadioLbl">0</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHMMRC" id="rbtnCTHMMRC1" />
                                        <label for="rbtnCTHMMRC1" class="RadioLbl">1</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHMMRC" id="rbtnCTHMMRC2" />
                                        <label for="rbtnCTHMMRC2" class="RadioLbl">2</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHMMRC" id="rbtnCTHMMRC3" />
                                        <label for="rbtnCTHMMRC3" class="RadioLbl">3</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHMMRC" id="rbtnCTHMMRC4" />
                                        <label for="rbtnCTHMMRC4" class="RadioLbl">4</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row EachRow">
                        <%--Cardiac System--%>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <div class="col-8" style="flex:1;padding-right:10px">
                                    <fieldset class="CardiacFieldSet">
                                        <legend class="CardiacFieldSetLegend">Cardiac System</legend>
                                        <div class="">
                                            <div class="CheckboxDiv" style="display: flex; align-items: center; white-space: nowrap;">
                                                <input type="checkbox" id="chkIHD" onclick="toggleRemark('chkIHD', 'txtIHD')" Style="width:30px;"  />
                                                <label for="chkIHD" style="margin-left: 5px; margin-bottom: 0;">IHD</label>
                                            </div>
                                            <input type="text" id="txtIHD" class="form-control" placeholder="Enter Remark"
                                                style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />
                                            <div class="CheckboxDiv" style="display: flex; align-items: center; white-space: nowrap;">
                                                <input type="checkbox" id="chkCHF" onclick="toggleRemark('chkCHF', 'txtCHF')" Style="width:30px;" />
                                                <label for="chkCHF" style="margin-left: 5px; margin-bottom: 0;">CHF</label>
                                            </div>
                                            <input type="text" id="txtCHF" class="form-control" placeholder="Enter Remark"
                                                style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />
                                            <div class="CheckboxDiv" style="display: flex; align-items: center; white-space: nowrap;">
                                                <input type="checkbox" id="chkRHD" onclick="toggleRemark('chkRHD', 'txtRHD')" Style="width:30px;" />
                                                <label for="chkRHD" style="margin-left: 5px; margin-bottom: 0;">RHD</label>
                                            </div>
                                            <input type="text" id="txtRHD" class="form-control" placeholder="Enter Remark"
                                                style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />
                                            <div class="CheckboxDiv" style="display: flex; align-items: center; white-space: nowrap;">
                                                <input type="checkbox" id="chkOther" onclick="toggleRemark('chkOther', 'txtOther')" Style="width:30px;" />
                                                <label for="chkOther" style="margin-left: 5px; margin-bottom: 0;">Other</label>
                                            </div>
                                            <input type="text" id="txtOther" class="form-control" placeholder="Enter Remark"
                                                style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);" />
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>

                        <%--Nervous System--%>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <div class="col-8" style="flex:1;padding-right:10px">
                                    <fieldset class="CardiacFieldSet">
                                        <legend class="CardiacFieldSetLegend">Nervous System</legend>
                                        <div class="">
                                            <div class="CheckboxDiv">
                                                <input type="checkbox" id="chkEpilepsy" onclick="toggleRemark('chkEpilepsy', 'txtEpilepsy')" Style="width:30px;" />
                                                <label for="chkEpilepsy">Epilepsy</label>
                                            </div>
                                            <input type="text" id="txtEpilepsy" class="form-control" placeholder="Enter Remark" 
                                                style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />

                                            <div class="CheckboxDiv">
                                                <input type="checkbox" id="chkStroke" onclick="toggleRemark('chkStroke', 'txtStroke')" Style="width:30px;" />
                                                <label for="chkStroke">Stroke</label>
                                            </div>
                                            <input type="text" id="txtStroke" class="form-control" placeholder="Enter Remark" 
                                                style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />

                                            <div class="CheckboxDiv">
                                                <input type="checkbox" id="chkNOthers" onclick="toggleRemark('chkNOthers', 'txtNOthers')" Style="width:30px;" />
                                                <label for="chkNOthers">Others</label>
                                            </div>
                                            <input type="text" id="txtNOthers" class="form-control" placeholder="Enter Remark" 
                                               style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />

                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>

                        <%--Respiratory System--%>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <div class="col-8" style="flex: 1; padding-right: 10px">
                                    <fieldset class="CardiacFieldSet">
                                        <legend class="CardiacFieldSetLegend">Respiratory</legend>
                                        <div class="CheckboxDiv">
                                            <input type="checkbox" id="chkASTHMA" onclick="toggleRemark('chkASTHMA', 'txtASTHMA')" style="width: 30px;" />
                                            <label for="chkASTHMA">ASTHMA</label>
                                        </div>
                                        <input type="text" id="txtASTHMA" class="form-control" placeholder="Enter Remark" 
                                          style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;"onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);" />

                                        <div class="CheckboxDiv">
                                            <input type="checkbox" id="chkTB" onclick="toggleRemark('chkTB', 'txtTB')" style="width: 30px;" />
                                            <label for="chkTB">TB</label>
                                        </div>
                                        <input type="text" id="txtTB" class="form-control" placeholder="Enter Remark" 
                                            style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;"onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />

                                        <div class="CheckboxDiv">
                                            <input type="checkbox" id="chkCOPD" onclick="toggleRemark('chkCOPD', 'txtCOPD')" style="width: 30px;" />
                                            <label for="chkCOPD">COPD</label>
                                        </div>
                                        <input type="text" id="txtCOPD" class="form-control" placeholder="Enter Remark" 
                                            style="display: none;height: 30px;padding: 2px 8px;font-size: 12px;margin-left: 25px;width: 96%;margin-top: 5px;"onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                        
                    </div>

                   <%--Renal--%>
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <div class="col-8" style="flex: 1; padding-right: 10px">
                                    <fieldset class="CardiacFieldSet">
                                        <legend class="CardiacFieldSetLegend">Renal</legend>
                                        <div class="CheckboxDiv">
                                            <input type="checkbox" id="chkAKI" onclick="toggleRemark('chkAKI', 'txtAKI')" style="width: 30px;" />
                                            <label for="chkAKI">AKI</label>
                                        </div>
                                        <input type="text" id="txtAKI" class="form-control" placeholder="Enter Remark"
                                            style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;"onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />
                                        
                                        <div class="CheckboxDiv">
                                            <input type="checkbox" id="chkCKD" onclick="toggleRemark('chkCKD', 'txtCKD')" style="width: 30px;" />
                                            <label for="chkCKD">CKD</label>
                                        </div>
                                        <input type="text" id="txtCKD" class="form-control" placeholder="Enter Remark"
                                            style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;"onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />
                                        <div class="CheckboxDiv">
                                            <input type="checkbox" id="chkROthers" onclick="toggleRemark('chkROthers', 'txtROthers')" style="width: 30px;" />
                                            <label for="chkROthers">Other</label>
                                        </div>
                                        <input type="text" id="txtROthers" class="form-control" placeholder="Enter Remark"
                                            style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />
                                    </fieldset>
                                </div>
                            </div>
                        </div>

                        <%--Blood Related--%>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                             <div class="ContentFieldDiv">
                                  <div class="col-8" style="flex: 1; padding-right: 10px">
                                      <fieldset class="CardiacFieldSet">
                                          <legend class="CardiacFieldSetLegend">Blood Related</legend>
                                          <div class="CheckboxDiv">
                                              <input type="checkbox" id="chkAnaemia" onclick="toggleRemark('chkAnaemia', 'txtAnaemia')" style="width:30px;" />
                                              <label for="chkAnaemia">Anaemia</label>
                                          </div>
                                          <input type="text" id="txtAnaemia" class="form-control" placeholder="Enter Remark" 
                                              style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);"  />

                                          <div class="CheckboxDiv">
                                              <input type="checkbox" id="chkTrasDis" onclick="toggleRemark('chkTrasDis', 'txtTransDisorder')" style="width:30px;"  />
                                              <label for="chkTrasDis">H/o Transfusion / Disorders</label>
                                          </div>
                                          <input type="text" id="txtTransDisorder" class="form-control" placeholder="Enter Remark" 
                                              style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;" onkeypress="MakeNormal(this.id)"; onchange="MakeNormal(this.id);" />
                                      </fieldset>
                                  </div>
                             </div>
                        </div>


                    </div>
                    <div class="row EachRow">
                         <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Thyroid Disorder</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHTHYDIS" onclick="EnDisChkTextbox(this.id, 'txtCTHThyroidDis')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHThyroidDis" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Chemotherapy</label>
                                <div class="col-8 FieldDiv d-flex">  <%--style="align-items: center;"--%>
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHCHEMO" onclick="EnDisChkTextbox(this.id, 'txtCTHChemotherapy')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <textarea maxlength="100" class="form-control ml-2" id="txtCTHChemotherapy" style="resize:none; flex: 1; margin-left: 5px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);"></textarea> <%-- onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);"--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Radiotherapy</label>
                                <div class="col-8 FieldDiv d-flex">   <%--style="align-items: center;"--%>
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHRADIO" onclick="EnDisChkTextbox(this.id, 'txtCTHRadiotherapy')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <textarea maxlength="100" class="form-control ml-2" id="txtCTHRadiotherapy" style="resize:none; flex: 1; margin-left: 5px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);"></textarea>  <%-- onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Any H/O Surgeries</label>
                                <div class="col-8 FieldDiv d-flex">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHANYSURG" onclick="EnDisChkTextbox(this.id, 'txtCTHAnyHOSurg')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1; margin-left: 5px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtCTHAnyHOSurg"></textarea>
                                </div>
                            </div>
                        </div>

                       
                       
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Drug Allergies</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkDrugAlleg" onclick="EnDisChkTextbox(this.id, 'txtDrugAlleg')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtDrugAlleg" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Snake Bite</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHBITE" onclick="EnDisChkTextbox(this.id, 'txtCTHBite')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHBite" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Scorpion Sting Bite</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkSTRINGBITE" onclick="EnDisChkTextbox(this.id, 'txtSTRINGBite')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtSTRINGBite" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>

                         <div class="col-12 col-md-12 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Any Other Relevant Medical History</label>
                                <div class="col-8 FieldDiv d-flex">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHANYRELHIST" onclick="EnDisChkTextbox(this.id, 'txtCTHRelMedHist')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1; margin-left: 5px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtCTHRelMedHist"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-12" style=" margin-left: -12px;" >
                            <div class="ContentFieldDiv">
                                <div class="col-12 FieldDiv">
                                    <fieldset class="InvstFieldSet">
                                        <legend class="InvstFieldSetLegend">Obesity(<b>STOP BANG</b> Questionnaire) - <span id="lblObesity" style="font-weight: bold;">0 </span></legend>
                                        <input type="text" id="txtObesity" style="display: none" />
                                        <div class="AdviListMainDiv">
                                            <div class="RadioDiv">
                                                <input type="checkbox" name="CTHOBESITY" id="rbtnCTHOBESITY1" onclick="CalcObesity()" />
                                                <label for="rbtnCTHOBESITY1" class="RadioLbl"><b style="text-decoration: underline; font-weight: 900;">S</b>noring</label>
                                            </div>
                                            <div class="RadioDiv">
                                                <input type="checkbox" name="CTHOBESITY" id="rbtnCTHOBESITY2" onclick="CalcObesity()" />
                                                <label for="rbtnCTHOBESITY2" class="RadioLbl"><b style="text-decoration: underline; font-weight: 900;">T</b>iredness</label>
                                            </div>
                                            <div class="RadioDiv">
                                                <input type="checkbox" name="CTHOBESITY" id="rbtnCTHOBESITY3" onclick="CalcObesity()" />
                                                <label for="rbtnCTHOBESITY3" class="RadioLbl"><b style="text-decoration: underline; font-weight: 900;">O</b>bserved Apnoea</label>
                                            </div>
                                            <div class="RadioDiv">
                                                <input type="checkbox" name="CTHOBESITY" id="rbtnCTHOBESITY4" onclick="CalcObesity()" />
                                                <label for="rbtnCTHOBESITY4" class="RadioLbl">High Blood <b style="text-decoration: underline; font-weight: 900;">P</b>ressure</label>
                                            </div>
                                            <div class="RadioDiv">
                                                <input type="checkbox" name="CTHOBESITY" id="rbtnCTHOBESITY5" onclick="CalcObesity()" />
                                                <label for="rbtnCTHOBESITY5" class="RadioLbl"><b style="text-decoration: underline; font-weight: 900;">B</b>MI > 35Kg/m2</label>
                                            </div>
                                            <div class="RadioDiv">
                                                <input type="checkbox" name="CTHOBESITY" id="rbtnCTHOBESITY6" onclick="CalcObesity()" />
                                                <label for="rbtnCTHOBESITY6" class="RadioLbl"><b style="text-decoration: underline; font-weight: 900;">A</b>ge > 50yrs</label>
                                            </div>
                                            <div class="RadioDiv">
                                                <input type="checkbox" name="CTHOBESITY" id="rbtnCTHOBESITY7" onclick="CalcObesity()" />
                                                <label for="rbtnCTHOBESITY7" class="RadioLbl"><b style="text-decoration: underline; font-weight: 900;">N</b>eck Circumference > 40cm</label>
                                            </div>
                                            <div class="RadioDiv">
                                                <input type="checkbox" name="CTHOBESITY" id="rbtnCTHOBESITY8" onclick="CalcObesity()" />
                                                <label for="rbtnCTHOBESITY8" class="RadioLbl">Male <b style="text-decoration: underline; font-weight: 900;">G</b>ender</label>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Substance Abuse History --%>
            <div id="MainDivSAH">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('SAHUp', 'SAHDown', 'DivContentSAH')">Substance Abuse History <span style="color:red;font-weight: bolder;">*</span></label>
                    <div class="ArrowDiv">
                        <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;display:none;" id="btnSAHCopy">Copy</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="SAHDown" onclick="ToggleDiv(this.id,'SAHUp','DivContentSAH','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="SAHUp" onclick="ToggleDiv(this.id,'SAHDown','DivContentSAH','N')" aria-hidden="true"></i>
                    </div>
                </div>
                 <div class="MainDivContent" id="DivContentSAH">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Drugs</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkSAHDrugs" onclick="EnDisChkTextbox(this.id, 'txtSAHDrugs')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtSAHDrugs" style="flex: 1; margin-left: 5px;" readonly onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)";  />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Alcohol</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkSAHAlcohol" onclick="EnDisChkTextbox(this.id, 'txtSAHAlcohol')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtSAHAlcohol" style="flex: 1; margin-left: 5px;" readonly onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)";  />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Betal Nut</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkSAHBetalNut" onclick="EnDisChkTextbox(this.id, 'txtSAHBetalNut')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtSAHBetalNut" style="flex: 1; margin-left: 5px;" readonly onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)";  />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Tobacco</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkSAHTobacco" onclick="EnDisChkTextbox(this.id, 'txtSAHTobacco')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtSAHTobacco" style="flex: 1; margin-left: 5px;" readonly onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)";  />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Smoking</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkSAHSmoking" onclick="EnDisChkTextbox(this.id, 'txtSAHSmoking')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtSAHSmoking" style="flex: 1; margin-left: 5px;" readonly onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)";  />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Airway Assesment --%>
            <div id="MainDivAA">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('AAUp', 'AADown', 'DivContentAA')">Airway Assessment</label>
                    <div class="ArrowDiv">
                        <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;display:none;" id="btnAirAssmt">Copy</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="AADown" onclick="ToggleDiv(this.id,'AAUp','DivContentAA','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="AAUp" onclick="ToggleDiv(this.id,'AADown','DivContentAA','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentAA">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">NARES <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="AANARES" id="rbtnAANARES1" />
                                        <label for="rbtnAANARES1" class="RadioLbl">Normal</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AANARES" id="rbtnAANARES2" />
                                        <label for="rbtnAANARES2" class="RadioLbl">Abnormal</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Deviated Nasal Septum <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="AANASALSEP" id="rbtnAANASALSEP1" />
                                        <label for="rbtnAANASALSEP1" class="RadioLbl">Normal</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AANASALSEP" id="rbtnAANASALSEP2" />
                                        <label for="rbtnAANASALSEP2" class="RadioLbl">Left</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AANASALSEP" id="rbtnAANASALSEP3" />
                                        <label for="rbtnAANASALSEP3" class="RadioLbl">Right</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AANASALSEP" id="rbtnAANASALSEP4" />
                                        <label for="rbtnAANASALSEP4" class="RadioLbl">Post Surgical</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Mouth Opening <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAMOUTHOPN" id="rbtnAAMOUTHOPN1" />
                                        <label for="rbtnAAMOUTHOPN1" class="RadioLbl"><3cm</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAMOUTHOPN" id="rbtnAAMOUTHOPN2" />
                                        <label for="rbtnAAMOUTHOPN2" class="RadioLbl">3-4cm</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAMOUTHOPN" id="rbtnAAMOUTHOPN3" />
                                        <label for="rbtnAAMOUTHOPN3" class="RadioLbl">> 4cm</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row EachRow">
                        <%-- Teeth --%>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <div class="col-8" style="flex: 1; padding-right: 10px">
                                    <fieldset class="CardiacFieldSet">
                                        <legend class="CardiacFieldSetLegend">Teeth</legend>
                                        <div class="">
                                            <div class="CheckboxDiv">
                                                <%--<input type="checkbox" id="chkNormal" name="AATEETH" onclick="toggleRemark('chkNormal', 'txtNormal')" style="width: 30px;" />--%>
                                                <input type="checkbox" id="chkNormal" name="AATEETH" style="width: 30px;" />
                                                <label for="chkNormal">Normal</label>
                                            </div>
                                            <input type="text" id="txtNormal" class="form-control" placeholder="Enter Remark"
                                                style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;" onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)"; />

                                            <div class="CheckboxDiv">
                                                <input type="checkbox" id="chkEdentulous" onclick="toggleRemark('chkEdentulous', 'txtEdentulous')" style="width: 30px;" />
                                                <label for="chkEdentulous">Edentulous</label>
                                            </div>
                                            <input type="text" id="txtEdentulous" class="form-control" placeholder="Enter Remark"
                                                style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;"onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)";  />

                                            <div class="CheckboxDiv">
                                                <input type="checkbox" id="chkProtruding" onclick="toggleRemark('chkProtruding', 'txtProtruding')" style="width: 30px;" />
                                                <label for="chkProtruding">Protruding</label>
                                            </div>
                                            <input type="text" id="txtProtruding" class="form-control" placeholder="Enter Remark"
                                                style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;" onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)";  />

                                            <div class="CheckboxDiv">
                                                <input type="checkbox" id="chkArtificial" onclick="toggleRemark('chkArtificial', 'txtArtificial')" style="width: 30px;" />
                                                <label for="chkArtificial">Artificial</label>
                                            </div>
                                            <input type="text" id="txtArtificial" class="form-control" placeholder="Enter Remark"
                                                style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;" onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)";  />

                                            <div class="CheckboxDiv">
                                                <input type="checkbox" id="chkBuck" onclick="toggleRemark('chkBuck', 'txtBuck')" style="width: 30px;" />
                                                <label for="chkBuck">Buck</label>
                                            </div>
                                            <input type="text" id="txtBuck" class="form-control" placeholder="Enter Remark"
                                                style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;" onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)"; />

                                            <div class="CheckboxDiv">
                                                <input type="checkbox" id="chkLooseTooth" onclick="toggleRemark('chkLooseTooth', 'txtLooseTooth')" style="width: 30px;" />
                                                <label for="chkLooseTooth">Loose Tooth</label>
                                            </div>
                                            <input type="text" id="txtLooseTooth" class="form-control" placeholder="Enter Remark"
                                                style="display: none; height: 30px; padding: 2px 8px; font-size: 12px; margin-left: 25px; width: 96%; margin-top: 5px;" onkeypress="MakeNormal(this.id)";onchange="MakeNormal(this.id)";  />
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                                                        <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Mallampati <span style="color:red;font-weight: bolder;">*</span>
                                    <%--priyanka 09/04/2026--%>
                                    <i class="fa fa-question-circle InfoIconPopup" title="Mallampati Information" onclick="OpenPopInfoGuide('M')" aria-hidden="true"></i> 
                                </label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAMALLTI" id="rbtnAAMALLTI1" />
                                        <label for="rbtnAAMALLTI1" class="RadioLbl">0</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAMALLTI" id="rbtnAAMALLTI2" />
                                        <label for="rbtnAAMALLTI2" class="RadioLbl">1</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAMALLTI" id="rbtnAAMALLTI3" />
                                        <label for="rbtnAAMALLTI3" class="RadioLbl">2</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAMALLTI" id="rbtnAAMALLTI4" />
                                        <label for="rbtnAAMALLTI4" class="RadioLbl">3</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAMALLTI" id="rbtnAAMALLTI5" />
                                        <label for="rbtnAAMALLTI5" class="RadioLbl">4</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAMALLTI" id="rbtnAAMALLTI6" />
                                        <label for="rbtnAAMALLTI6" class="RadioLbl">NA</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Mallampati Remark</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtAAMallRemark" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Jaw Sliding <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAJAWSLID" id="rbtnAAJAWSLID1" />
                                        <label for="rbtnAAJAWSLID1" class="RadioLbl">+1</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAJAWSLID" id="rbtnAAJAWSLID2" />
                                        <label for="rbtnAAJAWSLID2" class="RadioLbl">0</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AAJAWSLID" id="rbtnAAJAWSLID3" />
                                        <label for="rbtnAAJAWSLID3" class="RadioLbl">-1</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Trismus <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="FieldDiv" style="margin-top: 10px; flex: 20 20 20%;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATRIS" id="rbtnAATRIS1" />
                                        <label for="rbtnAATRIS1" class="RadioLbl">Grade 0 (>35mm)</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATRIS" id="rbtnAATRIS2" />
                                        <label for="rbtnAATRIS2" class="RadioLbl">Grade 1 (26-35mm)</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATRIS" id="rbtnAATRIS3" />
                                        <label for="rbtnAATRIS3" class="RadioLbl">Grade 2 (16-25mm)</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATRIS" id="rbtnAATRIS4" />
                                        <label for="rbtnAATRIS4" class="RadioLbl">Grade 3 (<15mm)</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Thyromental Distance <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATHYDIST" id="rbtnAATHYDIST1" />
                                        <label for="rbtnAATHYDIST1" class="RadioLbl">< 6 cm</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATHYDIST" id="rbtnAATHYDIST2" />
                                        <label for="rbtnAATHYDIST2" class="RadioLbl">6-7.5 cm</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATHYDIST" id="rbtnAATHYDIST3" />
                                        <label for="rbtnAATHYDIST3" class="RadioLbl">>7.5 cm</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Neck</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtAANeck" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Spine</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtAASpine" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Tracheostomy</label>
                                <div class="col-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkAATRACH" onclick="EnDisChkTextbox(this.id, 'txtAATracheostomy')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtAATracheostomy" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Airway Comments</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtAAAirComment" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Systemic Examination --%>
            <div id="MainDivSE">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('SEUp', 'SEDown', 'DivContentSE')">Systemic Examination</label>
                    <div class="ArrowDiv">
                        <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;display:none;" id="btnSysExm">Copy</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="SEDown" onclick="ToggleDiv(this.id,'SEUp','DivContentSE','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="SEUp" onclick="ToggleDiv(this.id,'SEDown','DivContentSE','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentSE">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Cardiovascular System</label>
                                <div class="col-8 FieldDiv">
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1 1 0%; margin-left: 5px; height: 57px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtSECardiSys"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Respiratory System</label>
                                <div class="col-8 FieldDiv">
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1 1 0%; margin-left: 5px; height: 57px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtSERespSys"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Abdominal System</label>
                                <div class="col-8 FieldDiv">
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1 1 0%; margin-left: 5px; height: 57px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtSEAdboSys"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Central Nervous System</label>
                                <div class="col-8 FieldDiv">
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1 1 0%; margin-left: 5px; height: 57px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtSECentNervSys"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- ARISCAT --%>
            <div id="MainDivARISCAT">
                <div class="MainDivHeader row">
                    <div class="MDHeaderLbl"  onclick="TriggerToggleDiv('ARISCATUp', 'ARISCATDown', 'DivContentARISCAT')" style="display: flex;align-items: center;">
                        <label>ARISCAT Criteria</label>
                        <span style="padding: 0px 10px;">-</span>
                        <input type="checkbox" id="ChkARISCATNA" onclick="NACheckHeaderInfo(this.id, 'DivContentARISCAT', 'ARISCATUp', 'ARISCATDown')" />
                        <span style="padding: 0px 10px;">NA</span>
                    </div>
                    <div class="ArrowDiv">
                         <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;display:none;" id="btnARISCAT">Copy</button>
                        <i class="fa fa-question-circle" style="font-size: 20px; margin-right: 10px; color: #0070ff; cursor: pointer;" title="ARISCAT Information" onclick='OpenPopInfoGuide("A")' aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-down DownArrow" id="ARISCATDown" onclick="ToggleDiv(this.id,'ARISCATUp','DivContentARISCAT','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="ARISCATUp" onclick="ToggleDiv(this.id,'ARISCATDown','DivContentARISCAT','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentARISCAT">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Age(yrs) <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATAGE" id="rbtnAge1" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnAge1" class="RadioLbl">0-51</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATAGE" id="rbtnAge2" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnAge2" class="RadioLbl">51-80</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATAGE" id="rbtnAge3" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnAge3" class="RadioLbl">>80</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Pre-op SpO2 <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATSPO2" id="rbtnPreOPSPO1" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnPreOPSPO1" class="RadioLbl">0-90</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATSPO2" id="rbtnPreOPSPO2" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnPreOPSPO2" class="RadioLbl">91-95</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATSPO2" id="rbtnPreOPSPO3" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnPreOPSPO3" class="RadioLbl">>95</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Respiratory Infection in Last 1 Month <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATRESINFT" id="rbtnRESPINFT1" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnRESPINFT1" class="RadioLbl">Yes</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATRESINFT" id="rbtnRESPINFT2" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnRESPINFT2" class="RadioLbl">No</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Pre-Op Hb <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATHB" id="rbtnPreOPHB1" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnPreOPHB1" class="RadioLbl">≤ 10</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATHB" id="rbtnPreOPHB2" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnPreOPHB2" class="RadioLbl">> 10</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Incision <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="FieldDiv" style="margin-top: 10px;flex: 20 20 20%;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATINC" id="rbtnINC1" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnINC1" class="RadioLbl">Upper Abdominal</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATINC" id="rbtnINC2" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnINC2" class="RadioLbl">Intrathoracic</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATINC" id="rbtnINC3" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnINC3" class="RadioLbl">None</label>
                                    </div>
                                    <%--Priyanka 18/11/2025--%>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATINC" id="rbtnINC4" />
                                        <label for="rbtnINC4" class="RadioLbl">Other</label>
                                        <input type="text" name="Other" id="txtINCOther" class="form-control" style="display:none;" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Surgery <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATSURG" id="rbtnARISCATSURG1" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnARISCATSURG1" class="RadioLbl">>3Hrs</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATSURG" id="rbtnARISCATSURG2" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnARISCATSURG2" class="RadioLbl"><3hrs</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Emergency Procedure <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATEMGPROC" id="rbtnEMGPROC1" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnEMGPROC1" class="RadioLbl">Yes</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="ARISCATEMGPROC" id="rbtnEMGPROC2" onclick="CalcRiskPPCRate();" />
                                        <label for="rbtnEMGPROC2" class="RadioLbl">No</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Total</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtARISCATTotal" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Risk Category</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtARISCATRiskCatg" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">PPC Rate</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtARISCATPPCRate" readonly />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Revised Lee Cardiac Risk Factor Index --%>
            <div id="MainDivRLCRFI">
                <div class="MainDivHeader row">
                    <div class="MDHeaderLbl" onclick="TriggerToggleDiv('RLCRFIUp', 'RLCRFIDown', 'DivContentRLCRFI')" style="display: flex;align-items: center;">
                        <label>Revised Lee Cardiac Risk</label>
                        <span style="padding: 0px 10px;">-</span>
                        <input style="padding: 0px 5px;" type="checkbox" id="ChkRevLeeNA" onclick="NACheckHeaderInfo(this.id, 'DivContentRLCRFI', 'RLCRFIUp', 'RLCRFIDown')" />
                        <span style="padding: 0px 10px;">NA</span>
                    </div>
                    <div class="ArrowDiv">
                         <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;display:none;" id="btnCardiacCopy">Copy</button>
                        <i class="fa fa-question-circle" style="font-size: 20px; margin-right: 10px; color: #0070ff; cursor: pointer;" title="Revised Lee Cardiac Risk Information" onclick='OpenPopInfoGuide("R")' aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-down DownArrow" id="RLCRFIDown" onclick="ToggleDiv(this.id,'RLCRFIUp','DivContentRLCRFI','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="RLCRFIUp" onclick="ToggleDiv(this.id,'RLCRFIDown','DivContentRLCRFI','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentRLCRFI">
                    <div class="row EachRow">
                        <div class="col-12" style="">
                            <div class="ContentFieldDiv" style="margin-left: -12px;">
                                <div class="col-12 FieldDiv" >
                                    <div class="RadioDiv">
                                        <input type="checkbox" name="RLCRFIFACTIND" id="rbtnRSKFCTIND1" onclick="CalcReviCardRsk()" />
                                        <label for="rbtnRSKFCTIND1" class="RadioLbl">High Risk Surgery</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="checkbox" name="RLCRFIFACTIND" id="rbtnRSKFCTIND2" onclick="CalcReviCardRsk()" />
                                        <label for="rbtnRSKFCTIND2" class="RadioLbl">Coronary Artery Disease</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="checkbox" name="RLCRFIFACTIND" id="rbtnRSKFCTIND3" onclick="CalcReviCardRsk()" />
                                        <label for="rbtnRSKFCTIND3" class="RadioLbl">Congestive Heart Failure</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="checkbox" name="RLCRFIFACTIND" id="rbtnRSKFCTIND4" onclick="CalcReviCardRsk()" />
                                        <label for="rbtnRSKFCTIND4" class="RadioLbl">Cerebrovascular Disease</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="checkbox" name="RLCRFIFACTIND" id="rbtnRSKFCTIND5" onclick="CalcReviCardRsk()" />
                                        <label for="rbtnRSKFCTIND5" class="RadioLbl">DM on Insulin</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="checkbox" name="RLCRFIFACTIND" id="rbtnRSKFCTIND6" onclick="CalcReviCardRsk()" />
                                        <label for="rbtnRSKFCTIND6" class="RadioLbl">Creatinine >2mg%</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Class</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtRSKFCTClass" disabled />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Major Cardiac Event</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtRSKFCTCardioEvnt" disabled />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Child Pugh Turcotte Score --%>
            <div id="MainDivCPTS">
                <div class="MainDivHeader row">
                    <div class="MDHeaderLbl"  onclick="TriggerToggleDiv('CPTSUp', 'CPTSDown', 'DivContentCPTS')" style="display: flex;align-items: center;">
                        <label>Child Pugh Turcotte Score</label>
                        <span style="padding: 0px 10px;">-</span>
                        <input type="checkbox" id="ChkChildPughNA" onclick="NACheckHeaderInfo(this.id, 'DivContentCPTS', 'CPTSUp', 'CPTSDown')" />
                        <span style="padding: 0px 10px;">NA</span>
                    </div>
                    <div class="ArrowDiv">
                         <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;display:none;" id="btnChildPughCopy">Copy</button>
                        <i class="fa fa-question-circle" style="font-size: 20px; margin-right: 10px; color: #0070ff; cursor: pointer;" title="Child Pugh Turcotte Score Information" onclick='OpenPopInfoGuide("C")' aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-down DownArrow" id="CPTSDown" onclick="ToggleDiv(this.id,'CPTSUp','DivContentCPTS','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="CPTSUp" onclick="ToggleDiv(this.id,'CPTSDown','DivContentCPTS','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentCPTS">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Encephalopathy <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSENC" id="rbtnCPTSENC1" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSENC1" class="RadioLbl">None</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSENC" id="rbtnCPTSENC2" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSENC2" class="RadioLbl">Mild – Moderate (Gr I-II)</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSENC" id="rbtnCPTSENC3" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSENC3" class="RadioLbl">Severe (Gr III-IV)</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Ascites <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSASCT" id="rbtnCPTSASCT1" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSASCT1" class="RadioLbl">None</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSASCT" id="rbtnCPTSASCT2" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSASCT2" class="RadioLbl">Mild-Moderate</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSASCT" id="rbtnCPTSASCT3" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSASCT3" class="RadioLbl">Severe</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Bilirubin (mg/dl) <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSBILI" id="rbtnCPTSBILI1" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSBILI1" class="RadioLbl"><2</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSBILI" id="rbtnCPTSBILI2" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSBILI2" class="RadioLbl">2-3</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSBILI" id="rbtnCPTSBILI3" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSBILI3" class="RadioLbl">>3</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Albumin (gm/dl) <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSALBU" id="rbtnCPTSALBU1" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSALBU1" class="RadioLbl">>3.5</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSALBU" id="rbtnCPTSALBU2" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSALBU2" class="RadioLbl">2.8-3.5</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSALBU" id="rbtnCPTSALBU3" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSALBU3" class="RadioLbl"><2.8</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">INR <span style="color:red;font-weight: bolder;">*</span></label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSINR" id="rbtnCPTSINR1" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSINR1" class="RadioLbl"><1.7</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSINR" id="rbtnCPTSINR2" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSINR2" class="RadioLbl">1.7-2.3</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CPTSINR" id="rbtnCPTSINR3" onclick="CalcChildPughScore()" />
                                        <label for="rbtnCPTSINR3" class="RadioLbl">>2.3</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Class</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtCPTSClass" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Points</label>
                                <div class="col-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtCPTSPoints" readonly />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
      
            <%-- ASA Physical Status --%>
            <div id="MainDivAPS">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('APSUp', 'APSDown', 'DivContentAPS')">ASA</label>
                    <div class="ArrowDiv">
                        <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;display:none;" id="bntcopyASA">Copy</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="APSDown" onclick="ToggleDiv(this.id,'APSUp','DivContentAPS','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="APSUp" onclick="ToggleDiv(this.id,'APSDown','DivContentAPS','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentAPS">
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                                                        <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Physical Status
                                     <%--priyanka 09/04/2026--%>
                                     <i class="fa fa-question-circle" title="Physical Status Information" onclick="OpenPopInfoGuide('P')" aria-hidden="true" style="font-size: 14px;color: #398ebd;cursor: pointer;padding-left: 5px;"></i> 
                                </label>
                                <div class="col-8 FieldDiv" style="margin-top: 10px;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSPHYSTS" id="rbtnAPSPHYSTS1" />
                                        <label for="rbtnAPSPHYSTS1" class="RadioLbl">I</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSPHYSTS" id="rbtnAPSPHYSTS2" />
                                        <label for="rbtnAPSPHYSTS2" class="RadioLbl">II</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSPHYSTS" id="rbtnAPSPHYSTS3" />
                                        <label for="rbtnAPSPHYSTS3" class="RadioLbl">III</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSPHYSTS" id="rbtnAPSPHYSTS4" />
                                        <label for="rbtnAPSPHYSTS4" class="RadioLbl">IV</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSPHYSTS" id="rbtnAPSPHYSTS5" />
                                        <label for="rbtnAPSPHYSTS5" class="RadioLbl">V</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSPHYSTS" id="rbtnAPSPHYSTS6" />
                                        <label for="rbtnAPSPHYSTS6" class="RadioLbl">VI</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="checkbox" name="APSPHYSTSCHK" id="rbtnAPSPHYSTSE" />
                                        <label for="rbtnAPSPHYSTSE" class="RadioLbl">E</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label" style="width: 90px;">Remark</label>
                                <div class="col-8 FieldDiv">
                                    <textarea maxlength="1500" class="form-control" style="resize: none;max-height:200px;overflow:auto" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="MakeNormal(this.id);" placeholder="" id="txtASARemark"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Fitness Status</label>
                                <div class="col-8 FieldDiv" style="flex-direction: column;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSFITSTS" id="rbtnAPSFITSTSF" onclick="UpdateCurrDateTime();EnDisAnesthesiaType();" />
                                        <label for="rbtnAPSFITSTSF" class="RadioLbl">Yes</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSFITSTS" id="rbtnAPSFITSTSW" onclick="UpdateCurrDateTime();EnDisAnesthesiaType();" />
                                        <label for="rbtnAPSFITSTSW" class="RadioLbl">Yes, with Accepted Risk</label>
                                    </div>
                                    <div class="RadioDiv" >
                                        <select id="cmbASARisk" class="form-control" style="width:160px;display:none;margin-bottom: 10px;">
                                            <option value="">---Select---</option>
                                            <option value="L">Low</option>
                                            <option value="M">Medium</option>
                                            <option value="H">High</option>
                                        </select>
                                    </div>
                                    <div class="RadioDiv" style="width: 80px;">
                                        <input type="radio" name="APSFITSTS" id="rbtnAPSFITSTSU" onclick="UpdateCurrDateTime();EnDisAnesthesiaType();" />
                                        <label for="rbtnAPSFITSTSU" class="RadioLbl">No</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="display:none" id="DivReviewPAC">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Review</label>
                                <div class="col-8 FieldDiv" style="flex-wrap: nowrap; align-items: center;">
                                    <input type="checkbox" id="ChkPACReview" onclick="PickTodayDate()" />
                                    <input type="text" class="form-control" id="txtPACReviewDate" style="margin-left: 15px;display:none" disabled readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4" style="">
                            <div class="ContentFieldDiv">
                                <label class="col-4 col-form-label ContentFieldLabel">Date / Time</label>
                                <div class="col-8 FieldDiv" style="justify-content: space-between;align-items: center;">
                                    <input type="text" class="form-control" id="txtAPSDate" style="width:45%;padding: 5px;background-color: #e9ecef;pointer-events: none;" readonly/>
                                    <label style="font-size: 18px;"> / </label>
                                    <input type="text" class="form-control" id="txtAPSTime" style="width:40%;padding: 5px;background-color: #e9ecef;pointer-events: none;" readonly />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Anaesthesia Plan --%>
            <div id="MainDivAnaestPlan"  style="display:none">
                <div class="MainDivHeader row" >
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('ASPLANUp', 'ASPLANDown', 'DivContentASPLAN')">Anaesthesia Plan</label>
                    <div class="ArrowDiv">
                        <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;display:none;" id="BtnCoptAnthsPln" onclick="">Copy</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="ASPLANDown" onclick="ToggleDiv(this.id,'ASPLANUp','DivContentASPLAN','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="ASPLANUp" onclick="ToggleDiv(this.id,'ASPLANDown','DivContentASPLAN','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentASPLAN">
                    <div id="ContentASPLAN">
                        <div id="AnaesthesiaSection">
                            <%--Abhishesh || 20260527--%>
                            <div class="row EachRow">
                                <div class="col-12 col-md-6 col-lg-4" style="">
                                    <div class="ContentFieldDiv">
                                        <label class="col-4 col-form-label ContentFieldLabel">Anaesthesia Type</label>
                                        <div class="col-8 FieldDiv">
                                            <%:Html.DropDownListFor(x => Model.AneasthTypeCode, new SelectList(Model.cmbAneasType, "Value", "Text"), "---Select---", new { id = "cmbAneasthesiaType", @class = "form-control"})%>
                                        </div>
                                    </div>
                                    <div class="col-12" style="">
                                        <div class="ContentFieldDiv">
                                            <div class="col-12 FieldDiv" id="AnaesthesiaList">
                                                <fieldset class="InvstFieldSet">
                                                    <legend class="InvstFieldSetLegend">Anaesthesia Type List</legend>
                                                    <div class="AdviListMainDiv" id="AnaesthesiaListOption">
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6 col-lg-4" style="">
                                    <div class="ContentFieldDiv">
                                        <label class="col-4 col-form-label ContentFieldLabel">Notes</label>
                                        <div class="col-8 FieldDiv">
                                            <textarea maxlength="1000" class="form-control ml-2" style="resize: none; flex: 1; margin-left: 5px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtASPLANNotes"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <%--Abhishesh || 20260525--%>
                            </div>
                        </div>
                        <div class="col-12" style=" display: inline-block;">
                            <div class="ContentFieldDiv" id="PreOPMedication">
                                <%--Abhishesh || 20260525--%>
                                <div class="col-12 DivAnaesthesiaPlanTable">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">Pre-op Meds
                                       <%-- <img id="btnDuplicate" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServicesPAC('D','P')" />
                                        <img id="btnInformant" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServicesPAC('I','P')">--%>

                                            <div style="display: flex; float: right;">

                                                <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("I"))
                                                    { %>

                                                <button class="btn btn-outline-success" id="btnInformant" title="Drug Interaction" style="float: right; margin-left: 5px; margin-right: 6px; display: none; padding: 5px; background: none !important;" onclick="subscribeCIMSServicesPAC('I','P')">
                                                    <%--<img src="../Images/CIMS_Images/DrugInteraction.png" style="height: 20px; width: 20px;">--%>
                                                    <svg width="24" height="24" viewBox="0 0 34 34" fill="none">
                                                        <rect x="34" y="1.48619e-06" width="34" height="34" rx="4" transform="rotate(90 34 1.48619e-06)" fill="gray" />
                                                        <path d="M21.25 22.3125L21.25 28.6875L27.625 28.6875" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round" />
                                                        <path d="M21.2502 28.6875L25.0062 24.9316C27.1812 22.7564 28.4111 19.8115 28.429 16.7354C28.4469 13.6594 27.2514 10.7003 25.1018 8.5" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round" />
                                                        <path d="M12.75 11.6875L12.75 5.3125L6.375 5.3125" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round" />
                                                        <path d="M12.75 5.3125L8.99406 9.06844C6.81899 11.2436 5.58913 14.1886 5.57123 17.2646C5.55333 20.3406 6.74883 23.2997 8.89844 25.5" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round" />
                                                    </svg>
                                                </button>

                                                <% } %>


                                                <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("D"))
                                                    { %>

                                                <button class="btn btn-outline-success" id="btnDuplicate" title="Drug Duplicate" style="float: right; margin-right: 6px; display: none; padding: 5px; background: none !important;" onclick="subscribeCIMSServicesPAC('D','P')">
                                                    <%--<img src="../Images/CIMS_Images/duplicate.png" style="float: right; height: 20px; width: 20px;" />--%>
                                                    <svg width="24" height="24" viewBox="0 0 34 34" fill="none">
                                                        <rect width="34" height="34" rx="4" fill="gray" />
                                                        <path d="M8.78261 10.9345V27.7606H22.087V14.8476L19.7391 10.781H8" stroke="white" stroke-width="1.56522" />
                                                        <path d="M11.9131 10.5434V6.23901H21.6957L26 10.5434V24.239H22.4783" stroke="white" stroke-width="1.56522" />
                                                        <path d="M16.0103 17.395L12.8951 20.5102C12.3528 21.0525 12.3528 21.9319 12.8951 22.4742L12.8953 22.4744C13.4377 23.0168 14.317 23.0168 14.8594 22.4744L17.9745 19.3593C18.5169 18.8169 18.5169 17.9376 17.9745 17.3952L17.9743 17.395C17.432 16.8527 16.5526 16.8527 16.0103 17.395Z" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round" />
                                                        <path d="M14.4526 18.9525L16.4169 20.9168" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round" />
                                                        <path d="M16.417 19.443L17.1536 18.7064" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round" />
                                                    </svg>
                                                </button>

                                                <% } %>


                                                <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("A"))
                                                    { %>

                                                <button class="btn btn-outline-success" id="btnAllergy" title="Drug Allergy" style="float: right; margin-right: 6px; display: none; padding: 5px; background: none !important;" onclick="subscribeCIMSServicesPAC('A','P')">
                                                    <%--<img src="../Images/CIMS_Images/duplicate.png" style="float: right; height: 20px; width: 20px;" />--%>
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 200 200" fill="none">
                                                        <rect width="200" height="200" rx="8" fill="gray" />
                                                        <path d="M138.5 174.5L103.686 139.686C100.686 136.686 96.616 135 92.3726 135H80.0342C76.7572 135 73.5593 133.994 70.8728 132.117L47.1549 115.553C44.8646 113.953 43.5 111.336 43.5 108.542V108.293C43.5 106.185 44.3377 104.162 45.8287 102.671C46.9193 101.581 48.3036 100.831 49.8128 100.513L50.9598 100.272C54.7468 99.4744 58.6849 100.569 61.5167 103.207L66.125 107.5L30.3385 70.4228C28.8384 68.8686 28 66.7928 28 64.6327C28 62.6132 28.733 60.6623 30.0629 59.1424L30.8934 58.1933C31.2972 57.7318 31.7366 57.3028 32.2077 56.9103L34.5 55C35.3766 54.4156 36.5413 54.5181 37.3024 55.2465L71 87.5L34.1423 50.1758C32.5068 48.5195 31.877 46.1176 32.4895 43.872C32.8226 42.6504 33.5039 41.5521 34.4502 40.7109L36.3999 38.9779C37.1226 38.3355 37.9899 37.8775 38.928 37.643C40.5661 37.2335 42.301 37.534 43.7059 38.4706L47.5 41M47.5 41L80 74M47.5 41L50.2581 38.2419C51.0835 37.4165 51.9969 36.6838 52.9818 36.0571L55.0563 34.7369C56.3257 33.9291 57.7992 33.5 59.3039 33.5C61.3541 33.5 63.3243 34.2959 64.7993 35.72L66.125 37M91.5 61.5L66.125 37M66.125 37L67.2143 34.9667C67.7363 33.9923 68.371 33.0826 69.1054 32.2564L70.0878 31.1512C71.3336 29.7497 72.9732 28.7567 74.7923 28.3019C78.0158 27.4961 81.4245 28.4677 83.7387 30.852L96.5 44M111.5 59.5L123.845 71.4339C125.592 73.1224 126.931 75.1866 127.762 77.4698L129.537 82.3509C130.174 84.1035 130.5 85.954 130.5 87.8188V96.8726C130.5 101.116 132.186 105.186 135.186 108.186L164 137" stroke="white" stroke-width="7" stroke-linecap="round" />
                                                        <circle cx="104.5" cy="51.5" r="4" fill="white" stroke="white" />
                                                        <circle cx="83.5" cy="90.5" r="3" fill="white" stroke="white" />
                                                        <circle cx="87.5" cy="113.5" r="8" fill="white" stroke="white" />
                                                        <circle cx="103.5" cy="81.5" r="8" fill="white" stroke="white" />
                                                        <circle cx="116" cy="106" r="2.5" fill="white" stroke="white" />
                                                        <circle cx="112" cy="127" r="2.5" fill="white" stroke="white" />
                                                        <circle cx="135" cy="130" r="6.5" fill="white" stroke="white" />
                                                        <circle cx="156.5" cy="164.5" r="7" fill="white" stroke="white" />
                                                        <circle cx="139" cy="152" r="2.5" fill="white" stroke="white" />
                                                        <circle cx="172" cy="145" r="2.5" fill="white" stroke="white" />
                                                    </svg>
                                                </button>

                                                <% } %>
                                            </div>
                                        </legend>
                                        <div class="col-12 FieldDiv">
                                            <fieldset class="InvstFieldSet" style="position: relative">
                                                <input type="text" id="txtSearchPreOpMed" placeholder="Search Pre-op Meds" class="form-control" style="width: 100%;" />
                                                <div id="DivSearchPreOpMedList" class="SearchListDiv" style="display: none;"></div>
                                                <div class="col-12" style="">
                                                    <div class="ContentFieldDiv">
                                                        <div class="FieldDiv" id="PrescMedList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width: 100%">
                                                                <table id="TablePreop" class="MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
                                                                            <th style="width: 10px;" class="th-info">Info.</th>
                                                                            <th style="width: 300px;" id="PreopTh">Medicine</th>
                                                                            <th style="width: 150px;">Form Name</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: 50px;">Duration</th>
                                                                            <th style="width: 100px; display: none">Food</th>
                                                                            <th style="width: 150px; color: red;">Route</th>
                                                                            <th style="width: 150px; color: red;">Dosage</th>
                                                                            <th style="width: 70px; color: red;">Qty</th>
                                                                            <th style="width: 250px;">Remark</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="TablePreopTBody"></tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>

                        <div class="col-12" style=" display: none;">
                            <div class="ContentFieldDiv">
                                <div class="col-12 DivAnaesthesiaPlanTable">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">Maintenance Medicine
         <img id="btnDuplicateMaint" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServicesPAC('D','M')" />
                                            <img id="btnInformantMaint" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServicesPAC('I','M')">
                                        </legend>
                                        <div class="col-12 FieldDiv">
                                            <fieldset class="InvstFieldSet">
                                                <input type="text" id="txtSearchMaintMed" placeholder="Search Maintenance Medicine" class="form-control" />
                                                <div id="DivSearchMaintMedList" class="SearchListDiv"></div>
                                                <div class="col-12" style=" width: 100%; overflow-x: auto;">
                                                    <div class="ContentFieldDiv">
                                                        <div class="col-12 FieldDiv" id="MaintList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width: 100%">
                                                                <table id="TableMaint" class="table table-bordered table-striped MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
                                                                            <th style="width: 10px;" class="th-info">Info.</th>
                                                                            <th style="width: 300px;" id="MaintTh">Medicine</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: 50px;">Duration</th>
                                                                            <th style="width: 100px; display: none">Food</th>
                                                                            <th style="width: 150px;">Route</th>
                                                                            <th style="width: 150px;">Dosage</th>
                                                                            <th style="width: 150px;">Qty</th>
                                                                            <th style="width: 250px;">Remark</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="TableMaintTBody"></tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>

                        <div class="col-12" style=" display: none;">
                            <div class="ContentFieldDiv">
                                <div class="col-12 DivAnaesthesiaPlanTable">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">Reversal Medicine
        <img id="btnDuplicateRev" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServicesPAC('D','R')" />
                                            <img id="btnInformantIndRev" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServicesPAC('I','R')">
                                        </legend>
                                        <div class="col-12 FieldDiv">
                                            <fieldset class="InvstFieldSet">
                                                <input type="text" id="txtSearchRevMed" placeholder="Search Reversal Medicine" class="form-control" />
                                                <div id="DivSearchRevMedList" class="SearchListDiv"></div>
                                                <div class="col-12" style=" width: 100%; overflow-x: auto;">
                                                    <div class="ContentFieldDiv">
                                                        <div class="col-12 FieldDiv" id="RevList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width: 100%">
                                                                <table id="TableRev" class="table table-bordered table-striped MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
                                                                            <th style="width: 10px;" class="th-info">Info.</th>
                                                                            <th style="width: 300px;" id="RevTh">Medicine</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: 50px;">Duration</th>
                                                                            <th style="width: 100px; display: none">Food</th>
                                                                            <th style="width: 150px;">Route</th>
                                                                            <th style="width: 150px;">Dosage</th>
                                                                            <th style="width: 150px;">Qty</th>
                                                                            <th style="width: 250px;">Remark</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="TableRevTBody"></tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>

                        <div class="col-12" style=" display: none;">
                            <div class="ContentFieldDiv">
                                <div class="col-12 DivAnaesthesiaPlanTable">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">PONV Medicine
         <img id="btnDuplicatePONV" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServicesPAC('D','N')" />
                                            <img id="btnInformantPONV" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServicesPAC('I','N')">
                                        </legend>
                                        <div class="col-12 FieldDiv">
                                            <fieldset class="InvstFieldSet">
                                                <input type="text" id="txtSearchPONVMed" placeholder="Search PONV Medicine" class="form-control" />
                                                <div id="DivSearchPONVMedList" class="SearchListDiv"></div>
                                                <div class="col-12" style=" width: 100%; overflow-x: auto;">
                                                    <div class="ContentFieldDiv">
                                                        <div class="col-12 FieldDiv" id="PONVMedList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width: 100%">
                                                                <table id="TablePONV" class="table table-bordered table-striped MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
                                                                            <th style="width: 10px;" class="th-info">Info.</th>

                                                                            <th style="width: 300px;" id="PONVTh">Medicine</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: 50px;">Duration</th>
                                                                            <th style="width: 100px; display: none">Food</th>
                                                                            <th style="width: 150px;">Route</th>
                                                                            <th style="width: 150px;">Dosage</th>
                                                                            <th style="width: 150px;">Qty</th>
                                                                            <th style="width: 250px;">Remark</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="TablePONVTBody"></tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row" id="DivVisitTab">
                <div style="display: flex; align-items: center; justify-content: space-between; background-color: #022548; padding: 5px 10px; color: white;">

                    <div style="display: flex; align-items: center; gap: 15px; flex-shrink: 0;">
                        <label class="MDHeaderLbl" style="width: auto !important; margin-bottom: 0; white-space: nowrap;">Visit</label>
                        <label class="switch mb-0" style="display:none;">
                            <%--<input type="checkbox" id="ChkVisitYN" onclick="EnDisChkTextbox(this.id)">--%>
                            <input type="checkbox" id="ChkVisitYN" checked>
                            <span class="slider"><span class="switch-label">No</span></span>
                        </label>
                    </div>
                    <%--<div id="MainDivTranInfo" style="display: flex; margin-right: 14px;">--%>
                    <div id="MainDivVitalTranInfo" style="display: flex; flex-wrap: wrap; gap: 15px; margin-right: 10px;">
                        <div id="DivVisitInfoPrint" style="align-items: center;">
                            <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;" id="BtnVisitInfoPrint" onclick="PrintVisitInfo()">Print</button>
                        </div>

                        <%--<div style="margin-right: 9px;">--%>
                        <div style="display: flex; align-items: center;">
                            <label style="width: 41px;">Date:</label>
                            <input type="text" style="color: black; border-radius: 4px; border: none; background-color: #ffffff;" id="txtVisitDate" readonly />
                        </div>
                        <%--<div style="margin-right: 1px;">--%>
                        <div style="display: flex; align-items: center;">
                            <label style="width: 45px;">Time:</label>
                            <input type="text" style="color: black; border-radius: 4px; border: none; background-color: #ffffff;" id="txtVisitime" readonly />
                        </div>
                    </div>
                </div>
            </div>

        <%-- Investigations --%>
        <div id="MainDivINVST">
            <div class="MainDivHeader row">
                <label class="MDHeaderLbl" onclick="TriggerToggleDiv('INVSTUp', 'INVSTDown', 'DivContentINVST')">Investigations</label>
                <div class="ArrowDiv" style="display: flex; justify-content: flex-end; align-items: center;">
                    <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 1.8px 10px; margin-right: 10px;display:none;" id="BtnCopyInvst" onclick="">Copy</button>
                    <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 1.8px 10px; margin-right: 10px;" id="BtnPrintInvst" onclick="PrintMultiEntryInvestigation()">Print</button>
                    <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 1.8px 10px; margin-right: 10px;" id="BtnResultInvst" onclick="OpenResultEntryPopup()">Result</button>
                    <i class="fa fa-chevron-circle-down DownArrow" id="INVSTDown" onclick="ToggleDiv(this.id,'INVSTUp','DivContentINVST','Y')" style="display: none" aria-hidden="true"></i>
                    <i class="fa fa-chevron-circle-up UpArrow" id="INVSTUp" onclick="ToggleDiv(this.id,'INVSTDown','DivContentINVST','N')" aria-hidden="true"></i>
                </div>
            </div>
            <div class="MainDivContent" id="DivContentINVST">
                <div class="row EachRow">
                    <div class="col-12" style="margin-left:-12px;">
                        <div class="ContentFieldDiv">
                            <div class="col-12 col-md-6 FieldDiv" id="AdviceList">
                                <fieldset class="InvstFieldSet">
                                    <legend class="InvstFieldSetLegend">Setup</legend>
                                    <div class="AdviListMainDiv" id="AdviceListOption">
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-12 col-md-6 FieldDiv" id="InvstSearchList">
                                <fieldset class="InvstFieldSet" style="position: relative;">
                                    <legend class="InvstFieldSetLegend">Test</legend>
                                    <input type="text" maxlength="100" id="txtSearchInvst" placeholder="Search Test" class="form-control"  style="width:96%;"/>
                                    <div id="DivSearchInvstList" style=" display: none;"></div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                    <div class="col-12" style="">
                        <div class="ContentFieldDiv">
                            <div class="col-12 FieldDiv" id="AdviceTestList">
                                <fieldset class="InvstFieldSet">
                                    <legend class="InvstFieldSetLegend">Test Advice List</legend>
                                    <div class="AdviListMainDiv" id="AdviceTestListOption">
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
            
            <%-- Speciality Reference (General Physician/Endocrinology/Nephrology/Gastroenterology/Neurology/Psychiatry) --%>
            <div id="MainDivSPCREF">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl">Speciality Reference <i id="btnAddRef" class="fa fa-plus-square" aria-hidden="true" style="display: none; cursor: pointer; color: black; margin-left: 10px; font-size: 20px;" onclick="AddRemSpecialityRef('A','')"></i></label>
                    <div class="ArrowDiv">
                        <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;display:none;" id="BtnCopySpeRef" onclick="">Copy</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="SPCREFDown" onclick="ToggleDiv(this.id,'SPCREFUp','DivContentSPCREF','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="SPCREFUp" onclick="ToggleDiv(this.id,'SPCREFDown','DivContentSPCREF','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentSPCREF">
                    <div class="row EachRow" id="SpecialityRefAddDiv"></div>

                    <div class="row EachRow">
                        <div class="col-12" style="">
                            <div class="ContentFieldDiv">
                                <div class="col-12 FieldDiv">
                                    <label class=" col-form-label">Other</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-12" style="">
                            <div class="ContentFieldDiv">
                                <div class="col-12 FieldDiv">
                                    <textarea maxlength="100" class="form-control" style="resize: none;" oninput="autoResize(this.id)" onchange="autoResize(this.id)" placeholder="" id="txtSPCREF"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- Anaesthesiologist’s Advice & Preoperative Orders --%>
            <div id="MainDivAAPO">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('AAPOUp', 'AAPODown', 'DivContentAAPO')">Anaesthesiologist’s Advice & Preoperative Orders</label>
                    <div class="ArrowDiv">
                        <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;display:none;" id="BtnCopyAnaesth" onclick="">Copy</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="AAPODown" onclick="ToggleDiv(this.id,'AAPOUp','DivContentAAPO','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="AAPOUp" onclick="ToggleDiv(this.id,'AAPODown','DivContentAAPO','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentAAPO">
                    <div class="row EachRow">
                        <div class="col-12" style="">
                            <div class="ContentFieldDiv">
                                <div class="col-12 FieldDiv">
                                    <textarea maxlength="5000" class="form-control" style="resize: none;" onchange="autoResize(this.id)" oninput="autoResize(this.id)" id="txtAAPO"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%--priyanka 18/02/2026--%>
            <%--Medicine--%>
            <div id="MainDivMedicine">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('MedicineUp', 'MedicineDown', 'DivContentMedicine')">Medicine</label>
                    <div class="ArrowDiv">
                        <i class="fa fa-chevron-circle-down DownArrow" id="MedicineDown" onclick="ToggleDiv(this.id,'MedicineUp','DivContentMedicine','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="MedicineUp" onclick="ToggleDiv(this.id,'MedicineDown','DivContentMedicine','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentMedicine">
                    <div class="row EachRow">
                        <div class="col-12" style=" width:98%;" >
                            <div class="ContentFieldDiv">
                                <div class="col-12">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">Medicine
                                             <%--<img id="btnDuplicateInd" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServicesPAC('D','I')" />
                                             <img id="btnInformantInd" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServicesPAC('I','I')">--%>

                                        

                                            <div style="display:flex;float:right;">

                                               <% if(@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("I")) { %>

                                                <button class="btn btn-outline-success" id="btnInformantInd" title="Drug Interaction" style="float: right; margin-left: 5px; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServicesPAC('D','I')">
                                                    <%--<img src="../Images/CIMS_Images/DrugInteraction.png" style="height: 20px; width: 20px;">--%>
                                                      <svg width="24" height="24" viewBox="0 0 34 34" fill="none">
                                                          <rect x="34" y="1.48619e-06" width="34" height="34" rx="4" transform="rotate(90 34 1.48619e-06)" fill="gray"/>
                                                          <path d="M21.25 22.3125L21.25 28.6875L27.625 28.6875" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round"/>
                                                          <path d="M21.2502 28.6875L25.0062 24.9316C27.1812 22.7564 28.4111 19.8115 28.429 16.7354C28.4469 13.6594 27.2514 10.7003 25.1018 8.5" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round"/>
                                                          <path d="M12.75 11.6875L12.75 5.3125L6.375 5.3125" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round"/>
                                                          <path d="M12.75 5.3125L8.99406 9.06844C6.81899 11.2436 5.58913 14.1886 5.57123 17.2646C5.55333 20.3406 6.74883 23.2997 8.89844 25.5" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round"/>
                                                      </svg>
                                                </button>
                                
                                               <% } %>

                                               <% if(@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("D")) { %>

                                                <button class="btn btn-outline-success" id="btnDuplicateInd" title="Drug Duplicate" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="
                                                    ('I','I')">
                                                    <%--<img src="../Images/CIMS_Images/duplicate.png" style="float: right; height: 20px; width: 20px;" />--%>
                                                      <svg width="24" height="24" viewBox="0 0 34 34" fill="none">
                                                        <rect width="34" height="34" rx="4" fill="gray"/>
                                                        <path d="M8.78261 10.9345V27.7606H22.087V14.8476L19.7391 10.781H8" stroke="white" stroke-width="1.56522"/>
                                                        <path d="M11.9131 10.5434V6.23901H21.6957L26 10.5434V24.239H22.4783" stroke="white" stroke-width="1.56522"/>
                                                        <path d="M16.0103 17.395L12.8951 20.5102C12.3528 21.0525 12.3528 21.9319 12.8951 22.4742L12.8953 22.4744C13.4377 23.0168 14.317 23.0168 14.8594 22.4744L17.9745 19.3593C18.5169 18.8169 18.5169 17.9376 17.9745 17.3952L17.9743 17.395C17.432 16.8527 16.5526 16.8527 16.0103 17.395Z" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round"/>
                                                        <path d="M14.4526 18.9525L16.4169 20.9168" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round"/>
                                                        <path d="M16.417 19.443L17.1536 18.7064" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round"/>
                                                      </svg>
                                                </button>

                                               <% } %>

                                               <% if(@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("A")) { %>

                                                <button class="btn btn-outline-success" id="btnAllergyInd" title="Drug Allergy" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServicesPAC('A','I')">
                                                    <%--<img src="../Images/CIMS_Images/duplicate.png" style="float: right; height: 20px; width: 20px;" />--%>
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 200 200" fill="none">
                                                          <rect width="200" height="200" rx="8" fill="gray"/>
                                                          <path d="M138.5 174.5L103.686 139.686C100.686 136.686 96.616 135 92.3726 135H80.0342C76.7572 135 73.5593 133.994 70.8728 132.117L47.1549 115.553C44.8646 113.953 43.5 111.336 43.5 108.542V108.293C43.5 106.185 44.3377 104.162 45.8287 102.671C46.9193 101.581 48.3036 100.831 49.8128 100.513L50.9598 100.272C54.7468 99.4744 58.6849 100.569 61.5167 103.207L66.125 107.5L30.3385 70.4228C28.8384 68.8686 28 66.7928 28 64.6327C28 62.6132 28.733 60.6623 30.0629 59.1424L30.8934 58.1933C31.2972 57.7318 31.7366 57.3028 32.2077 56.9103L34.5 55C35.3766 54.4156 36.5413 54.5181 37.3024 55.2465L71 87.5L34.1423 50.1758C32.5068 48.5195 31.877 46.1176 32.4895 43.872C32.8226 42.6504 33.5039 41.5521 34.4502 40.7109L36.3999 38.9779C37.1226 38.3355 37.9899 37.8775 38.928 37.643C40.5661 37.2335 42.301 37.534 43.7059 38.4706L47.5 41M47.5 41L80 74M47.5 41L50.2581 38.2419C51.0835 37.4165 51.9969 36.6838 52.9818 36.0571L55.0563 34.7369C56.3257 33.9291 57.7992 33.5 59.3039 33.5C61.3541 33.5 63.3243 34.2959 64.7993 35.72L66.125 37M91.5 61.5L66.125 37M66.125 37L67.2143 34.9667C67.7363 33.9923 68.371 33.0826 69.1054 32.2564L70.0878 31.1512C71.3336 29.7497 72.9732 28.7567 74.7923 28.3019C78.0158 27.4961 81.4245 28.4677 83.7387 30.852L96.5 44M111.5 59.5L123.845 71.4339C125.592 73.1224 126.931 75.1866 127.762 77.4698L129.537 82.3509C130.174 84.1035 130.5 85.954 130.5 87.8188V96.8726C130.5 101.116 132.186 105.186 135.186 108.186L164 137" stroke="white" stroke-width="7" stroke-linecap="round"/>
                                                          <circle cx="104.5" cy="51.5" r="4" fill="white" stroke="white"/>
                                                          <circle cx="83.5" cy="90.5" r="3" fill="white" stroke="white"/>
                                                          <circle cx="87.5" cy="113.5" r="8" fill="white" stroke="white"/>
                                                          <circle cx="103.5" cy="81.5" r="8" fill="white" stroke="white"/>
                                                          <circle cx="116" cy="106" r="2.5" fill="white" stroke="white"/>
                                                          <circle cx="112" cy="127" r="2.5" fill="white" stroke="white"/>
                                                          <circle cx="135" cy="130" r="6.5" fill="white" stroke="white"/>
                                                          <circle cx="156.5" cy="164.5" r="7" fill="white" stroke="white"/>
                                                          <circle cx="139" cy="152" r="2.5" fill="white" stroke="white"/>
                                                          <circle cx="172" cy="145" r="2.5" fill="white" stroke="white"/>
                                                     </svg>
                                                </button>

                                               <% } %>

                                            </div>

                                        </legend>
                                        <div class="FieldDiv">
                                            <fieldset class="InvstFieldSet" id="DivContentInvstFieldSet" style="position: relative;">
                                                <input type="text" id="txtSearchIndMed" placeholder="Search Medicine" class="form-control" style=" width: 100%;" />
                                                <div id="DivSearchIndMedList" class="SearchListDiv" style="display: none;"></div>
                                                <div class="col-12" style="">
                                                    <div class="ContentFieldDiv">
                                                        <div class="FieldDiv" id="IndMedList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width: 100%">
                                                                <%--<table id="TableInd" class="table table-bordered table-striped MedicineTbl">--%>
                                                                <table id="TableInd" class="MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
                                                                            <th style="width: 10px;" class="th-info">Info.</th>
                                                                            <th style="width: 300px;" id="IndTh">Medicine</th>
                                                                            <th style="width: 150px;">Form Name</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: auto;">Duration</th>
                                                                            <th style="width: 100px; display: none">Food</th>
                                                                            <th style="width: 150px; color: red;">Route</th>
                                                                            <th style="width: 150px;color: red;">Dosage</th>
                                                                            <th style="width: 70px;color: red;">Qty</th>
                                                                            <th style="width: 250px;">Remark</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="TableIndTBody"></tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- Button Div --%>
            <div id="MainDivBtnGrp">
                <div id="DivContentBtnGrp">
                    <div class="row EachRow">
                        <div class="col-12" style="">
                            <div class="ContentFieldDiv">
                                <div class="col-12 FieldDiv" style="justify-content: center;">
                                    <button type="button" class="btn btn-success" style="min-width: 70px; display: none; margin-left: 20px;" id="BtnSave" onclick="SavePAC('N')">Save</button>
                                    <button type="button" class="btn btn-primary" style="min-width: 70px; display: none; margin-left: 20px;" id="BtnEdit" onclick="ChangeGaction('E')">Edit</button>
                                    <div id="DivEditChange" style="display: none">
                                        <button type="button" class="btn btn-success" style="min-width: 70px; margin-left: 20px;" id="BtnUpdate" onclick="SavePAC('E')">Update</button>
                                        <button type="button" class="btn btn-success" style="min-width: 70px; margin-left: 20px;display:inline-block;" id="BtnApprovel" onclick="window.location.reload();">Reload</button>
                                    </div>
                                    <div id="PrintDiv" style="display: none; align-items: center;">
                                        <button type="button" class="btn btn-success" style="min-width: 70px; margin-left: 20px;" id="BtnReview" onclick="SavePAC('E')">Review</button>
                                        <button type="button" class="btn btn-success" style="min-width: 70px; margin-left: 20px;" id="BtnPrint" onclick="HistoryPopupOpen('PAC Print','PACPrint')">Print</button>
                                    </div>
                                    <div id="PrintWDiv" style="display:none; align-items: center;">
                                        <button type="button" class="btn btn-success" style="min-width: 70px; margin-left: 20px;" id="BtnPrevPrint" onclick="HistoryPopupOpen('PAC Print','PACPrint')">Print</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Investigation Result Entry --%>
    <div id="ReventModal" class="EModal" style="justify-content: center; align-items: center;">
        <div class="modal-content" style="width: 80vw;">
            <div class="ModelHeaderDiv ResultHeader">
                <label>Result Entry</label>
                <span class="closeMdlBtn" id="closeModalBtn" onclick="ClosePop('ReventModal');">&times;</span>
            </div>
            <div class="ModelContentDiv">
                <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                    <div class="Tablewrapper" style="font-size: 12px; background: white;height:70vh">
                        <table id="tblResultInvstList" class="tblpopupList" style="width: auto !important;">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th id="thInhouse">Inhouse</th>
                                    <th>Outside</th>
                                    <th style="min-width: 150px; display: none">Investion Code</th>
                                    <th style="min-width: 150px; display: none">Test Code</th>
                                </tr>
                            </thead>
                            <tbody id="tblResultInvstListBody"></tbody>
                        </table>
                    </div>
                </div>
                <div style="display: flex; align-items: center; justify-content: center; margin: 10px 0px;">
                    <input type="button" id="BtnUpdateInvst" onclick="UpdateResultList()" class="" style="width: 100px; font-size: 13px; text-align: center; display: block; cursor: pointer; color: white !important; background-color: #008bce; border-radius: 5px; background-position-x: 6px; border: 1px; border-radius: 5px; background-position-y: 2px; padding-top: 3px; padding-bottom: 3px;" value="Ok">
                </div>
            </div>
        </div>
    </div>

    <%-- ARISCAT Criteria Info --%>
    <div id="POPUPInfoModal" class="EModal" style="justify-content: center; align-items: center;">
        <div class="modal-content" style="min-width: 300px;">
            <div class="ModelHeaderDiv ResultHeader">
                <label id="InfoHeadLabel"></label>
                <span id="closeARISCATBtn" class="closeMdlBtn"  onclick="ClosePop('POPUPInfoModal');">&times;</span>
            </div>
            <div class="ModelContentDiv">
                <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                    <div class="Tablewrapper" style="font-size: 12px; background: white;">
                        <table class="tblpopupList"  id="TblARISCATInfo">
                            <thead>
                                <tr>
                                    <th>Score</th>
                                    <th>Risk Category</th>
                                    <th>Rate</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: center;">< 25</td>
                                    <td>Low risk</td>
                                    <td style="text-align: center;">1.6%</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">26 - 44</td>
                                    <td>Intermediate risk</td>
                                    <td style="text-align: center;">13.3%</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">> 44</td>
                                    <td>High risk</td>
                                    <td style="text-align: center;">42.1%</td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="tblpopupList"  id="TblRevLeeInfo">
                            <thead>
                                <tr>
                                    <th>No. of Risk Factors</th>
                                    <th>Class</th>
                                    <th>Major Cardiac Event</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: center;">0</td>
                                    <td style="text-align: center;">I</td>
                                    <td style="text-align: center;">0.4%</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">1</td>
                                    <td style="text-align: center;">II</td>
                                    <td style="text-align: center;">0.9%</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">2</td>
                                    <td style="text-align: center;">III</td>
                                    <td style="text-align: center;">6.6%</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">3 or More</td>
                                    <td style="text-align: center;">IV</td>
                                    <td style="text-align: center;">11%</td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="tblpopupList" id="TblChildPughInfo">
                            <thead>
                                <tr>
                                    <th style="min-width: 150px;">Criteria</th>
                                    <th style="min-width: 70px;">1</th>
                                    <th style="min-width: 150px;">2</th>
                                    <th style="min-width: 100px;">3</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Encephalopathy</td>
                                    <td>None</td>
                                    <td>Mild-Moderate (Gr I-II)</td>
                                    <td>Severe (Gr III-IV)</td>
                                </tr>
                                <tr>
                                    <td>Ascites</td>
                                    <td>None</td>
                                    <td>Mild-Moderate</td>
                                    <td>Severe</td>
                                </tr>
                                <tr>
                                    <td>Bilirubin (mg/dl)</td>
                                    <td><2</td>
                                    <td>2-3</td>
                                    <td>>3</td>
                                </tr>
                                <tr>
                                    <td>Albumin (gm/dl)</td>
                                    <td>>3.5</td>
                                    <td>2.8-3.5</td>
                                    <td><2.8</td>
                                </tr>
                                <tr>
                                    <td>INR</td>
                                    <td><1.7</td>
                                    <td>1.7-2.3</td>
                                    <td>>2.3</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold">Class</td>
                                    <td style="font-weight: bold">A</td>
                                    <td style="font-weight: bold">B</td>
                                    <td style="font-weight: bold">C</td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold">Points</td>
                                    <td style="font-weight: bold">5-6</td>
                                    <td style="font-weight: bold">7-9</td>
                                    <td style="font-weight: bold">10-15</td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="tblpopupList"  id="TblECOGInfo">
                            <thead>
                                <tr>
                                    <th>Score</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: center;">0</td>
                                    <td>Fully active, able to carry on all pre-disease performance without restriction</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">1</td>
                                    <td>Strenuous physical activity restricted; fully ambulatory and able to carry out light work</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">2</td>
                                    <td>Capable of self-care; but unable to carry out any work activities. Up and about >50% of waking hours</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">3</td>
                                    <td>Capable of only limited self-care; confined to bed or chair >50% of waking hours</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">4</td>
                                    <td>Completely disabled; cannot carry out any self-care; totally confined to bed or chair</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">5</td>
                                    <td>Dead</td>
                                </tr>
                            </tbody>
                        </table>

                        <%--priyanka 09/04/2026--%>
                        <table class="tblpopupList" id="TblMALLAMPATIInfo">
                            <thead>
                                <tr>
                                    <th>Score</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: center;">0</td>
                                    <td>Epiglottis partially or fully visible</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">1</td>
                                    <td>Full view of soft palate, uvula, and tonsillar pillars</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">2</td>
                                    <td>Soft palate and uvula visible, pillars obscured</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">3</td>
                                    <td>Soft palate and uvula base visible</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">4</td>
                                    <td>Visualization restricted to the hard palate</td>
                                </tr>
                            </tbody>
                        </table>

                         <%--priyanka 09/04/2026--%>
                        <table class="tblpopupList" id="TblPhysicalStatusIInfo">
                            <thead>
                                <tr>
                                    <th>Status</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: center;">I</td>
                                    <td>A normal healthy patient (nonsmoker, no or minimal alcohol consumption)</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">II</td>
                                    <td> A patient with mild systemic disease (e.g., current smoker, social drinker, BMI 30 but , well-controlled DM/HTN)</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">III</td>
                                    <td>A patient with severe systemic disease (e.g., BMI 40, poorly controlled DM/HTN, stable angina)</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">IV</td>
                                    <td>A patient with severe systemic disease that is a constant threat to life (e.g., recent MI, stroke, sepsis)</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">V</td>
                                    <td>A moribund patient who is not expected to survive without the operation</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">VI</td>
                                    <td>A brain-dead patient whose organs are being removed for donor purposes</td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="PACHistInfoModal" class="EModal" style="justify-content: center; align-items: center;">
        <div class="modal-content" style="min-width: 300px;">
            <div class="ModelHeaderDiv ResultHeader">
                <label>History List</label>
                <span class="closeMdlBtn" onclick="ClosePop('PACHistInfoModal');">&times;</span>
            </div>
            <div class="ModelContentDiv">
                <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                    <div class="Tablewrapper" style="font-size: 12px; background: white;">
                        <table class="tblpopupList" id="TblPACHistInfo">
                            <thead>
                                <tr>
                                    <th>Act</th>
                                    <th>PAC No.</th>
                                    <th>Ref. Doctor</th>
                                    <th>Surgery Advice Date</th>
                                    <th>Surgery Advice</th>
                                    <th>Nature of Surgery</th>
                                    <th>PAC Status</th>
                                    <th>PAC Status Date/Time</th>
                                    <th>PAC Done By</th>
                                </tr>
                            </thead>
                            <tbody id="TBodyPACHist">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="PACLogInfoModal" class="EModal" style="justify-content: center; align-items: center;">
        <div class="modal-content" style="min-width: 300px;">
            <div class="ModelHeaderDiv ResultHeader">
                <label>Log Information</label>
                <span class="closeMdlBtn" onclick="ClosePop('PACLogInfoModal');">&times;</span>
            </div>
            <div class="ModelContentDiv">
                <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                    <div class="Tablewrapper" style="font-size: 12px; background: white;">
                        <table class="tblpopupList" id="TblPACLogInfo">
                            <thead>
                                <tr>
                                     <th></th>
                                    <th>Action</th>
                                    <th>User Name</th>
                                    <th>Log On</th>
                                    <th>Log At</th>
                                </tr>
                            </thead>
                            <tbody id="TBodyPACLog">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
         <%-- Added by Roshan 20250812 => Dialog For  CIMS Info --%>
    <div id="divCIMSInfo" style="display: none;">
        <div class="CIMS-container">
            <div class="CIMS-header">
                <div style="display: inline-block; vertical-align: middle; margin-top: 7px; padding-left: 4px;">
                    <img src="../Images/CIMS_Images/Drug.png" style="height: 28px; width: 28px; vertical-align: middle;" />
                </div>
                <div style="display: inline-block; vertical-align: middle; margin-top: 7px;">
                    <h2 class="CIMS-header-child" style="color: white; margin: 0; vertical-align: middle; font-size: 19px;"></h2>
                </div>
                <div class="CIMS-close" onclick="$('#divCIMSInfo').dialog('close')" title="Close"><i class="fa fa-times"></i></div>
            </div>
            <div class="CIMS-body" id="CIMSBody"></div>
        </div>
    </div>
    <div id="minimizedIframeBar" style="display:none;"></div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <%-- Common --%>
    <style>
        html, body {
        height: 100%;
        margin: 0;
        overflow: hidden;   /* disable browser scroll */
        }

        /* Top header height = measure it (example 120px) */
        :root {
            --header-height: 120px;
        }

        #MainDiv {
            height: calc(100vh - var(--header-height));
            overflow-y: auto;
            overflow-x: hidden;
        }

        #LblInvstNotifi {
            margin-left: 10px;
            background-color:red;
            padding: 2px;
            color: white;
            border-radius: 5px;
        }

        label {
            margin: 0px !important;
        }

        input[type="radio"], input[type="checkbox"] {
            margin: 0px;
        }

        :checked + label:before {
            content: "" !important;
        }

        :checked + label {
            border: none;
        }

        .input-form-label {
            cursor: pointer;
        }

        .MainDivHeader {
            display:flex;
            align-items: center;
            justify-content: flex-start;
            background-color: #00930012;
            color: #363636;
            border-top: 2px solid #009300;
            margin-top: 5px !important;
            margin-left:2px;
        }

        .MDHeaderLbl {
            padding: 5px;
            font-size: 14px;
            font-weight: bold;
            width: 70%;
            text-align: left;
        }

        .MainDivContent {
            margin-top: 5px;
            display: none;
            font-size: 12px;
        }

        .HeaderBtnIcon {
            padding-right: 10px;
            align-items: center;
        }

        .ArrowDiv {
            width: 30%;
            text-align: right;
        }

        .DownArrow {
            padding-right: 15px;
            font-size: 20px;
        }

        .UpArrow {
            padding-right: 15px;
            font-size: 20px;
        }

        .ContentFieldDiv {
            display: flex;
            align-items: flex-start;
            padding-top: 5px;
        }
        .ContentFieldLabel{
            width:112px;
        }
        .DivAdvisedSurgeryTables{
            width: 100%;
            margin-left: -15px;
        }
        .DivAnaesthesiaPlanTable{
            width: 98%;
            margin-left: -4px;
        }
        .FieldDiv {
            display: flex;
            align-items: flex-start;
            flex-wrap: wrap;
            margin-left: 10px;
        }

        .RadioDiv {
            display: flex;
            align-items: flex-start;
        }

        .EachRow {
            display: flex;
            flex-wrap: wrap;
            align-items: flex-start;
            margin : 0px !important;
        }

        .RadioLbl {
            padding:0px 20px 10px 5px;
        }

        .MeasureInd {
            border: 1px solid #cccccc;
            border-radius: 5px;
            padding: 5px;
            color: #fff;
            background-color: #31b0d5;
            border-color: #269abc;
            border-top-left-radius: 0px;
            border-bottom-left-radius: 0px;
            min-width: 60px;
            text-align: center;
            align-content: center;
        }

        .SpeciPrintIcon {
            cursor: pointer;
            color: black;
            margin-left: 10px;
            font-size: 20px;
        }

        .SpeciDelIcon {
            color: black;
            margin-left: 10px;
            font-size: 20px;
        }
    </style>
           <%-- 20260220--%>
    <style>
        .pac-container {
            width: 900px;
            max-width: 100%;
            background: #f4f7f9;
            padding: 10px;
        }

        .pac-card {
            background: #fff;
            border: 1px solid #ddd;
            margin-bottom: 20px;
            border-radius: 4px;
            overflow: hidden;
        }

        .pac-header {
            background: #3c5a99; /* Blue header from your image */
            color: white;
            padding: 10px 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: bold;
        }

        .pac-body {
            padding: 15px;
        }

        .section-title {
            font-weight: bold;
            font-size: 14px;
            margin: 15px 0 5px 0;
            color: #333;
        }

        .pac-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px;
        }

            .pac-table th {
                background: #5b7db1;
                color: white;
                font-size: 16px;
                padding: 8px;
                text-align: left;
            }

            .pac-table td {
                border: 1px solid #eee;
                padding: 8px;
                font-size: 14px;
            }

        .pac-list {
            margin: 0;
            padding-left: 20px;
            font-size: 13px;
        }

        .pac-text {
            font-size: 13px;
            color: #555;
            padding-left: 5px;
        }
        .pac-table th, .pac-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .pac-table thead th {
            background-color: #3c5a99;
            color: #fff;
        }

        .section-title {
            color: #3c5a99;
            border-bottom: 1px solid #eee;
            padding-bottom: 3px;
            margin-bottom: 5px;
        }
        #DivSearchInvstList {
            max-width: 96%;
            display: block;
            margin-top: 0px;
            z-index: 100022;
            top: 70px;
            position: absolute;
            background-color: rgb(251, 251, 251);
            border: 1px solid black;
            padding: 0px 5px;
            max-height: 150px;
            overflow: auto;
        }
    </style>

    <%-- Pain Score Table --%>
    <style>
        #tblPainScore td {
            padding:5px 10px 10px 20px;
            vertical-align:top;
        }

        .Tablewrapper {
            overflow-x: auto;
            width: 100%;
        }

        #tblPainScore input[type="radio"]:checked + label {
            background-color: #f78888;
        }
    </style>

    <%-- Patient Vital Signs and Measurements --%>
  
    <style>
        table#tblPatVitalMsrmnts {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            min-height: 100px;
        }

            table#tblPatVitalMsrmnts thead {
                background: #4CAF50;
                color: white;
                font-size: 12px;
                text-align:center;
            }

            table#tblPatVitalMsrmnts th,
            table#tblPatVitalMsrmnts td {
                padding: 12px 15px;
                border: none;
                text-align: left;
                border: 1px solid #c9c9c9;
            }

            table#tblPatVitalMsrmnts th {
                text-align:center !important;
            }

            table#tblPatVitalMsrmnts tbody tr {
                background-color: #f9f9f9;
                transition: background-color 0.3s;
            }

                table#tblPatVitalMsrmnts tbody tr:nth-child(even) {
                    background-color: #f1f1f1;
                }

                table#tblPatVitalMsrmnts tbody tr:hover {
                    background-color: #f1f1f1;
                }

        .GridEditIcon {
            cursor: pointer;
            transition: transform 0.3s;
        }

            .GridEditIcon:hover {
                transform: scale(1.2);
            }

        .GridDeleteIcon {
            cursor: pointer;
            transition: transform 0.3s;
        }

            .GridDeleteIcon:hover {
                transform: scale(1.2);
            }
    </style>
    <style>
        .CheckboxContainer {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .CheckboxDiv {
            display: flex;
            align-items: center;
            min-width: 70px; /* Adjust based on longest label */
        }

        .CheckboxContainer .form-control {
            width: auto;
            flex-grow: 1;
        }
    </style>
    <%-- Investigation --%>
    <style>
        .InvstFieldSet {
            width: 100%;
        }

        .InvstFieldSetLegend {
            margin-bottom: 10px;
            border-bottom: 1px solid #009300;
            color: black;
            font-size: 15px;
        }

        .AdviListMainDiv {
            display:flex;
            align-items: center;
            flex-wrap: wrap;
            width: 100%;
        }

        .AdviListSepDiv {
            display: flex;
            align-items: center;
            border: 1px solid grey;
            background-color: #d1d1d1;
            margin: 5px 5px;
            border-radius: 10px;
            padding: 2px 0px;
            cursor: pointer;
        }

        .AdvListChkbox {
            margin-left: 5px !important;
            cursor: pointer;
        }

        .AdvListLbl {
            cursor: pointer;
            padding: 2px 10px 0px 10px;
        }

         .MedListSepDiv {
            display: flex;
            align-items: center;
            border: 1px solid grey;
            background-color:rgb(92, 184, 92);
            margin: 5px 5px;
            border-radius: 10px;
            padding: 2px 0px;
            cursor: pointer;
            border: 1px solid rgb(74, 163, 74);
            color: white;
        }
    </style>

     <%--Treatment history--%>
    <style>
        .CardiacFieldSet {
            width: 100%;
        }

        .CardiacFieldSetLegend {
            margin-bottom: 10px;
            border-bottom: 1px solid #009300;
            color: black;
            font-size: 15px;
        }
    </style>

    <%-- Investigation -Result Entry --%>
    <style>
        .EModal {
            display:none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

            .EModal .modal-content {
                background-color:white;
                margin: 10% auto;
                width: auto;
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

        .fc-event-main {
            font-size: 12px !important;
        }

        .ui-dialog {
            z-index: 100000000000000000000000000000;
        }

        .ResultHeader {
            background: #043362 !important;
            border-radius: 0px;
        }

        table.tblpopupList {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            min-height: 100px;
        }

            table.tblpopupList thead {
                background: #314b81;
                color: white;
                color: white;
                font-size: 12px;
            }

            table.tblpopupList th {
                padding: 5px 15px;
                border: none;
                border: 1px solid #e6e6e6;
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

            table.tblpopupList tbody td {
                padding: 5px;
                border: 1px solid #e6e6e6;
            }

        .TestTd {
            text-align: center;
            color: black;
            font-weight: bold;
            padding: 0px 5px;
            background-color: #ededed;
            border: 1px solid #c9c9c9;
        }

        .TestDateINTd {
            padding: 5px 10px !important;
        }

        .TestDateOTTd {
            padding: 5px 10px !important;
            width: 190px;
        }

        .InvstHeaderTd {
            text-align: left;
            font-weight: bold;
            padding: 2px 5px;
            background-color: #fbf9f9;
            border: 1px solid #c9c9c9;
        }

        .InvstFieldTd {
            padding: 5px 10px;
            border: 1px solid #c9c9c9;
            background-color: white;
        }

        .InfoIconPopup {
            font-size: 14px;
            margin-right: 10px;
            color: #398ebd;
            cursor: pointer;
            padding-left: 5px;
        }

        .OutsideGroup {
            width: 150px;
        }

        .ResultDate {
            width: 110px;
            display: inline-block;
        }

        .AddInvstNew {
            display: inline-block;
            font-size: 18px;
            margin-left: 10px;
                cursor: pointer;
        }

        .DelInvst {
            display: inline-block;
            font-size: 18px;
            margin-left: 10px;
            color: #ff0000;
                cursor: pointer;
        }
        .TestDateTd{
            min-width: 175px;
        }
        .ResultVal {
            width: 110px;
        }

        .HeadTestDateTd {
            text-align: left !important;
        }

        .TestCodeTd {
            min-width: 100px;
        }

        .InvstCodeTd {
            min-width: 100px;
        }

        .TestNameTd {
            min-width: 200px !important;
        }

        .RemoveTextBoxStyle {
            background-color: #e1efff !important;
            border: none;
            color: black;
            font-weight: bold;
            box-shadow: none;
        }
    </style>

    <%-- Setup --%>
    <style>
        .invsAddspan {
            float: right;
            margin-right: 6px;
            margin-top: -28px;
            position: relative;
            z-index: 2;
            color: #3d7da3;
            cursor: pointer;
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


        #tblPersInvestigationlist > tbody > tr > td {
            border-top: 1px solid rgba(234, 228, 228, 0.32) !important;
        }

        .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
            color: #000;
            font-weight: normal;
            font-size: small;
        }

        @media only screen and (min-width : 992px) {
            .divtblInvestigation {
                height: 500px !important;
                overflow-y: hidden !important;
            }

                .divtblInvestigation:hover {
                    overflow-y: scroll !important;
                    transition-duration: 0.4s;
                    transition-timing-function: cubic-bezier(0.36, 0.55, 0.19, 1);
                }
        }

        .divtblInvestigation {
            height: 300px;
            overflow-y: scroll;
        }

        div.divtblInvestigation::-webkit-scrollbar {
            width: 7px;
        }

        div.divtblInvestigation::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        div.divtblInvestigation::-webkit-scrollbar-thumb {
            background: #b4b6f2;
            border-radius: 3px;
        }

        div.divtblInvestigation:hover {
            overflow-y: scroll;
        }

        #tblinvestigate tr td:not(:first-child) {
            width: 10%;
            text-align: center;
        }

            #tblinvestigate tr td:not(:first-child) a {
                width: 98%;
                display: block;
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

        .HeadRemark {
            width: 15.8%;
        }

        .empty {
            width: 50%;
        }

        @media only screen and (min-device-width : 1024px)and (max-device-width : 1152px) { /*//*/

            .HeadRemark {
                width: 16.2%;
            }
        }

        .Headdur {
            width: 19.9%;
        }

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) { /*//*/
            .empty {
                width: 65%;
            }

            .duration {
                width: 12% !important;
            }

            day-td {
                width: 12% !important;
            }

            .HeadRemark {
                width: 16.7%;
            }

            .Headdur {
                width: 22.3%;
            }

            .HeadPatTab > thead > tr > th {
                text-align: center;
                border: 1px solid #ede4e4;
                height: 22px;
                font-size: 10px;
            }
        }

        .TestListSearchDiv {
            display: flex;
            padding: 5px 0px;
        }

        .TestListSearchChk {
        }

        .TestListSearchLbl {
            padding-left: 5px;
            font-size: 14px;
        }
    </style>

    <style>
        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 25px;
            vertical-align: middle;
            margin-right: 10px;
        }

            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: 0.4s;
            border-radius: 34px;
        }

            .slider:before {
                position: absolute;
                content: "";
                height: 20px;
                width: 20px;
                left: 3px;
                bottom: 3px;
                background-color: white;
                transition: 0.4s;
                border-radius: 50%;
            }

        input:checked + .slider {
            background-color: #28a745;
        }

            input:checked + .slider:before {
                transform: translateX(25px);
            }

        .switch-label {
            position: absolute;
            width: 100%;
            text-align: center;
            color: white;
            font-size: 12px;
            line-height: 26px;
            font-weight: bold;
            pointer-events: none;
        }
    </style>

    <%-- Medicine  --%>
    <style>
        .SearchListDiv {
            max-width: 100%;
            display: block;
            margin-top: 0px;
            z-index: 100000;
            position: absolute;
            background-color: rgb(251, 251, 251);
            border: 1px solid black;
            padding: 0px 5px;
            overflow-y: auto;
            height: 100px;
            top: 40px;
        }


        .table-responsive {
            overflow-x: auto;
        }

        .MedicineTbl td, th {
            text-align: center;
            vertical-align: middle !important;
        }

        .MedicineTbl {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            font-family: Arial, sans-serif;
            font-size: 14px;
            color: #333;
        }

            .MedicineTbl th, .MedicineTbl td {
                border: 1px solid #ccc;
                padding: 8px 10px;
                text-align: center;
            }

            .MedicineTbl thead {
                font-weight: bold;
                background-color: #2d70aa;
                color: white;
            }

            .MedicineTbl tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

        .tdCombo {
            padding: 8px 0px !important;
            text-align: center;
        }

        .tdtxt {
            padding: 0px !important;
            text-align: center;
        }

        .editable-text {
            width: 100%;
            border: none;
            background: transparent;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding: 0;
            margin: 0;
            font: inherit;
            color: inherit;
            cursor: pointer;
            text-align: center;
            resize: none;
            box-shadow: none;
        }

            .editable-text:focus {
                outline: none;
                box-shadow: none;
            }

        .editable-select {
            width: 100%;
            border: none;
            background: transparent;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding: 0;
            margin: 0;
            font: inherit;
            color: inherit;
            cursor: pointer;
            text-align: center;
        }

            .editable-select:focus {
                outline: none;
            }

        .MedDelIcon {
            font-size: 20px;
            color: #c70000;
            cursor:pointer;
        }
      .MedInfoIcon {
    font-size: 20px !important;
    color: #2d70aa;
    cursor:pointer;
}
    </style>

    <style>
    /* Make table cells align to the top */
    #TableInd td,
    #TableRev td,
    #TablePONV td,
    #TableMaint td,
    #TablePreop td
    {
        vertical-align: top !important;
    }

    /* Ensure inputs stretch to full cell height */
    #TableInd .tdtxt input,
    #TableRev .tdtxt input,
    #TablePONV .tdtxt input,
    #TableMaint .tdtxt input,
    #TablePreop .tdtxt input
    {
        height: 100%;
        min-height: 40px;       /* Adjust as needed */
        box-sizing: border-box;
    }

    /* Optional: give consistent padding */
    #TableInd td,
    #TableRev td,
    #TablePONV td,
    #TableMaint td,
    #TablePreop td {
        padding: 6px 8px;
    }
    .tdtxt input {
        height: 100%;
        width: 100%;
    }

    </style>
   <%-- Added By Roshan CIMS Info 20251208 --%>

   <%-- Added By Roshan CIMS Info 20251208 --%>
         <style type="text/css">

          .CIMS-container {
              padding: 10px 0px;
              background-color: #f8fbff;
              border-radius: 8px;
              box-shadow: 0 4px 10px rgba(0,0,0,0.1);
              font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
              /*height: 95%;
              width: 98%;*/
              position: relative;
          }

          .CIMS-header {
              margin-top: 0;
              margin-bottom: 5px;
              color: #003366;
              padding-bottom: 5px;
              height: 7%;
              font-size: 1em;
              font-weight: 700;
              background-color: #0d2b46;
              text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
              letter-spacing: 0.5px;
              border-bottom: 1px solid gray;
          }

          .CIMS-footer {
              padding: 5px;
              /*border-top: 1px solid #ddd;*/
              background-color: #f9f9f9;
          }

          .CIMS-footer button {
               margin-left: 10px;
          }

          .CIMS-footer {
              text-align: center;
              position: absolute;
              bottom: 0;
              height: 7%;
              width: 95%;
          }

          .CIMS-body {
              max-height: 86%;
              height: 86%;
              width:100%;
              overflow-y: auto; /* Enables vertical scrolling */
              overflow-x: hidden; /* Prevents horizontal scroll */
              padding-right: 10px; /* Optional: avoid content hiding behind scrollbar */
              box-sizing: border-box;
              font-size:14px;
      
          }
          #CIMSBody::-webkit-scrollbar {
              width: 8px;   /* Increase width */
              display:none !important;
          }

          @keyframes professionalBlink {
              0% {
                  opacity: 1;
                  transform: scale(1);
              }

              25% {
                  opacity: 0.6;
                  transform: scale(1.05);
              }

              50% {
                  opacity: 1;
                  transform: scale(1);
              }

              75% {
                  opacity: 0.6;
                  transform: scale(1.05);
              }

              100% {
                  opacity: 1;
                  transform: scale(1);
              }
          }

          /* Class to apply blinking */
          .CIMS-blinking {
              animation: professionalBlink 1s infinite;
              transition: all 0.3s ease;
          }

          .ui-dialog[aria-describedby="divCIMSInfo"] .ui-dialog-titlebar {
              display: none !important;
          }

          .ui-dialog[aria-describedby="divCIMSInfo"] {
              padding-top: 0 !important;
          }

          .CIMS-close {
             position: absolute;
             top: 15px;
             right: 25px;
             color: #ffffff;
             font-size: 25px;
             font-weight: bold;
             cursor: pointer;
             line-height: 1;
          }

          .CIMS-close:hover {
             color: #ff4d4d;
          }

        </style>
    <%-- Anaesthesia Type List - Pournima 15th July 2026 --%>
    <style type="text/css">
        .AnaesthesiaRow {
            display: flex;
            align-items: center;
            border: 1px solid #4cddb3;
            background-color: #b2d6c4;
            margin: 5px 5px;
            border-radius: 10px;
            padding: 2px 0px;
            cursor: pointer;
        }

        .lblAnaesType{
            margin-right: 6px;
            margin-left: 6px;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
        // Added by Dhananjay 20260407 
        var CIMS_BLINKING_ENABLE_FORMS = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_BLINKING_ENABLE_FORMS")%>';

        const IS_DISPLAY_CIMS_FUNCTIONLITY = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("IS_DISPLAY_CIMS_INTEGRATION")%>';  // Added By Roshan - 12/10/2025
        function toggleInfoColumn() {
            if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                $(".th-info").show();
            } else {
                $(".th-info").hide();
            }
        }
        var CIMS_blinkIds_PAC = {
            P: ['btnInformant', 'btnDuplicate','btnAllergy'],
            I: ['btnInformantInd', 'btnDuplicateInd','btnAllergyInd'],
            M: ['btnInformantMaint', 'btnDuplicateMaint','btnAllergyMaint'],
            R: ['btnInformantIndRev', 'btnDuplicateRev','btnAllergyRev'],
            N: ['btnInformantPONV', 'btnDuplicatePONV','btnAllergyPONV'],
        }

        // Function to show/hide buttons based on grid row count
        function toogleButtonsPAC(TableType) {
            var rowCount = 0;
            for (var i = 0; i < AllMedListForSave.length; i++) {
                var rowData = AllMedListForSave[i];
                if (rowData.TYPE == TableType) {
                    rowCount++;
                }
            }
            if (rowCount >= 2) {
                $('#' + CIMS_blinkIds_PAC[TableType][0] + ',' + '#' + CIMS_blinkIds_PAC[TableType][1] + ',' + '#' + CIMS_blinkIds_PAC[TableType][2]).show();
                subscribeCIMSServicesPAC("", TableType);
            } else {
                $('#' + CIMS_blinkIds_PAC[TableType][0] + ',' + '#' + CIMS_blinkIds_PAC[TableType][1] + ',' + '#' + CIMS_blinkIds_PAC[TableType][2]).stop(true, true).hide();
            }
        }

        function preapreDataForCIMS(TableType) {
            var MaterialCodes = [];
            for (var i = 0; i < AllMedListForSave.length; i++) {
                var rowData = AllMedListForSave[i];
                if (rowData.TYPE == TableType) {
                    MaterialCodes.push(rowData.DRUGCODE);
                }
            }

            let mrno = '';
            let ipno = '';
            let moduleFlag = sessionStorage.getItem('MODULE_FLAG') || '';
            if (moduleFlag && moduleFlag == 'IPD') {
                mrno = sessionStorage.getItem('IPPatMRNO') || ' ';
                ipno = sessionStorage.getItem('IPPatIPNO') || ' ';
            }
            else if (moduleFlag && moduleFlag == 'OPD') {
                mrno = sessionStorage.getItem('PatMRNO') || ''
                ipno = '';
            }
            else if (moduleFlag && moduleFlag == 'PAC') {
                mrno = sessionStorage.getItem('PACPatMRNO') || ''
                ipno = '';
            }

            var DataToSend = {
                DrugCodes: JSON.stringify(MaterialCodes),
                Type: "html",
                Mrno: mrno,
                Ipno: ipno
            };
            return DataToSend;
        }

        function subscribeCIMSServicesPAC(type, TableType) {
            if (type == "I") {
                GetDrugInterationService(TableType).then(function (response) {
                    $('#CIMSBody').empty();
                    if (response && response == "0") {
                        ToastMsg('Kindly Contact IT', 'Warning');
                    } else {
                        if (typeof response == 'object') {
                            if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                                // Append the HTML to #CIMSBody
                                debugger;
                                var iframe = createResponsiveIframe(response.HtmlText);
                                $('#CIMSBody').html(iframe);
                                $('.CIMS-header-child').text("Drug Interaction");
                                $('#divCIMSInfo').dialog('open');
                            } else {
                                ToastMsg(response.Status, 'Information');
                            }
                        }
                    }
                }).catch(function (error) {
                    ToastMsg('Kindly Contact IT', 'Warning');
                });

            } else if (type == "D") {
                GetDrugDuplicateService(TableType).then(function (response) {
                    $('#CIMSBody').empty();
                    if (response && response == "0") {
                        ToastMsg('Kindly Contact IT', 'Warning');
                    } else {
                        if (typeof response == 'object') {
                            if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                                // Append the HTML to #CIMSBody
                                var iframe = createResponsiveIframe(response.HtmlText);
                                $('#CIMSBody').html(iframe);
                                $('.CIMS-header-child').text("Drug Duplicate");
                                $('#divCIMSInfo').dialog('open');
                            } else {
                                ToastMsg(response.Status, 'Information');
                            }
                        }
                    }
                }).catch(function (error) {
                    ToastMsg('Kindly Contact IT', 'Warning');
                });

            }
            else if (type == "A") {

                GetDrugAllergyService(TableType).then(function (response) {
                    $('#CIMSBody').empty();
                    if (response && response == "0") {
                        ToastMsg('Kindly Contact IT', 'Warning');
                    } else {
                        if (typeof response == 'object') {
                            if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                                // Append the HTML to #CIMSBody
                                var iframe = createResponsiveIframe(response.HtmlText);
                                $('#CIMSBody').html(iframe);
                                $('.CIMS-header-child').text("Drug Duplicate");
                                $('#divCIMSInfo').dialog('open');
                            } else {
                                ToastMsg(response.Status, 'Information');
                            }
                        }
                    }
                }).catch(function (error) {
                    ToastMsg('Kindly Contact IT', 'Warning');
                });

            }

            else {

                let informationId = CIMS_blinkIds_PAC[TableType][0];
                let dublicateId = CIMS_blinkIds_PAC[TableType][1];
                let allergyId = CIMS_blinkIds_PAC[TableType][2];

                debugger;

                if (isCimsBlinkingEnabled('PAC')) {

                    // Default: fetch both services to determine alert states and toggle buttons visually
                    GetDrugInterationService(TableType).then(function (response) {
                        $('#CIMSBody').empty();
                        if (response && response == "0") {
                            // ignore
                        } else {
                            if (typeof response == 'object') {
                                if (response.AlertYN == true) {
                                    // Blink("#" + CIMS_blinkIds_PAC[TableType][0]);
                                    onBlinkColorModifications(informationId, response.ColorName, true);
                                } else {
                                    //  stopBlink("#" + CIMS_blinkIds_PAC[TableType][0]);
                                    onBlinkColorModifications(informationId, '', false);
                                }
                            }
                        }
                    }).catch(function (error) {
                        ToastMsg('Kindly Contact IT', 'Warning');
                    });

                    GetDrugDuplicateService(TableType).then(function (response) {
                        $('#CIMSBody').empty();
                        if (response && response == "0") {
                            // ignore
                        } else {
                            if (typeof response == 'object') {
                                if (response.AlertYN == true) {
                                    // Blink("#" + CIMS_blinkIds_PAC[TableType][1]);
                                    onBlinkColorModifications(dublicateId, response.ColorName, true);
                                } else {
                                    onBlinkColorModifications(dublicateId, '', false);
                                    //  stopBlink("#" + CIMS_blCIMS_blinkIds_PACinkIds[TableType][1]);
                                }
                            }
                        }
                    }).catch(function (error) {
                        ToastMsg('Kindly Contact IT', 'Warning');
                    });

                    GetDrugAllergyService(TableType).then(function (response) {
                        $('#CIMSBody').empty();
                        if (response && response == "0") {
                            // ignore
                        } else {
                            if (typeof response == 'object') {
                                if (response.AlertYN == true) {
                                    // Blink("#" + CIMS_blinkIds_PAC[TableType][1]);
                                    onBlinkColorModifications(allergyId, response.ColorName, true);
                                } else {
                                    //  stopBlink("#" + CIMS_blCIMS_blinkIds_PACinkIds[TableType][1]);
                                    onBlinkColorModifications(allergyId, '', false);
                                }
                            }
                        }
                    }).catch(function (error) {
                        ToastMsg('Kindly Contact IT', 'Warning');
                    });
                }
            }
        }

        function createResponsiveIframe(htmlText, height = "600px") {

            var iframe = document.createElement("iframe");
            iframe.style.width = "100%";
            iframe.style.height = '72vh';
            iframe.style.border = "none";
            iframe.style.display = "block"; // avoids gaps

            iframe.onload = function () {
                try {
                    var doc = iframe.contentWindow.document;
                    doc.open();
                    doc.write(htmlText);
                    doc.close();
                } catch (e) {
                    console.error(e);
                }
            };

            iframe.src = "about:blank";

            return iframe;
        }

            function GetDrugInterationService(gridId) {
                return new Promise(function (resolve, reject) {
                    $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        url: '../DoctorDesk/GetDrugInteration',
                        data: preapreDataForCIMS(gridId),
                        cache: false,
                        success: function (response) {
                            resolve(response);
                        },
                        error: function (xhr, status, error) {
                            reject(true);
                        },
                        complete: function () {
                        }
                    });
                });
            }

            function GetDrugDuplicateService(gridId) {
                return new Promise(function (resolve, reject) {
                    $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        url: '../DoctorDesk/GetDrugDuplicate',
                        data: preapreDataForCIMS(gridId),
                        cache: false,
                        success: function (response) {
                            resolve(response);
                        },
                        error: function (xhr, status, error) {
                            reject(true);
                        },
                        complete: function () {
                        }
                    });
                });
            }

            function GetDrugAllergyService(gridId) {
                return new Promise(function (resolve, reject) {
                    $.ajax({
                        type: 'POST',
                        datatype: 'json',
                        url: '../DoctorDesk/GetDrugAllergy',
                        data: preapreDataForCIMS(gridId),
                        cache: false,
                        success: function (response) {
                            resolve(response);
                        },
                        error: function (xhr, status, error) {
                            reject(true);
                        },
                        complete: function () {

                        }
                    });
                });
            }

            function isCimsBlinkingEnabled(cims_current_tablename) {

                if (typeof CIMS_BLINKING_ENABLE_FORMS === 'undefined' || !CIMS_BLINKING_ENABLE_FORMS || !cims_current_tablename) {
                    return false;
                }

                const rawValue = (CIMS_BLINKING_ENABLE_FORMS || '');
                const formList = rawValue
                    .split(',')
                    .map(f => f.trim())
                    .filter(f => f);
                return formList.includes(cims_current_tablename);
            }


            function onBlinkColorModifications(id, colorName, isAlert) {
                var $btn = $("#" + id);

                if ($btn.length === 0) {
                    console.warn("Element not found for id:", id);
                    return;
                }

                if (!colorName || colorName.trim() === "") {
                    colorName = "gray";
                };

                if (isAlert) {
                    Blink("#" + id);
                } else {
                    stopBlink("#" + id);
                }

                // Change SVG colors
                $btn.find("rect").attr("fill", colorName);   // background square
                $btn.find("path").attr("stroke", "#ffffff"); // keep icon white (or change if needed)
            }


            function Blink(selector) {
                $(selector).addClass('CIMS-blinking').show(); // show and add blink effect
            }

            // Stop blink
            function stopBlink(selector) {
                $(selector).removeClass('CIMS-blinking').css("opacity", "1"); // remove animation
            }

            function getDrugInfo(mtrlCode) {
                return new Promise(function (resolve, reject) {
                    $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        url: '../DoctorDesk/GetDrugInformation',
                        cache: false,
                        data: { DrugCode: mtrlCode },
                        success: function (response) {
                            $('#CIMSBody').empty();
                            if (response && response == "0") {
                                ToastMsg('Kindly Contact IT', 'info');
                                resolve(true);
                            } else {
                                if (typeof response == 'object') {
                                    if (response.HtmlText) {
                                        // Append the HTML to #
                                        var iframe = createResponsiveIframe(response.HtmlText);
                                        $('#CIMSBody').html(iframe);
                                        $('.CIMS-header-child').text("Drug Information");
                                        $('#divCIMSInfo').dialog('open');
                                    } else {
                                        ToastMsg(response.Status, "info");
                                    }
                                }
                                resolve(response);
                            }
                        },
                        error: function (xhr, status, error) {
                            reject(true);
                        },
                        complete: function () {
                            //    ajaxindicatorstop();
                        }
                    });
                });
            }

            $(document).ready(function () {
                // Initialize dialog
                $('#divCIMSInfo').dialog({
                    autoOpen: false,
                    modal: true,
                    width: '85vw',
                    height: 600,
                    resizable: false,
                    title: "",
                    draggable: false,
                    position: {
                        my: "center top",   // align dialog's top center
                        at: "center top+60", // push 80px down from top
                        of: window
                    },
                    open: function () {
                        $("body > *:not(.ui-dialog)").addClass("blurred");
                        $("body").css("overflow", "hidden");
                    },
                    close: function () {
                        $("body > *").removeClass("blurred");
                        $("body").css("overflow", "");
                    }
                });

                $('#CIMSBody').on('click', 'a[href^="#"]', function (e) {
                    e.preventDefault();
                    const targetId = $(this).attr('href').substring(1);
                    const $target = $('#CIMSBody').find('#' + targetId);

                    if ($target.length) {
                        const scrollTop = $target.position().top + $('#CIMSBody').scrollTop();
                        $('#CIMSBody').animate({ scrollTop: scrollTop }, 300);
                    }
                });
                $(document).on("blur", "#txtPVSMTemp", function () {

                    var val = $.trim($(this).val());

                    if (val === "")
                        return;

                    var num = parseFloat(val);

                    if (!isNaN(num)) {
                        $(this).val(num.toFixed(1));
                    }
                });
            });

    </script>
    <%-- <script src="../Scripts/_CimsCommon.js"></script>--%>
   <%-- End By Roshan CIMS Info 20251208 --%>
    <script src="../Scripts/PatList.js"></script>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>

    <%-- Global Decalaration --%>
    <script type="text/javascript">
        var MultiResultEntry = "Y";
        var ShowSelectDiv = "N";
        var MRNo = '<%=Model.MRNO %>';
        var Gaction = '<%=Model.Gaction %>';
        var TranNo = '<%=Model.TRANNO %>';
        var SurgyTranNo = '<%=Model.SurgAdvConsNo %>';
        var PatVitalsList = [];
        var AllPACAdviceList = [];
        var AllPACTestAdviceList = [];
        var AllResultInvstList = [];
        var srvcgrpname = "dblServiceHelpsrvcgrp";
        var BckAllResultInvstList = [];
        var SearchInvestigationsList = [];
        var SpecialityRefList = [];
        var SpecialityTypeList = [];
        var ICDDiagnosis = "";
        var TemplateRef = "This is a case of {FIELDONE} who is awaiting for planned surgery: {FIELDTWO} under anaesthesia, kindly do assess the patient for _____________________ and give your valuable clinical opinion.";
        var GeneralWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';
        var OTNotesNo = '<%=Model.OTNotesNo %>';
        <% var SampMainView = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var FormLinkRouteList = <%:Html.Raw(SampMainView.Serialize(ViewBag.FormLinkRouteList))%>;
        var pacSTATUS = sessionStorage.getItem("PACSTATUS") || "";
    </script>  

    <%-- Form Load  --%>
    <script type="text/javascript">
        $(document).ready(function (e) {
            $('input').attr('autocomplete', 'off');
            DispAddPatient = false;
          
/*            sessionStorage.setItem('PatCompleted', 'N');*/
            if (sessionStorage.getItem('PatCompleted') == "Y") { 
               document.getElementById("BtnSave").style.display = "none";
                //document.getElementById("BtnEdit").style.display = "none";
                document.getElementById("DivEditChange").style.display = "none";
                document.getElementById("btnAddRef").style.display = "none";
                document.getElementById("PrintDiv").style.display = "flex";
                document.getElementById("PrintDiv_Top").style.display = "flex";
                Gaction = "D";
                if (OTNotesNo === "" && (Gaction === "D" || Gaction === "V")) {
                    document.getElementById("BtnEdit").style.display = "inline-block";
                }
                else {
                    document.getElementById("BtnEdit").style.display = "none";
                }
            }
            $('#SettingDrpdown').css('display', 'none');
            $("#PatHistory").hide();
            $("#menuDots").hide();
            $(".triggerInputBP").on("input", function () {
                $(this).val($(this).val().replace(/\D/g, ''));
                if ($(this).val() > 300) {
                    $(this).val(300);
                }
            });
            $(".triggerInputBP").attr('maxlength', '3');
            const contentDiv = document.getElementById('ContentHolderDiv');
            const lastCheckedMap = {};
            contentDiv.addEventListener('click', function (e) {
                if (e.target && e.target.type === 'radio') {
                    const groupName = e.target.name;
                    if (lastCheckedMap[groupName] === e.target) {
                        e.target.checked = false;
                        lastCheckedMap[groupName] = null;
                    } else {
                        lastCheckedMap[groupName] = e.target;
                    }
                    CalcRiskPPCRate();
                    CalcChildPughScore();
                    UpdateCurrDateTime();
                    EnDisAnesthesiaType();
                    //priyanka 19/11/2025
                    if ($("#rbtnINC4").prop("checked") === true) {
                        $("#txtINCOther").show();
                    } else {
                        $("#txtINCOther").hide();
                        $("#txtINCOther").val("");
                    }

                    if ($("#rbtnAPSFITSTSW").prop("checked") === true) {
                        $("#cmbASARisk").css('display', 'inline-block');
                    }
                    else {
                        $("#cmbASARisk").css('display', 'none');
                    }
                    //end  
                }
            });

            if ((MRNo != null && MRNo != "") && (SurgyTranNo == null || SurgyTranNo == "") && Gaction != "D") {
                ToastMsg("There is currently no pending surgery advice for the selected patient.", "info");
            }
            else {
                PatientInfoLoad();
                AdviceSurgeryInfoLoad();
                PatVitalMsrmntInfoLoad();
                GeneralPhyExamInfoLoad();
                ComoTreatHistInfoLoads();
                SubsAbuseHistInfoLoad();
                AirwayAssmntInfoLoad();
                SysExamInfoLoad();
                ARISCATCritInfoLoad();
                BindReviLeeCardRskInfoGaction();
                ReviLeeCardRskInfoLoad();
                ChildPughScrInfoLoad();
                InvestigationInfoLoad();
                SpecialityRefInfoLoad();
                ASAInfoLoad();
                AnaestAdvOrdInfoLoad();
                AnaethesiaPlanLoad();
                CancerCareHistoryInfoLoad();
            }
            $("#PatInfoDown").trigger('click');
            if (Gaction == "D" || Gaction == "V" ) {
                document.querySelectorAll('#ContentHolderDiv input, #ContentHolderDiv select, #ContentHolderDiv textarea, #ContentHolderDiv button').forEach(function (el) { el.disabled = true });
                $("#BtnResultInvst").prop("disabled", false);
                $("#BtnPrintInvst").prop("disabled", false);
                $("#BtnVisitInfoPrint").prop("disabled", false);
                $("#BtnPACLogInfo").prop("disabled", false);
                $("#previousPrep").css('display', 'none');
                $("#CancerCareHist").css('display', 'none');
                $("#InvestRpt").css('display', 'none');
                $("#PACHistory").show();
                $("#BtnPACHistory").removeAttr("disabled");
                $("#PersMedi").show();
                $("#PACInvestigation_Setup").removeAttr("disabled");
                $("#PACForm_BackBtn").removeAttr("disabled");
                $("#BtnPACCopyAll").prop("disabled", false);
                $("#btnGPECopy").prop("disabled", false);
                $("#btnCTHCopy").prop("disabled", false);
                $("#btnSAHCopy").prop("disabled", false);
                $("#btnAirAssmt").prop("disabled", false);
                $("#btnSysExm").prop("disabled", false);
                $("#btnARISCAT").prop("disabled", false);
                $("#btnCardiacCopy").prop("disabled", false);
                $("#BtnCopyInvst").prop("disabled", false);
                $("#bntcopyASA").prop("disabled", false);
                $("#BtnCoptAnthsPln").prop("disabled", false);
                $("#btnCopyPatientVital").prop("disabled", false);
                $("#btnCopyInductionMed").prop("disabled", false);
                $("#BtnCopyAnaesth").prop("disabled", false);
                $("#btnChildPughCopy").prop("disabled", false);
                $("#BtnCopySpeRef").prop("disabled", false);

                if (Gaction == "V") {
                    $("#BtnSave").prop("disabled", false);
                    $("#BtnEdit").prop("disabled", false);
                    document.getElementById("BtnSave").style.display = "block";
                    document.getElementById("BtnSave").innerText = "Approve";
                    document.getElementById("BtnUpdate").style.display = "inline-block";
                    document.getElementById("BtnReview").style.display = "inline-block";
                    document.getElementById("BtnEdit").style.display = "inline-block"; //Pournima 20th Aug 2026
                     //document.getElementById("BtnApprovel").style.display = "none";
                    $("#BtnUpdate").removeAttr("disabled");
                    $("#BtnReview").removeAttr("disabled");
                    //commented by priyanka 22/04/2026
                    //$("#ChkPACYN").prop("checked", false);
                    //toggleSwitchLabel('ChkPACYN');
                    //$("#ChkVisitYN").prop("checked", false);
                    //toggleSwitchLabel('ChkVisitYN');
                    //end
                    $("#ChkPACYN").prop("disabled", true);
                    $("#ChkVisitYN").prop("disabled", true);

                    document.querySelectorAll('input[name="APSFITSTS"]').forEach(function (el) {
                        el.disabled = true;
                    });
                    $("#ChkPACReview").prop("disabled", true);
               
                    if (sessionStorage.getItem("PACSTATUS") === "W") {
                        $("#PrintWDiv").css('display', 'inline-block');
                        $("#BtnPrevPrint").attr("disabled", false);
                    }
                    //priyanka 23/02/2026
                    if (sessionStorage.getItem("PACSTATUS") === "A") {
                        $("#PACPrint").css('display', 'inline-block');
                        $("#PrintDiv").css('display','inline-block')
                        $("#BtnPACPrint").removeAttr("disabled");
                        $("#BtnPrint").removeAttr("disabled");
                        $("#ChkPACReview").removeAttr("disabled");
                    }
                    else {
                        $("#PACPrint").css('display', 'none');
                        $("#BtnPACPrint").attr("disabled", true);
                        $("#PrintDiv").css('display', 'none');
                        $("#BtnPrint").attr("disabled", true);
                    }
                    //$("#DivContentAPS *").removeAttr("disabled");
                }
                else {
                    $("#BtnSave").prop("disabled", true);
                    //$("#BtnEdit").prop("disabled", true);
                    document.getElementById("DivEditChange").style.display = "none";
                    $("#PrintDiv_Top").css('display', 'none');
                }
                $("#BtnEdit").prop("disabled", false);
                $("#BtnPrint").prop("disabled", false);
                $("#BtnPrint_Top").prop("disabled", false);
                $("#PrintSpecialityRef").prop("disabled", false);
                $("#PrintSpecialityRef_Top").prop("disabled", false);
                $("#PrintPACInvstResult").prop("disabled", false);//priyanka 09/12/2025
                //priyanka 18/02/2026
                $("#ChkPACYN").removeAttr("disabled");
                $("#ChkVisitYN").removeAttr("disabled");
                $("#ChkPACYN").prop("disabled", true);
                $("#ChkVisitYN").prop("disabled", true);

            }


            $(document.body).on('click', '#investigationSetUpAdd', function (e) {
                InvestigationSetUpAddEdit(this);
            });
            $(document.body).on({
                'click': function (e) {
                    $("#dblServiceHelpsrvcgrp").show();
                },
                'focus': function (e) {
                    $("#dblServiceHelpsrvcgrp").show();
                },
            }, '#txtServiceGrpsearch');
            $(document.body).on('click', '#btnsrvgrp', function (e) {
                $('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);
            });
            $(document.body).on("click", "#spanAddNewInvtInSetUp", function (e) {
                $.confirm({
                    title: '',
                    closeIcon: true,
                    offsetTop: 10,
                    type: 'orange',
                    backgroundDismissAnimation: 'glow',
                    theme: 'bootstrap',
                    content: '' +
                    '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">New Investigation</label><br>' +
                    '<input  type="varchar" id="txtNewMInvst"  placeholder="Enter Text" autofocus="autofocus" class="setUp form-control" required />' +
                    '</div>' +

                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                if ($("#txtNewMInvst").val() == "" || $("#txtNewMInvst").val() == null) {

                                    $('#txtNewMInvst').css({ 'border-color': 'Red' });
                                    return false;

                                } else {
                                    $('#txtNewMInvst').css({ 'border-color': '' });
                                }
                                var invstName = $("#txtNewMInvst").val();
                                var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + invstName + "' value='" + "" + "' checked />" + "<label style='vertical-align:middle'>" + invstName + "</label></label><li>";
                                $(elemnet).insertAfter('a[id="btnsrvgrp"]');
                                $(elemnet).focus();
                                $("#dblServiceHelpsrvcgrp").show();
                                $("#divSrvcGrpGrid").show();
                            }
                        },
                        Closed: {
                            text: 'Cancel'
                        }
                    }
                });
            });

            if (ShowSelectDiv == "N") {
                const allUpArrow = document.querySelectorAll('.UpArrow');
                allUpArrow.forEach(function (div) { div.style.display = 'none' });
                const allDownArrow = document.querySelectorAll('.DownArrow');
                allDownArrow.forEach(function (div) { $("#" + div.id).trigger('click') });
            }
            if (Gaction == "N") {
                debugger;
                ShowHidePACHistoryIcon();
               //commented by priyanka 22/04/2026
                //$("#ChkPACYN").prop("checked", true);
                //toggleSwitchLabel('ChkPACYN');
                //$("#ChkVisitYN").prop("checked", true);
                //toggleSwitchLabel('ChkVisitYN');
                //end

                $("#previousPrep").css('display', 'none');
                $("#CancerCareHist").css('display', 'none');
                $("#InvestRpt").css('display', 'none');
                $("#PACHistory").show();
                $("#BtnPACHistory").removeAttr("disabled");
                $("#PersMedi").show();
                $("#PACInvestigation_Setup").removeAttr("disabled");
                $("#PACForm_BackBtn").removeAttr("disabled");
            }

                $("#previousPrep").click(function () {
                    var Mrno = (sessionStorage.getItem('PACPatMRNO')).toString();
                    if (Mrno != "") {
                        $.ajax({
                            type: 'POST',
                            url: '../DoctorDesk/RedirectToDicom',
                            data: { mrNo: Mrno },
                            success: function (data) {
                                HoldOn.close();
                                window.open(data);
                            },
                            error: function () {
                            }
                        });
                    }
                    else {
                        ToastMsg("Please Select Patient", "Information");
                        return false;
                    }
                });
            //priyanka 04/12/2025
            $("#txtPVSMTemp").change(function () {
                $('#txtPVSMTemp').val(Number($("#txtPVSMTemp").val()).toFixed(2));
            });
            //end
            
            //Added By Roshan For MasterPage 20/2/2026
            if (IsMasterpage == "Y") {
                $('.header_container,.slider, #MainSectRightMenu, #PACForm_BackBtn, #PACInvestigation_Setup, #PACHistory, #PACLogInfo, #BtnPrintInvst,#DivVisitTab,#MainDivINVST,#MainDivSPCREF,#MainDivAAPO,#MainDivMedicine,#BtnVisitInfoPrint').hide();
            }
            else {
                $('.header_container, #MainSectRightMenu').show();
            }

            if (sessionStorage.getItem('PACSTATUS') == "A") {
                document.getElementById("BtnSave").style.display = "none";
                document.getElementById("BtnEdit").style.display = "inline-block";
                document.getElementById("btnAddRef").style.display = "none";
                document.getElementById("divisit").style.display = "none";
                document.getElementById("PACInvestigation_Setup").style.display = "none";
                document.getElementById("PrintDiv").style.display = "flex";
                document.getElementById("PrintDiv_Top").style.display = "flex";
                Gaction = "D";
            }
            //Pournima 15th July 2026
            $("#cmbAneasthesiaType").change(function () {

                var Code = $(this).val();

                if (Code == "" || Code == null)
                    return;

                var Name = $("#cmbAneasthesiaType option:selected").text();

                var Exists = AllAnaesthesiaTypeList.some(function (x) {
                    return x.CODE == Code;
                });

                if (!Exists) {

                    var Obj = {
                        CODE: Code,
                        NAME: Name
                    };

                    AllAnaesthesiaTypeList.push(Obj);

                    BindAnaesthesiaTypeList([Obj], true);
                }
                $(this).val("");
            });

        });//End Ready
    </script>

    <%-- Patient Info --%>
    <script type="text/javascript">
        //Patient Info Load
        function PatientInfoLoad() {
            $('#txtPACWeight,#txtPACHeight,#txtPACBMI').blockInput({ regex: '[0-9.]' });
            $("#txtPACWeight,#txtPACHeight").on('keyup', function (e) {
                if (event.keyCode == 46 || event.keyCode == 8) {
                    $('#txtPACBMI').val("");
                }
            });
            $("#txtPACWeight,#txtPACHeight").change(function () {
                CalBMI();
            });
            $("#txtPACReviewDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                minDate: new Date(),
            });
           BindPatInfoGaction();
        }
        //Bind Patient Info Gaction
       function BindPatInfoGaction() {
            document.getElementById("DivEditChange").style.display = "none";
            if (Gaction == "N") {
                ClearTranInfo();
                CleartPatientInfo();
                document.getElementById("BtnSave").style.display = "block";
                document.getElementById("BtnSave").innerText = "Save";
                document.getElementById("BtnEdit").style.display = "none";
                //document.getElementById("PersMedi").style.display = "inline-block";
                document.getElementById("PACLogInfo").style.display = "none";
                $("#PersMedi").show();
                $("#PACInvestigation_Setup").removeAttr("disabled");
            }
            else if (Gaction == "V") {
                document.getElementById("BtnSave").style.display = "block";
                document.getElementById("BtnSave").innerText = "Approve";
                document.getElementById("PACLogInfo").style.display = "inline-block";
                document.getElementById("DivEditChange").style.display = "none";
                document.getElementById("BtnUpdate").style.display = "inline-block";
                document.getElementById("BtnReview").style.display = "inline-block";
                //document.getElementById("BtnApprovel").style.display = "none";
                document.getElementById("BtnEdit").style.display = "inline-block"; // Pournima 20th Aug 2026
                $("#BtnUpdate").removeAttr("disabled");
                $("#BtnReview").removeAttr("disabled");
                $("#BtnEdit").removeAttr("disabled"); // Pournima 20th Aug 2026
                $("#PersMedi").show();
                $("#PACInvestigation_Setup").removeAttr("disabled");
                //document.getElementById("BtnEdit").style.display = "none";

                if (OTNotesNo === "") {
                    document.getElementById("BtnEdit").style.display = "inline-block";
                }
                else {
                    document.getElementById("BtnEdit").style.display = "none";
                }

                //priyanka 23/02/2026
                if (IsMasterpage === "Y") {
                    document.getElementById("BtnSave").innerText = "Approve";
                    document.getElementById("PACLogInfo").style.display = "inline-block";
                    document.getElementById("BtnPACCopyAll").style.display = "inline-block";
                    document.getElementById("btnGPECopy").style.display = "inline-block";
                    document.getElementById("btnCTHCopy").style.display = "inline-block";
                    document.getElementById("btnSAHCopy").style.display = "inline-block";
                    document.getElementById("btnAirAssmt").style.display = "inline-block";
                    document.getElementById("btnSysExm").style.display = "inline-block";
                    document.getElementById("btnARISCAT").style.display = "inline-block";
                    document.getElementById("btnCardiacCopy").style.display = "inline-block";
                    document.getElementById("BtnCopyInvst").style.display = "inline-block";
                    document.getElementById("BtnCopySpeRef").style.display = "inline-block";
                    document.getElementById("BtnCopyAnaesth").style.display = "inline-block";
                    document.getElementById("btnChildPughCopy").style.display = "inline-block";
                    document.getElementById("BtnCoptAnthsPln").style.display = "inline-block";
                    document.getElementById("btnCopyPatientVital").style.display = "inline-block";
                    document.getElementById("bntcopyASA").style.display = "inline-block";
                }
            }
            else {
                document.getElementById("BtnSave").style.display = "none";
                if (OTNotesNo === "") {
                    document.getElementById("BtnEdit").style.display = "inline-block";
                }
                else {
                    document.getElementById("BtnEdit").style.display = "none";
                }
                //document.getElementById("BtnEdit").style.display = "none";
                document.getElementById("PrintDiv").style.display = "flex";
                document.getElementById("PrintDiv_Top").style.display = "flex";
                document.getElementById("PACLogInfo").style.display = "inline-block";
                $("#PersMedi").hide();
                $("#PACInvestigation_Setup").attr("disabled", true);

                if (IsMasterpage === "Y") {
                    document.getElementById("BtnPACCopyAll").style.display = "inline-block";
                    document.getElementById("btnGPECopy").style.display = "inline-block";
                    document.getElementById("btnCTHCopy").style.display = "inline-block";
                    document.getElementById("btnSAHCopy").style.display = "inline-block";
                    document.getElementById("btnAirAssmt").style.display = "inline-block";
                    document.getElementById("btnSysExm").style.display = "inline-block";
                    document.getElementById("btnARISCAT").style.display = "inline-block";
                    document.getElementById("btnCardiacCopy").style.display = "inline-block";
                    document.getElementById("BtnCopyInvst").style.display = "inline-block";
                    document.getElementById("BtnCopySpeRef").style.display = "inline-block";
                    document.getElementById("BtnCopyAnaesth").style.display = "inline-block";
                    document.getElementById("btnCopyInductionMed").style.display = "inline-block";
                    //document.getElementById("CopyAll").style.display = "inline-block";
                    document.getElementById("btnChildPughCopy").style.display = "inline-block";
                    document.getElementById("BtnCoptAnthsPln").style.display = "inline-block";
                    document.getElementById("btnCopyPatientVital").style.display = "inline-block";
                    document.getElementById("btnCopyInductionMed").style.display = "inline-block";
                    document.getElementById("bntcopyASA").style.display = "inline-block";
                }

                
            }
           //priyanka 18/02/2026
           $("#previousPrep").css('display', 'none');
           $("#CancerCareHist").css('display', 'none');
           $("#InvestRpt").css('display', 'none');
           $("#PACHistory").show();
           $("#BtnPACHistory").removeAttr("disabled");
            BindPatientDtls();
        }
        //Calculate BMI
        function CalBMI() {
            var sum = 0;
            $('#txtPACWeight').val(Number($("#txtPACWeight").val()).toFixed(2));
            $('#txtPACHeight').val(Number($("#txtPACHeight").val()).toFixed(2));
            sum = Number($("#txtPACWeight").val()) / (((Number($("#txtPACHeight").val())) / 100) * ((Number($("#txtPACHeight").val())) / 100));
            $('#txtPACBMI').val(sum == Infinity ? "0.00" : sum.toFixed(2));
            DefaultObesity();
        }
        //Clear Transaction Info
        function ClearTranInfo() {
            $("#txtPAC").val("");
            $("#txtPACDate").val("");
            Gaction = "N";
            document.getElementById("MainDivTranInfo").style.display = "flex"; 
    
        }
        //Clear Transaction Info
        function CleartPatientInfo() {
            $("#txtPACMRNO").val("");
            $("#txtPACPatName").val("");
            $("#txtPACPatAge").val("");
            $("#txtPACPatGen").val("");
            $("#txtPACAdmDoct").val("");
            $("#txtPACAdmDoctCode").val("");
            $("#ChkPACReview").prop("checked", false);
            $("#ChkPACReview").prop("disabled", true);
            $("#txtPACReviewDate").val("");
            $("#txtPACWeight").val("0.00");
            $("#txtPACHeight").val("0.00");
            $("#txtPACBMI").val("0.00");
            DefaultObesity();
        }
        //Check Review Pick Today Date
        function PickTodayDate() {
            var PrevFitDate = '<%=Model.ASADate %>';
            var PrevFitTime = '<%=Model.ASATime %>';
            $("#txtPACReviewDate").val("");
            if ($("#ChkPACReview").prop("checked") == true) {
                $("#txtPACReviewDate").datepicker("setDate", new Date());
                UpdateCurrDateTime();
                EnDisAnesthesiaType();
            }
        }
        //Bind Patient Details
        function BindPatientDtls() {
            if (sessionStorage.getItem('PACPatMRNO') != undefined && sessionStorage.getItem('PACPatMRNO') != "") {
                $("#txtPACMRNO").val(sessionStorage.getItem('PACPatMRNO'));
                $("#txtPACPatName").val(sessionStorage.getItem('PACPatName').split('(')[0].trim() || "");
                $("#txtPACPatAge").val(sessionStorage.getItem('PACPatAge'));
                $("#txtPACPatGen").val(sessionStorage.getItem('PACPatGender'));
            }
            $("#txtPACAdmDoct").val('<%=Model.DoctorName %>');
            $("#txtPACAdmDoctCode").val('<%=Model.DoctorCode %>');
            if (Gaction != "N") {
                $("#txtPAC").val('<%=Model.TRANNO %>');
                $("#txtPACDate").val('<%=Model.TRANDT %>');
                $("#txtPACWeight").val('<%=Model.PatWeight %>');
                $("#txtPACHeight").val('<%=Model.PatHeight %>');
                $("#txtPACBMI").val('<%=Model.PatBMI %>');
            }
        }
       // Validation For Patient Info
        //Validation For Patient Info
        function ValidationForPatInfo() {
            if ($("#txtPACMRNO").val() == "") {
                ToastMsg("Please Select Patient", "Information");
                $("#PatInfoDown").trigger('click');
                return false;
            }
            if ($("#txtPACWeight").val() == "") {
                $("#PatInfoDown").trigger('click');
                $("#txtPACWeight").focus();
                $("#txtPACWeight").css("border-color", "red");
                return false;
            }
            if ($("#txtPACHeight").val() == "") {
                $("#PatInfoDown").trigger('click');
                $("#txtPACHeight").focus();
                $("#txtPACHeight").css("border-color", "red");
                return false;
            }
            return true;
        }
        //Patient Info Save Value Pass
        function SaveForPatInfo(PostData, GType) {
            PostData.push({ name: 'Gaction', value: GType != "E" ? Gaction : GType });
            /*PostData.push({ name: 'TRANNO', value: TranNo });*/
            PostData.push({ name: 'TRANNO', value: sessionStorage.getItem("PACConsltNo") });
            PostData.push({ name: 'SurgAdvConsNo', value: SurgyTranNo });
            PostData.push({ name: 'MRNO', value: $("#txtPACMRNO").val() });
            PostData.push({ name: 'ReviewYN', value: ($("#ChkPACReview").prop("checked") == true ? "Y" : "N") });
            PostData.push({ name: 'ReviewDate', value: $("#txtPACReviewDate").val() });
            PostData.push({ name: 'PatHeight', value: $("#txtPACHeight").val() });
            PostData.push({ name: 'PatWeight', value: $("#txtPACWeight").val() });
            PostData.push({ name: 'PatBMI', value: $("#txtPACBMI").val() });
            PostData.push({ name: 'RefPACTranNo', value: sessionStorage.getItem("PACRefPACTranNo") === "" ? TranNo : sessionStorage.getItem("PACRefPACTranNo") });//priyanka 19/02/2026
            return PostData;
        }

        //Patient Info Print
        function PrintPatientInfo(PrintData) {
            PrintData.push({ name: 'TRANNO', value: TranNo });
            PrintData.push({ name: 'TRANDT', value: $("#txtPACDate").val() });
            PrintData.push({ name: 'SurgAdvConsNo', value: SurgyTranNo });
            PrintData.push({ name: 'MRNO', value: $("#txtPACMRNO").val() });
            PrintData.push({ name: 'PatName', value: $("#txtPACPatName").val() });
            PrintData.push({ name: 'PatAge', value: $("#txtPACPatAge").val() });
            PrintData.push({ name: 'PatGender', value: $("#txtPACPatGen").val() });
            PrintData.push({ name: 'AdmDoctor', value: $("#txtPACAdmDoct").val() });
            PrintData.push({ name: 'ReviewYN', value: ($("#ChkPACReview").prop("checked") == true ? "Y" : "N") });
            PrintData.push({ name: 'ReviewDate', value: $("#txtPACReviewDate").val() });
            PrintData.push({ name: 'PatHeight', value: $("#txtPACHeight").val() });
            PrintData.push({ name: 'PatWeight', value: $("#txtPACWeight").val() });
            PrintData.push({ name: 'PatBMI', value: $("#txtPACBMI").val() });
            return PrintData;
        }
    </script>

    <%-- Advice Surgery Info --%>
    <script type="text/javascript">
        //Advice Surgery Info Load
        function AdviceSurgeryInfoLoad() {
            GetICDDiagnosis();
            BindAdviceSurgeryInfoGaction();
        }
        //Advice Surgery Info Gaction
        function BindAdviceSurgeryInfoGaction() {
            if (Gaction == "N") {
                CleartAdviceSurgeryInfo();
            }
            BindAdviceSurgeryDtls();
        }

        //Function Get ICD Diagnosis and ICD-O
        function GetICDDiagnosis() {
            if (SurgyTranNo != "") {
                var DataToSend = {
                    strTranNo: SurgyTranNo,
                    strMRNO: sessionStorage.getItem('PACPatMRNO')
                }
                $.ajax({
                    url: '../DoctorDesk/SetDataForDiagnosis',
                    type: 'post',
                    datatype: 'json',
                    data: DataToSend,
                    async: false,
                    success: function (data) {
                        ICDDiagnosis = "";
                        if (data.length > 0) {
                            if (data[1] != null) {
                                $.grep(data[1], function (a) {
                                    ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                                });
                                BindICDDiagnosisTable(data[1]);

                            }
                            else if (data[0] != null) {
                                $.grep(data[0], function (a) {
                                    ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                                });
                            }
                            BindICDODiagnosisTable((data[4] != null ? data[4] : []), (data[5] != null ? data[5] : []));
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
        }
        //Bind ICD Diagnosis Table
        function BindICDDiagnosisTable(Lst) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            $("#TableICDTBody").empty();
            $.grep(Lst, function (a) {
                var Code = a.ICDCODE;
                var Desc = a.NAME;
                var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                var RplTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd);
                $("#TableICDTBody").append(RplTr);
            });

        }
        //Bind ICD-O Diagnosis Table
        function BindICDODiagnosisTable(TLst, Lst) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            $("#TableICDOTBody").empty();
            $.grep(TLst, function (a) {
                var Code = a.TOPOCODE;
                var TopoNM = a.TOPODESC;
                var TNM = a.T + a.N + a.M;
                var HistoDesc = "";
                var HistoDescFilter = Lst.filter(function (A) { return A.SITELEVEL == a.SITELEVEL && A.TOPOCODE == a.TOPOCODE && A.TOPODESC == a.TOPODESC; });
                $.grep(HistoDescFilter, function (H) {
                    var RplHistoDesc = H.HCODE + " - " + H.HDESC + " - " + H.HGRADE;
                    HistoDesc = HistoDesc + (HistoDesc == "" ? (RplHistoDesc) : ("<br>" + RplHistoDesc))
                });
                var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                var TopoNMTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", TopoNM);
                var HistoDescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", HistoDesc);
                var TNMTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", TNM);
                var RplTr = Tr.replace("{TRCONTENT}", CodeTd + TopoNMTd + HistoDescTd + TNMTd);
                $("#TableICDOTBody").append(RplTr);
            });
            //$.grep(Lst, function (a) {
            //    var Code = a.TOPOCODE + a.HCODE + " " + a.HGRADE;
            //    var Desc = a.TOPODESC + "," + a.HDESC + "," + a.GRADENAME;
            //    var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
            //    var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
            //    var TNMFilter = TLst.filter(function (A) { return A.SITELEVEL == a.SITELEVEL && A.TOPOCODE == a.TOPOCODE && A.TOPODESC == a.TOPODESC; });
            //    var TNMValue = "";
            //    if (TNMFilter.length > 0) {
            //        TNMValue = TNMFilter[0].T + TNMFilter[0].N + TNMFilter[0].M;
            //    }
            //    var DisplayTNM = ShowTNMICDO != "Y" ? "display:none" : "";
            //    var TNMTd = Td.replace("{STYLE}", "style='text-align:center;" + DisplayTNM + "'").replace("{TDCONTENT}", TNMValue);
            //    var RplTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd + TNMTd);
            //    $("#TableICDOTBody").append(RplTr);
            //});
        }
        //Clear Advice Surgery Info
        function CleartAdviceSurgeryInfo() {
            $("#txtPACProcdPlanCode").val("");
            $("#txtPACProcdPlan").val("");
            $("#txtPACSchSurg").val("");
            UncheckRadioBtn('PACNATSURG');
            $("#txtPACProcdPlan").prop("readonly", true);
            $("#txtPACSchSurg").prop("readonly", true);
            $("#rbtnPACNATSURG1").prop("disabled", true);
            $("#rbtnPACNATSURG2").prop("disabled", true);
            $("#rbtnPACNATSURG3").prop("disabled", true);
            $("#ADVSURGDown").trigger('click');
            autoResize('txtPACProcdPlan');
            $("#ADVSURGUp").trigger('click');
        }
        //Bind Advice Surgery Info
        function BindAdviceSurgeryDtls() {
            $("#txtPACProcdPlanCode").val('<%=Model.PlannedSurgeryCodes %>');
            var PlanSurNm = '<%=HttpUtility.JavaScriptStringEncode(Model.PlannedSurgeryNM) %>'
            $("#txtPACProcdPlan").val(PlanSurNm.replace(/\\n/g, "\n"));
            $("#txtPACSchSurg").val('<%=Model.AdvicedSurgeryDate %>');
            var NatOfSurg = '<%=Model.SurgBookType %>';
            if (NatOfSurg != "")
                $("#rbtnPACNATSURG" + NatOfSurg).prop("checked", true);
            $("#ADVSURGDown").trigger('click');
            autoResize('txtPACProcdPlan');
            $("#ADVSURGUp").trigger('click');
        }
        //Validation For Advice Surgery Info
        function ValidationForAdviceSurgeryInfo() {
            return true;
        }
        //Advice Surgery Info Save Value Pass
        function SaveForAdviceSurgeryInfo(PostData) {
            PostData.push({ name: 'PlannedSurgeryCodes', value: $("#txtPACProcdPlanCode").val() });
            PostData.push({ name: 'AdvicedSurgeryDate', value: $("#txtPACSchSurg").val() });
            PostData.push({ name: 'SurgBookType', value: GetLastLetterCheckedRadio('PACNATSURG') });
            return PostData;
        }
        //Advice Surgery Info Print
        function PrintAdviceSurgeryInfo(PrintData) {
            PrintData.push({ name: 'PlannedSurgeryNM', value: $("#txtPACProcdPlan").val() });
            PrintData.push({ name: 'AdvicedSurgeryDate', value: $("#txtPACSchSurg").val() });
            PrintData.push({ name: 'SurgBookType', value: GetCheckRadioLabel("PACNATSURG") });
            return PrintData;
        }
    </script>

    <%-- Patient Vital Signs and Measurements --%>
    <script type="text/javascript">
        //Patient Vital Signs and Measurements Info Load
        function PatVitalMsrmntInfoLoad() {
            $('#txtPVSMTemp,#txtPVSMPulse,#txtPVSMSPO,#txtPVSMBrthTime,#txtPVSMBldPrs1,#txtPVSMBldPrs2').blockInput({ regex: '[0-9.]' });
            $("#txtPVSMDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                minDate: new Date(),
                maxDate: new Date(),
                onSelect: function () {
                    restrictTimeBasedOnDate();
                }
            });
            document.getElementById("txtPVSMTime").addEventListener("change", function () {
                var max = this.max;
                if (max == "") {
                    if ($("#txtPVSMDate").val() == "") {
                        ToastMsg("Please Select the Date", "Information");
                        this.value = "";
                        return;
                    }
                }
                if (max && this.value > max) {
                    ToastMsg("You cannot select a time in the future.", "Information");
                    const now = new Date();
                    const hours = now.getHours().toString().padStart(2, "0");
                    const minutes = now.getMinutes().toString().padStart(2, "0");
                    const currentTime = hours + ':' + minutes;
                    this.value = currentTime;
                }
            });
            BindPatVitalMsrmntInfoGaction();
        }
        //Patient Vital Signs and Measurements Info Gaction
        function BindPatVitalMsrmntInfoGaction() {
            FillBPList();
            if (Gaction == "N") {
                CleartPatVitalMsrmntInfo();
                DefaultVitalsDtls();
            }
            else {
                BindVitalsDtls();
                //if (sessionStorage.getItem("PACConsltNo") === sessionStorage.getItem("PACRefPACTranNo")) { //priyanka 25/02/2026
                //    BindVitalsDtls();
                //}
                
            }
        }
        //Fill List of BP
        function FillBPList() {
            var arreay = [];
            for (var i = 0; i <= 300; i++) {
                arreay.push(i.toString());
            }
            var len = $(".triggerInputBP").closest("input[type='text']").prevObject.length;
            for (var i = 0; i < len  ; i++) {
                var text = $(".triggerInputBP").closest("input[type='text']").prevObject[i];
                var txtObj = $("#" + text.id);
                txtObj.autocomplete({
                    source: arreay,
                    minLength: 0,
                    open: function (event, ui) {
                        $(".ui-autocomplete").css({
                            "max-height": "200px",
                            "overflow-y": "auto"
                        });
                    }
                }).focus(function () {
                    $(this).autocomplete("search", "");
                });
            }
        }
        //Get Default Vitals
        function DefaultVitalsDtls() {
            $.ajax({
                type: 'post',
                datatype: 'json',
                url: '../DoctorDesk/SetDataForVitals',
                async: false,
                data: { strTranNo: SurgyTranNo },
                success: function (data) {
                    if (data != "") {
                        var ConsltDate = '<%=Model.ConsultDate %>';
                        var ConsltTime = '<%=Model.ConsultTime %>';
                        ConsltTime = ConsltTime != "" ? (ConsltTime.split(':')[0] + ":" + ConsltTime.split(':')[1]) : "";
                        var found = false;
                        var rows = document.querySelectorAll("#tblPatVitalMsrmntsBody tr");
                        var targetDateTime = ConsltDate + " - " + ConsltTime;
                        rows.forEach(function (row) {
                            var dateTimeCell = row.cells[1].innerText.trim();
                            if (dateTimeCell === targetDateTime) {
                                found = true;
                            }
                        });
                        if (found)
                            return;
                        $("#txtPVSMDate").val('<%=Model.ConsultDate %>');
                        $("#txtPVSMTime").val(ConsltTime);
                        $("#txtPACWeight").val(data["Weight"]);
                        $("#txtPACHeight").val(data["HEIGHT"]);
                        $("#txtPACBMI").val(data["BMI"]);
                        $("#txtPVSMTemp").val(data["TEMP"]);
                        $("#txtPVSMPulse").val(data["PULSE"]);
                        if (data["BP"] != "") {
                            var strBP = data["BP"].toString();
                            var strSystolic = strBP.substring(0, strBP.indexOf("/"));
                            var strDiastolic = strBP.substring(strBP.indexOf("/") + 1);
                            $('#txtPVSMBldPrs1').val(strSystolic);
                            $('#txtPVSMBldPrs2').val(strDiastolic);
                        }
                        $("#txtPVSMSPO").val(data["SPO2"]);
                        $("#" + data["PAINSCORE"].toString() + "PainRadio").prop("checked", true);
                        $("#BtnVitalsAdd").trigger('click');
                        var EditVitalId = "EDITVITALS_" + PatVitalsList[PatVitalsList.length - 1].SEQNO;
                        var DelVitalId = "DELVITALS_" + PatVitalsList[PatVitalsList.length - 1].SEQNO;
                        document.getElementById(EditVitalId).style.display = "none";
                    }
                }
            });
        }

        //Clear Patient Vital Signs and Measurements Info
        function CleartPatVitalMsrmntInfo() {
            $("#txtSelRowId").val("");
            $("#txtPVSMDate").val("");
            $("#txtPVSMTime").val("");
            $("#txtPVSMTemp").val("");
            $("#txtPVSMPulse").val("");
            $("#txtPVSMBldPrs1").val("");
            $("#txtPVSMBldPrs2").val("");
            $("#txtPVSMSPO").val("");
            $("#txtPVSMBrthTime").val("");
            $("#txtPVSMDate").prop("readonly", true);
            document.querySelectorAll('input[type="radio"][name="radio-pain"]').forEach(function (radio) {
                radio.checked = false;
            });
            document.getElementById("BtnVitalsUpdate").style.display = "none";
            document.getElementById("BtnVitalsClear").style.display = "none";
            document.getElementById("BtnVitalsAdd").style.display = "block";
        }
        //Validation For Vital Add To Table
        function ValidationForAddVitalsTable(Type) {
            if ($("#txtPVSMDate").val() == "") {
                $("#PVSMDown").trigger('click');
                $("#txtPVSMDate").focus();
                $("#txtPVSMDate").css("border-color", "red");
                return false;
            }
            //if ($("#txtPVSMTime").val() == "") {
            //    $("#PVSMDown").trigger('click');
            //    $("#txtPVSMTime").focus();
            //    $("#txtPVSMTime").css("border-color", "red");
            //    return false;
            //}
            var PainFlag = false;
            document.querySelectorAll('input[type="radio"][name="radio-pain"]').forEach(function (radio) {
                if (radio.checked)
                    PainFlag = true;
            });
            if ($("#txtPVSMTemp").val() == "" && $("#txtPVSMPulse").val() == "" && $("#txtPVSMBldPrs1").val() == "" && $("#txtPVSMBldPrs2").val() == ""
                && $("#txtPVSMSPO").val() == "" && $("#txtPVSMBrthTime").val() == "" && PainFlag == false) {
                ToastMsg("Please Enter atleast one field", "Information");
                return false;
            }
            var VitalsFlag = false;
            //$.grep(PatVitalsList, function (a) {
            //    if (a.VITALDATE.trim() == $("#txtPVSMDate").val().trim()) {
            //        if (Type == "E") {
            //            if($("#txtSelRowId").val() != a.SEQNO)
            //                VitalsFlag = true;
            //        }
            //        else {
            //            VitalsFlag = true;
            //        }
            //    }
            //});
            if (VitalsFlag) {
                ToastMsg(("Already Vitals have enter for " + $("#txtPVSMDate").val()), "Information");
                $("#txtPVSMDate").val("");
                $("#txtPVSMDate").focus();
                $("#txtPVSMDate").css("border-color", "red");
                $("#PVSMDown").trigger('click');
                return false;
            }
            //if ($("#txtPVSMTemp").val() == "") {
            //    $("#PVSMDown").trigger('click');
            //    $("#txtPVSMTemp").focus();
            //    $("#txtPVSMTemp").css("border-color", "red");
            //    return false;
            //}
            //if ($("#txtPVSMPulse").val() == "") {
            //    $("#PVSMDown").trigger('click');
            //    $("#txtPVSMPulse").focus();
            //    $("#txtPVSMPulse").css("border-color", "red");
            //    return false;
            //}
            //if ($("#txtPVSMBldPrs1").val() == "") {
            //    $("#PVSMDown").trigger('click');
            //    $("#txtPVSMBldPrs1").focus();
            //    $("#txtPVSMBldPrs1").css("border-color", "red");
            //    return false;
            //}
            //if ($("#txtPVSMBldPrs2").val() == "") {
            //    $("#PVSMDown").trigger('click');
            //    $("#txtPVSMBldPrs2").focus();
            //    $("#txtPVSMBldPrs2").css("border-color", "red");
            //    return false;
            //}
            //if ($("#txtPVSMSPO").val() == "") {
            //    $("#PVSMDown").trigger('click');
            //    $("#txtPVSMSPO").focus();
            //    $("#txtPVSMSPO").css("border-color", "red");
            //    return false;
            //}
            //if ($("#txtPVSMBrthTime").val() == "") {
            //    $("#PVSMDown").trigger('click');
            //    $("#txtPVSMBrthTime").focus();
            //    $("#txtPVSMBrthTime").css("border-color", "red");
            //    return false;
            //}
            //var PainFlag = false;
            //document.querySelectorAll('input[type="radio"][name="radio-pain"]').forEach(function (radio) {
            //    if (radio.checked)
            //        PainFlag = true;
            //});
            //if (PainFlag == false) {
            //    $.alert("Please Select Pain Score");
            //    return false;
            //}
            AddUpdateVitalsDtlsArray();
        }
        //Added or Update in Global Decalaration List
        function AddUpdateVitalsDtlsArray() {
            var IsPresentFlag = false;
            var SeqNo = $("#txtSelRowId").val();
            var PainScoreCode = "";
            var PainScoreName = "";
            document.querySelectorAll('input[type="radio"][name="radio-pain"]').forEach(function (radio) {
                if (radio.checked) {
                    var SplitValue = Array.from(document.querySelectorAll('label[for="' + radio.id + '"]'))[1].textContent.split('\n');
                    PainScoreCode = SplitValue[0];
                    PainScoreName = SplitValue[1];
                }
            });
            if (SeqNo != "") {
                $.grep(PatVitalsList, function (a) {
                    if (a.SEQNO == SeqNo) {
                        IsPresentFlag = true;
                        a.VITALDATE = $("#txtPVSMDate").val().trim();
                        a.VITALTIME = $("#txtPVSMTime").val().trim();
                        a.TEMP = $("#txtPVSMTemp").val();
                        a.PULSE = $("#txtPVSMPulse").val(),
                        a.BLOODPRESSURE = $("#txtPVSMBldPrs2").val() == "" ? $("#txtPVSMBldPrs1").val() : $("#txtPVSMBldPrs1").val() + "/" + $("#txtPVSMBldPrs2").val();
                        a.SPO2 = $("#txtPVSMSPO").val();
                        a.PAINSCORE = PainScoreCode;
                        a.BREATHHOLD = $("#txtPVSMBrthTime").val();
                    }
                });
            }
            if (IsPresentFlag == false) {
                SeqNo = PatVitalsList.length + 1;
                var NewDtls = {
                    SEQNO: SeqNo,
                    VITALDATE: $("#txtPVSMDate").val().trim(),
                    VITALTIME: $("#txtPVSMTime").val().trim(),
                    TEMP: $("#txtPVSMTemp").val(),
                    PULSE: $("#txtPVSMPulse").val(),
                    BLOODPRESSURE: $("#txtPVSMBldPrs2").val() == "" ? $("#txtPVSMBldPrs1").val() : $("#txtPVSMBldPrs1").val() + "/" + $("#txtPVSMBldPrs2").val(),
                    SPO2: $("#txtPVSMSPO").val(),
                    PAINSCORE: PainScoreCode,
                    BREATHHOLD: $("#txtPVSMBrthTime").val()
                }
                PatVitalsList.push(NewDtls);
                AddVitalsDtlsTable(SeqNo);
            }
            else {
                UpdateVitalsDtlsTable(SeqNo);
            }
        }
        //Added Vitals Details in Table
        function AddVitalsDtlsTable(RowId) {
            var Tr = "<tr {TRID}>{TRCONTENT}</tr>";
            var Td = "<td {TDSTYLE}>{TDCONTENT}</td>";
            var Action = "<td><div class='TblActionDiv'><i class='fa fa-pencil GridEditIcon' aria-hidden='true' id='{EDITID}' onclick='BindVitalsDtlsField(this)' style='font-size: 20px;width: 30px;display:{EDITSTYLE}'></i><i class='fa fa-trash GridDeleteIcon' aria-hidden='true' id='{CANCELID}' onclick=\"RemoveVitalsDtls(this,'{ID}')\" style='font-size: 20px;width: 30px;display:{DELETESTYLE}'></i></div></td>";
            var PainScoreCode = "";
            var PainScoreName = "";
            document.querySelectorAll('input[type="radio"][name="radio-pain"]').forEach(function (radio) {
                if (radio.checked) {
                    var SplitValue = Array.from(document.querySelectorAll('label[for="' + radio.id + '"]'))[1].textContent.split('\n');
                    PainScoreCode = SplitValue[0];
                    PainScoreName = SplitValue[1];
                }
            });
            var EditVitalId = "EDITVITALS_" + RowId;
            var DelVitalId = "DELVITALS_" + RowId;
            var ActionTD = Action.replace("{ID}", RowId).replace("{EDITID}", EditVitalId).replace("{EDITSTYLE}", (Gaction == "D" || Gaction == "V" ? "none" : "inline-block")).replace("{CANCELID}", DelVitalId).replace("{DELETESTYLE}", (Gaction == "D" || Gaction == "V" ? "none" : "inline-block"));
            var DateTD = Td.replace("{TDCONTENT}", $("#txtPVSMDate").val() + ($("#txtPVSMTime").val() == "" ? "" : (" - " + $("#txtPVSMTime").val()))).replace("{TDSTYLE}", "");
            var TempTD = Td.replace("{TDCONTENT}", $("#txtPVSMTemp").val()).replace("{TDSTYLE}", "");
            var PulseTD = Td.replace("{TDCONTENT}", $("#txtPVSMPulse").val()).replace("{TDSTYLE}", "");
            var BLdPresTD = Td.replace("{TDCONTENT}", ($("#txtPVSMBldPrs2").val() == "" ? $("#txtPVSMBldPrs1").val() : $("#txtPVSMBldPrs1").val() + "/" + $("#txtPVSMBldPrs2").val())).replace("{TDSTYLE}", "");
            var SPOTD = Td.replace("{TDCONTENT}", $("#txtPVSMSPO").val()).replace("{TDSTYLE}", "");
            var PainScoreTD = Td.replace("{TDCONTENT}", (PainScoreName + (PainScoreCode != "" ? ("(" + PainScoreCode + ")") : ""))).replace("{TDSTYLE}", "");
            var PainScoreCodeTD = Td.replace("{TDCONTENT}", PainScoreCode).replace("{TDSTYLE}", "style='display:none'");
            var BreathHoldTD = Td.replace("{TDCONTENT}", $("#txtPVSMBrthTime").val()).replace("{TDSTYLE}", "");
            var AllTd = ActionTD + DateTD + TempTD + PulseTD + BLdPresTD + SPOTD + PainScoreTD + PainScoreCodeTD + BreathHoldTD;
            var Tr = Tr.replace("{TRCONTENT}", AllTd).replace("{TRID}", "id='" + RowId + "'");
            $("#tblPatVitalMsrmntsBody").append(Tr);
            CleartPatVitalMsrmntInfo();
        }
        //Update Vitals Table
        function UpdateVitalsDtlsTable(rowId) {
            var row = document.getElementById(rowId);
            var PainScoreCode = "";
            var PainScoreName = "";
            document.querySelectorAll('input[type="radio"][name="radio-pain"]').forEach(function (radio) {
                if (radio.checked) {
                    var SplitValue = Array.from(document.querySelectorAll('label[for="' + radio.id + '"]'))[1].textContent.split('\n');
                    PainScoreCode = SplitValue[0];
                    PainScoreName = SplitValue[1];
                }
            });
            if (row) {
                row.cells[1].innerText = $(("#txtPVSMDate")).val() + " - " + $("#txtPVSMTime").val();
                row.cells[2].innerText = $(("#txtPVSMTemp")).val();
                row.cells[3].innerText = $(("#txtPVSMPulse")).val();
                row.cells[4].innerText = ($("#txtPVSMBldPrs2").val() == "" ? $("#txtPVSMBldPrs1").val() : $("#txtPVSMBldPrs1").val() + "/" + $("#txtPVSMBldPrs2").val());
                row.cells[5].innerText = $(("#txtPVSMSPO")).val();
                row.cells[6].innerText = PainScoreName + (PainScoreCode != "" ? ("(" + PainScoreCode + ")") : "");
                row.cells[7].innerText = PainScoreCode;
                row.cells[8].innerText = $(("#txtPVSMBrthTime")).val();
                CleartPatVitalMsrmntInfo();
            }
        }
        //Bind Vitals Table To Field
        function BindVitalsDtlsField(element) {
            var row = element.closest('tr');
            if (row) {
                var cells = row.getElementsByTagName('td');
                $("#txtSelRowId").val(row.id);
                $("#txtPVSMDate").val(cells[1].innerText.split('-')[0].trim());
                $("#txtPVSMTime").val(cells[1].innerText.split('-').length > 1 ? cells[1].innerText.split('-')[1].trim() : "");
                $("#txtPVSMTemp").val(cells[2].innerText);
                $("#txtPVSMPulse").val(cells[3].innerText);
                var SpiltBP = cells[4].innerText.split("/");
                $("#txtPVSMBldPrs1").val(SpiltBP[0]);
                if (SpiltBP.length > 1)
                    $("#txtPVSMBldPrs2").val(SpiltBP[1]);
                $("#txtPVSMSPO").val(cells[5].innerText);
                $("#" + cells[7].innerText + "PainRadio").prop("checked", true);
                $("#txtPVSMBrthTime").val(cells[8].innerText);
                document.getElementById("BtnVitalsAdd").style.display = "none";
                document.getElementById("BtnVitalsUpdate").style.display = "block";
                document.getElementById("BtnVitalsClear").style.display = "block";
            }
        }
        //Remove Vitals
        function RemoveVitalsDtls(element, Id) {
            var row = element.closest('tr');
            if (row) {
                row.parentNode.removeChild(row);
                CleartPatVitalMsrmntInfo();
                var TData = JSON.parse(JSON.stringify(PatVitalsList));
                var FilterVital = TData.filter(function (A) { return A.SEQNO != Id; });
                PatVitalsList = FilterVital;
            }
        }
        //Bind Vitals Info
        function BindVitalsDtls() {
            var VitalsData = '<%:Html.Raw(Model.VitalsData)%>';
            PatVitalsList = VitalsData != "" ? JSON.parse(VitalsData) : [];
            $.grep(PatVitalsList, function (a) {
                $("#txtSelRowId").val(a.SEQNO);
                $("#txtPVSMDate").val(a.VITALDATE.trim());
                $("#txtPVSMTime").val(a.VITALTIME.trim());
                $("#txtPVSMTemp").val(a.TEMP);
                $("#txtPVSMPulse").val(a.PULSE);
                var SpiltBP = a.BLOODPRESSURE.split("/");
                $("#txtPVSMBldPrs1").val(SpiltBP[0]);
                if (SpiltBP.length > 1)
                    $("#txtPVSMBldPrs2").val(SpiltBP[1]);
                $("#txtPVSMSPO").val(a.SPO2);
                $("#" + a.PAINSCORE + "PainRadio").prop("checked", true);
                $("#txtPVSMBrthTime").val(a.BREATHHOLD);
                AddVitalsDtlsTable(a.SEQNO);
            });
            DefaultVitalsDtls();
        }
        //Validation For Vitals Info
        function ValidationForVitalsInfo() {
            if (PatVitalsList.length == 0) {
                $("#PVSMDown").trigger('click');
                ToastMsg("Please Enter Vitals.", "Information");
                return false;
            }
            return true;
        }
        //Vitals Info Save Value Pass
        function SaveForVitalsInfo(PostData) {
            PostData.push({ name: 'VitalsData', value: JSON.stringify(PatVitalsList) });
            return PostData;
        }
        //Vitals Info Print
        function PrintVitalsInfo(PrintData) {
            var TData = JSON.parse(JSON.stringify(PatVitalsList));
            $.grep(TData, function (a) {
                if (a.PAINSCORE != "") {
                    var Id = a.PAINSCORE + "PainRadio";
                    var SplitValue = Array.from(document.querySelectorAll('label[for="' + Id + '"]'))[1].textContent.split('\n');
                    PainScoreCode = SplitValue[0];
                    PainScoreName = SplitValue[1];
                    a.PAINSCORENAME = (PainScoreName + "(" + PainScoreCode + ")").trim();
                    a.VITALDATE = a.VITALDATE + (a.VITALTIME.trim() == "" ? "" : (" - " + a.VITALTIME.trim()));
                }
            });
            PrintData.push({ name: 'VitalsData', value: JSON.stringify(TData) });
            return PrintData;
        }
    </script>

    <%--  General Physical Examination Info --%>
    <script type="text/javascript">
        $(document).ready(function (e) {
            $("#btnGPECopy").click(function () {
                copyandBindGPE();
            });
            $("#btnCTHCopy").click(function () {
                copyandBindComorbidities();
                // closeIframe();
            });
            $("#btnSAHCopy").click(function () {
                bindSubstanceHistory();
            });
            $("#btnAirAssmt").click(function () {
                bindAirwayAssenment();
            });
            $("#btnSysExm").click(function () {
                bindSystemticExamination();
            });
            $("#btnARISCAT").click(function () {
                bindArisCatCriteria();
            });
            $("#btnCardiacCopy").click(function () {
                bindLeeCardicRisk();
            });
            $("#btnChildPughCopy").click(function () {
                bindChildPughTurcotteScore();
            });
            $("#bntcopyASA").click(function () {
                bindASA();
            });
            $("#BtnCoptAnthsPln").click(function () {
                bindAnaesthesiaPlans();
            });
            $("#btnCopyPatientVital").click(function () {//Table Is Pending
                bindPateintVitalSigns();
            });
            $("#BtnCopyAnaesth").click(function () {
                bindAnaethesiologistAdvice();
            });
            $("#btnCopyInductionMed").click(function () {
                bindInductionMedicine("I");
            });
            $("#BtnPACCopyAll").click(function () {
                copyandBindGPE();
                copyandBindComorbidities();
                bindSubstanceHistory();
                bindAirwayAssenment();
                bindSystemticExamination();
                bindArisCatCriteria();
                bindLeeCardicRisk();
                bindChildPughTurcotteScore();
                bindASA();
                bindAnaesthesiaPlans();
                bindPateintVitalSigns();
                bindAnaethesiologistAdvice();
                bindInductionMedicine("I");
            });
        });
        // General Physical Examination Info Load
        function GeneralPhyExamInfoLoad() {
            $('#txtGPERR').blockInput({ regex: '[0-9.]' });
            BindGeneralPhyExamInfoGaction();
        }
        // General Physical Examination Info Gaction
        function BindGeneralPhyExamInfoGaction() {
            if (Gaction == "N") {
                ClearGeneralPhyExamInfo();
            }
            else {
                BindGenPhyExamDtls();
            }
        }
        function copyandBindGPE() {
            var parentDoc = window.parent.document;
            var Phystatus = IFrameGetLastLetterCheckedRadio("GPEGENCOND");  
            var Orientation = IFrameGetLastLetterCheckedRadio("CPTORT");
            var Breathing = IFrameGetLastLetterCheckedRadio("CPTBRETPATTRM");
            var METS = IFrameGetLastLetterCheckedRadio("CPTMETS");
            var FunctCapacity = IFrameGetLastLetterCheckedRadio("CPTFUNCCAP");
            SetRadioFieldData("rbtnGPEGENCOND", Phystatus, "GPEGENCOND");
            SetRadioFieldData("rbtnCPTORT", Orientation, "CPTORT");
            SetRadioFieldData("rbtnCPTBRETPATTRM", Breathing, "CPTBRETPATTRM");
            SetRadioFieldData("rbtnCPTMETS", METS, "CPTMETS");
            SetRadioFieldData("rbtnCPTFUNCCAP", FunctCapacity, "CPTFUNCCAP");
          
            var ListOfFields = [
                { TOGGLEID: "ChkGPEPALL", TEXTBOXID: "txtCPTPallor" },
                { TOGGLEID: "ChkGPEICET", TEXTBOXID: "txtCPTIcterus" },
                { TOGGLEID: "ChkGPECYAN", TEXTBOXID: "txtCPTCyanosis" },
                { TOGGLEID: "ChkGPECLUB", TEXTBOXID: "txtCPTClubbing" },
                { TOGGLEID: "ChkGPELYMP", TEXTBOXID: "txtCPTLymphadenopathy" },
                { TOGGLEID: "ChkGPEEDEMA", TEXTBOXID: "txtCPTPedalEDEMA" },
                { TOGGLEID: "ChkGPEVENACC", TEXTBOXID: "txtCPTVenousAccess" },
                { TOGGLEID: "ChkGPELRTI", TEXTBOXID: "txtCPTLRTI" },
                { TOGGLEID: "ChkGPEURTI", TEXTBOXID: "txtCPTURTI" },
                { TOGGLEID: "ChkGPEFEVER", TEXTBOXID: "txtCPTFever" },
                { TOGGLEID: "ChkGPEPREANAHIST", TEXTBOXID: "txtCPTPREANAEVALHIST" },
            ]
            SetToggleFieldData(ListOfFields);
            window.parent.$("#txtHydraStatusOther").val($("#txtHydraStatusOther").val());
            window.parent.$("#txtGPERR").val($("#txtGPERR").val());
            var value = $("#cmbCPTHydrationStatus").val(); 

            window.parent.$("#cmbCPTHydrationStatus").val(value);
            //$("#txtGPERR").val($(document.getElementById("myIframe").contentWindow.document).find("#txtGPERR").val())
            ToastMsg("Data Copied Successfully.", "Info");
        }

        function copyandBindComorbidities() {
            var parentDoc = window.parent.document;
            var ECOG = IFrameGetLastLetterCheckedRadio("CTHECOG");
            var MMRC = IFrameGetLastLetterCheckedRadio("CTHMMRC");
            var NYHA = IFrameGetLastLetterCheckedRadio("CTHNYHA");
           
            SetRadioFieldData("rbtnCTHECOG", ECOG, "CTHECOG");
            SetRadioFieldData("rbtnCTHMMRC", MMRC, "CTHMMRC");
            SetRadioFieldData("rbtnCTHNYHA", NYHA, "CTHNYHA");
        
            var selected = IframeGetMultiCheckBoxVal("CTHOBESITY"); 
            SetMultiCheckBoxData("CTHOBESITY", selected);           
            var ListOfFields = [
                { TOGGLEID: "ChkCTHHYP", TEXTBOXID: "txtCTHHypert" },
                { TOGGLEID: "ChkCTHDIABMEL", TEXTBOXID: "txtCTHDiabMelt" },
                { TOGGLEID: "ChkCTHTHYDIS", TEXTBOXID: "txtCTHThyroidDis" },
                { TOGGLEID: "ChkCTHCHEMO", TEXTBOXID: "txtCTHChemotherapy" },
                { TOGGLEID: "ChkCTHRADIO", TEXTBOXID: "txtCTHRadiotherapy" },
                { TOGGLEID: "ChkCTHANYSURG", TEXTBOXID: "txtCTHAnyHOSurg" },
                { TOGGLEID: "ChkDrugAlleg", TEXTBOXID: "txtDrugAlleg" },
                { TOGGLEID: "ChkCTHBITE", TEXTBOXID: "txtCTHBite" },
                { TOGGLEID: "ChkSTRINGBITE", TEXTBOXID: "txtSTRINGBite" },
                { TOGGLEID: "ChkCTHANYRELHIST", TEXTBOXID: "txtCTHRelMedHist" },
              //  { TOGGLEID: "chkEpilepsy", TEXTBOXID: "txtEpilepsy" },
               
            ]
            var ListOfCHFields = [
                { TOGGLEID: "chkNOthers", TEXTBOXID: "txtNOthers" },
                { TOGGLEID: "chkStroke", TEXTBOXID: "txtStroke" },
                { TOGGLEID: "chkEpilepsy", TEXTBOXID: "txtEpilepsy" },
                { TOGGLEID: "chkASTHMA", TEXTBOXID: "txtASTHMA" },
                { TOGGLEID: "chkTB", TEXTBOXID: "txtTB" },
                { TOGGLEID: "chkCOPD", TEXTBOXID: "txtCOPD" },
                { TOGGLEID: "chkAKI", TEXTBOXID: "txtAKI" },
                { TOGGLEID: "chkCKD", TEXTBOXID: "txtCKD" },
                { TOGGLEID: "chkROthers", TEXTBOXID: "txtROthers" },
                { TOGGLEID: "chkIHD", TEXTBOXID: "txtIHD" },
                { TOGGLEID: "chkCHF", TEXTBOXID: "txtCHF" },
                { TOGGLEID: "chkRHD", TEXTBOXID: "txtRHD" },
                { TOGGLEID: "chkOther", TEXTBOXID: "txtOther" },
            ];

            function syncAllCheckboxes(list) {
                list.forEach(item => handleCheckbox(item.TOGGLEID, item.TEXTBOXID));
            }
            syncAllCheckboxes(ListOfCHFields);
            SetToggleFieldData(ListOfFields);

            ToastMsg("Data Copied Successfully.", "Info");
        }
        function syncAllCheckboxes(list) {
            list.forEach(item => handleCheckbox(item.TOGGLEID, item.TEXTBOXID));
        }
        function SetRadioFieldData(RadioID, RadionIND, RadioName) {
            if (RadionIND != "") {
                window.parent.document.getElementById(RadioID + RadionIND).checked = true;
            }
            else {
                //    window.parent.document.$("input[name='" + RadioName +"']").prop("checked", false);
                window.parent.$("input[name='" + RadioName + "']").prop("checked", false);
            }
        }

        function SetToggleFieldData(ListOfFields) {
            for (var i = 0; i < ListOfFields.length; i++) {
                if ($("#" + ListOfFields[i].TOGGLEID).prop("checked") == true) {
                    window.parent.$("#" + ListOfFields[i].TOGGLEID).prop("checked", true)
                    window.parent.$("#" + ListOfFields[i].TEXTBOXID).val($("#" + ListOfFields[i].TEXTBOXID).val());
                    window.parent.$("#" + ListOfFields[i].TOGGLEID).trigger("change")
                } else {

                    window.parent.$("#" + ListOfFields[i].TOGGLEID).prop("checked", false)
                    window.parent.$("#" + ListOfFields[i].TEXTBOXID).val("");
                    window.parent.$("#" + ListOfFields[i].TOGGLEID).trigger("change");
                }
            }

        }
        function SetMultiCheckBoxData(CheckBoxName, CheckedList, useId = true) {
            var list = CheckedList ? CheckedList.split(",") : [];
            window.parent.document.querySelectorAll('input[name="' + CheckBoxName + '"]').forEach(function (cb) {
                var val = useId ? cb.id.slice(-1) : cb.value;
                cb.checked = list.indexOf(val) >= 0;
            });
        }
        function handleCheckbox(checkboxId, textboxId) {
            var checkBox = document.getElementById(checkboxId);
            var textBox = textboxId ? document.getElementById(textboxId) : null;
            if (checkBox.checked) {
                if (textBox) textBox.style.display = "block";
            } else {
                if (textBox) {
                    textBox.style.display = "none";
                    textBox.value = "";
                }
            }
            if (window.parent) {
                window.parent.$("#" + checkboxId).prop("checked", checkBox.checked);
                if (textBox) {
                    window.parent.$("#" + textboxId).val(textBox.value);
                    if (checkBox.checked) window.parent.$("#" + textboxId).show();
                    else window.parent.$("#" + textboxId).hide();
                }
            }
        }

        function bindSubstanceHistory() {
            debugger;
            window.parent.$("#txtSAHDrugs").val($("#txtSAHDrugs").val());
            window.parent.$("#txtSAHAlcohol").val($("#txtSAHAlcohol").val());
            window.parent.$("#txtSAHBetalNut").val($("#txtSAHBetalNut").val());
            window.parent.$("#txtSAHTobacco").val($("#txtSAHTobacco").val());
            window.parent.$("#txtSAHSmoking").val($("#txtSAHSmoking").val());
            ToastMsg("Data Copied Successfully.", "Info");
        }
        function bindAirwayAssenment() {
            var Nares = IFrameGetLastLetterCheckedRadio("AANARES");  
            var Devi_Nasal = IFrameGetLastLetterCheckedRadio("AANASALSEP");  
            var Mouth_Opening = IFrameGetLastLetterCheckedRadio("AAMOUTHOPN");  
            var Malla_Aati = IFrameGetLastLetterCheckedRadio("AAMALLTI");  
            var Jaw_Sliding = IFrameGetLastLetterCheckedRadio("AAJAWSLID");
            var Thy_Distance = IFrameGetLastLetterCheckedRadio("AATHYDIST");  
            var Trismus = IFrameGetLastLetterCheckedRadio("AATRIS");  

            SetRadioFieldData("rbtnAANARES", Nares, "AANARES");
            SetRadioFieldData("rbtnAANASALSEP", Devi_Nasal, "AANASALSEP");
            SetRadioFieldData("rbtnAAMOUTHOPN", Mouth_Opening, "AAMOUTHOPN");
            SetRadioFieldData("rbtnAAMALLTI", Malla_Aati, "AAMALLTI");
            SetRadioFieldData("rbtnAAJAWSLID", Jaw_Sliding, "AAJAWSLID");
            SetRadioFieldData("rbtnAATHYDIST", Thy_Distance, "AATHYDIST");
            SetRadioFieldData("rbtnAATRIS", Trismus, "AATRIS");
            //Checkbox
            var ListCheckBoxAirway = [
                { TOGGLEID: "chkNormal", TEXTBOXID: "txtNormal" },
                { TOGGLEID: "chkEdentulous", TEXTBOXID: "txtEdentulous" },
                { TOGGLEID: "chkProtruding", TEXTBOXID: "txtProtruding" },
                { TOGGLEID: "chkArtificial", TEXTBOXID: "txtArtificial" },
                { TOGGLEID: "chkBuck", TEXTBOXID: "txtBuck" },
                { TOGGLEID: "chkLooseTooth", TEXTBOXID: "txtLooseTooth" },
            ];
            syncAllCheckboxes(ListCheckBoxAirway);
            //For Textbox
            window.parent.$("#txtAAMallRemark").val($("#txtAAMallRemark").val());
            window.parent.$("#txtAANeck").val($("#txtAANeck").val());
            window.parent.$("#txtAASpine").val($("#txtAASpine").val());
            window.parent.$("#txtAAAirComment").val($("#txtAAAirComment").val());

            //for Slider
            var ListOfFields = [
                { TOGGLEID: "ChkAATRACH", TEXTBOXID: "txtAATracheostomy" },
            ]
            SetToggleFieldData(ListOfFields);

            ToastMsg("Data Copied Successfully.", "Info");
        }
        function bindSystemticExamination() {
            //For Textbox
            window.parent.$("#txtSECardiSys").val($("#txtSECardiSys").val());
            window.parent.$("#txtSERespSys").val($("#txtSERespSys").val());
            window.parent.$("#txtSEAdboSys").val($("#txtSEAdboSys").val());
            window.parent.$("#txtSECentNervSys").val($("#txtSECentNervSys").val());
            ToastMsg("Data Copied Successfully.", "Info");
        }
        function bindArisCatCriteria() {
            var Age = IFrameGetLastLetterCheckedRadio("ARISCATAGE");  
            var SpO2 = IFrameGetLastLetterCheckedRadio("ARISCATSPO2");  
            var Respiratory = IFrameGetLastLetterCheckedRadio("ARISCATRESINFT");  
            var Pre_Op = IFrameGetLastLetterCheckedRadio("ARISCATHB");  
            var Incision = IFrameGetLastLetterCheckedRadio("ARISCATINC");  
            var Surgery = IFrameGetLastLetterCheckedRadio("ARISCATSURG");  
            var Emergency_Procedure = IFrameGetLastLetterCheckedRadio("ARISCATEMGPROC");
            SetRadioFieldData("rbtnAge", Age, "ARISCATAGE");
            SetRadioFieldData("rbtnPreOPSPO", SpO2, "ARISCATSPO2");
            SetRadioFieldData("rbtnRESPINFT", Respiratory, "ARISCATRESINFT");
            SetRadioFieldData("rbtnPreOPHB", Pre_Op, "ARISCATHB");
            SetRadioFieldData("rbtnINC", Incision, "ARISCATINC");
            SetRadioFieldData("rbtnARISCATSURG", Surgery, "ARISCATSURG");
            SetRadioFieldData("rbtnEMGPROC", Emergency_Procedure, "ARISCATEMGPROC");

            //For Textbox
            window.parent.$("#txtARISCATPPCRate").val($("#txtARISCATPPCRate").val());
            window.parent.$("#txtARISCATTotal").val($("#txtARISCATTotal").val());
            window.parent.$("#txtARISCATRiskCatg").val($("#txtARISCATRiskCatg").val());
            ToastMsg("Data Copied Successfully.", "Info");
        }
        function bindLeeCardicRisk() {
            var selected = IframeGetMultiCheckBoxVal("RLCRFIFACTIND");
            SetMultiCheckBoxData("RLCRFIFACTIND", selected);   
            window.parent.$("#txtCPTSClass").val($("#txtCPTSClass").val());
            window.parent.$("#txtCPTSPoints").val($("#txtCPTSPoints").val());
            ToastMsg("Data Copied Successfully.", "Info");
        }
        function bindChildPughTurcotteScore() {
            var Encephalopathy = IFrameGetLastLetterCheckedRadio("CPTSENC");  
            var Ascities = IFrameGetLastLetterCheckedRadio("CPTSASCT");  
            var Biliirubin = IFrameGetLastLetterCheckedRadio("CPTSBILI");  
            var Albumin = IFrameGetLastLetterCheckedRadio("CPTSALBU");  
            var INR = IFrameGetLastLetterCheckedRadio("CPTSINR");  
            SetRadioFieldData("rbtnCPTSENC", Encephalopathy, "CPTSENC");
            SetRadioFieldData("rbtnCPTSASCT", Ascities, "CPTSASCT");
            SetRadioFieldData("rbtnCPTSBILI", Biliirubin, "CPTSBILI");
            SetRadioFieldData("rbtnCPTSALBU", Albumin, "CPTSALBU");
            SetRadioFieldData("rbtnCPTSINR", INR, "CPTSINR");

            window.parent.$("#txtCPTSClass").val($("#txtCPTSClass").val());
            window.parent.$("#txtCPTSPoints").val($("#txtCPTSPoints").val());
            ToastMsg("Data Copied Successfully.", "Info");
        }

        function bindASA() {
            var PhyStatus = IFrameGetLastLetterCheckedRadio("APSPHYSTS");  
            var FitStatus = IFrameGetLastLetterCheckedRadio("APSFITSTS");  
            //Abhishesh || 20260506
            var selected = $("#rbtnAPSPHYSTSE").prop("checked");
            window.parent.$("#rbtnAPSPHYSTSE").prop("checked", selected);

            var selected = $("#ChkPACReview").prop("checked");
            window.parent.$("#ChkPACReview").prop("checked", selected);
            //End
            SetRadioFieldData("rbtnAPSPHYSTS", PhyStatus, "APSPHYSTS");
            SetRadioFieldData("rbtnAPSFITSTS", FitStatus, "APSFITSTS");

            window.parent.$("#cmbASARisk").val($("#cmbASARisk").val());
            window.parent.$("#txtASARemark").val($("#txtASARemark").val());
            window.parent.$("#txtAPSDate").val($("#txtAPSDate").val());
            window.parent.$("#txtAPSTime").val($("#txtAPSTime").val());
            ToastMsg("Data Copied Successfully.", "Info");
        }

        function bindAnaesthesiaPlans() {
            window.parent.$("#cmbAneasthesiaType").val($("#cmbAneasthesiaType").val());
            window.parent.$("#txtASPLANNotes").val($("#txtASPLANNotes").val());
            ToastMsg("Data Copied Successfully.", "Info");
        }
        function bindPateintVitalSigns() {
            window.parent.$("#txtPVSMDate").val($("#txtPVSMDate").val());
            window.parent.$("#txtPVSMTime").val($("#txtPVSMTime").val());
            window.parent.$("#txtPVSMTemp").val($("#txtPVSMTemp").val());
            window.parent.$("#txtPVSMPulse").val($("#txtPVSMPulse").val());
            window.parent.$("#txtPVSMBldPrs1").val($("#txtPVSMBldPrs1").val());
            window.parent.$("#txtPVSMBldPrs2").val($("#txtPVSMBldPrs2").val());
            window.parent.$("#txtPVSMBrthTime").val($("#txtPVSMBrthTime").val());
            ToastMsg("Data Copied Successfully.", "Info");
        }
        function bindAnaethesiologistAdvice() {
            window.parent.$("#txtAAPO").val($("#txtAAPO").val());
            ToastMsg("Data Copied Successfully.", "Info");
        }
        function getMedByType(type) {
            var parentDoc = window.parent.document;
            let myIframe = parentDoc.getElementById('myIframe');
            let filteredList = myIframe.contentWindow.AllMedListForSave.filter(item => item.TYPE === type);
            return filteredList;
        }
        function bindInductionMedicine(type) {
            GeneralFunctionBindingAllTable(type);
        }
        function GeneralFunctionBindingAllTable(type) {
            var MedListFor = getMedByType(type);
            var parent$ = window.parent.$; // parent jQuery if inside iframe

            $.grep(MedListFor, function (a) {
                var TbodyId = "";
                if (a.TYPE == "P") TbodyId = "TablePreopTBody";
                else if (a.TYPE == "I") TbodyId = "TableIndTBody";
                else if (a.TYPE == "N") TbodyId = "TablePONVTBody";
                else if (a.TYPE == "R") TbodyId = "TableRevTBody";
                else TbodyId = "TableMaintTBody";

                AddMedicineTable(a.DRUGCODE, a.DRUGNM, a.TYPE, TbodyId, a.GENERICID, a.GENERICNAME, a.DRUGFORM, "C");//C means Copy

                var ids = {
                    Freq: "txt_Freq_" + a.TYPE + "_" + a.DRUGCODE,
                    DurDay: "txt_DurDay_" + a.TYPE + "_" + a.DRUGCODE,
                    DurCatg: "txt_DurCatg_" + a.TYPE + "_" + a.DRUGCODE,
                    Food: "txt_Food_" + a.TYPE + "_" + a.DRUGCODE,
                    Route: "txt_Route_" + a.TYPE + "_" + a.DRUGCODE,
                    Dosage: "txt_Dose_" + a.TYPE + "_" + a.DRUGCODE,
                    Qty: "txt_Qty_" + a.TYPE + "_" + a.DRUGCODE,
                    Remark: "txt_Remark_" + a.TYPE + "_" + a.DRUGCODE
                };

                parent$('[id="' + ids.Freq + '"]').val(a.INTAKEDESC);
                parent$('[id="' + ids.DurDay + '"]').val(a.DAYS);
                parent$('[id="' + ids.DurCatg + '"]').val(a.DURATION);
                parent$('[id="' + ids.Food + '"]').val(a.ABFOOD);
                parent$('[id="' + ids.Route + '"]').val(a.ROUTE);
                parent$('[id="' + ids.Dosage + '"]').val(a.DOSSAGE);
                parent$('[id="' + ids.Qty + '"]').val(a.QTY);
                parent$('[id="' + ids.Remark + '"]').val(a.Remarks);

                AddUpdateMedicineListSave("U", a.DRUGCODE, a.DRUGNM, a.TYPE, a.GENERICID, a.GENERICNAME, "C");
            });
            parent$("#ASPLANDown").trigger('click');
            window.parent.autoResize('txtASPLANNotes');
            parent$("#ASPLANUp").trigger('click');
            ToastMsg("Data Copied Successfully.", "Info");
        }
        //end By Roshan
        //Clear General Physical Examination Info
        function ClearGeneralPhyExamInfo() {
            UncheckRadioBtn('GPEGENCOND');
            UncheckRadioBtn('CPTBRETPATTRM');
            UncheckRadioBtn('CPTORT');
            $("#txtGPEBreathRemark").val("");
            $("#txtGPERR").val("");
            $("#ChkGPEPALL").prop("checked", false);
            $("#ChkGPEICET").prop("checked", false);
            $("#ChkGPECYAN").prop("checked", false);
            $("#ChkGPELYMP").prop("checked", false);
            $("#ChkGPEEDEMA").prop("checked", false);
            $("#cmbCPTHydrationStatus").val("");
            EnDisTextCombo('cmbCPTHydrationStatus', 'txtHydraStatusOther');
            $("#ChkGPEVENACC").prop("checked", false);
            $("#ChkGPELRTI").prop("checked", false);
            $("#ChkGPEURTI").prop("checked", false);
            $("#ChkGPEFEVER").prop("checked", false);
            $("#ChkGPEPREANAHIST").prop("checked", false);
            EnDisChkTextbox('ChkGPEPALL', 'txtCPTPallor');
            EnDisChkTextbox('ChkGPEICET', 'txtCPTIcterus');
            EnDisChkTextbox('ChkGPECYAN', 'txtCPTCyanosis');
            EnDisChkTextbox('ChkGPECLUB', 'txtCPTClubbing');
            EnDisChkTextbox('ChkGPELYMP', 'txtCPTLymphadenopathy');
            EnDisChkTextbox('ChkGPEEDEMA', 'txtCPTPedalEDEMA');
            EnDisChkTextbox('ChkGPEVENACC', 'txtCPTVenousAccess');
            EnDisChkTextbox('ChkGPELRTI', 'txtCPTLRTI');
            EnDisChkTextbox('ChkGPEURTI', 'txtCPTURTI');
            EnDisChkTextbox('ChkGPEFEVER', 'txtCPTFever');
            EnDisChkTextbox('ChkGPEPREANAHIST', 'txtCPTPREANAEVALHIST');
            UncheckRadioBtn('CPTMETS');
            UncheckRadioBtn('CPTFUNCCAP');
            $("#GPEDown").trigger('click');
            autoResize('txtCPTPREANAEVALHIST');
            $("#GPEUp").trigger('click');
        }
        //Bind General Physical Examination Info
        function BindGenPhyExamDtls() {
            var GenCondition = '<%=Model.GeneralCondtion %>';
            var BreathPat = '<%=Model.BreathPattern %>';
            var Orient = '<%=Model.Orientation %>';
            var METS = '<%=Model.METS %>';
            var FunCap = '<%=Model.FunctCapacity %>';
            if (GenCondition != "")
                $("#rbtnGPEGENCOND" + GenCondition).prop("checked", true);
            if (BreathPat != "")
                $("#rbtnCPTBRETPATTRM" + BreathPat).prop("checked", true);
            if (Orient != "")
                $("#rbtnCPTORT" + Orient).prop("checked", true);
            var BreathRmk = '<%=HttpUtility.JavaScriptStringEncode(Model.BreathingPatternRemark) %>'
            $("#txtGPEBreathRemark").val(BreathRmk.replace(/\\n/g, "\n"));
            $("#txtGPERR").val('<%=Model.RespiratoryRate %>');
            if ('<%=Model.IsPallor %>' == "Y") {
                $("#ChkGPEPALL").prop("checked", true);
                var Pallor = '<%=HttpUtility.JavaScriptStringEncode(Model.Pallor) %>'
                $("#txtCPTPallor").val(Pallor.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsIcterus %>' == "Y") {
                $("#ChkGPEICET").prop("checked", true);
                var Icterus = '<%=HttpUtility.JavaScriptStringEncode(Model.Icterus) %>'
                $("#txtCPTIcterus").val(Icterus.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsCyanosis %>' == "Y") {
                $("#ChkGPECYAN").prop("checked", true);
                var Cyanosis = '<%=HttpUtility.JavaScriptStringEncode(Model.Cyanosis) %>'
                $("#txtCPTCyanosis").val(Cyanosis.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsClubbing %>' == "Y") { // Change
                $("#ChkGPECLUB").prop("checked", true);
                var Clubbing = '<%=HttpUtility.JavaScriptStringEncode(Model.Clubbing) %>'
                $("#txtCPTClubbing").val(Clubbing.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsLymphadenopathy %>' == "Y") {
                $("#ChkGPELYMP").prop("checked", true);
                var Lymphadenopathy = '<%=HttpUtility.JavaScriptStringEncode(Model.Lymphadenopathy) %>'
                $("#txtCPTLymphadenopathy").val(Lymphadenopathy.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsPedalEDEMA %>' == "Y") {
                $("#ChkGPEEDEMA").prop("checked", true);
                var PedalEDEMA = '<%=HttpUtility.JavaScriptStringEncode(Model.PedalEDEMA) %>'
                $("#txtCPTPedalEDEMA").val(PedalEDEMA.replace(/\\n/g, "\n"));
            }
            $("#cmbCPTHydrationStatus").val('<%=Model.HydrationStatus %>');
            var HydrationStatusOther = '<%=HttpUtility.JavaScriptStringEncode(Model.HydrationStatusOther) %>'
            $("#txtHydraStatusOther").val(HydrationStatusOther.replace(/\\n/g, "\n"));
            if ('<%=Model.IsVenousAccess %>' == "Y") {
                $("#ChkGPEVENACC").prop("checked", true);
                var VenousAccess = '<%=HttpUtility.JavaScriptStringEncode(Model.VenousAccess) %>'
                $("#txtCPTVenousAccess").val(VenousAccess.replace(/\\n/g, "\n"));
            }
            if (METS != "")
                $("#rbtnCPTMETS" + METS).prop("checked", true);
            if (FunCap != "")
                $("#rbtnCPTFUNCCAP" + FunCap).prop("checked", true);

            if ('<%=Model.IsLRTI %>' == "Y") {
                $("#ChkGPELRTI").prop("checked", true);
                var LRTI = '<%=HttpUtility.JavaScriptStringEncode(Model.LRTI) %>'
                $("#txtCPTLRTI").val(LRTI.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsURTI %>' == "Y") {
                $("#ChkGPEURTI").prop("checked", true);
                var URTI = '<%=HttpUtility.JavaScriptStringEncode(Model.URTI) %>'
                $("#txtCPTURTI").val(URTI.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsFever %>' == "Y") {
                $("#ChkGPEFEVER").prop("checked", true);
                var Fever = '<%=HttpUtility.JavaScriptStringEncode(Model.Fever) %>'
                $("#txtCPTFever").val(Fever.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsPreAnaestEvalHist %>' == "Y") {
                $("#ChkGPEPREANAHIST").prop("checked", true);
                var PreAnaestEvalHist = '<%=HttpUtility.JavaScriptStringEncode(Model.PreAnaestEvalHist) %>'
                $("#txtCPTPREANAEVALHIST").val(PreAnaestEvalHist.replace(/\\n/g, "\n"));
            }
            EnDisChkTextbox('ChkGPEPALL', 'txtCPTPallor');
            EnDisChkTextbox('ChkGPEICET', 'txtCPTIcterus');
            EnDisChkTextbox('ChkGPECYAN', 'txtCPTCyanosis');
            EnDisChkTextbox('ChkGPECLUB', 'txtCPTClubbing');
            EnDisChkTextbox('ChkGPELYMP', 'txtCPTLymphadenopathy');
            EnDisChkTextbox('ChkGPEEDEMA', 'txtCPTPedalEDEMA');
            EnDisChkTextbox('ChkGPEVENACC', 'txtCPTVenousAccess');
            EnDisChkTextbox('ChkGPELRTI', 'txtCPTLRTI');
            EnDisChkTextbox('ChkGPEURTI', 'txtCPTURTI');
            EnDisChkTextbox('ChkGPEFEVER', 'txtCPTFever');
            EnDisChkTextbox('ChkGPEPREANAHIST', 'txtCPTPREANAEVALHIST');
            EnDisTextCombo('cmbCPTHydrationStatus', 'txtHydraStatusOther');
            $("#GPEDown").trigger('click');
            autoResize('txtCPTPREANAEVALHIST');
            $("#GPEUp").trigger('click');

        }
        //Validation For General Physical Examination Info
        function ValidationForGenPhyExamInfo() {
            var GenCondition = GetLastLetterCheckedRadio('GPEGENCOND');
            if (GenCondition == "") {
                $("#GPEDown").trigger('click');
                FocusRadioOpt("rbtnGPEGENCOND1", "Please Select General Condition");
                return false;
            }
            var BreathPat = GetLastLetterCheckedRadio('CPTBRETPATTRM');
            if (BreathPat == "") {
                $("#GPEDown").trigger('click');
                FocusRadioOpt("rbtnCPTBRETPATTRM1", "Please Select Breathing Pattern");
                return false;
            }
            if (BreathPat != "1" && $("#txtGPERR").val() == "") {
                $("#GPEDown").trigger('click');
                $("#txtGPERR").focus();
                $("#txtGPERR").css("border-color", "red");
                return false;
            }
            var Orient = GetLastLetterCheckedRadio('CPTORT');
            if (Orient == "") {
                $("#GPEDown").trigger('click');
                FocusRadioOpt("rbtnCPTORT1", "Please Select Orientation");
                return false;
            }
            if (ValidTextCheck('ChkGPEPALL', 'txtCPTPallor') == false)
                return false;
            if (ValidTextCheck('ChkGPEICET', 'txtCPTIcterus') == false)
                return false;
            if (ValidTextCheck('ChkGPECYAN', 'txtCPTCyanosis') == false)
                return false;
            if (ValidTextCheck('ChkGPECLUB', 'txtCPTClubbing') == false)
                return false;
            if (ValidTextCheck('ChkGPELYMP', 'txtCPTLymphadenopathy') == false)
                return false;
            if (ValidTextCheck('ChkGPEEDEMA', 'txtCPTPedalEDEMA') == false)
                return false;
            if ($("#cmbCPTHydrationStatus").val() == "O" && $("#txtHydraStatusOther").val() == "") {
                $("#GPEDown").trigger('click');
                $("#txtHydraStatusOther").focus();
                $("#txtHydraStatusOther").css("border-color", "red");
                return false;
            }
            if (ValidTextCheck('ChkGPEVENACC', 'txtCPTVenousAccess') == false)
                return false;
            if (ValidTextCheck('ChkGPELRTI', 'txtCPTLRTI') == false)
                return false;
            if (ValidTextCheck('ChkGPEURTI', 'txtCPTURTI') == false)
                return false;
            if (ValidTextCheck('ChkGPEFEVER', 'txtCPTFever') == false)
                return false;
            if (ValidTextCheck('ChkGPEPREANAHIST', 'txtCPTPREANAEVALHIST') == false)
                return false;
            var METS = GetLastLetterCheckedRadio('CPTMETS');
            if (METS == "") {
                $("#GPEDown").trigger('click');
                FocusRadioOpt("rbtnCPTMETS1", "Please Select METS");
                return false;
            }
            var FuncCap = GetLastLetterCheckedRadio('CPTFUNCCAP');
            if (FuncCap == "") {
                $("#GPEDown").trigger('click');
                FocusRadioOpt("rbtnCPTFUNCCAP1", "Please Select Functional Capacity");
                return false;
            }
            return true;
        }
        //General Physical Examination Info Save Value Pass
        function SaveForGenPhyExamInfo(PostData) {
            PostData.push({ name: 'GeneralCondtion', value: GetLastLetterCheckedRadio('GPEGENCOND') });
            PostData.push({ name: 'BreathPattern', value: GetLastLetterCheckedRadio('CPTBRETPATTRM') });
            PostData.push({ name: 'Orientation', value: GetLastLetterCheckedRadio('CPTORT') });
            PostData.push({ name: 'BreathingPatternRemark', value: $("#txtGPEBreathRemark").val() });
            PostData.push({ name: 'RespiratoryRate', value: $("#txtGPERR").val() });
            PostData.push({ name: 'IsPallor', value: SaveValueTextCheck('ChkGPEPALL') });
            PostData.push({ name: 'Pallor', value: $("#txtCPTPallor").val() });
            PostData.push({ name: 'IsIcterus', value: SaveValueTextCheck('ChkGPEICET') });
            PostData.push({ name: 'Icterus', value: $("#txtCPTIcterus").val() });
            PostData.push({ name: 'IsCyanosis', value: SaveValueTextCheck('ChkGPECYAN') });
            PostData.push({ name: 'Cyanosis', value: $("#txtCPTCyanosis").val() });
            PostData.push({ name: 'IsClubbing', value: SaveValueTextCheck('ChkGPECLUB') });
            PostData.push({ name: 'Clubbing', value: $("#txtCPTClubbing").val() });
            PostData.push({ name: 'IsLymphadenopathy', value: SaveValueTextCheck('ChkGPELYMP') });
            PostData.push({ name: 'Lymphadenopathy', value: $("#txtCPTLymphadenopathy").val() });
            PostData.push({ name: 'IsPedalEDEMA', value: SaveValueTextCheck('ChkGPEEDEMA') });
            PostData.push({ name: 'PedalEDEMA', value: $("#txtCPTPedalEDEMA").val() });
            PostData.push({ name: 'HydrationStatus', value: $("#cmbCPTHydrationStatus").val() });
            PostData.push({ name: 'HydrationStatusOther', value: $("#txtHydraStatusOther").val() });
            PostData.push({ name: 'IsVenousAccess', value: SaveValueTextCheck('ChkGPEVENACC') });
            PostData.push({ name: 'VenousAccess', value: $("#txtCPTVenousAccess").val() });
            PostData.push({ name: 'METS', value: GetLastLetterCheckedRadio('CPTMETS') });
            PostData.push({ name: 'FunctCapacity', value: GetLastLetterCheckedRadio('CPTFUNCCAP') });
            PostData.push({ name: 'IsLRTI', value: SaveValueTextCheck('ChkGPELRTI') });
            PostData.push({ name: 'LRTI', value: $("#txtCPTLRTI").val() });
            PostData.push({ name: 'IsURTI', value: SaveValueTextCheck('ChkGPEURTI') });
            PostData.push({ name: 'URTI', value: $("#txtCPTURTI").val() });
            PostData.push({ name: 'IsFever', value: SaveValueTextCheck('ChkGPEFEVER') });
            PostData.push({ name: 'Fever', value: $("#txtCPTFever").val() });
            PostData.push({ name: 'IsPreAnaestEvalHist', value: SaveValueTextCheck('ChkGPEPREANAHIST') });
            PostData.push({ name: 'PreAnaestEvalHist', value: JSON.stringify($("#txtCPTPREANAEVALHIST").val().toString().trim()) });
            return PostData;
        }
        //General Physical Examination Info Print
        function PrintGenPhyExamInfo(PrintData) {
            PrintData.push({ name: 'GeneralCondtion', value: GetCheckRadioLabel('GPEGENCOND') });
            PrintData.push({ name: 'BreathPattern', value: GetCheckRadioLabel('CPTBRETPATTRM') });
            PrintData.push({ name: 'BreathingPatternRemark', value: $("#txtGPEBreathRemark").val() });
            PrintData.push({ name: 'RespiratoryRate', value: $("#txtGPERR").val() });
            PrintData.push({ name: 'Orientation', value: GetCheckRadioLabel('CPTORT') });
            PrintData.push({ name: 'IsPallor', value: SaveValueTextCheck('ChkGPEPALL') });
            PrintData.push({ name: 'Pallor', value: $("#txtCPTPallor").val() });
            PrintData.push({ name: 'IsIcterus', value: SaveValueTextCheck('ChkGPEICET') });
            PrintData.push({ name: 'Icterus', value: $("#txtCPTIcterus").val() });
            PrintData.push({ name: 'IsCyanosis', value: SaveValueTextCheck('ChkGPECYAN') });
            PrintData.push({ name: 'Cyanosis', value: $("#txtCPTCyanosis").val() });
            PrintData.push({ name: 'IsClubbing', value: SaveValueTextCheck('ChkGPECLUB') });
            PrintData.push({ name: 'Clubbing', value: $("#txtCPTClubbing").val() });
            PrintData.push({ name: 'IsLymphadenopathy', value: SaveValueTextCheck('ChkGPELYMP') });
            PrintData.push({ name: 'Lymphadenopathy', value: $("#txtCPTLymphadenopathy").val() });
            PrintData.push({ name: 'IsPedalEDEMA', value: SaveValueTextCheck('ChkGPEEDEMA') });
            PrintData.push({ name: 'PedalEDEMA', value: $("#txtCPTPedalEDEMA").val() });
            PrintData.push({ name: 'HydrationStatus', value: $("#cmbCPTHydrationStatus").val() == "" ? "" : $("#cmbCPTHydrationStatus option:selected").text() });
            PrintData.push({ name: 'HydrationStatusOther', value: $("#txtHydraStatusOther").val() });
            PrintData.push({ name: 'IsVenousAccess', value: SaveValueTextCheck('ChkGPEVENACC') });
            PrintData.push({ name: 'VenousAccess', value: $("#txtCPTVenousAccess").val() });
            PrintData.push({ name: 'METS', value: GetCheckRadioLabel('CPTMETS') });
            PrintData.push({ name: 'FunctCapacity', value: GetCheckRadioLabel('CPTFUNCCAP') });
            PrintData.push({ name: 'IsLRTI', value: SaveValueTextCheck('ChkGPELRTI') });
            PrintData.push({ name: 'LRTI', value: $("#txtCPTLRTI").val() });
            PrintData.push({ name: 'IsURTI', value: SaveValueTextCheck('ChkGPEURTI') });
            PrintData.push({ name: 'URTI', value: $("#txtCPTURTI").val() });
            PrintData.push({ name: 'IsFever', value: SaveValueTextCheck('ChkGPEFEVER') });
            PrintData.push({ name: 'Fever', value: $("#txtCPTFever").val() });
            PrintData.push({ name: 'IsPreAnaestEvalHist', value: SaveValueTextCheck('ChkGPEPREANAHIST') });
            PrintData.push({ name: 'PreAnaestEvalHist', value: JSON.stringify($("#txtCPTPREANAEVALHIST").val().toString().trim()) });
            return PrintData;
        }
    </script>

    <%-- Comorbidities & Treatment History Info --%>
    <script type="text/javascript">
        // Comorbidities & Treatment History Info Load
        function ComoTreatHistInfoLoads() {
            BindComoTreatHistInfoGaction()
        }
        function toggleRemark(checkboxId, textboxId) {
            var checkBox = document.getElementById(checkboxId);
            var textBox = document.getElementById(textboxId);

            if (checkBox.checked == true) {
                textBox.style.display = "block";
            } else {
                textBox.style.display = "none";
                textBox.value = ""; 
            }
        }
        // Comorbidities & Treatment History Info Gaction
        function BindComoTreatHistInfoGaction() {
            if (Gaction == "N") {
                ClearComoTreatHistInfo();
                DefaultObesity();

                //priyanka 27/02/2026
                var Chemotherapydata = '<%=Model.ChemoTherapyData %>';
                var Radiotherapydata = '<%=Model.RadioTherapyData %>';
                if (Chemotherapydata != "") {
                    $("#ChkCTHCHEMO").prop("checked", true);
                    var Chemotherapy = '<%=HttpUtility.JavaScriptStringEncode(Model.ChemoTherapyData) %>'
                    $("#txtCTHChemotherapy").val(Chemotherapy.replace(/\\n/g, "\n"));
                    EnDisChkTextbox('ChkCTHCHEMO', 'txtCTHChemotherapy');
                }
                else {
                    $("#ChkCTHCHEMO").prop("checked", false);
                    EnDisChkTextbox('ChkCTHCHEMO', 'txtCTHChemotherapy');
                }


                if (Radiotherapydata != "") {
                    $("#ChkCTHRADIO").prop("checked", true);
                    var Radiotherapy = '<%=HttpUtility.JavaScriptStringEncode(Model.RadioTherapyData) %>'
                    $("#txtCTHRadiotherapy").val(Radiotherapy.replace(/\\n/g, "\n"));
                    EnDisChkTextbox('ChkCTHRADIO', 'txtCTHRadiotherapy');
                }
                else {
                    $("#ChkCTHRADIO").prop("checked", false);
                    EnDisChkTextbox('ChkCTHRADIO', 'txtCTHRadiotherapy');

                }
                //end

            }
            else {
                BindComoTreatHistDtls();
            }
        }
        //Calculate Obesity 
        function CalcObesity() {
            var Count = 0;
            document.querySelectorAll('input[name="CTHOBESITY"]').forEach(function (radio) {
                if (radio.checked) {
                    Count++;
                }
            });
            document.getElementById("lblObesity").innerText = Count;
            $("#txtObesity").val(Count);
        }
        //Clear Comorbidities & Treatment History Info
        function ClearComoTreatHistInfo() {
            $("#ChkCTHHYP").prop("checked", false);
            EnDisChkTextbox('ChkCTHHYP', 'txtCTHHypert');
            $("#ChkCTHDIABMEL").prop("checked", false);
            EnDisChkTextbox('ChkCTHDIABMEL', 'txtCTHDiabMelt');
            UncheckRadioBtn('CTHCARDI');
            $("#txtCTHCardiothrs").val("");
            UncheckRadioBtn('CTHNYHA');
            UncheckRadioBtn('CTHECOG');
            UncheckRadioBtn('CTHRESP');
            UncheckRadioBtn('CTHMMRC');
            UncheckRadioBtn('CTHNERVSYS');
            $("#txtCTHNervSysOthrs").val("");
            UncheckRadioBtn('CTHRENAL');
            $("#txtCTHRENALOthrs").val("");
            $("#ChkCTHTHYDIS").prop("checked", false);
            EnDisChkTextbox('ChkCTHTHYDIS', 'txtCTHThyroidDis');
            $("#ChkCTHCHEMO").prop("checked", false);
            EnDisChkTextbox('ChkCTHCHEMO', 'txtCTHChemotherapy');
            $("#ChkCTHRADIO").prop("checked", false);
            EnDisChkTextbox('ChkCTHRADIO', 'txtCTHRadiotherapy');
            $("#ChkCTHANYSURG").prop("checked", false);
            EnDisChkTextbox('ChkCTHANYSURG', 'txtCTHAnyHOSurg');
            UncheckRadioBtn('CTHBLDREL');
            $("#ChkCTHBITE").prop("checked", false);
            EnDisChkTextbox('ChkCTHBITE', 'txtCTHBite');
            $("#ChkDrugAlleg").prop("checked", false);
            EnDisChkTextbox('ChkDrugAlleg', 'txtDrugAlleg');
            $("#ChkSTRINGBITE").prop("checked", false);
            EnDisChkTextbox('ChkSTRINGBITE', 'txtSTRINGBite');
            $("#ChkCTHANYRELHIST").prop("checked", false);
            EnDisChkTextbox('ChkCTHANYRELHIST', 'txtCTHRelMedHist');
            //EnDisRadioOtherField('rbtnCTHCARDI4', 'txtCTHCardiothrs');
            //EnDisRadioOtherField('rbtnCTHNERVSYS3', 'txtCTHNervSysOthrs');
            //EnDisRadioOtherField('rbtnCTHRENAL3', 'txtCTHRENALOthrs');
            UncheckRadioBtn('CTHOBESITY');
            CalcObesity();
            $("#CTHDown").trigger('click');
            autoResize('txtCTHAnyHOSurg');
            autoResize('txtCTHRelMedHist');
            $("#CTHUp").trigger('click');
        }
        //Default Check Obesity
        function DefaultObesity() {
            if ($("#txtPACBMI").val() != "") {
                var BMINumber = Number($("#txtPACBMI").val());
                if (BMINumber > 35) {
                    $("#rbtnCTHOBESITY5").prop("checked", true);
                }
                else //priyanka 04/12/2025
                {
                    $("#rbtnCTHOBESITY5").prop("checked", false);
                }
            }
            if (sessionStorage.getItem('PatAge2') != "" && sessionStorage.getItem('PatAge2') != undefined && sessionStorage.getItem('PatAge2') != null) {
                var AgeSpilt = sessionStorage.getItem('PatAge2').split(':');
                if (Number(AgeSpilt[0]) > 50) {
                    $("#rbtnCTHOBESITY6").prop("checked", true);
                }
            }
            if (sessionStorage.getItem('PACPatGender') == "Male") {
                $("#rbtnCTHOBESITY8").prop("checked", true);
            }
            CalcObesity();
        }

        //Bind Comorbidities & Treatment History Info
        function BindComoTreatHistDtls() {
            var Cardic = '<%=Model.Cardiac %>';
            var NYHA = '<%=Model.NYHA %>';
            var ECOG = '<%=Model.ECOG %>';
            var Resp = '<%=Model.Respiratory %>';
            var MMRC = '<%=Model.MMRC %>';
            var NervSys = '<%=Model.NervsousSys %>';
            var Renal = '<%=Model.Renal %>';
            var BldRel = '<%=Model.BloodRelated %>';
            var ObesityIndx = '<%=Model.Obesity %>';        if ('<%=Model.IsHypertension %>' == "Y") {
                $("#ChkCTHHYP").prop("checked", true);
                var Hypertension = '<%=HttpUtility.JavaScriptStringEncode(Model.Hypertension) %>'
                $("#txtCTHHypert").val(Hypertension.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsDiabetesMellitus %>' == "Y") {
                $("#ChkCTHDIABMEL").prop("checked", true);
                var DiabetesMellitus = '<%=HttpUtility.JavaScriptStringEncode(Model.DiabetesMellitus) %>'
                $("#txtCTHDiabMelt").val(DiabetesMellitus.replace(/\\n/g, "\n"));
            }
            if (Cardic != "")
                $("#rbtnCTHCARDI" + Cardic).prop("checked", true);
            var CardiacOthrs = '<%=HttpUtility.JavaScriptStringEncode(Model.CardiacOthrs) %>'
            $("#txtCTHCardiothrs").val(CardiacOthrs.replace(/\\n/g, "\n"));
            if (NYHA != "")
                $("#rbtnCTHNYHA" + NYHA).prop("checked", true);
            if (ECOG != "")
                $("#rbtnCTHECOG" + ECOG).prop("checked", true);
            if (Resp != "")
                $("#rbtnCTHRESP" + Resp).prop("checked", true);
            if (MMRC != "")
                $("#rbtnCTHMMRC" + MMRC).prop("checked", true);
            if (NervSys != "")
                $("#rbtnCTHNERVSYS" + NervSys).prop("checked", true);
            var NervsousSysOthrs = '<%=HttpUtility.JavaScriptStringEncode(Model.NervsousSysOthrs) %>'
            $("#txtCTHNervSysOthrs").val(NervsousSysOthrs.replace(/\\n/g, "\n"));

            if (Renal != "")
                $("#rbtnCTHRENAL" + Renal).prop("checked", true);
            var RenalOthrs = '<%=HttpUtility.JavaScriptStringEncode(Model.RenalOthrs) %>'
            $("#txtCTHRENALOthrs").val(RenalOthrs.replace(/\\n/g, "\n"));
            if ('<%=Model.IsThyroidDisorder %>' == "Y") {
                $("#ChkCTHTHYDIS").prop("checked", true);
                var ThyroidDisorder = '<%=HttpUtility.JavaScriptStringEncode(Model.ThyroidDisorder) %>'
                $("#txtCTHThyroidDis").val(ThyroidDisorder.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsChemotherapy %>' == "Y") {
                $("#ChkCTHCHEMO").prop("checked", true);
                var Chemotherapy = '<%=HttpUtility.JavaScriptStringEncode(Model.Chemotherapy) %>'
                $("#txtCTHChemotherapy").val(Chemotherapy.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsRadiotherapy %>' == "Y") {
                $("#ChkCTHRADIO").prop("checked", true);
                var Radiotherapy = '<%=HttpUtility.JavaScriptStringEncode(Model.Radiotherapy) %>'
                $("#txtCTHRadiotherapy").val(Radiotherapy.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsAntHOSurgery %>' == "Y") {
                $("#ChkCTHANYSURG").prop("checked", true);
                var AnyHOSurg = '<%=HttpUtility.JavaScriptStringEncode(Model.AnyHOSurg) %>'
                $("#txtCTHAnyHOSurg").val(AnyHOSurg.replace(/\\n/g, "\n"));
            }
            if (BldRel != "")
                $("#rbtnCTHBLDREL" + BldRel).prop("checked", true);

<%--            if ('<%=Model.IsDrugSnakeScorpionBite %>' == "Y") {
                $("#ChkCTHBITE").prop("checked", true);
                var DrugBite = '<%=HttpUtility.JavaScriptStringEncode(Model.DrugBite) %>'
                $("#txtCTHBite").val(DrugBite.replace(/\\n/g, "\n"));
            }--%>

            //cardiac
            if ('<%=Model.CardiacIHDYN%>' == "Y") {
                $("#chkIHD").prop("checked", true);
                var CardiacIHDRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.CardiacIHDRemarks) %>'
                $("#txtIHD").val(CardiacIHDRemarks.replace(/\\n/g, "\n"));
                $("#txtIHD").css('display', 'inline-block');
            }
            if ('<%=Model.CardiacCHFYN%>' == "Y") {
                $("#chkCHF").prop("checked", true);
                var CardiacCHFRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.CardiacCHFRemarks) %>'
                $("#txtCHF").val(CardiacCHFRemarks.replace(/\\n/g, "\n"));
                $("#txtCHF").css('display', 'inline-block');
            }
            if ('<%=Model.CardiacTHRYN%>' == "Y") {
                $("#chkOther").prop("checked", true);
                var CardiacTHRRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.CardiacTHRRemarks) %>'
                $("#txtOther").val(CardiacTHRRemarks.replace(/\\n/g, "\n"));
                $("#txtOther").css('display', 'inline-block');
            }
            if ('<%=Model.CardiacRHDYN%>' == "Y") {
                $("#chkRHD").prop("checked", true);
                var CardiacRHDRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.CardiacRHDRemarks) %>'
                $("#txtRHD").val(CardiacRHDRemarks.replace(/\\n/g, "\n"));
                $("#txtRHD").css('display', 'inline-block');
            }
            //End

            //Nervous Syetem
            if ('<%=Model.NervSysEpilepsyYN%>' == "Y") {
                $("#chkEpilepsy").prop("checked", true);
                var NervSysEpilepsyRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.NervSysEpilepsyRemarks) %>'
                $("#txtEpilepsy").val(NervSysEpilepsyRemarks.replace(/\\n/g, "\n"));
                $("#txtEpilepsy").css('display', 'inline-block');
            }

            if ('<%=Model.NervSysStrokeYN%>' == "Y") {
                $("#chkStroke").prop("checked", true);
                var NervSysStrokeRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.NervSysStrokeRemarks) %>'
                $("#txtStroke").val(NervSysStrokeRemarks.replace(/\\n/g, "\n"));
                $("#txtStroke").css('display', 'inline-block');
            }
            if ('<%=Model.NervSysOtherYN%>' == "Y") {
                $("#chkNOthers").prop("checked", true);
                var NervSysOtherRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.NervSysOtherRemarks) %>'
                $("#txtNOthers").val(NervSysOtherRemarks.replace(/\\n/g, "\n"));
                $("#txtNOthers").css('display', 'inline-block');

            }
            //End
            //Renal
            if ('<%=Model.RenalAKIYN%>' == "Y") {
                $("#chkAKI").prop("checked", true);
                var RenalAKIRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.RenalAKIRemarks) %>'
                $("#txtAKI").val(RenalAKIRemarks.replace(/\\n/g, "\n"));
                $("#txtAKI").css('display', 'inline-block');
            }

            if ('<%=Model.RenalCKDYN%>' == "Y") {
                $("#chkCKD").prop("checked", true);
                var RenalCKDRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.RenalCKDRemarks) %>'
                $("#txtCKD").val(RenalCKDRemarks.replace(/\\n/g, "\n"));
                $("#txtCKD").css('display', 'inline-block');
            }
            if ('<%=Model.RenalOtherYN%>' == "Y") {
                $("#chkROthers").prop("checked", true);
                var RenalOtherRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.RenalOtherRemarks) %>'
                $("#txtROthers").val(RenalOtherRemarks.replace(/\\n/g, "\n"));
                $("#txtROthers").css('display', 'inline-block');

              }
            //End

            //Respiratory
            if ('<%=Model.RespiAsthmaYN%>' == "Y") {
                $("#chkASTHMA").prop("checked", true);
                var RespiAsthmaRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.RespiAsthmaRemarks) %>'
                $("#txtASTHMA").val(RespiAsthmaRemarks.replace(/\\n/g, "\n"));
                $("#txtASTHMA").css('display', 'inline-block');
            }

            if ('<%=Model.RespiTBYN%>' == "Y") {
                $("#chkTB").prop("checked", true);
                var RespiTBRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.RespiTBRemarks) %>'
                $("#txtTB").val(RespiTBRemarks.replace(/\\n/g, "\n"));
                $("#txtTB").css('display', 'inline-block');
            }
            if ('<%=Model.RespiCOPDYN%>' == "Y") {
                $("#chkCOPD").prop("checked", true);
                var RespiCOPDRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.RespiCOPDRemarks) %>'
                $("#txtCOPD").val(RespiCOPDRemarks.replace(/\\n/g, "\n")); //priyanka 03/04/2026
                $("#txtCOPD").css('display', 'inline-block');
            }
            //End

            //Blood Related
            if ('<%=Model.BloodRelAnaYN%>' == "Y") {
                $("#chkAnaemia").prop("checked", true);
                var BloodRelAnaRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.BloodRelAnaRemarks) %>'
                $("#txtAnaemia").val(BloodRelAnaRemarks.replace(/\\n/g, "\n"));
                $("#txtAnaemia").css('display', 'inline-block');
            }

            if ('<%=Model.BloodRelHoYN%>' == "Y") {
                $("#chkTrasDis").prop("checked", true);
                var BloodRelHoRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.BloodRelHoRemarks) %>'
                $("#txtTransDisorder").val(BloodRelHoRemarks.replace(/\\n/g, "\n"));
                $("#txtTransDisorder").css('display', 'inline-block');
            }
            
             //End

            if ('<%=Model.DrugAllergyYN %>' == "Y") {
                $("#ChkDrugAlleg").prop("checked", true);
                var DrugBite = '<%=HttpUtility.JavaScriptStringEncode(Model.DrugAllergyRemarks) %>'
                $("#txtDrugAlleg").val(DrugBite.replace(/\\n/g, "\n"));

            }
            if ('<%=Model.SnakeBiteYN %>' == "Y") {
                $("#ChkCTHBITE").prop("checked", true);
                var snakBite = '<%=HttpUtility.JavaScriptStringEncode(Model.SnakeBiteRemarks) %>'
                $("#txtCTHBite").val(snakBite.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.ScorpionBiteYN %>' == "Y") {
                $("#ChkSTRINGBITE").prop("checked", true);
                var ScorpionBite = '<%=HttpUtility.JavaScriptStringEncode(Model.ScorpionBiteRemarks) %>'
                $("#txtSTRINGBite").val(ScorpionBite.replace(/\\n/g, "\n"));
            }
            if ('<%=Model.IsAnyRevlMediHist %>' == "Y") {
                $("#ChkCTHANYRELHIST").prop("checked", true);
                var OtherMedicalHist = '<%=HttpUtility.JavaScriptStringEncode(Model.OtherMedicalHist) %>'
                $("#txtCTHRelMedHist").val(OtherMedicalHist.replace(/\\n/g, "\n"));
            }
            //EnDisRadioOtherField('rbtnCTHCARDI4', 'txtCTHCardiothrs');
            //EnDisRadioOtherField('rbtnCTHNERVSYS3', 'txtCTHNervSysOthrs');
            //EnDisRadioOtherField('rbtnCTHRENAL3', 'txtCTHRENALOthrs');
            if (("" + ObesityIndx) != "")
                BindMultiCheckBoxVal("rbtnCTHOBESITY", ObesityIndx);
            EnDisChkTextbox('ChkCTHHYP', 'txtCTHHypert');
            EnDisChkTextbox('ChkCTHDIABMEL', 'txtCTHDiabMelt');
            EnDisChkTextbox('ChkCTHTHYDIS', 'txtCTHThyroidDis');
            EnDisChkTextbox('ChkCTHCHEMO', 'txtCTHChemotherapy');
            EnDisChkTextbox('ChkCTHRADIO', 'txtCTHRadiotherapy');
            EnDisChkTextbox('ChkCTHANYSURG', 'txtCTHAnyHOSurg');
            EnDisChkTextbox('ChkCTHBITE', 'txtCTHBite');
            EnDisChkTextbox('ChkSTRINGBITE', 'txtSTRINGBite');
            EnDisChkTextbox('ChkDrugAlleg', 'txtDrugAlleg');
            EnDisChkTextbox('ChkCTHANYRELHIST', 'txtCTHRelMedHist');
            $("#CTHDown").trigger('click');
            autoResize('txtCTHAnyHOSurg');
            autoResize('txtCTHRelMedHist');
            $("#CTHUp").trigger('click');
        }
        //Validation For Comorbidities & Treatment History Info
        function ValidationForComoTreatHistInfo() { //priyanka 21/03/2026
            if (ValidTextCheck('ChkCTHHYP', 'txtCTHHypert') == false)
                return false;
            if (ValidTextCheck('ChkCTHDIABMEL', 'txtCTHDiabMelt') == false)
                return false;
            if (ValidTextCheck('ChkCTHTHYDIS', 'txtCTHThyroidDis') == false)
                return false;
            if (ValidTextCheck('ChkCTHCHEMO', 'txtCTHChemotherapy') == false)
                return false;
            if (ValidTextCheck('ChkCTHRADIO', 'txtCTHRadiotherapy') == false)
                return false;
            if (ValidTextCheck('ChkCTHANYSURG', 'txtCTHAnyHOSurg') == false)
                return false;
            if (ValidTextCheck('ChkCTHBITE', 'txtCTHBite') == false)
                return false;
            if (ValidTextCheck('ChkDrugAlleg', 'txtDrugAlleg') == false)
                return false;
            if (ValidTextCheck('ChkSTRINGBITE', 'txtSTRINGBite') == false)
                return false;
            if (ValidTextCheck('ChkCTHANYRELHIST', 'txtCTHRelMedHist') == false)
                return false;
            if (ValidTextCheck('chkIHD', 'txtIHD') == false)
                return false;
            if (ValidTextCheck('chkCHF', 'txtCHF') == false)
                return false;
            if (ValidTextCheck('chkRHD', 'txtRHD') == false)
                return false;
            if (ValidTextCheck('chkOther', 'txtOther') == false)
                return false;
            if (ValidTextCheck('chkEpilepsy', 'txtEpilepsy') == false)
                return false;
            if (ValidTextCheck('chkStroke', 'txtStroke') == false)
                return false;
            if (ValidTextCheck('chkNOthers', 'txtNOthers') == false)
                return false;
            if (ValidTextCheck('chkASTHMA', 'txtASTHMA') == false)
                return false;
            if (ValidTextCheck('chkTB', 'txtTB') == false)
                return false;
            if (ValidTextCheck('chkCOPD', 'txtCOPD') == false)
                return false;
            if (ValidTextCheck('chkAKI', 'txtAKI') == false)
                return false;
            if (ValidTextCheck('chkCKD', 'txtCKD') == false)
                return false;
            if (ValidTextCheck('chkROthers', 'txtROthers') == false)
                return false;
            if (ValidTextCheck('chkAnaemia', 'txtAnaemia') == false)
                return false;
            if (ValidTextCheck('chkTrasDis', 'txtTransDisorder') == false)
                return false;
            return true;
        }
        //General Comorbidities & Treatment History Info Save Value Pass
        function SaveForComoTreatHistInfo(PostData) {
            PostData.push({ name: 'IsHypertension', value: SaveValueTextCheck('ChkCTHHYP') });
            PostData.push({ name: 'Hypertension', value: $("#txtCTHHypert").val() });
            PostData.push({ name: 'IsDiabetesMellitus', value: SaveValueTextCheck('ChkCTHDIABMEL') });
            PostData.push({ name: 'DiabetesMellitus', value: $("#txtCTHDiabMelt").val() });
            //PostData.push({ name: 'Cardiac', value: GetLastLetterCheckedRadio('CTHCARDI') });
            //PostData.push({ name: 'CardiacOthrs', value: $("#txtCTHCardiothrs").val() });
            PostData.push({ name: 'CardiacIHDYN', value: $("#chkIHD").prop("checked") == true ? "Y" : "N" });   //Cardiac
            PostData.push({ name: 'CardiacIHDRemarks', value: $("#txtIHD").val() });
            PostData.push({ name: 'CardiacCHFYN', value: $("#chkCHF").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'CardiacCHFRemarks', value: $("#txtCHF").val() });
            PostData.push({ name: 'CardiacRHDYN', value: $("#chkRHD").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'CardiacRHDRemarks', value: $("#txtRHD").val() });
            PostData.push({ name: 'CardiacTHRYN', value: $("#chkOther").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'CardiacTHRRemarks', value: $("#txtOther").val() });
            PostData.push({ name: 'NYHA', value: GetLastLetterCheckedRadio('CTHNYHA') });
            PostData.push({ name: 'ECOG', value: GetLastLetterCheckedRadio('CTHECOG') });
            //  PostData.push({ name: 'Respiratory', value: GetLastLetterCheckedRadio('CTHRESP') });
            PostData.push({ name: 'RespiAsthmaYN', value: $("#chkASTHMA").prop("checked") == true ? "Y" : "N" });  //Respiratory
            PostData.push({ name: 'RespiAsthmaRemarks', value: $("#txtASTHMA").val() });
            PostData.push({ name: 'RespiTBYN', value: $("#chkTB").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'RespiTBRemarks', value: $("#txtTB").val() });
            PostData.push({ name: 'RespiCOPDYN', value: $("#chkCOPD").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'RespiCOPDRemarks', value: $("#txtCOPD").val() });
            PostData.push({ name: 'MMRC', value: GetLastLetterCheckedRadio('CTHMMRC') });
            //PostData.push({ name: 'NervsousSys', value: GetLastLetterCheckedRadio('CTHNERVSYS') });
            //PostData.push({ name: 'NervsousSysOthrs', value: $("#txtCTHNervSysOthrs").val() });
            PostData.push({ name: 'NervSysEpilepsyYN', value: $("#chkEpilepsy").prop("checked") == true ? "Y" : "N" }); //NervousSystem
            PostData.push({ name: 'NervSysEpilepsyRemarks', value: $("#txtEpilepsy").val() });
            PostData.push({ name: 'NervSysStrokeYN', value: $("#chkStroke").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'NervSysStrokeRemarks', value: $("#txtStroke").val() });
            PostData.push({ name: 'NervSysOtherYN', value: $("#chkNOthers").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'NervSysOtherRemarks', value: $("#txtNOthers").val() });

           // PostData.push({ name: 'Renal', value: GetLastLetterCheckedRadio('CTHRENAL') });
            //PostData.push({ name: 'RenalOthrs', value: $("#txtCTHRENALOthrs").val() });
            PostData.push({ name: 'RenalAKIYN', value: $("#chkAKI").prop("checked") == true ? "Y" : "N" }); // Renal
            PostData.push({ name: 'RenalAKIRemarks', value: $("#txtAKI").val() });
            PostData.push({ name: 'RenalCKDYN', value: $("#chkCKD").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'RenalCKDRemarks', value: $("#txtCKD").val() });
            PostData.push({ name: 'RenalOtherYN', value: $("#chkROthers").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'RenalOtherRemarks', value: $("#txtROthers").val() });

            PostData.push({ name: 'IsThyroidDisorder', value: SaveValueTextCheck('ChkCTHTHYDIS') });
            PostData.push({ name: 'ThyroidDisorder', value: $("#txtCTHThyroidDis").val() });
            PostData.push({ name: 'IsChemotherapy', value: SaveValueTextCheck('ChkCTHCHEMO') });
            PostData.push({ name: 'Chemotherapy', value: $("#txtCTHChemotherapy").val() });
            PostData.push({ name: 'IsRadiotherapy', value: SaveValueTextCheck('ChkCTHRADIO') });
            PostData.push({ name: 'Radiotherapy', value: $("#txtCTHRadiotherapy").val() });
            PostData.push({ name: 'IsAntHOSurgery', value: SaveValueTextCheck('ChkCTHANYSURG') });
            PostData.push({ name: 'AnyHOSurg', value: JSON.stringify($("#txtCTHAnyHOSurg").val().toString().trim()) });


           // PostData.push({ name: 'BloodRelated', value: GetLastLetterCheckedRadio('CTHBLDREL') });
            PostData.push({ name: 'BloodRelAnaYN', value: $("#chkAnaemia").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'BloodRelAnaRemarks', value: $("#txtAnaemia").val() });
            PostData.push({ name: 'BloodRelHoYN', value: $("#chkTrasDis").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'BloodRelHoRemarks', value: $("#txtTransDisorder").val() });

            PostData.push({ name: 'SnakeBiteYN', value: SaveValueTextCheck('ChkCTHBITE') });
            PostData.push({ name: 'SnakeBiteRemarks', value: $("#txtCTHBite").val() });
            PostData.push({ name: 'DrugAllergyYN', value: SaveValueTextCheck('ChkDrugAlleg') });
            PostData.push({ name: 'DrugAllergyRemarks', value: $("#txtDrugAlleg").val() });
            PostData.push({ name: 'ScorpionBiteYN', value: SaveValueTextCheck('ChkSTRINGBITE') });
            PostData.push({ name: 'ScorpionBiteRemarks', value: $("#txtSTRINGBite").val() });
            PostData.push({ name: 'IsAnyRevlMediHist', value: SaveValueTextCheck('ChkCTHANYRELHIST') });
            PostData.push({ name: 'OtherMedicalHist', value: JSON.stringify($("#txtCTHRelMedHist").val().toString().trim()) });
            PostData.push({ name: 'Obesity', value: GetMultiCheckBoxVal('CTHOBESITY') });
            return PostData;
        }
        //General Physical Examination Info Print
        function PrintComoTreatHistInfo(PrintData) {
            PrintData.push({ name: 'IsHypertension', value: SaveValueTextCheck('ChkCTHHYP') });
            PrintData.push({ name: 'Hypertension', value: $("#txtCTHHypert").val() });
            PrintData.push({ name: 'IsDiabetesMellitus', value: SaveValueTextCheck('ChkCTHDIABMEL') });
            PrintData.push({ name: 'DiabetesMellitus', value: $("#txtCTHDiabMelt").val() });
            PrintData.push({ name: 'Cardiac', value: GetCheckRadioLabel('CTHCARDI') });
            PrintData.push({ name: 'CardiacOthrs', value: $("#txtCTHCardiothrs").val() });
            PrintData.push({ name: 'NYHA', value: GetCheckRadioLabel('CTHNYHA') });
            PrintData.push({ name: 'ECOG', value: GetCheckRadioLabel('CTHECOG') });
            PrintData.push({ name: 'Respiratory', value: GetCheckRadioLabel('CTHRESP') });
            PrintData.push({ name: 'MMRC', value: GetCheckRadioLabel('CTHMMRC') });
            PrintData.push({ name: 'NervsousSys', value: GetCheckRadioLabel('CTHNERVSYS') });
            PrintData.push({ name: 'NervsousSysOthrs', value: $("#txtCTHNervSysOthrs").val() });
            PrintData.push({ name: 'Renal', value: GetCheckRadioLabel('CTHRENAL') });
            PrintData.push({ name: 'RenalOthrs', value: $("#txtCTHRENALOthrs").val() });
            PrintData.push({ name: 'IsThyroidDisorder', value: SaveValueTextCheck('ChkCTHTHYDIS') });
            PrintData.push({ name: 'ThyroidDisorder', value: $("#txtCTHThyroidDis").val() });
            PrintData.push({ name: 'IsChemotherapy', value: SaveValueTextCheck('ChkCTHCHEMO') });
            PrintData.push({ name: 'Chemotherapy', value: $("#txtCTHChemotherapy").val() });
            PrintData.push({ name: 'IsRadiotherapy', value: SaveValueTextCheck('ChkCTHRADIO') });
            PrintData.push({ name: 'Radiotherapy', value: $("#txtCTHRadiotherapy").val() });
            PrintData.push({ name: 'IsAntHOSurgery', value: SaveValueTextCheck('ChkCTHANYSURG') });
            PrintData.push({ name: 'AnyHOSurg', value: JSON.stringify($("#txtCTHAnyHOSurg").val().toString().trim()) });
            PrintData.push({ name: 'BloodRelated', value: GetCheckRadioLabel('CTHBLDREL') });
            PrintData.push({ name: 'IsDrugSnakeScorpionBite', value: SaveValueTextCheck('ChkCTHBITE') });
            PrintData.push({ name: 'DrugBite', value: $("#txtCTHBite").val() });
            PrintData.push({ name: 'IsAnyRevlMediHist', value: SaveValueTextCheck('ChkCTHANYRELHIST') });
            PrintData.push({ name: 'OtherMedicalHist', value: JSON.stringify($("#txtCTHRelMedHist").val().toString().trim()) });
            PrintData.push({ name: 'ObesityScore', value: $("#txtObesity").val() });
            PrintData.push({ name: 'Obesity', value: GetCheckboxLabels('CTHOBESITY', ",") });
            return PrintData;
        }
    </script>

    <%-- Substance Abuse History Info --%>
    <script type="text/javascript">
        //Substance Abuse History Info Load
        function SubsAbuseHistInfoLoad() {
            BindSubsAbuseHistInfoGaction();
        }
        //Substance Abuse History Info Gaction
        function BindSubsAbuseHistInfoGaction() {
            if (Gaction == "N") {
                ClearSubsAbuseHistInfo();
            }
            else {
                BindSubsAbuseHistDtls();
            }
        }
        //Clear Substance Abuse History Info
        function ClearSubsAbuseHistInfo() {
            $("#txtSAHDrugs").val("");
            $("#txtSAHAlcohol").val("");
            $("#txtSAHBetalNut").val("");
            $("#txtSAHTobacco").val("");
            $("#txtSAHSmoking").val("");
            //Abhishesh || 20260814
            $("#ChkSAHDrugs").prop("checked", false);
            $("#ChkSAHAlcohol").prop("checked", false);
            $("#ChkSAHBetalNut").prop("checked", false);
            $("#ChkSAHTobacco").prop("checked", false);
            $("#ChkSAHSmoking").prop("checked", false);

            EnDisChkTextbox('ChkSAHDrugs', 'txtSAHDrugs');
            EnDisChkTextbox('ChkSAHAlcohol', 'txtSAHAlcohol');
            EnDisChkTextbox('ChkSAHBetalNut', 'txtSAHBetalNut');
            EnDisChkTextbox('ChkSAHTobacco', 'txtSAHTobacco');
            EnDisChkTextbox('ChkSAHSmoking', 'txtSAHSmoking');
            //End
        }
        //Bind Substance Abuse History Info
        function BindSubsAbuseHistDtls() {
            var Drugs = '<%=HttpUtility.JavaScriptStringEncode(Model.Drugs) %>'
            $("#txtSAHDrugs").val(Drugs.replace(/\\n/g, "\n"));
            $("#ChkSAHDrugs").prop("checked", Drugs != "");
            EnDisChkTextbox('ChkSAHDrugs', 'txtSAHDrugs');
            $("#txtSAHDrugs").val(Drugs.replace(/\\n/g, "\n"));

            var Alcohol = '<%=HttpUtility.JavaScriptStringEncode(Model.Alcohol) %>'
            $("#ChkSAHAlcohol").prop("checked", Alcohol != "");
            EnDisChkTextbox('ChkSAHAlcohol', 'txtSAHAlcohol');
            $("#txtSAHAlcohol").val(Alcohol.replace(/\\n/g, "\n"));

            var BetalNut = '<%=HttpUtility.JavaScriptStringEncode(Model.BetalNut) %>'
            $("#ChkSAHBetalNut").prop("checked", BetalNut != "");
            EnDisChkTextbox('ChkSAHBetalNut', 'txtSAHBetalNut');
            $("#txtSAHBetalNut").val(BetalNut.replace(/\\n/g, "\n"));

            var Tobacco = '<%=HttpUtility.JavaScriptStringEncode(Model.Tobacco) %>'
            $("#ChkSAHTobacco").prop("checked", Tobacco != "");
            EnDisChkTextbox('ChkSAHTobacco', 'txtSAHTobacco');
            $("#txtSAHTobacco").val(Tobacco.replace(/\\n/g, "\n"));

            var Smoking = '<%=HttpUtility.JavaScriptStringEncode(Model.Smoking) %>'
            $("#ChkSAHSmoking").prop("checked", Smoking != "");
            EnDisChkTextbox('ChkSAHSmoking', 'txtSAHSmoking');
            $("#txtSAHSmoking").val(Smoking.replace(/\\n/g, "\n"));
        }
        //Validation For Substance Abuse History Info
       function ValidationForSubsAbuseHistInfo() { //priyanka 21/03/2026
            if (ValidTextCheck('ChkSAHDrugs', 'txtSAHDrugs') == false) {
                return false;
            }
            if (ValidTextCheck('ChkSAHAlcohol', 'txtSAHAlcohol') == false) {
                return false;
            }
            if (ValidTextCheck('ChkSAHBetalNut', 'txtSAHBetalNut') == false) {
                return false;
            }
            if (ValidTextCheck('ChkSAHTobacco', 'txtSAHTobacco') == false) {
                return false;
            }
            if (ValidTextCheck('ChkSAHSmoking', 'txtSAHSmoking') == false) {
                return false;
            }
            return true;
        }
        //General Substance Abuse History Info Save Value Pass
        function SaveForSubsAbuseHistInfo(PostData) {
            PostData.push({ name: 'Drugs', value: $("#txtSAHDrugs").val() });
            PostData.push({ name: 'Alcohol', value: $("#txtSAHAlcohol").val() });
            PostData.push({ name: 'BetalNut', value: $("#txtSAHBetalNut").val() });
            PostData.push({ name: 'Tobacco', value: $("#txtSAHTobacco").val() });
            PostData.push({ name: 'Smoking', value: $("#txtSAHSmoking").val() });
            return PostData;
        }
        //General Substance Examination Info Print
        function PrintSubsAbuseHistInfo(PrintData) {
            PrintData.push({ name: 'Drugs', value: $("#txtSAHDrugs").val() });
            PrintData.push({ name: 'Alcohol', value: $("#txtSAHAlcohol").val() });
            PrintData.push({ name: 'BetalNut', value: $("#txtSAHBetalNut").val() });
            PrintData.push({ name: 'Tobacco', value: $("#txtSAHTobacco").val() });
            PrintData.push({ name: 'Smoking', value: $("#txtSAHSmoking").val() });
            return PrintData;
        }
    </script>

    <%-- Airway Assesment Info --%>
    <script type="text/javascript">
        //Airway Assesment Info Load
        function AirwayAssmntInfoLoad() {
            BindAirwayAssmntInfoGaction();
        }
        //Airway Assesment Info Gaction
        function BindAirwayAssmntInfoGaction() {
            if (Gaction == "N") {
                ClearAirwayAssmntInfo();
            }
            else {
                BindAirwayAssmntDtls();
            }
        }
        //Clear Airway Assesment Info
        function ClearAirwayAssmntInfo() {
            UncheckRadioBtn('AANARES');
            UncheckRadioBtn('AANASALSEP');
            UncheckRadioBtn('AAMOUTHOPN');
            UncheckRadioBtn('AATEETH');
            UncheckRadioBtn('AAMALLTI');
            UncheckRadioBtn('AAJAWSLID');
            UncheckRadioBtn('AATRIS');
            UncheckRadioBtn('AATHYDIST');
            $("#txtAAMallRemark").val("");
            $("#txtAANeck").val("");
            $("#txtAASpine").val("");
            $("#ChkAATRACH").prop("checked", false);
            EnDisChkTextbox('ChkAATRACH', 'txtAATracheostomy');
            $("#txtAAAirComment").val("");
        }
        //Bind Airway Assesment Info
        function BindAirwayAssmntDtls() {
            var Nares = '<%=Model.NARES %>';
            var Nasal = '<%=Model.NASALSeptum %>';
            var Mouth = '<%=Model.MouthOpen %>';
            var Teeth = '<%=Model.Teeth %>';
            var Mallti = '<%=Model.Mallampati %>';
            var Jawslid = '<%=Model.Jawsliding %>';
            var Tris = '<%=Model.Trismus %>';
            var Thydist = '<%=Model.ThyromentalDisorder %>';
            if (Nares != "")
                $("#rbtnAANARES" + Nares).prop("checked", true);
            if (Nasal != "")
                $("#rbtnAANASALSEP" + Nasal).prop("checked", true);
            if (Mouth != "")
                $("#rbtnAAMOUTHOPN" + Mouth).prop("checked", true);
            if (Teeth != "")
                $("#rbtnAATEETH" + Teeth).prop("checked", true);
            if (Mallti != "")
                $("#rbtnAAMALLTI" + Mallti).prop("checked", true);
            if (Jawslid != "")
                $("#rbtnAAJAWSLID" + Jawslid).prop("checked", true);
            if (Tris != "")
                $("#rbtnAATRIS" + Tris).prop("checked", true);
            if (Thydist != "")
                $("#rbtnAATHYDIST" + Thydist).prop("checked", true);
            var Neck = '<%=HttpUtility.JavaScriptStringEncode(Model.Neck) %>'
            $("#txtAANeck").val(Neck.replace(/\\n/g, "\n"));
            var Spine = '<%=HttpUtility.JavaScriptStringEncode(Model.Spine) %>'
            $("#txtAASpine").val(Spine.replace(/\\n/g, "\n"));
            if ('<%=Model.IsTracheostomy %>' == "Y") {
                $("#ChkAATRACH").prop("checked", true);
                var Tracheostomy = '<%=HttpUtility.JavaScriptStringEncode(Model.Tracheostomy) %>'
                $("#txtAATracheostomy").val(Tracheostomy.replace(/\\n/g, "\n"));
            }
            var MallampattiRemark = '<%=HttpUtility.JavaScriptStringEncode(Model.MallampattiRemark) %>'
            $("#txtAAMallRemark").val(MallampattiRemark.replace(/\\n/g, "\n"));
            var Airwaycomment = '<%=HttpUtility.JavaScriptStringEncode(Model.Airwaycomment) %>'
            $("#txtAAAirComment").val(Airwaycomment.replace(/\\n/g, "\n"));
            EnDisChkTextbox('ChkAATRACH', 'txtAATracheostomy');

            //Teeth
            if ('<%=Model.TeethNormalYN%>' == "Y") {
                $("#chkNormal").prop("checked", true);
                var TeethNormalRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.TeethNormalRemarks) %>'
                $("#txtNormal").val(TeethNormalRemarks.replace(/\\n/g, "\n"));
                $("#txtNormal").css('display', 'none');
            }
            if ('<%=Model.TeethEdenYN%>' == "Y") {
                $("#chkEdentulous").prop("checked", true);
                var TeethEdenRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.TeethEdenRemarks) %>'
                //$("#txtCHF").val(TeethEdenRemarks.replace(/\\n/g, "\n"));
                //$("#txtCHF").css('display', 'inline-block');

                //priyanka 21/03/2026
                $("#txtEdentulous").val(TeethEdenRemarks.replace(/\\n/g, "\n"));
                $("#txtEdentulous").css('display', 'inline-block');
                //end
            }
            if ('<%=Model.TeethProYN%>' == "Y") {
                $("#chkProtruding").prop("checked", true);
                var TeethProRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.TeethProRemarks) %>'
                $("#txtProtruding").val(TeethProRemarks.replace(/\\n/g, "\n"));
                $("#txtProtruding").css('display', 'inline-block');
            }
            if ('<%=Model.TeethArtiYN%>' == "Y") {
                $("#chkArtificial").prop("checked", true);
                var TeethArtiRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.TeethArtiRemarks) %>'
                $("#txtArtificial").val(TeethArtiRemarks.replace(/\\n/g, "\n"));
                $("#txtArtificial").css('display', 'inline-block');
            }
            if ('<%=Model.TeethBuckYN%>' == "Y") {
                $("#chkBuck").prop("checked", true);
                var TeethBuckRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.TeethBuckRemarks) %>'
                $("#txtBuck").val(TeethBuckRemarks.replace(/\\n/g, "\n"));
                $("#txtBuck").css('display', 'inline-block');
            }
            if ('<%=Model.TeethLooseYN%>' == "Y") {
                $("#chkLooseTooth").prop("checked", true);
                var TeethLooseRemarks = '<%=HttpUtility.JavaScriptStringEncode(Model.TeethLooseRemarks) %>'
                $("#txtLooseTooth").val(TeethLooseRemarks.replace(/\\n/g, "\n"));
                $("#txtLooseTooth").css('display', 'inline-block');
            }
            //End


        }
        //Validation For Airway Assesment Info
        function ValidationForAirwayAssmntInfo() {
            var Nares = GetLastLetterCheckedRadio('AANARES');
            if (Nares == "") {
                $("#AADown").trigger('click');
                FocusRadioOpt("rbtnAANARES1", "Please Select NARES");
                return false;
            }
            var Nasal = GetLastLetterCheckedRadio('AANASALSEP');
            if (Nasal == "") {
                $("#AADown").trigger('click');
                FocusRadioOpt("rbtnAANASALSEP1", "Please Select Deviated NASAL Septum");
                return false;
            }
            var Mouth = GetLastLetterCheckedRadio('AAMOUTHOPN');
            if (Mouth == "") {
                $("#AADown").trigger('click');
                FocusRadioOpt("rbtnAAMOUTHOPN1", "Please Select Mouth Opening");
                return false;
            }
            //var Teeth = GetLastLetterCheckedRadio('AATEETH');
            //if (Teeth == "") {
            //    $("#AADown").trigger('click');
            //    FocusRadioOpt("rbtnAATEETH1", "Please Select Teeth");
            //    return false;
            //}

            //priyanka 21/03/2026
            //if (ValidTextCheck('chkNormal', 'txtNormal') == false) { //commented by priyanka 15/04/2026
            //    return false;
            //}
            if (ValidTextCheck('chkEdentulous', 'txtEdentulous') == false) {
                return false;
            }
            if (ValidTextCheck('chkProtruding', 'txtProtruding') == false) {
                return false;
            }
            if (ValidTextCheck('chkArtificial', 'txtArtificial') == false) {
                return false;
            }
            if (ValidTextCheck('chkBuck', 'txtBuck') == false) {
                return false;
            }
            if (ValidTextCheck('chkLooseTooth', 'txtLooseTooth') == false) {
                return false;
            }
            //end
            var Mallti = GetLastLetterCheckedRadio('AAMALLTI');
            if (Mallti == "") {
                $("#AADown").trigger('click');
                FocusRadioOpt("rbtnAAMALLTI1", "Please Select Mallampati");
                return false;
            }
            var Jawslid = GetLastLetterCheckedRadio('AAJAWSLID');
            if (Jawslid == "") {
                $("#AADown").trigger('click');
                FocusRadioOpt("rbtnAAJAWSLID1", "Please Select Jaw Sliding");
                return false;
            }
            var Tris = GetLastLetterCheckedRadio('AATRIS');
            if (Tris == "") {
                $("#AADown").trigger('click');
                FocusRadioOpt("rbtnAATRIS1", "Please Select Trismus");
                return false;
            }
            var Thydist = GetLastLetterCheckedRadio('AATHYDIST');
            if (Thydist == "") {
                $("#AADown").trigger('click');
                FocusRadioOpt("rbtnAATHYDIST1", "Please Select Thyromental Distance");
                return false;
            }
            if (ValidTextCheck('ChkAATRACH', 'txtAATracheostomy') == false)
                return false;
            return true;
        }
        //Airway Assesment Info Save Value Pass
        function SaveForAirwayAssmntInfo(PostData) {
            PostData.push({ name: 'NARES', value: GetLastLetterCheckedRadio('AANARES') });
            PostData.push({ name: 'NASALSeptum', value: GetLastLetterCheckedRadio('AANASALSEP') });
            PostData.push({ name: 'MouthOpen', value: GetLastLetterCheckedRadio('AAMOUTHOPN') });
            // PostData.push({ name: 'Teeth', value: GetLastLetterCheckedRadio('AATEETH') });
            //Teeth
            PostData.push({ name: 'TeethNormalYN', value: $("#chkNormal").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'TeethNormalRemarks', value: $("#txtNormal").val() });
            PostData.push({ name: 'TeethEdenYN', value: $("#chkEdentulous").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'TeethEdenRemarks', value: $("#txtEdentulous").val() });
            PostData.push({ name: 'TeethProYN', value: $("#chkProtruding").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'TeethProRemarks', value: $("#txtProtruding").val() });
            PostData.push({ name: 'TeethArtiYN', value: $("#chkArtificial").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'TeethArtiRemarks', value: $("#txtArtificial").val() });
            PostData.push({ name: 'TeethBuckYN', value: $("#chkBuck").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'TeethLooseYN', value: $("#chkLooseTooth").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'TeethLooseRemarks', value: $("#txtLooseTooth").val() });
            PostData.push({ name: 'TeethBuckRemarks', value: $("#txtBuck").val() });
            PostData.push({ name: 'Mallampati', value: GetLastLetterCheckedRadio('AAMALLTI') });
            PostData.push({ name: 'MallampattiRemark', value: $("#txtAAMallRemark").val() });
            PostData.push({ name: 'Jawsliding', value: GetLastLetterCheckedRadio('AAJAWSLID') });
            PostData.push({ name: 'Trismus', value: GetLastLetterCheckedRadio('AATRIS') });
            PostData.push({ name: 'ThyromentalDisorder', value: GetLastLetterCheckedRadio('AATHYDIST') });
            PostData.push({ name: 'Neck', value: $("#txtAANeck").val() });
            PostData.push({ name: 'Spine', value: $("#txtAASpine").val() });
            PostData.push({ name: 'IsTracheostomy', value: SaveValueTextCheck('ChkAATRACH') });
            PostData.push({ name: 'Tracheostomy', value: $("#txtAATracheostomy").val() });
            PostData.push({ name: 'Airwaycomment', value: $("#txtAAAirComment").val() });
            return PostData;
        }
        //Airway Assesment Examination Info Print
        function PrintAirwayAssmntInfo(PrintData) {
            PrintData.push({ name: 'NARES', value: GetCheckRadioLabel('AANARES') });
            PrintData.push({ name: 'NASALSeptum', value: GetCheckRadioLabel('AANASALSEP') });
            PrintData.push({ name: 'MouthOpen', value: GetCheckRadioLabel('AAMOUTHOPN') });
            PrintData.push({ name: 'Teeth', value: GetCheckRadioLabel('AATEETH') });
            PrintData.push({ name: 'Mallampati', value: GetCheckRadioLabel('AAMALLTI') });
            PrintData.push({ name: 'MallampattiRemark', value: $("#txtAAMallRemark").val() });
            PrintData.push({ name: 'Jawsliding', value: GetCheckRadioLabel('AAJAWSLID') });
            PrintData.push({ name: 'Trismus', value: GetCheckRadioLabel('AATRIS') });
            PrintData.push({ name: 'ThyromentalDisorder', value: GetCheckRadioLabel('AATHYDIST') });
            PrintData.push({ name: 'Neck', value: $("#txtAANeck").val() });
            PrintData.push({ name: 'Spine', value: $("#txtAASpine").val() });
            PrintData.push({ name: 'IsTracheostomy', value: SaveValueTextCheck('ChkAATRACH') });
            PrintData.push({ name: 'Tracheostomy', value: $("#txtAATracheostomy").val() });
            PrintData.push({ name: 'Airwaycomment', value: $("#txtAAAirComment").val() });
            return PrintData;
        }
    </script>

    <%-- Systemic Examination Info --%>
    <script type="text/javascript">
        //Systemic Examination Info Load
        function SysExamInfoLoad() {
            BindSysExamInfoGaction();
        }
        //Systemic Examination Info Gaction
        function BindSysExamInfoGaction() {
            if (Gaction == "N") {
                ClearSysExamInfo();
            }
            else {
                BindSysExamDtls();
            }
        }
        //Clear Systemic Examination Info
        function ClearSysExamInfo() {
            $("#txtSECardiSys").val("");
            $("#txtSERespSys").val("");
            $("#txtSEAdboSys").val("");
            $("#txtSECentNervSys").val("");
        }
        //Bind Substance Abuse History Info
        function BindSysExamDtls() {
            var CardiovascularSys = '<%=HttpUtility.JavaScriptStringEncode(Model.CardiovascularSys) %>'
            $("#txtSECardiSys").val(CardiovascularSys.replace(/\\n/g, "\n"));
            var RespiratorySys = '<%=HttpUtility.JavaScriptStringEncode(Model.RespiratorySys) %>'
            $("#txtSERespSys").val(RespiratorySys.replace(/\\n/g, "\n"));
            var AdbominalSys = '<%=HttpUtility.JavaScriptStringEncode(Model.AdbominalSys) %>'
            $("#txtSEAdboSys").val(AdbominalSys.replace(/\\n/g, "\n"));
            var CentralNervSys = '<%=HttpUtility.JavaScriptStringEncode(Model.CentralNervSys) %>'
            $("#txtSECentNervSys").val(CentralNervSys.replace(/\\n/g, "\n"));
            $("#SEDown").trigger('click');
            autoResize('txtSECardiSys');
            autoResize('txtSERespSys');
            autoResize('txtSEAdboSys');
            autoResize('txtSECentNervSys');
            $("#SEUp").trigger('click');
        }
        //Validation For Substance Abuse History Info
        function ValidationForSysExamInfo() {
            return true;
        }
        //General Substance Abuse History Info Save Value Pass
        function SaveForSysExamInfo(PostData) {
            PostData.push({ name: 'CardiovascularSys', value: JSON.stringify($("#txtSECardiSys").val().toString().trim()) });
            PostData.push({ name: 'RespiratorySys', value: JSON.stringify($("#txtSERespSys").val().toString().trim()) });
            PostData.push({ name: 'AdbominalSys', value: JSON.stringify($("#txtSEAdboSys").val().toString().trim()) });
            PostData.push({ name: 'CentralNervSys', value: JSON.stringify($("#txtSECentNervSys").val().toString().trim()) });
            return PostData;
        }
        //General Substance Abuse History Info Print
        function PrintSysExamInfo(PrintData) {
            PrintData.push({ name: 'CardiovascularSys', value: JSON.stringify($("#txtSECardiSys").val().toString().trim()) });
            PrintData.push({ name: 'RespiratorySys', value: JSON.stringify($("#txtSERespSys").val().toString().trim()) });
            PrintData.push({ name: 'AdbominalSys', value: JSON.stringify($("#txtSEAdboSys").val().toString().trim()) });
            PrintData.push({ name: 'CentralNervSys', value: JSON.stringify($("#txtSECentNervSys").val().toString().trim()) });
            return PrintData;
        }
    </script>

    <%-- ARISCAT Criteria Info --%>
    <script type="text/javascript">
        //ARISCAT Criteria Info Load
        function ARISCATCritInfoLoad() {
            BindARISCATCritInfoGaction()
        }
        //ARISCAT Criteria Info Gaction
        function BindARISCATCritInfoGaction() {
            if (Gaction == "N") {
                ClearARISCATCritInfo();
            }
            else {
                BindARISCATCritDtls();
                CalcRiskPPCRate();
            }
        }
        //Clear ARISCAT Criteria Info
        function ClearARISCATCritInfo() {
            UncheckRadioBtn('ARISCATAGE');
            UncheckRadioBtn('ARISCATSPO2');
            UncheckRadioBtn('ARISCATRESINFT');
            UncheckRadioBtn('ARISCATHB');
            UncheckRadioBtn('ARISCATINC');
            UncheckRadioBtn('ARISCATSURG');
            UncheckRadioBtn('ARISCATEMGPROC');
            $("#txtARISCATRiskCatg").val("");
            $("#txtARISCATPPCRate").val("");
            $("#txtINCOther").val("");//priyanka 19/11/2025
            if (sessionStorage.getItem('PatAge2') != "" && sessionStorage.getItem('PatAge2') != undefined && sessionStorage.getItem('PatAge2') != null) {
                var AgeSpilt = sessionStorage.getItem('PatAge2').split(':');
                if (Number(AgeSpilt[0]) <= 51) {
                    $("#rbtnAge1").prop("checked", true);
                }
                else if (Number(AgeSpilt[0]) > 51 && Number(AgeSpilt[0]) <= 80) {
                    $("#rbtnAge2").prop("checked", true);
                }
                else if (Number(AgeSpilt[0]) > 80) {
                    $("#rbtnAge3").prop("checked", true);
                }
                $("#rbtnAge1").prop("disabled", true);
                $("#rbtnAge2").prop("disabled", true);
                $("#rbtnAge3").prop("disabled", true);
            }
            var SPO2 = "";
            if ($("#txtPVSMSPO").val() != "") {
                SPO2 = Number($("#txtPVSMSPO").val());
            }
            else if (PatVitalsList.length > 0) {
                if (PatVitalsList.length == 1) {
                    SPO2 = PatVitalsList[0].SPO2 == "" ? "" : Number(PatVitalsList[0].SPO2);
                }
                else {
                    const latestRecord = PatVitalsList.sort(function (a, b) {
                        var SpltDate1 = a.VITALDATE.split(' ');
                        var SpltDate2 = b.VITALDATE.split(' ');
                        const dateA = new Date(SpltDate1[0].split('/').reverse().join('-'));
                        const dateB = new Date(SpltDate1[1].split('/').reverse().join('-'));
                        return dateB - dateA;
                    })[0];
                    SPO2 = latestRecord.SPO2
                }
            }
            if (SPO2 != "") {
                if (SPO2 <= 90) {
                    $("#rbtnPreOPSPO1").prop("checked", true);
                }
                else if (SPO2 >= 91 && SPO2 <= 95) {
                    $("#rbtnPreOPSPO2").prop("checked", true);
                }
                else {
                    $("#rbtnPreOPSPO3").prop("checked", true);
                }
            }
            if ($("#rbtnPACNATSURGE").prop("checked") == true)
                $("#rbtnEMGPROC1").prop("checked", true);
            else
                $("#rbtnEMGPROC2").prop("checked", true);
            CalcRiskPPCRate();
        }

        //Calculate ARISCAT Risk and PPC Rate
        function CalcRiskPPCRate() {
            var TotalRisk = 0; var RiskCatg = ""; var PPCRate = "";
            //Age 
            if ($("#rbtnAge2").prop("checked") == true)
                TotalRisk += 3;
            else if ($("#rbtnAge3").prop("checked") == true)
                TotalRisk += 16;
            //SPO2
            if ($("#rbtnPreOPSPO1").prop("checked") == true)
                TotalRisk += 24;
            else if ($("#rbtnPreOPSPO2").prop("checked") == true)
                TotalRisk += 8;
            //Resp Inft 1 Month
            if ($("#rbtnRESPINFT1").prop("checked") == true)
                TotalRisk += 17;
            //Pre-OP Hb 
            if ($("#rbtnPreOPHB1").prop("checked") == true)
                TotalRisk += 11;
            //Incision
            if ($("#rbtnINC1").prop("checked") == true)
                TotalRisk += 15;
            else if ($("#rbtnINC2").prop("checked") == true)
                TotalRisk += 24;
            //Surgery
            if ($("#rbtnARISCATSURG1").prop("checked") == true)
                TotalRisk += 16;
            else if ($("#rbtnARISCATSURG2").prop("checked") == true)
                TotalRisk += 23;
            //Emergency Procedure
            if ($("#rbtnEMGPROC1").prop("checked") == true)
                TotalRisk += 8;
            if (TotalRisk == 0) {
                TotalRisk = "";
                RiskCatg = "";
                PPCRate = "";
            }
            else if (TotalRisk < 26) {
                RiskCatg = "Low Risk";
                PPCRate = "1.6%";
            }
            else if (TotalRisk >= 26 && TotalRisk <= 44) {
                RiskCatg = "Intermediate Risk";
                PPCRate = "13.3%";
            }
            else if (TotalRisk > 44) {
                RiskCatg = "High Risk";
                PPCRate = "42.1%";
            }
            $("#txtARISCATTotal").val(TotalRisk);
            $("#txtARISCATRiskCatg").val(RiskCatg);
            $("#txtARISCATPPCRate").val(PPCRate);

            if (Gaction == "N" || Gaction == "E") {
                if (TotalRisk > 44)
                    $("#rbtnRSKFCTIND1").prop("checked", true);
                else
                    $("#rbtnRSKFCTIND1").prop("checked", false);
                CalcReviCardRsk();
            }
        }
        //Bind ARISCAT Criteria Info
        function BindARISCATCritDtls() {
            var ARIAge = '<%=Model.ARIAge %>';
            var SPO2 = '<%=Model.PreOPSPO2 %>';
            var RespInft = '<%=Model.RespInfct1Month %>';
            var HB = '<%=Model.PreOPHb %>';
            var Incision = '<%=Model.Incision %>';
            var Surgery = '<%=Model.Surgery %>';
            var EmgProc = '<%=Model.EmgProcedure %>';
            var IncisionOther = '<%=Model.IncisionOther %>'; //Priyanka 19/11/2025
            if ('<%=Model.ARISCATNAYN %>' == "Y") {
                $("#ChkARISCATNA").prop("checked", true);
            }
            else {
                if (ARIAge != "")
                    $("#rbtnAge" + ARIAge).prop("checked", true);
                if (SPO2 != "")
                    $("#rbtnPreOPSPO" + SPO2).prop("checked", true);
                if (RespInft != "")
                    $("#rbtnRESPINFT" + RespInft).prop("checked", true);
                if (HB != "")
                    $("#rbtnPreOPHB" + HB).prop("checked", true);
                if (Incision != "")
                    $("#rbtnINC" + Incision).prop("checked", true);
                if (Surgery != "")
                    $("#rbtnARISCATSURG" + Surgery).prop("checked", true);
                if (EmgProc != "")
                    $("#rbtnEMGPROC" + EmgProc).prop("checked", true);
                $("#txtARISCATRiskCatg").val('<%=Model.RiskCatg %>');
                $("#txtARISCATPPCRate").val('<%=Model.PPCRate %>');
                //Priyanka 19/11/2025
                $("#txtINCOther").val('<%=Model.IncisionOther %>');
                if ($("#rbtnINC4").prop("checked") === true) {
                    $("#txtINCOther").show();
                } else {
                    $("#txtINCOther").hide();
                }
                //End
            }
            NACheckHeaderInfo('ChkARISCATNA', 'DivContentARISCAT', 'ARISCATUp', 'ARISCATDown');
        }
        //Validation For ARISCAT Criteria Info
        function ValidationForARISCATCritInfo() {
            if ($("#ChkARISCATNA").prop("checked") == false) {
                var RadioAge = GetLastLetterCheckedRadio('ARISCATAGE');
                if (RadioAge == "") {
                    $("#ARISCATDown").trigger('click');
                    FocusRadioOpt("rbtnAge1", "Please Select ARISCAT Criteria Age");
                    return false;
                }
                var SPO2 = GetLastLetterCheckedRadio('ARISCATSPO2');
                if (SPO2 == "") {
                    $("#ARISCATDown").trigger('click');
                    FocusRadioOpt("rbtnPreOPSPO1", "Please Select Pre-op SpO2");
                    return false;
                }
                var RespInft = GetLastLetterCheckedRadio('ARISCATRESINFT');
                if (RespInft == "") {
                    $("#ARISCATDown").trigger('click');
                    FocusRadioOpt("rbtnRESPINFT1", "Please Select Respiratory Infection in Last 1 Month");
                    return false;
                }
                var HB = GetLastLetterCheckedRadio('ARISCATHB');
                if (HB == "") {
                    $("#ARISCATDown").trigger('click');
                    FocusRadioOpt("rbtnPreOPHB1", "Please Select Pre-Op Hb");
                    return false;
                }
                var Incision = GetLastLetterCheckedRadio('ARISCATINC');
                if (Incision == "") {
                    $("#ARISCATDown").trigger('click');
                    FocusRadioOpt("rbtnINC1", "Please Select Incision");
                    return false;
                }

                if (Incision != "" && Incision === "4")//Priyanka 19/11/2025
                {
                    if ($("#txtINCOther").val() === "") {
                        FocusRadioOpt("txtINCOther", "Please Enter Other Incision");
                        return false;
                    }
                }
                //end
                var Surgy = GetLastLetterCheckedRadio('ARISCATSURG');
                if (Surgy == "") {
                    $("#ARISCATDown").trigger('click');
                    FocusRadioOpt("rbtnARISCATSURG1", "Please Select Surgery");
                    return false;
                }
                var EmgProc = GetLastLetterCheckedRadio('ARISCATEMGPROC');
                if (EmgProc == "") {
                    ToastMsg("Please Select Emergency Procedure", "Information");
                    $("#ARISCATDown").trigger('click');
                    FocusRadioOpt("rbtnEMGPROC1", "Please Select Emergency Procedure");
                    return false;
                }
            }
            return true;
        }
        //ARISCAT Criteria Info Save Value Pass
        function SaveForARISCATCritInfo(PostData) {
            PostData.push({ name: 'ARIAge', value: GetLastLetterCheckedRadio('ARISCATAGE') });
            PostData.push({ name: 'PreOPSPO2', value: GetLastLetterCheckedRadio('ARISCATSPO2') });
            PostData.push({ name: 'RespInfct1Month', value: GetLastLetterCheckedRadio('ARISCATRESINFT') });
            PostData.push({ name: 'PreOPHb', value: GetLastLetterCheckedRadio('ARISCATHB') });
            PostData.push({ name: 'Incision', value: GetLastLetterCheckedRadio('ARISCATINC') });
            PostData.push({ name: 'Surgery', value: GetLastLetterCheckedRadio('ARISCATSURG') });
            PostData.push({ name: 'EmgProcedure', value: GetLastLetterCheckedRadio('ARISCATEMGPROC') });
            PostData.push({ name: 'RiskCatg', value: $("#txtARISCATRiskCatg").val() });
            PostData.push({ name: 'PPCRate', value: $("#txtARISCATPPCRate").val() });
            PostData.push({ name: 'ARISCATNAYN', value: $("#ChkARISCATNA").prop("checked") == true ? "Y" : "N" });
            PostData.push({ name: 'IncisionOther', value: $("#txtINCOther").val() });//priyanka 19/11/2025
            return PostData;
        }
        //ARISCAT Criteria Info Print
        function PrintARISCATCritInfo(PrintData) {
            PrintData.push({ name: 'ARIAge', value: GetCheckRadioLabel('ARISCATAGE') });
            PrintData.push({ name: 'PreOPSPO2', value: GetCheckRadioLabel('ARISCATSPO2') });
            PrintData.push({ name: 'RespInfct1Month', value: GetCheckRadioLabel('ARISCATRESINFT') });
            PrintData.push({ name: 'PreOPHb', value: GetCheckRadioLabel('ARISCATHB') });
            PrintData.push({ name: 'Incision', value: GetCheckRadioLabel('ARISCATINC') });
            PrintData.push({ name: 'Surgery', value: GetCheckRadioLabel('ARISCATSURG') });
            PrintData.push({ name: 'EmgProcedure', value: GetCheckRadioLabel('ARISCATEMGPROC') });
            PrintData.push({ name: 'ARISCATTotal', value: $("#txtARISCATTotal").val() });
            PrintData.push({ name: 'RiskCatg', value: $("#txtARISCATRiskCatg").val() });
            PrintData.push({ name: 'PPCRate', value: $("#txtARISCATPPCRate").val() });
            PrintData.push({ name: 'ARISCATNAYN', value: $("#ChkARISCATNA").prop("checked") == true ? "Y" : "N" });
            return PrintData;
        }

    </script>

    <%-- Revised Lee Cardiac Risk Info --%>
    <script type="text/javascript">
        //Revised Lee Cardiac Risk Info Load
        function ReviLeeCardRskInfoLoad() {
            BindReviLeeCardRskInfoGaction();
        }
        //Revised Lee Cardiac Risk Info Gaction
        function BindReviLeeCardRskInfoGaction() {
            if (Gaction == "N") {
                ClearReviLeeCardRskInfo();
            }
            else {
                BindReviLeeCardRskDtls();
                CalcReviCardRsk();
            }
        }
        //Clear Revised Lee Cardiac Risk Info
        function ClearReviLeeCardRskInfo() {
            UncheckRadioBtn('RLCRFIFACTIND');
            if (Gaction == "N") {
                //if ($("#txtARISCATRiskCatg").val() == "High Risk")
                //    $("#rbtnRSKFCTIND1").prop("checked", true);
                //else
                //    $("#rbtnRSKFCTIND1").prop("checked", false);
                CalcReviCardRsk();
            }
            $("#txtRSKFCTClass").val("");
            $("#txtRSKFCTCardioEvnt").val("");
            CalcReviCardRsk();
        }
        //Calculate Class and Major Cardic Event
        function CalcReviCardRsk() {
            var CheckedCount = 0; var Class = "I"; var RiskEvent = "0.4%";
            document.querySelectorAll('input[name="RLCRFIFACTIND"]').forEach(function (CheckBox) {
                if (CheckBox.checked)
                    CheckedCount++;
            });
            if (CheckedCount == 0) {
                Class = Class;
                RiskEvent = RiskEvent;
            }
            else if (CheckedCount == 1) {
                Class = "II";
                RiskEvent = "0.9%";
            }
            else if (CheckedCount == 2) {
                Class = "III";
                RiskEvent = "6.6%";
            }
            else if (CheckedCount > 2) {
                Class = "IV";
                RiskEvent = "11%";
            }
            else {
                Class = "";
                RiskEvent = "";
            }
            $("#txtRSKFCTClass").val(Class);
            $("#txtRSKFCTCardioEvnt").val(RiskEvent);
        }
        //Bind Revised Lee Cardiac Risk Info
        function BindReviLeeCardRskDtls() {
            var FactorIndx = '<%=Model.ReviLeeCardiIndx %>';
            if ('<%=Model.REVLEENAYN %>' == "Y") {
                $("#ChkRevLeeNA").prop("checked", true);
            }
            else {
                if (("" + FactorIndx) != "")
                    BindMultiCheckBoxVal("rbtnRSKFCTIND", FactorIndx);
                $("#txtRSKFCTClass").val('<%=Model.ReviLeeClass %>');
                $("#txtRSKFCTCardioEvnt").val('<%=Model.ReviLeeCardiEvent %>');
            }
            CalcReviCardRsk();
        }
        //Validation For Revised Lee Cardiac Risk Info
        function ValidationForReviLeeCardRskInfo() {
            return true;
        }
        //Revised Lee Cardiac Risk Info Save Value Pass
        function SaveForReviLeeCardRskInfo(PostData) {
            PostData.push({ name: 'ReviLeeCardiIndx', value: GetMultiCheckBoxVal("RLCRFIFACTIND") });
            PostData.push({ name: 'ReviLeeClass', value: $("#txtRSKFCTClass").val() });
            PostData.push({ name: 'ReviLeeCardiEvent', value: $("#txtRSKFCTCardioEvnt").val() });
            PostData.push({ name: 'REVLEENAYN', value: $("#ChkChildPughNA").prop("checked") == true ? "Y" : "N" });
            return PostData;
        }
        //Revised Lee Cardiac Risk Info Print
        function PrintReviLeeCardRskInfo(PrintData) {
            PrintData.push({ name: 'ReviLeeCardiIndx', value: GetCheckboxLabels("RLCRFIFACTIND", ",") });
            PrintData.push({ name: 'ReviLeeClass', value: $("#txtRSKFCTClass").val() });
            PrintData.push({ name: 'ReviLeeCardiEvent', value: $("#txtRSKFCTCardioEvnt").val() });
            PrintData.push({ name: 'REVLEENAYN', value: $("#ChkChildPughNA").prop("checked") == true ? "Y" : "N" });
            return PrintData;
        }
    </script>

    <%-- Child Pugh Turcotte Score Info --%>
    <script type="text/javascript">
        //Child Pugh Turcotte Score Info Load
        function ChildPughScrInfoLoad() {
            BindChildPughScrInfoGaction();
        }
        //Child Pugh Turcotte Score Info Gaction
        function BindChildPughScrInfoGaction() {
            if (Gaction == "N") {
                ClearChildPughScrInfo();
            }
            else {
                BindChildPughScrDtls();
                CalcChildPughScore();
            }
        }
        //Clear Child Pugh Turcotte Score Info
        function ClearChildPughScrInfo() {
            //$("#rbtnCPTSENC1").prop("checked", true);
            //$("#rbtnCPTSASCT1").prop("checked", true);
            //$("#rbtnCPTSBILI1").prop("checked", true);
            //$("#rbtnCPTSALBU1").prop("checked", true);
            //$("#rbtnCPTSINR1").prop("checked", true);
            $("#txtCPTSClass").val("");
            $("#txtCPTSPoints").val("");
            CalcChildPughScore()
        }
        //Calculate Child Pugh Turcotte Score
        function CalcChildPughScore() {
            var TotalPoints = 0; var Class = "";
            if ($("#rbtnCPTSENC1").prop("checked"))
                TotalPoints += 1;
            if ($("#rbtnCPTSENC2").prop("checked"))
                TotalPoints += 2;
            if ($("#rbtnCPTSENC3").prop("checked"))
                TotalPoints += 3;
            if ($("#rbtnCPTSASCT1").prop("checked"))
                TotalPoints += 1;
            if ($("#rbtnCPTSASCT2").prop("checked"))
                TotalPoints += 2;
            if ($("#rbtnCPTSASCT3").prop("checked"))
                TotalPoints += 3;
            if ($("#rbtnCPTSBILI1").prop("checked"))
                TotalPoints += 1;
            if ($("#rbtnCPTSBILI2").prop("checked"))
                TotalPoints += 2;
            if ($("#rbtnCPTSBILI3").prop("checked"))
                TotalPoints += 3;
            if ($("#rbtnCPTSALBU1").prop("checked"))
                TotalPoints += 1;
            if ($("#rbtnCPTSALBU2").prop("checked"))
                TotalPoints += 2;
            if ($("#rbtnCPTSALBU3").prop("checked"))
                TotalPoints += 3;
            if ($("#rbtnCPTSINR1").prop("checked"))
                TotalPoints += 1;
            if ($("#rbtnCPTSINR2").prop("checked"))
                TotalPoints += 2;
            if ($("#rbtnCPTSINR3").prop("checked"))
                TotalPoints += 3;
            if (TotalPoints >= 5 && TotalPoints <= 6) {
                Class = "A";
            }
            else if (TotalPoints >= 7 && TotalPoints <= 9) {
                Class = "B";
            }
            else if (TotalPoints >= 10 && TotalPoints <= 15) {
                Class = "C";
            }
            else {
                TotalPoints = "";
                Class = "";
            }
            //priyanka 21/03/2026
            $("#txtCPTSClass").val(Class);
            $("#txtCPTSPoints").val(TotalPoints);
        }
        //Bind Child Pugh Turcotte Score Info
        function BindChildPughScrDtls() {
            var Encephalopathy = '<%=Model.Encephalopathy %>';
            var Ascites = '<%=Model.Ascites %>';
            var Bilirubin = '<%=Model.Bilirubin%>';
            var Albumin = '<%=Model.Albumin %>';
            var INR = '<%=Model.INR %>';
            if ('<%=Model.CHILDPUGHNAYN %>' == "Y") {
                $("#ChkChildPughNA").prop("checked", true);
            }
            else {
                if (Encephalopathy != "")
                    $("#rbtnCPTSENC" + Encephalopathy).prop("checked", true);
                if (Ascites != "")
                    $("#rbtnCPTSASCT" + Ascites).prop("checked", true);
                if (Bilirubin != "")
                    $("#rbtnCPTSBILI" + Bilirubin).prop("checked", true);
                if (Albumin != "")
                    $("#rbtnCPTSALBU" + Albumin).prop("checked", true);
                if (INR != "")
                    $("#rbtnCPTSINR" + INR).prop("checked", true);
                $("#txtCPTSClass").val('<%=Model.ChildPughClass %>');
                $("#txtCPTSPoints").val('<%=Model.ChildPughPoints %>');
            }
            NACheckHeaderInfo('ChkChildPughNA', 'DivContentCPTS', 'CPTSUp', 'CPTSDown');
        }
        //Validation For Child Pugh Turcotte Score Info
        function ValidationForChildPughScrInfo() {
            if ($("#ChkChildPughNA").prop("checked") == false) {
                if (GetLastLetterCheckedRadio('CPTSENC') == "") {
                    FocusRadioOpt("rbtnCPTSENC1", "Please Select anyone in Encephalopathy");
                    return false;
                }
                if (GetLastLetterCheckedRadio('CPTSASCT') == "") {
                    FocusRadioOpt("rbtnCPTSASCT1", "Please Select anyone in Ascites");
                    return false;
                }
                if (GetLastLetterCheckedRadio('CPTSBILI') == "") {
                    FocusRadioOpt("rbtnCPTSBILI1", "Please Select anyone in Bilirubin (mg/dl)");
                    return false;
                }
                if (GetLastLetterCheckedRadio('CPTSALBU') == "") {
                    FocusRadioOpt("rbtnCPTSALBU1", "Please Select anyone in Albumin (gm/dl)");
                    return false;
                }
                if (GetLastLetterCheckedRadio('CPTSINR') == "") {
                    FocusRadioOpt("rbtnCPTSINR1", "Please Select anyone in INR");
                    return false;
                }
            }
            return true;
        }
        //Child Pugh Turcotte Score Info Save Value Pass
        function SaveForChildPughScrInfo(PostData) {
            PostData.push({ name: 'Encephalopathy', value: GetLastLetterCheckedRadio('CPTSENC') });
            PostData.push({ name: 'Ascites', value: GetLastLetterCheckedRadio('CPTSASCT') });
            PostData.push({ name: 'Bilirubin', value: GetLastLetterCheckedRadio('CPTSBILI') });
            PostData.push({ name: 'Albumin', value: GetLastLetterCheckedRadio('CPTSALBU') });
            PostData.push({ name: 'INR', value: GetLastLetterCheckedRadio('CPTSINR') });
            PostData.push({ name: 'ChildPughClass', value: $("#txtCPTSClass").val() });
            PostData.push({ name: 'ChildPughPoints', value: $("#txtCPTSPoints").val() });
            PostData.push({ name: 'CHILDPUGHNAYN', value: $("#ChkChildPughNA").prop("checked") == true ? "Y" : "N" });
            return PostData;
        }
        //Child Pugh Turcotte Score Info Print
        function PrintChildPughScrInfo(PrintData) {
            PrintData.push({ name: 'Encephalopathy', value: GetCheckRadioLabel('CPTSENC') });
            PrintData.push({ name: 'Ascites', value: GetCheckRadioLabel('CPTSASCT') });
            PrintData.push({ name: 'Bilirubin', value: GetCheckRadioLabel('CPTSBILI') });
            PrintData.push({ name: 'Albumin', value: GetCheckRadioLabel('CPTSALBU') });
            PrintData.push({ name: 'INR', value: GetCheckRadioLabel('CPTSINR') });
            PrintData.push({ name: 'ChildPughClass', value: $("#txtCPTSClass").val() });
            PrintData.push({ name: 'ChildPughPoints', value: $("#txtCPTSPoints").val() });
            PrintData.push({ name: 'CHILDPUGHNAYN', value: $("#ChkChildPughNA").prop("checked") == true ? "Y" : "N" });
            return PrintData;
        }
    </script>

    <%-- Investigation Info --%>
    <script type="text/javascript">
        //Cancer Care History Info Load
        function CancerCareHistoryInfoLoad() {
            $("#CancerCareHist").click(function () {
                var MRNO =sessionStorage.getItem('PatMRNO');
                var TranNo =sessionStorage.getItem('PatTRANNO');
                if (MRNO == "" || MRNO == null) {
                    ToastMsg('Please Select Patient', 'Info');
                }
                else {
                    sessionStorage.setItem('Pagefrom', "PAC");
                    openCancerCareHistframe(MRNO);
                }
            });
        }


        //Investigation Info Load
        function InvestigationInfoLoad() {
            $("#InvestRpt").click(function () {
                var MRNO =sessionStorage.getItem('PatMRNO');
                var TranNo =sessionStorage.getItem('PatTRANNO');
                if (MRNO == "" || MRNO == null) {
                    ToastMsg('Please Select Patient', 'Info');
                }
                else {
                    sessionStorage.setItem('Pagefrom', "PAC");
                    openInvestigationframe(MRNO);
                }
            });

            document.addEventListener('click', function (event) {
                const searchInput = document.getElementById('txtSearchInvst');
                const resultsDiv = document.getElementById('DivSearchInvstList');
                if (!searchInput.contains(event.target) && !resultsDiv.contains(event.target)) {
                    resultsDiv.style.display = 'none';
                    $("#txtSearchInvst").val("");
                }
            });
            document.getElementById('txtSearchInvst').addEventListener('input', function () {
                const query = this.value.trim().toLowerCase();
                const resultsDiv = document.getElementById('DivSearchInvstList');
                resultsDiv.innerHTML = '';
                if (query.length >= 3) {
                    resultsDiv.style.display = "block";
                    var matched = SearchInvestigationsList.filter(function (item) { return item.TESTNAME.toLowerCase().includes(query); });
                    if (matched.length == 0) {
                        GetAllInvestigation(query);
                        matched = SearchInvestigationsList.filter(function (item) { return item.TESTNAME.toLowerCase().includes(query); });
                    }
                    if (matched.length > 0) {
                        matched.forEach(function (item) {
                            var FilterData = AllPACTestAdviceList.filter(function (A) { return A.TESTCODE == item.TESTCODE && A.CHECKED == "Y"; });
                            var Check = false; var Disable = false;
                            if (FilterData.length > 0) {
                                Check = true;
                                Disable = true;
                                //Disable = FilterData[0].TRANYN == "Y" ? true : false;
                            }
                            const checkbox = document.createElement('input');
                            checkbox.className = 'TestListSearchChk';
                            checkbox.type = 'checkbox';
                            checkbox.id = 'invst_' + item.TESTCODE;
                            checkbox.checked = Check;
                            checkbox.disabled = Disable;
                            checkbox.onclick = function () {
                                var Id = ("ChkAdvTest_EDITADVTEST_" + item.TESTCODE);
                                var Check = checkbox.checked == true ? "Y" : "N";
                                var FilterD = AllPACTestAdviceList.filter(function (A) { return A.TESTCODE == item.TESTCODE; });
                                const container = document.getElementById('AdviceTestListOption');
                                const matchingElements = Array.from(container.querySelectorAll('[id]')).filter(function (el) {
                                    return el.id.startsWith('ChkAdvTest_') && el.id.endsWith(item.TESTCODE);
                                });
                                if (FilterD.length > 0) {
                                    AllPACTestAdviceList[0].CHECKED = Check;
                                    if (matchingElements.length == 0) {
                                        BindTestListForAdvice(FilterD, "EDITADVTEST", true);
                                    }
                                }
                                else {
                                    var FList = [];
                                    var Lst = {
                                        CHECKED: "Y",
                                        CODE: item.TESTCODE,
                                        SETUPCODE: "",
                                        TESTCODE: item.TESTCODE,
                                        TESTNAME: item.TESTNAME,
                                        TRANYN: "N"
                                    };
                                    AllPACTestAdviceList.push(Lst);
                                    FList.push(Lst);
                                    if (checkbox.checked) {
                                        BindTestListForAdvice(FList, "EDITADVTEST", true);
                                    }
                                }
                                AddRemTestFromInvstList(item.TESTCODE, Check);
                                if (matchingElements.length > 0) {
                                    Id = matchingElements[0].id;
                                }
                                var CheckYN = $("#" + Id).prop("checked", (Check == "Y" ? true : false));
                                AdviceListColorChange(Id);
                            };
                            const label = document.createElement('label');
                            label.className = 'TestListSearchLbl';
                            label.htmlFor = checkbox.id;
                            label.innerHTML = item.TESTNAME;
                            const div = document.createElement('div');
                            div.className = 'TestListSearchDiv';
                            div.appendChild(checkbox);
                            div.appendChild(label);
                            resultsDiv.appendChild(div);
                        });
                    } else {
                        resultsDiv.innerHTML = '<small>No results found.</small>';
                    }
                }
                else {
                    resultsDiv.style.display = "none";
                }
            });
            BindInvestigationInfoGaction();
        }

        //Get All Investigation List
        function GetAllInvestigation(FilterInvestigationText) {
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetTestList",
                data: { testname: FilterInvestigationText, strTranNo: "" },
                async: false,
                success: function (response) {
                    SearchInvestigationsList = response;
                },
                complete: function () {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                },
            });
        }

        //Investigation Info Gaction
        function BindInvestigationInfoGaction() {
            GetAllTest();
            if (Gaction == "N") {
                ClearInvestigationInfo();
                GetInvestigationAdviceList();
            }
            else {
                //priyanka 25/02/2026
                //if (sessionStorage.getItem("PACConsltNo") === sessionStorage.getItem("PACRefPACTranNo")) {
                //    BindInvestDtls();
                //}
                BindInvestDtls();
                document.getElementById("AdviceList").style.display = "none";
                document.getElementById("InvstSearchList").style.display = "none";
                document.querySelectorAll('#AdviceTestListOption input, #AdviceTestListOption button').forEach(function (el) { el.disabled = true });
            }
        }

        //Get All Test List
        function GetAllTest() {
            $.ajax({
                type: "POST",
                url:  "../DoctorDesk/GetInvestigationList",
                data: {},
                async: false,
                success: function (response) {
                    SearchInvestigationsList = response;
                },
                complete: function () {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                },
            });
        }

        //Clear Investigation Info
        function ClearInvestigationInfo() {
            GetInvestigationAdviceList();
        }

        //Bind Investigation Info
        function BindInvestDtls() {
            //Abhishesh || 20260825
          <%--  var InvstData = `<%=Model.InvstData %>`;
            var ResultData = `<%=Model.ResultInvstData %>`;--%>

            var InvstData =<%= Newtonsoft.Json.JsonConvert.SerializeObject(Model.InvstData ?? "") %>;
            var ResultData =<%= Newtonsoft.Json.JsonConvert.SerializeObject(Model.ResultInvstData ?? "") %>;

            AllPACTestAdviceList = InvstData ? JSON.parse(InvstData) : [];
            AllResultInvstList = ResultData ? JSON.parse(ResultData) : [];
            BckAllResultInvstList = ResultData ? JSON.parse(ResultData) : [];
            //End
            //AllPACTestAdviceList = AllPACTestAdviceList.filter(x => x.TRANNO == sessionStorage.getItem("PACConsltNo"));
            //if (AllPACTestAdviceList.length == 0) {
            //    AllResultInvstList = [];
            //    BckAllResultInvstList = [];
            //}

            var FilterForCurConsultADV = AllPACTestAdviceList.filter(x => x.TRANNO == sessionStorage.getItem("PACConsltNo"));
            BindTestListForAdvice(FilterForCurConsultADV, "EDITADVTEST", true);
        }

        //Validation For Investigation Info
        function ValidationForInvestInfo() {
            return true;
        }

        //Investigation Info Save Value Pas
        function SaveForInvestInfo(PostData) {
            const parentDiv = document.getElementById("AdviceTestListOption");
            const childDivs = parentDiv.querySelectorAll("div");
            var FilterData = [];
            for (var i = 0; i < childDivs.length; i++) {
                var id = childDivs[i].id;
                if (id) {
                    var IdSplit = id.split('_');
                    var SetupCode = IdSplit[1];
                    var TestCode = IdSplit[2];
                    //priyanka 
                    var SelY = AllPACTestAdviceList.filter(function (a) {
                        return a.CHECKED === "Y" &&
                            a.CODE === TestCode &&
                            (SetupCode === "EDITADVTEST" || a.SETUPCODE === SetupCode) &&
                            (a.TRANYN === undefined || a.TRANYN === "N");
                    });
                    if (Gaction != "N") {
                        SelY = AllPACTestAdviceList.filter(function (a) { return a.CHECKED == "Y" && a.TESTCODE === TestCode && a.TRANYN == "N"; })
                    }
                    if (SelY.length > 0) {
                        var PushData = {
                            SEQNO: (FilterData.length + 1),
                            TESTCODE: TestCode,
                            TESTNAME: SelY[0].TESTNAME.trim()
                        }
                        FilterData.push(PushData);
                    }
                }
            }
            var FilterResult = [];
            $.grep(AllResultInvstList, function (a) {
                if (a.RESULTTYPE != "H") {
                    if (a.RESULTDT != "" && (a.INVINHOUSEDATE == "" || a.INVINHOUSEDATE == undefined) && a.INRESULTDT == "") {
                        var TestNameList = AllPACTestAdviceList.filter(function (c) { return c.TESTCODE == a.TESTCODE; });
                        var TestName = "";
                        if (TestNameList.length > 0) {
                            TestName = TestNameList[0].TESTNAME;
                        }
                        a.TESTNAME = TestName;
                        FilterResult.push(a);
                    }
                }
            });

            $.grep(FilterData, function (a) {
                if (a.TRANNO == undefined || a.TRANNO == null || a.TRANNO == "") {
                    a.TRANNO = sessionStorage.getItem("PACConsltNo");
                }
            });

            $.grep(FilterResult, function (a) {
                if (a.TRANNO == undefined || a.TRANNO == null || a.TRANNO == "") {
                    a.TRANNO = sessionStorage.getItem("PACConsltNo");
                }
            });

            PostData.push({ name: 'InvstData', value: JSON.stringify(FilterData) });
            PostData.push({ name: 'ResultInvstData', value: JSON.stringify(FilterResult) });
            return PostData;
        }

        //Get Advice Setup List
        function GetInvestigationAdviceList() {
            debugger;
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetPersInvestigationList",
                data: {},
                asycn: false,
                success: function (response) {
                    AllPACAdviceList = [];
                    AllPACTestAdviceList = [];
                    if (response != "" && response != "UNSUCCESSFULL") {
                        var result = JSON.parse(response);
                        result.Table1.forEach(function (item) { item.CHECKED = "N"; });
                        AllPACAdviceList = result.Table1;
                    }
                    BindInvestigationAdviceList(AllPACAdviceList);
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                },
                complete: function () {
                }
            });
        }

        //Bind Advice Setup list
        function BindInvestigationAdviceList(List) {
            $("#AdviceTestListOption").empty();
            $("#AdviceListOption").empty();
            var SepDiv = '<div class="AdviListSepDiv" id="{SEPDIVID}">{DIVCONTENT}</div>';
            var CheckBox = '<input type="checkbox" id="{SEPCHKBOXID}" class="AdvListChkbox" onclick="AdviceListColorChange(this.id);AddUpdateInvstAdviceandTestList(this.id);" />';
            var CheckBoxLbl = '<label for="{SEPCHKBOXID}" class="AdvListLbl">{LABELCONTENT}</label>';
            $.grep(List, function (a) {
                var ChkId = "ChkAdv_" + a.CODE;
                var DivId = "Div" + ChkId;
                var RplCheckBox = CheckBox.replace("{SEPCHKBOXID}", ChkId);
                var RplCheckBoxLbl = CheckBoxLbl.replace("{SEPCHKBOXID}", ChkId).replace("{LABELCONTENT}", a.DESC);
                var RplSepDiv = SepDiv.replace("{SEPDIVID}", DivId).replace("{DIVCONTENT}", (RplCheckBox + RplCheckBoxLbl));
                $("#AdviceListOption").append(RplSepDiv);
            });
        }

        //Get Advice Test List
        function GetTestListForAdvice(Id) {
            $.ajax({
                url: '../DoctorDesk/GetInvstListBySetupCode',
                data: { strSetUpCode: Id },
                type: 'post',
                datatype: 'get',
                async: false,
                success: function (response) {
                    if (response != "" && response.length > 0) {
                        var FList = [];
                        response.forEach(function (item) {
                            item.TESTCODE = item.CODE;
                            item.CHECKED = "Y";
                            var Filter = AllPACTestAdviceList.filter(function (a) { a.TRANYN = "N"; return a.TESTCODE == item.CODE; });
                            if (Filter.length == 0) {
                                AllPACTestAdviceList.push(item);
                                FList.push(item);
                            }
                        });
                        BindTestListForAdvice(FList, Id, true);
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                },
                complete: function () {
                    HoldOn.close();
                }
            })
        }

        //Bind Advice Test List
        function BindTestListForAdvice(List, AdviceId, CheckedFlag) {
            var SepDiv = '<div class="AdviListSepDiv" id="{SEPDIVID}">{DIVCONTENT}</div>';
            var CheckBox = '<input type="checkbox" id="{SEPCHKBOXID}" class="AdvListChkbox" onclick="AdviceListColorChange(this.id);AddUpdateInvstAdviceandTestList(this.id);" {CHECKED} />';
            var CheckBoxLbl = '<label for="{SEPCHKBOXID}" class="AdvListLbl">{LABELCONTENT}</label>';
            $.grep(List, function (a) {
                var ChkId = "ChkAdvTest_" + AdviceId + "_" + a.TESTCODE;
                var DivId = "Div" + ChkId;
                var RplCheckBox = CheckBox.replace("{SEPCHKBOXID}", ChkId).replace("{CHECKED}", (CheckedFlag == true ? "checked" : ""));
                var RplCheckBoxLbl = CheckBoxLbl.replace("{SEPCHKBOXID}", ChkId).replace("{LABELCONTENT}", a.TESTNAME);
                var RplSepDiv = SepDiv.replace("{SEPDIVID}", DivId).replace("{DIVCONTENT}", (RplCheckBox + RplCheckBoxLbl));
                $("#AdviceTestListOption").append(RplSepDiv);
                if (CheckedFlag) {
                    AdviceListColorChange(ChkId);
                }
            });
        }

        //Advice List Color Change
        function AdviceListColorChange(ChkId) {
            var DivId = "Div" + ChkId;
            if ($("#" + ChkId).prop("checked") == true) {
                document.getElementById(DivId).style.backgroundColor = "rgb(92, 184, 92)";
                document.getElementById(DivId).style.border = "1px solid #4aa34a";
                document.getElementById(DivId).style.color = "white";
            }
            else {
                if (ChkId.includes("ChkAdv_")) {
                    document.getElementById(DivId).style.backgroundColor = "#d1d1d1";
                    document.getElementById(DivId).style.border = "1px solid grey";
                    document.getElementById(DivId).style.color = "black";
                }
                else {
                    var SpltId = ChkId.split('_');
                    var DivId = "DivChkAdvTest_" + SpltId[1] + "_" + SpltId[2];
                    if (document.getElementById(DivId)) {
                        document.getElementById(DivId).remove();
                    }
                }
            }
        }

        //Add or Update Advice and Test List
        function AddUpdateInvstAdviceandTestList(Id) {
            var SplitCode = Id.split("_");
            var CheckYN = $("#" + Id).prop("checked") == true ? "Y" : "N";
            if (Id.includes("ChkAdvTest_")) {
                var Code = SplitCode[2];
                $.grep(AllPACTestAdviceList, function (a) {
                    if (a.CODE == Code) {
                        a.CHECKED = CheckYN;
                        AddRemTestFromInvstList(a.TESTCODE, CheckYN);
                    }
                });
            }
            else {
                var Code = SplitCode[1];
                var FilterLst = AllPACTestAdviceList.filter(function (a) { return a.SETUPCODE === Code; });
                if (FilterLst.length == 0) {
                    GetTestListForAdvice(Code);
                    $.grep(AllPACTestAdviceList, function (a) {
                        if (a.SETUPCODE == Code) {
                            a.CHECKED = "Y";
                            GetResultEntryList(a.TESTCODE);
                        }
                    });
                }
                else {
                    var AdvCode = FilterLst[0].SETUPCODE;
                    $.grep(AllPACTestAdviceList, function (a) {
                        if (a.SETUPCODE == AdvCode) {
                            a.CHECKED = CheckYN;
                            var ChkId = "ChkAdvTest_" + AdvCode + "_" + a.CODE;
                            var DivId = "Div" + ChkId;
                            if (CheckYN == "N") {
                                let element = document.getElementById(DivId);
                                if (element) {
                                    element.remove();
                                }
                            }
                            else {
                                var AppendL = [];
                                AppendL.push(a);
                                BindTestListForAdvice(AppendL, AdvCode, true);
                            }
                            AddRemTestFromInvstList(a.TESTCODE, CheckYN);
                        }
                    });
                }
                $.grep(AllPACAdviceList, function (a) {
                    if (a.CODE == Code) {
                        a.CHECKED = CheckYN;
                    }
                });
            }
        }

        //Bind Test Code and Name For Invst From Setup Change
        function AddRemTestFromInvstList(TCode, AddYN) {
            var TList = [];
            if (AddYN == "N") {
                TList = AllResultInvstList.filter(function (a) { return a.TESTCODE != TCode; });
                AllResultInvstList = TList;
            }
            else {
                GetResultEntryList(TCode);
            }
        }

        //Validation For Open Result Popup
        function ValidationForResultPopup() {
            if (AllPACTestAdviceList.length == 0) {
                ToastMsg("No Data Found", 'Information');
                return false;
            }
            var FilterData = AllPACTestAdviceList.filter(function (a) { return a.CHECKED == "Y"; });
            if (FilterData.length == 0) {
                ToastMsg("select the Advice Test", 'Information');
                return false;
            }
            return true;
        }

        //Open Result Entry Popup
        function OpenResultEntryPopup() {
            $("#tblResultInvstListBody").empty();
            if (ValidationForResultPopup() == true && AllPACTestAdviceList.length > 0) {
                if (AllResultInvstList.length == 0 && Gaction != "D") {
                    $.grep(AllPACTestAdviceList, function (a) {
                        GetResultEntryList(a.TESTCODE);
                    });
                }
                if (AllResultInvstList.length > 0) {
                    document.getElementById("ReventModal").style.display = "flex";
                    document.documentElement.style.overflow = 'hidden';
                    if (MultiResultEntry == "Y")
                        BindMultiResultyEntryList(AllResultInvstList);
                    else
                        BindResultEntryList(AllResultInvstList);
                    document.getElementById("ReventModal").style.display = "flex";
                    document.documentElement.style.overflow = 'hidden';
                }
                else {
                    ToastMsg("No Result Entry Data Found.", 'Information');
                }
            }
        }

        //Get Result Entry
        function GetResultEntryList(Code) {
            var TestList = Code.split(',');
            var DataToSend = {
                TestCode: JSON.stringify(
                    TestList.map(function (item) {
                        return { TESTCODE: item.trim() };
                    })
                )
            };
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetInvestList",
                data: DataToSend,
                async: false,
                success: function (response) {
                    if (response != "" && response != "UNSUCCESSFULL") {
                        AllResultInvstList = AllResultInvstList.concat(response);
                    }
                    else {
                        $.grep(TestList, function (a) {
                            var Filt = AllPACTestAdviceList.filter(function (f) { return f.CHECKED == "Y" && f.TESTCODE == a; });
                            if (Filt.length > 0) {
                                var Data = {
                                    INVDATE: "",
                                    TESTCODE: Filt[0].TESTCODE,
                                    INVSETCODE: "",
                                    INVSETDESC: Filt[0].TESTNAME,
                                    RESULTTYPE: "",
                                    SEQNO: "",
                                    RESULTDT: "",
                                    INRESULTDT: ""
                                };
                                AllResultInvstList.push(Data);
                            }
                        });
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                },
                complete: function () {
                }
            });
        }

        //Bind Result Entry - Single Result Entry
        function BindResultEntryList(List) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td class='{TDCLASS}' {TDCOLSPAN} {STYLE}>{TDCONTENT}</td>";
            var InputField = "<input type='text' id='{INPUTID}' class='form-control' {READONLY} />";
            var DatePicker = "<input type='text' id='{INPUTID}' class='form-control ResultDate' readonly {DISABLED} />";
            var InhouseFlag = List.filter(function (a) { return a.INRESULTDT != ""; });
            var TestCodeList = [];
            var TestNameList = [];
            $.grep(AllPACTestAdviceList, function (a) {
                if (a.CHECKED == "Y") {
                    TestCodeList.push(a.TESTCODE);
                    TestNameList.push(a.TESTNAME);
                }
            });
            for (var i = 0 ; i < TestCodeList.length; i++) {
                var RplTestTd = Td.replace("{TDCLASS}", 'TestTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", TestNameList[i]);
                var RplInhouseDT = DatePicker.replace("{INPUTID}", ('txt_IN_' + TestCodeList[i])).replace("{DISABLED}", "disabled");
                var RplInhouseDTTd = Td.replace("{TDCLASS}", 'TestTd TestDateINTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", RplInhouseDT);
                var OutDateDisabled = Gaction == "D" || Gaction == "V" ? "disabled" : List.filter(function (a) { return a.TESTCODE == TestCodeList[i] && a.RESULTDT.trim() != ""; }).length > 0 ? "disabled" : "";
                var RplOutSideDT = DatePicker.replace("{INPUTID}", ('txt_OT_' + TestCodeList[i])).replace("{DISABLED}", Gaction == "N" ? "" : OutDateDisabled);
                var RplOutSideDTTd = Td.replace("{TDCLASS}", 'TestTd TestDateOTTd').replace("{TDCOLSPAN}", "3").replace("{STYLE}", "").replace("{TDCONTENT}", RplOutSideDT);
                var RplTestTr = Tr.replace("{TRCONTENT}", (RplTestTd + RplInhouseDTTd + RplOutSideDTTd));
                var RplFinalTR = Tr.replace("{TRCONTENT}", (RplTestTr));
                $("#tblResultInvstListBody").append(RplFinalTR);
                var FilterTestWise = List.filter(function (a) { return a.TESTCODE == TestCodeList[i]; });
                if (FilterTestWise.length > 0) {
                    var FilterGetINDate = FilterTestWise.filter(function (a) { return a.INVDATE != ""; });
                    var FilterGetOUTDate = FilterTestWise.filter(function (a) { return a.INVINHOUSEDATE != ""; });
                    if (FilterGetINDate.length > 0) {
                        $("#" + ('txt_OT_' + TestCodeList[i])).val(FilterGetINDate[0].INVDATE);
                    }
                    if (FilterGetOUTDate.length > 0) {
                        $("#" + ('txt_IN_' + TestCodeList[i])).val(FilterGetOUTDate[0].INVINHOUSEDATE);
                    }
                    $.grep(FilterTestWise, function (a) {
                        if (a.RESULTTYPE == "H") {
                            var RplInvstHeaderTd = Td.replace("{TDCLASS}", 'InvstHeaderTd').replace("{TDCOLSPAN}", "colspan='5'").replace("{STYLE}", "").replace("{TDCONTENT}", a.INVSETDESC);
                            var RplInvstHeaderTr = Tr.replace("{TRCONTENT}", RplInvstHeaderTd);
                            var RplFinalTR = Tr.replace("{TRCONTENT}", (RplInvstHeaderTr));
                            $("#tblResultInvstListBody").append(RplFinalTR);
                        }
                        else {
                            var OutSideValudeReadOnly = Gaction == "D" || Gaction == "V" ? "readonly" : (BckAllResultInvstList.filter(function (a) { return a.TESTCODE == TestCodeList[i] && a.RESULTDT.trim() != ""; }).length > 0 ? "readonly" : "");
                            var RplInvstNameTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", a.INVSETDESC);
                            var RplInvstInhouse = InputField.replace("{INPUTID}", ("Txt_I_" + TestCodeList[i] + "_" + a.INVSETCODE)).replace("{READONLY}", "readonly");
                            var RplInvstInhouseTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", (InhouseFlag.length == 0 ? "style='display:none'" : "")).replace("{TDCONTENT}", RplInvstInhouse);
                            var RplInvstOutside = InputField.replace("{INPUTID}", ("Txt_O_" + TestCodeList[i] + "_" + a.INVSETCODE)).replace("{READONLY}", OutSideValudeReadOnly);
                            var RplInvstOutsideTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", RplInvstOutside);
                            var RplInvstCode = InputField.replace("{INPUTID}", ("Txt_" + TestCodeList[i] + "_" + a.INVSETCODE)).replace("{READONLY}", "");
                            var RplInvstCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", RplInvstCode);
                            var RplTestCode = InputField.replace("{INPUTID}", ("Txt_" + TestCodeList[i])).replace("{READONLY}", "");
                            var RplTestCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", RplTestCode);
                            var RplInvstFieldTr = Tr.replace("{TRCONTENT}", (RplInvstNameTd + RplInvstInhouseTd + RplInvstOutsideTd + RplInvstCodeTd + RplTestCodeTd));
                            var RplFinalTR = Tr.replace("{TRCONTENT}", (RplInvstFieldTr));
                            $("#tblResultInvstListBody").append(RplFinalTR);
                            if (a.INRESULTDT != "") {
                                $("#" + CSS.escape("Txt_I_" + TestCodeList[i] + "_" + a.INVSETCODE)).val(a.INRESULTDT);
                            }
                            if (a.RESULTDT != "") {
                                $("#" + CSS.escape("Txt_O_" + TestCodeList[i] + "_" + a.INVSETCODE)).val(a.RESULTDT);
                            }
                        }
                    });
                }
                else {
                    var RplInvstNameTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", TestNameList[i]);
                    var RplInvstInhouse = InputField.replace("{INPUTID}", ("Txt_I_" + TestCodeList[i])).replace("{READONLY}", "readonly");
                    var RplInvstInhouseTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", (InhouseFlag.length == 0 ? "style='display:none'" : "")).replace("{TDCONTENT}", RplInvstInhouse);
                    var RplInvstOutside = InputField.replace("{INPUTID}", ("Txt_O_" + TestCodeList[i])).replace("{READONLY}", (Gaction == "D" || Gaction == "V" ? "readonly" : ""));
                    var RplInvstOutsideTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", RplInvstOutside);
                    var RplInvstCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", "");
                    var RplTestCode = InputField.replace("{INPUTID}", ("Txt_" + TestCodeList[i])).replace("{READONLY}", "");
                    var RplTestCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", RplTestCode);
                    var RplInvstFieldTr = Tr.replace("{TRCONTENT}", (RplInvstNameTd + RplInvstInhouseTd + RplInvstOutsideTd + RplInvstCodeTd + RplTestCodeTd));
                    var RplFinalTR = Tr.replace("{TRCONTENT}", (RplInvstFieldTr));
                    $("#tblResultInvstListBody").append(RplFinalTR);
                    var TestADD = {
                        INVDATE: List[0].INVDATE,
                        INVINHOUSEDATE: "",
                        TESTCODE: TestCodeList[i],
                        INVSETCODE: "",
                        INVSETDESC: TestNameList[i],
                        RESULTTYPE: "V",
                        SEQNO: AllResultInvstList.length,
                        RESULTDT: "",
                        INRESULTDT: "",
                    }
                    AllResultInvstList.push(TestADD);
                }
            }
            if (InhouseFlag.length == 0) {
                document.getElementById("thInhouse").style.display = "none";
                document.querySelectorAll('.TestDateINTd').forEach(function (el) {
                    el.style.display = 'none';
                });
            }
            $(".ResultDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
            });
        }

        //Bind Result Entry - Multiple Result Entry
        function BindMultiResultyEntryList(List) {
            var Tr = "<tr id='{ROWID}'>{TRCONTENT}</tr>";
            var Td = "<td class='{TDCLASS}' {TDCOLSPAN} {STYLE}>{TDCONTENT}</td>";
            var InputField = "<input type='text' id='{INPUTID}' class='form-control ResultVal' {READONLY} />";
            var DatePicker = "<input type='text' id='{INPUTID}' class='form-control ResultDate' readonly {DISABLED} {VALUE} />";
            $("#tblResultInvstList").empty();
            var TestUniqueList = Object.values(
                List.reduce(function (acc, item) {
                    if (!acc[item.TESTCODE]) {
                        var TestNM = "";
                        $.grep(AllPACTestAdviceList, function (a) {
                            if (a.CHECKED == "Y" && item.TESTCODE == a.TESTCODE) {
                                TestNM = a.TESTNAME;
                            }
                        });
                        item.TESTNAME = TestNM;
                        acc[item.TESTCODE] = item;
                    }
                    return acc;
                }, {})
            );
            var MaxTd = GetMaxTd();
            var PlusIcon = "";
            var DelIcon = "";
            var THead = "<thead><tr><th class='TestCodeTd'>Test Code</th><th class='InvstCodeTd'>Invest Code</th><th class='TestNameTd'>Name</th><th id='theadResult' colspan='" + MaxTd + "'>Result</th></tr></thead>";
            var TBody = "<tbody id='tblResultInvstListBody'></tbody>";
            $("#tblResultInvstList").append(THead + TBody);
            $.grep(TestUniqueList, function (a) {
                var TestFilterData = List.filter(function (c) { return c.TESTCODE == a.TESTCODE; });
                var TestNM = a.TESTNAME;
                if (a.TESTNAME == "") {
                    var FilterBck = BckAllResultInvstList.filter(function (c) { return c.TESTCODE == a.TESTCODE; });
                    if (FilterBck.length > 0) {
                        TestNM = FilterBck[0].TESTNAME;
                    }
                }
                var RplTestTd = Td.replace("{TDCLASS}", 'TestTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='width:200px !important'").replace("{TDCONTENT}", TestNM);
                //var OutDateDisabled = Gaction == "D" || Gaction == "V" ? "disabled" : List.filter(function (S) { return S.TESTCODE == a.TESTCODE && a.RESULTDT.trim() != ""; }).length > 0 ? "disabled" : "";
                var OutDateDisabled = "";

                var TestDateTd = "";
                var TestUniqueDate = Object.keys(
                    TestFilterData.reduce(function (acc, item) {
                        if (item.INVDATE && item.INVDATE.trim() !== "") {
                            acc[item.INVDATE] = true;
                        }
                        if (item.INVINHOUSEDATE && item.INVINHOUSEDATE.trim() !== "") {
                            acc[item.INVINHOUSEDATE] = true;
                        }
                        return acc;
                    }, {})
                );
                TestUniqueDate.sort(function (a, b) {
                    return new Date(b) - new Date(a);
                });
                if (TestUniqueDate.length == 0) {
                    var AddIcon = "<i class='fa fa-plus AddInvstNew' aria-hidden='true' style='display:inline-block;" + (OutDateDisabled == "" ? "" : "pointer-events: none;") + "' onclick=\"ValidateInvestigationValues('" + a.TESTCODE + "')\"></i>";
                    var DelIcon = "<i class='fa fa-trash DelInvst' aria-hidden='true' style='display:none;" + (OutDateDisabled == "" ? "" : "pointer-events: none;") + "' onclick=\"DeleteTd('" + a.TESTCODE + "')\"></i>";
                    var RplTestDate = DatePicker.replace("{INPUTID}", ('txt_' + a.TESTCODE + "_1")).replace("{VALUE}", "").replace("{DISABLED}", Gaction == "N" ? "" : OutDateDisabled);
                    var RplTestDateTd = Td.replace("{TDCLASS}", 'TestTd TestDateTd HeadTestDateTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", (RplTestDate + AddIcon + DelIcon));
                    TestDateTd = TestDateTd + RplTestDateTd;
                }
                else {
                    for (var i = 1; i <= MaxTd; i++) {
                        if (TestUniqueDate[i - 1]) {
                            var AddIcon = "<i class='fa fa-plus AddInvstNew' id=ADD_TESTDATE'" + (a.TESTCODE + "_" + i) + "' aria-hidden='true' style='display:" + (TestUniqueDate.length == i ? "inline-block;" : "none;") + (OutDateDisabled == "" ? "" : "pointer-events: none;") + "' onclick=\"ValidateInvestigationValues('" + a.TESTCODE + "')\"></i>";
                            var DelIcon = "<i class='fa fa-trash DelInvst' id=DEL_TESTDATE'" + (a.TESTCODE + "_" + i) + "' aria-hidden='true' style='display:" + (i == 1 ? "none;" : "inline-block;") + (OutDateDisabled == "" ? "" : "pointer-events: none;") + "' onclick=\"DeleteTd('" + a.TESTCODE + "')\"></i>";
                            var RplTestDate = DatePicker.replace("{INPUTID}", ('txt_' + a.TESTCODE + "_" + i)).replace("{VALUE}", ("Value='" + TestUniqueDate[i - 1] + "'")).replace("{DISABLED}", Gaction == "N" ? "" : OutDateDisabled);
                            var RplTestDateTd = Td.replace("{TDCLASS}", 'TestTd TestDateTd HeadTestDateTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", (RplTestDate + AddIcon + DelIcon));
                            TestDateTd = TestDateTd + RplTestDateTd;
                        }
                        else if (i == 1) {
                            var RplTestDateTd = Td.replace("{TDCLASS}", 'TestTd TestDateTd HeadTestDateTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", "");
                            TestDateTd = TestDateTd + RplTestDateTd;
                        }
                    }
                }
                var RplTestCodeTD = Td.replace("{TDCLASS}", 'TestTd TestCodeTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", a.TESTCODE);
                var RplInvestCodeTD = Td.replace("{TDCLASS}", 'TestTd InvstCodeTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", "");
                var RowId = "TEST_" + a.TESTCODE + "_" + a.TESTCODE;
                var RplFinalTR = Tr.replace("{ROWID}", RowId).replace("{TRCONTENT}", (RplTestCodeTD + RplInvestCodeTD + RplTestTd + TestDateTd));
                $("#tblResultInvstListBody").append(RplFinalTR);


                //Investigation Binding
                var uniqueTestFilterData = [];
                var uniqueKeys = {};
                $.each(TestFilterData, function (index, item) {
                    var key = item.TESTCODE + "_" + (item.INVSETCODE || item.TESTCODE);
                    if (!uniqueKeys[key]) {
                        uniqueKeys[key] = true;
                        uniqueTestFilterData.push(item);
                    }
                });
                $.grep(uniqueTestFilterData, function (I) {
                    var OtherTD = "";
                    var InvstCD = I.INVSETCODE == "" ? I.TESTCODE : I.INVSETCODE
                    var RowId = I.TESTCODE + "_" + InvstCD;
                    var HeaderFlag = I.RESULTTYPE == "H" ? true : false;
                    var RplTestCodeTD = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", I.TESTCODE);
                    var RplInvestCodeTD = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", InvstCD);
                    var RplInvstNameTd = Td.replace("{TDCLASS}", (HeaderFlag == true ? 'InvstHeaderTd' : 'InvstFieldTd')).replace("{TDCOLSPAN}", (HeaderFlag == true ? ("colspan='" + (MaxTd + 1) + "'") : "")).replace("{STYLE}", "").replace("{TDCONTENT}", I.INVSETDESC);
                    var RplFinalTR = Tr.replace("{ROWID}", RowId).replace("{TRCONTENT}", (RplTestCodeTD + RplInvestCodeTD + RplInvstNameTd));
                    $("#tblResultInvstListBody").append(RplFinalTR);
                });

                //Investigation Field Binding
                for (var i = 1; i <= MaxTd; i++) {
                    if (TestUniqueDate[i - 1]) {
                        var FilterDateWise = TestFilterData.filter(function (c) { return c.INVDATE == TestUniqueDate[i - 1] || c.INVINHOUSEDATE == TestUniqueDate[i - 1]; });
                        if (FilterDateWise.length != TestFilterData.length) {
                            var DifferenceLst = TestFilterData.filter(function (c) { return c.INVDATE == "" && c.INVINHOUSEDATE == "" && c.INVDATE != TestUniqueDate[i - 1] && c.INVINHOUSEDATE != TestUniqueDate[i - 1] && c.RESULTTYPE != "H"; });
                            $.grep(DifferenceLst, function (I) {
                                I.INVDATE == I.INVDATE == "" ? TestUniqueDate[i - 1] : I.INVDATE;
                                I.INVINHOUSEDATE == I.INVINHOUSEDATE == "" ? TestUniqueDate[i - 1] : I.INVINHOUSEDATE;
                                FilterDateWise.push(I);
                            });
                        }
                        var filteredUnique = [];
                        var seen = {};
                        for (var j = 0; j < FilterDateWise.length; j++) {
                            var item = FilterDateWise[j];
                            var key = item.TESTCODE + "_" + item.INVSETCODE;
                            if (seen[key]) {
                                if (item.INVINHOUSEDATE && item.INVINHOUSEDATE.trim() != "") {
                                    for (var k = 0; k < filteredUnique.length; k++) {
                                        var prev = filteredUnique[k];
                                        if (prev.TESTCODE + "_" + prev.INVSETCODE == key) {
                                            filteredUnique[k] = item;
                                            break;
                                        }
                                    }
                                }
                            } else {
                                filteredUnique.push(item);
                                seen[key] = true;
                            }
                        }
                        $.grep(filteredUnique, function (I) {
                            if (I.RESULTTYPE != "H") {
                                var Val = I.RESULTDT == "" ? I.INRESULTDT : I.RESULTDT;
                                var InvstCD = I.INVSETCODE == "" ? I.TESTCODE : I.INVSETCODE;
                                var Id = "Txt_" + I.TESTCODE + "_" + InvstCD + "_" + i;
                                var RplInvstVal = InputField.replace("{INPUTID}", Id).replace("{READONLY}", OutDateDisabled);
                                var RplInvstValTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", RplInvstVal);
                                $(("#" + I.TESTCODE + "_" + InvstCD)).append(RplInvstValTd);
                                $("#" + Id).val(Val);
                                if (I.INVINHOUSEDATE != "") {
                                    $("#" + Id).closest("td").css("background-color", "rgb(225 239 255)");
                                    $("#" + Id).addClass("RemoveTextBoxStyle");
                                }

                            }
                        });
                    }
                    else if (i == 1) {
                        var FilterWithoutHeader = uniqueTestFilterData.filter(function (c) { return c.RESULTTYPE != "H"; });
                        $.grep(FilterWithoutHeader, function (I) {
                            if (I.RESULTTYPE != "H") {
                                var InvstCD = I.INVSETCODE == "" ? I.TESTCODE : I.INVSETCODE;
                                var RplInvstVal = InputField.replace("{INPUTID}", ("Txt_" + I.TESTCODE + "_" + InvstCD + "_" + i)).replace("{READONLY}", OutDateDisabled);
                                var RplInvstValTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", RplInvstVal);
                                $(("#" + I.TESTCODE + "_" + InvstCD)).append(RplInvstValTd);
                            }
                        });
                    }
                }
            });
            $(".ResultDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
            });
            $(".ResultDate").on("change", function () {
                var selectedDate = $(this).val().trim();
                var row = $(this).closest("tr");
                var allDates = [];
                row.find(".ResultDate").each(function () {
                    var v = $(this).val().trim();
                    if (v !== "") {
                        allDates.push(v);
                    }
                });
                var duplicates = allDates.filter(function (d) {
                    return d === selectedDate;
                }).length;
                if (duplicates > 1) {
                    alert("This date is already selected. Please choose a different date.");
                    $(this).val("");
                    return false;
                }
            });
            if(Gaction == "D" || Gaction == "V"){
                $("#BtnUpdateInvst").hide();
            }
            else {
                $("#BtnUpdateInvst").show();
            }
            
        }

        function GetMaxTd() {
            var datesByTest = {};
            var finalResult = {};
            AllResultInvstList.forEach(function (item) {
                var test = item.TESTCODE;
                var date = item.INVDATE == "" ? item.INVINHOUSEDATE : item.INVDATE;
                if (!date) return;

                if (!datesByTest[test]) {
                    datesByTest[test] = new Set();
                }
                datesByTest[test].add(date);
            });
            Object.keys(datesByTest).forEach(function (test) {
                var datesArray = Array.from(datesByTest[test]);
                finalResult[test] = {
                    dates: datesArray,
                    count: datesArray.length
                };
            });
            var maxCount = 1;
            Object.keys(finalResult).forEach(function (test) {
                var count = finalResult[test].count;
                if (count > maxCount) {
                    maxCount = count;
                }
            });
            return maxCount;
        }

        // Add new date column for a given TestId
        function AddNewTd(TestId) {
            var testRows = $("#tblResultInvstListBody tr").filter(function () {
                return $(this).attr('id').startsWith("TEST_" + TestId) || $(this).attr('id').startsWith(TestId + "_");
            });
            var headerRow = $("#TEST_" + TestId + "_" + TestId);
            var existingIds = headerRow.find("input.ResultDate").map(function () {
                return parseInt($(this).attr('id').split('_')[2]);
            }).get();
            var newIndex = 1;
            if (existingIds.length > 0) {
                newIndex = Math.max.apply(null, existingIds) + 1;
            }
            testRows.each(function () {
                if ($(this).attr('id').startsWith("TEST_")) {
                    var newTd = '<td class="TestTd TestDateTd HeadTestDateTd">' +
                                    '<input type="text" id="txt_' + TestId + '_' + newIndex + '" class="form-control ResultDate" readonly>' +
                                    '<i class="fa fa-plus AddInvstNew" aria-hidden="true" onclick="ValidateInvestigationValues(\'' + TestId + '\')"></i>' +
                                    '<i class="fa fa-trash DelInvst" aria-hidden="true" onclick="DeleteTd(\'' + TestId + '\', this)"></i>' +
                                '</td>';
                    $(this).append(newTd);
                } else {
                    var isHeader = $(this).find("td.InvstHeaderTd").length > 0;
                    if (isHeader) {
                        var headerTd = $(this).find("td.InvstHeaderTd");
                        var currentColspan = parseInt(headerTd.attr("colspan")) || 1;
                        headerTd.attr("colspan", currentColspan + 1);
                    } else {
                        var newTd = '<td class="InvstFieldTd">' +
                                        '<input type="text" id="Txt_' + $(this).attr('id') + '_' + newIndex + '" class="form-control ResultVal">' +
                                    '</td>';
                        $(this).append(newTd);
                    }
                }
            });

            $(".ResultDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "c-150:c+99",
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            });
            $(".ResultDate").on("change", function () {
                var selectedDate = $(this).val().trim();
                var row = $(this).closest("tr");
                var allDates = [];
                row.find(".ResultDate").each(function () {
                    var v = $(this).val().trim();
                    if (v !== "") {
                        allDates.push(v);
                    }
                });
                var duplicates = allDates.filter(function (d) {
                    return d === selectedDate;
                }).length;
                if (duplicates > 1) {
                    alert("This date is already selected. Please choose a different date.");
                    $(this).val("");
                    return false;
                }
            });
            updateIcons(TestId);
        }

        function ValidateInvestigationValues(TestCode) {
            var icon = event.target;
            var colInput = $(icon).siblings("input");
            if (colInput.length === 0) {
                AddNewTd(TestCode);
                return;
            }
            var colId = colInput.attr("id");
            var ColNo = colId.split("_")[2];
            var isValid = true;
            $(".ResultVal").each(function () {
                var id = $(this).attr("id");
                if (id.indexOf(TestCode + "_") > -1 &&
                    id.endsWith("_" + ColNo)) {

                    if ($(this).val().trim() === "") {
                        isValid = false;
                    }
                }
            });
            if (!isValid) {
                alert("Please fill all investigation values before adding a new date.");
            }
            else {
                AddNewTd(TestCode);
            }
        }

        // Delete a date column for a given TestId
        function DeleteTd(TestId, clickedIcon) {
            if (!clickedIcon) return;

            let testRows = $("#tblResultInvstListBody tr").filter(function () {
                return $(this).attr('id').startsWith("TEST_" + TestId) || $(this).attr('id').startsWith(TestId + "_");
            });

            let tdIndex = $(clickedIcon).closest('td').index();

            testRows.each(function () {
                $(this).find('td').eq(tdIndex).remove();
            });

            updateIcons(TestId);
        }

        // Show/hide Add/Delete icons and update thead colspan
        function updateIcons(TestId) {
            let headerRow = $("#TEST_" + TestId + "_" + TestId);
            let dateTds = headerRow.find("td.TestDateTd");

            dateTds.find(".AddInvstNew").hide();
            dateTds.find(".DelInvst").hide();

            if (dateTds.length > 0) {
                dateTds.last().find(".AddInvstNew").show();
            }

            if (dateTds.length > 1) {
                dateTds.slice(1).find(".DelInvst").show();
            }
            UpdateHeaderColSpan();
        }

        function UpdateHeaderColSpan() {
            var table = document.getElementById('tblResultInvstList');
            var maxColumns = 1;
            if (table) {
                for (var i = 0; i < table.rows.length; i++) {
                    var row = table.rows[i];
                    var colCount = 0;
                    for (var j = 0; j < row.cells.length; j++) {
                        var colspan = row.cells[j].colSpan || 1;
                        colCount += colspan;
                    }

                    if (colCount > maxColumns) {
                        maxColumns = colCount;
                    }
                }
            }
            $("#theadResult").attr("colspan", maxColumns);
        }

        //Validation For Update Result Entry Details
        function ValidationForResultEntryDtls() {
            if (MultiResultEntry == "Y")
                return true;
            else
                return true;
        }

        //Update the Result Entry Details
        function UpdateResultList() {
            if (MultiResultEntry == "Y")
                UpdateMultiEntryResultList();
            else
                UpdateSingleEntryResultList();
        }

        //Update For Single Entry
        function UpdateSingleEntryResultList() {
            if (ValidationForResultEntryDtls() == true) {
                $.grep(AllResultInvstList, function (a) {
                    a.INVDATE = $("#" + ('txt_OT_' + a.TESTCODE)).val();
                    if (a.RESULTTYPE == "H") {
                        a.RESULTDT = "";
                    }
                    else {
                        var Id = "Txt_O_" + a.TESTCODE + "_" + a.INVSETCODE;
                        var InputField = document.getElementById(Id);
                        if (InputField != null) {
                            a.RESULTDT = $("#" + CSS.escape(Id)).val();
                        }
                        else {
                            Id = "Txt_O_" + a.TESTCODE;
                            InputField = document.getElementById(Id);
                            if (InputField != null) {
                                a.RESULTDT = $("#" + CSS.escape(Id)).val();
                            }
                            else {
                                a.RESULTDT = "";
                            }
                        }
                    }
                });
                document.getElementById("ReventModal").style.display = "none";
                document.documentElement.style.overflow = '';
            }
        }

        //Update For Multiple Entry
        function UpdateMultiEntryResultList() {
            if (ValidationForResultEntryDtls() == true) {
                var FinalResult = [];
                $("#tblResultInvstListBody tr[id^='TEST_']").each(function () {
                    var testRow = $(this);
                    var testIdParts = testRow.attr("id").split("_");
                    var TestCode = testIdParts[1];
                    var dateInputs = testRow.find("td.TestDateTd input.ResultDate");
                    $("#tblResultInvstListBody tr").filter(function () {
                        var rowId = $(this).attr("id");
                        return rowId.startsWith(TestCode + "_") && !rowId.startsWith("TEST_");
                    }).each(function () {
                        var childRow = $(this);
                        var InvSetCode = childRow.find("td.InvstFieldTd").eq(1).text();
                        childRow.find("td.InvstFieldTd input.ResultVal").each(function (index) {
                            var FilterRow = AllResultInvstList.filter(function (c) { return c.TESTCODE == TestCode && ((c.INVSETCODE == "" && c.TESTCODE == InvSetCode) || c.INVSETCODE == InvSetCode); });
                            var row = JSON.parse(JSON.stringify(FilterRow[0]));
                            row.INVSETCODE = InvSetCode;
                            row.INVDATE = dateInputs.eq(index).val() || "";
                            row.RESULTDT = $(this).val() || "";
                            FinalResult.push(row);
                        });
                    });
                });
                AllResultInvstList = FinalResult;
                document.getElementById("ReventModal").style.display = "none";
                document.documentElement.style.overflow = '';
            }
        }

        //Investigation Info Print For Single Entry
        function PrintInvestigationInfo(PrintData) {
            const parentDiv = document.getElementById("AdviceTestListOption");
            const childDivs = parentDiv.querySelectorAll("div");
            var FilterResult = [];
            var TData = JSON.parse(JSON.stringify(AllResultInvstList));
            $.grep(TData, function (a) {
                if (a.RESULTTYPE != "H") {
                    if (a.RESULTDT != "" || a.INRESULTDT != "") {
                        var TestNameList = AllPACTestAdviceList.filter(function (c) { return c.TESTCODE == a.TESTCODE; });
                        var TestName = "";
                        if (TestNameList.length > 0) {
                            TestName = TestNameList[0].TESTNAME;
                        }
                        a.TESTNAME = TestName;
                        FilterResult.push(a);
                    }
                }
            });
            PrintData.push({ name: 'InvstData', value: JSON.stringify(FilterResult) });
            return PrintData;
        }

        //Investigation Info Print For Multiple Entry
        function PrintMultiEntryInvestigation() {
            var PrintData = new Array();
            PrintData.push({ name: 'TranNo', value: $("#txtPAC").val() }, { name: 'Mrno', value: $("#txtPACMRNO").val() });
            HoldOn.open();
            $.ajax({
                url: '../DoctorDesk/PrintPACResult',
                data: PrintData,
                type: 'post',
                async: false,
                success: function (response) {
                    if (response.status === "Success") { //priyanka 03/04/2026
                        var win = window.open('../DoctorDesk/DisplayPrintPACResult', "_blank");
                        win.focus();
                    } else {
                        ToastMsg(response.message,"Info"); 
                    }
                    

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //$.messager.alert("Error", errorThrown);
                    ToastMsg(errorThrown, 'Error');

                },
                complete: function () {

                }
            });
        }
    </script>

    <%-- Speciality Reference Info --%>
    <script type="text/javascript">
        //Speciality Reference Info Load
        function SpecialityRefInfoLoad() {
            BindSpecialityRefInfoGaction();
        }
        //Speciality Reference Info Gaction
        function BindSpecialityRefInfoGaction() {
            GetCliniclist();
            if (Gaction == "N") {
                ClearSpecialityRefInfo();
                document.getElementById("btnAddRef").style.display = "inline-block";
            }
            else {
                document.getElementById("btnAddRef").style.display = "none";
                //priyanka 25/02/2026
                //if (sessionStorage.getItem("PACConsltNo") === sessionStorage.getItem("PACRefPACTranNo")) {
                //    BindSpecialityRefDtls();
                //}
                BindSpecialityRefDtls();
                
            }
        }
        //Get Specaility List
        function GetCliniclist() {
            $.ajax({
                url: '../DoctorDesk/GetClinic',
                type: 'post',
                datatype: 'json',
                data: {},
                async: false,
                success: function (data) {
                    SpecialityTypeList = [];
                    if (data.length > 0) {
                        var ind = 0;
                        $.grep(data, function (a) {
                            var Lst = {
                                CODE: a.ClinicCode,
                                TEXT: a.ClinicName,
                            }
                            SpecialityTypeList.push(Lst);
                        });
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
        //Clear Speciality Reference Info
        function ClearSpecialityRefInfo() {
            $("#txtSPCREF").val("");
            $("#SPCREFDown").trigger('click');
            autoResize('txtSPCREF');
            $("#SPCREFUp").trigger('click');
        }
        //Enable Disable of the Speciality Ref Textbox
        function EnDisableSpecRefTextbox(CmbId, TextId) {
            if ($("#" + CmbId).val() == "") {
                $("#" + TextId).val("");
                $("#" + TextId).prop("readonly", false);
            }
            else {
                var Flag = true;
                var Ind = CmbId.split('_')[1];
                var CurCmbValue = $("#" + CmbId).val();
                $.grep(SpecialityRefList, function (a) {
                    if (Flag == true && Ind != a.INDEX) {
                        var CmbId = "#cmbSpeciality_" + a.INDEX;
                        var TxtId = "#txtSpeciality_" + a.INDEX;
                        if (document.getElementById(CmbId) != null && $(CmbId).val().trim() == CurCmbValue) {
                            Flag = false;
                            ToastMsg("This Speciality Reference is already mentioned", 'Information');
                        }
                    }
                });
                if (Flag) {
                    $("#" + TextId).val($(("#" + CmbId + " option:selected")).text());
                    $("#" + TextId).prop("readonly", true);
                }
            }
        }
        //Validation For Reference Speciality Name
        function ValidateRefText(TextId) {
            var Ind = TextId.split('_')[1];
            if ($(("#" + TextId)).val() != "") {
                var Flag = true;
                var CurTxtValue = $("#" + TextId).val();
                $.grep(SpecialityRefList, function (a) {
                    if (Flag == true && Ind != a.INDEX) {
                        var TxtId = "#txtSpeciality_" + a.INDEX;
                        if ($(TxtId).val() != undefined && $(TxtId).val().trim() == CurTxtValue) {
                            Flag = false;
                            $("#" + TextId).val("");
                            ToastMsg("This Speciality Reference is already mentioned", 'Information');
                        }
                    }
                });
            }
        }
        //Validation For Add Speciality Referrence
        function ValidForAddSpecialityRef() {
            var Flag = true;
            $.grep(SpecialityRefList, function (a) {
                if (Flag) {
                    var CmbId = "#cmbSpeciality_" + a.INDEX;
                    var TxtId = "#txtSpeciality_" + a.INDEX;
                    var ContId = "#txtSPCREF_" + a.INDEX;
                    if ($(CmbId).val().trim() == "" && $(TxtId).val().trim() == "") {
                        Flag = false;
                        ToastMsg("Please Select or Enter Speciality Reference", 'Information');
                    }
                    if ($(ContId).val().trim() == "") {
                        Flag = false;
                        ToastMsg(("Please Enter Speciality Reference Content for " + $(TxtId).val().trim()), 'Information');
                        $(ContId).focus();
                    }
                }
            });
            return Flag;
        }
        //Add Specaility Referrence
        function AddRemSpecialityRef(Type, Id) {
            if (Type == "A") {
                if (ValidForAddSpecialityRef() == true) {
                    var Ind = SpecialityRefList.length == 0 ? 1 : (Number(SpecialityRefList[(SpecialityRefList.length - 1)].INDEX) + 1);
                    var NewRef = {
                        INDEX: Ind
                    }
                    SpecialityRefList.push(NewRef);
                    BindAddSpecialityRef(Ind, "", "", "", true, false);
                }
            }
            else {
                SpecialityRefList = SpecialityRefList.filter(function (A) { return A.INDEX != Id; });
                var RemoveId = "DivRef_" + Id;
                if (document.getElementById(RemoveId)) {
                    document.getElementById(RemoveId).remove();
                }
            }
        }
        //Bind Speciality Referrence
        function BindAddSpecialityRef(Ind, CmbValue, TextValue, Content, DelFlag, printFlag) {
            var MainDiv = "<div id='DivRef_" + Ind + "' class='col-12' style='padding: 0px 0px 0px 0px;'><div class='col-12' style=''><div class='ContentFieldDiv'><div class='col-12 FieldDiv' style='flex-wrap: nowrap;align-items: center;'>";
            var SelCombo = "<select class='form-control' id='cmbSpeciality_" + Ind + "' style='max-width: 20px;' onchange=\"EnDisableSpecRefTextbox(this.id,'txtSpeciality_" + Ind + "')\">{OPTIONS}</select>";
            var SpecNameTxt = "<input type='text' maxlength='50' class='form-control' id='txtSpeciality_" + Ind + "' placeholder='Speciality Name' onblur='ValidateRefText(this.id)' style='width:93.5%;'  />";
            var DelIcon = "<i class='fa fa-trash SpeciDelIcon' aria-hidden='true' onclick=\"AddRemSpecialityRef('R','" + Ind + "')\"></i>";
            var PrintIcon = "<i class='fa fa-print SpeciPrintIcon'  aria-hidden='true' onclick=\"PrintSpecRef('" + Ind + "')\"></i>";
            var MainCloseDiv = "</div></div></div><div class='col-12' style=''><div class='ContentFieldDiv'><div class='col-12 FieldDiv'>";
            var ContentTextarea = "<textarea class='form-control' maxlength='500' style='resize: none;' oninput='autoResize(this.id)' onchange='autoResize(this.id)' placeholder='' id='txtSPCREF_" + Ind + "'></textarea>"
            var FCloseDiv = "</div></div></div></div>";
            var Final = MainDiv + SelCombo + SpecNameTxt + (DelFlag == true ? DelIcon : "") + (printFlag == true ? PrintIcon : "") + MainCloseDiv + ContentTextarea + FCloseDiv;
            $("#SpecialityRefAddDiv").append(Final);
            var DOption = "<option value='{OPTVALUE}'>{OPTTEXT}</option>";
            var RplDefOption = DOption.replace("{OPTVALUE}", "").replace("{OPTTEXT}", "---Select---");
            var FlagPresent = false;
            $.grep(SpecialityTypeList, function (a) {
                var RplDOption = DOption.replace("{OPTVALUE}", a.CODE).replace("{OPTTEXT}", a.TEXT);
                RplDefOption = RplDefOption + RplDOption;
                if (CmbValue != "" && CmbValue == a.CODE)
                    FlagPresent = true;
            });
            if (!FlagPresent) {
                var RplDOption = DOption.replace("{OPTVALUE}", CmbValue).replace("{OPTTEXT}", TextValue);
                RplDefOption = RplDefOption + RplDOption;
            }
            $(("#cmbSpeciality_" + Ind)).append(RplDefOption);
            $(("#cmbSpeciality_" + Ind)).val(CmbValue);
            $(("#txtSpeciality_" + Ind)).val(TextValue);
            BindRefTemplate(("#txtSPCREF_" + Ind), Content);
        }
        //Bind Speciality Ref Template
        function BindRefTemplate(Id, Content) {
            //This is a case of {FIELDONE} who is awaiting for planned surgery/Radiotherapy/Chemotherapy {FIELDTWO} under anaesthesia, kindly do assess patient along with pulmonary status along with PFT/DLCO/VQ Scan and give your valuable clinical opinion.
            Content = Content == "" ? TemplateRef.replace("{FIELDONE}", ICDDiagnosis).replace("{FIELDTWO}", $("#txtPACProcdPlan").val()) : Content;
            $(Id).val(Content);
        }
        //Bind Speciality Ref Data For Save
        function BindRefDataForSave(Id) {
            var RefDtls = [];
            $.grep(SpecialityRefList, function (a) {
                if (Id == "" || (Id != "" && Id == a.INDEX)) {
                    var CmbId = "#cmbSpeciality_" + a.INDEX;
                    var TxtId = "#txtSpeciality_" + a.INDEX;
                    var ContId = "#txtSPCREF_" + a.INDEX;
                    var Lst = {
                        REFCODE: $(CmbId).val().trim(),
                        REFNAME: $(TxtId).val().trim(),
                        REFCONTENT: $(ContId).val().trim(),
                        REFDATE: $("#txtPACDate").val()
                    }
                    RefDtls.push(Lst);
                }
            });
            return JSON.stringify(RefDtls);
        }
        //Bind Speciality Reference Info
        function BindSpecialityRefDtls() {
            <%--  var SpecialityData = `<%=Model.SpecialityRefData %>`;--%>
            var SpecialityData =<%= Newtonsoft.Json.JsonConvert.SerializeObject(Model.SpecialityRefData ?? "") %>;
            SpecialityData = SpecialityData.replace(/\n/g, "\\n");
            SpecialityRefList = SpecialityData ? JSON.parse(SpecialityData) : [];
            SpecialityRefList = SpecialityRefList.filter(function (A) { return A.TRANNO == sessionStorage.getItem("PACConsltNo"); });
            var VisitRecordData =<%= Newtonsoft.Json.JsonConvert.SerializeObject(Model.VisitRecord ?? "") %>;
            <%--  var VisitRecordData =  '<%= System.Web.HttpUtility.JavaScriptStringEncode(Model.VisitRecord) %>';--%>
            var VisitRecordDataList = VisitRecordData ? JSON.parse(VisitRecordData) : [];
            VisitRecordDataList = VisitRecordDataList.filter(function (A) {
                return A.TRANNO == sessionStorage.getItem("PACConsltNo");
            });
            var spcRef = "";
            if (VisitRecordDataList.length > 0)
                spcRef = VisitRecordDataList[0].SPECIALITYREFERENCE;
            $("#txtSPCREF").val(spcRef.replace(/\\n/g, "\n"));
            $("#SPCREFDown").trigger('click');
            $.grep(SpecialityRefList, function (a) {
                BindAddSpecialityRef(a.INDEX, a.REFCODE, a.REFNAME, a.REFCONTENT, false, true);
                var CmbId = "cmbSpeciality_" + a.INDEX;
                var TxtId = "txtSpeciality_" + a.INDEX;
                if (a.REFCODE == "")
                    ValidateRefText(TxtId);
                else
                    EnDisableSpecRefTextbox(CmbId, TxtId);
                autoResize(('txtSPCREF_' + a.INDEX));
            });
            autoResize('txtSPCREF');
            $("#SPCREFUp").trigger('click');
        }
        //Validation For Speciality Reference Info
        function ValidationForSpecialityRefInfo() {
            if (ValidForAddSpecialityRef() == false) {
                return false;
            }
            return true;
        }
        //Speciality Reference Info Save Value Pass
        function SaveForSpecialityRefInfo(PostData) {
            PostData.push({ name: 'SpecialityReference', value: JSON.stringify($("#txtSPCREF").val().toString().trim()) });
            PostData.push({ name: 'SpecialityRefData', value: BindRefDataForSave("") });
            return PostData;
        }
        //Speciality Reference Info Print
        function PrintSpecialityRefInfo(PrintData, FlagYN) {
            PrintData.push({ name: 'SpecialityReference', value: JSON.stringify($("#txtSPCREF").val().toString().trim()) });
            if ($("#PrintSpecialityRef").prop("checked") || FlagYN == "Y")
                PrintData.push({ name: 'SpecialityRefData', value: BindRefDataForSave("") });
            return PrintData;
        }
    </script>

    <%-- ASA Info --%>
    <script type="text/javascript">
        //ASA Info Load
        function ASAInfoLoad() {
            $("#txtAPSDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
            });
            BindASAInfoGaction();
        }
        //ASA Info Gaction
        function BindASAInfoGaction() {
            if (Gaction == "N") {
                ClearASAInfo();
                document.getElementById("DivReviewPAC").style.display = "none";
            }
            else {
                BindASADtls();
                document.getElementById("DivReviewPAC").style.display = "block";
            }
        }
        //Update Current Date and Time
        function UpdateCurrDateTime() {
            if ($("#rbtnAPSFITSTSF").prop("checked") == true || $("#rbtnAPSFITSTSW").prop("checked") == true || $("#rbtnAPSFITSTSU").prop("checked") == true) {
                var now = new Date();
                var hours = now.getHours();
                var minutes = now.getMinutes();
                var CurrentTime = hours.toString().padStart(2, '0') + ':' + minutes.toString().padStart(2, '0') + ':' + now.getSeconds().toString().padStart(2, '0');
                $("#txtAPSDate").datepicker("setDate", new Date());
                $("#txtAPSTime").val(CurrentTime);
            }
            else {
                $("#txtAPSDate").val("");
                $("#txtAPSTime").val("");
            }
        }
        function EnDisAnesthesiaType() {
            var CheckVal = GetLastLetterCheckedRadio("APSFITSTS");
            if (CheckVal == "" || CheckVal == "U") {
                $("#MainDivAnaestPlan").hide();
                AllAnaesthesiaTypeList = [];
                AllMedListForSave = [];
                $("#AnaesthesiaListOption").empty();
                $("#TablePreopTBody").empty();
                $("#txtASPLANNotes").val("");
                $("#cmbAneasthesiaType").val("");
            } else {
                $("#MainDivAnaestPlan").show();
                if (sessionStorage.getItem("PACSTATUS") != "A") {
                    if (Gaction != "V")
                        $("#DivContentASPLAN *").removeAttr("disabled");
                }
                else {
                    $("#DivContentAPS *").attr("disabled", true);
                    $("#DivContentASPLAN *").attr("disabled", true);
                    $("#ChkPACReview").removeAttr("disabled");
                    if (Gaction == "E") {
                        $("#DivContentAPS *").removeAttr("disabled");
                        $("#DivContentASPLAN *").removeAttr("disabled");
                    }
                }
            }
        }
        //Clear ASA Info
        function ClearASAInfo() {
            UncheckRadioBtn('APSPHYSTS');
            UncheckRadioBtn('APSPHYSTSCHK');
            UncheckRadioBtn('APSFITSTS');
            $("#txtAPSDate").val("");
            $("#txtAPSTime").val("");
            $("#cmbASARisk").val("");//priyanka 19/11/2025
            $("#txtASARemark").val("");
            $("#APSDown").trigger('click');
            autoResize('txtASARemark');
            $("#APSUp").trigger('click');
            UpdateCurrDateTime(); // Abhishesh || 20260525
            EnDisAnesthesiaType();
        }
        //Bind ASA Info
        function BindASADtls() {
            var Phystatus = '<%=Model.ASAPhysicalStatus %>';
            var FitStatus = '<%=Model.ASAFitnessStatus %>';
            var ASARiskLvl = '<%=Model.ASARiskLevel %>'; //priyanka 19/11/2025
            var PhystatusE = '<%= Model.ASAPhysicalStatusEYN %>'//priyanka 21/03/2026
            if (PhystatusE == "Y")
                $("#rbtnAPSPHYSTSE").prop("checked", true);
            else
                $("#rbtnAPSPHYSTSE").prop("checked", false);

            if (Phystatus != "")
                $("#rbtnAPSPHYSTS" + Phystatus).prop("checked", true);
            if (FitStatus != "")
                $("#rbtnAPSFITSTS" + FitStatus).prop("checked", true);
            $("#txtAPSDate").val('<%=Model.ASADate %>');
            $("#txtAPSTime").val('<%=Model.ASATime %>');

            var ASARemark = '<%=HttpUtility.JavaScriptStringEncode(Model.ASARemarks) %>';
            $("#txtASARemark").val(ASARemark.replace(/\\n/g, "\n"));
            //priyanka 19/11/2025
            $("#cmbASARisk").val(ASARiskLvl);
            if ($("#rbtnAPSFITSTSW").prop("checked") === true) {
                $("#cmbASARisk").css('display', 'inline-block');
            }
            else {
                $("#cmbASARisk").css('display', 'none');
                $("#cmbASARisk").val("");
            }
            $("#APSDown").trigger('click');
            autoResize('txtASARemark');
            $("#APSUp").trigger('click');

        }
        //Validation For ASA Info
        function ValidationForASAScrInfo() {
            if (Gaction == "V") {
                if (GetLastLetterCheckedRadio('APSFITSTS') == "") {
                    FocusRadioOpt("rbtnAPSFITSTSF", "Please Select Fitness Status");
                    return false;
                }
            }
            if (GetLastLetterCheckedRadio('APSFITSTS') == "W") {//Priyanka 19/11/2025
                if ($("#cmbASARisk").val() === "") {
                    FocusRadioOpt("cmbASARisk", "Please Select Risk Level");
                    return false;
                }
            }//end
            return true;
        }
        //ASA Info Save Value Pas
        function SaveForASAInfo(PostData) {
            PostData.push({ name: 'ASAPhysicalStatus', value: GetLastLetterCheckedRadio('APSPHYSTS') });
            PostData.push({ name: 'ASAPhysicalStatusE', value: $("#rbtnAPSPHYSTSE").prop("checked") == true ? "Y" : "N" });//priyanka 21/03/2026
            PostData.push({ name: 'ASAFitnessStatus', value: GetLastLetterCheckedRadio('APSFITSTS') });
            PostData.push({ name: 'ASADate', value: $("#txtAPSDate").val() });
            PostData.push({ name: 'ASATime', value: $("#txtAPSTime").val() });
            PostData.push({ name: 'ASARiskLevel', value: $("#cmbASARisk").val() });//priyanka 19/11/2025
            PostData.push({ name: 'ASARemarks', value: $("#txtASARemark").val() });
            return PostData;
        }
        //Speciality Reference Info Print
        function PrintASAInfo(PrintData) {
            PrintData.push({ name: 'ASAPhysicalStatus', value: GetCheckRadioLabel('APSPHYSTS') });
            PrintData.push({ name: 'ASAFitnessStatus', value: GetCheckRadioLabel('APSFITSTS') });
            PrintData.push({ name: 'ASADate', value: $("#txtAPSDate").val() });
            PrintData.push({ name: 'ASATime', value: $("#txtAPSTime").val() });
            PrintData.push({ name: 'ASARemarks', value: $("#txtASARemark").val() });
            return PrintData;
        }
    </script>

    <%--Anaesthesiologist’s Advice & Preoperative Orders  Info --%>
    <script type="text/javascript">
        //Anaesthesiologist’s Advice & Preoperative Orders Info Load
        function AnaestAdvOrdInfoLoad() {
            BindAnaestAdvOrdInfoGaction();
        }
        //Anaesthesiologist’s Advice & Preoperative Orders Info Gaction
        function BindAnaestAdvOrdInfoGaction() {
            if (Gaction == "N") {
                ClearAnaestAdvOrdInfo();
            }
            else {
                //priyanka 25/02/2026
                //if (sessionStorage.getItem("PACConsltNo") === sessionStorage.getItem("PACRefPACTranNo")) {
                //    BindAnaestAdvOrdDtls();
                //}
                BindAnaestAdvOrdDtls();
                
            }
        }
        //Clear Anaesthesiologist’s Advice & Preoperative Orders Info
        function ClearAnaestAdvOrdInfo() {
            $("#txtAAPO").val("");
            $("#AAPODown").trigger('click');
            autoResize('txtAAPO');
            $("#AAPOUp").trigger('click')
        }
        //Bind Anaesthesiologist’s Advice & Preoperative Orders Info
        function BindAnaestAdvOrdDtls() {
            var VisitRecordData =<%= Newtonsoft.Json.JsonConvert.SerializeObject(Model.VisitRecord ?? "") %>;
            <%--  var VisitRecordData =  '<%= System.Web.HttpUtility.JavaScriptStringEncode(Model.VisitRecord) %>';--%>
            var VisitRecordDataList = VisitRecordData ? JSON.parse(VisitRecordData) : [];
            VisitRecordDataList = VisitRecordDataList.filter(function (A) { return A.TRANNO == sessionStorage.getItem("PACConsltNo"); });
            var AnaestAdviceOperativeOrder = "";
            var VisitDate = "";
            var VisitTime = "";
            if (VisitRecordDataList.length > 0) {
                AnaestAdviceOperativeOrder = VisitRecordDataList[0].ANAESTADVICEOPERATIVEORDER.replace(/\\/g, '').replace(/"/g, '').trim(); //Pournima 29th Aug 2026
                VisitDate = VisitRecordDataList[0].TRANDATE;//priyanka 21/03/2026
                VisitTime = VisitRecordDataList[0].TRANTIME;
            }
            //priyanka 21/03/2026
            $("#txtVisitDate").val(VisitDate);
            $("#txtVisitime").val(VisitTime);
            //end
            $("#txtAAPO").val(AnaestAdviceOperativeOrder); //Pournima 29th Aug 2026
            $("#AAPODown").trigger('click');
            autoResize('txtAAPO');
            $("#AAPOUp").trigger('click');
        }
        //Validation For Anaesthesiologist’s Advice & Preoperative Orders Info
        function ValidationForAnaestAdvOrdInfo() {
            return true;
        }
        //Anaesthesiologist’s Advice & Preoperative Orders Info Save Value Pass
        function SaveForAnaestAdvOrdInfo(PostData) {
            PostData.push({ name: 'AnaestAdviceOperativeOrder', value: JSON.stringify($("#txtAAPO").val().toString().trim()) });
            return PostData;
        }
        //Anaesthesiologist’s Advice & Preoperative Orders Info Print
        function PrintAnaestAdvOrdInfo(PrintData) {
            PrintData.push({ name: 'AnaestAdviceOperativeOrder', value: JSON.stringify($("#txtAAPO").val().toString().trim()) });
            return PrintData;
        }
    </script>

    <%-- Anaesthesia Plan --%>
    <script type="text/javascript">
       <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var MedRoute = '<%:Html.Raw(Samp.Serialize(ViewBag.MedRoute))%>';
        var AllMedRoute = JSON.parse(MedRoute.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
        var RemarkArray = '<%:Html.Raw(Samp.Serialize(ViewBag.RemarkArray))%>';
        var PACMedIntakeList = '<%:Html.Raw(Samp.Serialize(ViewBag.PACIntake))%>';
        var AllFreqList = [];
        var AllDurDayList = [];
        var AllDurCatgList = ["Days", "Weeks", "Months", "Years"];
        var AllFoodList = ["After", "Before"];
        var AllRouteList = [];
        //var AllDoseList = ["2 drops", "5 drops", "0.5 ml", "1 ml", "1.5 ml", "2 ml", "2.5 ml", "3 ml", "3.5 ml", "4 ml", "4.5 ml", "5 ml", "5.5 ml", "6 ml", "6.5 ml", "7 ml", "7.5 ml", "8 ml", "8.5 ml", "9 ml", "9.5 ml", "10 ml"];
        var AllDoseList = [];
        var AllRemarkList = [];
        var AllMedListForSave = [];
        var SearchPrescMedList = [];
        var AllAnaesthesiaTypeList = []; //Pournima 15th July 2026
        //Added By Roshan 20/2/2026
        var IsMasterpage = '<%: ViewBag.MasterPage %>';
        //Anaesthesia Plan Load
        function AnaethesiaPlanLoad() {
            ChangeLblGenericWise();
            //GetPreOPMed("");
            GetFrequencyList();
            GetDurationDayLst();
            GetMediRouteList();
            GetRemarkList();
            MedClickSearch('txtSearchPreOpMed', 'DivSearchPreOpMedList', 'TablePreopTBody', 'P');
            MedClickSearch('txtSearchIndMed', 'DivSearchIndMedList', 'TableInd', 'I');
            //MedClickSearch('txtSearchPONVMed', 'DivSearchPONVMedList', 'TablePONVTBody', 'N');
            //MedClickSearch('txtSearchMaintMed', 'DivSearchMaintMedList', 'TableMaintTBody', 'M');
            //MedClickSearch('txtSearchRevMed', 'DivSearchRevMedList', 'TableRevTBody', 'R');
            BindAnaethesiaPlanGaction();
            toggleInfoColumn();
        }
        //Change Label According Config Generic or Medicine
        function ChangeLblGenericWise() {
            if (GeneralWiseYN == "Y") {
                document.getElementById("PreopTh").innerText = "Generic";
                document.getElementById("IndTh").innerText = "Generic";
                document.getElementById("MaintTh").innerText = "Generic";
                document.getElementById("RevTh").innerText = "Generic";
                document.getElementById("PONVTh").innerText = "Generic";
            }
            else {
                document.getElementById("PreopTh").innerText = "Medicine";
                document.getElementById("IndTh").innerText = "Medicine";
                document.getElementById("MaintTh").innerText = "Medicine";
                document.getElementById("RevTh").innerText = "Medicine";
                document.getElementById("PONVTh").innerText = "Medicine";
            }
        }

        //Medicine Search and Click
        function MedClickSearch(SearchtxtId, DivId, TblBodyId, Type) {
            document.addEventListener('click', function (event) {
                const searchInput = document.getElementById(SearchtxtId);
                const resultsDiv = document.getElementById(DivId);
                if (!searchInput.contains(event.target) && !resultsDiv.contains(event.target)) {
                    resultsDiv.style.display = 'none';
                    $("#" + SearchtxtId).val("");
                }
            });
            document.getElementById(SearchtxtId).addEventListener('input', function () {
                const query = this.value.trim().toLowerCase();
                const resultsDiv = document.getElementById(DivId);
                resultsDiv.innerHTML = '';
                if (query.length >= 3) {
                    GetPreOPMed(query);
                    resultsDiv.style.display = "block";
                    const matched = SearchPrescMedList.filter(function (item) { return item.MTRLNAME.toLowerCase().includes(query) || item.GENERICNAM.toLowerCase().includes(query); });
                    if (matched.length > 0) {
                        matched.forEach(function (item) {
                            var FilterData = AllMedListForSave.filter(function (A) { return A.DRUGCODE == item.MTRLCODE && A.TYPE == Type; });
                            var Check = false; var Disable = false;
                            if (FilterData.length > 0) {
                                Check = true;
                            }
                            const checkbox = document.createElement('input');
                            checkbox.className = 'TestListSearchChk';
                            checkbox.type = 'checkbox';
                            checkbox.id = 'Search_Med_' + Type + '_' + item.MTRLCODE;
                            checkbox.checked = Check;
                            checkbox.disabled = Disable;
                            checkbox.onclick = function () {
                                if (checkbox.checked == true) {
                                    AddMedicineTable(item.MTRLCODE, item.MTRLNAME, Type, TblBodyId, item.GENERICID, item.GENERICNAM, item.MTRLFORMID, "");
                                }
                                else {
                                    AddMedicineTable(item.MTRLCODE, item.MTRLNAME, Type, TblBodyId, item.GENERICID, item.GENERICNAM, item.MTRLFORMID, "");
                                }
                                resultsDiv.innerHTML = '';
                                resultsDiv.style.display = 'none';
                                $("#" + SearchtxtId).val("");
                            };
                            const label = document.createElement('label');
                            label.className = 'TestListSearchLbl';
                            label.htmlFor = checkbox.id;
                            label.innerHTML = item.MTRLNAME;
                            const div = document.createElement('div');
                            div.className = 'TestListSearchDiv';
                            div.appendChild(checkbox);
                            div.appendChild(label);
                            resultsDiv.appendChild(div);
                        });
                    } else {
                        resultsDiv.innerHTML = '<small>No results found.</small>';
                    }
                }
                else {
                    resultsDiv.style.display = "none";
                }
            });
        }

        //Anaesthesia Plan Gaction
        function BindAnaethesiaPlanGaction() {
            if (Gaction == "N") {
                ClearAnaethesiaPlan();
            }
            else {
                BindAnaethesiaPlan();
            }
        }
        //Clear Anaethesia Plan
        function ClearAnaethesiaPlan() {
            $("#cmbAneasthesiaType").val("");
            $("#txtASPLANNotes").val("");
            $("#ASPLANDown").trigger('click');
            autoResize('txtASPLANNotes');
            $("#ASPLANUp").trigger('click');
        }
        //Get All Medicine List
        function GetPreOPMed(Name) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetMedicineRXList",
                data: { DrugName: Name },
                async: false,
                success: function (response) {
                    if (response == "[]")
                        SearchPrescMedList = [];
                    else {
                        //SearchPrescMedList.push(response);
                        SearchPrescMedList = response;
                    }
                },
                complete: function () {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                },
            });
        }
        //Get All Frequency List
        function GetFrequencyList() {
            HoldOn.open();
            $.ajax({
                type: "get",
                datatype: "json",
                url: '../DoctorDesk/GetMedicineInTake',
                async: false,
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var AllFreqDtlsLst = JSON.parse(response);
                        for (i = 0; i < AllFreqDtlsLst.Intake.length; i++) {
                            AllFreqList.push(AllFreqDtlsLst.Intake[i].INTAKE);
                        }
                    }
                },
                complete: function () { HoldOn.close(); },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
            });
        }
        //Get All Duration Day List
        function GetDurationDayLst() {
            for (var i = 0; i <= 30; i++) {
                AllDurDayList.push(i.toString());
            }
        }
        //Get All Route List
        function GetMediRouteList() {
            for (var i = 0; i < AllMedRoute.length; i++) {
                AllRouteList.push(AllMedRoute[i].Text);
            }
        }
        //Get All Remark List
        function GetRemarkList() {
            var RemarkArrayLst = JSON.parse(RemarkArray);
            for (var i = 0; i < RemarkArrayLst.length; i++) {
                AllRemarkList.push(RemarkArrayLst[i].Text);
            }
        }

        function BindRouteByForm(Type, MedCode, Form) {

            var FormTxtId = "txt_Form_" + Type + "_" + MedCode;
            var RouteTxtId = "txt_Route_" + Type + "_" + MedCode;

            var FormCode = $('[id="' + FormTxtId + '"]').attr("data-formcode");

            var FilterRoute = FormLinkRouteList.filter(function (x) {
                return x.FORMCODE == FormCode;
            });

            var option = "<option value=''>Select</option>";

            $.each(FilterRoute, function (i, item) {

                var selected = item.DEFAULTYN == "Y"
                    ? "selected='selected'"
                    : "";

                option += "<option value='" + item.Value + "' " + selected + ">" +
                    item.Text +
                    "</option>";

            });

            $('[id="' + RouteTxtId + '"]').html(option);

            AddUpdateMedicineListSave('U', MedCode, '', Type, '', '', Form);
        }
        //Add Medicine To Table
        function AddMedicineTable(MedCode, MedName, Type, TbodyId, GenCode, GenName, FormCode, Form) {
            toggleInfoColumn();
            if (Form == "C")//It Coming From Copy
            {
                var parent$ = window.parent.$;
            }
            var Tr = "<tr id='{TRID}'>{TRCONTENT}</tr>";
            var Td = "<td {CLASS}>{TDCONTENT}</td>";
            var Label = "<label>{LABELCONTENT}</label>";
            var InputAuto = "<input type='text' class='form-control editable-text auto-field' id='{TEXTBOXID}' onblur=\"AddUpdateMedicineListSave('U','{MEDCODE}','','{TYPE}','','','{FORM}')\" />";
            var DelIcon = "<i class='fa fa-trash MedDelIcon' onclick=\"AddUpdateMedicineListSave('R','{MEDCODE}','','{TYPE}','','','{FORM}')\"></i>";
            var InfoIcon = "<i class='fa fa-info-circle MedInfoIcon' style='font-size: 18px;' aria-hidden='true' onclick=\"getDrugInfo('{MEDCODE}')\"></i>";
            // Action
            var RplDelIcon = DelIcon.replace("{MEDCODE}", MedCode).replace("{TYPE}", Type).replace("{FORM}", Form);
            var RplActTd = Td.replace("{TDCONTENT}", RplDelIcon).replace("{CLASS}", "");
            //Info.
            var RplInfoTd = "";
            if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                var RplInfoIcon = InfoIcon.replace("{MEDCODE}", MedCode);
                RplInfoTd = Td.replace("{TDCONTENT}", RplInfoIcon).replace("{CLASS}", "");
            }
                       //Medicine
            var RplLabel = Label.replace("{LABELCONTENT}", MedName);

            var RplMedNameTd = Td
                .replace("{TDCONTENT}", RplLabel)
                .replace("{CLASS}", "");

            //FormCode
            var FormTxtId = "txt_Form_" + Type + "_" + MedCode;

            var RplFormTxt =
                "<input type='text' readonly " +
                "class='form-control editable-text auto-field' " +
                "id='" + FormTxtId + "' />";

            var RplFormTd = Td
                .replace("{TDCONTENT}", RplFormTxt)
                .replace("{CLASS}", "class='tdtxt'");
            // Frequency
            var FreqTxtId = "txt_Freq_" + Type + "_" + MedCode;
            var RplFreqTxt = InputAuto.replace("{TEXTBOXID}", FreqTxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type).replace("{FORM}", Form);
            var RplFreqTd = Td.replace("{TDCONTENT}", RplFreqTxt).replace("{CLASS}", "class='tdtxt'");
            // Duration Day
            var DurDayTxtId = "txt_DurDay_" + Type + "_" + MedCode;
            var RplDurDayTxt = InputAuto.replace("{TEXTBOXID}", DurDayTxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type).replace("{FORM}", Form);
            var RplDurDayTd = Td.replace("{TDCONTENT}", RplDurDayTxt).replace("{CLASS}", "class='tdtxt'");
            // Duration Category
            var DurCatgTxtId = "txt_DurCatg_" + Type + "_" + MedCode;
            var RplDurCatgTxt = InputAuto.replace("{TEXTBOXID}", DurCatgTxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type).replace("{FORM}", Form);
            var RplDurCatgTd = Td.replace("{TDCONTENT}", RplDurCatgTxt).replace("{CLASS}", "class='tdtxt'");
            // Food
            var FoodTxtId = "txt_Food_" + Type + "_" + MedCode;
            var RplFoodTxt = InputAuto.replace("{TEXTBOXID}", FoodTxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type).replace("{FORM}", Form);
            var RplFoodTd = Td.replace("{TDCONTENT}", RplFoodTxt).replace("{CLASS}", "class='tdtxt' style='display:none'");
            // Route
            // Route Dropdown
            var RouteTxtId = "txt_Route_" + Type + "_" + MedCode;
            var RouteDropdown =
                "<select class='form-control editable-text auto-field' " +
                "style='height:100%;min-height:40px;box-sizing:border-box; ' " +
                "id='" + RouteTxtId + "' " +
                "onchange=\"AddUpdateMedicineListSave('U','" + MedCode + "','','" + Type + "','','','" + Form + "')\">" +
                "</select>";
            var RplRouteTd = Td
                .replace("{TDCONTENT}", RouteDropdown)
                .replace("{CLASS}", "class='tdtxt' style='vertical-align:middle;'");
            // Dosage
            var DosagetxtId = "txt_Dose_" + Type + "_" + MedCode;
            var RplDosageTxt = InputAuto.replace("{TEXTBOXID}", DosagetxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type).replace("{FORM}", Form);
            var RplDosageTd = Td.replace("{TDCONTENT}", RplDosageTxt).replace("{CLASS}", "class='tdtxt'");
            // Quantity
            var QtytxtId = "txt_Qty_" + Type + "_" + MedCode;
            var RplQtyTxt = InputAuto.replace("{TEXTBOXID}", QtytxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type).replace("{FORM}", Form);
            var RplQtyTd = Td.replace("{TDCONTENT}", RplQtyTxt).replace("{CLASS}", "class='tdtxt'");
            // Remark
            var RemarktxtId = "txt_Remark_" + Type + "_" + MedCode;
            //var RplRemarkTxt = InputAuto.replace("{TEXTBOXID}", RemarktxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type).replace("{FORM}", Form);
            var RplRemarkTxt =
                "<textarea " +
                "class='form-control editable-text auto-field remark-textarea' " +
                "id='" + RemarktxtId + "' " +
                "rows='1' " +
                "style='width:100%; min-height:40px; overflow:hidden; resize:none; " +
                "white-space:pre-wrap; overflow-wrap:anywhere; word-break:break-word;' " +
                "oninput='autoResizeTextarea(this)' " +
                "onblur=\"AddUpdateMedicineListSave('U','" + MedCode + "','','" + Type + "','','','" + Form + "')\">" +
                "</textarea>";
            var RplRemarkTd = Td.replace("{TDCONTENT}", RplRemarkTxt).replace("{CLASS}", "class='tdtxt'");
            // Combine all columns
            var TrId = "TR_" + Type + "_" + MedCode;
            var RplTr = Tr.replace("{TRID}", TrId).replace("{TRCONTENT}", RplActTd + RplInfoTd + RplMedNameTd + RplFormTd + RplFreqTd + RplDurDayTd + RplDurCatgTd + RplFoodTd + RplRouteTd + RplDosageTd + RplQtyTd + RplRemarkTd);
            // Append to tbody
            if (Form == "C") {
                parent$("#" + TbodyId).append(RplTr);
            }
            else {
                $("#" + TbodyId).append(RplTr);
            }
            var FormName = "";

            var FormData = FormLinkRouteList.find(function (x) {
                return x.FORMCODE == FormCode;
            });

            if (FormData) {
                FormName = FormData.FORMNAME;
            }

            $("#" + FormTxtId)
                .val(FormName)
                .attr("data-formcode", FormCode);
            // Attach autocomplete


            attachAutocomplete(FreqTxtId, AllFreqList, Type, MedCode);
            attachAutocomplete(DurDayTxtId, AllDurDayList, Type, MedCode);
            attachAutocomplete(DurCatgTxtId, AllDurCatgList, Type, MedCode);
            attachAutocomplete(FoodTxtId, AllFoodList, Type, MedCode);
            /*attachAutocomplete(RouteTxtId, AllRouteList);*/
            attachAutocomplete(DosagetxtId, AllDoseList, Type, MedCode);
            attachAutocomplete(RemarktxtId, AllRemarkList, Type, MedCode);

            //added by aaryshree
            $("#" + FreqTxtId).on("blur change autocompletechange", function () {
                CalculatePACQty(Type, MedCode);
            });

            $("#" + DurDayTxtId).on("blur change autocompletechange", function () {
                CalculatePACQty(Type, MedCode);
            });

            $("#" + DurCatgTxtId).on("blur change autocompletechange", function () {
                CalculatePACQty(Type, MedCode);
            });
            //End
            BindRouteByForm(Type, MedCode, Form);
            //Update Array
            AddUpdateMedicineListSave("A", MedCode, MedName, Type, GenCode, GenName, Form, FormCode);
        }

        function autoResizeTextarea(element) {
            if (!element || element.tagName !== "TEXTAREA") {
                return;
            }
            element.style.height = "auto";
            element.style.overflowY = "hidden";
            element.style.height = element.scrollHeight + "px";
        }
        //Add Auto Complete
        //function attachAutocomplete(inputId, listData) {
        //    $("#" + inputId).autocomplete({
        //        source: listData,
        //        minLength: 0
        //    }).focus(function () {
        //        $(this).autocomplete("search", "");
        //    });
        //    $(document).off('scroll.autocomplete')
        //        .on('scroll.autocomplete wheel.autocomplete', function () {
        //            $(".ui-autocomplete-input").autocomplete("close");
        //        });
        //}

        //Abhishesh || 20260506
        function attachAutocomplete(inputId, listData, Type, MedCode) {

            $("#" + inputId).autocomplete({
                source: listData,
                minLength: 0,
                select: function (event, ui) {
                    $(this).val(ui.item.value);
                    autoResizeTextarea(this);

                    CalculatePACQty(Type, MedCode);

                    return false;
                },
                // Show above textbox
                position: {
                    my: "left bottom",
                    at: "left top",
                    collision: "none"
                },
                change: function (event, ui) {
                    autoResizeTextarea(this);
                    CalculatePACQty(Type, MedCode);
                },

                //Changes By Abhishesh || 20260825
                open: function () {
                    var $input = $(this);
                    var $menu = $input.autocomplete("widget");
                    $menu.css({
                        "max-height": "150px",
                        "overflow-y": "auto",
                        "overflow-x": "hidden",
                        "z-index": "999999"
                    });
                    $menu.position({
                        my: "left bottom",
                        at: "left top",
                        of: $input,
                        collision: "none"
                    });
                    $menu
                        .off("wheel")
                        .on("wheel", function (e) {
                            e.stopPropagation();
                        });
                }
                //End
            })

                // Show autocomplete immediately on focus
                .focus(function () {
                    $(this).autocomplete("search", "");
                });

            // Close autocomplete on page scroll
            $(document)
                .off('scroll.autocomplete wheel.autocomplete')
                .on('scroll.autocomplete wheel.autocomplete', function () {
                    $(".ui-autocomplete-input").autocomplete("close");
                });
        }
        //Update or Remove Medicine List For Save
        function AddUpdateMedicineListSave(Act, MedCode, MedName, Type, GenCode, GenName, From, FormCode) {
            if (Act == "A") {
                var NewD = {
                    SEQNO: AllMedListForSave.length + 1,
                    TYPE: Type,
                    DRUGCODE: MedCode,
                    DRUGNM: MedName,
                    GENERICID: GenCode,
                    GENERICNAME: GenName,
                    INTAKECD: "",
                    INTAKEDESC: "",
                    DAYS: "",
                    DURATION: "",
                    ABFOOD: "",
                    ROUTE: "",
                    DOSSAGE: "",
                    QTY: "",
                    Remarks: "",
                    SOSYN: "N",
                    DRUGFORM: FormCode,
                }
                if (From == "C") {
                    window.parent.AllMedListForSave.push(NewD);
                }
                else {
                    window.AllMedListForSave.push(NewD);
                }
            }
    //else if (Act == "R") {
    //    if (Gaction == "N" || Gaction == "E") {
    //        var TrId = "TR_" + Type + "_" + MedCode;
    //        if (document.getElementById(TrId)) {
    //            document.getElementById(TrId).remove();
    //        }
    //        if (From == "C") {
    //            var TData = JSON.parse(JSON.stringify(window.parent.AllMedListForSave));
    //        }
    //        else {
    //            var TData = JSON.parse(JSON.stringify(AllMedListForSave));
    //        }
    //        var TData = JSON.parse(JSON.stringify(AllMedListForSave));
    //        var Ind = 1;
    //        var FData = TData.filter(function (c) {
    //            if (c.DRUGCODE != MedCode || c.TYPE != Type) {
    //                c.SEQNO = Ind;
    //                Ind++;
    //            }
    //            return c.DRUGCODE != MedCode || c.TYPE != Type;
    //        });
    //        if (From == "C") {
    //            window.parent.AllMedListForSave.push(NewD);
    //        }
    //        else {
    //            window.AllMedListForSave.push(NewD);
    //        }
    //    }
        //}

   //Abhishesh || 20260506
    else if (Act == "R") {
        if (Gaction == "N" || Gaction == "E") {

            var TrId = "TR_" + Type + "_" + MedCode;
            if (document.getElementById(TrId)) {
                document.getElementById(TrId).remove();
            }

            var sourceArray = (From == "C")
                ? window.parent.AllMedListForSave
                : AllMedListForSave;

            var Ind = 1;

            var FData = sourceArray.filter(function (c) {
                return c && !(c.DRUGCODE == MedCode && c.TYPE == Type);
            }).map(function (c) {
                c.SEQNO = Ind++;
                return c;
            });


            if (From == "C") {
                window.parent.AllMedListForSave = FData;
            } else {
                AllMedListForSave = FData;
            }
        }
    }
    //End
            else {
                var FreqTxtId = "txt_Freq_" + Type + "_" + MedCode;
                var DurDayTxtId = "txt_DurDay_" + Type + "_" + MedCode;
                var DurCatgTxtId = "txt_DurCatg_" + Type + "_" + MedCode;
                var FoodTxtId = "txt_Food_" + Type + "_" + MedCode;
                var FormTxtId = "txt_Form_" + Type + "_" + MedCode;
                var RouteTxtId = "txt_Route_" + Type + "_" + MedCode;
                var DosagetxtId = "txt_Dose_" + Type + "_" + MedCode;
                var QtytxtId = "txt_Qty_" + Type + "_" + MedCode;
                var RemarktxtId = "txt_Remark_" + Type + "_" + MedCode;
                var SOSYN = $('[id="' + FreqTxtId + '"]').val() == "SOS" ? "Y" : "N";
                var STATYN = $('[id="' + FreqTxtId + '"]').val() == "STAT" ? "Y" : "N";
                if (SOSYN == "Y" || STATYN == "Y") {
                    $('[id="' + DurDayTxtId + '"]').val("0");
                    $('[id="' + DurCatgTxtId + '"]').val("Days");
                    $('[id="' + DurDayTxtId + '"]').prop("disabled", true);
                    $('[id="' + DurCatgTxtId + '"]').prop("disabled", true);
                }
                else {
                    $('[id="' + DurDayTxtId + '"]').prop("disabled", false);
                    $('[id="' + DurCatgTxtId + '"]').prop("disabled", false);
                }
                if (From == "C") {
                    $.grep(window.parent.AllMedListForSave, function (a) {
                        if (a.TYPE == Type && a.DRUGCODE == MedCode) {
                            a.INTAKECD = $('[id="' + FreqTxtId + '"]').val();
                            a.INTAKEDESC = $('[id="' + FreqTxtId + '"]').val();
                            a.DAYS = $('[id="' + DurDayTxtId + '"]').val();
                            a.DURATION = $('[id="' + DurCatgTxtId + '"]').val();
                            a.ABFOOD = $('[id="' + FoodTxtId + '"]').val();
                            a.ROUTE = $('[id="' + RouteTxtId + '"]').val();
                            a.DRUGFORM = $('[id="' + FormTxtId + '"]').attr("data-formcode");
                            a.DOSSAGE = $('[id="' + DosagetxtId + '"]').val();
                            a.QTY = $('[id="' + QtytxtId + '"]').val();
                            a.Remarks = $('[id="' + RemarktxtId + '"]').val();
                            a.SOSYN = SOSYN;
                        }
                    });
                }
                else {
                    $.grep(AllMedListForSave, function (a) {
                        if (a.TYPE == Type && a.DRUGCODE == MedCode) {
                            a.INTAKECD = $('[id="' + FreqTxtId + '"]').val();
                            a.INTAKEDESC = $('[id="' + FreqTxtId + '"]').val();
                            a.DAYS = $('[id="' + DurDayTxtId + '"]').val();
                            a.DURATION = $('[id="' + DurCatgTxtId + '"]').val();
                            a.ABFOOD = $('[id="' + FoodTxtId + '"]').val();
                            a.ROUTE = $('[id="' + RouteTxtId + '"]').val();
                            a.DRUGFORM = $('[id="' + FormTxtId + '"]').attr("data-formcode");
                            a.DOSSAGE = $('[id="' + DosagetxtId + '"]').val();
                            a.QTY = $('[id="' + QtytxtId + '"]').val();
                            a.Remarks = $('[id="' + RemarktxtId + '"]').val();
                            a.SOSYN = SOSYN;
                        }
                    });
                }
            }

            if (IS_DISPLAY_CIMS_FUNCTIONLITY == "Y") {
                // Added By Roshan Condtion Based On WebConfigs
                toogleButtonsPAC(Type);//For Show And Hide The Interaction and Duplicate Button Added By Roshan 12/12/2025
            }
        }
            //Bind AnaethesiaPlan
         function BindAnaethesiaPlan() {
             <%--$("#cmbAneasthesiaType").val('<%=Model.AneasthTypeCode %>');--%>
             BindAnaesthesiaPlanTypeList(); //Pournima 15th July 2026
            var Notes = '<%=HttpUtility.JavaScriptStringEncode(Model.Notes) %>';
             $("#txtASPLANNotes").val(Notes.replace(/\\n/g, "\n"));
             var MedicineData = '<%=HttpUtility.JavaScriptStringEncode(Model.MedGridData) %>';
           <%-- var MedicineData = `<%=Model.MedGridData %>`;--%>
            var TAllMedListForSave = MedicineData != "" ? JSON.parse(MedicineData) : [];
            $.grep(TAllMedListForSave, function (a) {
                var TbodyId = "";
                if (a.TYPE == "P")
                    TbodyId = "TablePreopTBody";
                if (TbodyId != "") {
                    AddMedicineTable(a.DRUGCODE, a.DRUGNAME, a.TYPE, TbodyId, a.GENERICID, a.GENERICNAME, a.DRUGFORM, '');
                    var FreqTxtId = "txt_Freq_" + a.TYPE + "_" + a.DRUGCODE;
                    var DurDayTxtId = "txt_DurDay_" + a.TYPE + "_" + a.DRUGCODE;
                    var DurCatgTxtId = "txt_DurCatg_" + a.TYPE + "_" + a.DRUGCODE;
                    var FoodTxtId = "txt_Food_" + a.TYPE + "_" + a.DRUGCODE;
                    var RouteTxtId = "txt_Route_" + a.TYPE + "_" + a.DRUGCODE;
                    var FormTxtId = "txt_Form_" + a.TYPE + "_" + a.DRUGCODE;
                    var DosagetxtId = "txt_Dose_" + a.TYPE + "_" + a.DRUGCODE;
                    var QtytxtId = "txt_Qty_" + a.TYPE + "_" + a.DRUGCODE;
                    var RemarktxtId = "txt_Remark_" + a.TYPE + "_" + a.DRUGCODE;
                    var Duration = a.DURATION === "D" ? "Days" : a.DURATION === "M" ? "Months" : a.DURATION === "W" ? "Weeks" : a.DURATION === "Y" ? "Years" : "";
                    $('[id="' + FreqTxtId + '"]').val(a.INTAKEDESC);
                    $('[id="' + DurDayTxtId + '"]').val(a.DAYS);
                    $('[id="' + DurCatgTxtId + '"]').val(Duration);
                    $('[id="' + FoodTxtId + '"]').val(a.ABFOOD);
                    $('[id="' + FormTxtId + '"]').val(a.DRUGFORM);
                    $('[id="' + FormTxtId + '"]').attr("data-formcode", a.DRUGFORMCODE); // Abhishesh || 20260617
                    BindRouteByForm(a.TYPE, a.DRUGCODE, '');
                    $('[id="' + RouteTxtId + '"]').val(a.ROUTE);
                    $('[id="' + DosagetxtId + '"]').val(a.DOSSAGE);
                    $('[id="' + QtytxtId + '"]').val(a.QTY);
                    $('[id="' + RemarktxtId + '"]').val(a.Remarks);
                    AddUpdateMedicineListSave("U", a.DRUGCODE, a.DRUGNAME, a.TYPE, a.GENERICID, a.GENERICNAME, a.DRUGFORM, "");
                }
            });

             var TAllFilterMedListForSave = TAllMedListForSave.filter(function (A) { return A.TRANNO == sessionStorage.getItem("PACConsltNo"); });
             $.grep(TAllFilterMedListForSave, function (a) {
                var TbodyId = "";
                if (a.TYPE == "I")
                    TbodyId = "TableInd";
                if (TbodyId != "") {
                    AddMedicineTable(a.DRUGCODE, a.DRUGNAME, a.TYPE, TbodyId, a.GENERICID, a.GENERICNAME, a.DRUGFORM, '');
                    var FreqTxtId = "txt_Freq_" + a.TYPE + "_" + a.DRUGCODE;
                    var DurDayTxtId = "txt_DurDay_" + a.TYPE + "_" + a.DRUGCODE;
                    var DurCatgTxtId = "txt_DurCatg_" + a.TYPE + "_" + a.DRUGCODE;
                    var FoodTxtId = "txt_Food_" + a.TYPE + "_" + a.DRUGCODE;
                    var RouteTxtId = "txt_Route_" + a.TYPE + "_" + a.DRUGCODE;
                    var FormTxtId = "txt_Form_" + a.TYPE + "_" + a.DRUGCODE;
                    var DosagetxtId = "txt_Dose_" + a.TYPE + "_" + a.DRUGCODE;
                    var QtytxtId = "txt_Qty_" + a.TYPE + "_" + a.DRUGCODE;
                    var RemarktxtId = "txt_Remark_" + a.TYPE + "_" + a.DRUGCODE;
                    var Duration = a.DURATION === "D" ? "Days" : a.DURATION === "M" ? "Months" : a.DURATION === "W" ? "Weeks" : a.DURATION === "Y" ? "Years" : "";
                    $('[id="' + FreqTxtId + '"]').val(a.INTAKEDESC);
                    $('[id="' + DurDayTxtId + '"]').val(a.DAYS);
                    $('[id="' + DurCatgTxtId + '"]').val(Duration);
                    $('[id="' + FoodTxtId + '"]').val(a.ABFOOD);
                    $('[id="' + FormTxtId + '"]').val(a.DRUGFORM);
                    $('[id="' + FormTxtId + '"]').attr("data-formcode", a.DRUGFORMCODE); // Abhishesh || 20260617
                    BindRouteByForm(a.TYPE, a.DRUGCODE, '');
                    $('[id="' + RouteTxtId + '"]').val(a.ROUTE);
                    $('[id="' + DosagetxtId + '"]').val(a.DOSSAGE);
                    $('[id="' + QtytxtId + '"]').val(a.QTY);
                    $('[id="' + RemarktxtId + '"]').val(a.Remarks);
                    AddUpdateMedicineListSave("U", a.DRUGCODE, a.DRUGNAME, a.TYPE, a.GENERICID, a.GENERICNAME, a.DRUGFORM, "");
                }
            });
                $("#ASPLANDown").trigger('click');
                autoResize('txtASPLANNotes');
                $("#ASPLANUp").trigger('click');
            }
        //Validation For AnaethesiaPlan
        function ValidationForAnaethesiaPlan() {
            return true;
        }
        //AnaethesiaPlan Save Value Pass
        function SaveForAnaethesiaPlan(PostData) {
            var AneasthTypeCode = AllAnaesthesiaTypeList.map(function (x) { return x.CODE; }).join("|");
            PostData.push({ name: 'AneasthTypeCode', value: AneasthTypeCode }); // $("#cmbAneasthesiaType").val() });
            PostData.push({ name: 'Notes', value: JSON.stringify($("#txtASPLANNotes").val().toString().trim()) });
            PostData.push({ name: 'MedGridData', value: JSON.stringify(AllMedListForSave) });
            return PostData;
        }
        //AnaethesiaPlan Info Print
        function PrintAnaethesiaPlan(PrintData) {
            var AneasthTypeCode = AllAnaesthesiaTypeList.map(function (x) { return x.NAME; }).join("|");

            PrintData.push({ name: 'AneasthTypeCode', value: AneasthTypeCode }); //  $("#cmbAneasthesiaType").val() != "" ? $("#cmbAneasthesiaType option:selected").text() : "" });
            PrintData.push({ name: 'PreOPMedLst', value: JSON.stringify(GetRealtedTypeMed("P")) });
            PrintData.push({ name: 'InductionLst', value: JSON.stringify(GetRealtedTypeMed("I")) });
            PrintData.push({ name: 'MaintenanceLst', value: JSON.stringify(GetRealtedTypeMed("M")) });
            PrintData.push({ name: 'PONVLst', value: JSON.stringify(GetRealtedTypeMed("N")) });
            PrintData.push({ name: 'RevLst', value: JSON.stringify(GetRealtedTypeMed("R")) });
            PrintData.push({ name: 'Notes', value: JSON.stringify($("#txtASPLANNotes").val().toString().trim()) });
            return PrintData;
        }
        //Get Related Type Name For Med Print
        function GetRealtedTypeMed(Type) {
            var TData = JSON.parse(JSON.stringify(AllMedListForSave));
            var FData = TData.filter(function (c) {
                if (c.TYPE == Type)
                {
                    var matchedDuration = AllDurCatgList.find(function (d) {
                        return d.charAt(0).toUpperCase() === c.DURATION.toUpperCase();
                    });
                    var matchedFood = AllFoodList.find(function (d) {
                        return d.charAt(0).toUpperCase() === c.ABFOOD.toUpperCase();
                    });
                    c.ABFOOD = matchedFood;
                    c.DURATION = matchedDuration;
                }
                return c.TYPE == Type;
            });
            return FData;
        }
        //Added By aaryshree 20260704
        function CalculatePACQty(Type, MedCode) {

            var intake = $("#txt_Freq_" + Type + "_" + MedCode).val().trim();
            var durNum = Number($("#txt_DurDay_" + Type + "_" + MedCode).val()) || 0;
            var durType = $("#txt_DurCatg_" + Type + "_" + MedCode).val().trim();

            var multiVal = 1;

            switch (durType.toUpperCase()) {
                case "DAYS":
                case "D":
                    multiVal = 1;
                    break;
                case "WEEKS":
                case "W":
                    multiVal = 7;
                    break;
                case "MONTHS":
                case "M":
                    multiVal = 30;
                    break;
                case "YEARS":
                case "Y":
                    multiVal = 365;
                    break;
            }

            var intakeObj = JSON.parse(PACMedIntakeList.replace(/^"|"$/g, ""));
            var intakeList = intakeObj.Intake;

            var intakeData = intakeList.find(function (x) {
                return x.INTAKE.toUpperCase() == intake.toUpperCase();
            });
            if (intakeData) {
                var qty = Number(intakeData.TABCOUNT) * (multiVal * durNum);
                $("#txt_Qty_" + Type + "_" + MedCode).val(qty);
            }
        }

        function ValidationForMedicineInfo() {

            for (var i = 0; i < AllMedListForSave.length; i++) {

                var med = AllMedListForSave[i];

                if ($.trim(med.ROUTE) == "") {
                    $("#txt_Route_" + med.TYPE + "_" + med.DRUGCODE).focus();
                    ToastMsg("Please select Route.", "warning");
                    return false;
                }

                if ($.trim(med.DOSSAGE) == "") {
                    $("#txt_Dose_" + med.TYPE + "_" + med.DRUGCODE).focus();
                    ToastMsg("Please enter Dosage.", "warning");
                    return false;
                }

                if ($.trim(med.QTY) == "") {
                    $("#txt_Qty_" + med.TYPE + "_" + med.DRUGCODE).focus();
                    ToastMsg("Please enter Qty.", "warning");
                    return false;
                }
            }

            return true;
        }
        //End

       //Pournima 15th July 2026
       function BindAnaesthesiaTypeList(Data, Append, ShowDelete) {
           if (ShowDelete == undefined)
               ShowDelete = true;
           var container = $("#AnaesthesiaListOption");
           if (!Append) {
               container.empty();
           }
           $.each(Data, function (i, item) {
               var RowId = "AnaesthesiaType_" + item.CODE;
               if ($("#" + RowId).length > 0)
                   return;

               var Row = $("<div>", { id: RowId, class: "AnaesthesiaRow" });

               Row.append($("<input>", { type: "hidden", class: "AnaesthesiaCode", value: item.CODE }));

               Row.append($("<span>", { class: "lblAnaesType", text: item.NAME }));

               if (ShowDelete) {
                   Row.append( $("<span>", {
                           html: "&nbsp;&nbsp;&#10006;",
                           css: { color: "red", cursor: "pointer",  float: "right", fontWeight: "bold", marginleft: "-2px", marginright: "6px", },
                       click: function () {
                           $("#" + RowId).remove();
                           AllAnaesthesiaTypeList = AllAnaesthesiaTypeList.filter(function (x) {
                               return x.CODE != item.CODE;
                           });
                       }
                   })
                   );
               }
               container.append(Row);
           });
       }

       function BindAnaesthesiaPlanTypeList() {
           var AnaesthesiaCodes = '<%=Model.AneasthTypeCode %>';

           if (AnaesthesiaCodes != null && AnaesthesiaCodes != "") {

               AllAnaesthesiaTypeList = [];
               $("#AnaesthesiaListOption").empty();

               var Codes = AnaesthesiaCodes.split("|");

               $.each(Codes, function (i, code) {

                   code = $.trim(code);

                   var option = $("#cmbAneasthesiaType option[value='" + code + "']");

                   if (option.length > 0) {

                       var Obj = {
                           CODE: code,
                           NAME: option.text()
                       };

                       AllAnaesthesiaTypeList.push(Obj);
                       BindAnaesthesiaTypeList([Obj], true, true);
                   }

               });
               $("#cmbAneasthesiaType").val("");
           }
       }
    </script>

    <%-- Save and Validation --%>
    <script type="text/javascript">
        function ValidationForSave() {
            if (ValidationForVitalsInfo() == true && ValidationForPatInfo() == true &&  ValidationForAdviceSurgeryInfo() == true  && ValidationForGenPhyExamInfo() == true &&
                ValidationForComoTreatHistInfo() == true && ValidationForSubsAbuseHistInfo() == true && ValidationForAirwayAssmntInfo() == true && ValidationForSysExamInfo() == true &&
                ValidationForARISCATCritInfo() == true && ValidationForReviLeeCardRskInfo() == true && ValidationForChildPughScrInfo() == true && ValidationForInvestInfo() == true &&
                ValidationForSpecialityRefInfo() == true && ValidationForASAScrInfo() == true && ValidationForAnaestAdvOrdInfo() == true && ValidationForAnaethesiaPlan() == true && ValidationForMedicineInfo() == true 
                ) {
                return true;
            }
            return false;
        }
        function SavePAC(GType) {
            if (ValidationForSave() == true) {
                var PostData = new Array();
                SaveForPatInfo(PostData, GType);
                SaveForAdviceSurgeryInfo(PostData);
                SaveForVitalsInfo(PostData);
                SaveForGenPhyExamInfo(PostData);
                SaveForComoTreatHistInfo(PostData);
                SaveForSubsAbuseHistInfo(PostData);
                SaveForAirwayAssmntInfo(PostData);
                SaveForSysExamInfo(PostData);
                SaveForARISCATCritInfo(PostData);
                SaveForReviLeeCardRskInfo(PostData);
                SaveForChildPughScrInfo(PostData);
                SaveForInvestInfo(PostData);
                SaveForSpecialityRefInfo(PostData);
                SaveForASAInfo(PostData);
                SaveForAnaestAdvOrdInfo(PostData);
                SaveForAnaethesiaPlan(PostData);
                $.ajax({
                    url: '../DoctorDesk/SavePAC',
                    data: PostData,
                    type: 'post',
                    async: false,
                    success: function (response) {
                        if (response.toUpperCase().includes("SUCCESS")) {
                            ToastMsg(response, 'Success');

                            setTimeout(function () {
                                window.location.href = "../SinglePage/WaitingListPAC";
                            }, 2000);

                           
                        }
                        else {
                            ToastMsg(response, 'Information');
                        }
                    }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                        ToastMsg(errorThrown, 'Error');
                    },
                    complete: function () {
                    }
                })
            }
        }
    </script>

    <%-- Common Function --%>
    <script type="text/javascript">
        //Main Div Click
        function TriggerToggleDiv(UpId, DownId, DivId) {
            if (document.getElementById(UpId).style.display == "block" || document.getElementById(UpId).style.display == 'inline-block') {
                ToggleDiv(UpId, DownId, DivId, 'N');
            }
            else if (document.getElementById(DownId).style.display == "block" || document.getElementById(DownId).style.display == 'inline-block') {
                ToggleDiv(DownId, UpId, DivId, 'Y');
            }
        }

        //Toogle For Up and Down Arrow
        function ToggleDiv(ClickId, ShowArrowId, DivId, ShowYN) {
            if (ShowSelectDiv == "Y") {
                const allDivs = document.querySelectorAll('.MainDivContent');
                allDivs.forEach(function (div) { div.style.display = 'none' });
                const allUpArrow = document.querySelectorAll('.UpArrow');
                allUpArrow.forEach(function (div) { div.style.display = 'none' });
                const allDownArrow = document.querySelectorAll('.DownArrow');
                allDownArrow.forEach(function (div) { div.style.display = 'inline-block' });
                document.getElementById(ClickId).style.display = 'none';
                document.getElementById(ShowArrowId).style.display = 'inline-block';
                if (ShowYN === "Y") {
                    document.getElementById(DivId).style.display = 'block';
                }
            }
            else {
                document.getElementById(ClickId).style.display = 'none';
                document.getElementById(ShowArrowId).style.display = 'inline-block';
                if (ShowYN === "Y") {
                    document.getElementById(DivId).style.display = 'block';
                }
                else {
                    document.getElementById(DivId).style.display = 'none';
                }
            }
        }
        //Auto Increase Height of TextArea
        function autoResize(id) {
            var textarea = document.getElementById(id);
            textarea.style.height = "auto";
            var maxHeight = 200;
            if (textarea.scrollHeight > maxHeight) {
                textarea.style.height = maxHeight + "px";
                textarea.style.overflowY = "auto";
            } else {
                textarea.style.height = textarea.scrollHeight + "px";
                textarea.style.overflowY = "hidden";
            }
        }
        //Remove Validation Color
        function MakeNormal(Id) {
            $("#" + Id).css("border-color", "");
        }
        //Uncheck Radion Button
        function UncheckRadioBtn(RadioName) {
            document.querySelectorAll('input[name="' + RadioName + '"]').forEach(function (radio) {
                radio.checked = false;
            });
        }
        //Enable Disable Radio Others Option  Textbox 
        function EnDisRadioOtherField(RadioId, TextFieldId) {
            if ($("#" + RadioId).prop("checked") == true) {
                $("#" + TextFieldId).prop("readonly", false);
            }
            else {
                $("#" + TextFieldId).prop("readonly", true);
            }
        }
        //Radio Button Checked Last Letter
        function GetLastLetterCheckedRadio(RadioName) {
            var Name = "";
            document.querySelectorAll('input[name="' + RadioName + '"]').forEach(function (radio) {
                if (radio.checked) {
                    Name = radio.id.slice(-1);
                }
            });
            return Name;
        }

        //Get Multi Checkbox Value 
        function GetMultiCheckBoxVal(CheckBoxName) {
            var Ids = "";
            document.querySelectorAll('input[name="' + CheckBoxName + '"]').forEach(function (radio) {
                if (radio.checked) {
                    Ids += Ids == "" ? radio.id.slice(-1) : ("," + radio.id.slice(-1));
                }
            });
            return Ids;
        }
        //Bind Multi Checkbox Value 
        function BindMultiCheckBoxVal(CheckBox, Value) {
            var Ids = Value.split(',');
            $.grep(Ids, function (a) {
                $("#" + CheckBox + a).prop("checked", true);
            });
            CalcObesity();
        }
        //Enable Disable Textbox Based Checkbox
        function EnDisChkTextbox(ChkId, TextBoxId) {
            if ($("#" + ChkId).prop("checked") == true) {
                $("#" + TextBoxId).prop("readonly", false);
            }
            else {
                $("#" + TextBoxId).prop("readonly", true);
                $("#" + TextBoxId).val("");
            }
            toggleSwitchLabel(ChkId)
        }
        //Validation For Textbox Based Checkbox
        function ValidTextCheck(ChkId, TextBoxId) {
            if ($("#" + ChkId).prop("checked") == true) {
                if ($("#" + TextBoxId).val() == "") {
                    $("#" + TextBoxId).css("border-color", "red");
                    $("#" + TextBoxId).focus();
                    return false;
                }
            }
            return true;
        }
        //Save Value For Textbox Based Checkbox
        function SaveValueTextCheck(ChkId) {
            if ($("#" + ChkId).prop("checked") == true)
                return "Y";
            return "N";
        }


        //Enable Disable Textbox Based Combo
        function EnDisTextCombo(ComboId, TextBoxId) {
            if ($("#" + ComboId).val() == "O") {
                /*$("#" + TextBoxId).prop("readonly", false);*/
                $("#" + TextBoxId).prop("disabled", false); //priyanka 21/03/2026
            }
            else {
                //$("#" + TextBoxId).prop("readonly", true);
                $("#" + TextBoxId).prop("disabled", true);//priyanka 21/03/2026
                $("#" + TextBoxId).val("");
            }
        }

        function CheckNotif(objectNm, lowerVal, UpperVal, displayMsg) {
            var obj = $('#' + objectNm);
            if (!isNaN(obj.val()) && obj.val() != "") {
                if (obj.val() < lowerVal || obj.val() > UpperVal) {
                    if (displayMsg) {
                        ToastMsg("Critical parameter! Please notify doctor.", 'Information');
                    }
                    setBoldToCritParamVal(objectNm)
                }
                else
                    resetBoldToCritParamVal(objectNm);
            }
            else
                resetBoldToCritParamVal(objectNm);
        }
        function setBoldToCritParamVal(sender) {
            $('#' + sender).css("color", "red");
            $('#' + sender).css("font-weight", "bold");
        }

        function resetBoldToCritParamVal(sender) {
            $('#' + sender).css("color", "#075366");
            $('#' + sender).css("font-weight", "normal");
        }

        function toggleSwitchLabel(checkbox) {
            var label = document.getElementById(checkbox).nextElementSibling.querySelector(".switch-label");
            if (document.getElementById(checkbox).checked) {
                label.textContent = "Yes";
                label.style.left = "5px";
                label.style.textAlign = "left";
                label.style.right = "";
            }
            else {
                label.textContent = "No";
                label.style.left = "";
                label.style.textAlign = "right";
                label.style.right = "10px";
            }
        }

        //Get Label of the Radio Checked
        function GetCheckRadioLabel(groupName) {
            var radios = document.getElementsByName(groupName);
            for (var i = 0; i < radios.length; i++) {
                if (radios[i].checked) {
                    var label = document.querySelector('label[for="' + radios[i].id + '"]');
                    return label ? label.textContent.trim() : null;
                }
            }
            return "";
        }
        //Get Label of the Checkbox Checked
        function GetCheckboxLabels(groupName, separator) {
            var checkboxes = document.getElementsByName(groupName);
            var selectedLabels = [];
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    var label = document.querySelector('label[for="' + checkboxes[i].id + '"]');
                    if (label) {
                        selectedLabels.push(label.textContent.trim());
                    }
                }
            }
            return selectedLabels.join(separator);
        }

        //Open Popup for Information of ARI , Child,Rev Lee
        function OpenPopInfoGuide(Type) {
            if (Type == "A") {
                document.getElementById("InfoHeadLabel").innerText = "ARISCAT Criteria Info";
                $("#TblRevLeeInfo").hide();
                $("#TblChildPughInfo").hide();
                $("#TblECOGInfo").hide();
                $("#TblMALLAMPATIInfo").hide();//priyanka 09/04/2026
                $("#TblPhysicalStatusIInfo").hide();//priyanka 09/04/2026
                $("#TblARISCATInfo").show();
            }
            else if (Type == "R") {
                document.getElementById("InfoHeadLabel").innerText = "Revised Lee Cardiac Risk Info";
                $("#TblARISCATInfo").hide();
                $("#TblChildPughInfo").hide();
                $("#TblECOGInfo").hide();
                $("#TblMALLAMPATIInfo").hide();//priyanka 09/04/2026
                $("#TblPhysicalStatusIInfo").hide();//priyanka 09/04/2026
                $("#TblRevLeeInfo").show();
            }
            else if (Type == "C") {
                document.getElementById("InfoHeadLabel").innerText = "Child Pugh Turcotte Score Info";
                $("#TblARISCATInfo").hide();
                $("#TblRevLeeInfo").hide();
                $("#TblECOGInfo").hide();
                $("#TblMALLAMPATIInfo").hide();//priyanka 09/04/2026
                $("#TblPhysicalStatusIInfo").hide();//priyanka 09/04/2026
                $("#TblChildPughInfo").show();
            }
            else if (Type == "E") {
                document.getElementById("InfoHeadLabel").innerText = "ECOG Score Info";
                $("#TblARISCATInfo").hide();
                $("#TblRevLeeInfo").hide();
                $("#TblChildPughInfo").hide();
                $("#TblMALLAMPATIInfo").hide();//priyanka 09/04/2026
                $("#TblPhysicalStatusIInfo").hide();//priyanka 09/04/2026
                $("#TblECOGInfo").show();
                
            }
            else if (Type == "M") {//priyanka 09/04/2026
                document.getElementById("InfoHeadLabel").innerText = "Mallampati Score Info";
                $("#TblARISCATInfo").hide();
                $("#TblRevLeeInfo").hide();
                $("#TblChildPughInfo").hide();
                $("#TblECOGInfo").hide();
                $("#TblPhysicalStatusIInfo").hide();
                $("#TblMALLAMPATIInfo").show();
            }
            else if (Type == "P") {//priyanka 09/04/2026
                document.getElementById("InfoHeadLabel").innerText = "Physical Status Info";
                $("#TblARISCATInfo").hide();
                $("#TblRevLeeInfo").hide();
                $("#TblChildPughInfo").hide();
                $("#TblECOGInfo").hide();
                $("#TblMALLAMPATIInfo").hide();
                $("#TblPhysicalStatusIInfo").show();
            }
            document.getElementById("POPUPInfoModal").style.display = "flex";
            document.documentElement.style.overflow = 'hidden';
        }

        //NA Option Check for the Score
        function NACheckHeaderInfo(ChckId, ContentDivId, UpArrowId, DownArrowId) {
            document.querySelectorAll('#' + ContentDivId + ' input[type="text"], #' + ContentDivId + ' input[type="radio"], #' + ContentDivId + ' input[type="CHECKBOX"]').forEach(function (el) {
                if ($("#" + ChckId).prop("checked") == true) {
                    if (el.type === 'text') el.value = '';
                    if (el.type === 'radio' || el.type === 'checkbox') el.checked = false;
                    el.disabled = true;
                }
                else {
                    el.disabled = false;
                }
            });
            TriggerToggleDiv(UpArrowId, DownArrowId, ContentDivId);
        }
        //Restrict Vitals Time For Future 
        function restrictTimeBasedOnDate() {
            const dateInput = document.getElementById("txtPVSMDate").value;
            const timeInput = document.getElementById("txtPVSMTime");
            const today = new Date();
            const selectedDateParts = dateInput.split("/");
            if (selectedDateParts.length !== 3) return;
            const selectedDate = new Date(parseInt(selectedDateParts[2], 10), parseInt(selectedDateParts[1], 10) - 1, parseInt(selectedDateParts[0], 10));
            if (selectedDate.getDate() === today.getDate() && selectedDate.getMonth() === today.getMonth() && selectedDate.getFullYear() === today.getFullYear()) {
                const hours = today.getHours().toString().padStart(2, "0");
                const minutes = today.getMinutes().toString().padStart(2, "0");
                const maxTime = hours + ':' + minutes;
                timeInput.max = maxTime;
            } else {
                timeInput.removeAttribute("max");
            }
            document.getElementById("txtPVSMTime").value = "";
        }

        //Close Popup Div
        function ClosePop(DivId) {
            document.getElementById(DivId).style.display = 'none';
            document.documentElement.style.overflow = '';
        }

        //Focus Radio Options
       
        function FocusRadioOpt(Id, Text) {
            document.activeElement.blur();

            ToastMsg(Text);

            const el = document.getElementById(Id);
            if (el && $(el).is(':visible')) {
                el.focus({ preventScroll: true });
                el.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }

        function IFrameGetLastLetterCheckedRadio(RadioName) {
            var Name = "";
            var parentDoc = window.parent.document;

            parentDoc.getElementById("myIframe").contentWindow.document.querySelectorAll('input[name="' + RadioName + '"]').forEach(function (radio) {
                if (radio.checked) {
                    Name = radio.id.slice(-1);
                }
            });
            return Name;
        }
        function IframeGetMultiCheckBoxVal(CheckBoxName, useId = true) {
            var ids = [];
            document.querySelectorAll('input[name="' + CheckBoxName + '"]').forEach(function (cb) {
                if (cb.checked) {
                    var val = useId ? cb.id.slice(-1) : cb.value;
                    ids.push(val);
                }
            });
            return ids.join(",");
        }

       
    </script>

    <%-- Plugins --%>
    <script type="text/javascript">
        $.fn.blockInput = function (options) {
            function findDelta(value, prevValue) {
                var delta = '';
                for (var i = 0; i < value.length; i++) {
                    var str = value.substr(0, i) +
                        value.substr(i + value.length - prevValue.length);
                    if (str === prevValue) delta =
                        value.substr(i, value.length - prevValue.length);
                }
                return delta;
            }
            function isValidChar(c) {
                return new RegExp(options.regex).test(c);
            }
            function isValidString(str) {
                for (var i = 0; i < str.length; i++)
                    if (!isValidChar(str.substr(i, 1))) return false;
                return true;
            }
            this.filter('input,textarea').on('input', function () {
                var val = this.value,
                    lastVal = $(this).data('lastVal');
                var inserted = findDelta(val, lastVal);
                var removed = findDelta(lastVal, val);
                var pasted = inserted.length > 1 || (!inserted && !removed);
                if (pasted) {
                    if (!isValidString(val)) this.value = lastVal;
                }
                else if (!removed) {
                    if (!isValidChar(inserted)) this.value = lastVal;
                }
                $(this).data('lastVal', this.value);
            }).on('focus', function () {
                $(this).data('lastVal', this.value);
            });
            return this;
        };
    </script>

    <%-- Setup Create --%>
    <script type="text/javascript">
        function SetupPopupPACInvestigationContent() {
            return `
            <div class="FilterClassDivPopup">
            <img src="../Images/Singlepage/Plus.png" alt="Add" style="width:34px; height:34px; cursor:pointer; object-fit:contain;" title="Add New Setup" onclick="OpenPopupForNewItem('PAC Investigation', 'PACInvestigationSetup')">
            </div>
            <div id="loading-Setup-Setting" class="loading-screen" style="display: none; opacity: 0;"></div>
            `;
        }

        function CreateTabulatorPACInvestigationSetup(TabulatorSetupId) {
            var PACSetupExamListTable = new Tabulator(("#" + TabulatorSetupId), {
                layout: "fitColumns",
                autoResize: true,
                cellVertAlign: "top",
                resizableColumns: true,
                height: "auto",
                index: "code",
                columns: [
                    {
                        title: "Action",
                        field: "act",
                        width: 100,
                        headerSort: false,
                        hozAlign: "center",
                        formatter: function (cell, formatterParams, onRendered) {
                            return `
                            <div style="display: flex; gap: 15px; justify-content: center; align-items: center;">
                                <i class="fa fa-pencil text-primary edit-row" style="cursor:pointer; font-size: 16px;" title="Edit"></i>
                            </div>
                    `;
                        },
                        cellClick: function (e, cell) {
                            var row = cell.getRow();
                            var target = e.target;
                            var rowData = cell.getRow().getData();
                            if (target.classList.contains("row-checkbox")) {
                                var isChecked = target.checked;
                                var newValue = isChecked ? "Y" : "N";
                                row.update({ CHECKYN: newValue });
                            }
                            if (target.classList.contains("edit-row")) {
                                OpenPopupForNewItem('Edit PAC Investigation', 'PACInvestigationSetup');
                                BindPACInvestigationEditSetup(rowData)
                            }
                        }
                    },
                    { title: "CHECKYN", field: "CHECKYN", visible: false },
                    { title: "Code", field: "code", visible: false },
                    {
                        title: "Name",
                        field: "name",
                        editor: false,
                        formatter: "textarea",
                        formatterParams: {
                            minHeight: "auto",
                        },
                        cssClass: "wrap-text"
                    }
                ]
            });
            BindPACInvestigationSetupList(TabulatorSetupId);
        }

        function BindPACInvestigationSetupList(TabulatorSetupId) {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersInvestigationList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);

                        if (result.Table1 && result.Table1.length > 0) {

                            var formattedData = result.Table1.map(function (row) {
                                return {
                                    CHECKYN: "N",
                                    code: row.CODE,
                                    name: row.DESC
                                };
                            });
                            var table = Tabulator.findTable("#" + TabulatorSetupId)[0];

                            if (table) {
                                table.setData(formattedData);
                            }
                        }
                    }
                }
            });
        }

        function ValidationForPACSetupInvestigationBindTran(TabulatorSetupId) {
            var SelCode = "";
            var table = Tabulator.findTable("#" + TabulatorSetupId)[0];

            if (table) {
                var TableAllData = table.getData();
                SelCode = TableAllData
                    .filter(function (row) {
                        return row.CHECKYN === "Y";
                    })
                    .map(function (row) {
                        return row.code;
                    })
                    .join(",");
                //SetPACInvestigationSetupToTran(SelCode);

                GetInvestigationAdviceList();
            }
        }

        function ContentForAddNewItemPACInvestigationSetup() {
            return `
            <div class="mb-3">
                     <input id="txtSetupNameCode" type="text" class="form-control " style="display:none" />
                   </div>
            <div class="mb-3">
              <input id="txtSetupName" type="text" class="form-control SetupName" maxlength="250" autocomplete="off" placeholder="Enter Setup Name" tabindex="2" />
            </div>
            <div class="mb-3">
                  <div id="PACInvestigationTableSetupNew"></div>
            </div>
            `;
        }

        function FooterContentForAddNewItemPACInvestigationSetup(Type) {
            return `
            <button class="btn btn-primary" onclick="SaveNewItemForPACInvestigationSetup('')" tabindex="4">${Type}</button>
            `;
        }

        function CreatePACInvestigationSetupNewTabultor() {
            var PACInvestigationSetupNewTabultor = new Tabulator(("#PACInvestigationTableSetupNew"), {
                layout: "fitColumns",
                autoResize: true,
                cellVertAlign: "top",
                resizableColumns: true,
                height: "350",
                index: "code",
                columns: [
                    {
                        title: "CHECKYN",
                        field: "CHECKYN",
                        formatter: "tickCross",
                        editor: true,
                        hozAlign: "center",
                        width: 100
                    },
                    { title: "Code", field: "code", visible: false },
                    {
                        title: "Name",
                        field: "name",
                        editor: false,
                        formatter: "textarea",
                        formatterParams: {
                            minHeight: "auto",
                        },
                        cssClass: "wrap-text"
                    }
                ]
            });
            PACInvestigationSetupNewTabultor.on("tableBuilt", function () {
                BindPACInvestigationSetupNewList();
            });
        }

        function BindPACInvestigationSetupNewList() {
            var DataToSend = {
                ClinicCode: sessionStorage.getItem('ClinicCode')
            };
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetInvestigationList","DoctorDesk")%>",
                data: DataToSend,
                async: false,
                success: function (response) {
                    if (response != "") {
                        var formattedData = response.map(function (row) {
                            return {
                                CHECKYN: false,
                                code: row.TESTCODE,
                                name: row.TESTNAME
                            };
                        });
                        var table = Tabulator.findTable("#PACInvestigationTableSetupNew")[0];
                        if (table) {
                            table.setData(formattedData);
                        }
                    }
                }
            });
        }

        function BindPACInvestigationEditSetup(RowData) {
            $.ajax({
                url: '../DoctorDesk/GetInvstListBySetupCode',
                data: { strSetUpCode: RowData.code },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {
                        var codeMap = {};
                        $.each(response, function (i, val) {
                            if (val.CODE) {
                                codeMap[val.CODE] = true;
                            }
                        });
                        var table = Tabulator.findTable("#PACInvestigationTableSetupNew")[0];
                        table.getRows().forEach(function (row) {
                            row.update({
                                CHECKYN: codeMap[row.getData().code]
                            });
                        });
                    }
                    $("#txtSetupNameCode").val(RowData.code);
                    $("#txtSetupName").val(RowData.name);
                }
            })
        }

        function ValidationForNewItemPACInvestigationSetup() {
            var table = Tabulator.findTable("#PACInvestigationTableSetupNew")[0];
            if ($("#txtSetupName").val().trim().length === 0) {
                ToastMsg("Enter Setup Name", "warning");
                $("#txtSetupName").focus();
                return false;
            }
            if (table.getData().filter(function (row) { return row.CHECKYN === true; }).length == 0) {
                ToastMsg("Select Atleast One UnCoded Diagnosis.", "warning");
                return false;
            }
            return true;
        }

        function SaveNewItemForPACInvestigationSetup() {
            if (ValidationForNewItemPACInvestigationSetup() == true) {
                var table = Tabulator.findTable("#PACInvestigationTableSetupNew")[0];

                // collect checked CODEs
                var strInvstArry = table.getData()
                    .filter(function (row) {
                        return row.CHECKYN === true;
                    })
                    .map(function (row) {
                        return row.code;
                    })
                    .join(",");
                var strInvstArry2 = table.getData()
                    .filter(function (row) {
                        return row.CHECKYN === true;
                    })
                    .map(function (row) {
                        return row.name;
                    })
                    .join(",");

                $.ajax({
                    type: "post",
                    datatype: "json",
                    url: '../DoctorDesk/AddInvestnSetUp',
                    data: { strInvestSetUpName: $("#txtSetupName").val(), strInvestigationLst: strInvstArry, strNameLst: strInvstArry2, strSetUpCode: $("#txtSetupNameCode").val() },
                    success: function (response) {
                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            ToastMsg(response, "success");
                            BindPACInvestigationSetupList('Setup_PACInvestigation');
                            GetInvestigationAdviceList();
                            closeAddNewItemPopup('PACInvestigationSetup');
                        }
                        else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {
                            ToastMsg("This Set Up is already Present.", "warning");
                        }
                        else {
                            ToastMsg("Error!!Please Contact IT Dept.", "error");
                        }
                    },
                });
            }
        }

        function SetPACInvestigationSetupToTran(strCode) {
            $.ajax({
                url: '../DoctorDesk/GetAdvicesBySetUpCode',
                data: { strCode: strCode, strType: "I" },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "" && response != "Unsucessfull") {
                        startLoading("Loading", "loading-Investigations");
                        response = JSON.parse(response);
                        for (i = 0; i < response.length; i++) {
                            var rows = InvestigationListtable.getData();
                            var Flag = true;
                            for (var j = 0; j < rows.length; j++) {
                                if (rows[j].code.trim() === response[i].CODE.trim()) {
                                    ToastMsg("Investigation : " + rows[j].name + " already added", "warning");
                                    Flag = false;
                                }
                            }
                            if (Flag) {
                                InvestigationListtable.addRow({
                                    code: response[i].CODE.trim(),
                                    name: response[i].NAME.trim(),
                                    no: "",
                                    type: "",
                                    remark: "",
                                    SetUpYn: "Y"
                                }).then(function (row) {
                                    row.normalizeHeight();
                                    adjustTableHeight("InvestigationTable");
                                });
                            }
                        }
                        stopLoading("loading-Investigations");
                        closeMaxMinPopup('Hist_M_Investigation');
                    }
                }
            })
        }


    </script>

    <%-- Print --%>
    <script type="text/javascript">
        function PrintVisitInfo() {
            if ($("#chkheader").prop('checked') == true) {
                LetterHeaderYN = "Y";
            } else {
                LetterHeaderYN = "";
            }

            startLoading("Loading");
            var DataToSend = {
                TranNo: TranNo,
                MRNo: MRNo,
                SpecialityYN: "Y",//
                PACInvstResultYN: "Y",//
                ShowPatInfo: "Y",
                ShowAdvisedSurgeryDtls: "N",
                ShowPatVitalDtls:  "Y", //
                ShowGenPhysicalExamDtls:"N",
                ShowCombandTreatHistDtls: "N",
                ShowSubstanceAbuseHistDtls: "N",
                ShowAirwayAssmntDtls: "N",
                ShowSysExamDtls:"N",
                ShowARISCATtls:  "N",
                ShowRevCardiacRiskDtls:  "N",
                ShowChildPughTurcScoreDtls:  "N",
                ShowSpecialityRefDtls:  "Y",//
                ShowASADtls: "N",
                ShowInvestAdviceDtls:  "Y", //
                ShowAneasandPreopDtls:  "Y",//
                ShowAneasPlanDtls: "N",
                ShowInductionMedicineDtls:  "Y" ,//
                LetterHeaderYN: LetterHeaderYN,
                IsVisitPrint: sessionStorage.getItem("PACConsltNo")
            };
            $.ajax({
                url: '../DoctorDesk/PrintPACDtls',
                data: DataToSend,
                type: 'post',
                async: false,
                success: function (response) {
                    var url = '../DoctorDesk/DisplayPrintPAC';
                    var win = window.open(url, '', 'width=' + screen.availWidth + ',height=' + screen.availHeight);
                    win.document.close();
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                    stopLoading();
                },
                complete: function () {
                    stopLoading();
                }
            })
        }


        function PrintPAC(FlagYN) {
          
            var isAnyChecked =
                $("#chkSurgeryDiagnosis").prop("checked") ||
                $("#chkVitalSigns").prop("checked") ||
                $("#chkGeneralExam").prop("checked") ||
                $("#chkComorbidities").prop("checked") ||
                $("#chkSubstanceAbuse").prop("checked") ||
                $("#chkAirway").prop("checked") ||
                $("#chkSystemicExam").prop("checked") ||
                $("#chkARISCAT").prop("checked") ||
                $("#chkRevisedLee").prop("checked") ||
                $("#chkChildPugh").prop("checked") ||
                $("#chkSpecialityReference").prop("checked") ||
                $("#chkASA").prop("checked") ||
                $("#chkInvestigations").prop("checked") ||
                $("#chkPreOpOrders").prop("checked") ||
                $("#chkAnaesthesiaPlan").prop("checked") ||
                $("#chkMedicine").prop("checked");

            if (!isAnyChecked) {
                ToastMsg("Please select at least one option to print.", "warning");
                return false;
            }
            // Abhishesh || 20260720
            if ($("#chkheader").prop('checked') == true) {
                LetterHeaderYN = "Y";
            } else {
                LetterHeaderYN = "";
            }

            startLoading("Loading");
            var DataToSend = {
                TranNo: TranNo,
                MRNo: MRNo,
                SpecialityYN: $("#PrintSpecialityRef").prop("checked") == true ? "Y" : "N",
                PACInvstResultYN: $("#PrintPACInvstResult").prop("checked") == true ? "Y" : "N",
                ShowPatInfo: "Y",
                ShowAdvisedSurgeryDtls: $("#chkSurgeryDiagnosis").prop("checked") ? "Y" : "N",
                ShowPatVitalDtls: $("#chkVitalSigns").prop("checked") ? "Y" : "N",
                ShowGenPhysicalExamDtls: $("#chkGeneralExam").prop("checked") ? "Y" : "N",
                ShowCombandTreatHistDtls: $("#chkComorbidities").prop("checked") ? "Y" : "N",
                ShowSubstanceAbuseHistDtls: $("#chkSubstanceAbuse").prop("checked") ? "Y" : "N",
                ShowAirwayAssmntDtls: $("#chkAirway").prop("checked") ? "Y" : "N",
                ShowSysExamDtls: $("#chkSystemicExam").prop("checked") ? "Y" : "N",
                ShowARISCATtls: $("#chkARISCAT").prop("checked") ? "Y" : "N",
                ShowRevCardiacRiskDtls: $("#chkRevisedLee").prop("checked") ? "Y" : "N",
                ShowChildPughTurcScoreDtls: $("#chkChildPugh").prop("checked") ? "Y" : "N",
                ShowSpecialityRefDtls: $("#chkSpecialityReference").prop("checked") ? "Y" : "N",
                ShowASADtls: $("#chkASA").prop("checked") ? "Y" : "N",
                ShowInvestAdviceDtls: $("#chkInvestigations").prop("checked") ? "Y" : "N",
                ShowAneasandPreopDtls: $("#chkPreOpOrders").prop("checked") ? "Y" : "N",
                ShowAneasPlanDtls: $("#chkAnaesthesiaPlan").prop("checked") ? "Y" : "N",
                ShowInductionMedicineDtls: $("#chkMedicine").prop("checked") ? "Y" : "N",
                LetterHeaderYN: LetterHeaderYN,
                IsVisitPrint: "",
                PrintPrvw: sessionStorage.getItem("PACSTATUS") == "W" ? "Y" : "N"
            };
            $.ajax({
                url: '../DoctorDesk/PrintPACDtls',
                data: DataToSend,
                type: 'post',
                async: false,
                success: function (response) {
                     // var win = window.open('../DoctorDesk/DisplayPrintPAC', "_blank", '', true);
                    var url = '../DoctorDesk/DisplayPrintPAC';
                    var win = window.open(url, '', 'width=' + screen.availWidth + ',height=' + screen.availHeight);
                    win.document.close();
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                    stopLoading();
                },
                complete: function () {
                    stopLoading();
                }
            })
        }

        //function PrintPAC(FlagYN) {
        //    HoldOn.open();
        //    var PrintData = new Array();
        //    PrintPatientInfo(PrintData);
        //    PrintAdviceSurgeryInfo(PrintData);
        //    PrintVitalsInfo(PrintData);
        //    PrintGenPhyExamInfo(PrintData);
        //    PrintComoTreatHistInfo(PrintData);
        //    PrintSubsAbuseHistInfo(PrintData);
        //    PrintAirwayAssmntInfo(PrintData);
        //    PrintSysExamInfo(PrintData);
        //    PrintARISCATCritInfo(PrintData);
        //    PrintReviLeeCardRskInfo(PrintData);
        //    PrintChildPughScrInfo(PrintData);
        //    PrintInvestigationInfo(PrintData);
        //    PrintSpecialityRefInfo(PrintData, FlagYN);
        //    PrintASAInfo(PrintData);
        //    PrintAnaestAdvOrdInfo(PrintData);
        //    PrintAnaethesiaPlan(PrintData);
        //    $.ajax({
        //        url: '../DoctorDesk/PrintPACDtls',
        //        data: PrintData,
        //        type: 'post',
        //        async: false,
        //        success: function (response) {
        //            var win = window.open('../DoctorDesk/DisplayPrintPAC', "_blank", '', true);
        //            win.focus();
        //            HoldOn.close();
        //        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
        //            $.messager.alert("Error", errorThrown);
        //            HoldOn.close();
        //        },
        //        complete: function () {
        //            HoldOn.close();
        //        }
        //    })
        //}

        function PrintSpecRef(Ind) {
            var PrintData = new Array();
            PrintData.push({ name: 'SpecialityRefData', value: BindRefDataForSave(Ind) });
            PrintData.push({ name: 'MRNO', value: sessionStorage.getItem('PACPatMRNO') });
            PrintData.push({ name: 'TRANNO', value: sessionStorage.getItem("PACConsltNo") });

            HoldOn.open();
            $.ajax({
                url: '../DoctorDesk/PrintPACReferrence',
                data: PrintData,
                type: 'post',
                async: false,
                success: function (response) {
                    var win = window.open('../DoctorDesk/DisplayPrintPAC', "_blank", '', true);
                    win.focus();
                    HoldOn.close();
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                    HoldOn.close();
                },
                complete: function () {
                    HoldOn.close();
                }
            });
        }


    </script>

    <%-- Change Gaction --%>
    <script type="text/javascript">
        function ChangeGaction(Act) {
            Gaction = Act;
            if (Gaction == "E") {
                document.querySelectorAll('#ContentHolderDiv input, #ContentHolderDiv select, #ContentHolderDiv textarea, #ContentHolderDiv button').forEach(function (el) { el.disabled = false });
                document.querySelectorAll('#AdviceTestListOption input, #AdviceTestListOption select, #AdviceTestListOption textarea, #AdviceTestListOption button').forEach(function (el) { el.disabled = true });
                $("#BtnResultInvst").prop("disabled", false);
                $("#BtnPrintInvst").prop("disabled", false);
                $("#BtnVisitInfoPrint").prop("disabled", false);
                $("#BtnPACLogInfo").prop("disabled", false);
                $("#previousPrep").css('display', 'none');
                $("#CancerCareHist").css('display', 'none');
                $("#InvestRpt").css('display', 'none');
                $("#PACHistory").show();
                $("#BtnPACHistory").removeAttr("disabled");
                $("#PersMedi").show();
                $("#PACInvestigation_Setup").removeAttr("disabled");
                $("#BtnSave").prop("disabled", true);
                $("#BtnEdit").prop("disabled", true);
                $("#BtnPrint").prop("disabled", true);
                $("#BtnPrint_Top").prop("disabled", true);
                $("#PrintSpecialityRef").prop("disabled", true);
                $("#PrintSpecialityRef_Top").prop("disabled", true);
                //$("#txtAPSDate").prop("disabled", true);
                //$("#txtAPSTime").prop("disabled", true);
                $("#rbtnPACNATSURGR").prop("disabled", true);
                $("#rbtnPACNATSURGE").prop("disabled", true);
                $("#rbtnPACNATSURGT").prop("disabled", true);
                $("#PrintPACInvstResult").prop("disabled", true);
                NACheckHeaderInfo('ChkARISCATNA', 'DivContentARISCAT', 'ARISCATUp', 'ARISCATDown');
                TriggerToggleDiv('ARISCATUp', 'ARISCATDown', 'DivContentARISCAT');
                NACheckHeaderInfo('ChkRevLeeNA', 'DivContentRLCRFI', 'RLCRFIUp', 'RLCRFIDown');
                TriggerToggleDiv('RLCRFIUp', 'RLCRFIDown', 'DivContentRLCRFI');
                NACheckHeaderInfo('ChkChildPughNA', 'DivContentCPTS', 'CPTSUp', 'CPTSDown');
                TriggerToggleDiv('CPTSUp', 'CPTSDown', 'DivContentCPTS');
                document.getElementById("BtnSave").style.display = "none";
                document.getElementById("BtnEdit").style.display = "none";
                document.getElementById("PrintDiv").style.display = "none";
                document.getElementById("PrintDiv_Top").style.display = "none";
                document.getElementById("AdviceList").style.display = "none";
                document.getElementById("DivEditChange").style.display = "block";
                document.getElementById("InvstSearchList").style.display = "block";
                document.getElementById("btnAddRef").style.display = "inline-block";
                $("#ChkPACYN").prop("disabled", false);
                $("#ChkVisitYN").prop("disabled", false);
                EnablePACContent();
                EnableVisitContent();
            }
        }

        function EnableDisableAllSections() {
            NACheckHeaderInfo('ChkARISCATNA', 'DivContentARISCAT', 'ARISCATUp', 'ARISCATDown');
            TriggerToggleDiv('ARISCATUp', 'ARISCATDown', 'DivContentARISCAT');
            NACheckHeaderInfo('ChkRevLeeNA', 'DivContentRLCRFI', 'RLCRFIUp', 'RLCRFIDown');
            TriggerToggleDiv('RLCRFIUp', 'RLCRFIDown', 'DivContentRLCRFI');
            NACheckHeaderInfo('ChkChildPughNA', 'DivContentCPTS', 'CPTSUp', 'CPTSDown');
            TriggerToggleDiv('CPTSUp', 'CPTSDown', 'DivContentCPTS');
        }

        function EnablePACContent() {
            if (document.getElementById('ChkPACYN').checked === true) {
                $("#DivContentPatInfo *").removeAttr("disabled");
                $("#DivContentADVSURG *").removeAttr("disabled");
                $("#DivContentPVSM *").removeAttr("disabled");
                $("#DivContentGPE *").removeAttr("disabled");
                $("#DivContentCTH *").removeAttr("disabled");
                $("#DivContentSAH *").removeAttr("disabled");
                $("#DivContentAA *").removeAttr("disabled");
                $("#DivContentSE *").removeAttr("disabled");
                $("#DivContentARISCAT *").removeAttr("disabled");
                $("#DivContentRLCRFI *").removeAttr("disabled");
                $("#DivContentCPTS *").removeAttr("disabled");
                $("#DivContentAPS *").removeAttr("disabled");
                $("#DivContentASPLAN *").removeAttr("disabled");
                $("#txtHydraStatusOther").attr("disabled", true); //priyanka 21/03/2026
            }
            else {
                $("#DivContentPatInfo *").attr("disabled", true);
                $("#DivContentADVSURG *").attr("disabled", true);
                $("#DivContentPVSM *").attr("disabled", true);
                $("#DivContentGPE *").attr("disabled", true);
                $("#DivContentCTH *").attr("disabled", true);
                $("#DivContentSAH *").attr("disabled", true);
                $("#DivContentAA *").attr("disabled", true);
                $("#DivContentSE *").attr("disabled", true);
                $("#DivContentARISCAT *").attr("disabled", true);
                $("#DivContentRLCRFI *").attr("disabled", true);
                $("#DivContentCPTS *").attr("disabled", true);
                $("#DivContentAPS *").attr("disabled", true);
                $("#DivContentASPLAN *").attr("disabled", true);  
            }
        }

        function EnableVisitContent() {
            if (document.getElementById('ChkVisitYN').checked === true) {
                $("#DivContentINVST *").removeAttr("disabled");
                $("#DivContentSPCREF *").removeAttr("disabled");
                $("#DivContentAAPO *").removeAttr("disabled");
                $("#DivContentInvstFieldSet *").removeAttr("disabled");
                document.getElementById("InvstSearchList").style.display = "block";
                document.getElementById("btnAddRef").style.display = "inline-block";
                $("#AdviceList").css('display','inline-block');
                //GetInvestigationAdviceList();
            }
            else {
                $("#DivContentINVST *").attr("disabled", true);
                $("#DivContentSPCREF *").attr("disabled", true);
                $("#DivContentAAPO *").attr("disabled", true);
                $("#DivContentInvstFieldSet *").attr("disabled", true);
                document.getElementById("InvstSearchList").style.display = "none";
                document.getElementById("btnAddRef").style.display = "none";
                $("#AdviceList").css('display', 'none');
            }
        }
    </script>

    <%-- PAC History --%>
    <script type="text/javascript">
        var PacHistListDtls = [];
        var PACHistList = '<%:Html.Raw(Model.PACHistListData)%>';
        PACHistList = PACHistList.replace(/\r?\n/g, "\\n");
        PACHistList = PACHistList !== "" ? JSON.parse(PACHistList) : [];
        console.log(PACHistList);
        function ShowHidePACHistoryIcon() {
            if (PACHistList.length >= 0) {
                document.getElementById("PACHistory").style.display = "flex";
            }
            else {
                document.getElementById("PACHistory").style.display = "none";
            }
        }
        function OpenClosePACHistory() {
            BindPACHistoryList();
            document.getElementById("PACHistInfoModal").style.display = "flex";
            document.documentElement.style.overflow = 'hidden';
            document.getElementById("minimizedIframeBar").innerHTML = ""; // Pournima 28th Aug 2026
        }

        function BindPACHistoryList() {
            $("#TBodyPACHist").empty();
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCCONTENT}</td>";
            $.grep(PACHistList, function (a) {

              //if (a.STATUS === "A") {
//    var RplIcon =
//        "<i class='fa fa-eye IFrameEyeIcon' onclick=\"openIframe('" + a.MRNO + "','" + a.PACCONSNO + "','" + a.PACFITDATE + "','" + a.PACFITTIME + "')\"></i>" +
//        "&nbsp;&nbsp;" +
//        "<i class='fa fa-history IFrameHistoryIcon' onclick=\"openVisitList('" + a.MRNO + "','" + a.PACCONSNO + "')\"></i>";
//}
//else {
//    var RplIcon =
//        "<i class='fa fa-history IFrameHistoryIcon' onclick=\"openVisitList('" + a.MRNO + "','" + a.PACCONSNO + "')\"></i>";
//}
                var RplIcon =
                    //Abhishesh || 20260910
                    "<i class='fa fa-eye IFrameEyeIcon'title='Display' onclick=\"openIframe('" + a.MRNO + "','" + a.PACCONSNO + "','" + a.PACFITDATE + "','" + a.PACFITTIME + "')\"></i>" +
                    "&nbsp;&nbsp;" +
                    "<i class='fa fa-history IFrameHistoryIcon'title='Visit History'style='font-size:17px;' onclick=\"openVisitList('" + a.MRNO + "','" + a.PACCONSNO + "')\"></i>";
                //End
                var RplIconTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", RplIcon);
                var RplTranNoTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.PACCONSNO);
                var RplRefDoctTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.DOCTNAME);
                var RplSurgAdvDTTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.SURGADVDATE);
                var RplSurgeryTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.SURGNMADVICE);
                var NatOfSurg = a.SURGADVTYPE == "R" ? "Regular" : (a.SURGADVTYPE == "E" ? "Emergency" : (a.SURGADVTYPE == "T" ? "Tentative" : ""))
                var RplNatOfSurgTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", NatOfSurg);
                //var PacStatus = a.PACSTATUS == "F" ? "Fit" : (a.PACSTATUS == "W" ? "Fit, with Accepted Risk" : (a.PACSTATUS == "U" ? "UnFit": "Pending"))
                //priyanka 20/11/2025
                var PacStatus = a.PACSTATUS === "F" ? "Fit" :
                               (a.PACSTATUS === "W" && a.ASARISKLEVEL === "") ? "Fit, with Accepted Risk" :
                               (a.PACSTATUS === "W" && a.ASARISKLEVEL !== "") ? "Fit, with Accepted Risk (" + a.ASARISKLEVEL + ")" :
                               (a.PACSTATUS === "U" ? "UnFit" : "Pending");

                var RplPacStatusTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", PacStatus);
                var RplPacStatusDTTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", (a.PACFITDATE.trim() == "" || a.PACFITDATE.trim() == "/  /" ? "" : (a.PACFITDATE + " " + a.PACFITTIME)));
                var RplCreatedByTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.PACDONEBY);
                var RplTr = Tr.replace("{TRCONTENT}", (RplIconTd + RplTranNoTd + RplRefDoctTd + RplSurgAdvDTTd + RplSurgeryTd + RplNatOfSurgTd + RplPacStatusTd + RplPacStatusDTTd + RplCreatedByTd));
                $("#TBodyPACHist").append(RplTr);
            });
        }

        function openIframe(Mrno, TranNo, PacDT, PacTM) {
            const iframeMain = document.getElementById('iframeMain');
            iframeMain.style.display = 'block';
            iframeMain.classList.remove('minimized');
            $("#iframeContainer").empty();
            document.getElementById('PACHistFrameLbl').innerText = TranNo + (PacDT.trim() == "" || PacDT.trim() == "/  /"  ? "" : (" (" + PacDT.trim() + " " + PacTM.trim() + ")"));
            const iframe = document.createElement("iframe");
            HoldOn.open();
            iframe.id = "myIframe";
            iframe.src = "../SinglePage/PAC?PatMRNO=" + Mrno + "&PatTRANNO=" + TranNo + "&Gaction=" + "V" + "&MasterPage=" + "Y";
            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            iframe.onload = function () {
                var code = iframe.contentWindow.gDoctCode;
                if (!code || code.trim() === "") {
                    document.getElementById("iframeContainer").style.display = "none";
                    window.location.href = "../Account/Login";
                    return;
                }
                const iframeDoc = iframe.contentWindow.document;
                const $secCont = $(iframeDoc).find("#secCont");
                const $iframeBody = $(iframeDoc).find("body, html");
                $(iframeDoc).find(".main-header").hide();
                $(iframeDoc).find("#MainDivBtnGrp").hide();
                $(iframeDoc).find("#InvestRpt").hide();
                $(iframeDoc).find("#content").css("padding", "0px");
                $secCont.attr("style", function (i, s) {
                    return (s || "") +
                      "min-height:0px !important;" +
                      "margin-left:0px !important;" +
                      "padding:0px !important;" +
                      "width:100% !important;";
                });
                $("#myIframe").css("visibility", "visible");
                HoldOn.close();
            };
            document.getElementById("iframeContainer").appendChild(iframe);
        }

        //Added by Aaryshree on 20260220
        function openVisitList(mrno, tranno) {
            debugger;
            if (typeof ClosePop === "function") {
                ClosePop('PACHistInfoModal');
            } else {
                $('#PACHistInfoModal').modal('hide');
            }

            $.ajax({
                url: '../DoctorDesk/GetPACVisit',
                type: 'GET',
                data: { MRNO: mrno, TRANNO: tranno },
                dataType: 'json',
                success: function (data) {

                    if (!data || !data.Table) {
                        ToastMsg("No history found for this transaction.", "info");
                        return;
                    }

                    var tranNos = Object.values(data.AllTable).flat().map(x => x.TRANNO).filter(x => x);
                    var uniqueTranNos = [...new Set(tranNos)];
                    const rxList = data.Table6 || [];
                    const invList = data.Table3 || [];
                    const specList = data.Table || [];
                    //const ConsLst = data.AllTable.Table7 || [];
                    const ConsLst = data.Table7 || []; //priyanka 21/03/2026
                    const SpecilityName = data.Table5 || [];
                    var html = "";
                    uniqueTranNos.forEach(tranNo => {
                        html += `<div id="fancybox-pac-content" style="width:100%; max-width:900px;">
                            <div class="pac-container">`;
                        const spec = specList.find(x => x.TRANNO === tranNo) || {};
                        const rxFiltered = rxList.filter(x => x.TRANNO === tranNo);
                        const invFiltered = invList.filter(x => x.TRANNO === tranNo);
                        const specilityRefrenceListFilter = SpecilityName.filter(x => x.TRANNO === tranNo)
                        const specilityRefrenceFilter = SpecilityName.filter(x => x.TRANNO === tranNo).map(x => x.REFNAME);
                        const ConusltData = ConsLst.filter(x => x.TRANNO === tranNo);
                        if (ConusltData.length === 0) return;

                        const currentVisit = ConusltData[0];
                        var formattedDate = formatDate(currentVisit.TRANDATE);
                        var trantime = currentVisit.TRANTIME;//priyanka 21/03/2026
                        html += `
               <div class="pac-card" style="border: 1px solid #ddd; margin-bottom: 20px; border-radius: 4px;">
                   <div class="pac-header" style="background: #3c5a99; color: white; padding: 10px; display: flex; justify-content: space-between;">
                       <span><i class="fa fa-copy"></i> Dr. ${currentVisit.DOCTNAME || 'Consultant'}</span> 
                       <span>${formattedDate} - ${trantime}</span>
                   </div>
              
                   <div class="pac-body" style="padding: 15px;">
              
                   <div class="section-title" style="font-weight:bold; margin-top:10px; display:flex; justify-content:space-between;">
                   <span>Medicine</span>
                   <i class="fa fa-copy" style="cursor:pointer; color:#2c73b4;"onclick='copyRxToParent(${JSON.stringify(rxFiltered)})'></i>
                   </div>
              
                   <table class="pac-table" style="width:100%; font-size:12px;">
                             <thead style="background:#2c73b4; color:white;">
                         <tr>
                             <th style="padding:8px; border:1px solid #ddd;">Sr No</th>
                             <th style="padding:8px; border:1px solid #ddd;">Generic</th>
                                  <th style="padding:8px; border:1px solid #ddd;">Form</th>
                                    <th style="padding:8px; border:1px solid #ddd;">Frequency</th>
                             <th colspan="2" style="padding:8px; border:1px solid #ddd;">Duration</th>
                             <th style="padding:8px; border:1px solid #ddd;">Route</th>
                             <th style="padding:8px; border:1px solid #ddd;">Dosage</th>
                             <th style="padding:8px; border:1px solid #ddd;">Qty</th>
                             <th style="padding:8px; border:1px solid #ddd;">Remark</th>
                         </tr>
                     </thead>
                   <tbody>
              
                   ${rxFiltered.map((rx, index) => {

                            const durationType = rx.DURATION_UNIT || rx.DURATION;
                            let durationLabel = durationType;

                            if (durationType === 'W') durationLabel = 'Weeks';
                            else if (durationType === 'D') durationLabel = 'Days';
                            else if (durationType === 'M') durationLabel = 'Months';

                            return `
                           <tr>
                               <td>${index + 1}</td>
                               <td>${rx.GENERICNAME}</td>
                             <td>${
                                (FormLinkRouteList.find(function (x) {
                                    return x.FORMCODE == rx.DRUGFORM;
                                }) || {}).FORMNAME || rx.DRUGFORM || ''
                                  }</td>
                               <td>${rx.INTAKEDESC || rx.FREQUENCY}</td>
                               <td>${rx.DAYS}</td>
                               <td>${durationLabel}</td>
                               <td>${
                                (FormLinkRouteList.find(function (x) {
                                    return x.Value == rx.ROUTE &&
                                        x.FORMCODE == rx.DRUGFORM;
                                }) || {}).Text || rx.ROUTE || ''
                                 }</td>
                               <td>${rx.DOSSAGE}</td>
                               <td>${rx.QTY}</td>
                               <td>${rx.Remarks || 'As needed.'}</td>
                           </tr>`;
                        }).join('')
                            }
                   </tbody>
                   </table>
                   <div class="section-title" style="font-weight:bold; margin-top:10px; display:flex; justify-content:space-between;">
                   <span>Investigation</span>
                    <i class="fa fa-copy" onclick='AutoSelectInvestigations(${JSON.stringify(invFiltered)})'></i>
                   </div>
              
                   <ul>
                   ${invFiltered.length > 0
                                ? invFiltered.map(inv => {

                                    const durationPart = inv.DURATION && inv.DURATION != 0
                                        ? ` - ${inv.DURATION}` : '';

                                    const remarkPart = inv.REMARK
                                        ? ` - ${inv.REMARK}` : '';

                                    return `<li>${inv.TESTNAME}${durationPart}${remarkPart.replace(/\\n/g, "\n") }</li>`;

                                }).join('')
                                : '<li>No investigations</li>'
                            }
                   </ul>
                                            
                      <div class="section-title" style="font-weight:bold; margin-top:10px; display:flex; justify-content:space-between;">
                        <span>Speciality Reference</span>
                        ${specilityRefrenceFilter.length
                                ? `<i class='fa fa-copy' onclick='AutoSelectSpeciality(${JSON.stringify(specilityRefrenceListFilter)})'></i>`
                                : ''}
                      </div>
                      
                      <p>${specilityRefrenceFilter.length ? specilityRefrenceFilter.join(', ') : 'N/A'}</p>
                      
                      
                      <div class="section-title" style="font-weight:bold; margin-top:10px; display:flex; justify-content:space-between;">
                        <span>Speciality Others</span> 
                       ${currentVisit.SPECIALITYREFERENCE
                                ? `<i class="fa fa-copy copy-icon" data-value="${currentVisit.SPECIALITYREFERENCE}" onclick='AutoSelectSpecialityOther(this)'></i>`
                                : ''}
                      </div>
                      <p>${currentVisit.SPECIALITYREFERENCE && currentVisit.SPECIALITYREFERENCE != '""' ? currentVisit.SPECIALITYREFERENCE.replace(/\\n/g, "\n") : 'No Speciality Others'}</p>
                     <div class="section-title" style="font-weight:bold; margin-top:10px; display:flex; justify-content:space-between;">
                        <span>Anaesthesiologist’s Advice & Preoperative Orders</span>
                           ${currentVisit.ANAESTADVICEOPERATIVEORDER
                                ? `<i class="fa fa-copy copy-icon" data-value="${currentVisit.ANAESTADVICEOPERATIVEORDER}" onclick='AutoSelectAnaesthAdv(this)'></i>`
                                : ''}
                      </div>
                      <p>${currentVisit.ANAESTADVICEOPERATIVEORDER && currentVisit.ANAESTADVICEOPERATIVEORDER != '""' ? currentVisit.ANAESTADVICEOPERATIVEORDER.replace(/\\n/g, "\n") : 'No Anaesthesiologist Advice'}</p>
                   </div>
               </div></div></div>
               `;
                    });
                    $.fancybox.open(html);
                    if (sessionStorage.getItem("PACSTATUS") == "A") {
                        $(".fa-copy").hide();
                    }
                },
                error: function (xhr, status, error) {
                    ToastMsg("Failed to load data. Please check console for details.", "info");
                }
            });
        }

        function formatDate(dateStr) {
            if (!dateStr) return '';

            return dateStr.substring(6, 8) + "/" +
                dateStr.substring(4, 6) + "/" +
                dateStr.substring(0, 4);
        }

        function AutoSelectSpeciality(specilityRefrenceFilterData) {
            $("#SPCREFDown").trigger('click');
            $.grep(specilityRefrenceFilterData, function (a) {
                AddRemSpecialityRef("A", "");
                var IndId = SpecialityRefList[SpecialityRefList.length - 1].INDEX;
                BindAddSpecialityRef(IndId, a.REFCODE, a.REFNAME, a.REFCONTENT, false, true);
                var CmbId = "cmbSpeciality_" + IndId;
                var TxtId = "txtSpeciality_" + IndId;
                if (a.REFCODE == "")
                    ValidateRefText(TxtId);
                else
                    EnDisableSpecRefTextbox(CmbId, TxtId);
                autoResize(('txtSPCREF_' + IndId));
            });
            if ($.fancybox) $.fancybox.close();
            $("#txtSPCREF").focus();
        }

        //function AutoSelectSpecialityOther(el) {
        //    const value = $(el).data("value");
        //    $("#txtSPCREF").val(value);
        //    autoResize('txtSPCREF');
        //    if ($.fancybox) $.fancybox.close();
        //    $("#txtSPCREF").focus();
        //}

        function AutoSelectSpecialityOther(el) {
            //const value = $(el).closest('.section-title').next('p').text().trim();
            const value = $(el).closest('.section-title').next('p').text().trim().replace(/^"(.*)"$/, '$1');//priyanka 23/03/2026
            $("#txtSPCREF").val(value);
            autoResize('txtSPCREF');
            if ($.fancybox) $.fancybox.close();
            $("#txtSPCREF").focus();
        }

        function AutoSelectAnaesthAdv(el) {
            //const AnaesthAdvTxt = $(el).data("value");
            const AnaesthAdvTxt = $(el).closest('.section-title').next('p').text().trim().replace(/^"(.*)"$/, '$1');
            $("#txtAAPO").val(AnaesthAdvTxt);
            autoResize('txtAAPO');
            if ($.fancybox) $.fancybox.close();
            $("#txtAAPO").focus();
        }

        function AutoSelectInvestigations(invList) {
            if (!invList || invList.length === 0) return;

            invList.forEach(inv => {

                var ChkId = "ChkAdvTest_EDITADVTEST_" + inv.TESTCODE;
                var existingCheckbox = document.getElementById(ChkId);

                if (existingCheckbox) {

                    existingCheckbox.checked = true;
                    AdviceListColorChange(ChkId);
                } else {

                    BindTestListForAdvice([inv], "EDITADVTEST", true);
                }


                var alreadyInList = AllPACTestAdviceList.some(x => x.TESTCODE === inv.TESTCODE);
                if (!alreadyInList) {
                    AllPACTestAdviceList.push({
                        CHECKED: "Y",
                        CODE: inv.TESTCODE,
                        SETUPCODE: "",
                        TESTCODE: inv.TESTCODE,
                        TESTNAME: inv.TESTNAME,
                        TRANYN: "N"
                    });
                }
            });

            if ($.fancybox) $.fancybox.close();
        }

        function copySpecialityRef(value) {
            if (!value) {
                ToastMsg("No data to copy.");
                return;
            }
            try {
                value = JSON.parse(value);
            } catch (e) { }
            $("#txtSPCREF").val(value);

            autoResize("txtSPCREF");

            $.fancybox.close();
        }
        function copyAnaesthesisAdvice(value) {
            if (!value) {
                ToastMsg("No data to copy.");
                return;
            }
            try {
                value = JSON.parse(value);
            } catch (e) { }
            $("#txtAAPO").val(value);

            autoResize("txtAAPO");

            $.fancybox.close();
        }
        function copyRxToParent(rxArray) {

            if (!rxArray || rxArray.length === 0) {
                alert("No Rx data to copy.");
                return;
            }

            var parent$ = window.parent.$;
            var duplicateMeds = [];

            rxArray.forEach(function (rx) {

                let medCode = rx.MEDCODE || rx.GENERICID;
                let medName = rx.GENERICNAME;

                var trId = "TR_RX_" + medCode;
                if (parent$("#" + trId).length > 0) {
                    duplicateMeds.push(medName);
                    return;
                }

                let durationLabel = rx.DURATION_UNIT || rx.DURATION;

                if (durationLabel === 'W') durationLabel = 'Weeks';
                else if (durationLabel === 'D') durationLabel = 'Days';
                else if (durationLabel === 'M') durationLabel = 'Months';

                AddMedicineTable(
                    medCode,
                    medName,
                    "RX",
                    "TableIndTBody",
                    rx.GENERICID || "",
                    rx.GENERICNAME || "",
                    rx.DRUGFORM || "",
                    "C"
                );

                var prefix = "RX_" + medCode;

                parent$("#txt_Freq_" + prefix).val(rx.INTAKEDESC || rx.FREQUENCY);
                parent$("#txt_DurDay_" + prefix).val(rx.DAYS);
                parent$("#txt_DurCatg_" + prefix).val(durationLabel);
                parent$("#txt_Route_" + prefix).val(rx.ROUTE);
                parent$("#txt_Dose_" + prefix).val(rx.DOSSAGE);
                parent$("#txt_Qty_" + prefix).val(rx.QTY);
                parent$("#txt_Remark_" + prefix).val(rx.Remarks || "");
                // Update parent array directly
                var parentMed = window.parent.AllMedListForSave.find(function(item) {
                    return item.TYPE === "RX" &&
                        item.DRUGCODE === medCode;
                });

                if (parentMed) {

                    parentMed.INTAKECD = rx.INTAKEDESC || rx.FREQUENCY;
                    parentMed.INTAKEDESC = rx.INTAKEDESC || rx.FREQUENCY;
                    parentMed.DAYS = rx.DAYS;
                    parentMed.DURATION = rx.DURATION;
                    parentMed.ROUTE = rx.ROUTE;
                    parentMed.DOSSAGE = rx.DOSSAGE;
                    parentMed.QTY = rx.QTY;
                    parentMed.Remarks = rx.Remarks || "";
                    parentMed.DRUGFORM =rx.DRUGFORM || "";
                    parentMed.ABFOOD = "";
                    parentMed.SOSYN = rx.INTAKEDESC === "SOS" || rx.FREQUENCY === "SOS" ? "Y" : "N";
                    parentMed.TYPE = "I";
                }

           
            });

            if (duplicateMeds.length > 0) {
                ToastMsg("These medicines are already copied:\n\n" + duplicateMeds.join("\n"), "warning");
            }

            $.fancybox.close();
        }
        function closeIframe() {
            window.parent.document.getElementById('iframeMain').style.display = 'none';
        }

        //Priyanka 19/11/2025
        //function openInvestigationframe(MRNO) {
        //    const iframeMain = document.getElementById('iframeMain');
        //    iframeMain.style.display = 'block';
        //    iframeMain.classList.remove('minimized');
        //    $("#iframeContainer").empty();
        //    //document.getElementById('PACHistFrameLbl').innerText = TranNo + " (" + PacDT + " " + PacTM + ")";
        //    const iframe = document.createElement("iframe");
        //    HoldOn.open();
        //    iframe.id = "myIframe";
        //    iframe.src = '../DoctorDesk/Investigation?MRNO=' + MRNO;
        //    iframe.style.width = "100%";
        //    iframe.style.height = "100%";
        //    iframe.style.border = "none";
        //    iframe.onload = function () {
        //        var code = iframe.contentWindow.gDoctCode;
        //        if (!code || code.trim() === "") {
        //            document.getElementById("iframeContainer").style.display = "none";
        //            window.location.href = "../Account/Login";
        //            return;
        //        }
        //        const iframeDoc = iframe.contentWindow.document;
        //        const $secCont = $(iframeDoc).find("#secCont");
        //        const $iframeBody = $(iframeDoc).find("body, html");
        //        $(iframeDoc).find(".main-header").hide();
        //        $(iframeDoc).find("#MainDivBtnGrp").hide();
        //        $(iframeDoc).find("#InvestRpt").hide();
        //        $(iframeDoc).find("#content").css("padding", "0px");
        //        $secCont.attr("style", function (i, s) {
        //            return (s || "") +
        //              "min-height:0px !important;" +
        //              "margin-left:0px !important;" +
        //              "padding:0px !important;" +
        //              "width:100% !important;";
        //        });
        //        $("#myIframe").css("visibility", "visible");
        //        HoldOn.close();
        //    };
        //    document.getElementById("iframeContainer").appendChild(iframe);
        //}


        function openInvestigationframe(MRNO) {
            const iframeMain = document.getElementById('iframeMain');
            iframeMain.style.display = 'block';
            iframeMain.classList.remove('minimized');
            $("#iframeContainer").empty();
            //document.getElementById('PACHistFrameLbl').innerText = TranNo + " (" + PacDT + " " + PacTM + ")";
            const iframe = document.createElement("iframe");
            HoldOn.open();
            iframe.id = "myIframe";
            iframe.src = '../DoctorDesk/Investigation?MRNO=' + MRNO;
            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            iframe.onload = function () {
                var code = iframe.contentWindow.gDoctCode;
                if (!code || code.trim() === "") {
                    document.getElementById("iframeContainer").style.display = "none";
                    window.location.href = "../Account/Login";
                    return;
                }
                const iframeDoc = iframe.contentWindow.document;
                const $secCont = $(iframeDoc).find("#secCont");
                const $iframeBody = $(iframeDoc).find("body, html");
                $(iframeDoc).find(".main-header").hide();
                // Hide the main header in the iframe (if present)
                $(iframeDoc).find(".main-header").hide();

                let patientInfoHtml = $("#DivpatDtls").clone();
                // Hide or remove divNotification inside it
                patientInfoHtml.find("#divNotification").remove();
                // Convert back to HTML
                patientInfoHtml = patientInfoHtml.html();
                // Add the content of DivpatDtls to the right corner of the iframe body
                $(iframeDoc.body).prepend(
                    '<div id="iframe-patient-info" ' +
                    'style="position:absolute; top:10px; right:10px; z-index:9999;padding: 5px;background: steelblue;">' +
                        patientInfoHtml +
                    '</div>'
                );
                $(iframeDoc).find("#divForBack").hide();
                $(iframeDoc).find("#MainDivBtnGrp").hide();
                $(iframeDoc).find("#InvestRpt").hide();
                $(iframeDoc).find("#content").css("padding", "0px");
                $secCont.attr("style", function (i, s) {
                    return (s || "") +
                      "min-height:0px !important;" +
                      "margin-left:0px !important;" +
                      "padding:0px !important;" +
                      "width:100% !important;";
                });
                $("#myIframe").css("visibility", "visible");
                HoldOn.close();
            };
            document.getElementById("iframeContainer").appendChild(iframe);
        }



        function openCancerCareHistframe(MRNO) {
            const iframeMain = document.getElementById('iframeMain');
            iframeMain.style.display = 'block';
            iframeMain.classList.remove('minimized');
            $("#iframeContainer").empty();
            const iframe = document.createElement("iframe");
            HoldOn.open();
            iframe.id = "myIframe";
            iframe.src = '../DoctorDesk/SurgicalHistory';
            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            iframe.onload = function () {
                var code = iframe.contentWindow.gDoctCode;
                if (!code || code.trim() === "") {
                    document.getElementById("iframeContainer").style.display = "none";
                    window.location.href = "../Account/Login";
                    return;
                }
                const iframeDoc = iframe.contentWindow.document;
                const $secCont = $(iframeDoc).find("#secCont");
                const $iframeBody = $(iframeDoc).find("body, html");
                $(iframeDoc).find(".main-header").hide();
                let patientInfoHtml = $("#DivpatDtls").clone();
                patientInfoHtml.find("#divNotification").remove();
                patientInfoHtml = patientInfoHtml.html();
                $(iframeDoc.body).prepend(
                    '<div id="iframe-patient-info" ' +
                    'style="position:absolute; top:10px; right:10px; z-index:9999;padding: 5px;background: steelblue;">' +
                        patientInfoHtml +
                    '</div>'
                );
                $(iframeDoc).find("#divForBack").hide();
                $(iframeDoc).find("#MainDivBtnGrp").hide();
                $(iframeDoc).find("#InvestRpt").hide();
                $(iframeDoc).find("#btnAddRecord").hide();
                $(iframeDoc).find("#content").css("padding", "0px");
                $secCont.attr("style", function (i, s) {
                    return (s || "") +
                      "min-height:0px !important;" +
                      "margin-left:0px !important;" +
                      "padding:0px !important;" +
                      "width:100% !important;";
                });
                $("#myIframe").css("visibility", "visible");
                HoldOn.close();
            };
            document.getElementById("iframeContainer").appendChild(iframe);
        }
        //End

        function minimizeIframe() {
            const container = document.getElementById('iframeMain');
            container.classList.toggle('minimized');
        }
    </script>
    <style>
        .IFrameEyeIcon {
            cursor: pointer;
            font-size: 18px;
            color: black;
        }

        #iframeMain {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: white;
            z-index: 1000000;
            display: flex;
            flex-direction: column;
            border: 1px solid #aaa;
        }

        #iframeHeader {
            height: 40px;
            background-color: #3b5998;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 10px;
            font-weight: bold;
            flex-shrink: 0;
            border-bottom: 1px solid #ddd;
            color: white;
            font-size: 14px;
        }

        #myIframe {
            flex-grow: 1;
            width: 100%;
            border: none;
            height: 100%;
            visibility: hidden;
        }

        #iframeMain.minimized {
            height: 40px;
            width: auto;
            position: fixed;
            top: auto;
            bottom: 10px;
            right: 40px;
            left: auto;
        }

            #iframeMain.minimized #myIframe {
                display: none;
            }

        .IFrameIcon {
            padding: 0px 5px;
            font-size: 25px;
            cursor: pointer;
        }

    </style>

    <%-- PAC Log Info --%>
    <script type="text/javascript">
        function OpenClosePACLogInfo() {
            GetPACLogList();
            document.getElementById("PACLogInfoModal").style.display = "flex";
            document.documentElement.style.overflow = 'hidden';
        }

        function GetPACLogList() {
            var PACLogList = [];
            var DataToSend = {
                TranNo: TranNo
            }
            HoldOn.open();
            $.ajax({
                url: '../DoctorDesk/GetPACLogInfoList',
                data: DataToSend,
                type: 'post',
                async: false,
                success: function (response) {
                    PACLogList = response != null ? response : [];
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, 'Error');
                    HoldOn.close();
                },
                complete: function () {
                    HoldOn.close();
                }
            });
            BindPACLogList(PACLogList);
            HoldOn.close();
        }

        //function BindPACLogList(PACLogList) {
        //    $("#TBodyPACLog").empty();
        //    var Tr = "<tr>{TRCONTENT}</tr>";
        //    var Td = "<td {STYLE}>{TDCCONTENT}</td>";
        //    $.grep(PACLogList, function (a) {
        //        var RplModeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.ACTION);
        //        var RplUserTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.USERID);
        //        var RplCreatedOnTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.LOGDATE);
        //        var RplCreatedAtTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.LOGTIME);
        //        var RplTr = Tr.replace("{TRCONTENT}", (RplModeTd + RplUserTd + RplCreatedOnTd + RplCreatedAtTd));
        //        $("#TBodyPACLog").append(RplTr);
        //    });
        //}

        function BindPACLogList(PACLogList) {
            debugger;
            $("#TBodyPACLog").empty();
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCCONTENT}</td>";
            $.grep(PACLogList, function (a) {
                var TranNo = $("#txtPAC").val();
                var RplIcon = "<i class='fa fa-eye IFrameEyeIcon' onclick=\"openLogIframe('" + TranNo + "','" + a.ACTION + "','" + a.LOGDATE + "','" + a.LOGTIME + "')\"></i>";
                var RplIconTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", RplIcon);
                var RplModeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.ACTION);
                var RplUserTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.USERID);
                var RplCreatedOnTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.LOGDATE);
                var RplCreatedAtTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.LOGTIME);
                var RplTr = Tr.replace("{TRCONTENT}", (RplIconTd + RplModeTd + RplUserTd + RplCreatedOnTd + RplCreatedAtTd));
                $("#TBodyPACLog").append(RplTr);
            });
        }

        //Enable Disable Textbox Based Checkbox
        function EnDisChkTextbox(ChkId, TextBoxId) {
            if ($("#" + ChkId).prop("checked") == true) {
                $("#" + TextBoxId).prop("readonly", false);
            }
            else {
                $("#" + TextBoxId).prop("readonly", true);
                $("#" + TextBoxId).val("");
            }
            toggleSwitchLabel(ChkId)
        }
        function toggleSwitchLabel(checkbox) {
            var label = document.getElementById(checkbox).nextElementSibling.querySelector(".switch-label");
            if (document.getElementById(checkbox).checked) {
                label.textContent = "Yes";
                label.style.left = "5px";
                label.style.textAlign = "left";
                label.style.right = "";
            }
            else {
                label.textContent = "No";
                label.style.left = "";
                label.style.textAlign = "right";
                label.style.right = "10px";
            }
        }


        $(document).on("click", "#ChkVisitYN", function (e) {
            e.stopPropagation();
            toggleSwitchLabel(this.id);
            EnableVisitContent();

        });

        $(document).on("click", "#ChkPACYN", function (e) {
            e.stopPropagation();
            toggleSwitchLabel(this.id);
            EnablePACContent();

        });
    </script>

     <%--PAC Print--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).on("click", "#btnPACSelectAll", function () {
                $("#SelectListToPACPrintSection input[type='checkbox']")
                    .prop("checked", true);
            });

            $(document).on("click", "#chkAll", function () {
                $("#SelectListToPACPrintSection input[type='checkbox']")
                    .prop("checked", this.checked);
            });

            $(document).on("click", "#btnPACClearAll", function () {
                $("#SelectListToPACPrintSection input[type='checkbox']")
                    .prop("checked", false);
            });
        });

        //function GetPACPrintView() {

        //    var html = "";

        //    /*html += "<div class='container-fluid mt-3' id='SelectListToPACPrintSection'>";*/
        //    html += "<div class='container-fluid mt-3' id='SelectListToPACPrintSection' style='max-height:none; overflow-y: visible;'>";
        //    html += "<div class='d-flex justify-content-between align-items-center mb-3'>";
        //    html += "<h5 class='fw-bold mb-0'>Select list to print</h5>";
        //    html += "<div class='btn-group btn-group-sm'>";
        //    html += "<button type='button' class='btn btn-outline-secondary' id='btnPACSelectAll'>Select All</button>";
        //    html += "<button type='button' class='btn btn-outline-secondary' id='btnPACClearAll'>Clear</button>";
        //    html += "</div>";
        //    html += "</div>";

        //    //html += "<div class='row'>";
        //    html += "<div class='row g-2'>";

        //    function createCheckbox(id, label) {
        //        return "<div class='col-12 col-md-6 mb-3'>" +
        //            "<div class='form-check'>" +
        //            "<input type='checkbox' id='" + id + "' class='form-check-input'>" +
        //            "<label class='form-check-label ms-2' for='" + id + "'>" + label + "</label>" +
        //            "</div>" +
        //            "</div>";
        //    }

        //    //html += createCheckbox("chkAll", "All");
        //    //html += createCheckbox("chkPatientInfo", "Patient Info");
        //    html += createCheckbox("chkSurgeryDiagnosis", "Advised Surgery and Diagnosis");
        //    html += createCheckbox("chkGeneralExam", "General Physical Examination");
        //    html += createCheckbox("chkComorbidities", "Comorbidities & Treatment History");
        //    html += createCheckbox("chkSubstanceAbuse", "Substance Abuse History");
        //    html += createCheckbox("chkAirway", "Airway Assessment");
        //    html += createCheckbox("chkSystemicExam", "Systemic Examination");
        //    html += createCheckbox("chkARISCAT", "ARISCAT Criteria");
        //    html += createCheckbox("chkRevisedLee", "Revised Lee Cardiac Risk");
        //    html += createCheckbox("chkChildPugh", "Child Pugh Turcotte Score");
        //    html += createCheckbox("chkASA", "ASA");
        //    html += createCheckbox("chkAnaesthesiaPlan", "Anaesthesia Plan");
        //    html += createCheckbox("chkVitalSigns", "Patient Vital Signs and Measurements");
        //    html += createCheckbox("chkInvestigations", "Investigations");
        //    html += createCheckbox("chkSpecialityReference", "Speciality Reference");
        //    html += createCheckbox("chkPreOpOrders", "Anaesthesiologist’s Advice & Preoperative Orders");
        //    html += createCheckbox("chkMedicine", "Medicine");
        //    html += createCheckbox("PrintSpecialityRef", "Print with Speciality Reference");
        //    html += createCheckbox("PrintPACInvstResult", "Print with Investigation Result");

        //    html += "</div>";

        //    html += "<div class='text-center mt-4'>";
        //    html += "<button type='button' class='btn btn-outline-success px-4' " +
        //        "style='min-width:250px;' onclick='PrintPAC();'>Print</button>";
        //    html += "</div>";

        //    html += "</div>";

        //    return html;
        //}

        function GetPACPrintView() {
            var html = "";

            html += "<div class='container-fluid d-flex flex-column' " +
                "id='SelectListToPACPrintSection' style='height:500px; border:1px solid #ccc;'>";

            html += "<div class='d-flex justify-content-between align-items-center mb-3 flex-shrink-0' " +
                "style='background:#fff; padding:0.5rem 0; z-index:10;'>";
            html += "<h5 class='fw-bold mb-0'>Select list to print</h5>";
            html += "<div class='btn-group btn-group-sm'>";
            html += "<button type='button' class='btn btn-outline-secondary' id='btnPACSelectAll'>Select All</button>";
            html += "<button type='button' class='btn btn-outline-secondary' id='btnPACClearAll'>Clear</button>";
            html += "</div>";
            html += "</div>";

            html += "<div class='flex-grow-1' style='overflow-y:auto; overflow-x:hidden;'>";
            html += "<div class='row g-2 flex-wrap'>";

            function createCheckbox(id, label, checked = false, hidden = false) {
                var style = hidden ? "style='display:none;'" : "";
                var chk = checked ? "checked" : "";
                return "<div class='col-12 col-md-6 mb-3' " + style + ">" +
                    "<div class='form-check'>" +
                    "<input type='checkbox' id='" + id + "' class='form-check-input' " + chk + ">" +
                    "<label class='form-check-label ms-2' for='" + id + "'>" + label + "</label>" +
                    "</div>" +
                    "</div>";
            }

            html += createCheckbox("chkAll", "All", false, true);
            html += createCheckbox("chkPatientInfo", "Patient Info", true, true);

            html += createCheckbox("chkSurgeryDiagnosis", "Advised Surgery and Diagnosis");
            html += createCheckbox("chkGeneralExam", "General Physical Examination");
            html += createCheckbox("chkComorbidities", "Comorbidities & Treatment History");
            html += createCheckbox("chkSubstanceAbuse", "Substance Abuse History");
            html += createCheckbox("chkAirway", "Airway Assessment");
            html += createCheckbox("chkSystemicExam", "Systemic Examination");
            html += createCheckbox("chkARISCAT", "ARISCAT Criteria");
            html += createCheckbox("chkRevisedLee", "Revised Lee Cardiac Risk");
            html += createCheckbox("chkChildPugh", "Child Pugh Turcotte Score");
            html += createCheckbox("chkASA", "ASA");
            html += createCheckbox("chkAnaesthesiaPlan", "Anaesthesia Plan");
            html += createCheckbox("chkVitalSigns", "Patient Vital Signs and Measurements");
            html += createCheckbox("chkInvestigations", "Investigations");
            html += createCheckbox("chkSpecialityReference", "Speciality Reference");
            html += createCheckbox("chkPreOpOrders", "Anaesthesiologist’s Advice & Preoperative Orders");
            html += createCheckbox("chkMedicine", "Medicine");
            html += createCheckbox("PrintSpecialityRef", "Print with Speciality Reference");
            html += createCheckbox("PrintPACInvstResult", "Print with Investigation Result");
            //Abhishesh || 20260720
            var defaultLetterHeadYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PACDEFAULTLETTER")%>';
            html += createCheckbox("chkheader", "Print With LetterHead", defaultLetterHeadYN == "Y", true);
            //End
            html += "</div>";
            html += "</div>";

            html += "<div class='text-center mt-2 flex-shrink-0' style='padding:0.5rem 0; background:#fff; z-index:10;'>";
            html += "<button type='button' class='btn btn-outline-success px-4' " +
                "style='min-width:250px;' onclick='PrintPAC();'>Print</button>";
            html += "</div>";

            html += "</div>";

            return html;
        }
    </script>
    <style>
        /* Mobile optimization: Stack elements vertically on very small screens */
    @media (max-width: 576px) {
        #MainDivTranInfo {
            width: 100%; /* Forces the transaction info to its own line if needed */
            justify-content: flex-start;
            
        }
        
        #MainDivTranInfo input {
            flex-grow: 1; /* Inputs will fill the remaining space on mobile */
        }
        .checkboxinputfield{
            width:30px;
        }
    }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            UpdateCurrDateTime(); // Abhishesh || 20260525
            EnDisAnesthesiaType();
            document.getElementById("PACForm_BackBtn").addEventListener("click", function () {
                window.location.href = "../SinglePage/WaitingListPAC";
            });
        });
        

    </script>
   <%-- PAC Modified Records --%>

    <style type="text/css">
        .iframeMain {
            position: fixed;
            top: 60px;
            left: 60px;
            width: calc(100vw - 120px);
            height: calc(100vh - 120px);
            background: #ffffff;
            z-index: 1000000;
            display: flex;
            flex-direction: column;
            border: 1px solid #777;
            box-sizing: border-box;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.35);
            overflow: hidden;
        }

        .iframeHeader {
            width: 100%;
            height: 40px;
            min-height: 40px;
            background-color: #064b7a;
            display: flex;
            align-items: center;
            padding: 0 6px;
            color: #ffffff;
            font-size: 14px;
            font-weight: bold;
            box-sizing: border-box;
            border-bottom: 1px solid #cccccc;
            cursor: default;
        }

            .iframeHeader label {
                flex: 1 1 auto;
                min-width: 0;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                padding: 0 5px 0 2px;
                color: #ffffff;
                line-height: 40px;
                box-sizing: border-box;
            }

        .iframe-controls {
            flex: 0 0 auto;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            height: 40px;
        }

        .IFrameIcon {
            width: 27px;
            height: 27px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0;
            margin: 0;
            color: #ffffff;
            font-size: 17px;
            cursor: pointer;
            border-radius: 3px;
            box-sizing: border-box;
            flex: 0 0 27px;
            line-height: 27px;
        }

            .IFrameIcon:hover {
                background-color: rgba(255, 255, 255, 0.20);
            }

        .iframeContainer {
            flex: 1 1 auto;
            width: 100%;
            height: auto;
            min-height: 0;
            overflow: hidden;
            background: #ffffff;
        }


        .myIframe {
            display: block;
            width: 100%;
            height: 100%;
            border: none;
            visibility: hidden;
        }

        .iframeMain.maximized {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            right: auto !important;
            bottom: auto !important;
            width: 100vw !important;
            height: 100vh !important;
            border-radius: 0 !important;
            overflow: hidden !important;
        }

            .iframeMain.maximized .iframeHeader {
                width: 100%;
            }

        .iframeMain,
        .iframeMain.minimized,
        .iframeMain.maximized,
        .iframeHeader,
        .iframeContainer {
            box-sizing: border-box;
        }

        #minimizedIframeBar {
            position: fixed;
            left: 10px;
            right: 10px;
            bottom: 10px;
            height: 55px;
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            gap: 5px;
            overflow-x: auto;
            overflow-y: hidden;
            z-index: 20000000;
            box-sizing: border-box;
            padding: 0 0 10px 0;
            white-space: nowrap;
        }

            #minimizedIframeBar::-webkit-scrollbar {
                height: 10px;
            }

            #minimizedIframeBar::-webkit-scrollbar-track {
                background: #d0d0d0;
                border-radius: 5px;
            }

            #minimizedIframeBar::-webkit-scrollbar-thumb {
                background: #666;
                border-radius: 5px;
            }

                #minimizedIframeBar::-webkit-scrollbar-thumb:hover {
                    background: #333;
                }

        .iframeMain.minimized {
            position: relative !important;
            flex: 0 0 230px !important;
            width: 230px !important;
            min-width: 230px !important;
            max-width: 230px !important;
            height: 40px !important;
            top: auto !important;
            left: auto !important;
            right: auto !important;
            bottom: auto !important;
            display: flex !important;
            flex-direction: column !important;
            overflow: hidden !important;
            box-sizing: border-box !important;
            border-radius: 2px;
            margin: 0 !important;
        }
    </style>

    <script type="text/javascript">
        var PacHistListDtls = [];
        var iframeZIndex = 1000000;
        var PACHistList = '<%:Html.Raw(Model.PACHistListData)%>';
        PACHistList = PACHistList.replace(/\r?\n/g, "\\n");
        PACHistList = PACHistList !== "" ? JSON.parse(PACHistList) : [];

        $(document).ready(function () {
            document.addEventListener("mousedown",
                function (e) {
                    var iframeMain = e.target.closest(".iframeMain");
                    if (!iframeMain) {
                        return;
                    }
                    bringIframeToFront(iframeMain);
                }
            );

            var minimizedBar = document.getElementById("minimizedIframeBar");

            if (minimizedBar) {
                minimizedBar.addEventListener("wheel", function (e) {

                    if (this.scrollWidth > this.clientWidth) {

                        e.preventDefault();

                        this.scrollLeft += e.deltaY;
                    }

                }, { passive: false });
            }
        });

        function bringIframeToFront(iframeMain) {
            iframeZIndex++;
            iframeMain.style.zIndex = iframeZIndex;
        }

        function openLogIframe(TranNo, Type, LogDT, LogTM) {
            var minimizedBar = document.getElementById("minimizedIframeBar");

            if (minimizedBar) {
                minimizedBar.style.display = "flex";
            }

            var datePart = (LogDT || "").trim().replace(/[^a-zA-Z0-9]/g, "");
            var timePart = (LogTM || "").trim().replace(/[^a-zA-Z0-9]/g, "");
            var typePart = (Type || "").trim().replace(/[^a-zA-Z0-9]/g, "");
            var uniqueId = datePart + "_" + timePart + "_" + typePart;

            if (uniqueId === "__") {
                uniqueId = Date.now().toString();
            }

            var mainId = "iframeMain_" + uniqueId;
            var headerId = "iframeHeader_" + uniqueId;
            var labelId = "PACHistFrameLbl_" + uniqueId;
            var containerId = "iframeContainer_" + uniqueId;
            var iframeId = "myIframe_" + uniqueId;
            var existing = document.getElementById(mainId);

            if (existing) {
                existing.style.display = "flex";
                if (existing.classList.contains("minimized")) {
                    restoreIframe(mainId);
                }
                else {
                    bringIframeToFront(existing);
                }
                return;
            }

            var iframeMain = document.createElement("div");
            iframeMain.id = mainId;
            iframeMain.className = "iframeMain";
            var iframeHeader = document.createElement("div");
            iframeHeader.id = headerId;
            iframeHeader.className = "iframeHeader";

            var label = document.createElement("label");
            label.id = labelId;

            label.innerText = (LogDT.trim() === "" || LogTM.trim() === "" ? "" : " (" + LogDT.trim() + " " + LogTM.trim() + ")");

            var controls = document.createElement("div");
            controls.className = "iframe-controls";

            var minimizeIcon = document.createElement("i");
            minimizeIcon.className = "fa fa-minus-circle IFrameIcon";
            minimizeIcon.setAttribute("aria-hidden", "true");
            minimizeIcon.title = "Minimize";
            minimizeIcon.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                minimizeLogIframe(mainId);
            };

            var maximizeIcon = document.createElement("span");
            maximizeIcon.className = "fa fa-square-o IFrameIcon";  //maximizeIcon
            maximizeIcon.title = "Maximize";
            maximizeIcon.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                toggleMaximizeIframe(mainId);
            };

            var closeIcon = document.createElement("i");
            closeIcon.className = "fa fa-times-circle IFrameIcon";
            closeIcon.setAttribute("aria-hidden", "true");
            closeIcon.title = "Close";

            closeIcon.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                closeLogIframe(mainId);
            };

            controls.appendChild(minimizeIcon);
            controls.appendChild(maximizeIcon);
            controls.appendChild(closeIcon);
            iframeHeader.appendChild(label);
            iframeHeader.appendChild(controls);


            iframeHeader.onclick = function (e) {
                if (e.target.closest(".IFrameIcon")) {
                    return;
                }
                if (iframeMain.classList.contains("minimized")) {
                    restoreIframe(mainId);
                    return;
                }
                bringIframeToFront(iframeMain);
            };

            var iframeContainer = document.createElement("div");
            iframeContainer.id = containerId;
            iframeContainer.className = "iframeContainer";

            var iframe = document.createElement("iframe");
            iframe.id = iframeId;
            iframe.className = "myIframe";
            iframe.src = "../SinglePage/PAC" + "?PatMRNO=" + encodeURIComponent(MRNo) + "&PatTRANNO=" + encodeURIComponent(TranNo) + "&Gaction=D" + "&MasterPage=N" + "&LOGYN=Y" +
                "&Type=" + encodeURIComponent(Type) + "&LogDT=" + encodeURIComponent(LogDT) + "&LogTM=" + encodeURIComponent(LogTM);

            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            iframe.style.visibility = "hidden";
            iframe.onload = function () {
                var code = iframe.contentWindow.gDoctCode;
                if (!code || code.trim() === "") {
                    iframeContainer.style.display = "none";
                    HoldOn.close();
                    window.location.href = "../Account/Login";
                    return;
                }

                var iframeDoc = iframe.contentWindow.document;
                var $secCont = $(iframeDoc).find("#secCont");

                $(iframeDoc).find(".main-header").hide();
                $(iframeDoc).find(".header_container").hide();
                $(iframeDoc).find("#MainDivBtnGrp").hide();
                $(iframeDoc).find("#InvestRpt").hide();
                $(iframeDoc).find("#content").css("padding", "0px");
                $(iframeDoc).find("#MainDiv")[0].style.setProperty("height", "100vh", "important");
                $(iframeDoc).find(".sticky-top").hide();

                $secCont.attr("style",
                    function (i, s) {
                        return (s || "") + "min-height:0px !important;" + "margin-left:0px !important;" + "padding:0px !important;" + "width:100% !important;";
                    }
                );
                $(iframeDoc).find("#MainSectRightMenu").css("display", "none", "important");
                $(iframeDoc).find("#DivVisitTab").css("display", "none", "important");
                $(iframeDoc).find("#MainDivAAPO").css("display", "none", "important");
                $(iframeDoc).find("#MainDivINVST").css("display", "none", "important");
                $(iframeDoc).find("#MainDivSPCREF").css("display", "none", "important");
                $(iframeDoc).find("#MainDivMedicine").css("display", "none", "important");
                iframe.style.visibility = "visible";
                iframe.style.display = "block";
                HoldOn.close();
            };

            iframeContainer.appendChild(iframe);
            iframeMain.appendChild(iframeHeader);
            iframeMain.appendChild(iframeContainer);
            document.body.appendChild(iframeMain);

            bringIframeToFront(iframeMain);

            HoldOn.open();
        }

        function minimizeLogIframe(mainId) {
            var iframeMain = document.getElementById(mainId);
            if (!iframeMain) {
                return;
            }
            if (iframeMain.classList.contains("minimized")) {
                return;
            }
            iframeMain.classList.remove("maximized");
            iframeMain.classList.add("minimized");
            var minimizeIcon = iframeMain.querySelector(".fa-minus-circle");
            var maximizeIcon = iframeMain.querySelector(".fa-square-o");
            if (minimizeIcon) {
                minimizeIcon.style.display = "none";
            }
            if (maximizeIcon) {
                maximizeIcon.style.display = "inline-flex";
                maximizeIcon.style.fontWeight = "bold";
            }
            var minimizedBar = document.getElementById("minimizedIframeBar");

            if (minimizedBar) {
                minimizedBar.appendChild(iframeMain);
            }
            bringIframeToFront(iframeMain);
        }

        function restoreIframe(mainId) {
            var iframeMain = document.getElementById(mainId);
            if (!iframeMain) {
                return;
            }

            if (iframeMain.parentElement &&
                iframeMain.parentElement.id === "minimizedIframeBar") {

                document.body.appendChild(iframeMain);
            }
            iframeMain.classList.remove("minimized");
            iframeMain.classList.remove("maximized");
            iframeMain.style.position = "fixed";
            iframeMain.style.top = "60px";
            iframeMain.style.left = "60px";
            iframeMain.style.right = "auto";
            iframeMain.style.bottom = "auto";
            iframeMain.style.width = "calc(100vw - 120px)";
            iframeMain.style.height = "calc(100vh - 120px)";

            var iframeContainer = iframeMain.querySelector(".iframeContainer");

            if (iframeContainer) {
                iframeContainer.style.display = "block";
                iframeContainer.style.visibility = "visible";
            }

            var iframe = iframeMain.querySelector(".myIframe");

            if (iframe) {
                iframe.style.display = "block";
                iframe.style.visibility = "visible";
                iframe.style.width = "100%";
                iframe.style.height = "100%";
            }

            var minimizeIcon = iframeMain.querySelector(".fa-minus-circle");
            var maximizeIcon = iframeMain.querySelector(".fa-square-o");

            if (minimizeIcon) {
                minimizeIcon.style.display = "inline-flex";
            }

            if (maximizeIcon) {
                maximizeIcon.style.display = "inline-flex";
                maximizeIcon.style.fontWeight = "bold";
            }
            bringIframeToFront(iframeMain);
        }

        function toggleMaximizeIframe(mainId) {
            var iframeMain = document.getElementById(mainId);
            if (!iframeMain) {
                return;
            }
            if (iframeMain.classList.contains("minimized")) {
                restoreIframe(mainId);
                return;
            }
            if (iframeMain.classList.contains("maximized")) {
                iframeMain.classList.remove("maximized");
                iframeMain.style.position = "fixed";
                iframeMain.style.top = "60px";
                iframeMain.style.left = "60px";
                iframeMain.style.right = "auto";
                iframeMain.style.bottom = "auto";
                iframeMain.style.width = "calc(100vw - 120px)";
                iframeMain.style.height = "calc(100vh - 120px)";

                bringIframeToFront(iframeMain);
                return;
            }

            iframeMain.classList.add("maximized");
            iframeMain.style.position = "fixed";
            iframeMain.style.top = "0";
            iframeMain.style.left = "0";
            iframeMain.style.right = "auto";
            iframeMain.style.bottom = "auto";
            iframeMain.style.width = "100vw";
            iframeMain.style.height = "100vh";
            bringIframeToFront(iframeMain);
        }

        function closeLogIframe(mainId) {
            var iframeMain = document.getElementById(mainId);
            if (!iframeMain) {
                return;
            }
            iframeMain.remove();
        }
    </script>
</asp:Content>
