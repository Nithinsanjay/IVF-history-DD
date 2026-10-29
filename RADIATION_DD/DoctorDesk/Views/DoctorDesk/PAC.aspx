<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.PACMdl>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="MainDiv">
        <div id="ContentHolderDiv">
            <%-- Form Header --%>

            <div class="row">
                <div style="display: flex; align-items: center; justify-content: space-between; background-color: #022548; padding: 5px 0px; color: white;">
                    <label class="MDHeaderLbl" style="width: auto !important;">Pre-Anesthetic Checkup</label>

                    <div id="MainDivTranInfo" style="display: flex;margin-right: 14px;">
                            <div>
                                <label style="width: 60px;">Tran No :</label>
                                <input type="text" style="color: black;margin-right: 15px;" id="txtPAC" readonly />
                            </div>
                            <div>
                                <label style="width: 60px;">Tran Date :</label>
                                <input type="text" style="color: black;" id="txtPACDate" readonly />
                            </div>
                        </div>
                </div>
            </div>
            <div class="row">
                <div style="display: flex;align-items: center;justify-content: space-between;padding: 5px 0px;color: white;background: azure;justify-content: flex-end;">
                    <%--<label class="MDHeaderLbl" style="width: auto !important;">Pre-Anesthetic Checkup</label>--%>
                    <div class="HeaderBtnIcon" style="display: flex; flex-wrap: wrap;">
                        <%--<div id="MainDivTranInfo" style="display: flex;">
                            <div>
                                <label style="width: 60px;">Tran No :</label>
                                <input type="text" style="color: black;" id="txtPAC" readonly />
                            </div>
                            <div>
                                <label style="width: 60px;">Tran Date :</label>
                                <input type="text" style="color: black;" id="txtPACDate" readonly />
                            </div>
                        </div>--%>
                        
                        <div style="display: flex;">
                            <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;" id="previousPrep">DICOM</button>
                        </div>
                         <div style="display: flex;"> <%--Priyanka 20/11/2025--%>
                            <button type="button" class="btn btn-success" style="padding: 3px 10px; margin-right: 10px;" id="CancerCareHist">Cancer Care History</button>
                        </div>
                        <div style="display: flex;">
                            <button type="button" class="btn btn-success" style="padding: 3px 10px; margin-right: 10px;" id="InvestRpt">Invest. Report</button>
                        </div>
                        <label id="PersMedi" style="background-color:transparent; border-color: transparent; display: none" title="Save" onclick="CreatePersonalList()" class="PersBtn">
                            <button type="button" class="btn btn-info margin" style="padding: 2px 12px; font-size: 14px; margin: 0; margin-right: 10px;" data-prokeyscachednode="false">Setup</button>
                        </label>
                        <div id="PrintDiv_Top" style="display: none; align-items: center;">
                            <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;" id="BtnPrint_Top" onclick="PrintPAC('Y')">Print</button>
                        </div>
                        <div id="PACHistory" style="display: none; align-items: center;">
                            <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;" id="BtnPACHistory" onclick="OpenClosePACHistory()">History</button>
                        </div>
                        <div id="PACLogInfo" style="display: none; align-items: center; ">
                            <button type="button" class="btn btn-success" style="min-width: 70px; padding: 3px 10px;margin-left: 10px;" id="BtnPACLogInfo" onclick="OpenClosePACLogInfo()">Log Info</button>
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
                        <i class="fa fa-chevron-circle-down DownArrow" id="PatInfoDown" onclick="ToggleDiv(this.id,'PatInfoUp','DivContentPatInfo','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="PatInfoUp" onclick="ToggleDiv(this.id,'PatInfoDown','DivContentPatInfo','N')" style="display: none" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentPatInfo">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">MR No.</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACMRNO" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Patient Name</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACPatName" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Age</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACPatAge" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Gender</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACPatGen" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Admitting Doctor</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtPACAdmDoct" readonly />
                                    <input type="text" class="form-control" id="txtPACAdmDoctCode" style="display: none" readonly />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Weight</label>
                                <div class="col-xs-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" maxlength="5" class="form-control" id="txtPACWeight" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">Kg</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Height</label>
                                <div class="col-xs-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" maxlength="5" class="form-control" id="txtPACHeight" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">Cm</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">BMI</label>
                                <div class="col-xs-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Surgery Planned</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtPACProcdPlanCode" readonly style="display: none" />
                                    <textarea class="form-control" style="resize: none" id="txtPACProcdPlan" onchange="autoResize(this.id)" readonly></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Scheduled Date of Surgery</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtPACSchSurg" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Nature of Surgery</label>
                                <div class="col-xs-8 FieldDiv">
                                    <div class="RadioDiv">
                                        <input type="radio" name="PACNATSURG" id="rbtnPACNATSURGR" disabled />
                                        <label for="rbtnPACNATSURGR" class="RadioLbl">Routine</label>
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

                        <div class="col-xs-12">
                            <fieldset style="background-color: white; padding-bottom: 10px;">
                                <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">ICD Diagnosis</legend>
                                <div class="MedicineDiv table-responsive" style="width: 100%">
                                    <table id="TableICD" class="table table-bordered table-striped MedicineTbl">
                                        <thead>
                                            <tr>
                                                <th style="width: 150px">Code</th>
                                                <th>Description</th>
                                            </tr>
                                        </thead>
                                        <tbody id="TableICDTBody"></tbody>
                                    </table>
                                </div>
                            </fieldset>
                        </div>

                        <div class="col-xs-12">
                            <fieldset style="background-color: white; padding-bottom: 10px;">
                                <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">ICD-O Diagnosis</legend>
                                <div class="MedicineDiv table-responsive" style="width: 100%">
                                    <table id="TableICDO" class="table table-bordered table-striped MedicineTbl">
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
                        <i class="fa fa-chevron-circle-down DownArrow" id="PVSMDown" onclick="ToggleDiv(this.id,'PVSMUp','DivContentPVSM','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="PVSMUp" onclick="ToggleDiv(this.id,'PVSMDown','DivContentPVSM','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentPVSM">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Date</label>
                                <div class="col-xs-8 FieldDiv" style="justify-content: space-between;flex-wrap: nowrap;    align-items: center;">
                                    <input type="text" class="form-control" id="txtPVSMDate" onchange="MakeNormal(this.id);" style="width: 100px;" readonly />
                                    <span style="font-weight:900">-</span>
                                    <input type="time" id="txtPVSMTime" class="form-control" style="width: 105px;padding: 5px;" onchange="MakeNormal(this.id);" />
<%--                                    <input type="text" class="form-control" id="txtPVSMTime" onchange="MakeNormal(this.id);" style="width: 100px;" readonly />--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Temp</label>
                                <div class="col-xs-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="form-control" id="txtPVSMTemp" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">°F</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Pulse</label>
                                <div class="col-xs-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="form-control" id="txtPVSMPulse" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">bpm</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Blood Pressure</label>
                                <div class="col-xs-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="triggerInputBP form-control input-form-control form-control" style="min-width: 55px;" id="txtPVSMBldPrs1" onchange="MakeNormal(this.id);" />
                                    <label style="margin: 0px 10px !important; font-size: 25px; font-weight: bold;">/</label>
                                    <input type="text" class="triggerInputBP form-control input-form-control form-control" style="min-width: 55px;" id="txtPVSMBldPrs2" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd" style="border-radius: 5px; margin-left: 5px;">mmHg</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">SpO2</label>
                                <div class="col-xs-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="form-control" id="txtPVSMSPO" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">%</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Breath Holding Time</label>
                                <div class="col-xs-8 FieldDiv" style="align-items: stretch; flex-wrap: nowrap;">
                                    <input type="text" class="form-control" id="txtPVSMBrthTime" style="border-top-right-radius: 0px; border-bottom-right-radius: 0px;" onchange="MakeNormal(this.id);" />
                                    <span class="MeasureInd">SEC</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
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
                                                        Pain Free</label></td>
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

                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv" style="justify-content: center;">
                                <button type="button" class="btn btn-primary" id="BtnVitalsAdd" onclick="ValidationForAddVitalsTable('N')">Add</button>
                                <button type="button" class="btn btn-primary" style="display: none;" id="BtnVitalsUpdate" onclick="ValidationForAddVitalsTable('E')">Update</button>
                                <button type="button" class="btn btn-primary" style="margin-left: 20px; display: none;" id="BtnVitalsClear" onclick="CleartPatVitalMsrmntInfo()">Clear</button>
                            </div>
                        </div>

                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
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
                        <i class="fa fa-chevron-circle-down DownArrow" id="GPEDown" onclick="ToggleDiv(this.id,'GPEUp','DivContentGPE','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="GPEUp" onclick="ToggleDiv(this.id,'GPEDown','DivContentGPE','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentGPE">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">General Condition</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Breathing Pattern</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px; display: none">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Breathing Remark</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtGPEBreathRemark" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Respiratory Rate(BPM)</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtGPERR" onchange="MakeNormal(this.id);CheckNotif('txtGPERR',10,30,true);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Orientation</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Pallor</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEPALL" onclick="EnDisChkTextbox(this.id, 'txtCPTPallor')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTPallor" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Icterus</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEICET" onclick="EnDisChkTextbox(this.id, 'txtCPTIcterus')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTIcterus" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Cyanosis</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPECYAN" onclick="EnDisChkTextbox(this.id, 'txtCPTCyanosis')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTCyanosis" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Clubbing</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPECLUB" onclick="EnDisChkTextbox(this.id, 'txtCPTClubbing')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTClubbing" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>

                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Lymphadenopathy</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPELYMP" onclick="EnDisChkTextbox(this.id, 'txtCPTLymphadenopathy')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" class="form-control ml-2" id="txtCPTLymphadenopathy" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Pedal EDEMA</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Hydration Status</label>
                                <div class="col-xs-8 FieldDiv">
                                    <select id="cmbCPTHydrationStatus" class="form-control" onchange="EnDisTextCombo('cmbCPTHydrationStatus','txtHydraStatusOther')">
                                        <option value="">---Select---</option>
                                        <option value="W">Well hydrated</option>
                                        <option value="D">Dehydrated</option>
                                        <option value="O">Other</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Hydration Status Other</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtHydraStatusOther" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Venous Access</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">METS</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Functional Capacity</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">LRTI</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPELRTI" onclick="EnDisChkTextbox(this.id, 'txtCPTLRTI')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" class="form-control ml-2" id="txtCPTLRTI" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">URTI</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEURTI" onclick="EnDisChkTextbox(this.id, 'txtCPTURTI')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCPTURTI" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Fever</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Pre-Anaesthesia Evaluation History</label>
                                <div class="col-xs-8 FieldDiv d-flex">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEPREANAHIST" onclick="EnDisChkTextbox(this.id, 'txtCPTPREANAEVALHIST')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <textarea maxlength="100" class="form-control ml-2" style="flex: 1; margin-left: 5px; resize: none;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtCPTPREANAEVALHIST"></textarea>
                                </div>
                            </div>
                        </div>
<%--                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv" style="align-items: center;">
                                <label class="col-form-label" style="padding-right: 15px;padding-left: 15px;">Pre-Anaesthesia Evaluation History</label>
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkGPEPREANAHIST" onclick="EnDisChkTextbox(this.id, 'txtCPTPREANAEVALHIST')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                            </div>
                        </div>
                        <div class="col-xs-12" style="padding: 0px 15px 5px 10px;">
                            <div class="ContentFieldDiv">
                                <textarea class="form-control ml-2" style="flex: 1; margin-left: 5px; resize: none;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtCPTPREANAEVALHIST"></textarea>
                            </div>
                        </div>--%>
                    </div>
                </div>
            </div>

            <%-- Comorbidities & Treatment History --%>
            <div id="MainDivCTH">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('CTHUp', 'CTHDown', 'DivContentCTH')">Comorbidities & Treatment History</label>
                    <div class="ArrowDiv">
                        <i class="fa fa-chevron-circle-down DownArrow" id="CTHDown" onclick="ToggleDiv(this.id,'CTHUp','DivContentCTH','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="CTHUp" onclick="ToggleDiv(this.id,'CTHDown','DivContentCTH','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentCTH">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Hypertension</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHHYP" onclick="EnDisChkTextbox(this.id, 'txtCTHHypert')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHHypert" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Diabetes Mellitus</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHDIABMEL" onclick="EnDisChkTextbox(this.id, 'txtCTHDiabMelt')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHDiabMelt" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Cardiac</label>
                                <div class="col-xs-8 FieldDiv">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHCARDI" id="rbtnCTHCARDI1" />
                                        <%--onclick="EnDisRadioOtherField('rbtnCTHCARDI4', 'txtCTHCardiothrs')"--%>
                                        <label for="rbtnCTHCARDI1" class="RadioLbl">IHD</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHCARDI" id="rbtnCTHCARDI2" />
                                        <%--onclick="EnDisRadioOtherField('rbtnCTHCARDI4', 'txtCTHCardiothrs')"--%>
                                        <label for="rbtnCTHCARDI2" class="RadioLbl">CHF</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHCARDI" id="rbtnCTHCARDI3" /><%-- onclick="EnDisRadioOtherField('rbtnCTHCARDI4', 'txtCTHCardiothrs')"--%>
                                        <label for="rbtnCTHCARDI3" class="RadioLbl">RHD</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHCARDI" id="rbtnCTHCARDI4" />
                                        <%-- onclick="EnDisRadioOtherField('rbtnCTHCARDI4', 'txtCTHCardiothrs')"--%>
                                        <label for="rbtnCTHCARDI4" class="RadioLbl">Others</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Cardiac Remark</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtCTHCardiothrs" onchange="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">NYHA</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">ECOG
                                    <i class="fa fa-question-circle InfoIconPopup" title="ARISCAT Information" onclick="OpenPopInfoGuide('E')" aria-hidden="true"></i>
                                </label>
                                <div class="col-xs-8 FieldDiv">
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
                    </div>
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Respiratory</label>
                                <div class="col-xs-8 FieldDiv">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHRESP" id="rbtnCTHRESP1" />
                                        <label for="rbtnCTHRESP1" class="RadioLbl">ASTHMA</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHRESP" id="rbtnCTHRESP2" />
                                        <label for="rbtnCTHRESP2" class="RadioLbl">TB</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHRESP" id="rbtnCTHRESP3" />
                                        <label for="rbtnCTHRESP3" class="RadioLbl">COPD</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">MMRC</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Nervous System</label>
                                <div class="col-xs-8 FieldDiv">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHNERVSYS" id="rbtnCTHNERVSYS1" />
                                        <%--onclick="EnDisRadioOtherField('rbtnCTHNERVSYS3', 'txtCTHNervSysOthrs')"--%>
                                        <label for="rbtnCTHNERVSYS1" class="RadioLbl">Epilepsy</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHNERVSYS" id="rbtnCTHNERVSYS2" />
                                        <%-- onclick="EnDisRadioOtherField('rbtnCTHNERVSYS3', 'txtCTHNervSysOthrs')"--%>
                                        <label for="rbtnCTHNERVSYS2" class="RadioLbl">Stroke</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHNERVSYS" id="rbtnCTHNERVSYS3" />
                                        <%--onclick="EnDisRadioOtherField('rbtnCTHNERVSYS3', 'txtCTHNervSysOthrs')"--%>
                                        <label for="rbtnCTHNERVSYS3" class="RadioLbl">Others</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Nervous System Remark</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtCTHNervSysOthrs" onchange="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                                            </div>
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Renal</label>
                                <div class="col-xs-8 FieldDiv">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHRENAL" id="rbtnCTHRENAL1" />
                                        <%--onclick="EnDisRadioOtherField('rbtnCTHRENAL3', 'txtCTHRENALOthrs')"--%>
                                        <label for="rbtnCTHRENAL1" class="RadioLbl">AKI</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHRENAL" id="rbtnCTHRENAL2" />
                                        <%--onclick="EnDisRadioOtherField('rbtnCTHRENAL3', 'txtCTHRENALOthrs')"--%>
                                        <label for="rbtnCTHRENAL2" class="RadioLbl">CKD</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHRENAL" id="rbtnCTHRENAL3" />
                                        <%--onclick="EnDisRadioOtherField('rbtnCTHRENAL3', 'txtCTHRENALOthrs')"--%>
                                        <label for="rbtnCTHRENAL3" class="RadioLbl">Others</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Renal - Remark</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtCTHRENALOthrs" onchange="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                                            </div>
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Thyroid Disorder</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHTHYDIS" onclick="EnDisChkTextbox(this.id, 'txtCTHThyroidDis')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHThyroidDis" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>

                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Chemotherapy</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHCHEMO" onclick="EnDisChkTextbox(this.id, 'txtCTHChemotherapy')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHChemotherapy" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Radiotherapy</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHRADIO" onclick="EnDisChkTextbox(this.id, 'txtCTHRadiotherapy')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHRadiotherapy" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Any H/O Surgeries</label>
                                <div class="col-xs-8 FieldDiv d-flex">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHANYSURG" onclick="EnDisChkTextbox(this.id, 'txtCTHAnyHOSurg')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1; margin-left: 5px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtCTHAnyHOSurg"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Blood Related</label>
                                <div class="col-xs-8 FieldDiv">
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHBLDREL" id="rbtnCTHBLDREL1" />
                                        <label for="rbtnCTHBLDREL1" class="RadioLbl">Anaemia</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="CTHBLDREL" id="rbtnCTHBLDREL2" />
                                        <label for="rbtnCTHBLDREL2" class="RadioLbl">H/o Transfusion / Disorders</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Drug Allergies / Snake Bite / Scorpion Sting Bite</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHBITE" onclick="EnDisChkTextbox(this.id, 'txtCTHBite')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtCTHBite" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Any Other Relevant Medical History</label>
                                <div class="col-xs-8 FieldDiv d-flex">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkCTHANYRELHIST" onclick="EnDisChkTextbox(this.id, 'txtCTHRelMedHist')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1; margin-left: 5px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtCTHRelMedHist"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12 FieldDiv">
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
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('SAHUp', 'SAHDown', 'DivContentSAH')">Substance Abuse History</label>
                    <div class="ArrowDiv">
                        <i class="fa fa-chevron-circle-down DownArrow" id="SAHDown" onclick="ToggleDiv(this.id,'SAHUp','DivContentSAH','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="SAHUp" onclick="ToggleDiv(this.id,'SAHDown','DivContentSAH','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentSAH">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Drugs</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtSAHDrugs" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Alcohol</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtSAHAlcohol" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Betal Nut</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtSAHBetalNut" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Tobacco</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtSAHTobacco" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Smoking</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtSAHSmoking" />
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
                        <i class="fa fa-chevron-circle-down DownArrow" id="AADown" onclick="ToggleDiv(this.id,'AAUp','DivContentAA','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="AAUp" onclick="ToggleDiv(this.id,'AADown','DivContentAA','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentAA">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">NARES</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Deviated Nasal Septum</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Mouth Opening</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Teeth</label>
                                <div class="col-xs-8 FieldDiv">
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATEETH" id="rbtnAATEETH1" />
                                        <label for="rbtnAATEETH1" class="RadioLbl">Normal</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATEETH" id="rbtnAATEETH2" />
                                        <label for="rbtnAATEETH2" class="RadioLbl">Edentulous</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATEETH" id="rbtnAATEETH3" />
                                        <label for="rbtnAATEETH3" class="RadioLbl">Protruding</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATEETH" id="rbtnAATEETH4" />
                                        <label for="rbtnAATEETH4" class="RadioLbl">Artificial</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATEETH" id="rbtnAATEETH5" />
                                        <label for="rbtnAATEETH5" class="RadioLbl">Buck</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="AATEETH" id="rbtnAATEETH6" />
                                        <label for="rbtnAATEETH6" class="RadioLbl">Loose Tooth</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Mallampati</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Mallampati Remark</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtAAMallRemark" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Jaw Sliding</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Trismus</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Thyromental Distance</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Neck</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" class="form-control" id="txtAANeck" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Spine</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtAASpine" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Tracheostomy</label>
                                <div class="col-xs-8 FieldDiv d-flex" style="align-items: center;">
                                    <label class="switch mb-0">
                                        <input type="checkbox" id="ChkAATRACH" onclick="EnDisChkTextbox(this.id, 'txtAATracheostomy')">
                                        <span class="slider"><span class="switch-label">No</span></span>
                                    </label>
                                    <input type="text" maxlength="100" class="form-control ml-2" id="txtAATracheostomy" style="flex: 1; margin-left: 5px;" onchange="MakeNormal(this.id);" onkeypress="MakeNormal(this.id);" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Airway Comments</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <i class="fa fa-chevron-circle-down DownArrow" id="SEDown" onclick="ToggleDiv(this.id,'SEUp','DivContentSE','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="SEUp" onclick="ToggleDiv(this.id,'SEDown','DivContentSE','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentSE">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Cardiovascular System</label>
                                <div class="col-xs-8 FieldDiv">
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1 1 0%; margin-left: 5px; height: 57px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtSECardiSys"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Respiratory System</label>
                                <div class="col-xs-8 FieldDiv">
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1 1 0%; margin-left: 5px; height: 57px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtSERespSys"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Abdominal System</label>
                                <div class="col-xs-8 FieldDiv">
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1 1 0%; margin-left: 5px; height: 57px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtSEAdboSys"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Central Nervous System</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <i class="fa fa-question-circle" style="font-size: 20px; margin-right: 10px; color: #0070ff; cursor: pointer;" title="ARISCAT Information" onclick='OpenPopInfoGuide("A")' aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-down DownArrow" id="ARISCATDown" onclick="ToggleDiv(this.id,'ARISCATUp','DivContentARISCAT','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="ARISCATUp" onclick="ToggleDiv(this.id,'ARISCATDown','DivContentARISCAT','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentARISCAT">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Age(yrs)</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Pre-op SpO2</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Respiratory Infection in Last 1 Month</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Pre-Op Hb</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Incision</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Surgery</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Emergency Procedure</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Total</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtARISCATTotal" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Risk Category</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtARISCATRiskCatg" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">PPC Rate</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <i class="fa fa-question-circle" style="font-size: 20px; margin-right: 10px; color: #0070ff; cursor: pointer;" title="Revised Lee Cardiac Risk Information" onclick='OpenPopInfoGuide("R")' aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-down DownArrow" id="RLCRFIDown" onclick="ToggleDiv(this.id,'RLCRFIUp','DivContentRLCRFI','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="RLCRFIUp" onclick="ToggleDiv(this.id,'RLCRFIDown','DivContentRLCRFI','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentRLCRFI">
                    <div class="row EachRow">
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Class</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtRSKFCTClass" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Major Cardiac Event</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtRSKFCTCardioEvnt" readonly />
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
                        <i class="fa fa-question-circle" style="font-size: 20px; margin-right: 10px; color: #0070ff; cursor: pointer;" title="Child Pugh Turcotte Score Information" onclick='OpenPopInfoGuide("C")' aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-down DownArrow" id="CPTSDown" onclick="ToggleDiv(this.id,'CPTSUp','DivContentCPTS','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="CPTSUp" onclick="ToggleDiv(this.id,'CPTSDown','DivContentCPTS','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentCPTS">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Encephalopathy</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Ascites</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Bilirubin (mg/dl)</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Albumin (gm/dl)</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">INR</label>
                                <div class="col-xs-8 FieldDiv">
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
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Class</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtCPTSClass" readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Points</label>
                                <div class="col-xs-8 FieldDiv">
                                    <input type="text" maxlength="100" class="form-control" id="txtCPTSPoints" readonly />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Investigations --%>
            <div id="MainDivINVST">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('INVSTUp', 'INVSTDown', 'DivContentINVST')">Investigations</label>
                    <div class="ArrowDiv" style="display: flex; justify-content: flex-end; align-items: center;">
                        <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;" id="BtnPrintInvst" onclick="PrintMultiEntryInvestigation()">Print</button>
                        <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;" id="BtnResultInvst" onclick="OpenResultEntryPopup()">Result</button>
                        <i class="fa fa-chevron-circle-down DownArrow" id="INVSTDown" onclick="ToggleDiv(this.id,'INVSTUp','DivContentINVST','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="INVSTUp" onclick="ToggleDiv(this.id,'INVSTDown','DivContentINVST','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentINVST">
                    <div class="row EachRow">
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12 col-md-6 FieldDiv" id="AdviceList">
                                    <fieldset class="InvstFieldSet">
                                        <legend class="InvstFieldSetLegend">Setup</legend>
                                        <div class="AdviListMainDiv" id="AdviceListOption">
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-xs-12 col-md-6 FieldDiv" id="InvstSearchList">
                                    <fieldset class="InvstFieldSet">
                                        <legend class="InvstFieldSetLegend">Investigation</legend>
                                        <input type="text" maxlength="100" id="txtSearchInvst" placeholder="Search Investigation" class="form-control" />
                                        <div id="DivSearchInvstList" style="max-width: 100%; display: none; margin-top: 0px; z-index: 100000; position: absolute; background-color: #fbfbfb; border: 1px solid black; padding: 0px 5px;"></div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12 FieldDiv" id="AdviceTestList">
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
                        <i class="fa fa-chevron-circle-down DownArrow" id="SPCREFDown" onclick="ToggleDiv(this.id,'SPCREFUp','DivContentSPCREF','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="SPCREFUp" onclick="ToggleDiv(this.id,'SPCREFDown','DivContentSPCREF','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentSPCREF">
                    <div class="row EachRow" id="SpecialityRefAddDiv"></div>

                    <div class="row EachRow">
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12 FieldDiv">
                                    <label class=" col-form-label">Other</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12 FieldDiv">
                                    <textarea maxlength="100" class="form-control" style="resize: none;" oninput="autoResize(this.id)" onchange="autoResize(this.id)" placeholder="" id="txtSPCREF"></textarea>
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
                        <i class="fa fa-chevron-circle-down DownArrow" id="APSDown" onclick="ToggleDiv(this.id,'APSUp','DivContentAPS','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="APSUp" onclick="ToggleDiv(this.id,'APSDown','DivContentAPS','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentAPS">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Physical Status</label>
                                <div class="col-xs-8 FieldDiv">
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
                                        <input type="radio" name="APSPHYSTS" id="rbtnAPSPHYSTS7" />
                                        <label for="rbtnAPSPHYSTS7" class="RadioLbl">E</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Remark</label>
                                <div class="col-xs-8 FieldDiv">
                                    <textarea maxlength="100" class="form-control" style="resize: none;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" placeholder="" id="txtASARemark"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Fitness Status</label>
                                <div class="col-xs-8 FieldDiv" style="flex-direction: column;">
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSFITSTS" id="rbtnAPSFITSTSF" onclick="UpdateCurrDateTime()" />
                                        <label for="rbtnAPSFITSTSF" class="RadioLbl">Yes</label>
                                    </div>
                                    <div class="RadioDiv">
                                        <input type="radio" name="APSFITSTS" id="rbtnAPSFITSTSW" onclick="UpdateCurrDateTime()" />
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
                                        <input type="radio" name="APSFITSTS" id="rbtnAPSFITSTSU" onclick="UpdateCurrDateTime()" />
                                        <label for="rbtnAPSFITSTSU" class="RadioLbl">No</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;display:none" id="DivReviewPAC">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Review</label>
                                <div class="col-xs-8 FieldDiv" style="flex-wrap: nowrap; align-items: center;">
                                    <input type="checkbox" id="ChkPACReview" onclick="PickTodayDate()" />
                                    <input type="text" class="form-control" id="txtPACReviewDate" style="margin-left: 15px;display:none" disabled readonly />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Date / Time</label>
                                <div class="col-xs-8 FieldDiv" style="justify-content: space-between;align-items: center;">
                                    <input type="text" class="form-control" id="txtAPSDate" style="width:45%;padding: 5px;" disabled />
                                    <label style="font-size: 18px;"> / </label>
                                    <input type="text" class="form-control" id="txtAPSTime" style="width:40%;padding: 5px;" disabled />
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
                        <i class="fa fa-chevron-circle-down DownArrow" id="AAPODown" onclick="ToggleDiv(this.id,'AAPOUp','DivContentAAPO','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="AAPOUp" onclick="ToggleDiv(this.id,'AAPODown','DivContentAAPO','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentAAPO">
                    <div class="row EachRow">
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12 FieldDiv">
                                    <textarea maxlength="100" class="form-control" style="resize: none;" onchange="autoResize(this.id)" oninput="autoResize(this.id)" id="txtAAPO"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Anaesthesia Plan --%>
            <div id="MainDivAnaestPlan">
                <div class="MainDivHeader row">
                    <label class="MDHeaderLbl" onclick="TriggerToggleDiv('ASPLANUp', 'ASPLANDown', 'DivContentASPLAN')">Anaesthesia Plan</label>
                    <div class="ArrowDiv">
                        <i class="fa fa-chevron-circle-down DownArrow" id="ASPLANDown" onclick="ToggleDiv(this.id,'ASPLANUp','DivContentASPLAN','Y')" style="display: none" aria-hidden="true"></i>
                        <i class="fa fa-chevron-circle-up UpArrow" id="ASPLANUp" onclick="ToggleDiv(this.id,'ASPLANDown','DivContentASPLAN','N')" aria-hidden="true"></i>
                    </div>
                </div>
                <div class="MainDivContent" id="DivContentASPLAN">
                    <div class="row EachRow">
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Anaesthesia Type</label>
                                <div class="col-xs-8 FieldDiv">
                                    <%:Html.DropDownListFor(x => Model.AneasthTypeCode, new SelectList(Model.cmbAneasType, "Value", "Text"), "---Select---", new { id = "cmbAneasthesiaType", @class = "form-control"})%>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 col-lg-4" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <label class="col-xs-4 col-form-label">Notes</label>
                                <div class="col-xs-8 FieldDiv">
                                    <textarea maxlength="100" class="form-control ml-2" style="resize: none; flex: 1; margin-left: 5px;" oninput="autoResize(this.id);MakeNormal(this.id);" onchange="autoResize(this.id);MakeNormal(this.id);" id="txtASPLANNotes"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">Pre-op Meds
  <img id="btnDuplicate" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServices('D','P')" />
   <img id="btnInformant" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServices('I','P')">
                                        </legend>
                                        <div class="col-xs-12 FieldDiv">
                                            <fieldset class="InvstFieldSet">
                                                <input type="text" id="txtSearchPreOpMed" placeholder="Search Pre-op Meds" class="form-control" />
                                                <div id="DivSearchPreOpMedList" class="SearchListDiv" ></div>
                                                <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                                                    <div class="ContentFieldDiv">
                                                        <div class="col-xs-12 FieldDiv" id="PrescMedList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width:100%">
                                                                <table id="TablePreop" class="table table-bordered table-striped MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
                                                                            <th style="width: 10px;" class="th-info">Info.</th>
                                                                            <th style="width: 300px;" id="PreopTh">Medicine</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: 50px;">Duration</th>
                                                                            <th style="width: 100px;display:none">Food</th>
                                                                            <th style="width: 150px;">Route</th>
                                                                            <th style="width: 150px;">Dosage</th>
                                                                            <th style="width: 150px;">Qty</th>
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

                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                       <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">Induction Medicine
      <img id="btnDuplicateInd" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServices('D','I')" />
  <img id="btnInformantInd" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServices('I','I')">
</legend>
                                        <div class="col-xs-12 FieldDiv">
                                            <fieldset class="InvstFieldSet">
                                                <input type="text" id="txtSearchIndMed" placeholder="Search Induction Medicine" class="form-control" />
                                                <div id="DivSearchIndMedList" class="SearchListDiv" ></div>
                                                <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                                                    <div class="ContentFieldDiv">
                                                        <div class="col-xs-12 FieldDiv" id="IndMedList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width:100%">
                                                                <table id="TableInd" class="table table-bordered table-striped MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
<th style="width: 10px;" class="th-info">Info.</th>
                                                                            <th style="width: 300px;" id="IndTh">Medicine</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: 50px;">Duration</th>
                                                                            <th style="width: 100px;display:none">Food</th>
                                                                            <th style="width: 150px;">Route</th>
                                                                            <th style="width: 150px;">Dosage</th>
                                                                            <th style="width: 150px;">Qty</th>
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

                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                         <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">Maintenance Medicine
         <img id="btnDuplicateMaint" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServices('D','M')" />
    <img id="btnInformantMaint" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServices('I','M')">
  </legend>
                                        <div class="col-xs-12 FieldDiv">
                                            <fieldset class="InvstFieldSet">
                                                <input type="text" id="txtSearchMaintMed" placeholder="Search Maintenance Medicine" class="form-control" />
                                                <div id="DivSearchMaintMedList" class="SearchListDiv" ></div>
                                                <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                                                    <div class="ContentFieldDiv">
                                                        <div class="col-xs-12 FieldDiv" id="MaintList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width:100%">
                                                                <table id="TableMaint" class="table table-bordered table-striped MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
<th style="width: 10px;" class="th-info">Info.</th>
                                                                            <th style="width: 300px;" id="MaintTh">Medicine</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: 50px;">Duration</th>
                                                                            <th style="width: 100px;display:none">Food</th>
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

                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                      <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">Reversal Medicine
       <img id="btnDuplicateRev" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServices('D','R')" />
    <img id="btnInformantIndRev" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServices('I','R')">
</legend>
                                        <div class="col-xs-12 FieldDiv">
                                            <fieldset class="InvstFieldSet">
                                                <input type="text" id="txtSearchRevMed" placeholder="Search Reversal Medicine" class="form-control" />
                                                <div id="DivSearchRevMedList" class="SearchListDiv" ></div>
                                                <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                                                    <div class="ContentFieldDiv">
                                                        <div class="col-xs-12 FieldDiv" id="RevList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width:100%">
                                                                <table id="TableRev" class="table table-bordered table-striped MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
<th style="width: 10px;" class="th-info">Info.</th>
                                                                            <th style="width: 300px;" id="RevTh">Medicine</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: 50px;">Duration</th>
                                                                            <th style="width: 100px;display:none">Food</th>
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

                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12">
                                    <fieldset style="background-color: white; padding-bottom: 10px;">
                                         <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">PONV Medicine
         <img id="btnDuplicatePONV" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServices('D','N')" />
      <img id="btnInformantPONV" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServices('I','N')">
  </legend>
                                        <div class="col-xs-12 FieldDiv">
                                            <fieldset class="InvstFieldSet">
                                                <input type="text" id="txtSearchPONVMed" placeholder="Search PONV Medicine" class="form-control" />
                                                <div id="DivSearchPONVMedList" class="SearchListDiv" ></div>
                                                <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                                                    <div class="ContentFieldDiv">
                                                        <div class="col-xs-12 FieldDiv" id="PONVMedList" style="padding: 0px;">
                                                            <div class="MedicineDiv table-responsive" style="width:100%">
                                                                <table id="TablePONV" class="table table-bordered table-striped MedicineTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 40px;">Action</th>
                                                                            <th style="width: 10px;" class="th-info">Info.</th>

                                                                            <th style="width: 300px;" id="PONVTh">Medicine</th>
                                                                            <th style="width: 150px;">Frequency</th>
                                                                            <th colspan="2" style="text-align: center; width: 50px;">Duration</th>
                                                                            <th style="width: 100px;display:none">Food</th>
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

            <%-- Button Div --%>
            <div id="MainDivBtnGrp">
                <div id="DivContentBtnGrp">
                    <div class="row EachRow">
                        <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                            <div class="ContentFieldDiv">
                                <div class="col-xs-12 FieldDiv" style="justify-content: center;">
                                    <button type="button" class="btn btn-success" style="min-width: 70px; display: none; margin-left: 20px;" id="BtnSave" onclick="SavePAC('N')">Save</button>
                                    <button type="button" class="btn btn-primary" style="min-width: 70px; display: none; margin-left: 20px;" id="BtnEdit" onclick="ChangeGaction('E')">Edit</button>
                                    <div id="DivEditChange" style="display: none">
                                        <button type="button" class="btn btn-success" style="min-width: 70px; margin-left: 20px;" id="BtnUpdate" onclick="SavePAC('E')">Update</button>
                                        <button type="button" class="btn btn-success" style="min-width: 70px; margin-left: 20px;" id="BtnApprovel" onclick="window.location.reload();">Back</button>
                                    </div>
                                    <div id="PrintDiv" style="display: none; align-items: center;">
                                        <button type="button" class="btn btn-success" style="min-width: 70px; margin-left: 20px;" id="BtnPrint" onclick="PrintPAC('')">Print</button>
                                        <input type="checkbox" id="PrintSpecialityRef" style="margin: 0px 10px;" /><label for="PrintSpecialityRef">Print with Speciality Reference</label>
                                        <input type="checkbox" id="PrintPACInvstResult" style="margin: 0px 10px;" /><label for="PrintPACInvstResult">Print with Investigation Result</label>
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
                                    <th>Risk Class</th>
                                    <th>Risk of Major Cardiac Event</th>
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
           <div class="CIMS-header" style="background: #2d70aa; margin-bottom: 4px;">
               <div style="display: inline-block; vertical-align: middle; margin-top: 4px; padding-left: 4px; height: 33px">
                   <img src="../Images/CIMS_Images/Drug.png" />
               </div>
               <div style="display: inline-block; vertical-align: middle; margin-top: 7px;">
                   <h2 class="CIMS-header-child"></h2>
               </div>
               <div class="CIMS-close" onclick="$('#divCIMSInfo').dialog('close')" title="Close"><i class="fa fa-times"></i></div>
           </div>
           <div class="CIMS-body" id="CIMSBody"></div>
       </div>
   </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <%-- Common --%>
    <style>
        #LblInvstNotifi {
            margin-left: 10px;
            background-color: red;
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
            display: flex;
            align-items: center;
            justify-content: flex-start;
            background-color: #00930012;
            color: #363636;
            border-top: 2px solid #009300;
            margin-top: 5px !important;
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

        .FieldDiv {
            display: flex;
            align-items: flex-start;
            flex-wrap: wrap;
        }

        .RadioDiv {
            display: flex;
            align-items: flex-start;
        }

        .EachRow {
            display: flex;
            flex-wrap: wrap;
            align-items: flex-start;
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

    <%-- Pain Score Table --%>
    <style>
        #tblPainScore td {
            padding: 5px 10px 10px 20px;
            vertical-align: top;
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
            display: flex;
            align-items: center;
            flex-wrap: wrap;
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

    <%-- Investigation -Result Entry --%>
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
            overflow: auto;
            height: -webkit-fill-available;
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
      <style type="text/css">
  .CIMS-container {
    display: flex;
    flex-direction: column;  /* stack header, body, footer */
    width: 100%;
    max-height: 80vh;        /* limit dialog height to viewport */
    overflow: hidden;        /* prevent container scroll */
}

.CIMS-body {
    flex: 1;                 /* take remaining space */
    overflow-y: auto;        /* only this scrolls */
    padding-right: 10px;
}


.CIMS-header img {
    height: 28px;
    width: 28px;
    vertical-align: middle;
    margin-right: 8px;
}

.CIMS-header h2 {
    color: white;
    margin: 0;
    font-size: 1.2em;
    flex: 1;
    word-break: break-word;
}

.CIMS-body {
    overflow-y: auto; 
    overflow-x: hidden;
    padding-right: 10px;
    box-sizing: border-box;
}

            .CIMS-close {
            position: absolute;
            top: 12px;
            right: 23px;
            color: #ffffff;
            font-size: 23px;
            font-weight: bold;
            cursor: pointer;
            line-height: 1;
        }

            .CIMS-close:hover {
                color: #ff4d4d;
            }

           #CIMSBody h3.ui-widget-header {
                height: auto !important; 
                padding: 12px 10px !important; 
                line-height: 1.4;
                text-align: center;
                background: #f7f7f7 !important; 
                border: 1px solid #dcdcdc;
                color: #555;
                font-size: 13px;
                font-weight: 600;
                box-sizing: border-box;
                margin: 10px;
            }

            /* Responsive tweaks for mobile */
@media (max-width: 768px) {
    .CIMS-header h2 {
        font-size: 1em;
    }

    .CIMS-header img {
        height: 24px;
        width: 24px;
    }

    .CIMS-body {
        padding: 5px;
    }

    .CIMS-footer {
        height: auto;
        padding: 5px 0;
    }
}

@media (max-width: 480px) {
    .CIMS-header h2 {
        font-size: 0.9em;
    }

    .CIMS-header img {
        height: 20px;
        width: 20px;
    }
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

</style>
    <script type="text/javascript">
        const IS_DISPLAY_CIMS_FUNCTIONLITY = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("IS_DISPLAY_CIMS_INTEGRATION")%>';  // Added By Roshan - 12/10/2025
        function toggleInfoColumn() {
            if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                $(".th-info").show();
            } else {
                $(".th-info").hide();
            }
        }
        var CIMS_blinkIds = {
            P: ['btnInformant', 'btnDuplicate'],
            I: ['btnInformantInd', 'btnDuplicateInd'],
            M: ['btnInformantMaint', 'btnDuplicateMaint'],
            R: ['btnInformantIndRev', 'btnDuplicateRev'],
            N: ['btnInformantPONV', 'btnDuplicatePONV'],
        }

        // Function to show/hide buttons based on grid row count
        function toogleButtons(TableType) {
            var rowCount = 0;
            for (var i = 0; i < AllMedListForSave.length; i++) {
                var rowData = AllMedListForSave[i];
                if (rowData.TYPE == TableType) {
                    rowCount++;
                }
            }
            if (rowCount >= 2) {
                $('#' + CIMS_blinkIds[TableType][0] + ',' + '#' + CIMS_blinkIds[TableType][1]).show();
                subscribeCIMSServices("", TableType);
            } else {
                $('#' + CIMS_blinkIds[TableType][0] + ',' + '#' + CIMS_blinkIds[TableType][1]).stop(true, true).hide();
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
            var DataToSend = {
                DrugCodes: JSON.stringify(MaterialCodes),
                Type: "html"
            };
            return DataToSend;
        }

        function subscribeCIMSServices(type, TableType) {
            if (type == "I") {
                GetDrugInterationService(TableType).then(function (response) {
                    $('#CIMSBody').empty();
                    if (response && response == "0") {
                        $.messager.alert('Warning', 'Kindly Contact IT');
                    } else {
                        if (typeof response == 'object') {
                            if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                                // Append the HTML to #CIMSBody
                                $('#CIMSBody').html(response.HtmlText);
                                $('.CIMS-header-child').text("Drug Interaction");
                                $('#divCIMSInfo').dialog('open');
                            } else {
                                $.messager.alert("Information", response.Status);
                            }
                        }
                    }
                }).catch(function (error) {
                    $.messager.alert('Warning', 'Kindly Contact IT');
                });

            } else if (type == "D") {
                GetDrugDuplicateService(TableType).then(function (response) {
                    $('#CIMSBody').empty();
                    if (response && response == "0") {
                        $.messager.alert('Warning', 'Kindly Contact IT');
                    } else {
                        if (typeof response == 'object') {
                            if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                                // Append the HTML to #CIMSBody
                                $('#CIMSBody').html(response.HtmlText);
                                $('.CIMS-header-child').text("Drug Duplicate");
                                $('#divCIMSInfo').dialog('open');
                            } else {
                                $.messager.alert("Information", response.Status);
                            }
                        }
                    }
                }).catch(function (error) {
                    $.messager.alert('Warning', 'Kindly Contact IT');
                });

            } else {
                // Default: fetch both services to determine alert states and toggle buttons visually
                GetDrugInterationService(TableType).then(function (response) {
                    $('#CIMSBody').empty();
                    if (response && response == "0") {
                        // ignore
                    } else {
                        if (typeof response == 'object') {
                            if (response.AlertYN == true) {
                                Blink("#" + CIMS_blinkIds[TableType][0]);
                            } else {
                                stopBlink("#" + CIMS_blinkIds[TableType][0]);
                            }
                        }
                    }
                }).catch(function (error) {
                    $.messager.alert('Warning', 'Kindly Contact IT');
                });

                GetDrugDuplicateService(TableType).then(function (response) {
                    $('#CIMSBody').empty();
                    if (response && response == "0") {
                        // ignore
                    } else {
                        if (typeof response == 'object') {
                            if (response.AlertYN == true) {
                                Blink("#" + CIMS_blinkIds[TableType][1]);
                            } else {
                                stopBlink("#" + CIMS_blinkIds[TableType][1]);
                            }
                        }
                    }
                }).catch(function (error) {
                    $.messager.alert('Warning', 'Kindly Contact IT');
                });
            }
        }
        </script>
    <script src="../Scripts/_CimsCommon.js"></script>
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
        var AllAdviceList = [];
        var AllTestAdviceList = [];
        var AllResultInvstList = [];
        var srvcgrpname = "dblServiceHelpsrvcgrp";
        var BckAllResultInvstList = [];
        var SearchInvestigationsList = [];
        var SpecialityRefList = [];
        var SpecialityTypeList = [];
        var ICDDiagnosis = "";
        var TemplateRef = "This is a case of {FIELDONE} who is awaiting for planned surgery: {FIELDTWO} under anaesthesia, kindly do assess the patient for _____________________ and give your valuable clinical opinion.";
        var GeneralWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';
    </script>

    <%-- Form Load  --%>
    <script type="text/javascript">
        $(document).ready(function (e) {
            $("#slide_sdList").hide();
            $("#slide_MoveTop").show();
            document.getElementById('slide_MoveTop').addEventListener('click', function () {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
            DispAddPatient = false;
            if ($.session.get('PatCompleted') == "Y") {
                document.getElementById("BtnSave").style.display = "none";
                //document.getElementById("BtnEdit").style.display = "none";
                document.getElementById("DivEditChange").style.display = "none";
                document.getElementById("btnAddRef").style.display = "none";
                document.getElementById("PrintDiv").style.display = "flex";
                document.getElementById("PrintDiv_Top").style.display = "flex";
                Gaction = "D";
            }
            $('#SettingDrpdown').css('display', 'none');
            $("#PatHistory").hide();
            $("#menuDots").hide();
            SearchFunction($.session.get('ClinicCode'));
            $(".triggerInputBP").on("input", function () {
                $(this).val($(this).val().replace(/\D/g, ''));
                if ($(this).val() > 300) {
                    $(this).val(300);
                }
            });
            $(".triggerInputBP").attr('maxlength', '3');
            if ($(window).width() >= 996) {
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                $("#slide_sdList").click();
                ActiveMenu("PAC");
            }
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
                    //priyanka 19/11/2025
                    if ($("#rbtnINC4").prop("checked") === true) {
                        $("#txtINCOther").show();
                    } else {
                        $("#txtINCOther").hide();
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
                $.alert("There is currently no pending surgery advice for the selected patient.");
            }
            else {
                SetPatientDtl();
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
            if (Gaction == "D" || Gaction == "V") {
                document.querySelectorAll('#ContentHolderDiv input, #ContentHolderDiv select, #ContentHolderDiv textarea, #ContentHolderDiv button').forEach(function (el) { el.disabled = true });
                $("#BtnResultInvst").prop("disabled", false);
                $("#BtnPrintInvst").prop("disabled", false);
                $("#InvestRpt").prop("disabled", false);
                $("#CancerCareHist").prop("disabled", false);
                $("#previousPrep").prop("disabled", false);
                $("#BtnPACLogInfo").prop("disabled", false);
                if (Gaction == "V") {
                    $("#BtnSave").prop("disabled", false);
                    $("#BtnEdit").prop("disabled", false);
                    document.getElementById("DivEditChange").style.display = "none";
                    document.querySelectorAll('input[name="APSFITSTS"]').forEach(function (el) {
                        el.disabled = false;
                    });
                    $("#ChkPACReview").prop("disabled", false);
                }
                else {
                    $("#BtnSave").prop("disabled", true);
                    //$("#BtnEdit").prop("disabled", true);
                    document.getElementById("DivEditChange").style.display = "none";
                }
                $("#BtnEdit").prop("disabled", false);
                $("#BtnPrint").prop("disabled", false);
                $("#BtnPrint_Top").prop("disabled", false);
                $("#PrintSpecialityRef").prop("disabled", false);
                $("#PrintSpecialityRef_Top").prop("disabled", false);
                $("#PrintPACInvstResult").prop("disabled", false);//priyanka 09/12/2025
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
            if (Gaction == "N")
                ShowHidePACHistoryIcon();

            $("#previousPrep").click(function () {
                var Mrno = ($.session.get('PatMRNO')).toString();
                if (Mrno != "") {
                    HoldOn.open();
                    $.ajax({
                        type: 'POST',
                        url: '../DoctorDesk/RedirectToDicom',
                        data: { mrNo: Mrno },
                        success: function (data) {
                            HoldOn.close();
                            window.open(data);
                        },
                        error: function () {
                            HoldOn.close();
                        }
                    });
                }
                else {
                    $.alert("Please Select Patient", "Information");
                    return false;
                }
            });
            //priyanka 04/12/2025
            $("#txtPVSMTemp").change(function () {
                $('#txtPVSMTemp').val(Number($("#txtPVSMTemp").val()).toFixed(2));
            });
            //end
        });
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
                document.getElementById("PersMedi").style.display = "inline-block";
                document.getElementById("PACLogInfo").style.display = "none";
            }
            else if (Gaction == "V") {
                document.getElementById("BtnSave").style.display = "block";
                if ('<%=Model.OTNotesNo %>' == "" || '<%=Model.OTNotesNo %>' == "P")
                    document.getElementById("BtnEdit").style.display = "inline-block";
                else
                    document.getElementById("BtnEdit").style.display = "none";
                document.getElementById("BtnSave").innerText = "Approve";
                document.getElementById("PACLogInfo").style.display = "inline-block";
            }
            else {
                document.getElementById("BtnSave").style.display = "none";
                if ('<%=Model.OTNotesNo %>' == "" || '<%=Model.OTNotesNo %>' == "P")
                    document.getElementById("BtnEdit").style.display = "inline-block";
                else
                    document.getElementById("BtnEdit").style.display = "none";
                document.getElementById("PrintDiv").style.display = "flex";
                document.getElementById("PrintDiv_Top").style.display = "flex";
                document.getElementById("PACLogInfo").style.display = "inline-block";
            }
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
            document.getElementById("MainDivTranInfo").style.display = "none";
            document.getElementById("PersMedi").style.display = "inline-block";
            document.getElementById("PACLogInfo").style.display = "none";
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
            }
        }
        //Bind Patient Details
        function BindPatientDtls() {
            if ($.session.get('PatMRNO') != undefined && $.session.get('PatMRNO') != "") {
                $("#txtPACMRNO").val($.session.get('PatMRNO'));
                $("#txtPACPatName").val($.session.get('PatName'));
                $("#txtPACPatAge").val($.session.get('PatAge'));
                $("#txtPACPatGen").val($.session.get('PatGender'));
            }
            $("#txtPACAdmDoct").val('<%=Model.DoctorName %>');
            $("#txtPACAdmDoctCode").val('<%=Model.DoctorCode %>');
            if (Gaction != "N") {
                $("#txtPAC").val('<%=Model.TRANNO %>');
                $("#txtPACDate").val('<%=Model.TRANDT %>');
<%--                if ('<%=Model.ReviewYN %>' == "Y") {
                    $("#ChkPACReview").prop("checked", true);
                    $("#ChkPACReview").prop("disabled", true);
                    $("#txtPACReviewDate").val('<%=Model.ReviewDate %>');
                }
                else {
                    $("#ChkPACReview").prop("checked", false);
                    $("#ChkPACReview").prop("disabled", false);
                    $("#txtPACReviewDate").val("");
                }--%>
                $("#txtPACWeight").val('<%=Model.PatWeight %>');
                $("#txtPACHeight").val('<%=Model.PatHeight %>');
                $("#txtPACBMI").val('<%=Model.PatBMI %>');
            }
        }
        //Validation For Patient Info
        function ValidationForPatInfo() {
            if ($("#txtPACMRNO").val() == "") {
                $.alert("Please Select Patient");
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
            PostData.push({ name: 'TRANNO', value: TranNo });
            PostData.push({ name: 'SurgAdvConsNo', value: SurgyTranNo });
            PostData.push({ name: 'MRNO', value: $("#txtPACMRNO").val() });
            PostData.push({ name: 'ReviewYN', value: ($("#ChkPACReview").prop("checked") == true ? "Y" : "N") });
            PostData.push({ name: 'ReviewDate', value: $("#txtPACReviewDate").val() });
            PostData.push({ name: 'PatHeight', value: $("#txtPACHeight").val() });
            PostData.push({ name: 'PatWeight', value: $("#txtPACWeight").val() });
            PostData.push({ name: 'PatBMI', value: $("#txtPACBMI").val() });
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
                    strMRNO: $.session.get('PatMRNO')
                }
                $.ajax({
                    url: 'SetDataForDiagnosis',
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
                maxDate: new Date(),
                onSelect: function () {
                    restrictTimeBasedOnDate();
                }
            });
            document.getElementById("txtPVSMTime").addEventListener("change", function () {
                var max = this.max;
                if (max == "") {
                    if ($("#txtPVSMDate").val() == "") {
                        $.alert("Please Select the Date", "Information");
                        this.value = "";
                        return;
                    }
                }
                if (max && this.value > max) {
                    $.alert("You cannot select a time in the future.", "Information");
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
                url: 'SetDataForVitals',
                async: false,
                data: { strTranNo: SurgyTranNo },
                success: function (data) {
                    if (data != "") {
                        var ConsltTime = '<%=Model.ConsultTime %>';
                        ConsltTime = ConsltTime != "" ? (ConsltTime.split(':')[0] + ":" + ConsltTime.split(':')[1]) : "";
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
                $.alert("Please Enter atleast one field");
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
                $.alert(("Already Vitals have enter for " + $("#txtPVSMDate").val()), "Information");
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
        }
        //Validation For Vitals Info
        function ValidationForVitalsInfo() {
            if (PatVitalsList.length == 0) {
                $("#PVSMDown").trigger('click');
                $.alert("Please Enter Vitals.");
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
        // Comorbidities & Treatment History Info Gaction
        function BindComoTreatHistInfoGaction() {
            if (Gaction == "N") {
                ClearComoTreatHistInfo();
                DefaultObesity();
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
            if ($.session.get('PatAge2') != "" && $.session.get('PatAge2') != undefined && $.session.get('PatAge2') != null) {
                var AgeSpilt = $.session.get('PatAge2').split(':');
                if (Number(AgeSpilt[0]) > 50) {
                    $("#rbtnCTHOBESITY6").prop("checked", true);
                }
            }
            if ($.session.get('PatGender') == "Male") {
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
            var ObesityIndx = '<%=Model.Obesity %>';
            if ('<%=Model.IsHypertension %>' == "Y") {
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

            if ('<%=Model.IsDrugSnakeScorpionBite %>' == "Y") {
                $("#ChkCTHBITE").prop("checked", true);
                var DrugBite = '<%=HttpUtility.JavaScriptStringEncode(Model.DrugBite) %>'
                $("#txtCTHBite").val(DrugBite.replace(/\\n/g, "\n"));
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
            EnDisChkTextbox('ChkCTHANYRELHIST', 'txtCTHRelMedHist');
            $("#CTHDown").trigger('click');
            autoResize('txtCTHAnyHOSurg');
            autoResize('txtCTHRelMedHist');
            $("#CTHUp").trigger('click');
        }
        //Validation For Comorbidities & Treatment History Info
        function ValidationForComoTreatHistInfo() {
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
            if (ValidTextCheck('ChkCTHANYRELHIST', 'txtCTHRelMedHist') == false)
                return false;
            //var Cardi = GetLastLetterCheckedRadio('CTHCARDI');
            //if (Cardi == "4") {
            //    if ($("#txtCTHCardiothrs").val() == "") {
            //        $("#CTHDown").trigger('click');
            //        $("#txtCTHCardiothrs").focus();
            //        $("#txtCTHCardiothrs").css("border-color", "red");
            //        return false;
            //    }
            //}
            //var NervSys = GetLastLetterCheckedRadio('CTHNERVSYS');
            //if (NervSys == "3") {
            //    if ($("#txtCTHNervSysOthrs").val() == "") {
            //        $("#CTHDown").trigger('click');
            //        $("#txtCTHNervSysOthrs").focus();
            //        $("#txtCTHNervSysOthrs").css("border-color", "red");
            //        return false;
            //    }
            //}
            //var Renel = GetLastLetterCheckedRadio('CTHRENAL');
            //if (Renel == "3") {
            //    if ($("#txtCTHRENALOthrs").val() == "") {
            //        $("#CTHDown").trigger('click');
            //        $("#txtCTHRENALOthrs").focus();
            //        $("#txtCTHRENALOthrs").css("border-color", "red");
            //        return false;
            //    }
            //}
            return true;
        }
        //General Comorbidities & Treatment History Info Save Value Pass
        function SaveForComoTreatHistInfo(PostData) {
            PostData.push({ name: 'IsHypertension', value: SaveValueTextCheck('ChkCTHHYP') });
            PostData.push({ name: 'Hypertension', value: $("#txtCTHHypert").val() });
            PostData.push({ name: 'IsDiabetesMellitus', value: SaveValueTextCheck('ChkCTHDIABMEL') });
            PostData.push({ name: 'DiabetesMellitus', value: $("#txtCTHDiabMelt").val() });
            PostData.push({ name: 'Cardiac', value: GetLastLetterCheckedRadio('CTHCARDI') });
            PostData.push({ name: 'CardiacOthrs', value: $("#txtCTHCardiothrs").val() });
            PostData.push({ name: 'NYHA', value: GetLastLetterCheckedRadio('CTHNYHA') });
            PostData.push({ name: 'ECOG', value: GetLastLetterCheckedRadio('CTHECOG') });
            PostData.push({ name: 'Respiratory', value: GetLastLetterCheckedRadio('CTHRESP') });
            PostData.push({ name: 'MMRC', value: GetLastLetterCheckedRadio('CTHMMRC') });
            PostData.push({ name: 'NervsousSys', value: GetLastLetterCheckedRadio('CTHNERVSYS') });
            PostData.push({ name: 'NervsousSysOthrs', value: $("#txtCTHNervSysOthrs").val() });
            PostData.push({ name: 'Renal', value: GetLastLetterCheckedRadio('CTHRENAL') });
            PostData.push({ name: 'RenalOthrs', value: $("#txtCTHRENALOthrs").val() });
            PostData.push({ name: 'IsThyroidDisorder', value: SaveValueTextCheck('ChkCTHTHYDIS') });
            PostData.push({ name: 'ThyroidDisorder', value: $("#txtCTHThyroidDis").val() });
            PostData.push({ name: 'IsChemotherapy', value: SaveValueTextCheck('ChkCTHCHEMO') });
            PostData.push({ name: 'Chemotherapy', value: $("#txtCTHChemotherapy").val() });
            PostData.push({ name: 'IsRadiotherapy', value: SaveValueTextCheck('ChkCTHRADIO') });
            PostData.push({ name: 'Radiotherapy', value: $("#txtCTHRadiotherapy").val() });
            PostData.push({ name: 'IsAntHOSurgery', value: SaveValueTextCheck('ChkCTHANYSURG') });
            PostData.push({ name: 'AnyHOSurg', value: JSON.stringify($("#txtCTHAnyHOSurg").val().toString().trim()) });
            PostData.push({ name: 'BloodRelated', value: GetLastLetterCheckedRadio('CTHBLDREL') });
            PostData.push({ name: 'IsDrugSnakeScorpionBite', value: SaveValueTextCheck('ChkCTHBITE') });
            PostData.push({ name: 'DrugBite', value: $("#txtCTHBite").val() });
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
        }
        //Bind Substance Abuse History Info
        function BindSubsAbuseHistDtls() {
            var Drugs = '<%=HttpUtility.JavaScriptStringEncode(Model.Drugs) %>'
            $("#txtSAHDrugs").val(Drugs.replace(/\\n/g, "\n"));
            var Alcohol = '<%=HttpUtility.JavaScriptStringEncode(Model.Alcohol) %>'
            $("#txtSAHAlcohol").val(Alcohol.replace(/\\n/g, "\n"));
            var BetalNut = '<%=HttpUtility.JavaScriptStringEncode(Model.BetalNut) %>'
            $("#txtSAHBetalNut").val(BetalNut.replace(/\\n/g, "\n"));
            var Tobacco = '<%=HttpUtility.JavaScriptStringEncode(Model.Tobacco) %>'
            $("#txtSAHTobacco").val(Tobacco.replace(/\\n/g, "\n"));
            var Smoking = '<%=HttpUtility.JavaScriptStringEncode(Model.Smoking) %>'
            $("#txtSAHSmoking").val(Smoking.replace(/\\n/g, "\n"));
        }
        //Validation For Substance Abuse History Info
        function ValidationForSubsAbuseHistInfo() {
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
            var Teeth = GetLastLetterCheckedRadio('AATEETH');
            if (Teeth == "") {
                $("#AADown").trigger('click');
                FocusRadioOpt("rbtnAATEETH1", "Please Select Teeth");
                return false;
            }
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
            PostData.push({ name: 'Teeth', value: GetLastLetterCheckedRadio('AATEETH') });
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
            if ($.session.get('PatAge2') != "" && $.session.get('PatAge2') != undefined && $.session.get('PatAge2') != null) {
                var AgeSpilt = $.session.get('PatAge2').split(':');
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
                    $.alert("Please Select Emergency Procedure");
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
            if (CheckedCount == 1) {
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
            $("#txtCPTSClass").val(TotalPoints);
            $("#txtCPTSPoints").val(Class);
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
                var MRNO = $.session.get('PatMRNO');
                var TranNo = $.session.get('PatTRANNO');
                if (MRNO == "" || MRNO == null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else {
                    $.session.set('Pagefrom', "PAC");
                    openCancerCareHistframe(MRNO);
                }
            });
        }

        //Investigation Info Load
        function InvestigationInfoLoad() {
            $("#InvestRpt").click(function () {
                var MRNO = $.session.get('PatMRNO');
                var TranNo = $.session.get('PatTRANNO');
                if (MRNO == "" || MRNO == null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else {
                    $.session.set('Pagefrom', "PAC");
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
                    const matched = SearchInvestigationsList.filter(function (item) { return item.TESTNAME.toLowerCase().includes(query); });
                    if (matched.length > 0) {
                        matched.forEach(function (item) {
                            var FilterData = AllTestAdviceList.filter(function (A) { return A.TESTCODE == item.TESTCODE && A.CHECKED == "Y"; });
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
                                var FilterD = AllTestAdviceList.filter(function (A) { return A.TESTCODE == item.TESTCODE; });
                                const container = document.getElementById('AdviceTestListOption');
                                const matchingElements = Array.from(container.querySelectorAll('[id]')).filter(function (el) {
                                    return el.id.startsWith('ChkAdvTest_') && el.id.endsWith(item.TESTCODE);
                                });
                                if (FilterD.length > 0) {
                                    AllTestAdviceList[0].CHECKED = Check;
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
                                    AllTestAdviceList.push(Lst);
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

        //Investigation Info Gaction
        function BindInvestigationInfoGaction() {
            GetAllTest();
            if (Gaction == "N") {
                ClearInvestigationInfo();
                GetInvestigationAdviceList();
            }
            else {
                BindInvestDtls();
                document.getElementById("AdviceList").style.display = "none";
                document.getElementById("InvstSearchList").style.display = "none";
                document.querySelectorAll('#AdviceTestListOption input, #AdviceTestListOption button').forEach(function (el) { el.disabled = true });
            }
        }

        //Get All Test List
        function GetAllTest() {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url:  "../DoctorDesk/GetInvestigationList",
                data: {},
                async: false,
                success: function (response) {
                    SearchInvestigationsList = response;
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
            });
        }

        //Clear Investigation Info
        function ClearInvestigationInfo() {
            GetInvestigationAdviceList();
        }

        //Bind Investigation Info
        function BindInvestDtls() {
            var InvstData = '<%=Model.InvstData %>';
            var ResultData = '<%=Model.ResultInvstData %>';
            AllTestAdviceList = InvstData != "" ? JSON.parse(InvstData) : [];
            AllResultInvstList = ResultData != "" ? JSON.parse(ResultData) : [];
            BckAllResultInvstList = ResultData != "" ? JSON.parse(ResultData) : [];
            BindTestListForAdvice(AllTestAdviceList, "EDITADVTEST", true);
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
                    var SelY = AllTestAdviceList.filter(function (a) { return a.CHECKED == "Y" && a.CODE === TestCode && a.SETUPCODE === SetupCode && a.TRANYN == "N"; })
                    if (Gaction != "N") {
                        SelY = AllTestAdviceList.filter(function (a) { return a.CHECKED == "Y" && a.TESTCODE === TestCode && a.TRANYN == "N"; })
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
                    if (a.RESULTDT != "" && a.INVINHOUSEDATE == "" && a.INRESULTDT == "") {
                        var TestNameList = AllTestAdviceList.filter(function (c) { return c.TESTCODE == a.TESTCODE; });
                        var TestName = "";
                        if (TestNameList.length > 0) {
                            TestName = TestNameList[0].TESTNAME;
                        }
                        a.TESTNAME = TestName;
                        FilterResult.push(a);
                    }
                }
            });
            PostData.push({ name: 'InvstData', value: JSON.stringify(FilterData) });
            PostData.push({ name: 'ResultInvstData', value: JSON.stringify(FilterResult) });
            return PostData;
        }

        //Get Advice Setup List
        function GetInvestigationAdviceList() {
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetPersInvestigationList",
                data: {},
                asycn: false,
                success: function (response) {
                    AllAdviceList = [];
                    AllTestAdviceList = [];
                    if (response != "" && response != "UNSUCCESSFULL") {
                        var result = JSON.parse(response);
                        result.Table1.forEach(function (item) { item.CHECKED = "N"; });
                        AllAdviceList = result.Table1;
                    }
                    BindInvestigationAdviceList(AllAdviceList);
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
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
                            var Filter = AllTestAdviceList.filter(function (a) { a.TRANYN = "N"; return a.TESTCODE == item.CODE; });
                            if (Filter.length == 0) {
                                AllTestAdviceList.push(item);
                                FList.push(item);
                            }
                        });
                        BindTestListForAdvice(FList, Id, true);
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
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
                $.grep(AllTestAdviceList, function (a) {
                    if (a.CODE == Code) {
                        a.CHECKED = CheckYN;
                        AddRemTestFromInvstList(a.TESTCODE, CheckYN);
                    }
                });
            }
            else {
                var Code = SplitCode[1];
                var FilterLst = AllTestAdviceList.filter(function (a) { return a.SETUPCODE === Code; });
                if (FilterLst.length == 0) {
                    GetTestListForAdvice(Code);
                    $.grep(AllTestAdviceList, function (a) {
                        if (a.SETUPCODE == Code) {
                            a.CHECKED = "Y";
                            GetResultEntryList(a.TESTCODE);
                        }
                    });
                }
                else {
                    var AdvCode = FilterLst[0].SETUPCODE;
                    $.grep(AllTestAdviceList, function (a) {
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
                $.grep(AllAdviceList, function (a) {
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
            if (AllTestAdviceList.length == 0) {
                $.messager.alert("Information", "No Data Found");
                return false;
            }
            var FilterData = AllTestAdviceList.filter(function (a) { return a.CHECKED == "Y"; });
            if (FilterData.length == 0) {
                $.messager.alert("Information", "Select the Advice Test");
                return false;
            }
            return true;
        }

        //Open Result Entry Popup
        function OpenResultEntryPopup() {
            $("#tblResultInvstListBody").empty();
            if (ValidationForResultPopup() == true && AllTestAdviceList.length > 0) {
                if (AllResultInvstList.length == 0 && Gaction != "D") {
                    $.grep(AllTestAdviceList, function (a) {
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
                    $.messager.alert("Information", "No Result Entry Data Found.");
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
                            var Filt = AllTestAdviceList.filter(function (f) { return f.CHECKED == "Y" && f.TESTCODE == a; });
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
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
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
            $.grep(AllTestAdviceList, function (a) {
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
                        $.grep(AllTestAdviceList, function (a) {
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
                var RplTestTd = Td.replace("{TDCLASS}", 'TestTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='width:200px !important'").replace("{TDCONTENT}", a.TESTNAME);
                var OutDateDisabled = Gaction == "D" || Gaction == "V" ? "disabled" : List.filter(function (S) { return S.TESTCODE == a.TESTCODE && a.RESULTDT.trim() != ""; }).length > 0 ? "disabled" : "";
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
                        var TestNameList = AllTestAdviceList.filter(function (c) { return c.TESTCODE == a.TESTCODE; });
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
                    var win = window.open('../DoctorDesk/DisplayPrintPACResult', "_blank", '', true);
                    win.focus();
                    HoldOn.close();
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                    HoldOn.close();
                },
                complete: function () {
                    HoldOn.close();
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
                BindSpecialityRefDtls();
            }
        }
        //Get Specaility List
        function GetCliniclist() {
            $.ajax({
                url: 'GetClinic',
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
                            $.messager.alert("Information", "This Speciality Reference is already mentioned");
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
                            $.messager.alert("Information", "This Speciality Reference is already mentioned");
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
                        $.messager.alert("Information", "Please Select or Enter Speciality Reference");
                    }
                    if ($(ContId).val().trim() == "") {
                        Flag = false;
                        $.messager.alert("Information", ("Please Enter Speciality Reference Content for " + $(TxtId).val().trim()));
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
            var MainDiv = "<div id='DivRef_" + Ind + "' class='col-xs-12' style='padding: 0px 0px 0px 0px;'><div class='col-xs-12' style='padding: 0px 0px 5px 0px;'><div class='ContentFieldDiv'><div class='col-xs-12 FieldDiv' style='flex-wrap: nowrap;align-items: center;'>";
            var SelCombo = "<select class='form-control' id='cmbSpeciality_" + Ind + "' style='max-width: 20px;' onchange=\"EnDisableSpecRefTextbox(this.id,'txtSpeciality_" + Ind + "')\">{OPTIONS}</select>";
            var SpecNameTxt = "<input type='text' maxlength='50' class='form-control' id='txtSpeciality_" + Ind + "' placeholder='Speciality Name' onblur='ValidateRefText(this.id)' />";
            var DelIcon = "<i class='fa fa-trash SpeciDelIcon' aria-hidden='true' onclick=\"AddRemSpecialityRef('R','" + Ind + "')\"></i>";
            var PrintIcon = "<i class='fa fa-print SpeciPrintIcon' aria-hidden='true' onclick=\"PrintSpecRef('" + Ind + "')\"></i>";
            var MainCloseDiv = "</div></div></div><div class='col-xs-12' style='padding: 0px 0px 5px 0px;'><div class='ContentFieldDiv'><div class='col-xs-12 FieldDiv'>";
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
            var spcRef = '<%=HttpUtility.JavaScriptStringEncode(Model.SpecialityReference) %>';
            $("#txtSPCREF").val(spcRef.replace(/\\n/g, "\n"));
            var SpecialityData = '<%=Model.SpecialityRefData %>';
            SpecialityData = SpecialityData.replace(/\n/g, "\\n");
            SpecialityRefList = SpecialityData != "" ? JSON.parse(SpecialityData) : [];
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
                var ampm = hours >= 12 ? 'PM' : 'AM';
                hours = hours % 12;
                hours = hours ? hours : 12;
                minutes = minutes < 10 ? '0' + minutes : minutes;
                var CurrentTime = hours.toString().padStart(2, '0') + ':' + minutes + ' ' + ampm;
                $("#txtAPSDate").datepicker("setDate", new Date());
                $("#txtAPSTime").val(CurrentTime);
            }
            else {
                $("#txtAPSDate").val("");
                $("#txtAPSTime").val("");
            }
        }
        //Clear ASA Info
        function ClearASAInfo() {
            UncheckRadioBtn('APSPHYSTS');
            UncheckRadioBtn('APSFITSTS');
            $("#txtAPSDate").val("");
            $("#txtAPSTime").val("");
            $("#cmbASARisk").val("");//priyanka 19/11/2025
            $("#txtASARemark").val("");
            $("#APSDown").trigger('click');
            autoResize('txtASARemark');
            $("#APSUp").trigger('click');
        }
        //Bind ASA Info
        function BindASADtls() {
            var Phystatus = '<%=Model.ASAPhysicalStatus %>';
            var FitStatus = '<%=Model.ASAFitnessStatus %>';
            var ASARiskLvl = '<%=Model.ASARiskLevel %>'; //priyanka 19/11/2025     if (Phystatus != "")
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
            var AnaestAdviceOperativeOrder = '<%=HttpUtility.JavaScriptStringEncode(Model.AnaestAdviceOperativeOrder) %>';
            $("#txtAAPO").val(AnaestAdviceOperativeOrder.replace(/\\n/g, "\n"));
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
            MedClickSearch('txtSearchPONVMed', 'DivSearchPONVMedList', 'TablePONVTBody', 'N');
            MedClickSearch('txtSearchMaintMed', 'DivSearchMaintMedList', 'TableMaintTBody', 'M');
            MedClickSearch('txtSearchRevMed', 'DivSearchRevMedList', 'TableRevTBody', 'R');
            BindAnaethesiaPlanGaction();
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
                                    AddMedicineTable(item.MTRLCODE, item.MTRLNAME, Type, TblBodyId, item.GENERICID, item.GENERICNAM);
                                }
                                else {
                                    AddMedicineTable(item.MTRLCODE, item.MTRLNAME, Type, TblBodyId, item.GENERICID, item.GENERICNAM);
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
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
            });
        }
        //Get All Frequency List
        function GetFrequencyList() {
            HoldOn.open();
            $.ajax({
                type: "get",
                datatype: "json",
                url: 'GetMedicineInTake',
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
        //Add Medicine To Table
        function AddMedicineTable(MedCode, MedName, Type, TbodyId, GenCode, GenName) {
            var Tr = "<tr id='{TRID}'>{TRCONTENT}</tr>";
            var Td = "<td {CLASS}>{TDCONTENT}</td>";
            var Label = "<label>{LABELCONTENT}</label>";
            var InputAuto = "<input type='text' class='form-control editable-text auto-field' id='{TEXTBOXID}' onblur=\"AddUpdateMedicineListSave('U','{MEDCODE}','','{TYPE}','','')\" />";
            var DelIcon = "<i class='fa fa-trash MedDelIcon' onclick=\"AddUpdateMedicineListSave('R','{MEDCODE}','','{TYPE}','','')\"></i>";
            var InfoIcon = "<i class='fa fa-info-circle MedInfoIcon' style='font-size: 18px;' aria-hidden='true' onclick=\"getDrugInfo('{MEDCODE}')\"></i>";
            // Action
            var RplDelIcon = DelIcon.replace("{MEDCODE}", MedCode).replace("{TYPE}", Type);
            var RplActTd = Td.replace("{TDCONTENT}", RplDelIcon).replace("{CLASS}", "");
  //Info.
  var RplInfoTd = "";
  if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
      var RplInfoIcon = InfoIcon.replace("{MEDCODE}", MedCode);
      RplInfoTd = Td.replace("{TDCONTENT}", RplInfoIcon).replace("{CLASS}", "");
  }
            //Medicine
            var RplLabel = Label.replace("{LABELCONTENT}", MedName);
            var RplMedNameTd = Td.replace("{TDCONTENT}", RplLabel).replace("{CLASS}", "");
            // Frequency
            var FreqTxtId = "txt_Freq_" + Type + "_" + MedCode;
            var RplFreqTxt = InputAuto.replace("{TEXTBOXID}", FreqTxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type);
            var RplFreqTd = Td.replace("{TDCONTENT}", RplFreqTxt).replace("{CLASS}", "class='tdtxt'");
            // Duration Day
            var DurDayTxtId = "txt_DurDay_" + Type + "_" + MedCode;
            var RplDurDayTxt = InputAuto.replace("{TEXTBOXID}", DurDayTxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type);
            var RplDurDayTd = Td.replace("{TDCONTENT}", RplDurDayTxt).replace("{CLASS}", "class='tdtxt'");
            // Duration Category
            var DurCatgTxtId = "txt_DurCatg_" + Type + "_" + MedCode;
            var RplDurCatgTxt = InputAuto.replace("{TEXTBOXID}", DurCatgTxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type);
            var RplDurCatgTd = Td.replace("{TDCONTENT}", RplDurCatgTxt).replace("{CLASS}", "class='tdtxt'");
            // Food
            var FoodTxtId = "txt_Food_" + Type + "_" + MedCode;
            var RplFoodTxt = InputAuto.replace("{TEXTBOXID}", FoodTxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type);
            var RplFoodTd = Td.replace("{TDCONTENT}", RplFoodTxt).replace("{CLASS}", "class='tdtxt' style='display:none'");
            // Route
            var RouteTxtId = "txt_Route_" + Type + "_" + MedCode;
            var RplRouteTxt = InputAuto.replace("{TEXTBOXID}", RouteTxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type);
            var RplRouteTd = Td.replace("{TDCONTENT}", RplRouteTxt).replace("{CLASS}", "class='tdtxt'");
            // Dosage
            var DosagetxtId = "txt_Dose_" + Type + "_" + MedCode;
            var RplDosageTxt = InputAuto.replace("{TEXTBOXID}", DosagetxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type);
            var RplDosageTd = Td.replace("{TDCONTENT}", RplDosageTxt).replace("{CLASS}", "class='tdtxt'");
            // Quantity
            var QtytxtId = "txt_Qty_" + Type + "_" + MedCode;
            var RplQtyTxt = InputAuto.replace("{TEXTBOXID}", QtytxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type);
            var RplQtyTd = Td.replace("{TDCONTENT}", RplQtyTxt).replace("{CLASS}", "class='tdtxt'");
            // Remark
            var RemarktxtId = "txt_Remark_" + Type + "_" + MedCode;
            var RplRemarkTxt = InputAuto.replace("{TEXTBOXID}", RemarktxtId).replace("{MEDCODE}", MedCode).replace("{TYPE}", Type);
            var RplRemarkTd = Td.replace("{TDCONTENT}", RplRemarkTxt).replace("{CLASS}", "class='tdtxt'");
            // Combine all columns
            var TrId = "TR_" + Type + "_" + MedCode;
            var RplTr = Tr.replace("{TRID}", TrId).replace("{TRCONTENT}", RplActTd + RplInfoTd + RplMedNameTd + RplFreqTd + RplDurDayTd + RplDurCatgTd + RplFoodTd + RplRouteTd + RplDosageTd + RplQtyTd + RplRemarkTd);
            // Append to tbody
            $("#" + TbodyId).append(RplTr);
            // Attach autocomplete
            attachAutocomplete(FreqTxtId, AllFreqList);
            attachAutocomplete(DurDayTxtId, AllDurDayList);
            attachAutocomplete(DurCatgTxtId, AllDurCatgList);
            attachAutocomplete(FoodTxtId, AllFoodList);
            attachAutocomplete(RouteTxtId, AllRouteList);
            attachAutocomplete(DosagetxtId, AllDoseList);
            attachAutocomplete(RemarktxtId, AllRemarkList);
            //Update Array
            AddUpdateMedicineListSave("A", MedCode, MedName, Type, GenCode, GenName);
        }
        //Add Auto Complete
        function attachAutocomplete(inputId, listData) {
            $("#" + inputId).autocomplete({
                source: listData,
                minLength: 0
            }).focus(function () {
                $(this).autocomplete("search", "");
            });
        }
        //Update or Remove Medicine List For Save
        function AddUpdateMedicineListSave(Act, MedCode, MedName, Type, GenCode, GenName) {
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
                    DRUGFORM: "",
                }
                AllMedListForSave.push(NewD);
            }
            else if (Act == "R") {
                if (Gaction == "N" || Gaction == "E") {
                    var TrId = "TR_" + Type + "_" + MedCode;
                    if (document.getElementById(TrId)) {
                        document.getElementById(TrId).remove();
                    }
                    var TData = JSON.parse(JSON.stringify(AllMedListForSave));
                    var Ind = 1;
                    var FData = TData.filter(function (c) {
                        if (c.DRUGCODE != MedCode || c.TYPE != Type) {
                            c.SEQNO = Ind;
                            Ind++;
                        }
                        return c.DRUGCODE != MedCode || c.TYPE != Type;
                    });
                    AllMedListForSave = FData;
                }
            }
            else {
                var FreqTxtId = "txt_Freq_" + Type + "_" + MedCode;
                var DurDayTxtId = "txt_DurDay_" + Type + "_" + MedCode;
                var DurCatgTxtId = "txt_DurCatg_" + Type + "_" + MedCode;
                var FoodTxtId = "txt_Food_" + Type + "_" + MedCode;
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
                $.grep(AllMedListForSave, function (a) {
                    if (a.TYPE == Type && a.DRUGCODE == MedCode) {
                        a.INTAKECD = $('[id="' + FreqTxtId + '"]').val();
                        a.INTAKEDESC = $('[id="' + FreqTxtId + '"]').val();
                        a.DAYS = $('[id="' + DurDayTxtId + '"]').val();
                        a.DURATION = $('[id="' + DurCatgTxtId + '"]').val();
                        a.ABFOOD = $('[id="' + FoodTxtId + '"]').val();
                        a.ROUTE = $('[id="' + RouteTxtId + '"]').val();
                        a.DOSSAGE = $('[id="' + DosagetxtId + '"]').val();
                        a.QTY = $('[id="' + QtytxtId + '"]').val();
                        a.Remarks = $('[id="' + RemarktxtId + '"]').val();
                        a.SOSYN = SOSYN;
                    }
                });
            }
 if (IS_DISPLAY_CIMS_FUNCTIONLITY == "Y") {
     // Added By Roshan Condtion Based On WebConfigs
     toogleButtons(Type);//For Show And Hide The Interaction and Duplicate Button Added By Roshan 12/12/2025
 }
        }
        //Bind AnaethesiaPlan
        function BindAnaethesiaPlan() {
            $("#cmbAneasthesiaType").val('<%=Model.AneasthTypeCode %>');
            var Notes = '<%=HttpUtility.JavaScriptStringEncode(Model.Notes) %>';
            $("#txtASPLANNotes").val(Notes.replace(/\\n/g, "\n"));
            var MedicineData = '<%=Model.MedGridData %>';
            var TAllMedListForSave = MedicineData != "" ? JSON.parse(MedicineData) : [];
            $.grep(TAllMedListForSave, function (a) {
                var TbodyId = "";
                if (a.TYPE == "P")
                    TbodyId = "TablePreopTBody";
                else if (a.TYPE == "I")
                    TbodyId = "TableInd";
                else if (a.TYPE == "N")
                    TbodyId = "TablePONVTBody";
                else if (a.TYPE == "R")
                    TbodyId = "TableRevTBody";
                else
                    TbodyId = "TableMaintTBody";
                AddMedicineTable(a.DRUGCODE, a.DRUGNAME, a.TYPE, TbodyId, a.GENERICID, a.GENERICNAME);
                var FreqTxtId = "txt_Freq_" + a.TYPE + "_" + a.DRUGCODE;
                var DurDayTxtId = "txt_DurDay_" + a.TYPE + "_" + a.DRUGCODE;
                var DurCatgTxtId = "txt_DurCatg_" + a.TYPE + "_" + a.DRUGCODE;
                var FoodTxtId = "txt_Food_" + a.TYPE + "_" + a.DRUGCODE;
                var RouteTxtId = "txt_Route_" + a.TYPE + "_" + a.DRUGCODE;
                var DosagetxtId = "txt_Dose_" + a.TYPE + "_" + a.DRUGCODE;
                var QtytxtId = "txt_Qty_" + a.TYPE + "_" + a.DRUGCODE;
                var RemarktxtId = "txt_Remark_" + a.TYPE + "_" + a.DRUGCODE;
                $('[id="' + FreqTxtId + '"]').val(a.INTAKEDESC);
                $('[id="' + DurDayTxtId + '"]').val(a.DAYS);
                $('[id="' + DurCatgTxtId + '"]').val(a.DURATION);
                $('[id="' + FoodTxtId + '"]').val(a.ABFOOD);
                $('[id="' + RouteTxtId + '"]').val(a.ROUTE);
                $('[id="' + DosagetxtId + '"]').val(a.DOSSAGE);
                $('[id="' + QtytxtId + '"]').val(a.QTY);
                $('[id="' + RemarktxtId + '"]').val(a.Remarks);
                AddUpdateMedicineListSave("U", a.DRUGCODE, a.DRUGNAME, a.TYPE, a.GENERICID, a.GENERICNAME);
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
            PostData.push({ name: 'AneasthTypeCode', value: $("#cmbAneasthesiaType").val() });
            PostData.push({ name: 'Notes', value: JSON.stringify($("#txtASPLANNotes").val().toString().trim()) });
            PostData.push({ name: 'MedGridData', value: JSON.stringify(AllMedListForSave) });
            return PostData;
        }
        //AnaethesiaPlan Info Print
        function PrintAnaethesiaPlan(PrintData) {
            PrintData.push({ name: 'AneasthTypeCode', value: $("#cmbAneasthesiaType").val() != "" ? $("#cmbAneasthesiaType option:selected").text() : "" });
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
                if (c.TYPE == Type) {
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
    </script>

    <%-- Save and Validation --%>
    <script type="text/javascript">
        function ValidationForSave() {
            if (ValidationForPatInfo() == true && ValidationForAdviceSurgeryInfo() == true && ValidationForVitalsInfo() == true && ValidationForGenPhyExamInfo() == true &&
                ValidationForComoTreatHistInfo() == true && ValidationForSubsAbuseHistInfo() == true && ValidationForAirwayAssmntInfo() == true && ValidationForSysExamInfo() == true &&
                ValidationForARISCATCritInfo() == true && ValidationForReviLeeCardRskInfo() == true && ValidationForChildPughScrInfo() == true && ValidationForInvestInfo() == true &&
                ValidationForSpecialityRefInfo() == true && ValidationForASAScrInfo() == true && ValidationForAnaestAdvOrdInfo() == true && ValidationForAnaethesiaPlan() == true
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
                            $.messager.confirm("Confirmation", response, function (result) {
                                $.session.set('PatName', '');
                                $.session.set('PatAge', '');
                                $.session.set('PatGender', '');
                                $.session.set('PatMobile', '');
                                $.session.set('PatAge2', '');
                                $.session.set('PatMRNO', '');
                                $.session.set('PatTRANNO', '');
                                $.session.set('PatCompleted', '');
                                $.session.set('ClinicCode', "");
                                $.session.set('OutRefDrNm', '');
                                window.location.href = '../DoctorDesk/PAC'
                            });
                            $(".ui-dialog-titlebar-close").hide();
                            $('.ui-dialog-buttonset button').each(function () {
                                if ($(this).text().trim() === 'Cancel') {
                                    $(this).hide();
                                }
                            });
                        }
                        else {
                            $.messager.alert("Information", response);
                        }
                    }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $.messager.alert("Error", errorThrown);
                    },
                    complete: function () {
                        HoldOn.close();
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
        function autoResize(Id) {
            var textarea = document.getElementById(Id);
            textarea.style.height = 'auto';
            textarea.style.height = (textarea.scrollHeight + 5) + 'px';
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
                $("#" + TextBoxId).prop("readonly", false);
            }
            else {
                $("#" + TextBoxId).prop("readonly", true);
                $("#" + TextBoxId).val("");
            }
        }

        function CheckNotif(objectNm, lowerVal, UpperVal, displayMsg) {
            var obj = $('#' + objectNm);
            if (!isNaN(obj.val()) && obj.val() != "") {
                if (obj.val() < lowerVal || obj.val() > UpperVal) {
                    if (displayMsg) {
                        $.messager.alert("Information", "Critical parameter! Please notify doctor.");
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
                $("#TblARISCATInfo").show();
            }
            else if (Type == "R") {
                document.getElementById("InfoHeadLabel").innerText = "Revised Lee Cardiac Risk Info";
                $("#TblARISCATInfo").hide();
                $("#TblChildPughInfo").hide();
                $("#TblECOGInfo").hide();
                $("#TblRevLeeInfo").show();
            }
            else if (Type == "C") {
                document.getElementById("InfoHeadLabel").innerText = "Child Pugh Turcotte Score Info";
                $("#TblARISCATInfo").hide();
                $("#TblRevLeeInfo").hide();
                $("#TblECOGInfo").hide();
                $("#TblChildPughInfo").show();
            }
            else if (Type == "E") {
                document.getElementById("InfoHeadLabel").innerText = "ECOG Score Info";
                $("#TblARISCATInfo").hide();
                $("#TblRevLeeInfo").hide();
                $("#TblChildPughInfo").hide();
                $("#TblECOGInfo").show();
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
            $.alert({
                title: 'Information',
                content: Text,
                onClose: function () {
                    const el = document.getElementById(Id);
                    if (el && $(el).is(':visible')) {
                        el.focus({ preventScroll: true });
                        el.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }
                }
            });
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
        function CreatePersonalList() {
            $.confirm({
                title: 'Investigation setup',
                theme: 'supervan',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                content: '' + //
                 '<form action="" class="formName" style="height:410px;"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:-16px !important;" class="form-control" id="investigationSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtInvestigation" type="text" id="input-name" placeholder="Search Setup" class="form-control" onkeyup="SearchInvestigations()" style="" autofocus></td></tr></table></div>' +
                '<div id="divtblInvestigation" class="divtblInvestigation" style=""><table id="tblPersInvestigationlist" style="width:100%;border-top:1px solid #29884bd6 !important;" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {},
                onOpen: function () {
                    $('jconfirm-box').css('margin-top', '10px !important;')
                },
                onContentReady: function () {
                    GetpersonalisedList();
                    $(".jconfirm-buttons").hide();
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
                },
                onClose: function () {
                    $(".jconfirm-buttons").show();
                }
            });
        }

        function GetpersonalisedList() {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersInvestigationList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "" && response != "UNSUCCESSFULL") {
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td class='InvestigationName' style='padding:5px;font-size: 13px;vertical-align:middle;width:80%' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='InvestigationSetUpAddEdit(this);'></i></span></td>";
                            rows += "</tr>";
                        }
                        $('#tblPersInvestigationlist tbody').empty();
                        $('#tblPersInvestigationlist tbody').append(rows).closest('tr');
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

        function InvestigationSetUpAddEdit(obj) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">Investigation SetUp</label>' +
                 '<input  type="varchar" id="txtSetUp" maxlength="50"  placeholder="Enter SetUp Name" autofocus="autofocus" class="setUp form-control" required />' +//added length kavita
                '<br><input id="txtServiceGrpsearch" type="varchar" style="" placeholder="Search For Investigations"  class="form-control" onkeyup="SearchServiceGroup()" /> <span class="fa fa-plus fa-2x invsAddspan" title="Add free Invetigation" id="spanAddNewInvtInSetUp"></span>' +
                '<div id="divSrvcGrpSelect" style="border:1px solid gray;" ></div>' +
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
                            var chlBoxTitleLst = null;
                            chlBoxTitleLst = [];
                            $('#dblServiceHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxTitleLst.push($(this).attr('title'));
                            });
                            var strArry1 = chlBoxTitleLst.join(",");
                            if (strArry == "" && strArry1 == "") {
                                $.alert('Select at least one test ');
                                return false;
                            }
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil")) {
                                strSetUpCode = $(obj).parents("tr")[0].id;
                            }
                            if (setUp != "") {
                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: '../DoctorDesk/AddInvestnSetUp',
                                    data: { strInvestSetUpName: setUp, strInvestigationLst: strArry, strNameLst: strArry1, strSetUpCode: strSetUpCode },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtSetUp").val("");
                                            $("#txtInvestigation").val("");
                                            $.alert('Record inserted successfully');
                                            GetpersonalisedList();
                                            InvestigationInfoLoad();
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
                        $('#txtSetUp').val($(obj).parents('td').prev().text());
                    }
                    else {
                        $('#txtSetUp').focus();
                        $('#txtSetUp').val("");
                    }
                    SerivceGrpData(srvcgrpname)
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectedSetUpsInvst($(obj).parents('tr')[0].id);
                    }
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    $(".jconfirm-box-container").last().css('width', '480px');
                }
            });
            function SerivceGrpData(srvcgrpname) {
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
                HoldOn.open();//
                $.ajax({
                    type: "POST",
                    url: "<%=Url.Action("GetInvestigationList","DoctorDesk")%>",
                    data: {},
                    async: false,
                    success: function (response) {
                        FreqDataSetupList = response;
                        if (response != "") {
                            $.each(response, function (i, item) {
                                var title = item.TESTNAME;
                                var idstring = item.TESTCODE;
                                options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.TESTCODE + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>";
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
                $('#divSrvcGrpSelect').append($newDiv);
            }
        }
        function FillSelectedSetUpsInvst(strSetUpCode) {
            HoldOn.open();
            $.ajax({
                url: '../DoctorDesk/GetInvstListBySetupCode',
                data: { strSetUpCode: strSetUpCode },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {
                        $.each(response, function (i, val) {
                            if (val["CODE"] != "") {
                                $("#dblServiceHelpsrvcgrp li input#" + val["CODE"]).trigger("click");
                            }
                            else {
                                var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["TESTNAME"] + "' value='" + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["TESTNAME"] + "</label></label><li>";
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
        function SearchInvestigations() {
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("txtInvestigation");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblPersInvestigationlist");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.InvestigationName")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";

                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
        function SearchServiceGroup() {
            input = document.getElementById("txtServiceGrpsearch");
            filter = input.value.toUpperCase();
            var elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent();
            var search = false;
            search = $(elem).hasClass('display');
            if ($(input).val().length >= 3) {
                getNonFreqInChkBxList(filter);
            } else {
                elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent().parent().remove();
                var checdelem = $("#SrvcGrpdata li input[type='checkbox']:checked").parent();
                $.each(checdelem, function (j, item) {

                    var label = checdelem[j].getElementsByTagName("input")[0];
                    if (label)
                        FreqDataSetupList = FreqDataSetupList.filter(function (e, index) {

                            return FreqDataSetupList[index]["TESTCODE"].toString().trim() != label.defaultValue.toString().trim();
                        });
                });
                $.each(FreqDataSetupList, function (i, item) {
                    var title = item.TESTNAME;
                    var idstring = item.TESTCODE;
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
        function getNonFreqInChkBxList(filter) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                datatype: "json",
                url: "<%=Url.Action("GetTestList","DoctorDesk")%>",
                data: { testname: filter },
                asycn: false,
                success: function (response) {
                    NonFreqDataSetupList = response;
                    var result = response;
                    var options = "";
                    $.each(result, function (i, item) {
                        var title = item.TESTNAME;
                        var idstring = item.TESTCODE;
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.TESTCODE + "'>" + title + "</label><li>";
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
    </script>

    <%-- Print --%>
    <script type="text/javascript">
        function PrintPAC(FlagYN) {
            HoldOn.open();
            var DataToSend = {
                TranNo: TranNo,
                MRNo: MRNo,
                SpecialityYN: FlagYN != "" ? FlagYN : $("#PrintSpecialityRef").prop("checked") == true ? "Y" : "N",
                PACInvstResultYN: FlagYN != "" ? FlagYN : $("#PrintPACInvstResult").prop("checked") == true ? "Y" : "N"
            }
            $.ajax({
                url: '../DoctorDesk/PrintPACDtls',
                data: DataToSend,
                type: 'post',
                async: false,
                success: function (response) {
                    var win = window.open('../DoctorDesk/DisplayPrintPAC', "_blank", '', true);
                    win.focus();
                    HoldOn.close();
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                    HoldOn.close();
                },
                complete: function () {
                    HoldOn.close();
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
                    $.messager.alert("Error", errorThrown);
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
                $("#InvestRpt").prop("disabled", false);
                $("#CancerCareHist").prop("disabled", false);
                $("#previousPrep").prop("disabled", false);
                $("#BtnPACLogInfo").prop("disabled", false);
                $("#BtnSave").prop("disabled", true);
                $("#BtnEdit").prop("disabled", true);
                $("#BtnPrint").prop("disabled", true);
                $("#BtnPrint_Top").prop("disabled", true);
                $("#PrintSpecialityRef").prop("disabled", true);
                $("#PrintSpecialityRef_Top").prop("disabled", true);
                $("#txtAPSDate").prop("disabled", true);
                $("#txtAPSTime").prop("disabled", true);
                $("#rbtnPACNATSURGR").prop("disabled", true);
                $("#rbtnPACNATSURGE").prop("disabled", true);
                $("#rbtnPACNATSURGT").prop("disabled", true);
                $("#PrintPACInvstResult").prop("disabled", true); //priyanka 09/12/2025
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
            }
        }
    </script>

    <%-- PAC History --%>
    <script type="text/javascript">
        var PacHistListDtls = [];
        var PACHistList = '<%:Html.Raw(Model.PACHistListData)%>';
        PACHistList = PACHistList != "" ? JSON.parse(PACHistList) : [];
        function ShowHidePACHistoryIcon() {
            if (PACHistList.length > 0) {
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
        }

        function BindPACHistoryList() {
            $("#TBodyPACHist").empty();
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCCONTENT}</td>";
            $.grep(PACHistList, function (a) {
                var RplIcon = "<i class='fa fa-eye IFrameEyeIcon' onclick=\"openIframe('" + a.MRNO + "','" + a.PACCONSNO + "','" + a.PACFITDATE + "','" + a.PACFITTIME + "')\"></i>";
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
                var RplPacStatusDTTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", (a.PACFITDATE + " " + a.PACFITTIME));
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
            document.getElementById('PACHistFrameLbl').innerText = TranNo + " (" + PacDT + " " + PacTM + ")";
            const iframe = document.createElement("iframe");
            HoldOn.open();
            iframe.id = "myIframe";
            iframe.src = "../DoctorDesk/PAC?PatMRNO=" + Mrno + "&PatTRANNO=" + TranNo;
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

        function closeIframe() {
            document.getElementById('iframeMain').style.display = 'none';
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
                    $.messager.alert("Error", errorThrown);
                    HoldOn.close();
                },
                complete: function () {
                    HoldOn.close();
                }
            });
            BindPACLogList(PACLogList);
            HoldOn.close();
        }

        function BindPACLogList(PACLogList) {
            $("#TBodyPACLog").empty();
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCCONTENT}</td>";
            $.grep(PACLogList, function (a) {
                var RplModeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.ACTION);
                var RplUserTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.USERID);
                var RplCreatedOnTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.LOGDATE);
                var RplCreatedAtTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.LOGTIME);
                var RplTr = Tr.replace("{TRCONTENT}", (RplModeTd + RplUserTd + RplCreatedOnTd + RplCreatedAtTd));
                $("#TBodyPACLog").append(RplTr);
            });
        }
    </script>

</asp:Content>
