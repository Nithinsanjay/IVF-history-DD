<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.OncologyModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <script type="text/javascript">
           var validationConfig = {
               Weight: '<%= System.Configuration.ConfigurationManager.AppSettings["VALIDATE_WEIGHT"] %>',
               Height: '<%= System.Configuration.ConfigurationManager.AppSettings["VALIDATE_HEIGHT"] %>',
               BP: '<%= System.Configuration.ConfigurationManager.AppSettings["VALIDATE_BP"] %>',
               RR: '<%= System.Configuration.ConfigurationManager.AppSettings["VALIDATE_RR"] %>',
               SPO2: '<%= System.Configuration.ConfigurationManager.AppSettings["VALIDATE_SPO2"] %>',
               RBS: '<%= System.Configuration.ConfigurationManager.AppSettings["VALIDATE_RBS"] %>',
               TEMP: '<%= System.Configuration.ConfigurationManager.AppSettings["VALIDATE_TEMP"] %>',
               PLUSE: '<%= System.Configuration.ConfigurationManager.AppSettings["VALIDATE_PLUSE"] %>',
               NUTRI: '<%= System.Configuration.ConfigurationManager.AppSettings["VALIDATE_NUTURATION"] %>'

           };
       </script>

    <div id="MainDiv">

        <%--	  <a href="#test1" style="font-size:10px;">Treatment Advice</a>--%>
        <%--<img src="../Images/backfornonPage.png" />--%>
        <div style="width: 100%; text-align: center">
            <a class="button1 button1-green" id="divForBack" style="margin-bottom: 5px;" onclick="SetpageDirctn()">
                <i class="fa fa-arrow-left"></i>
                <strong>Back</strong>
            </a>

            <button id="btnSave" onclick="SaveVitals('SS');"
                style="display: inline-block; margin-left: 10px; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
                onmouseover="this.style.backgroundColor='#218838'"
                onmouseout="this.style.backgroundColor='#28a745'">
                Save
            </button>
            <div style="display: inline; float: right; margin-right: 25px; font-size: 18px;">
               <input type="checkbox" class="form-check-input" id="chkProxyVisit" onchange="EnDisableProxyCheck()" style="vertical-align: middle;margin: 0;">
               <label style="margin: 0;" for="chkProxyVisit" class="input-form-label"> - Proxy Visit</label>
            </div>


            <%-- Added by Dhananjay 20250926 --%>
          <%--  <div style="position: fixed; bottom: 10%; left: 25%; right: 15%; bottom: 5%; text-align: center; z-index: 1000;">
                <button id="btnSave" onclick="SaveVitals('SS');"
                    style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
                    onmouseover="this.style.backgroundColor='#218838'"
                    onmouseout="this.style.backgroundColor='#28a745'">
                    Save
                </button>
            </div>--%>
        </div>
        <div id="ContentHolderDiv">

            <div class="col-md-6 col-sm-12">
                <%--.............................................   .......................................--%>
                <div style="-webkit-box-shadow: 0px 0px 6px 2px #878888;" class="panel">
                    <div style="font-size: 14px;" class="panel-heading divHeads">
                        General Vitals  
                            <div id="divForReset" style="background-image: url(../Images/reset.png); background-repeat: no-repeat; height: 27px; margin-top: -18px; width: 29px;" onclick="ResetDataForVitals()" title="Reset data"></div>
                        <div id="divRollBack" style="height: 27px; margin-top: -28px; width: 86px; float: right; border: 1px solid; border-radius: 15px;" onclick="RollBackDataForVitals()" title="Rollback">
                            <label style="display: inline-block; margin-top: 2px; margin-left: 0px;">Rollback</label>
                        </div>
                    </div>

                    <div style="font-size: 12px; display: block; background: white;" class="panel-body divBody"><%-- sumayya4/8/19--%>
                              
                    <%--..........................................................................................--%>
                     <table id="tblVitals" style="float: left;;margin-left: -10px;font-size:11px;">
                            <tbody style="line-height: 1.9">
                                <tr>
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">Weight</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtCurrWeight"  type="text" class="form-control input-form-control" style="padding-left:5px;padding-right:0px;" name="msg" placeholder="Weight" value="0"  oninput="validateWeightHeight(this,'300')"autocomplete="off">
                                            <span class="input-group-addon input-form-addon">Kg</span>
                                            <select class="form-control" id="cmbWeight" style="height: 24px !important;padding: 0;width: 145px;">
                                                <option value="" selected></option>
                                                <option value="01">Measured</option>
                                                <option value="02">As per history given</option>
                                                <option value="03">Approximate</option>
                                                <option value="04">Not able to check</option>
                                            </select>
                                        </div>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;">Prev Weight</label>
                                    </td>

                                    <%--<td>
                                    <input type="text" id="txtPrev" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 147px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td>
                                    <input type="text" value="Kg" style="width: 20px; margin-left: -21px; font-weight: bold; background-color: #f1efef; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" readonly>
                                </td>--%>
                                    <td colspan="3"  >
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtPrev" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Prev Weight" readonly="readonly">
                                            <span class="input-group-addon input-form-addon">Kg</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;">Weight Loss/ Gain</label>
                                    </td>

                                    <%--                                <td>
                                    <input type="text" id="txtWghtLG" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 165px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td>
                                    <input type="text" value="Kg" style="width: 20px; margin-left: -21px; font-weight: bold; background-color: #f1efef; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" readonly>
                                </td>--%>
                                    <td colspan="3">
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtWghtLG" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Weight Loss" readonly="readonly">
                                            <span class="input-group-addon input-form-addon">Kg</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label" style="padding-left: 0px !important;">Prev Height</label>
                                    </td>
                                    <td colspan="3">
                                        <div class="input-group" style="width: 85%;">
                                            <input id="txtPrevHeight" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Prev Height" readonly="readonly">
                                            <span class="input-group-addon input-form-addon">cm</span>
                                        </div>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td>
                                        <label class="input-form-label" style="padding-left: 0px !important;">Height</label></td>
                                <%-- <td>
                                    <input type="text" id="txtHeight" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 165px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td>
                                    <input type="text" value="ft" style="width: 20px; margin-left: -21px; font-weight: bold; background-color: #f1efef; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" readonly>
                                </td>--%>
                                    <td colspan="3">
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtHeight"  type="text" class="form-control input-form-control"  style="padding-left:5px;padding-right:0px;"  name="msg" placeholder="Height" value="0"  oninput="validateWeightHeight(this,'300')" autocomplete="off">
                                            <span class="input-group-addon input-form-addon">cm</span>
                                            <select class="form-control" id="cmbHeight" style="height: 24px !important;padding: 0;width: 145px;">
                                                <option value="" selected></option>
                                                <option value="01">Measured</option>
                                                <option value="02">As per history given</option>
                                                <option value="03">Approximate</option>
                                                <option value="04">Not able to check</option>
                                            </select>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;">Temp</label>
                                    </td>                                 
                                    <td colspan="3">
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtTemp"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Temperature" value="0" autocomplete="off">
                                            <span class="input-group-addon input-form-addon"> &#x2109;</span><%--DEGREE FAHRENHEIT--%>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;">Pulse</label>
                                    </td>
                                    <%--<td>
                                    <input type="text" id="txtPulse" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 165px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td></td>--%>
                                    <td colspan="3">
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtPulse" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Pulse" autocomplete="off" >
                                            <span class="input-group-addon input-form-addon">bpm</span>
                                        </div>
                                        <div class="btn-group btn-toggle" id="divPulseCond" data-toggle="buttons" style="width: 85%;margin-bottom:3px;">
                                            <button class="btn btn-xs btn-info active" id="btnPulseReg" style="width: 50%">Regular Pulse</button>
                                            <button class="btn btn-xs btn-default" id="btnPulseIReg" style="width: 50%">Irregular Pulse</button>
                                            <input type="hidden" id="hdnPulseCond" value="R" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
    <td>
        <label class="input-form-label" style="padding-left: 0px !important;">RR</label>
    </td>
    <td colspan="3">
        <div class="input-group" style="width: 85%;">
            <input id="txtResp" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Respiratory" style="width: 100%;" autocomplete="off">
            <span class="input-group-addon input-form-addon" style="padding: 0px !important;">Breaths/Minutes</span>
        </div>
    </td>
</tr>


<tr>
    <td>
        <label class="input-form-label" style="padding-left: 0px !important;">BP</label>
    </td>
    <td colspan="2">
        <input type='text' class='triggerInputBP form-control input-form-control' style="width: 35%; display: inline-block" id='SelSystolic' />
        <label style="width: 13%; text-align: center; margin-left: 0px; display: inline-block">/</label>
        <input type='text' class='triggerInputBP form-control input-form-control' style="width: 35%; display: inline-block" id='SelDiastolic' />
    </td>
                                </tr>
                                 <%--  added by vijeta on 21st aug 2018--%>
                                <tr>
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;">SpO2</label>
                                    </td>                                 
                                    <td colspan="3">
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtSPO2"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="SpO2" style="width:100%;" autocomplete="off">
                                               <span class="input-group-addon input-form-addon">%</span>
                                        </div>
                                    </td>
                                </tr>
                          
                                  <tr>
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">BMI</label>
                                    </td>
                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtBMI"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Body Mass Index" readonly>
                                            <span class="input-group-addon input-form-addon" style="padding: 0px !important;">kg/(m<sup>2</sup>)</span>
                                        </div>
                                    </td>

                                </tr>

                                 <tr>
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">BSA</label>
                                    </td>
                                    <td colspan="3">
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtBSA"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Body Surface Area" readonly>
                                            <span class="input-group-addon input-form-addon">m<sup>2</sup></span>
                                        </div>
                                    </td>
                                </tr>

                                  <tr id="trHeadCircmfr">
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">Head Circumference</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtHeadCirc"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Head Circumference" >
                                            <span class="input-group-addon input-form-addon">cm</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr id="trRBS">
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">RBS</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtRBS"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Random Blood Sugar" autocomplete="off">
                                            <span class="input-group-addon input-form-addon" style="padding: 0px !important;">mg/dl</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr id="trkarkyscore">
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">Karnofsky Score
                                            <i class="fa fa-question-circle" style="font-size: 14px;margin-right: 10px;color: #000000;cursor: pointer;padding-left: 5px;" id="PopKarno" title="Karnofsky Score Information" onclick="OpenPopInfoGuide('K')" aria-hidden="true"></i>
                                        </label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtkarkyscore"  type="text" maxlength="3" onkeyup="MaxValidation(this.id)" class="form-control input-form-control" name="msg" placeholder="Karnofsky Score" >
                                            <span class="input-group-addon input-form-addon">%</span>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trEcogScore">
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">ECOG Score                                    
                                            <i class="fa fa-question-circle" style="font-size: 14px;margin-right: 10px;color: #000000;cursor: pointer;padding-left: 5px;" id="PopECOG" title="ECOG Score Information" onclick="OpenPopInfoGuide('E')" aria-hidden="true"></i>
                                        </label>
                                    </td>
                                    <td colspan="3">
                                        <div class="input-group"  style="width: 85%;display: flex;align-items: center;">
                                            <input type="radio" style="margin: 0px;" name="rbtnECOG" id="rbtnECOG0" value="0" />
                                            <label for="rbtnECOG0" style="margin: 0px;padding: 0px 10px;cursor: pointer;">0</label>
                                            <input type="radio" style="margin: 0px;" name="rbtnECOG" id="rbtnECOG1" value="1" />
                                            <label for="rbtnECOG1" style="margin: 0px;padding: 0px 10px;cursor: pointer;">1</label>
                                            <input type="radio" style="margin: 0px;" name="rbtnECOG" id="rbtnECOG2" value="2" />
                                            <label for="rbtnECOG2" style="margin: 0px;padding: 0px 10px;cursor: pointer;">2</label>
                                            <input type="radio" style="margin: 0px;" name="rbtnECOG" id="rbtnECOG3" value="3" />
                                            <label for="rbtnECOG3" style="margin: 0px;padding: 0px 10px;cursor: pointer;">3</label>
                                            <input type="radio" style="margin: 0px;" name="rbtnECOG" id="rbtnECOG4" value="4" />
                                            <label for="rbtnECOG4" style="margin: 0px;padding: 0px 10px;cursor: pointer;">4</label>
                                            <input type="radio" style="margin: 0px;" name="rbtnECOG" id="rbtnECOG5" value="5" />
                                            <label for="rbtnECOG5" style="margin: 0px;padding: 0px 10px;cursor: pointer;">5</label>
<%--                                            <input id="txtEcogScore"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="ECOG score" >--%>
<%--                                            <span class="input-group-addon input-form-addon"></span>--%>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trDailyWalk">
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;">Daily Walking ?</label>
                                    </td>
                                    <td colspan="3">
                                        <div class="btn-group btn-toggle" id="divWalking" style="float: left;width: 37%;">
                                            <button class="btn btn-xs btn-default" id="btnWalkY">YES</button>
                                            <button class="btn btn-xs btn-info active" id="btnWalkN">NO</button>
                                            <input type="hidden" id="hdnWalkingYN" value="N" />
                                        </div>
                                        <div style="width: 100%; float: right; margin-right: 11px;display:none" id="divWalkingNoInfo">

                                            <div style="float: right; margin-top: -23px; margin-right: 50px; margin-left: -155px;">
                                                <label id="lblDuration">Duration</label>
                                                <span data-toggle="tooltip" title="" class="badge bg-aqua" style="height: 25px; padding-top: 7px;" id="divDurationNum"><%----%>
                                                    <a class="trigger2" href="javascript:;" data-layer-id="layer-Numbers" id="Numbers" style="color: white">0</a>
                                                </span>
                                                <div id="layer-Numbers" class="po__layer list">
                                                </div>
                                            </div>
                                            <div style="float: right; margin-top: -23px; margin-right: -10px;" id="divDurationDays">
                                                <span data-toggle="tooltip" title="" class="badge bg-aqua" data-original-title="3 New Messages" style="width: 60px; height: 25px; padding-top: 7px;">
                                                    <a class="trigger1" href="javascript:;" data-layer-id="layer-DMY" id="DaySelect" style="text-decoration: none; color: white">Days</a>
                                                </span>

                                                <div id="layer-DMY" class="po__layer list">
                                                    <a href="javascript:;" style="font-weight: 500; font-size: 16px" onclick="SetText('Days')">Days</a>
                                                    <a href="javascript:;" style="font-weight: 500; font-size: 16px" onclick="SetText('Weeks')">Weeks</a>
                                                    <a href="javascript:; " style="font-weight: 500; font-size: 16px" onclick="SetText('Months')">Months</a>
                                                    <a href="javascript:;" style="font-weight: 500; font-size: 16px" onclick="SetText('Years')">Years</a>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trOnDiet">
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;">On Diet</label></td>
                                    <td colspan="3">
                                        <div class="btn-group btn-toggle" id="divDiet">
                                            <button class="btn btn-xs btn-default" id="btnDietY">YES</button>
                                            <button class="btn btn-xs btn-info active" id="btnDietN">NO</button>
                                            <input type="hidden" id="hdnDietYN" value="N" />
                                        </div>
                                    </td>
                                </tr>
                                <tr  id="trRegMed">
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;">Regular Medicine</label></td>
                                    <td colspan="3">
                                        <div class="btn-group btn-toggle" id="divRegMedicineYN">
                                            <button class="btn btn-xs btn-default" id="btnRegMedY">YES</button>
                                            <button class="btn btn-xs btn-info active" id="btnRegMedN">NO</button>
                                            <input type="hidden" id="hdnRegMedYN" value="N" />
                                        </div>
                                    </td>
                                </tr>
                                <%-- Below Code Added by Murali on 25/05/2024 --%>
                                <%-- **************************************************************************************************************** --%>
                                <tr id="trIBW">
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">IBW</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtIBW"  type="text" maxlength="6" class="form-control input-form-control" name="msg" placeholder="IBW" >
                                            <span class="input-group-addon input-form-addon"></span>
                                        </div>
                                    </td>
                                </tr>
                                 <tr id="trBWPerc">
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">BW %</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtBWPerc"  type="text" maxlength="6" class="form-control input-form-control" name="msg" placeholder="BW %" >
                                            <span class="input-group-addon input-form-addon"></span>
                                        </div>
                                    </td>
                                </tr>
                                 <tr id="trWaist">
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">Waist Circumference</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtWaistCircum"  type="text" maxlength="6" class="form-control input-form-control" name="msg" placeholder="Waist Circumference" >
                                           <span class="input-group-addon input-form-addon">cm</span>
                                        </div>
                                    </td>
                                </tr>
                                 <tr id="trHip">
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">Hip Circumference</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtHip"  type="text" maxlength="6" class="form-control input-form-control" name="msg" placeholder="Hip Circumference" >
                                            <span class="input-group-addon input-form-addon">cm</span>
                                        </div>
                                    </td>
                                </tr>
                                 <tr id="trWHR">
                                    <td style="width: 42%;">
                                        <label class="input-form-label" style="padding-left:0px !important;">WHR</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtWHR"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="WHR" readonly >
                                            <span class="input-group-addon input-form-addon"></span>
                                        </div>
                                    </td>
                                </tr>
                                <%-- **************************************************************************************************************** --%>
                            </tbody>
                        </table>
                
                         </div></div>
               
               </div>
             <div class="col-md-6 col-sm-12" id="DivVitals2"> <%--4/8/19--%>

                    <%--....................................................................................--%>
                    <div style="-webkit-box-shadow:  0px 0px 6px 2px #878888;" class="panel">
                        <div style="font-size:14px;" class="panel-heading divHeads">
                          </div>
                        <div style="font-size:12px;display:block;background: white;" class="panel-body divBody">
                           
                               
                    <%--..........................................................................................--%>
                     <table id="tblotherVitals" style="float: left;margin-left: -10px;font-size:11px;">
                            <tbody style="line-height: 1.9">
                                <tr>
                                    <td style="width: 42%;">
                                        <label class="input-form-label">PEFR</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group">
                                            <input id="txtPerf"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="PEFR" >
                                            <span class="input-group-addon input-form-addon">lit/min</span>
                                        </div>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <label class="input-form-label">Lowest PEFR</label>
                                    </td>

                                    <%--<td>
                                    <input type="text" id="txtPrev" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 147px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td>
                                    <input type="text" value="Kg" style="width: 20px; margin-left: -21px; font-weight: bold; background-color: #f1efef; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" readonly>
                                </td>--%>
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtlowestPefr" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Lowest PEFR" readonly="readonly">
                                            <span class="input-group-addon input-form-addon">lit/min</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label">Highest PEFR</label>
                                    </td>

                                    <%--                                <td>
                                    <input type="text" id="txtWghtLG" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 165px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td>
                                    <input type="text" value="Kg" style="width: 20px; margin-left: -21px; font-weight: bold; background-color: #f1efef; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" readonly>
                                </td>--%>
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtHighestPefr" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Highest PEFR" readonly="readonly">
                                            <span class="input-group-addon input-form-addon">lit/min</span>
                                        </div>
                                    </td>
                                </tr>

                              <%--  <tr>
                                    <td>
                                        <label class="input-form-label">Technique</label></td>
                                    
                                    <td colspan="3">
                                        <div class="btn-group btn-toggle1" id="divTechnq">
                                            <button class="btn btn-xs btn-default" id="btnTechnqGood">Good</button>
                                            <button class="btn btn-xs btn-default" id="btnTechnqFair">Fair</button>
                                            <button class="btn btn-xs btn-default" id="btnTechnqPoor">Poor</button>
                                            <input type="hidden" id="hdnTechnqGFP" value="N" />
                                        </div>
                                    </td>
                                </tr>--%>
                                   <tr>
                                    <td>
                                        <label class="input-form-label">Technique</label>
                                    </td>                                 
                                   <td colspan="3">
                                        <div class="btn-group btn-toggle1" id="divTechnique" data-toggle="buttons" style="width:100%">
                                             <label class="btn btn-default borderC " style="width: 25%;">
                                                    <input type="radio" name="Technique" id="btnTechnqGood"   value="G" autocomplete="off" >
                                                     Good
                                             </label>
                                              <label class="btn btn-default borderC" >
                                                    <input type="radio" name="Technique" id="btnTechnqFair"  value="F" autocomplete="off" >
                                                     Fair
                                             </label>
                                            <label class="btn btn-default borderC">
                                                     <input type="radio" name="Technique"   id="btnTechnqPoor"  value="P"  autocomplete="off">
                                                         Poor
                                             </label>
                                              <label class="btn btn-default borderC active" style="width: 16%;">
                                                     <input type="radio" name="Technique"   id="btnTechnqNA"  value="N" autocomplete="off" checked>
                                                         NA
                                             </label>
                                        </div>
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label class="input-form-label">Compliance</label>
                                    </td>                                 
                                   <td colspan="3">
                                        <div class="btn-group btn-toggle1" id="divCompliance" data-toggle="buttons" style="width:100%" >
                                             <label class="btn btn-default borderC " style="width: 25%;">
                                                    <input type="radio" name="Compliance" value="G" autocomplete="off"  id="rbtnCompliGood">
                                                     Good
                                             </label>
                                              <label class="btn btn-default borderC" >
                                                    <input type="radio" name="Compliance" value="A" autocomplete="off" id="rbtnCompliAverage">
                                                     Average
                                             </label>
                                            <label class="btn btn-default borderC">
                                                     <input type="radio" name="Compliance" value="P" autocomplete="off" id="rbtnCompliPoor">
                                                         Poor
                                             </label>
                                             <label class="btn btn-default borderC active" style="width: 16%;">
                                                     <input type="radio" name="Compliance" value="N" autocomplete="off" id="rbtnCompliNA" checked>
                                                         NA
                                             </label>
                                        </div>
                                       
                                    </td>
                                </tr>

                                
                                 <%--  added by vijeta on 21st aug 2018--%>
                              

                     
                            </tbody>
                        </table>
                                 </div></div>
               
                   </div>
                  
                   <div class="col-md-6 col-sm-12" style="display:none;">

                    <%--....................................................................................--%>
                    <div style="-webkit-box-shadow:  0px 0px 6px 2px #878888;" class="panel">
                        <div style="font-size:14px;" class="panel-heading divHeads"> Electronic Readings
                          </div>
                        <div style="font-size:12px;display:block" class="panel-body divBody">
                           
                               
                    <%--..........................................................................................--%>
                     <table id="tblElectronicReading" style="float: left;margin-left: -10px;font-size:11px;">
                            <tbody style="line-height: 1.9">
                               <tr>
                                    <td colspan="3">
                                        <label class="input-form-label" style="padding-left:0px !important;">Temp</label>
                                    </td>                                 
                                    <td>
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txteleTemp"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Temperature" value="0">
                                            <span class="input-group-addon input-form-addon"> &#x2109;</span><%--DEGREE FAHRENHEIT--%>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="3">
                                        <label class="input-form-label" style="padding-left:0px !important;">Pulse</label>
                                    </td>
                                   
                                    <td>
                                        <div class="input-group"  style="width: 85%;">
                                            <input id="txtelePulse" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Pulse">
                                             <span class="input-group-addon input-form-addon">bpm</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="3">
                                        <label class="input-form-label" style="padding-left:0px !important;">BP</label>                                  
                                    </td>                                                               
                                    <td>
                                        <div class="input-group"  style="width: 85%;">
                                           <input type='text'class='triggerInputBP form-control'  id='eleSelSystolic' />
                                          <%-- <select id="eleSelSystolic" style="width: 90px;height: 22px;"></select>--%>
                                            <label>/</label>
                                           <input type='text'class='triggerInputBP form-control'  id='eleSelDiastolic' />
                                           <%-- <select id="eleSelDiastolic" style="width: 88px;margin-left:5px;height: 22px;"></select>--%>
                                        </div>
                                    </td>
                                </tr>
                     
                            </tbody>
                        </table>
                                 </div></div>
               
                   </div>


                   <div class="col-md-6 col-sm-12" >

                    <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888;" class="panel">
                        <div style="font-size:14px;" class="panel-heading divHeads"> Pain Score (Wong–Baker)
                          </div>
                        <div style="font-size:12px;display:block;background: white;overflow: auto;" class="panel-body divBody">
                           
                               
                    <%--..........................................................................................--%>
                     <table id="tblPainScore" style="float: left;margin-left: -10px;font-size:11px;">
                            <tbody style="text-align: center;">
                               <tr>
                                   <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/0pain.png"/></label>
                                    </td>                                 
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/1pain.png"/></label>
                                    </td> 
                                   <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/2pain.png"/></label>
                                    </td> 
                                   <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/3pain.png"/></label>
                                    </td> 
                                   <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/4pain.png"/></label>
                                    </td> 
                                   <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/5pain.png"/></label>
                                    </td>
                                </tr>
                                  <tr>
                                    <td>
                                         <input type="radio"  value="0" name="radio-pain" id="0PainRadio" />
                                        <label for="0PainRadio" class="painlbl" >0 <br/>No Pain</label>
                                    </td>                                    
                                    <td>
                                         <input type="radio"  value="1"  name="radio-pain" id="1PainRadio" />
                                        <label for="1PainRadio" class="input-form-label painlbl" >1 </br>Very Mild</label>
                                    </td> 
                                   <td>
                                       <input type="radio"  value="2"  name="radio-pain" id="2PainRadio" />
                                        <label for="2PainRadio" class="input-form-label painlbl" >2 </br>Hurts Little bit</label>
                                    </td> 
                                   <td>
                                       <input type="radio"   value="3" name="radio-pain" id="3PainRadio" />
                                        <label for="3PainRadio" class="input-form-label painlbl" >3 </br>Tolerable</label>
                                    </td> 
                                   <td>
                                        <input type="radio"  value="4"  name="radio-pain" id="4PainRadio" />
                                        <label for="4PainRadio" class="input-form-label painlbl">4 </br>Hurts Little More</label>
                                    </td> 
                                   <td>
                                       <input type="radio"  value="5" name="radio-pain" id="5PainRadio" />
                                        <label for="5PainRadio"class="input-form-label painlbl">5 </br>Very Distressing</label>
                                    </td>
                                </tr>   
                                <tr>
                                     <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/6pain.png"/></label>
                                    </td>                                 
                                    <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/7pain.png"/></label>
                                    </td> 
                                   <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/8pain.png"/></label>
                                    </td> 
                                   <td>
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/9pain.png"/></label>
                                    </td> 
                                   <td colspan ="2">
                                        <label class="input-form-label" style="padding-left:0px !important;"><img  src="../Images/PainSmiley/10pain.png"/></label>
                                    </td> 
                                </tr>
                         <tr>
                                    <td>
                                         <input type="radio"  value="6"  name="radio-pain" id="6PainRadio" />
                                        <label for="6PainRadio" class="painlbl input-form-label" >6 </br>Hurts even More</label>
                                    </td>                                 
                                    <td>
                                         <input type="radio"   value="7" name="radio-pain" id="7PainRadio" />
                                        <label for="7PainRadio" class="input-form-label painlbl" >7 </br>Very Intense</label>
                                    </td> 
                                   <td>
                                       <input type="radio"  value="8"  name="radio-pain" id="8PainRadio" />
                                        <label for="8PainRadio" class="input-form-label painlbl" >8 </br>Hurts Whole lot</label>
                                    </td> 
                                   <td>
                                       <input type="radio"  value="9" name="radio-pain" id="9PainRadio" />
                                        <label for="9PainRadio" class="input-form-label painlbl" >9 </br>Unbearable</label>
                                    </td> 
                                   <td colspan ="2">
                                       <input type="radio"  value="10" name="radio-pain" id="10PainRadio" />
                                        <label for="10PainRadio" class="input-form-label painlbl">10 </br>Hurts Worst</label>
                                    </td> 
                                   
                                </tr>
                            </tbody>
                        </table>
                                 </div></div>
               
                   </div>


                  <div class="col-sm-12" id="DivNutr">
                      <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888;" class="panel">
                          <div style="font-size: 14px;" class="panel-heading divHeads">
                              Nutritional screening
                          </div>
                          <div style="display: flex;align-items: center;padding: 5px;">
                              <label style="margin: 0px;padding: 5px;">Total</label>
                              <input style="margin: 0px;margin-left: 10px;width: 35px;" type="text" id="txtNutrSrcTotal" disabled />
                              <input style="margin: 0px;margin-left: 10px;" type="checkbox" id="chkNutrSrcNA" onclick="IsNutriScreen()" />
                              <label style="margin: 0px;padding: 5px;" for="chkNutrSrcNA" >NA</label>
                          </div>
                          <div style="font-size: 12px; display: block; background: white; overflow: auto;" class="panel-body divBody">
                              <table id="tblNutrSrc" style="float: left; margin-left: -10px; font-size: 11px;">
                                  <thead>
                                      <tr>
                                          <th>Criteria</th>
                                          <th>0</th>
                                          <th>1</th>
                                          <th>2</th>
                                          <th>3</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      <tr>
                                          <td>Decreased food intake over last 3 months</td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnD_0" onclick="CalNutrSrc()" name="DecFoodInScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="0">Severe Loss</label></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnD_1" onclick="CalNutrSrc()" name="DecFoodInScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="1">Moderate Loss</label></td>
                                          <td></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnD_3" onclick="CalNutrSrc()" name="DecFoodInScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="3">No</label></td>
                                      </tr>
                                      <tr>
                                          <td>Weight Loss in last 3 months</td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnW_0" onclick="CalNutrSrc()" name="WeighLossScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="0"> > 3 Kg</label></td>
                                          <td></td>
                                          <td></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnW_3" onclick="CalNutrSrc()" name="WeighLossScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="3">No Loss</label></td>
                                      </tr>
                                      <tr>
                                          <td>Mobility</td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnM_0" onclick="CalNutrSrc()" name="MobiliScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="0">Bed/Chair Bound</label></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnM_1" onclick="CalNutrSrc()" name="MobiliScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="1">Able to but doesn’t</label></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnM_2" onclick="CalNutrSrc()" name="MobiliScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="2">Fully Mobile</label></td>
                                          <td></td>
                                      </tr>
                                      <tr>
                                          <td>Acute Disease in last 3 months</td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnA_0" onclick="CalNutrSrc()" name="AcuteDiseaseScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="0">Yes</label></td>
                                          <td></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnA_2" onclick="CalNutrSrc()" name="AcuteDiseaseScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="2">No</label></td>
                                          <td></td>
                                      </tr>
                                      <tr>
                                          <td>Neuropsychological Problem</td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnN_0" onclick="CalNutrSrc()" name="NeuropsychoProbScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="0">Severe Dementia</label></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnN_1" onclick="CalNutrSrc()" name="NeuropsychoProbScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="1">Mild Dementia</label></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnN_2" onclick="CalNutrSrc()" name="NeuropsychoProbScore" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="2">None</label></td>
                                          <td></td>
                                      </tr>
                                      <tr>
                                          <td>Body Habits</td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnB_0" onclick="CalNutrSrc()" name="BodyHabit" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="0">Cachexic/Emaciated</label></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnB_1" onclick="CalNutrSrc()" name="BodyHabit" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="1">Thin</label></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnB_2" onclick="CalNutrSrc()" name="BodyHabit" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="2">Average</label></td>
                                          <td><label style="display: inline-block;cursor:pointer"><input id="rbtnB_3" onclick="CalNutrSrc()" name="BodyHabit" style="vertical-align: bottom; text-align: left; pointer-events: none;" type="radio" value="3">Obese</label></td>
                                      </tr>
                                  </tbody>
                              </table>
                          </div>

                          <div>
                               <label style="font-weight: 800;color: #ff0000;text-decoration: underline;">Note : </label>
                               <label style="font-weight: 800;color: #006300;">12 - 15 : Normal</label>
                               <label style="font-weight: 800;color: #af7c04;">8 – 11 : At risk of malnutrition</label>
                               <label style="font-weight: 800;color: #990000;">Below 8 : Malnourished</label>
                               <label style="display: block;font-weight: 800;">Score <12, Notify to Consultant /Refer to dietician</label>
                          </div>

                      </div>
                  </div>
                

               <div>
                    <label id="myBtn" style="background-color: transparent; float: right;    margin-right: 25%;   border-color: transparent;display:none;" title="Save">
                        <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                    </label>
                </div>

            </div>

        </div>

    <div id="POPUPInfoModal" class="EModal" style="justify-content: center; align-items: center;">
        <div class="modal-content" style="min-width: 300px;">
            <div class="ModelHeaderDiv ResultHeader">
                <label id="InfoHeadLabel"></label>
                <span id="closeARISCATBtn" class="closeMdlBtn" onclick="document.getElementById('POPUPInfoModal').style.display = 'none';">&times;</span>
            </div>
            <div class="ModelContentDiv">
                <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                    <div class="Tablewrapper" style="font-size: 12px; background: white;">
                        <table class="tblpopupList"  id="TblKarnofskyInfo">
                            <thead>
                                <tr>
                                    <th>Score</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: center;">100%</td>
                                    <td>Normal, no complaints; no evidence of disease.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">90%</td>
                                    <td>Able to carry on normal activity; minor signs or symptoms.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">80%</td>
                                    <td>Normal activity with effort; some signs or symptoms of disease.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">70%</td>
                                    <td>Cares for self; unable to carry on normal activity or do active work.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">60%</td>
                                    <td>Requires occasional assistance but able to care for most needs.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">50%</td>
                                    <td>Requires considerable assistance and frequent medical care.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">40%</td>
                                    <td>Disabled; requires special care and assistance.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">30%</td>
                                    <td>Severely disabled; hospitalization indicated, death not imminent.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">20%</td>
                                    <td>Very sick; hospitalization necessary; active supportive treatment.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">10%</td>
                                    <td>Moribund; fatal processes progressing rapidly.</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">0%</td>
                                    <td>Dead.</td>
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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <style>
        #chkProxyVisit.form-check-input {
            width: 18px;
            height: 18px;
            border-radius: 50%;
            border: 2px solid #3b5998;
            cursor: pointer;
        }

                #chkProxyVisit.form-check-input:checked {
                    background-color: #3b5998;
                    border-color: #3b5998;
                    background-image: none; /* Solid dot look */
                }
        input[type="radio"][name="radio-pain"] {
            display: none;
        }

        :checked + label:before {
            content: "" !important;
        }

        :checked + label {
            border: none;
            border-color: none;
        }

        #tblNutrSrc :checked + label:before {
            content: "" !important;
        }

        #tblPainScore :checked + label:before {
            content: "" !important;
        }

        #tblPainScore input[type="radio"]:checked + label {
            background-color: #f78888;
        }

        .painlbl {
            padding-left: 0px !important;
            background: #ddd;
            width: 75px;
            font-size: 11px !important;
            cursor: pointer;
        }

        table:not(#tblVitals) {
            width: 100%;
        }

        .switch {
            position: relative;
            display: block;
            vertical-align: top;
            width: 60px;
            height: 21px;
            padding: 3px;
            border-radius: 18px;
            cursor: pointer;
        }

        .switch-input {
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0;
        }

        .switch-label {
            position: relative;
            display: block;
            height: inherit;
            font-size: 10px;
            text-transform: uppercase;
            background: #eceeef;
            border-radius: inherit;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.12), inset 0 0 2px rgba(0, 0, 0, 0.15);
        }

            .switch-label:before, .switch-label:after {
                position: absolute;
                top: 50%;
                margin-top: -.5em;
                line-height: 1;
                -webkit-transition: inherit;
                -moz-transition: inherit;
                -o-transition: inherit;
                transition: inherit;
            }

            .switch-label:before {
                content: attr(data-off);
                right: 11px;
                color: #aaaaaa;
                text-shadow: 0 1px rgba(255, 255, 255, 0.5);
            }

            .switch-label:after {
                content: attr(data-on);
                left: 11px;
                color: #FFFFFF;
                text-shadow: 0 1px rgba(0, 0, 0, 0.2);
                opacity: 0;
            }

        .switch-input:checked ~ .switch-label {
            background: #0088cc;
            border-color: #0088cc;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.15), inset 0 0 3px rgba(0, 0, 0, 0.2);
        }

            .switch-input:checked ~ .switch-label:before {
                opacity: 0;
            }

            .switch-input:checked ~ .switch-label:after {
                opacity: 1;
            }

        .switch-handle {
            position: absolute;
            top: 4px;
            left: 4px;
            width: 20px;
            height: 20px;
            background: linear-gradient(to bottom, #FFFFFF 40%, #f0f0f0);
            border-radius: 100%;
        }

            .switch-handle:before {
                content: "";
                position: absolute;
                top: 50%;
                left: 50%;
                margin: -6px 0 0 -6px;
                width: 12px;
                height: 12px;
                background: linear-gradient(to bottom, #eeeeee, #FFFFFF);
                background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF);
                border-radius: 6px;
                box-shadow: inset 0 1px rgba(0, 0, 0, 0.02);
            }

        .switch-input:checked ~ .switch-handle {
            left: 38px;
            box-shadow: -1px 1px 5px rgba(0, 0, 0, 0.2);
        }

        /* Transition
========================== */
        .switch-label, .switch-handle {
            transition: All 0.3s ease;
            -webkit-transition: All 0.3s ease;
            -moz-transition: All 0.3s ease;
            -o-transition: All 0.3s ease;
        }

        .input-form-control {
            height: 24px !important;
        }

        .input-form-addon {
            height: 24.6px;
            padding: 5px 12px !important;
            font-size: 11px !important;
        }


        Label {
            margin-left: 5px;
        }

        .input-group-addon {
            width: 30px;
        }


        .panel-body {
            width: auto !important;
            height: auto !important;
        }

        .panel-heading {
            padding: 2px 5px;
        }

        .divHeads {
            color: #f4f4f4;
            background-color: #3c8dbc;
            border-color: #ddd;
            box-shadow: none;
            font-size: 12px;
            text-align: center;
            font-weight: bold;
        }

        .btn-default:active:hover, .btn-default.active:hover {
            color: #fff;
            background-color: #31b0d5;
            border-color: #269abc;
        }

        .btn-default:active,
        .btn-default.active,
        .open > .dropdown-toggle.btn-default {
            color: #fff;
            background-color: #31b0d5;
            border-color: #269abc;
        }

        .borderC {
            width: 30%;
            height: 25px;
            padding-top: 2px;
            padding-left: 0px;
        }


        #tblNutrSrc {
            border-collapse: collapse;
            width: 100%;
            font-family: Arial, sans-serif;
            font-size: 12px;
            margin-left: -10px;
        }

            #tblNutrSrc th, #tblNutrSrc td {
                border: 1px solid #ccc;
                padding: 6px 8px;
                text-align: left;
                vertical-align: top;
                min-width: 150px;
            }

            #tblNutrSrc th {
                background-color: #f2f2f2;
                font-weight: bold;
                text-align: center;
            }

            #tblNutrSrc tbody tr:nth-child(even) {
                background-color: #fafafa;
            }

            #tblNutrSrc label {
                display: inline-block;
                margin: 0;
                padding: 0;
            }

            #tblNutrSrc input[type="radio"] {
                vertical-align: middle;
                margin-right: 4px;
            }
    </style>
   
    <script src="../Scripts/PatList.js"></script>
     <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var ageOfPat = $.session.get('PatAge2'); //vijeta 17th may 2019
        var pathFrom = "";
        var Type = "V"; //Added By Rajan
        var HidePulseType = '<%:OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("HidePulseType")%>';


        $(document).ready(function (e) {


            if (HidePulseType == "Y") {
                $("#divPulseCond").hide();
            }
            else {
                $("#divPulseCond").show();
            }
            $(document).on('change', '#cmbWeight', function () {
                let val = $(this).val(); console.log("Weight changed:", val);
                if (val === '04') {
                    $('#txtCurrWeight').val('').prop('disabled', true);
                } else {
                    var sessionPatStatus = sessionStorage.getItem('PatCompleted');
                    if (sessionPatStatus != "Y") {
                        $('#txtCurrWeight').prop('disabled', false);
                    }
                }
            });

            $(document).on('change', '#cmbHeight', function () {
                let val = $(this).val();
                if (val === '04') {
                    $('#txtHeight').val('').prop('disabled', true);
                } else {
                    var sessionPatStatus = sessionStorage.getItem('PatCompleted');
                    if (sessionPatStatus != "Y") {
                        $('#txtHeight').prop('disabled', false);
                    }
                }
            });


            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');
            SetPatientDtl();
            var tranNo = $.session.get('PatTRANNO');
            for (var i = 1; i <= 30; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' onclick='SetNumber(" + i + ");' style='font-weight:500;font-size:16px' id='NumDaysSc'>" + i + "</a>";
                $("#layer-Numbers").append(s);
            }

            //vijeta 17th may 2019
            if (typeof ageOfPat != "undefined") {//
                if (Number(ageOfPat.substr(0, ageOfPat.indexOf(":"))) <= 18)
                    $("#trHeadCircmfr").show();
                else
                    $("#trHeadCircmfr").hide();
            }
          
            SetDataForVitals(tranNo);
            SetWeightLoss();

            $('.trigger1').po({
                alignment: 'center'
            });
            $('.trigger2').po({
                alignment: 'center'
            });

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                $("#slide_sdList").click();
                ActiveMenu("Vitals");
            }
            if ($(window).width() >= 1200) {
                $("#tabMenu").css("display", "block");
            }

            if (pathFrom != "") {//
                $("#divForBack").hide();
                $('#menuBar').removeAttr('disabled');
            }
            else {
               
                $("#divForBack").show()

                var leftSideNenuLst = document.getElementById('menuList');
                var rightSideMenuLst = document.getElementById('sideList');
                leftSideNenuLst.style.display = "none";
                rightSideMenuLst.style.display = "none";
                $("#Complaint").hide();
                $("#Examination").hide();
                $("#Diagnosis").hide();
                $("#RxDesktop").hide();
                $("#Investigation").hide();
                $("#RxNewSearch").hide();
                $("#PatAdviceLi").hide();
                $("#PresPrint").hide();
                $("#PresClinicalNotes").hide();
                $("#PresChemo").hide();
                $("#Vitals").hide();
                $('#menuBar').attr('disabled', 'disabled');

                $("#trHeadCircmfr").hide();
                $("#trkarkyscore").hide();
                $("#trEcogScore").hide();
                $("#trDailyWalk").hide();
                $("#trOnDiet").hide();
                $("#trRegMed").hide();
                $("#trIBW").hide();
                $("#trBWPerc").hide();
                $("#trWaist").hide();
                $("#trHip").hide();
                $("#trWHR").hide();
                $("#trDailyWalk").hide();
                $("#DivVitals2").hide();

                $("#txtkarkyscore").prop("disabled", true);
                $(".input-group input[type='radio']").prop("disabled", true);
                $("#divWalking button").prop("disabled", true);
                $("#divWalkingNoInfo").css({"pointer-events": "none","opacity": "0.6" });
                $("#divDiet button").prop("disabled", true);
                $("#divRegMedicineYN button").prop("disabled", true);
                $("#txtIBW").prop("disabled", true);
                $("#txtBWPerc").prop("disabled", true);
                $("#txtWaistCircum").prop("disabled", true);
                $("#txtHip").prop("disabled", true);
                $("#txtWHR").prop("disabled", true);
                $("#txtPerf").prop("disabled", true);
                $("#txtlowestPefr").prop("disabled", true);
                $("#txtHighestPefr").prop("disabled", true);
                $("#divTechnique").css({ "pointer-events": "none", "opacity": "0.6" });
                $("#divCompliance").css({ "pointer-events": "none", "opacity": "0.6" });
               //Added by Devendra 03/04/26
               var sessionPatStatus = sessionStorage.getItem('PatCompleted');
               if (sessionPatStatus == "Y") {
                   var $mainDiv = $("#ContentHolderDiv");
                   $mainDiv.find("input, select, textarea").prop("disabled", true);
                   $mainDiv.find("button").prop("disabled", true);
                   $mainDiv.find(".btn, .btn-toggle, .btn-toggle1").css({
                       "pointer-events": "none",
                       "opacity": "0.6"
                   });
                   $mainDiv.find("*").css("pointer-events", "none");
                   $mainDiv.css("pointer-events", "auto");
               }
           }
            ////06-12-2019 17:15
            $("#txtCurrWeight,#txtHeight").on('keyup', function (e) {
                if (event.keyCode == 46 || event.keyCode == 8) {
                    $('#txtBMI').val(""); $('#txtBSA').val("");
                }
            });
            
            $("#myBtn").click(function () {
                SaveVitals();
            });

            $("#txtCurrWeight").on("blur", function () {
                SetWeightLoss();
                CalBMI(); 
            });

            $("#txtHeight").change(function () {
                CalBMI(); 
            });

            $("#txtWaistCircum").change(function () {
                CalWHR();
            });

            $("#txtHip").change(function () {
                CalWHR();
            });

            $('.btn-toggle').click(function () {
                $(this).find('.btn').toggleClass('active');

                if ($(this).find('.btn-primary').size() > 0) {
                    $(this).find('.btn').toggleClass('btn-primary');
                }
                if ($(this).find('.btn-danger').size() > 0) {
                    $(this).find('.btn').toggleClass('btn-danger');
                }
                if ($(this).find('.btn-success').size() > 0) {
                    $(this).find('.btn').toggleClass('btn-success');
                }
                if ($(this).find('.btn-info').size() > 0) {
                    $(this).find('.btn').toggleClass('btn-info');
                }

                $(this).find('.btn').toggleClass('btn-default');

            });

            $("#divWalking").click(function () {
                var walkngYNVal = $(this).find('.active').text().substr(0, 1);
                $("#hdnWalkingYN").val(walkngYNVal);
            });

            $("#divDiet").click(function () {
                $("#hdnDietYN").val($(this).find('.active').text().substr(0, 1));
            });

            $("#divRegMedicineYN").click(function () {
                $("#hdnRegMedYN").val($(this).find('.active').text().substr(0, 1));
            });

            $("#divPulseCond").click(function () {
                $("#hdnPulseCond").val($(this).find('.active').text().substr(0, 1));
            });

            $('#txtCurrWeight,#txtHeight,#txtTemp,#txtPulse,#txtSPO2,#txtBMI,#txtBSA,#txtHeadCirc,#txtPerf,#txtRBS,#txtkarkyscore,#txtIBW,#txtBWPerc,#txtWaistCircum,#txtHip,#txtWHR').blockInput({ regex: '[0-9.]' });// #txtSPO2 added by vijeta on 20th aug 2018

            // added by vijeta on 13th april 2018
            $("#divDurationNum").click(function () {
                document.getElementById('layer-DMY').style.display = "none";
                document.getElementById('layer-Numbers').style.display = "block";
                ($('#layer-Numbers')).removeClass('is-active');
            });
            $("#divDurationDays").click(function () {
                document.getElementById('layer-Numbers').style.display = "none";
                document.getElementById('layer-DMY').style.display = "block";
                ($('#layer-DMY')).removeClass('is-active');
            });

            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys

            if (ageOfPat != undefined) {
                if (Number(ageOfPat.substr(0, ageOfPat.indexOf(":"))) <= 18) {
                    $("#txtHeadCirc").removeAttr("disabled");
                }
                else {
                    $("#txtHeadCirc").attr("disabled", "disabled");
                }
            }
            else {
                $("#txtHeadCirc").attr("disabled", "disabled");
            }

            $("#txtCurrWeight").focus();

            $(".triggerInputBP").on("input", function () {
                $(this).val($(this).val().replace(/\D/g, ''));
                if ($(this).val() > 300) {
                    $(this).val(300);
                }
            });
            $(".triggerInputBP").attr('maxlength', '3');

            $("#txtCurrWeight").change(function () {
                var val = $(this).val();
                if (val != "" && !isNaN(val)) {
                    $(this).val(parseFloat(val).toFixed(2));
                }
                if (val == '04') {
                    $('#txtCurrWeight').prop('disabled', true).val('');
                }
                else {
                    $('#txtCurrWeight').prop('disabled', false);
                }
                SetWeightLoss();
                CalBMI();
            });

            $("#txtHeight").change(function () {
                var val = $(this).val();
                if (val != "" && !isNaN(val)) {
                    $(this).val(parseFloat(val).toFixed(2));
                }
                if (val == '04') {
                    $('#txtHeight').prop('disabled', true).val('');
                }
                else {
                    $('#txtHeight').prop('disabled', false);
                }
                CalBMI();
            });

            $("#btnWalkY").click(function () {
                document.getElementById('divWalkingNoInfo').style.display = "block";
            });

            $("#btnWalkN").click(function () {
                document.getElementById('divWalkingNoInfo').style.display = "none";
                $("#Numbers").text("0");
                $("#DaySelect").text("Days");
            });
            
            if (sessionStorage.getItem("PatCompleted") === "Y") {
                $("#btnSave").css('display', 'none');
            }
            else {
                $("#btnSave").css('display', 'inline-block');
            }
            
            $(document).on("blur", "#txtTemp", function () {

                var val = $.trim($(this).val());

                if (val === "")
                    return;

                var num = parseFloat(val);

                if (!isNaN(num)) {
                    $(this).val(num.toFixed(1));
                }
            });
            
        });
          
        function CalBMI() {
            var sum = 0;
            if ($("#txtCurrWeight").val() != 0 && $("#txtHeight").val() != 0) {
                sum = Number($("#txtCurrWeight").val()) / (((Number($("#txtHeight").val())) / 100) * ((Number($("#txtHeight").val())) / 100));
            }
            $('#txtBMI').val(sum.toFixed(2));
            CalBSA();
        }

        function CalBSA() {
            var height = parseFloat($("#txtHeight").val());
            var weight = parseFloat($("#txtCurrWeight").val());

            var myBSA = Math.sqrt((weight * height) / 3600);

            var bsa = myBSA.toFixed(2);

            if (isNaN(bsa)) bsa = 0;

            $('#txtBSA').val((bsa));
        }

        function CalWHR() {
            var sum = 0;
            if ($("#txtWaistCircum").val() != 0 && $("#txtHip").val() != 0) {
                sum = Number($("#txtWaistCircum").val()) / Number($("#txtHip").val());
            }
            $('#txtWHR').val(sum.toFixed(2));
        }

        function AddOptionsToBPSelect() {
            // added by vijeta on 13th april 2018
            var emptyElement = document.createElement("option");
            emptyElement.text = "";
            emptyElement.value = "";
            emptyElement.selected = true;


            document.getElementById("SelSystolic").add(emptyElement);
            for (var i = 0; i <= 300; i++) {
                var selectElem = document.getElementById("SelSystolic");
                var element = document.createElement("option");
                element.text = i;
                element.value = i;
                //if (i == 120) { // commented by vijeta on 13th april 2018
                //    element.selected = true;
                //}
                selectElem.add(element);
            }

            // added by vijeta on 13th april 2018
            var emptyElement1 = document.createElement("option");
            emptyElement1.text = "";
            emptyElement1.value = "";
            emptyElement1.selected = true;

            document.getElementById("SelDiastolic").add(emptyElement1);
            for (var i = 0; i <= 300; i++) {
                var selectElem = document.getElementById("SelDiastolic");
                var element = document.createElement("option");
                element.text = i;
                element.value = i;
                //if (i == 80) {// commented by vijeta on 13th april 2018
                //    element.selected = true;
                //}
                selectElem.add(element);
            }
        }


        //-----vishal-----
         function AddOptionsToELEBPSelect() {
             // added by vijeta on 13th april 2018
             var emptyElement = document.createElement("option");
             emptyElement.text = "";
             emptyElement.value = "";
             emptyElement.selected = true;


             document.getElementById("eleSelSystolic").add(emptyElement);
             for (var i = 80; i <= 200; i++) {
                 var selectElem = document.getElementById("eleSelSystolic");
                 var element = document.createElement("option");
                 element.text = i;
                 element.value = i;
                 selectElem.add(element);
             }

             // added by vijeta on 13th april 2018
             var emptyElement1 = document.createElement("option");
             emptyElement1.text = "";
             emptyElement1.value = "";
             emptyElement1.selected = true;

             document.getElementById("eleSelDiastolic").add(emptyElement1);
             for (var i = 50; i <= 120; i++) {
                 var selectElem = document.getElementById("eleSelDiastolic");
                 var element = document.createElement("option");
                 element.text = i;
                 element.value = i;
                 selectElem.add(element);
             }
         }

        function SetpageDirctn() {
            if (pathFrom == "") {
                window.location.href = '../ClinicalNotes/ClinicEntry';
            } else {
                window.location.href = '../DoctorDesk/PatientEntry';
            }
               
        }
        function checkdata() {
            if (isNaN(String.fromCharCode(event.keyCode))) return false;
            else return (event.keyCode != 32 && event.which != 32);
        }
        function ResetDataForVitals() {//27-11-19
            $("#txtWghtLG").val("");

            $("#txtCurrWeight").val("");
            $("#txtPrev").val("");
            $("#txtPrevHeight").val("");
            $("#txtHeight").val("");
            $("#cmbHeight").val("");
            $("#cmbWeight").val("");
            $("#txtTemp").val("");
            $("#txtPulse").val("");
            $("#txtSPO2").val("");
            $("#txtBMI").val("");
            $("#txtBSA").val("");
            $("#txtHeadCirc").val("");
            $("#txtRBS").val(""); $("#txtkarkyscore").val("");
            document.querySelectorAll('input[name="rbtnECOG"]').forEach(function (radio) { radio.checked = false });
            //$("#txtEcogScore").val("");
            $("#SelSystolic").val("");
            $("#SelDiastolic").val("");
            $('#txtelePulse').val("")            ///VISHAL
            $('#txteleTemp').val("");
            $("#eleSelSystolic").val("");      
            $("#eleSelDiastolic").val("");       ///VISHAL
            $("#txtResp").val("");
            $("#txtOthr").val("");
            $("#Numbers").text("0");
            $("#DaySelect").text("Days");
            $("#rbtnCompliNA").trigger("click");
            $("#btnTechnqNA").trigger("click");
            $("#txtlowestPefr").val("");
            $("#txtHighestPefr").val("");


            $("#btnWalkY").removeClass('btn btn-xs btn-info active');
            $("#btnWalkN").removeClass().addClass('btn btn-xs btn-info active');
            $("#btnWalkY").addClass('btn btn-xs btn-default');
            $("#hdnWalkingYN").val('N');

            $("#btnDietY").removeClass('btn btn-xs btn-info active');
            $("#btnDietN").removeClass().addClass('btn btn-xs btn-info active');
            $("#btnDietY").addClass('btn btn-xs btn-default');
            $("#hdnDietYN").val('N');

            $("#btnRegMedY").removeClass('btn btn-xs btn-info active');
            $("#btnRegMedN").removeClass().addClass('btn btn-xs btn-info active');
            $("#btnRegMedY").addClass('btn btn-xs btn-default');
            $("#hdnRegMedYN").val('N');

            $("#btnPulseIReg").removeClass('btn btn-xs btn-info active');
            $("#btnPulseReg").removeClass().addClass('btn btn-xs btn-info active');
            $("#btnPulseIReg").addClass('btn btn-xs btn-default');
            $("#hdnPulseCond").val('R');
            document.getElementById("divRollBack").style.display = "block"; //Added By Rajan

            $("#txtIBW").val("");
            $("#txtBWPerc").val("");
            $("#txtWaistCircum").val("");
            $("#txtHip").val("");
            $("#txtWHR").val("");
        }
        //Added By Rajan
        function RollBackDataForVitals() {
            Type = "R";
            var tranNo = $.session.get('PatTRANNO');
            ResetDataForVitals();
            if (tranNo.trim() != "") {
                SetDataForVitals(tranNo);
            }
        }
        function SetDataForVitals(tranNo) {
            var selMrno = $.session.get('PatMRNO');
            $.ajax({
                type: 'post',
                datatype: 'json',
                url: 'SetDataForVitals',
                data: { strTranNo: tranNo, Type: Type, strMRNo: selMrno }, //Added By Rajan
                success: function (data) {
                    var flagFrDataExist = false;
                    if (data != "" ) {
                        
                        if (data["Weight"] > 0) {
                            $("#txtCurrWeight").val(data["Weight"]);
                            flagFrDataExist = true;
                        }
                        else
                            $("#txtCurrWeight").val("");

                        $("#txtPrev").val(data["PrevWeight"]);
                        $("#txtPrevHeight").val(data["PrevHeight"]);

                        if (data["HEIGHT"] > 0)
                        {
                            $("#txtHeight").val(data["HEIGHT"]);
                            flagFrDataExist = true;
                        }
                        else
                            $("#txtHeight").val("");

                        $("#cmbHeight").val(data["CMBHEIGHT"] || '').trigger('change');
                        $("#cmbWeight").val(data["CMBWEIGHT"] || '').trigger('change');

                        if (data["TEMP"] > 0) {
                            $("#txtTemp").val(data["TEMP"]);
                            flagFrDataExist = true;
                        }
                        else
                            $("#txtTemp").val("");

                        if (data["PULSE"] > 0) {
                            $("#txtPulse").val(data["PULSE"]);
                            flagFrDataExist = true;
                        }
                        else
                            $("#txtPulse").val("");

                        flagFrDataExist = data["SPO2"] != ""  ? true : flagFrDataExist == false ? false : true;
                        $("#txtSPO2").val(data["SPO2"]); 
                       
                        flagFrDataExist = data["BMI"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtBMI").val(data["BMI"]); 

                        flagFrDataExist = data["HEADCIRCMF"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtHeadCirc").val(data["HEADCIRCMF"]);

                        flagFrDataExist = data["RBS"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtRBS").val(data["RBS"]);

                        flagFrDataExist = data["KARNOFSKY"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtkarkyscore").val(data["KARNOFSKY"]);

                        flagFrDataExist = data["ECOG"] != "" ? true : flagFrDataExist == false ? false : true;
                        if (data["ECOG"] != "")
                            $("#rbtnECOG" + data["ECOG"]).prop("checked", true);
                        //$("#txtEcogScore").val(data["ECOG"]);

                        flagFrDataExist = data["BMI"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtBMI").val(data["BMI"]);

                        //Below code added by Murali on 25/05/2024
                        //**********************************************************************************
                        flagFrDataExist = data["IBW"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtIBW").val(data["IBW"]);

                        flagFrDataExist = data["BWPERC"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtBWPerc").val(data["BWPERC"]);

                        flagFrDataExist = data["WAISTCIRCUM"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtWaistCircum").val(data["WAISTCIRCUM"]);

                        flagFrDataExist = data["HIPCIRCUM"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtHip").val(data["HIPCIRCUM"]);

                        flagFrDataExist = data["WHR"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtWHR").val(data["WHR"]);
                        //**********************************************************************************

                        if (data["BP"] != "" && data["BP"] != "/") {
                            var strBP = data["BP"].toString();
                            var strSystolic = strBP.substring(0, strBP.indexOf("/"));
                            var strDiastolic = strBP.substring(strBP.indexOf("/") + 1);
                            flagFrDataExist = true;
                            $("#SelSystolic").val(strSystolic);
                            $("#SelDiastolic").val(strDiastolic);
                        }

                        //-----vishal-----
                        flagFrDataExist = data["BMI"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txteleTemp").val(data["ELETEMP"]);

                        $("#txtelePulse").val(data["ELEPULSE"]);
                         if (data["ELEBP"] != "" && data["ELEBP"] != "/") {
                             var strELEBP = data["ELEBP"].toString();
                             var strELESystolic = strELEBP.substring(0, strELEBP.indexOf("/"));
                             var strELEDiastolic = strELEBP.substring(strELEBP.indexOf("/") + 1);
                             flagFrDataExist == true;
                             $("#eleSelSystolic").val(strELESystolic);
                             $("#eleSelDiastolic").val(strELEDiastolic);
                         }
                        //----vishal------

                         flagFrDataExist = data["RESP"] != "" ? true : flagFrDataExist == false ? false : true;
                         $("#txtResp").val(data["RESP"]);

                         flagFrDataExist = data["VOTHERS"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtOthr").val(data["VOTHERS"]);

                        if (data["WALKINGYN"].toString() == "Y") {
                            $("#btnWalkN").removeClass('btn btn-xs btn-info active');
                            $("#btnWalkY").removeClass().addClass('btn btn-xs btn-info active');
                            $("#btnWalkN").addClass('btn btn-xs btn-default');
                            $("#hdnWalkingYN").val('Y');
                            flagFrDataExist == true;
                            document.getElementById('divWalkingNoInfo').style.display = "block";
                        }
                        else {
                            document.getElementById('divWalkingNoInfo').style.display = "none";
                        }


                        if (data["PULSECOND"].toString() == "I") {
                            $("#btnPulseReg").removeClass('btn btn-xs btn-info active');
                            $("#btnPulseIReg").removeClass().addClass('btn btn-xs btn-info active');
                            $("#btnPulseReg").addClass('btn btn-xs btn-default');
                            $("#hdnPulseCond").val('I');
                            flagFrDataExist == true;
                        }
                        else {

                        }
                        flagFrDataExist = data["WALKINGDURATION"].toString().trim() != "" ? true : flagFrDataExist == false ? false : true;
                        if (data["WALKINGDURATION"].toString().trim() == "")
                            $("#Numbers").text("0"); 
                        else
                            $("#Numbers").text(data["WALKINGDURATION"].toString().trim());


                        flagFrDataExist = data["WALKINGDURTYPE"].toString().trim() != "" ? true : flagFrDataExist == false ? false : true;
                        if (data["WALKINGDURTYPE"] == "D")
                            $("#DaySelect").text("Days");
                        else if (data["WALKINGDURTYPE"] == "W")
                            $("#DaySelect").text("Weeks");
                        else if (data["WALKINGDURTYPE"] == "M")
                            $("#DaySelect").text("Months");
                        else if (data["WALKINGDURTYPE"] == "Y")
                            $("#DaySelect").text("Years");


                        if (data["DIETYN"].toString() == "Y") {
                            $("#btnDietN").removeClass('btn btn-xs btn-info active');
                            $("#btnDietY").removeClass().addClass('btn btn-xs btn-info active');
                            $("#btnDietN").addClass('btn btn-xs btn-default');
                            $("#hdnDietYN").val('Y');
                            flagFrDataExist == true;
                        }
                        if (data["REGULARMEDIYN"].toString() == "Y") {
                            $("#btnRegMedN").removeClass('btn btn-xs btn-info active');
                            $("#btnRegMedY").removeClass().addClass('btn btn-xs btn-info active');
                            $("#btnRegMedN").addClass('btn btn-xs btn-default');
                            $("#hdnRegMedYN").val('Y');
                            flagFrDataExist == true;
                        }
                  
                        flagFrDataExist = data["PEFR"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtPerf").val(data["PEFR"]);

                        if (data["TECHNIQUE"] == 'G') {
                            $("#btnTechnqGood").trigger("click"); flagFrDataExist == true;
                        }
                        else if (data["TECHNIQUE"] == 'F') {
                            $("#btnTechnqFair").trigger("click"); flagFrDataExist == true;
                        }
                        else if (data["TECHNIQUE"] == 'P') {
                            $("#btnTechnqPoor").trigger("click"); flagFrDataExist == true;
                        }
                        else
                            $("#btnTechnqNA").trigger("click");

                        if (data["COMPLIANCE"] == 'G') {
                            $("#rbtnCompliGood").trigger("click"); flagFrDataExist == true;
                        }
                        else if (data["COMPLIANCE"] == 'A') {
                            $("#rbtnCompliAverage").trigger("click"); flagFrDataExist == true;
                        }
                        else if (data["COMPLIANCE"] == 'P') {
                            $("#rbtnCompliPoor").trigger("click"); flagFrDataExist == true;
                        }
                        else
                            $("#rbtnCompliNA").trigger("click");

                        if (data["PAINSCORE"].toString() != "") 
                        {
                            flagFrDataExist == true;
                            $("input[name='radio-pain'][value='" + data["PAINSCORE"].toString() + "']").prop("checked", true);
                        }

                        flagFrDataExist = data["BSA"] != "" ? true : flagFrDataExist == false ? false : true;
                        $("#txtBSA").val(data["BSA"]);  //Meenakshi

                        if (flagFrDataExist == true)
                            document.getElementById("divRollBack").style.display = "none";  //Added By Rajan
                        BindNutrSrc(data);
                       if (data["PROXYVISITYN"] == "Y") {
                           $("#chkProxyVisit").prop("checked", true);
                       } else {
                           $("#chkProxyVisit").prop("checked", false);
                       }
                       $("#chkProxyVisit").trigger("change");
                    }
                    else
                    {
                        document.getElementById("divRollBack").style.display = "Block"; //Added By Rajan
                        $("#txtHeight").val(""); $("#txtCurrWeight").val(""); $("#txtTemp").val(""); $("#txtPulse").val("");
                        if (Type == "R")
                            alert("No data found for rollover on today.");
                    }
                    SetWeightLoss();
                }
            });
        }

        function SetWeightLoss()
        {
            var currWt = $("#txtCurrWeight").val();
            var prevWt = $("#txtPrev").val();
            if (currWt != "" && prevWt != "" && Number(prevWt) > 0 && Number(currWt) > 0 ) {
                var diffWt = Number(currWt) - Number(prevWt);
                diffWt = (Number(diffWt) < 0 ? "" : "+") + Number(diffWt).toFixed(2);
                $("#txtWghtLG").val(diffWt);
            }
            else
                $("#txtWghtLG").val(0);
        }

        function SaveVitals(str) {
            var flag = true;
            var isProxyVisit = $("#chkProxyVisit").is(":checked");

            var strWtRemark = $("#cmbWeight").val();
            var strHtRemark = $("#cmbHeight").val();
            var strWt = "" + $('#txtCurrWeight').val();
            var strHt = "" + $('#txtHeight').val();
            var strTp = "" + $('#txtTemp').val();

            var strSystolicVal = $("#SelSystolic").val();
            var strDiastolicVal = $("#SelDiastolic").val();

            var strRp = "" + $('#txtResp').val();
            var strSPO2 = $("#txtSPO2").val();
            var strRBS = $("#txtRBS").val();

            var strPu = "" + $('#txtPulse').val();
            var strWtRemark = $("#cmbWeight").val();
            var strHtRemark = $("#cmbHeight").val();

                if (!isProxyVisit) {
            if (validationConfig.Weight === "Y") {

                if (strWtRemark !== "04") {
                    if (strWt == "" || strWt == "0") {
                        $.alert("Please Enter Weight.");
                        return false;
                    }
                }
            }

            if (validationConfig.Height === "Y") {

                if (strHtRemark !== "04") {
                    if (strHt == "" || strHt == "0") {
                        $.alert("Please Enter Height.");
                        return false;
                    }
                }
            }

            if (validationConfig.TEMP === "Y") {
                if (strTp == "" || strTp == "0") {
                    $.alert("Please Enter Temperature.");
                    return false;
                }
            }

            if (validationConfig.PLUSE === "Y") {
                if (strPu == "" || strPu == "0") {
                    $.alert("Please Enter Pulse.");
                    return false;
                }
            }

            if (validationConfig.BP === "Y") {
                if (strSystolicVal == "" || strDiastolicVal == "") {
                    $.alert("Please Enter BP.");
                    return false;
                }
            }

            if (validationConfig.BP === "Y") {
                if (strSystolicVal == "" && strDiastolicVal != "") {
                    $("#SelSystolic").css('border-color', 'red');
                    $("#SelDiastolic").css('border-color', '');
                    flag = false;
                    strMsg = "Please enter required field";
                }
                else if (strSystolicVal != "" && strDiastolicVal == "") {
                    $("#SelSystolic").css('border-color', '');
                    $("#SelDiastolic").css('border-color', 'red');
                    flag = false;
                    strMsg = "Please enter required field";
                }
            }

            if (validationConfig.RR === "Y") {
                if (strRp == "" || strRp == "0") {
                    $.alert("Please Enter Respiratory Rate.");
                    return false;
                }
            }

            if (validationConfig.SPO2 === "Y") {
                if (strSPO2 == "" || strSPO2 == "0") {
                    $.alert("Please Enter SPO2.");
                    return false;
                }
            }

            if (validationConfig.RBS === "Y") {
                if (strRBS == "" || strRBS == "0") {
                    $.alert("Please Enter RBS.");
                    return false;
                }
            }

            if (validationConfig.NUTRI === "Y") {
                var isNA = $('#chkNutrSrcNA').prop("checked");
                if (!isNA) {
                    var selectedCount = $('#tblNutrSrc input[type=radio]:checked').length;
                    if (selectedCount === 0) {
                        $.alert("Please Complete Nutritional Screening.");
                        return false;
                    }
                    // Optional strict validation (all rows must be selected)
                    var totalQuestions = $('#tblNutrSrc tbody tr').length;
                    if (selectedCount < totalQuestions) {
                        $.alert("Please Answer All Nutritional Screening Questions.");
                        return false;
                    }
                }
            }
            var PainScore = $("input[name='radio-pain']:checked").val();

            if (!PainScore) {
                $.alert("Please Select Pain Score.");
                return false;
            }
      }
            if (PainScore == undefined)
                PainScore = "";

            var strBp = strSystolicVal + "/" + strDiastolicVal;

            // --- Electronic Readings ---
            var streleTp = "" + $('#txteleTemp').val();
            var strelePu = "" + $('#txtelePulse').val();

            var streleSystolicVal = $("#eleSelSystolic").val();
            var streleDiastolicVal = $("#eleSelDiastolic").val();

                if (!isProxyVisit) {
                    if (streleSystolicVal == "" && streleDiastolicVal != "") {
                        $("#eleSelSystolic").css('border-color', 'red');
                        $("#eleSelDiastolic").css('border-color', '');
                        flag = false;
                        strMsg = "Please enter required field";
                    }
                    
                    else if (streleSystolicVal != "" && streleDiastolicVal == "") {
                        $("#eleSelSystolic").css('border-color', '');
                        $("#eleSelDiastolic").css('border-color', 'red');
                        flag = false;
                        strMsg = "Please enter required field";
                    }
                }

            var streleBp = streleSystolicVal + "/" + streleDiastolicVal;

            var strOt = "" + $('#txtOthr').val();
            var strPrev = "" + $('#txtPrev').val();

            var strTran = ($.session.get('PatTRANNO')).toString();
            var strMr = ($.session.get('PatMRNO')).toString();

            var strWalkngYN = $("#hdnWalkingYN").val();
            var strDietYN = $("#hdnDietYN").val();
            var strMedicineYN = $("#hdnRegMedYN").val();

            var strWalkDur = $("#Numbers").text();
            var strWalkDurType = $("#DaySelect").text().substr(0, 1);

            var strPulseCond = $("#hdnPulseCond").val();

            var strBMI = $("#txtBMI").val();
            var strBSA = $("#txtBSA").val();

            var strkarkyscore = $("#txtkarkyscore").val();
            var strEcogScore = SaveForECOG();

            var strHeadCircf = $("#txtHeadCirc").length > 0 ? $("#txtHeadCirc").val() : "";

            var strPerf = $("#txtPerf").val();
            var strTech = $("div#divTechnique label[class*=active] input").val();
            var strCompli = $("div#divCompliance label[class*=active] input").val();

            var strIBW = "" + $('#txtIBW').val();
            var strBWPerc = "" + $('#txtBWPerc').val();
            var strWaistCircum = "" + $('#txtWaistCircum').val();
            var strHip = "" + $('#txtHip').val();
            var strWHR = "" + $('#txtWHR').val();

            var strCmbWeight = $("#cmbWeight").val();
            var strCmbHeight = $("#cmbHeight").val();
            var strProxyVisit = $("#chkProxyVisit").is(":checked") ? "Y" : "N";

            var dataToSend = {
                strWeight: strWt,
                strHeight: strHt,
                strTemp: strTp,
                strPulse: strPu,
                strBlood: strBp,
                strResp: strRp,
                strOther: "",
                strPrevWt: strPrev,
                strTranno: strTran,
                strMrNo: strMr,
                strWalkngYN: strWalkngYN,
                strDietYN: strDietYN,
                strMedicineYN: strMedicineYN,
                strWalkDur: strWalkDur,
                strWalkDurType: strWalkDurType,
                strSPO2: strSPO2,
                strBMI: strBMI,
                strHeadCircf: strHeadCircf,
                strPEFR: strPerf,
                strTechnique: strTech,
                strCompliance: strCompli,
                streleTemp: streleTp,
                strelePulse: strelePu,
                streleBlood: streleBp,
                strPainScore: PainScore,
                strBSA: strBSA,
                strRBS: strRBS,
                strkarkyscore: strkarkyscore,
                strEcogScore: strEcogScore,
                strPulseCond: strPulseCond,
                strIBW: strIBW,
                strBWPerc: strBWPerc,
                strWaistCircum: strWaistCircum,
                strHip: strHip,
                strWHR: strWHR,
                strCmbWeight: strCmbWeight,
                strCmbHeight: strCmbHeight,
                strProxyVisit: strProxyVisit
            };

            SaveForNutrSrc(dataToSend);

            HoldOn.open();

            if (flag) {
                $.ajax({
                    type: "POST",
                    url: 'SaveVitals',
                    datatype: "json",
                    data: dataToSend,
                    async: false,
                    success: function (result) {
                        if (str == 'SS') {
                            if (result.toUpperCase().includes("SUCCESS")) {
                                $.messager.alert("Info", result);
                                setTimeout(function () {
                                    if (pathFrom == "") {
                                        window.location.href = '../ClinicalNotes/ClinicEntry?isVitalsCompleted=Y';
                                    } else {
                                        window.location.href = '../DoctorDesk/PatientEntry';
                                    }
                                }, 2000);
                            } else {
                                $.messager.alert("Info", result);
                            }
                        }
                    },
                    complete: function () { HoldOn.close(); },
                    error: function () { HoldOn.close(); }
                });
                return true;
            } else {
                $.alert(strMsg);
                HoldOn.close();
                return false;
            }
        }

        function SetText(str) {
            $('#DaySelect').text(str);
        }
        function SetNumber(str) {
            $('#Numbers').text(str);
        }

        //Save on back button
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './Vitals');

                $(window).on('popstate', function () {
                    SaveVitals();
                });
            }

          
            FillBPList();

        });

        function FillBPList()
        {
            //To fill the autocomplete in BP text boxes.
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

        // utility jQuery plugins
        $.fn.blockInput = function (options) {
            // find inserted or removed characters
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

                // get inserted chars
                var inserted = findDelta(val, lastVal);
                // get removed chars
                var removed = findDelta(lastVal, val);
                // determine if user pasted content
                var pasted = inserted.length > 1 || (!inserted && !removed);

                if (pasted) {
                    if (!isValidString(val)) this.value = lastVal;
                }
                else if (!removed) {
                    if (!isValidChar(inserted)) this.value = lastVal;
                }

                // store current value as last value
                $(this).data('lastVal', this.value);
            }).on('focus', function () {
                $(this).data('lastVal', this.value);
            });

            return this;
        };

        function BindNutrSrc(data) {
            var NAYN = data["NutriScoreNA"];
            if (NAYN == "Y") {
                $("#chkNutrSrcNA").prop("checked", true);
                IsNutriScreen();
            }
            else {
                var DecreFood = data["NutriDescreseFoodInTake"];
                var WeightLoss = data["NutriWeightLoss"];
                var Mobility = data["NutriMobility"];
                var AcuteDis = data["NutriAcuteDisease"];
                var Neuropsy = data["NutriNeuropsy"];
                var BodyHabit = data["NutriBodyHabit"];
                $("#rbtnD_" + DecreFood).prop("checked", true);
                $("#rbtnW_" + WeightLoss).prop("checked", true);
                $("#rbtnM_" + Mobility).prop("checked", true);
                $("#rbtnA_" + AcuteDis).prop("checked", true);
                $("#rbtnN_" + Neuropsy).prop("checked", true);
                $("#rbtnB_" + BodyHabit).prop("checked", true);
                $("#chkNutrSrcNA").prop("checked", false);
                CalNutrSrc();
            }
        }

        function CalNutrSrc() {
            var total = 0; 
            $('#tblNutrSrc input[type=radio]:checked').each(function () {
                var val = parseInt($(this).val());
                if (!isNaN(val)) {
                    total += val;
                }
            });
            // $('#txtNutrSrcTotal').val(total);
            SVCSClr(total)
        }

        function IsNutriScreen() {
            if ($('#chkNutrSrcNA').prop("checked") == true) {
                $("#tblNutrSrc input[type='radio']").attr('checked', false);
                $("#tblNutrSrc input[type='radio']").attr("disabled", "disabled");
                $('#txtNutrSrcTotal').val("");
            }
            else {
                $("#tblNutrSrc input[type='radio']").prop('disabled', false);
                $("#tblNutrSrc input[type='radio']").attr('checked', false);
                $('#txtNutrSrcTotal').val("");
            }
             $('#txtNutrSrcTotal').css({ backgroundColor: "", border: "", fontWeight: "", color: "", textAlign: "" });
        }

        function SaveForNutrSrc(dataToSend) {
            dataToSend.NutriScore = $("#txtNutrSrcTotal").val();
            dataToSend.NutriScoreNA = $('#chkNutrSrcNA').prop("checked") == true ? "Y" : "N";
            dataToSend.NutriDescreseFoodInTake = $('#tblNutrSrc input[type=radio][name="DecFoodInScore"]:checked').val();
            dataToSend.NutriWeightLoss = $('#tblNutrSrc input[type=radio][name="WeighLossScore"]:checked').val(); 
            dataToSend.NutriMobility = $('#tblNutrSrc input[type=radio][name="MobiliScore"]:checked').val(); 
            dataToSend.NutriAcuteDisease = $('#tblNutrSrc input[type=radio][name="AcuteDiseaseScore"]:checked').val();
            dataToSend.NutriNeuropsy = $('#tblNutrSrc input[type=radio][name="NeuropsychoProbScore"]:checked').val();
            dataToSend.NutriBodyHabit = $('#tblNutrSrc input[type=radio][name="BodyHabit"]:checked').val(); 
        }

        function ClearECOG() {

        }

        function SaveForECOG() {
            const selected = document.querySelector('input[name="rbtnECOG"]:checked');
            if (selected) {
                return selected.value;
            }
            return "";
        }

        function ValidateHeightandWeightRemark(strNum, strRemark) {
            //if ((strNum === "" || strNum === null || strNum === "0.00") && ((strRemark != "" || strRemark != null) && strRemark != "04")) {
            if (strRemark != "" && (strRemark != "04" && (strNum == "" && Number(strNum) == 0))) {
                return false;
            }
            else {
                return true;
            }
        }

        function SVCSClr(total) {
            var $txt = $("#txtNutrSrcTotal");
            $txt.val(total);

            if (total < 8) {
                $txt.css({ backgroundColor: "#fff6f9", border: "1px solid red", fontWeight: "900", color: "red", textAlign: "center" });
            }
            else if (total >= 8 && total <= 11) {
                $txt.css({ backgroundColor: "#fff6f9", border: "1px solid #af7c04", fontWeight: "900", color: "#af7c04", textAlign: "center" });
            }
            else if (total >= 12 && total <= 15) {
                $txt.css({ backgroundColor: "#fff6f9", border: "1px solid #006300", fontWeight: "900", color: "#006300", textAlign: "center" });
            }
        }

        function validateWeightHeight(input, maxValue) {
            input.value = input.value.replace(/[^0-9.]/g, '');
            if ((input.value.match(/\./g) || []).length > 1) {
                input.value = input.value.slice(0, -1);
                return;
            }
            if (input.value === "") return;
            let value = parseFloat(input.value);
            if (!isNaN(value) && value > Number(maxValue)) {
                input.value = maxValue;
            }
        }

        function EnDisableProxyCheck() {
            if ($("#chkProxyVisit").prop("checked")) {
                var $mainDiv = $("#ContentHolderDiv");
                $mainDiv.find("input, select, textarea").prop("disabled", true);
                $mainDiv.find("button").prop("disabled", true);
                $mainDiv.find(".btn, .btn-toggle, .btn-toggle1").css({
                    "pointer-events": "none",
                    "opacity": "0.6"
                });
                $mainDiv.find("*").css("pointer-events", "none");
                $mainDiv.css("pointer-events", "auto");
                //Clear Values
                $mainDiv.find("input:text").val("");
                $mainDiv.find("textarea").val("");
                $mainDiv.find("select").val("");
                $mainDiv.find("input:checkbox, input:radio").prop("checked", false);
            }
            else {
                var $mainDiv = $("#ContentHolderDiv");
                $mainDiv.find("input, select, textarea").prop("disabled", false);
                $mainDiv.find("button").prop("disabled", false);
                $mainDiv.find(".btn, .btn-toggle, .btn-toggle1").css({
                    "pointer-events": "auto",
                    "opacity": "1"
                });
                $mainDiv.find("*").css("pointer-events", "auto");
                $("#txtNutrSrcTotal").prop("disabled", true);
                if ($("#chkNutrSrcNA").prop("checked")) {
                    $("#tblNutrSrc input[type='radio']").prop("disabled", true);
                }
            }
        }
    </script>

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
                border: 1px solid #c9c9c9;
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
                }
    </style>
    <script type="text/javascript">
        function OpenPopInfoGuide(Type) {
            if (Type == "E") {
                document.getElementById("InfoHeadLabel").innerText = "ECOG Score Info";
                $("#TblKarnofskyInfo").hide();
                $("#TblECOGInfo").show();
            }
            else if (Type == "K") {
                document.getElementById("InfoHeadLabel").innerText = "Karnofsky Score Info";
                $("#TblECOGInfo").hide();
                $("#TblKarnofskyInfo").show();
                
            }
            document.getElementById("POPUPInfoModal").style.display = "flex";
        }

        function MaxValidation(Id) {
            if (Number($("#" + Id).val()) > 100) {
                $("#" + Id).val("100");
            }
        }
    </script>

</asp:Content>
