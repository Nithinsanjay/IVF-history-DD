<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style type="text/css">
    /* Full-Screen IVF History Popup */
    #Hist_M_IVFHistory {
        position: fixed !important;
        top: 50% !important;
        left: 50% !important;
        transform: translate(-50%, -50%) !important;
        width: 96vw !important;
        max-width: 1600px !important;
        height: 92vh !important;
        max-height: 92vh !important;
        background: #ffffff !important;
        border: 1px solid #444 !important;
        border-radius: 8px !important;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.45) !important;
        z-index: 1250 !important;
        display: none;
        flex-direction: column;
        overflow: hidden !important;
        margin: 0 !important;
    }

    /* 1. Header Bar: Title on left, Close button on right */
    .ivf-popup-header {
        background: #343a40;
        color: #fff;
        padding: 10px 18px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-shrink: 0;
        border-radius: 8px 8px 0 0;
    }

    /* 2. Scrollable Body */
    .ivf-popup-body {
        flex: 1;
        overflow-y: auto;
        padding: 14px 20px;
        background-color: #f4f6f9;
    }

        /* IVF Sticky Navigation Bar (Matching OPD Orange Active Style) */
    .ivf-nav-bar {
        background: #ffffff;
        border-bottom: 1px solid #dee2e6;
        padding: 6px 16px;
        display: flex;
        align-items: center;
        gap: 10px;
        flex-shrink: 0;
        overflow-x: auto;
        white-space: nowrap;
        z-index: 100;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.04);
    }
    .ivf-tab-btn {
        background: none;
        border: 1px solid transparent;
        padding: 6px 14px;
        font-weight: 600;
        color: #555555;
        font-size: 13px;
        cursor: pointer;
        white-space: nowrap;
        text-decoration: none !important;
        border-radius: 4px;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.2s ease-in-out;
    }
    .ivf-tab-btn:hover {
        color: #d65b00;
        background-color: #fff9f4;
    }
    .ivf-tab-btn.active {
        color: #d65b00 !important;
        border: 1px solid #d65b00 !important;
        background-color: #fff5eb !important;
        font-weight: 700;
    }


        /* Menstrual History Styles */
    .ivf-section-title {
        color: #3b76f6;
        font-weight: 700;
        font-size: 18px;
        margin-top: 10px;
        margin-bottom: 18px;
    }
    .ivf-label-title {
        color: #0b57b8;
        font-weight: 700;
        font-size: 14px;
        margin-bottom: 8px;
        display: block;
    }
    .ivf-sub-label {
        font-weight: 500;
        color: #212529;
        font-size: 13.5px;
    }
    .ivf-input-sm {
        height: 28px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        padding: 2px 6px;
        font-size: 13px;
        background-color: #fff;
        outline: none;
        transition: border-color .15s ease-in-out;
    }
    .ivf-input-sm:focus {
        border-color: #80bdff;
        box-shadow: 0 0 0 0.15rem rgba(0, 123, 255, 0.25);
    }
    .ivf-check-label {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 13.5px;
        font-weight: 400;
        color: #212529;
        cursor: pointer;
        margin-bottom: 6px;
        user-select: none;
    }
    .ivf-check-label input[type="radio"],
    .ivf-check-label input[type="checkbox"] {
        margin: 0;
        cursor: pointer;
        width: 15px;
        height: 15px;
    }
    .ivf-options-grid-2 {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, auto));
        row-gap: 6px;
        column-gap: 16px;
    }
    .ivf-options-row {
        display: flex;
        flex-wrap: wrap;
        gap: 16px;
    }

        /* Obstetric History Table Styles */
    .ivf-obs-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        background-color: #ffffff;
    }
    .ivf-obs-table th {
        background-color: #004b99;
        color: #ffffff;
        font-size: 13px;
        font-weight: 600;
        text-align: center;
        padding: 8px 6px;
        border: 1px solid #003a77;
        white-space: nowrap;
    }
    .ivf-obs-table td {
        border: 1px solid #b8c8d8;
        padding: 3px 5px;
        height: 32px;
        vertical-align: middle;
        background-color: #ffffff;
    }
    .ivf-obs-table td input[type="text"] {
        width: 100%;
        height: 26px;
        border: 1px solid transparent;
        border-radius: 3px;
        padding: 2px 4px;
        font-size: 13px;
        background-color: transparent;
        outline: none;
        box-sizing: border-box;
    }
    .ivf-obs-table td input[type="text"]:focus {
        border-color: #80bdff;
        background-color: #f8fbff;
    }

        /* Ensure jQuery UI Datepicker calendar displays above this popup */
    #ui-datepicker-div {
        z-index: 1300 !important;
    }

        /* Ensure the Today button in datepicker is always clickable and bright */
    #ui-datepicker-div .ui-datepicker-buttonpane button.ui-datepicker-current {
        opacity: 1 !important;
        cursor: pointer !important;
        pointer-events: auto !important;
        font-weight: 600 !important;
    }



</style>



<!-- Full Screen Modal Dialog -->
<div id="Hist_M_IVFHistory">
    
    <!-- 1. Header Bar: "IVF History" on Left, Close Button on Right -->
    <div class="ivf-popup-header" id="Hist_H_IVFHistory">
        <h5 style="margin: 0; font-size: 15px; font-weight: 700; color: #ffffff;">IVF History</h5>

             <button type="button" class="btn btn-danger btn-sm" onclick="CloseIVFHistoryModal();" title="Close" style="line-height: 1; font-size: 20px;">
            &times;
        </button>


    </div>

            <!-- Sticky Navigation Tab Bar (ScrollSpy) & Save Button -->
    <div class="ivf-nav-bar" style="display: flex; align-items: center; justify-content: space-between; padding: 6px 16px;">
        <!-- Left Side: 5 Section Tabs -->
        <div style="display: flex; align-items: center; gap: 8px; flex-wrap: nowrap; overflow-x: auto;">
            <a href="#secIVF_Female" class="ivf-tab-btn active"><i class="fa fa-female"></i> Female Partner</a>
            <a href="#secIVF_Male" class="ivf-tab-btn"><i class="fa fa-male"></i> Male Partner</a>
            <a href="#secIVF_Family" class="ivf-tab-btn"><i class="fa fa-users"></i> Family & Social</a>
            <a href="#secIVF_Physical" class="ivf-tab-btn"><i class="fa fa-stethoscope"></i> Physical Examination</a>
            <a href="#secIVF_Diagnosis" class="ivf-tab-btn"><i class="fa fa-user-md"></i> Diagnosis</a>
        </div>

        <!-- Right Side: Exact Green Save Button -->
        <div style="margin-left: auto; padding-left: 14px; flex-shrink: 0;">
            <button type="button" class="btn btn-success fw-bold" id="btnIVF_Save" onclick="SaveIVFHistory();" style="display: inline-flex; align-items: center; padding: 4px 14px; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.15);">
                <i class="fa fa-save" style="font-size: 15px;"></i>
                <span style="padding: 0px 5px; font-size: 14px;">Save</span>
            </button>
        </div>
    </div>




    <!-- 2. Full-Page Scrollable Body -->
    <div class="ivf-popup-body" id="Hist_C_IVFHistory">
        
           <!-- Main Form Container -->
        <div style="background: #ffffff; padding: 20px 24px; border-radius: 6px; box-shadow: 0 1px 4px rgba(0,0,0,0.08);">
            
            <!-- Orange Header Title -->
            <h4 id="secIVF_Female" class="ivf-scroll-section" style="color: #ff6600; font-weight: 700; font-size: 19px; margin-top: 0; margin-bottom: 22px;">
                Female Partner &mdash; Detailed History
            </h4>


            <!-- Sections will go right here -->

            <div class="ivf-menstrual-history-container" style="margin-bottom: 25px;">
    <!-- Section Title -->
    <div class="ivf-section-title">
        A ) Menstrual History:
    </div>

    <!-- Row 1: LMP, Cycle length / Flow duration, PBAC score -->
    <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 70px; margin-bottom: 22px;">
        
        
                <!-- LMP Single Date Box -->
        <div style="display: flex; align-items: center; gap: 8px;">
            <span class="ivf-label-title" style="margin-bottom: 0;">LMP:</span>
            <input type="text" id="txtIVF_LMP" class="ivf-input-sm ivf-datepicker" style="width: 110px; text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" />
        </div>


        <!-- Cycle length / Flow duration -->
        <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
            <span class="ivf-label-title" style="margin-bottom: 0;">Cycle length / Flow duration</span>
            <span class="ivf-sub-label">Cycle :</span>
            <input type="text" id="txtIVF_CycleLength" class="ivf-input-sm" style="width: 65px; text-align: center;" />
            <span class="ivf-sub-label">Days</span>

            <span class="ivf-sub-label" style="margin-left: 12px;">Flows :</span>
            <input type="text" id="txtIVF_FlowDuration" class="ivf-input-sm" style="width: 65px; text-align: center;" />
            <span class="ivf-sub-label">Days</span>
        </div>

        <!-- PBAC score -->
        <div style="display: flex; align-items: center; gap: 8px; flex: 1; min-width: 240px;">
            <span class="ivf-label-title" style="margin-bottom: 0; white-space: nowrap;">PBAC score:</span>
            <input type="text" id="txtIVF_PBACScore" class="ivf-input-sm" style="flex: 1; min-width: 140px; max-width: 260px;" />
        </div>

    </div>

    <!-- Row 2: 5 Option Groups Grid -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 24px;">

        <!-- 1. Flow volume -->
        <div>
            <span class="ivf-label-title">Flow volume:</span>
            <div class="ivf-options-grid-2">
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_FlowVolume" value="Scanty" /> Scanty
                </label>
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_FlowVolume" value="Normal" /> Normal
                </label>
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_FlowVolume" value="Heavy" /> Heavy
                </label>
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_FlowVolume" value="VeryHeavyDots" /> Very heavy + dots
                </label>
            </div>
        </div>

        <!-- 2. Cycle regularity -->
        <div>
            <span class="ivf-label-title">Cycle regularity:</span>
            <div class="ivf-options-grid-2">
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_CycleRegularity" value="Regular" /> Regular
                </label>
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_CycleRegularity" value="Irregular" /> Irregular
                </label>
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_CycleRegularity" value="Oligo" /> Oligo
                </label>
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_CycleRegularity" value="Amenorrhoea" /> Amenorrhoea
                </label>
            </div>
        </div>

        <!-- 3. Dysmenorrhoea -->
        <div>
            <span class="ivf-label-title">Dysmenorrhoea</span>
            <div class="ivf-options-grid-2">
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_Dysmenorrhoea" value="None" /> None
                </label>
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_Dysmenorrhoea" value="Mild" /> Mild
                </label>
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_Dysmenorrhoea" value="Moderate" /> Moderate
                </label>
                <label class="ivf-check-label">
                    <input type="radio" name="rdoIVF_Dysmenorrhoea" value="Severe" /> Severe
                </label>
            </div>
        </div>

        <!-- 4. Spotting / IMB (Checkboxes) -->
        <div>
            <span class="ivf-label-title">Spotting / IMB</span>
            <div class="ivf-options-grid-2">
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Spotting_None" name="chkIVF_Spotting" value="None" /> None
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Spotting_Premenstrual" name="chkIVF_Spotting" value="Pre-menstrual" /> Pre-menstrual
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Spotting_Postmenstrual" name="chkIVF_Spotting" value="Post-menstrual" /> Post-menstrual
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Spotting_Intermenstrual" name="chkIVF_Spotting" value="Intermenstrual" /> Intermenstrual
                </label>
            </div>
        </div>

        <!-- 5. Anaemia -->
        <div>
            <span class="ivf-label-title">Anaemia</span>
            <div style="display: flex; flex-direction: column; gap: 6px;">
                <div class="ivf-options-row">
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_Anaemia" value="Yes" /> Yes
                    </label>
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_Anaemia" value="No" /> No
                    </label>
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_Anaemia" value="Normal" /> Normal
                    </label>
                </div>
                <div class="ivf-options-row">
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_Anaemia" value="Elevated" /> Elevated
                    </label>
                </div>
            </div>
        </div>

    </div>
</div>

            <!-- ========================================== -->
<!-- B ) Obstetric History Section -->
<!-- ========================================== -->
<div class="ivf-obstetric-history-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title -->
    <div class="ivf-section-title">
        B ) Obstetric History:
    </div>

    <!-- Table Grid -->
    <div style="overflow-x: auto;">
          <table class="ivf-obs-table" id="tblIVF_Obstetric">
            <thead>
                <tr>
                    <!-- Action Column with Green Plus (+) Button -->
                    <th style="width: 42px; text-align: center; vertical-align: middle;">
                        <button type="button" class="btn btn-sm btn-light p-0" onclick="AddObstetricRow();" title="Add Row" style="width: 22px; height: 22px; border-radius: 4px; border: 1px solid #ced4da; display: inline-flex; align-items: center; justify-content: center; background: #ffffff; cursor: pointer;">
                            <i class="fa fa-plus-circle text-success" style="font-size: 16px;"></i>
                        </button>
                    </th>
                    <th style="width: 6%;">Preg #</th>
                    <th style="width: 7%;">Year</th>
                    <th style="width: 6%;">GA</th>
                    <th style="width: 7%;">Type</th>
                    <th style="width: 11%;">Outcome</th>
                    <th style="width: 23%;">Mode of Delivery</th>
                    <th style="width: 10%;">Birth Wt</th>
                    <th style="width: 26%;">Complications</th>
                </tr>
            </thead>
            <tbody>
                <!-- Row 1 -->
                <tr>
                    <td style="text-align: center; vertical-align: middle;">
                        <i class="fa fa-trash text-danger" onclick="DeleteTableRow(this);" title="Delete" style="font-size: 16px; cursor: pointer;"></i>
                    </td>
                    <td><input type="text" name="txtIVF_PregNo" style="text-align: center;" /></td>
                    <td><input type="text" name="txtIVF_Year" style="text-align: center;" /></td>
                    <td><input type="text" name="txtIVF_GA" style="text-align: center;" /></td>
                    <td><input type="text" name="txtIVF_Type" style="text-align: center;" /></td>
                    <td><input type="text" name="txtIVF_Outcome" /></td>
                    <td><input type="text" name="txtIVF_ModeOfDelivery" /></td>
                    <td><input type="text" name="txtIVF_BirthWt" style="text-align: center;" /></td>
                    <td><input type="text" name="txtIVF_Complications" /></td>
                </tr>
            </tbody>
        </table>

    </div>

</div>

            <!-- ========================================== -->
<!-- C ) Gynaecological History Section -->
<!-- ========================================== -->
<div class="ivf-gynae-history-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title -->
    <div class="ivf-section-title">
        C ) Gynarcological History:
    </div>

      <!-- 3-Column Layout -->
    <div style="display: grid; grid-template-columns: repeat(3, minmax(280px, 1fr)); column-gap: 28px; row-gap: 16px; align-items: start;">

        <!-- ================= Column 1 ================= -->
        <div style="display: flex; flex-direction: column; gap: 18px;">
            
            <!-- PCOS -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_PCOS" name="chkIVF_Gynae" value="PCOS" />
                    PCOS-diagnosis / suspected
                </label>
            </div>

            <!-- Adenomyosis -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Adenomyosis" name="chkIVF_Gynae" value="Adenomyosis" />
                    Adenomyosis ( confirmed on USS / MRI )
                </label>
            </div>

            <!-- Endometrial polyps -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 10px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkIVF_EndometrialPolyps" name="chkIVF_Gynae" value="EndometrialPolyps" />
                    Endometrial polyps
                </label>
                <div style="display: inline-flex; align-items: center; gap: 6px; margin-left: 6px;">
                    <span style="font-size: 13.5px; font-weight: 500;">Treated:</span>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoIVF_PolypsTreated" value="Yes" /> Yes
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoIVF_PolypsTreated" value="No" /> No
                    </label>
                </div>
            </div>

            <!-- Bicornuate / arcuate / unicornuate -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_UterusAnomaly" name="chkIVF_Gynae" value="UterusAnomaly" />
                    Bicornuate / arcuate / uterus unicornuate
                </label>
            </div>

            <!-- Hydrosalpinx -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 8px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkIVF_Hydrosalpinx" name="chkIVF_Gynae" value="Hydrosalpinx" />
                    Hydrosalpinx
                </label>
                <div style="display: inline-flex; align-items: center; gap: 6px; margin-left: 4px;">
                    <span style="font-size: 13.5px; font-weight: 500;">Treated before IVF :</span>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoIVF_HydrosalpinxTreated" value="Yes" /> Yes
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoIVF_HydrosalpinxTreated" value="No" /> No
                    </label>
                </div>
            </div>

            <!-- Previous PID -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_PrevPID" name="chkIVF_Gynae" value="PID" />
                    Previous PID ( pelvic inflammatory disease )
                </label>
            </div>

            <!-- Premature ovarian insufficiency -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_POI" name="chkIVF_Gynae" value="POI" />
                    Premature ovarian insufficiency ( POI )
                </label>
            </div>

            <!-- Previous cervical surgery -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_PrevCervicalSurgery" name="chkIVF_Gynae" value="CervicalSurgery" />
                    Previous cervical surgery (LLETZ / cone biopsy )
                </label>
            </div>

        </div>

        <!-- ================= Column 2 ================= -->
        <div style="display: flex; flex-direction: column; gap: 14px;">
            
            <!-- Prior egg / embryo freezing -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_EggFreezing" name="chkIVF_Gynae" value="EggFreezing" />
                    Prior egg / embryo freezing
                </label>
                <div style="display: flex; align-items: center; gap: 8px; margin-top: 4px; padding-left: 20px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529; white-space: nowrap;">Centre:</span>
                    <input type="text" id="txtIVF_FreezingCentre" class="ivf-input-sm" style="flex: 1; width: 100%;" />
                </div>
            </div>

            <!-- Prior hysteroscopy -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_PriorHysteroscopy" name="chkIVF_Gynae" value="PriorHysteroscopy" />
                    Prior hysteroscopy
                </label>
                <div style="display: flex; align-items: center; gap: 8px; margin-top: 4px; padding-left: 20px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529; white-space: nowrap;">Finding:</span>
                    <input type="text" id="txtIVF_HysteroscopyFinding" class="ivf-input-sm" style="flex: 1; width: 100%;" />
                </div>
            </div>

            <!-- Endometriosis -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Endometriosis" name="chkIVF_Gynae" value="Endometriosis" />
                    Endometriosis
                </label>
                <div style="display: flex; align-items: center; gap: 16px; margin-top: 4px; padding-left: 20px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529; min-width: 48px; display: inline-block;">Stage:</span>
                        <input type="text" id="txtIVF_EndometriosisStage" class="ivf-input-sm" style="width: 85px;" />  
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;min-width: 125px; display: inline-block;">Last Laparoscopy:</span>
                        <input type="text" id="txtIVF_LastLaparoscopy" class="ivf-input-sm" style="width: 85px; text-align: center;" />
                    </div>
                </div>
            </div>

            <!-- Uterine fibroids -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_UterineFibroids" name="chkIVF_Gynae" value="Fibroids" />
                    Uterine fibroids
                </label>
                <div style="display: flex; align-items: center; gap: 16px; margin-top: 4px; padding-left: 20px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;min-width: 48px; display: inline-block;">Size:</span>
                        <input type="text" id="txtIVF_FibroidSize" class="ivf-input-sm" style="width: 85px;" />
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;min-width: 125px; display: inline-block;">Location:</span>
                        <input type="text" id="txtIVF_FibroidLocation" class="ivf-input-sm" style="width: 85px;" />
                    </div>
                </div>
            </div>

            <!-- Cancer History (Moved under Uterine Fibroids) -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_CancerHistory" name="chkIVF_Gynae" value="CancerHistory" />
                    Cancer History
                </label>
                <div style="display: flex; align-items: center; gap: 16px; margin-top: 4px; padding-left: 20px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;min-width: 48px; display: inline-block;">Type:</span>
                        <input type="text" id="txtIVF_CancerType" class="ivf-input-sm" style="width: 85px;" />
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;min-width: 125px; display: inline-block;">Treatment:</span>
                        <input type="text" id="txtIVF_CancerTreatment" class="ivf-input-sm" style="width: 85px;" />
                    </div>
                </div>
            </div>

        </div>

        <!-- ================= Column 3 ================= -->
        <div style="display: flex; flex-direction: column; gap: 14px;">
            
            <!-- Uterine septum / adhesions -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_UterineSeptum" name="chkIVF_Gynae" value="UterineSeptum" />
                    Uterine septum / Asherman's / intrauterine adhesions
                </label>
            </div>

            <!-- Tubal blockage -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 8px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkIVF_TubalBlockage" name="chkIVF_Gynae" value="TubalBlockage" />
                    Tubal blockage
                </label>
                <div style="display: inline-flex; align-items: center; gap: 8px; margin-left: 4px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoIVF_TubalBlockageSide" value="right" /> right
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoIVF_TubalBlockageSide" value="left" /> left
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoIVF_TubalBlockageSide" value="bilateral" /> bilateral
                    </label>
                </div>
            </div>

            <!-- Previous ectopic pregnancy -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_PrevEctopic" name="chkIVF_Gynae" value="EctopicPregnancy" />
                    Previous ectopic pregnancy
                </label>
                <div style="display: flex; align-items: center; gap: 8px; margin-top: 4px; padding-left: 20px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529; white-space: nowrap;">Site:</span>
                    <input type="text" id="txtIVF_EctopicSite" class="ivf-input-sm" style="flex: 1; width: 100%;" />
                </div>
            </div>

            <!-- Ovarian cyst / endometrioma -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_OvarianCyst" name="chkIVF_Gynae" value="OvarianCyst" />
                    Ovarian cyst / endometrioma
                </label>
                <div style="display: flex; align-items: center; gap: 12px; margin-top: 4px; padding-left: 20px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Size:</span>
                        <input type="text" id="txtIVF_CystSize" class="ivf-input-sm" style="width: 85px;" />
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Side:</span>
                        <input type="text" id="txtIVF_CystSide" class="ivf-input-sm" style="width: 85px;" />
                    </div>
                </div>
            </div>

            <!-- Turner syndrome -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_TurnerSyndrome" name="chkIVF_Gynae" value="TurnerSyndrome" />
                    Turner syndrome / chromosomal anomaly
                </label>
            </div>

            <!-- Recurrent miscarriage -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_RecurrentMiscarriage" name="chkIVF_Gynae" value="RecurrentMiscarriage" />
                    Recurrent miscarriage
                </label>
                <div style="display: flex; align-items: center; gap: 12px; margin-top: 4px; padding-left: 20px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoIVF_MiscarriageType" value="Thrombophilia" /> thrombophilia
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoIVF_MiscarriageType" value="APSScreenDone" /> APS screen done
                    </label>
                </div>
            </div>

        </div>

    </div>


</div>


            <!-- ========================================== -->
<!-- D ) Sexual and Contraceptive History Section -->
<!-- ========================================== -->
<div class="ivf-sexual-contraceptive-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title -->
    <div class="ivf-section-title">
        D ) Sexual and Contraceptive History
    </div>

    <!-- Main Grid Layout (4 Columns) -->
    <div style="display: grid; grid-template-columns: 240px 300px 280px auto; column-gap: 32px; row-gap: 20px; align-items: start;">

        <!-- ================= Column 1: Intercourse frequency & Dyspareunia ================= -->
        <div>
            <!-- Intercourse frequency -->
            <div style="margin-bottom: 20px;">
                <span class="ivf-label-title">Intercourse frequency</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <div style="display: flex; gap: 16px;">
                        <label class="ivf-check-label">
                            <input type="radio" name="rdoIVF_IntercourseFreq" value="Daily" /> Daily
                        </label>
                        <label class="ivf-check-label">
                            <input type="radio" name="rdoIVF_IntercourseFreq" value="3-4xWeek" /> 3-4x/week
                        </label>
                    </div>
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_IntercourseFreq" value="1-2xWeek" /> 1-2x/week
                    </label>
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_IntercourseFreq" value="Occasional" /> Occasional
                    </label>
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_IntercourseFreq" value="TimedOvulation" /> Timed to Ovulation only
                    </label>
                </div>
            </div>

            <!-- Dyspareunia? -->
            <div>
                <span class="ivf-label-title">Dyspareunia</span>
                <div class="ivf-options-grid-2">
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_Dyspareunia" value="None" /> None
                    </label>
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_Dyspareunia" value="Superficial" /> Superfical
                    </label>
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_Dyspareunia" value="Deep" /> Deep
                    </label>
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_Dyspareunia" value="PostCoital" /> Post-cotial
                    </label>
                </div>
            </div>
        </div>

        <!-- ================= Column 2: Previous contraception ================= -->
        <div>
            <span class="ivf-label-title">Previous contraception</span>
            <div style="display: flex; flex-direction: column; gap: 8px;">
                <!-- None -->
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Contra_None" name="chkIVF_Contra" value="None" /> None
                </label>

                <!-- COCP Stopped -->
                <div style="display: flex; align-items: center; gap: 8px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkIVF_Contra_COCP" name="chkIVF_Contra" value="COCP" /> COCP
                    </label>
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Stopped</span>
                    <input type="text" id="txtIVF_COCP_Stopped" class="ivf-input-sm" style="width: 120px;" />
                </div>

                <!-- Mirena Remove -->
                <div style="display: flex; align-items: center; gap: 8px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkIVF_Contra_Mirena" name="chkIVF_Contra" value="Mirena" /> Mirena
                    </label>
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Remove</span>
                    <input type="text" id="txtIVF_Mirena_Remove" class="ivf-input-sm" style="width: 120px;" />
                </div>

                <!-- Implant & Depo -->
                <div style="display: flex; gap: 24px; margin-top: 2px;">
                    <label class="ivf-check-label" style="width: 85px;">
                        <input type="checkbox" id="chkIVF_Contra_Implant" name="chkIVF_Contra" value="Implant" /> Implant
                    </label>
                    <label class="ivf-check-label">
                        <input type="checkbox" id="chkIVF_Contra_Depo" name="chkIVF_Contra" value="Depo" /> Depo
                    </label>
                </div>

                <!-- Condoms & IUCD -->
                <div style="display: flex; gap: 24px;">
                    <label class="ivf-check-label" style="width: 85px;">
                        <input type="checkbox" id="chkIVF_Contra_Condoms" name="chkIVF_Contra" value="Condoms" /> Condoms
                    </label>
                    <label class="ivf-check-label">
                        <input type="checkbox" id="chkIVF_Contra_IUCD" name="chkIVF_Contra" value="IUCD" /> IUCD
                    </label>
                </div>
            </div>
        </div>

        <!-- ================= Column 3: STI history & Libido ================= -->
        <div>
            <!-- STI history -->
            <div style="margin-bottom: 20px;">
                <span class="ivf-label-title">STI history</span>
                <div style="display: flex; flex-direction: column; gap: 8px;">
                    <div class="ivf-options-grid-2">
                        <label class="ivf-check-label">
                            <input type="checkbox" id="chkIVF_STI_None" name="chkIVF_STI" value="NoneKnown" /> None known
                        </label>
                        <label class="ivf-check-label">
                            <input type="checkbox" id="chkIVF_STI_Chlamydia" name="chkIVF_STI" value="Chlamydia" /> Chlamydia
                        </label>
                        <label class="ivf-check-label">
                            <input type="checkbox" id="chkIVF_STI_HSV" name="chkIVF_STI" value="HSV" /> HSV
                        </label>
                        <label class="ivf-check-label">
                            <input type="checkbox" id="chkIVF_STI_HPV" name="chkIVF_STI" value="HPV" /> HPV
                        </label>
                    </div>

                    <!-- HIV Treated -->
                    <div style="display: flex; align-items: center; gap: 10px; margin-top: 2px;">
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkIVF_STI_HIV" name="chkIVF_STI" value="HIV" /> HIV
                        </label>
                        <span style="font-size: 13.5px; font-weight: 500;">Treated:</span>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="radio" name="rdoIVF_HIVTreated" value="Yes" /> Yes
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="radio" name="rdoIVF_HIVTreated" value="No" /> No
                        </label>
                    </div>
                </div>
            </div>

            <!-- Libido -->
            <div>
                <span class="ivf-label-title">Libido</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <div style="display: flex; gap: 16px;">
                        <label class="ivf-check-label">
                            <input type="radio" name="rdoIVF_Libido" value="Normal" /> Normal
                        </label>
                        <label class="ivf-check-label">
                            <input type="radio" name="rdoIVF_Libido" value="Reduced" /> Reduced
                        </label>
                    </div>
                    <label class="ivf-check-label">
                        <input type="radio" name="rdoIVF_Libido" value="Absent" /> Absent
                    </label>
                </div>
            </div>
        </div>

                <!-- ================= Column 4: Stopped since ================= -->
        <div style="display: flex; align-items: center; gap: 8px; margin-top: 26px; flex-wrap: nowrap;">
            <span style="font-weight: 700; font-size: 13.5px; color: #212529; white-space: nowrap;">Stopped since:</span>
            <input type="text" id="txtIVF_StoppedSinceMonths" class="ivf-input-sm" style="width: 90px;" />
            <span style="font-weight: 700; font-size: 13.5px; color: #212529; white-space: nowrap;">months ago</span>
        </div>




    </div>

</div>


            <!-- ========================================== -->
<!-- E ) Medical History and Current Medications -->
<!-- ========================================== -->
<div class="ivf-med-history-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title -->
    <div class="ivf-section-title">
        E ) Medical History and Current Medications
    </div>

    <!-- 2-Column Conditions Grid -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 36px; row-gap: 16px; align-items: start; margin-bottom: 22px;">

        <!-- ================= Left Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 14px;">
            
            <!-- Hypothyroidism / hyperthyroidism -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Thyroid" name="chkIVF_MedHist" value="Thyroid" />
                    Hypothyroidism / hyperthyroidism
                </label>
                <div style="display: flex; align-items: center; gap: 12px; margin-top: 6px; padding-left: 20px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">TSH :</span>
                        <input type="text" id="txtIVF_TSH" class="ivf-input-sm" style="width: 140px;" />
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 500; font-size: 13.5px; color: #212529;">on treatment</span>
                        <input type="text" id="txtIVF_ThyroidTreatment" class="ivf-input-sm" style="width: 130px;" />
                    </div>
                </div>
            </div>

            <!-- Hypertension -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Hypertension" name="chkIVF_MedHist" value="Hypertension" />
                    Hypertension
                </label>
            </div>

            <!-- Coeliac disease / malabsorption -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Coeliac" name="chkIVF_MedHist" value="Coeliac" />
                    Coeliac diesease / malabsorption
                </label>
            </div>

            <!-- Obesity -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 14px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkIVF_Obesity" name="chkIVF_MedHist" value="Obesity" />
                    Obesity
                </label>
                <div style="display: inline-flex; align-items: center; gap: 6px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">BMI:</span>
                    <input type="text" id="txtIVF_ObesityBMI" class="ivf-input-sm" style="width: 130px;" />
                </div>
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="radio" name="rdoIVF_WeightAnovulation" value="WeightRelatedAnovulation" /> Weight-related anovulation
                </label>
            </div>

            <!-- Epilepsy / seizure disorder -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Epilepsy" name="chkIVF_MedHist" value="Epilepsy" />
                    Epliepsy / seizure disorder
                </label>
            </div>

            <!-- Cancer -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 10px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkIVF_MedCancer" name="chkIVF_MedHist" value="Cancer" />
                    Cancer
                </label>
                <div style="display: inline-flex; align-items: center; gap: 6px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">type:</span>
                    <input type="text" id="txtIVF_MedCancerType" class="ivf-input-sm" style="width: 70px;" />
                </div>
                <div style="display: inline-flex; align-items: center; gap: 6px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">treatment:</span>
                    <input type="text" id="txtIVF_MedCancerTreatment" class="ivf-input-sm" style="width: 70px;" />
                </div>
                <div style="display: inline-flex; align-items: center; gap: 6px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">year:</span>
                    <input type="text" id="txtIVF_MedCancerYear" class="ivf-input-sm" style="width: 60px; text-align: center;" />
                </div>
            </div>

            <!-- Adrenal / pituitary disorders -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_AdrenalPituitary" name="chkIVF_MedHist" value="AdrenalPituitary" />
                    Adrenal / pituitary disorders
                </label>
            </div>

        </div>

        <!-- ================= Right Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 14px;">
            
            <!-- Diabetes mellitus -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 10px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkIVF_Diabetes" name="chkIVF_MedHist" value="Diabetes" />
                    Diabetes melitus ( Type 1 / Type 2 / gestational )
                </label>
                <div style="display: inline-flex; align-items: center; gap: 6px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">HbA1c</span>
                    <input type="text" id="txtIVF_HbA1c" class="ivf-input-sm" style="width: 80px;" />
                </div>
            </div>

            <!-- Autoimmune conditions -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_Autoimmune" name="chkIVF_MedHist" value="Autoimmune" />
                    Autoinmmune conditions ( SLE / RA / thyroiditis / APS )
                </label>
            </div>

            <!-- Inflammatory bowel disease -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_IBD" name="chkIVF_MedHist" value="IBD" />
                    Inflammatory bowel disease
                </label>
            </div>

            <!-- Eating disorder / low body weight -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 10px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkIVF_EatingDisorder" name="chkIVF_MedHist" value="EatingDisorder" />
                    Eating disorder / low body weight
                </label>
                <div style="display: inline-flex; align-items: center; gap: 6px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">BMI:</span>
                    <input type="text" id="txtIVF_LowBodyWeightBMI" class="ivf-input-sm" style="width: 80px;" />
                </div>
            </div>

            <!-- Depression / anxiety -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 10px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkIVF_DepressionAnxiety" name="chkIVF_MedHist" value="DepressionAnxiety" />
                    Depression / anxiety
                </label>
                <div style="display: inline-flex; align-items: center; gap: 6px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">On SSRI / other</span>
                    <input type="text" id="txtIVF_OnSSRI" class="ivf-input-sm" style="width: 80px;" />
                </div>
            </div>

            <!-- Clotting disorders / thrombophilia -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_ClottingDisorders" name="chkIVF_MedHist" value="ClottingDisorders" />
                    Clothing disorders / thrombophilla
                </label>
            </div>

            <!-- Kidney disease / liver disease -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkIVF_KidneyLiver" name="chkIVF_MedHist" value="KidneyLiver" />
                    Kidney disease / live disease
                </label>
            </div>

        </div>

    </div>

    <!-- ================= Full-Width Bottom Rows ================= -->
    <div style="display: flex; flex-direction: column; gap: 16px;">
        
        <!-- Current medications -->
        <div>
            <span class="ivf-label-title" style="margin-bottom: 6px;">
                Current medications ( list all - especially metformin, levothyroxine, folic acid, antiepressants
            </span>
            <input type="text" id="txtIVF_CurrentMedications" class="ivf-input-sm" style="width: 100%; height: 32px;" />
        </div>

        <!-- Known drug allergies & NKDA -->
        <div style="display: flex; align-items: center; gap: 24px; flex-wrap: wrap;">
            <div style="display: flex; align-items: center; gap: 10px; flex: 1; min-width: 320px;">
                <span class="ivf-label-title" style="margin-bottom: 0; white-space: nowrap;">Known drug allergies:</span>
                <input type="text" id="txtIVF_DrugAllergies" class="ivf-input-sm" style="flex: 1; height: 32px;" />
            </div>

            <div style="display: flex; align-items: center; gap: 12px; margin-left: auto;">
                <span class="ivf-label-title" style="margin-bottom: 0;">NKDA</span>
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="radio" name="rdoIVF_NKDA" value="Yes" /> Yes
                </label>
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="radio" name="rdoIVF_NKDA" value="No" /> No
                </label>
            </div>
        </div>

    </div>

</div>

            <!-- ========================================== -->
<!-- F ) Previous Fertility Treatments -->
<!-- ========================================== -->
<div class="ivf-fertility-treatments-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title -->
    <div class="ivf-section-title">
        F ) Previous Fertility Treatments
    </div>

    <!-- Table Grid -->
    <div style="overflow-x: auto;">
               <table class="ivf-obs-table" id="tblIVF_Fertility">
            <thead>
                <tr>
                    <!-- Action Column with Green Plus (+) Button -->
                    <th style="width: 42px; text-align: center; vertical-align: middle;">
                        <button type="button" class="btn btn-sm btn-light p-0" onclick="AddFertilityRow();" title="Add Row" style="width: 22px; height: 22px; border-radius: 4px; border: 1px solid #ced4da; display: inline-flex; align-items: center; justify-content: center; background: #ffffff; cursor: pointer;">
                            <i class="fa fa-plus-circle text-success" style="font-size: 16px;"></i>
                        </button>
                    </th>
                    <th style="width: 20%;">Treatment</th>
                    <th style="width: 15%;">Year</th>
                    <th style="width: 15%;">No of cycle</th>
                    <th style="width: 25%;">Centre</th>
                    <th style="width: 23%;">Outcome / Failure Reason</th>
                </tr>
            </thead>
            <tbody>
                <!-- Row 1 -->
                <tr>
                    <td style="text-align: center; vertical-align: middle;">
                        <i class="fa fa-trash text-danger" onclick="DeleteTableRow(this);" title="Delete" style="font-size: 16px; cursor: pointer;"></i>
                    </td>
                    <td><input type="text" name="txtIVF_FertilityTreatment" /></td>
                    <td><input type="text" name="txtIVF_FertilityYear" style="text-align: center;" /></td>
                    <td><input type="text" name="txtIVF_FertilityNoOfCycle" style="text-align: center;" /></td>
                    <td><input type="text" name="txtIVF_FertilityCentre" /></td>
                    <td><input type="text" name="txtIVF_FertilityOutcome" /></td>
                </tr>
            </tbody>
        </table>
    </div>

</div>

            <!-- ========================================== -->
<!-- Male Partner — Detailed History -->
<!-- ========================================== -->
<div id="secIVF_Male" class="ivf-scroll-section ivf-male-partner-container" style="margin-top: 35px; margin-bottom: 25px;">

    
    <!-- Orange Header Title -->
    <h4 style="color: #ff6600; font-weight: 700; font-size: 19px; margin-top: 15px; margin-bottom: 20px;">
        Male Partner &mdash; Detailed History
    </h4>

    <!-- Section Title (Blue) -->
    <div class="ivf-section-title">
        A ) Reproductive and Sexual History
    </div>

    <!-- 2-Column Main Layout -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 40px; row-gap: 20px; align-items: start;">

        <!-- ================= Left Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 16px;">
            
            <!-- 1. Previous pregnancies fathered -->
            <div>
                <span class="ivf-label-title">Previous pregnancies fathered</span>
                <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_PrevPregnancies" value="None" /> None
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_PrevPregnancies" value="Yes" /> Yes ( with current / previous partner )
                    </label>
                </div>
                <div style="display: flex; align-items: center; gap: 8px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Details:</span>
                    <input type="text" id="txtMale_PregnanciesDetails" class="ivf-input-sm" style="flex: 1; max-width: 320px;" />
                </div>
            </div>

            <!-- 2. Erectile dysfunction ? -->
            <div>
                <span class="ivf-label-title">Erectile dysfunction </span>
                <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_ED" value="No" /> No
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_ED" value="Yes" /> Yes ( mild/moderate/serve )
                    </label>
                </div>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Duration</span>
                        <input type="text" id="txtMale_ED_Duration" class="ivf-input-sm" style="width: 130px;" />
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">On treatment</span>
                        <input type="text" id="txtMale_ED_Treatment" class="ivf-input-sm" style="width: 120px;" />
                    </div>
                </div>
            </div>

            <!-- 3. Undescended testis ( cryptorchidism ) ? -->
            <div>
                <span class="ivf-label-title">Undescended testis ( cryptorchidism ) </span>
                <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_UndescendedTestis" value="No" /> No
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_UndescendedTestis" value="Yes" /> Yes ( right / left / bilateral Surgery )
                    </label>
                </div>
                <div style="display: flex; align-items: center; gap: 12px;">
                    <input type="text" id="txtMale_UndescendedSurgery" class="ivf-input-sm" style="flex: 1; max-width: 200px;" />
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Age</span>
                    <input type="text" id="txtMale_UndescendedAge" class="ivf-input-sm" style="width: 140px;" />
                </div>
            </div>

            <!-- 4. Testicular trauma / torsion ? -->
            <div>
                <span class="ivf-label-title">Testicular trauma / torsion </span>
                <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_TesticularTrauma" value="No" /> No
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_TesticularTrauma" value="Yes" /> Yes
                    </label>
                </div>
                <div style="display: flex; align-items: center; gap: 8px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Details</span>
                    <input type="text" id="txtMale_TesticularDetails" class="ivf-input-sm" style="flex: 1; max-width: 320px;" />
                </div>
            </div>

            <!-- 5. Groin / hernia surgery ? -->
            <div>
                <span class="ivf-label-title">Groin / hernia surgery </span>
                <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_GroinSurgery" value="No" /> No
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_GroinSurgery" value="Yes" /> Yes ( inguinal hernia repair / hydrocele repair / other )
                    </label>
                </div>
                <input type="text" id="txtMale_GroinSurgeryDetails" class="ivf-input-sm" style="width: 100%; max-width: 440px;" />
            </div>

            <!-- 6. STI history -->
            <div>
                <span class="ivf-label-title">STI history</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap; margin-bottom: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_STI_None" name="chkMale_STI" value="NoneKnown" /> None known
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_STI_Chlamydia" name="chkMale_STI" value="Chlamydia" /> Chlamydia
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_STI_Gonorhoea" name="chkMale_STI" value="Gonorhoea" /> Gonorhoea
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_STI_HIV" name="chkMale_STI" value="HIV" /> HIV
                    </label>
                </div>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Treated</span>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_STITreated" value="No" /> No
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_STITreated" value="Yes" /> Yes
                    </label>
                </div>
            </div>

        </div>

        <!-- ================= Right Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 16px;">
            
            <!-- 1. Ejaculatory problems? -->
            <div>
                <span class="ivf-label-title">Ejaculatory problems</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMale_Ejac_None" name="chkMale_Ejac" value="None" /> None
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMale_Ejac_Premature" name="chkMale_Ejac" value="Premature" /> Premature
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMale_Ejac_Retrograde" name="chkMale_Ejac" value="Retrograde" /> Retrograde
                        </label>
                    </div>
                    <div>
                        <label class="ivf-check-label">
                            <input type="checkbox" id="chkMale_Ejac_Anejaculation" name="chkMale_Ejac" value="Anejaculation" /> Anejaculation
                        </label>
                    </div>
                </div>
            </div>

            <!-- 2. Libido -->
            <div>
                <span class="ivf-label-title">Libido</span>
                <div style="display: flex; align-items: center; gap: 14px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_Libido_Normal" name="chkMale_Libido" value="Normal" /> Nromal
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_Libido_Reduced" name="chkMale_Libido" value="Reduced" /> Reduced
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_Libido_Absent" name="chkMale_Libido" value="Absent" /> Absent
                    </label>
                </div>
            </div>

            <!-- 3. Orchitis / epididymitis ? -->
            <div>
                <span class="ivf-label-title">Orchitis / epididymitis </span>
                <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_Orchitis" value="No" /> No
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_Orchitis" value="Yes" /> Yes
                    </label>
                </div>
                                <div style="display: flex; align-items: center; gap: 14px;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Date</span>
                        <input type="text" id="txtMale_OrchitisDate" class="ivf-input-sm ivf-datepicker" placeholder="DD/MM/YYYY" style="width: 105px; text-align: center; cursor: pointer; background-color: #fff;" />
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Cause</span>
                        <input type="text" id="txtMale_OrchitisCause" class="ivf-input-sm" style="width: 85px;" />
                    </div>
                </div>

            </div>

            <!-- 4. Vasectomy ? -->
            <div>
                <span class="ivf-label-title">Vasectomy </span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_Vasectomy" value="No" /> No
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_Vasectomy" value="Yes" /> Yes
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_Vasectomy" value="Reversal" /> Reversal:
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_Vasectomy_Done" name="chkMale_VasectomyReversal" value="Done" /> Done
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_Vasectomy_Planning" name="chkMale_VasectomyReversal" value="Planning" /> Planning
                    </label>
                </div>
            </div>

            <!-- 5. Varicocele? -->
            <div>
                <span class="ivf-label-title">Varicocele</span>
                <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_Varicocele" value="No" /> No
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_Varicocele" value="Yes" /> Yes
                    </label>
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Grade</span>
                    <input type="text" id="txtMale_VaricoceleGrade" class="ivf-input-sm" style="width: 70px;" />
                </div>
                <div style="display: flex; align-items: center; gap: 14px;">
                    <span style="font-weight: 500; font-size: 13.5px; color: #212529;">Treated:</span>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_Varicocele_Done" name="chkMale_VaricoceleTreated" value="Done" /> Done
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMale_Varicocele_Planning" name="chkMale_VaricoceleTreated" value="Planning" /> Planning
                    </label>
                </div>
            </div>

            <!-- 6. Post-testicular surgery ? -->
            <div>
                <span class="ivf-label-title">Post-testicular surgery </span>
                <div style="display: flex; align-items: center; gap: 14px; margin-bottom: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_PostTesticular" value="None" /> None
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_PostTesticular" value="TESA_PESA" /> TESA/PESA
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_PostTesticular" value="MicroTEST" /> Micro-TEST
                    </label>
                </div>
                <input type="text" id="txtMale_PostTesticularDetails" class="ivf-input-sm" style="width: 100%; max-width: 440px;" />
            </div>

        </div>

    </div>

</div>

            <!-- ========================================== -->
<!-- B ) Male Medical History -->
<!-- ========================================== -->
<div class="ivf-male-medical-history-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title (Blue) -->
    <div class="ivf-section-title">
        B ) Male Medical History :
    </div>

    <!-- 2-Column Conditions Grid -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 40px; row-gap: 16px; align-items: start;">

        <!-- ================= Left Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 14px;">
            
            <!-- Hypogonadism on TRT -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_Hypogonadism" name="chkMale_MedHist" value="Hypogonadism" />
                    Hypogonadism ( low testosterterone ) on TRT
                </label>
                <div style="display: flex; align-items: center; gap: 14px; margin-top: 4px; padding-left: 20px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_TRT" value="No" /> No
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_TRT" value="Yes" /> Yes
                    </label>
                </div>
            </div>

            <!-- Pituitary / hypothalamic disorder -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_Pituitary" name="chkMale_MedHist" value="PituitaryDisorder" />
                    Pitutary / hypothalamic disorder
                </label>
            </div>

            <!-- Cystic fibrosis / CFTR mutation -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_CysticFibrosis" name="chkMale_MedHist" value="CysticFibrosis" />
                    Cycstic fiborsis / CFTR mutation ( associated with CBAVD )
                </label>
            </div>

            <!-- Klinefelter syndrome (47,XXY) -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 10px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkMale_Klinefelter" name="chkMale_MedHist" value="Klinefelter" />
                    Klineflelter sydrome (47,XXY)
                </label>
                <div style="display: inline-flex; align-items: center; gap: 10px; margin-left: 6px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_KlinefelterStatus" value="Confirmed" /> comfirmed
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_KlinefelterStatus" value="Suspected" /> suspected
                    </label>
                </div>
            </div>

            <!-- Cancer -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 10px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkMale_Cancer" name="chkMale_MedHist" value="Cancer" />
                    Cancer
                </label>
                <div style="display: inline-flex; align-items: center; gap: 10px; margin-left: 6px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_CancerType" value="Testicular" /> testicular
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_CancerType" value="Lymphoma" /> lymphoma
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="radio" name="rdoMale_CancerType" value="ChemoExposure" /> chemotherapy exposure
                    </label>
                </div>
            </div>

            <!-- Autoimmune conditions -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_AntiSpermAntibodies" name="chkMale_MedHist" value="AntiSpermAntibodies" />
                    Autoimmune conditions- anti sperm antibodies
                </label>
            </div>

            <!-- Hypothyroidism / hyperthyroidism -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_Thyroid" name="chkMale_MedHist" value="Thyroid" />
                    Hypothyriodsm / hyperthyoidism
                </label>
            </div>

        </div>

        <!-- ================= Right Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 14px;">
            
            <!-- Hyperprolactinaemia -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_Hyperprolactinaemia" name="chkMale_MedHist" value="Hyperprolactinaemia" />
                    Hyperprolactinaemia
                </label>
            </div>

            <!-- Kartagener syndrome -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_Kartagener" name="chkMale_MedHist" value="Kartagener" />
                    Kartagener syndrome / primary ciliary dyskinesia
                </label>
            </div>

            <!-- Y-chromosome microdeletion -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_YMicrodeletion" name="chkMale_MedHist" value="YMicrodeletion" />
                    Y-chromosome microdeletion (AZF region )
                </label>
            </div>

            <!-- Diabetes mellitus -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_Diabetes" name="chkMale_MedHist" value="Diabetes" />
                    Diabetes mellitus ( retrograde ejaculation risk )
                </label>
            </div>

            <!-- Spinal cord injury -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_SpinalCord" name="chkMale_MedHist" value="SpinalCord" />
                    Spinal cord injury / neurological condition
                </label>
            </div>

            <!-- Chronic kidney / liver disease -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_KidneyLiver" name="chkMale_MedHist" value="KidneyLiver" />
                    Chronic kidney / liver disease
                </label>
            </div>

            <!-- Previous abdominal/pelvic surgery -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_AbdominalPelvicSurgery" name="chkMale_MedHist" value="AbdominalPelvicSurgery" />
                    Previous abdominal/pelvic surgery ( adhesions )
                </label>
            </div>

        </div>

    </div>

</div>

            <!-- ========================================== -->
<!-- C ) Semen Analysis Results ( Most Recent ) -->
<!-- ========================================== -->
<div class="ivf-semen-analysis-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title (Blue) -->
    <div class="ivf-section-title">
        C ) Semen Analysis Results ( Most Recent ) :
    </div>

    <!-- Table Grid -->
    <div style="overflow-x: auto;">
        <table class="ivf-obs-table">
            <thead>
                <tr>
                    <th style="width: 25%; text-align: left; padding-left: 12px;">Parameter</th>
                    <th style="width: 18%;">Result</th>
                    <th style="width: 15%;">Date</th>
                    <th style="width: 24%; text-align: left; padding-left: 12px;">WHO 2021 Reference</th>
                    <th style="width: 18%;">Status</th>
                </tr>
            </thead>
            <tbody>
                <!-- 1. Volume -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Volume ( ml )</td>
                    <td><input type="text" id="txtSemen_Volume_Result" style="text-align: center;" /></td>
                    <td><input type="text" id="txtSemen_Volume_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&ge; 1.4 ml</td>
                    <td><input type="text" id="txtSemen_Volume_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 2. pH -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">pH</td>
                    <td><input type="text" id="txtSemen_PH_Result" style="text-align: center;" /></td>
                    <td><input type="text" id="txtSemen_PH_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">7.2 - 8.0</td>
                    <td><input type="text" id="txtSemen_PH_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 3. Total sperm count -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Total sperm count</td>
                    <td><input type="text" id="txtSemen_TotalCount_Result" style="text-align: center;" /></td>
                    <td><input type="text" id="txtSemen_TotalCount_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&ge; 39 million / ejaculate</td>
                    <td><input type="text" id="txtSemen_TotalCount_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 4. Concentration -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Concentration(mil/ml)</td>
                    <td><input type="text" id="txtSemen_Concentration_Result" style="text-align: center;" /></td>
                   <td><input type="text" id="txtSemen_Concentration_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&ge;16 mil/ml</td>
                    <td><input type="text" id="txtSemen_Concentration_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 5. Total motility -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Total motility ( PR+NP )</td>
                    <td><input type="text" id="txtSemen_TotalMotility_Result" style="text-align: center;" /></td>
                   <td><input type="text" id="txtSemen_TotalMotility_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&ge; 42%</td>
                    <td><input type="text" id="txtSemen_TotalMotility_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 6. Progressive motility -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Progressive motility ( PR )</td>
                    <td><input type="text" id="txtSemen_ProgMotility_Result" style="text-align: center;" /></td>
                   <td><input type="text" id="txtSemen_ProgMotility_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&ge; 30%</td>
                    <td><input type="text" id="txtSemen_ProgMotility_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 7. Non-progressive motility -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Non-progressive motility</td>
                    <td><input type="text" id="txtSemen_NonProgMotility_Result" style="text-align: center;" /></td>
                   <td><input type="text" id="txtSemen_NonProgMotility_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&ge; report</td>
                    <td><input type="text" id="txtSemen_NonProgMotility_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 8. Morphology -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Morphology ( strict kruger )</td>
                    <td><input type="text" id="txtSemen_Morphology_Result" style="text-align: center;" /></td>
                   <td><input type="text" id="txtSemen_Morphology_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&ge; 4% normal forms</td>
                    <td><input type="text" id="txtSemen_Morphology_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 9. Vitality -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Vitality ( live sperm % )</td>
                    <td><input type="text" id="txtSemen_Vitality_Result" style="text-align: center;" /></td>
                    <td><input type="text" id="txtSemen_Vitality_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&ge; 54%</td>
                    <td><input type="text" id="txtSemen_Vitality_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 10. Leukocyte count -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Leukocyte count</td>
                    <td><input type="text" id="txtSemen_Leukocyte_Result" style="text-align: center;" /></td>
                   <td><input type="text" id="txtSemen_Leukocyte_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&ge; 1.0 mil/ml</td>
                    <td><input type="text" id="txtSemen_Leukocyte_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 11. Round cells -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">Round cells</td>
                    <td><input type="text" id="txtSemen_RoundCells_Result" style="text-align: center;" /></td>
                    <td><input type="text" id="txtSemen_RoundCells_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&le; 5 mil/ml</td>
                    <td><input type="text" id="txtSemen_RoundCells_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 12. DNA Fragmentation index -->
                <tr>
                    <td style="font-weight: 600; padding-left: 12px;">DNA Fragmentation index ( DFI )</td>
                    <td><input type="text" id="txtSemen_DFI_Result" style="text-align: center;" /></td>
                   <td><input type="text" id="txtSemen_DFI_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px;">&lt; 15% (ideal)</td>
                    <td><input type="text" id="txtSemen_DFI_Status" style="text-align: center;" /></td>
                </tr>

                <!-- 13. Diagnosis -->
                <tr>
                    <td style="font-weight: 700; padding-left: 12px; vertical-align: top; padding-top: 8px;">Diagnosis</td>
                    <td style="vertical-align: top;"><textarea id="txtSemen_Diagnosis_Result" rows="2" style="width: 100%; border: 1px solid transparent; border-radius: 3px; font-size: 13px; outline: none; resize: none; background: transparent;"></textarea></td>
                    <td style="vertical-align: top;"><input type="text" id="txtSemen_Diagnosis_Date" class="ivf-datepicker" style="text-align: center;" placeholder="DD/MM/YYYY" autocomplete="off" /></td>
                    <td style="font-weight: 600; padding-left: 12px; line-height: 1.4; vertical-align: top; padding-top: 8px;">
                        Normozoospermia/ Oligo /<br />
                        Astheno / Terato/<br />
                        Azoospermia
                    </td>
                    <td style="vertical-align: top;"><input type="text" id="txtSemen_Diagnosis_Status" style="text-align: center;" /></td>
                </tr>
            </tbody>
        </table>
    </div>

</div>

            <!-- ========================================== -->
<!-- D ) Male Lifestyle and enviromental factors -->
<!-- ========================================== -->
<div class="ivf-male-lifestyle-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title (Blue) -->
    <div class="ivf-section-title">
        D ) Male Lifestyle and enviromental factors :
    </div>

    <!-- 2-Column Conditions Grid -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 40px; row-gap: 18px; align-items: start;">

        <!-- ================= Left Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 14px;">
            
            <!-- 1. Smoking -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_Smoking" name="chkMale_Lifestyle" value="Smoking" />
                    Smoking
                </label>
                <div style="display: flex; align-items: center; gap: 12px; margin-top: 4px; padding-left: 20px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Cigarettes/day</span>
                        <input type="text" id="txtMale_SmokingCigarettes" class="ivf-input-sm" style="width: 65px; text-align: center;" />
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Duration:</span>
                        <input type="text" id="txtMale_SmokingDuration" class="ivf-input-sm" style="width: 75px; text-align: center;" />
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">year stopped</span>
                        <input type="text" id="txtMale_SmokingYearStopped" class="ivf-input-sm" style="width: 75px; text-align: center;" />
                    </div>
                </div>
            </div>

            <!-- 2. Recreational drugs -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_RecreationalDrugs" name="chkMale_Lifestyle" value="RecreationalDrugs" />
                    Recreational drugs
                </label>
                <div style="display: flex; align-items: center; gap: 8px; margin-top: 4px; padding-left: 20px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529; white-space: nowrap;">cannabis / steroids / cocaine - specify</span>
                    <input type="text" id="txtMale_DrugsSpecify" class="ivf-input-sm" style="flex: 1; max-width: 250px;" />
                </div>
            </div>

            <!-- 3. Heat exposure -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_HeatExposure" name="chkMale_Lifestyle" value="HeatExposure" />
                    Heat exposure ( laptop on lap , thight underwear, hot baths, prolonged siting )
                </label>
            </div>

            <!-- 4. Radiation / chemical exposure -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_RadiationExposure" name="chkMale_Lifestyle" value="RadiationExposure" />
                    Radiation / X-ray / chemical exposure at work
                </label>
            </div>

            <!-- 5. Night shifts / sleep deprivation -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_NightShifts" name="chkMale_Lifestyle" value="NightShifts" />
                    Night shifts / sleep deprivation ( &gt; 3 shifts / week )
                </label>
            </div>

        </div>

        <!-- ================= Right Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 14px;">
            
            <!-- 1. Alcohol -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_Alcohol" name="chkMale_Lifestyle" value="Alcohol" />
                    Alocohol
                </label>
                <div style="display: flex; align-items: center; gap: 12px; margin-top: 4px; padding-left: 20px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">units/week:</span>
                        <input type="text" id="txtMale_AlcoholUnits" class="ivf-input-sm" style="width: 65px; text-align: center;" />
                    </div>
                    <div style="display: flex; align-items: center; gap: 6px; flex: 1;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Type:</span>
                        <input type="text" id="txtMale_AlcoholType" class="ivf-input-sm" style="flex: 1; max-width: 250px;" />
                    </div>
                </div>
            </div>

            <!-- 2. Anabolic steroids -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_AnabolicSteroids" name="chkMale_Lifestyle" value="AnabolicSteroids" />
                    Anabolic steroids / testosterone supplements ( STOP - suppresses sprem )
                </label>
            </div>

            <!-- 3. Cycling > 5 hours/week -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_Cycling" name="chkMale_Lifestyle" value="Cycling" />
                    Cycling &gt; 5 hours/week ( associated with sperm quality decline )
                </label>
            </div>

            <!-- 4. Pesticide / heavy metal exposure -->
            <div>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkMale_PesticideExposure" name="chkMale_Lifestyle" value="Pesticides" />
                    Pesticide / heavy metal / solvent exposure
                </label>
            </div>

            <!-- 5. Obesity & BMI -->
            <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 12px;">
                <label class="ivf-check-label" style="margin-bottom: 0;">
                    <input type="checkbox" id="chkMale_Obesity" name="chkMale_Lifestyle" value="Obesity" />
                    Obesity
                </label>
                <div style="display: inline-flex; align-items: center; gap: 6px;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">BMI</span>
                    <input type="text" id="txtMale_LifestyleBMI" class="ivf-input-sm" style="width: 65px; text-align: center;" />
                </div>
                <span style="font-weight: 500; font-size: 13.5px; color: #212529;">Target BMI 18 5 - 25</span>
            </div>

        </div>

    </div>

</div>

            <!-- ========================================== -->
<!-- Family, Genetic And Social History -->
<!-- ========================================== -->
<div id="secIVF_Family" class="ivf-scroll-section ivf-family-social-history-container" style="margin-top: 35px; margin-bottom: 25px;">

    
    <!-- Orange Header Title -->
    <h4 style="color: #ff6600; font-weight: 700; font-size: 19px; margin-top: 15px; margin-bottom: 22px;">
        Family, Genetic And Social History
    </h4>

    <!-- 1. Family history ( Female ) -->
    <div style="margin-bottom: 22px;">
        <span style="font-weight: 700; font-size: 15px; color: #212529; display: block; margin-bottom: 12px;">
            Family history ( Female )
        </span>
        <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 36px; row-gap: 12px; align-items: start;">
            <!-- Left -->
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Female_Menopause" name="chkFam_Female" value="PrematureMenopause" />
                    Premature manopause / POI ( mother/sister &lt; 40 years )
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Female_Miscarriage" name="chkFam_Female" value="RecurrentMiscarriage" />
                    Recurrent miscarriage in family ( autoimmune / thrombophilia )
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Female_PCOS" name="chkFam_Female" value="PCOS" />
                    PCOS in mother / sister
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Female_OvarianCancer" name="chkFam_Female" value="OvarianCancer" />
                    Ovarian cancer/ BRCA mutation
                </label>
            </div>
            <!-- Right -->
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Female_Turner" name="chkFam_Female" value="TurnerSyndrome" />
                    Turner syndrome / DES exposure in utero
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Female_Endometriosis" name="chkFam_Female" value="Endometriosis" />
                    Endomertriosis in mother / sister
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Female_BreastCancer" name="chkFam_Female" value="BreastCancer" />
                    Breast cancer ( BRCA 1/2- relevant for fertility preservation timing )
                </label>
            </div>
        </div>
    </div>

    <!-- 2. Family history ( Male ) -->
    <div style="margin-bottom: 22px;">
        <span style="font-weight: 700; font-size: 15px; color: #212529; display: block; margin-bottom: 12px;">
            Family history ( Male )
        </span>
        <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 36px; row-gap: 12px; align-items: start;">
            <!-- Left -->
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Male_CysticFibrosis" name="chkFam_Male" value="CysticFibrosis" />
                    Cyctic fiborsis in family ( CFTR mutation screen if azoospermia )
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Male_YDeletion" name="chkFam_Male" value="YDeletion" />
                    Y- chromosome deletion in male relatives
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Male_TesticularCancer" name="chkFam_Male" value="TesticularCancer" />
                    Testicular cancer in family
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Male_Consanguinity" name="chkFam_Male" value="Consanguinity" />
                    Consagunity-first cousin marriage
                </label>
            </div>
            <!-- Right -->
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Male_Klinefelter" name="chkFam_Male" value="Klinefelter" />
                    Klinefelt / chromosomal anomaly in family
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Male_Infertility" name="chkFam_Male" value="Infertility" />
                    Infertility in brother / father
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkFam_Male_Haemophilia" name="chkFam_Male" value="Haemophilia" />
                    Haemophilia / X-linked disorder ( PG-M implications )
                </label>
                <div style="display: flex; align-items: center; gap: 8px;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFam_Male_SingleGene" name="chkFam_Male" value="SingleGene" />
                        Known single-gene disorder
                    </label>
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Specify</span>
                    <input type="text" id="txtFam_Male_SingleGeneSpecify" class="ivf-input-sm" style="flex: 1; max-width: 200px;" />
                </div>
            </div>
        </div>
    </div>

    <!-- 3. Carrier Screening ( ethic risk ) -->
    <div style="margin-bottom: 24px;">
        <span style="font-weight: 700; font-size: 15px; color: #212529; display: block; margin-bottom: 12px;">
            Carrier Screening ( ethic risk )
        </span>
        <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 36px; row-gap: 12px; align-items: start;">
            <!-- Left -->
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkCarrier_Thalassaemia" name="chkCarrier" value="Thalassaemia" />
                    Thalassaemia screen ( both partners- South Asian / Mediterranean )
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkCarrier_CysticFibrosis" name="chkCarrier" value="CysticFibrosis" />
                    Cystic fibrosis CFTR gene screen
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkCarrier_FragileX" name="chkCarrier" value="FragileX" />
                    Fragile X ( FMR1 premulation screen- if POI or family anomaly )
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkCarrier_KaryotypeFemale" name="chkCarrier" value="KaryotypeFemale" />
                    Karyptype-female ( if POI, PRL or structural anomaly )
                </label>
            </div>
            <!-- Right -->
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkCarrier_SickleCell" name="chkCarrier" value="SickleCell" />
                    Sickle cell disease screen
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkCarrier_SMA" name="chkCarrier" value="SMA" />
                    Spinal muscular altrophy ( SMA ) screen
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkCarrier_BRCA" name="chkCarrier" value="BRCA" />
                    BRCA1/2 testing offered / completed
                </label>
                <label class="ivf-check-label">
                    <input type="checkbox" id="chkCarrier_KaryotypeMale" name="chkCarrier" value="KaryotypeMale" />
                    Karyptype-male ( if azoospermia ro servere oligozoospermia )
                </label>
            </div>
        </div>
    </div>

    <!-- 4. Social and lifestyle history ( Couple ) Table Matrix -->
    <div>
        <span style="font-weight: 700; font-size: 15px; color: #212529; display: block; margin-bottom: 12px;">
            Social and lifestyle history ( Couple )
        </span>
        <div style="overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; background-color: #fff; border: 1px solid #ced4da;">
                <tbody>
                    <!-- Row 1: BMI, Ht, Wt -->
                    <tr>
                        <td style="width: 13%; border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Femal BMI :</td>
                        <td style="width: 37%; border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; align-items: center; gap: 8px;">
                                <input type="text" id="txtCouple_FemaleBMI" class="ivf-input-sm" style="width: 60px; text-align: center;" />
                                <span style="font-weight: 600; font-size: 12.5px;">Kg/m2</span>
                                <span style="font-weight: 700; font-size: 13px; margin-left: 6px;">Ht</span>
                                <input type="text" id="txtCouple_FemaleHt" class="ivf-input-sm" style="width: 65px; text-align: center;" />
                                <span style="font-weight: 700; font-size: 13px; margin-left: 6px;">Wt</span>
                                <input type="text" id="txtCouple_FemaleWt" class="ivf-input-sm" style="width: 65px; text-align: center;" />
                            </div>
                        </td>
                        <td style="width: 13%; border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Male BMI</td>
                        <td style="width: 37%; border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; align-items: center; gap: 8px;">
                                <input type="text" id="txtCouple_MaleBMI" class="ivf-input-sm" style="width: 60px; text-align: center;" />
                                <span style="font-weight: 600; font-size: 12.5px;">Kg/m2</span>
                                <span style="font-weight: 700; font-size: 13px; margin-left: 6px;">Ht</span>
                                <input type="text" id="txtCouple_MaleHt" class="ivf-input-sm" style="width: 65px; text-align: center;" />
                                <span style="font-weight: 700; font-size: 13px; margin-left: 6px;">Wt</span>
                                <input type="text" id="txtCouple_MaleWt" class="ivf-input-sm" style="width: 65px; text-align: center;" />
                            </div>
                        </td>
                    </tr>

                    <!-- Row 2: Exercise -->
                    <tr>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Female exercise:</td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_FemaleEx_None" name="chkCouple_FemaleEx" value="None" /> None
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_FemaleEx_Light" name="chkCouple_FemaleEx" value="Light" /> Light
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_FemaleEx_Moderate" name="chkCouple_FemaleEx" value="Moderate" /> Moderate
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_FemaleEx_Excessive" name="chkCouple_FemaleEx" value="Excessive" /> Excessive
                                </label>
                            </div>
                        </td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Male exercise</td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; flex-direction: column; gap: 4px;">
                                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_MaleEx_None" name="chkCouple_MaleEx" value="None" /> None
                                    </label>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_MaleEx_Light" name="chkCouple_MaleEx" value="Light" /> Light
                                    </label>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_MaleEx_Moderate" name="chkCouple_MaleEx" value="Moderate" /> Moderate
                                    </label>
                                </div>
                                <div>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_MaleEx_Cycling" name="chkCouple_MaleEx" value="CyclingHeatExposure" /> Cycling / heat exposure
                                    </label>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <!-- Row 3: Stress & Psychological support -->
                    <tr>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Stress levels:</td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_Stress_Low" name="chkCouple_Stress" value="Low" /> Low
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_Stress_Moderate" name="chkCouple_Stress" value="Moderate" /> Moderate
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_Stress_High" name="chkCouple_Stress" value="High" /> High ( work / infertlitly- related )
                                </label>
                            </div>
                        </td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Psychological support ?</td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_Psych_None" name="chkCouple_Psych" value="None" /> None
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_Psych_Counselling" name="chkCouple_Psych" value="Counselling" /> Couselling
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_Psych_CBT" name="chkCouple_Psych" value="CBT" /> CBT
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_Psych_SupportGroup" name="chkCouple_Psych" value="SupportGroup" /> Support group
                                </label>
                            </div>
                        </td>
                    </tr>

                    <!-- Row 4: Diet -->
                    <tr>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Diet (female)</td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; flex-direction: column; gap: 4px;">
                                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_FemaleDiet_Omnivore" name="chkCouple_FemaleDiet" value="Omnivore" /> Omnivore
                                    </label>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_FemaleDiet_Vegetarian" name="chkCouple_FemaleDiet" value="Vegetarian" /> Vegitarian
                                    </label>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_FemaleDiet_Vegan" name="chkCouple_FemaleDiet" value="Vegan" /> Vegan
                                    </label>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_FemaleDiet_GlutenFree" name="chkCouple_FemaleDiet" value="GlutenFree" /> Gluten-free
                                    </label>
                                </div>
                                <div>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_FemaleDiet_Jain" name="chkCouple_FemaleDiet" value="Jain" /> Jain
                                    </label>
                                </div>
                            </div>
                        </td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Diet ( male )</td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; flex-direction: column; gap: 4px;">
                                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_MaleDiet_Omnivore" name="chkCouple_MaleDiet" value="Omnivore" /> Omnivore
                                    </label>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_MaleDiet_Vegetarian" name="chkCouple_MaleDiet" value="Vegetarian" /> Vegetarian
                                    </label>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_MaleDiet_Vegan" name="chkCouple_MaleDiet" value="Vegan" /> Vegan
                                    </label>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_MaleDiet_Keto" name="chkCouple_MaleDiet" value="Keto" /> Keto
                                    </label>
                                </div>
                                <div>
                                    <label class="ivf-check-label" style="margin-bottom: 0;">
                                        <input type="checkbox" id="chkCouple_MaleDiet_HighProcessed" name="chkCouple_MaleDiet" value="HighProcessed" /> High-processed
                                    </label>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <!-- Row 5: Folic acid & Vitamin D -->
                    <tr>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Folic acid taken?</td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_FolicAcid_Yes" name="chkCouple_FolicAcid" value="Yes" /> Yes
                                </label>
                                <input type="text" id="txtCouple_FolicDose" class="ivf-input-sm" style="width: 55px;" placeholder="dose" />
                                <span style="font-weight: 500; font-size: 13px;">dose</span>
                                <input type="text" id="txtCouple_FolicStarted" class="ivf-input-sm" style="width: 60px;" placeholder="started" />
                                <span style="font-weight: 500; font-size: 13px;">started</span>
                                <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                                    <input type="checkbox" id="chkCouple_FolicAcid_No" name="chkCouple_FolicAcid" value="No" /> No
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="checkbox" id="chkCouple_FolicAcid_Prenatal" name="chkCouple_FolicAcid" value="PrenatalMulti" /> Pre-natal multi
                                </label>
                            </div>
                        </td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px; font-weight: 700; font-size: 13px;">Vitamin D ?</td>
                        <td style="border: 1px solid #ced4da; padding: 7px 10px;">
                            <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="radio" name="rdoCouple_VitD" value="Yes" /> Yes
                                </label>
                                <label class="ivf-check-label" style="margin-bottom: 0;">
                                    <input type="radio" name="rdoCouple_VitD" value="No" /> No
                                </label>
                                <span style="font-weight: 700; font-size: 13px; margin-left: 6px;">Level:</span>
                                <input type="text" id="txtCouple_VitDLevel" class="ivf-input-sm" style="width: 85px;" />
                                <span style="font-weight: 600; font-size: 12.5px;">nmo/L</span>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</div>

            <!-- ========================================== -->
<!-- Physical Examination -->
<!-- ========================================== -->
<div id="secIVF_Physical" class="ivf-scroll-section ivf-physical-examination-container" style="margin-top: 35px; margin-bottom: 25px;">

    
    <!-- Orange Header Title -->
    <h4 style="color: #ff6600; font-weight: 700; font-size: 19px; margin-top: 15px; margin-bottom: 20px;">
        Physical Examination
    </h4>

    <!-- Section Title (Blue) -->
    <div class="ivf-section-title">
        A ) Female General Examination:
    </div>

    <!-- 2-Column Main Layout -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 40px; row-gap: 20px; align-items: start;">

        <!-- ================= Left Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 18px;">
            
            <!-- 1. General : -->
            <div>
                <span class="ivf-label-title">General :</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Gen_Well" name="chkFemaleExam_Gen" value="Well" /> Well
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Gen_Overweight" name="chkFemaleExam_Gen" value="Overweight" /> Overweight
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Gen_Underweight" name="chkFemaleExam_Gen" value="Underweight" /> Underweight
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Gen_Hirsute" name="chkFemaleExam_Gen" value="Hirsute" /> Hirsute
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Gen_Acne" name="chkFemaleExam_Gen" value="Acne" /> Acne
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Gen_Acanthosis" name="chkFemaleExam_Gen" value="AcanthosisNigricans" /> Acathaosis nigricans
                    </label>
                </div>
            </div>

            <!-- 2. BMI / waist: -->
            <div>
                <span class="ivf-label-title">BMI / waist:</span>
                <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">BMI</span>
                    <input type="text" id="txtFemaleExam_BMI" class="ivf-input-sm" style="width: 60px; text-align: center;" />
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">kg/m2</span>

                    <span style="font-weight: 700; font-size: 13.5px; color: #212529; margin-left: 8px;">Waist</span>
                    <input type="text" id="txtFemaleExam_Waist" class="ivf-input-sm" style="width: 100px; text-align: center;" />
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">Cm</span>

                    <span style="font-weight: 700; font-size: 13.5px; color: #212529; margin-left: 8px;">Waist Hip ratio:</span>
                    <input type="text" id="txtFemaleExam_WaistHipRatio" class="ivf-input-sm" style="width: 90px; text-align: center;" />
                </div>
            </div>

            <!-- 3. Thyroid: -->
            <div>
                <span class="ivf-label-title">Thyroid:</span>
                <div style="display: flex; align-items: center; gap: 16px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Thyroid_Normal" name="chkFemaleExam_Thyroid" value="Normal" /> Normal
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Thyroid_Goitre" name="chkFemaleExam_Thyroid" value="Goitre" /> Goitre
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Thyroid_Tender" name="chkFemaleExam_Thyroid" value="Tender" /> Tender
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Thyroid_Bruit" name="chkFemaleExam_Thyroid" value="Bruit" /> Bruit
                    </label>
                </div>
            </div>

            <!-- 4. Acanthosis nigricans: -->
            <div>
                <span class="ivf-label-title">Acanthosis nigricans:</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Acanthosis_Absent" name="chkFemaleExam_Acanthosis" value="Absent" /> Absent
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Acanthosis_Neck" name="chkFemaleExam_Acanthosis" value="Neck" /> Neck
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Acanthosis_Axillance" name="chkFemaleExam_Acanthosis" value="Axillance" /> Axillance
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Acanthosis_Groin" name="chkFemaleExam_Acanthosis" value="Groin" /> Gorin ( insulin resistance marker )
                    </label>
                </div>
            </div>

        </div>

        <!-- ================= Right Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 18px;">
            
            <!-- 1. BP / Pulse: -->
            <div>
                <span class="ivf-label-title">BP / Pulse:</span>
                <div style="display: flex; align-items: center; gap: 8px;">
                    <input type="text" id="txtFemaleExam_BPSystolic" class="ivf-input-sm" style="width: 55px; text-align: center;" />
                    <span style="font-weight: 700; color: #555;">/</span>
                    <input type="text" id="txtFemaleExam_BPDiastolic" class="ivf-input-sm" style="width: 55px; text-align: center;" />
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">mmHg</span>

                    <input type="text" id="txtFemaleExam_Pulse" class="ivf-input-sm" style="width: 60px; text-align: center; margin-left: 10px;" />
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">/min</span>
                </div>
            </div>

            <!-- 2. Ferriman-Gallwey: -->
            <div>
                <span class="ivf-label-title">Ferriman-Gallwey:</span>
                <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Score:</span>
                    <input type="text" id="txtFemaleExam_FerrimanScore" class="ivf-input-sm" style="width: 60px; text-align: center;" />
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">/ 36 ( &gt;8=hirutism)</span>
                    <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 8px;">
                        <input type="checkbox" id="chkFemaleExam_ClinicalPCOS" name="chkFemaleExam_ClinicalPCOS" value="ClinicalPCOS" /> Clinical PCOS
                    </label>
                </div>
            </div>

            <!-- 3. Breast exam -->
            <div>
                <span class="ivf-label-title">Breast exam</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Breast_Normal" name="chkFemaleExam_Breast" value="Normal" /> Normal
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Breast_Lump" name="chkFemaleExam_Breast" value="Lump" /> Lump
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Breast_Galactorrhoea" name="chkFemaleExam_Breast" value="Galactorrhoea" /> Galactorhoea (protactin elevated ? )
                    </label>
                </div>
            </div>

            <!-- 4. Skin care -->
            <div>
                <span class="ivf-label-title">Skin care</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Skin_Normal" name="chkFemaleExam_Skin" value="Normal" /> Normal
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Skin_Androgenic" name="chkFemaleExam_Skin" value="Androgenic" /> Androgenic
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Skin_Alopecia" name="chkFemaleExam_Skin" value="Alopecia" /> Alopecia
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Skin_Hirsutism" name="chkFemaleExam_Skin" value="Hirsutism" /> Hirsutism
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleExam_Skin_Acne" name="chkFemaleExam_Skin" value="Acne" /> Acne
                    </label>
                </div>
            </div>

        </div>

    </div>

</div>

            <!-- ========================================== -->
<!-- B ) Female Gynaecological Examination -->
<!-- ========================================== -->
<div class="ivf-female-gynae-exam-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title (Blue) -->
    <div class="ivf-section-title">
        B ) Female Gynaecological Examination :
    </div>

    <!-- 2-Column Main Layout -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 40px; row-gap: 20px; align-items: start;">

        <!-- ================= Left Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 18px;">
            
            <!-- 1. Speculum exam -->
            <div>
                <span class="ivf-label-title">Speculum exam</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Cervix_Normal" name="chkFemaleGyn_Speculum" value="NormalCervix" /> Normal cervix
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Cervix_Ectropion" name="chkFemaleGyn_Speculum" value="Ectropion" /> Ectropion
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Cervix_Discharge" name="chkFemaleGyn_Speculum" value="Discharge" /> Discharge
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Cervix_Lesion" name="chkFemaleGyn_Speculum" value="Lesion" /> Lesion
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Cervix_BlueNodule" name="chkFemaleGyn_Speculum" value="BlueNodule" /> Blue nodule
                    </label>
                </div>
            </div>

            <!-- 2. Uterus ( bimanaul ) -->
            <div>
                <span class="ivf-label-title">Uterus ( bimanaul )</span>
                <div style="display: flex; flex-direction: column; gap: 8px;">
                    <!-- Line 1 -->
                    <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Size:</span>
                        <input type="text" id="txtFemaleGyn_UterusSize" class="ivf-input-sm" style="width: 55px; text-align: center;" />
                        <span style="font-weight: 700; font-size: 13px; color: #212529;">wks</span>

                        <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                            <input type="checkbox" id="chkFemaleGyn_Uterus_NormalMobile" name="chkFemaleGyn_Uterus" value="NormalMobile" /> Normal moblie
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkFemaleGyn_Uterus_Bulky" name="chkFemaleGyn_Uterus" value="Bulky" /> Bulky ( adenomyosis ? )
                        </label>
                    </div>
                    <!-- Line 2 -->
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkFemaleGyn_Uterus_Irregular" name="chkFemaleGyn_Uterus" value="IrregularFibroids" /> Irregular (fibroids )
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkFemaleGyn_Uterus_Fixed" name="chkFemaleGyn_Uterus" value="FixedRetroverted" /> Fixed / retroverted
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkFemaleGyn_Uterus_Tender" name="chkFemaleGyn_Uterus" value="Tender" /> Tender
                        </label>
                    </div>
                </div>
            </div>

            <!-- 3. Right adnexa -->
            <div>
                <span class="ivf-label-title">Right adnexa</span>
                <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_RAdnexa_Clear" name="chkFemaleGyn_RAdnexa" value="Clear" /> Clear
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_RAdnexa_Mass" name="chkFemaleGyn_RAdnexa" value="Mass" /> Mass
                    </label>
                    <input type="text" id="txtFemaleGyn_RAdnexa_MassCm" class="ivf-input-sm" style="width: 55px; text-align: center;" />
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">cm</span>

                    <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                        <input type="checkbox" id="chkFemaleGyn_RAdnexa_Tender" name="chkFemaleGyn_RAdnexa" value="Tender" /> Tender
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_RAdnexa_Fixed" name="chkFemaleGyn_RAdnexa" value="Fixed" /> Fixed
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_RAdnexa_Endometrioma" name="chkFemaleGyn_RAdnexa" value="Endometrioma" /> Endomertrioma
                    </label>
                </div>
            </div>

            <!-- 4. POD / USI -->
            <div>
                <span class="ivf-label-title">POD / USI</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkFemaleGyn_POD_Free" name="chkFemaleGyn_POD" value="FreePOD" /> Free POD ( sliding sign positive
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkFemaleGyn_POD_Nodules" name="chkFemaleGyn_POD" value="Nodules" /> Nodules
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkFemaleGyn_POD_Obliterated" name="chkFemaleGyn_POD" value="Obliterated" /> Obliterated
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkFemaleGyn_POD_POD" name="chkFemaleGyn_POD" value="POD" /> POD
                        </label>
                    </div>
                    <div>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkFemaleGyn_POD_USLNodularity" name="chkFemaleGyn_POD" value="USLNodularity" /> USL nodularity
                        </label>
                    </div>
                </div>
            </div>

        </div>

        <!-- ================= Right Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 18px;">
            
            <!-- 1. Vault -->
            <div>
                <span class="ivf-label-title">Vault</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Vault_Normal" name="chkFemaleGyn_Vault" value="Normal" /> Normal
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Vault_Nodule" name="chkFemaleGyn_Vault" value="Nodule" /> Nodule
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Vault_Irregular" name="chkFemaleGyn_Vault" value="IrregularFibroids" /> Irregular (fibroids )
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Vault_Induration" name="chkFemaleGyn_Vault" value="IndurationPosteriorFornix" /> Induration in posterior fornix
                    </label>
                </div>
            </div>

                        <!-- 2. TVUS today -->
            <div>
                <span class="ivf-label-title">TVUS today</span>
                <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                    
                    <!-- Uterus -->
                    <div style="display: inline-flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Uterus:</span>
                        <input type="text" id="txtFemaleGyn_TVUS_UterusW" class="ivf-input-sm" style="width: 50px; text-align: center;" />
                        <span style="font-weight: 700; font-size: 13px; color: #555;">x</span>
                        <input type="text" id="txtFemaleGyn_TVUS_UterusH" class="ivf-input-sm" style="width: 50px; text-align: center;" />
                        <span style="font-weight: 700; font-size: 13px; color: #212529;">mm</span>
                    </div>

                    <!-- Endometrium -->
                    <div style="display: inline-flex; align-items: center; gap: 6px;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Endometrium</span>
                        <input type="text" id="txtFemaleGyn_TVUS_Endo" class="ivf-input-sm" style="width: 50px; text-align: center;" />
                        <span style="font-weight: 700; font-size: 13px; color: #212529;">mm</span>
                    </div>

                    <!-- AFC R & L (Always on the same parallel line) -->
                    <div style="display: inline-flex; align-items: center; gap: 6px; white-space: nowrap;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">AFC R:</span>
                        <input type="text" id="txtFemaleGyn_TVUS_AFCR" class="ivf-input-sm" style="width: 50px; text-align: center;" />
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529; margin-left: 4px;">L:</span>
                        <input type="text" id="txtFemaleGyn_TVUS_AFCL" class="ivf-input-sm" style="width: 50px; text-align: center;" />
                    </div>

                </div>
            </div>


            <!-- 3. Left adnexa -->
            <div>
                <span class="ivf-label-title">Left adnexa</span>
                <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_LAdnexa_Clear" name="chkFemaleGyn_LAdnexa" value="Clear" /> Clear
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_LAdnexa_Mass" name="chkFemaleGyn_LAdnexa" value="Mass" /> Mass
                    </label>
                    <input type="text" id="txtFemaleGyn_LAdnexa_MassCm" class="ivf-input-sm" style="width: 55px; text-align: center;" />
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">cm</span>

                    <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                        <input type="checkbox" id="chkFemaleGyn_LAdnexa_Tender" name="chkFemaleGyn_LAdnexa" value="Tender" /> Tender
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_LAdnexa_Fixed" name="chkFemaleGyn_LAdnexa" value="Fixed" /> Fixed
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_LAdnexa_Endometrioma" name="chkFemaleGyn_LAdnexa" value="Endometrioma" /> Endometrioma
                    </label>
                </div>
            </div>

            <!-- 4. Cervical smear -->
            <div>
                <span class="ivf-label-title">Cervical smear</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Smear_UpToDate" name="chkFemaleGyn_Smear" value="UpToDate" /> Up to date
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Smear_Due" name="chkFemaleGyn_Smear" value="Due" /> Due
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkFemaleGyn_Smear_DoneToday" name="chkFemaleGyn_Smear" value="DoneToday" /> Done today
                    </label>
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">HPV status:</span>
                    <input type="text" id="txtFemaleGyn_HPVStatus" class="ivf-input-sm" style="width: 60px; text-align: center;" />
                </div>
            </div>

        </div>

    </div>

</div>

            <!-- ========================================== -->
<!-- C ) Male Physical Examination -->
<!-- ========================================== -->
<div class="ivf-male-physical-exam-container" style="margin-top: 25px; margin-bottom: 25px;">
    
    <!-- Section Title (Blue) -->
    <div class="ivf-section-title">
        C ) Male Physical Examination
    </div>

    <!-- 2-Column Main Layout -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 40px; row-gap: 20px; align-items: start;">

        <!-- ================= Left Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 18px;">
            
            <!-- 1. General / virilisation -->
            <div>
                <span class="ivf-label-title">General / virllisation</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_Gen_SecondarySex" name="chkMaleExam_Gen" value="NormalSecondarySex" /> Normal secondary sex characters
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_Gen_Eunuchoid" name="chkMaleExam_Gen" value="EunuchoidHabitus" /> Eunuchoid habitus
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_Gen_Gynaecomastia" name="chkMaleExam_Gen" value="Gynaecomastia" /> Gynaecomastia
                        </label>
                    </div>
                    <div>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_Gen_HairDistribution" name="chkMaleExam_Gen" value="NormalHairDistribution" /> Normal distribution of body hair
                        </label>
                    </div>
                </div>
            </div>

            <!-- 2. Right testis -->
            <div>
                <span class="ivf-label-title">Right testis</span>
                <div style="display: flex; flex-direction: column; gap: 8px;">
                    <!-- Line 1: Vol & Characteristics -->
                    <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Vol:</span>
                        <input type="text" id="txtMaleExam_RTestis_Vol" class="ivf-input-sm" style="width: 55px; text-align: center;" />
                        <span style="font-weight: 700; font-size: 13px; color: #212529;">ml</span>

                        <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                            <input type="checkbox" id="chkMaleExam_RTestis_Normal" name="chkMaleExam_RTestis" value="Normal" /> Normal
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_RTestis_Small" name="chkMaleExam_RTestis" value="Small" /> Small
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_RTestis_Soft" name="chkMaleExam_RTestis" value="Soft" /> Soft
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_RTestis_Tender" name="chkMaleExam_RTestis" value="Tender" /> Tender
                        </label>
                    </div>
                    <!-- Line 2: Epididymis -->
                    <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_RTestis_AbsentEpid" name="chkMaleExam_RTestis" value="AbsentEpididymis" /> Absent Epididymis:
                        </label>
                        <div style="display: inline-flex; align-items: center; gap: 10px;">
                            <label class="ivf-check-label" style="margin-bottom: 0;">
                                <input type="radio" name="rdoMaleExam_R_Epididymis" value="Normal" /> Normal
                            </label>
                            <label class="ivf-check-label" style="margin-bottom: 0;">
                                <input type="radio" name="rdoMaleExam_R_Epididymis" value="Indurated" /> indurated
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 3. Varicocele -->
            <div>
                <span class="ivf-label-title">Varicocele</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <!-- Right -->
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529; width: 45px;">Right</span>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_R_Varicocele_None" name="chkMaleExam_R_Varicocele" value="None" /> None
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_R_Varicocele_Grade2" name="chkMaleExam_R_Varicocele" value="GradeII" /> Grade II
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_R_Varicocele_Grade3" name="chkMaleExam_R_Varicocele" value="GradeIII" /> Grade III ( visible )
                        </label>
                    </div>
                    <!-- Left -->
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529; width: 45px;">Left</span>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_L_Varicocele_None" name="chkMaleExam_L_Varicocele" value="None" /> None
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_L_Varicocele_Grade2" name="chkMaleExam_L_Varicocele" value="GradeII" /> Grade II
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_L_Varicocele_Grade3" name="chkMaleExam_L_Varicocele" value="GradeIII" /> Grade III
                        </label>
                    </div>
                </div>
            </div>

            <!-- 4. Scrotal USS today -->
            <div>
                <span class="ivf-label-title">Scrotal USS today</span>
                <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMaleExam_ScrotalUSS_Done" name="chkMaleExam_ScrotalUSS" value="Done" /> Done
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMaleExam_ScrotalUSS_NotDone" name="chkMaleExam_ScrotalUSS" value="NotDone" /> Not done Findings:
                    </label>
                    <input type="text" id="txtMaleExam_ScrotalUSS_Findings" class="ivf-input-sm" style="width: 80px;" />
                </div>
            </div>

        </div>

        <!-- ================= Right Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 18px;">
            
            <!-- 1. BMI : -->
            <div>
                <span class="ivf-label-title">BMI :</span>
                <div style="display: flex; align-items: center; gap: 8px;">
                    <input type="text" id="txtMaleExam_BMI" class="ivf-input-sm" style="width: 60px; text-align: center;" />
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">Kg/m2</span>
                </div>
            </div>

            <!-- 2. Left testis -->
            <div>
                <span class="ivf-label-title">Left testis</span>
                <div style="display: flex; flex-direction: column; gap: 8px;">
                    <!-- Line 1: Vol & Characteristics -->
                    <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Vol:</span>
                        <input type="text" id="txtMaleExam_LTestis_Vol" class="ivf-input-sm" style="width: 55px; text-align: center;" />
                        <span style="font-weight: 700; font-size: 13px; color: #212529;">ml</span>

                        <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                            <input type="checkbox" id="chkMaleExam_LTestis_Normal" name="chkMaleExam_LTestis" value="Normal" /> Normal
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_LTestis_Small" name="chkMaleExam_LTestis" value="Small" /> Small
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_LTestis_Soft" name="chkMaleExam_LTestis" value="Soft" /> Soft
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_LTestis_Tender" name="chkMaleExam_LTestis" value="Tender" /> Tender
                        </label>
                    </div>
                    <!-- Line 2: Epididymis -->
                    <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_LTestis_AbsentEpid" name="chkMaleExam_LTestis" value="AbsentEpididymis" /> Absent Epididymis:
                        </label>
                        <div style="display: inline-flex; align-items: center; gap: 10px;">
                            <label class="ivf-check-label" style="margin-bottom: 0;">
                                <input type="radio" name="rdoMaleExam_L_Epididymis" value="Normal" /> Normal
                            </label>
                            <label class="ivf-check-label" style="margin-bottom: 0;">
                                <input type="radio" name="rdoMaleExam_L_Epididymis" value="Indurated" /> indurated
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 3. Vas deferens -->
            <div>
                <span class="ivf-label-title">Vas deferens</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <!-- Right -->
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529; width: 45px;">Right:</span>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_R_Vas_Palpable" name="chkMaleExam_R_Vas" value="Palpable" /> Palpable
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_R_Vas_Absent" name="chkMaleExam_R_Vas" value="AbsentCBAVD" /> Absent ( CBAVD )
                        </label>
                    </div>
                    <!-- Left -->
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <span style="font-weight: 700; font-size: 13.5px; color: #212529; width: 45px;">Left</span>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_L_Vas_Palpable" name="chkMaleExam_L_Vas" value="Palpable" /> Palpable
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkMaleExam_L_Vas_Absent" name="chkMaleExam_L_Vas" value="AbsentCBAVD" /> Absent ( CBAVD )
                        </label>
                    </div>
                </div>
            </div>

            <!-- 4. Rectal exam -->
            <div>
                <span class="ivf-label-title">Rectal exam</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMaleExam_Rectal_None" name="chkMaleExam_Rectal" value="NoneDone" /> None done
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMaleExam_Rectal_NormalProstate" name="chkMaleExam_Rectal" value="NormalProstate" /> Normal prostate
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkMaleExam_Rectal_MidlineCyst" name="chkMaleExam_Rectal" value="MidlineCyst" /> Midline cyst ( ejaculatory duct )
                    </label>
                </div>
            </div>

        </div>

    </div>

</div>

            <!-- ========================================== -->
<!-- Diagnosis -->
<!-- ========================================== -->
<div id="secIVF_Diagnosis" class="ivf-scroll-section ivf-diagnosis-container" style="margin-top: 35px; margin-bottom: 25px;">

    
    <!-- Orange Header Title -->
    <h4 style="color: #ff6600; font-weight: 700; font-size: 19px; margin-top: 15px; margin-bottom: 22px;">
        Diagnosis
    </h4>

    <!-- 2-Column Main Layout -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 40px; row-gap: 20px; align-items: start; margin-bottom: 22px;">

        <!-- ================= Left Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 18px;">
            
            <!-- 1. Unexplained infertility -->
            <div>
                <span class="ivf-label-title">Unexplained infertility</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <span style="font-size: 13.5px; font-weight: 500; color: #212529;">All investigation normal</span>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Unexplained_Duration" name="chkDiag_Unexplained" value="Duration" /> Duration
                    </label>
                    <input type="text" id="txtDiag_UnexplainedDurationYears" class="ivf-input-sm" style="width: 60px; text-align: center;" />
                    <span style="font-weight: 500; font-size: 13.5px; color: #212529;">years</span>
                </div>
            </div>

            <!-- 2. Anovulation / oligo-ovulation -->
            <div>
                <span class="ivf-label-title">Anovulation / oligo-ovulation</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Anov_PCOS" name="chkDiag_Anovulation" value="PCOS" /> PCOS
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Anov_Hyperprolactin" name="chkDiag_Anovulation" value="Hyperprolactinaemia" /> Hyperprolactinaemia
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Anov_POI" name="chkDiag_Anovulation" value="POI" /> POI
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Anov_Thyroid" name="chkDiag_Anovulation" value="Thyroid" /> Thyroid
                    </label>
                </div>
            </div>

            <!-- 3. Diminished ovarian reserve ( DOR/ Low AMH ) -->
            <div>
                <span class="ivf-label-title">Diminished ovarian reserve ( DOR/ Low AMH )</span>
                <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">AMH:</span>
                    <input type="text" id="txtDiag_DOR_AMH" class="ivf-input-sm" style="width: 60px; text-align: center;" />
                    <span style="font-weight: 700; font-size: 13px; color: #212529;">ng/mL</span>

                    <span style="font-weight: 700; font-size: 13px; color: #212529; margin-left: 6px;">AFC:</span>
                    <input type="text" id="txtDiag_DOR_AFC" class="ivf-input-sm" style="width: 55px; text-align: center;" />

                    <span style="font-weight: 700; font-size: 13px; color: #212529; margin-left: 6px;">POSEIDON Group</span>
                    <input type="text" id="txtDiag_DOR_Poseidon" class="ivf-input-sm" style="width: 55px; text-align: center;" />
                </div>
            </div>

            <!-- 4. PCOS ( Rotterdam criteria -->
            <div>
                <span class="ivf-label-title">PCOS ( Roterdam criteria</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_PCOS_Oligo" name="chkDiag_PCOSCriteria" value="Oligoanovulation" /> Oligo/anovaulation
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_PCOS_Hyperandrogen" name="chkDiag_PCOSCriteria" value="Hyperandrogenism" /> Hyperanddrogenism
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_PCOS_Morphology" name="chkDiag_PCOSCriteria" value="PCOMorphology" /> PCO morphology on USS
                    </label>
                </div>
            </div>

            <!-- 5. Tubal factor infertility -->
            <div>
                <span class="ivf-label-title">Tubal factor infertility</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Tubal_Unilateral" name="chkDiag_Tubal" value="Unilateral" /> Unilateral
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Tubal_Bilateral" name="chkDiag_Tubal" value="BilateralBlock" /> Bilateral block
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Tubal_Hydrosalpinx" name="chkDiag_Tubal" value="Hydrosalpinx" /> Hydrosalphix
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Tubal_Proximal" name="chkDiag_Tubal" value="Proximal" /> Proximal
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Tubal_Distal" name="chkDiag_Tubal" value="Distal" /> Distal
                    </label>
                </div>
            </div>

            <!-- 6. Endometriosis-related infertility -->
            <div>
                <span class="ivf-label-title">Endomertriosis-related infertility</span>
                <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Stage:</span>
                    <input type="text" id="txtDiag_EndoStage" class="ivf-input-sm" style="width: 60px; text-align: center;" />

                    <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                        <input type="checkbox" id="chkDiag_Endo_Peritoneal" name="chkDiag_Endometriosis" value="Peritoneal" /> Peritoneal
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Endo_Endometrioma" name="chkDiag_Endometriosis" value="Endometrioma" /> Endometrioma
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Endo_DIE" name="chkDiag_Endometriosis" value="DIE" /> DIE
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Endo_PostSurgical" name="chkDiag_Endometriosis" value="PostSurgical" /> Post-Surgical
                    </label>
                </div>
            </div>

            <!-- 7. Uterine factor infertility -->
            <div>
                <span class="ivf-label-title">Uterine factor infertility</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Uterine_Fibroids" name="chkDiag_Uterine" value="Fibroids" /> Fibroids
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Uterine_Polyps" name="chkDiag_Uterine" value="Polyps" /> Polyps
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Uterine_Septum" name="chkDiag_Uterine" value="Septum" /> Septum
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Uterine_Asherman" name="chkDiag_Uterine" value="Ashermans" /> Asherman's
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Uterine_Adenomyosis" name="chkDiag_Uterine" value="Adenomyosis" /> Adenomyosis
                    </label>
                </div>
            </div>

            <!-- 8. Male factor infertility -->
            <div>
                <span class="ivf-label-title">Male factor infertility</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Male_Oligo" name="chkDiag_MaleFactor" value="Oligozoospermia" /> Oligozoopemia
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Male_Astheno" name="chkDiag_MaleFactor" value="Asthenozoospermia" /> Asthenozoospermia
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Male_Terato" name="chkDiag_MaleFactor" value="Teratozoospermia" /> Teratozoospermia
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Male_OAT" name="chkDiag_MaleFactor" value="OAT" /> OAT
                    </label>
                </div>
            </div>

        </div>

        <!-- ================= Right Column ================= -->
        <div style="display: flex; flex-direction: column; gap: 18px;">
            
            <!-- 1. Azoospermia -->
            <div>
                <span class="ivf-label-title">Azoospermia</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_Azoo_OA" name="chkDiag_Azoospermia" value="OA" /> Obstructive (OA)
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_Azoo_NOA" name="chkDiag_Azoospermia" value="NOA" /> Non-obstructive ( NOA )
                        </label>
                    </div>
                    <div>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_Azoo_Klinefelter" name="chkDiag_Azoospermia" value="Klinefelters" /> Klinefelter's
                        </label>
                    </div>
                </div>
            </div>

            <!-- 2. Recurrent pregnancy loss ( RPL ) -->
            <div>
                <span class="ivf-label-title">Recurrent pregnancy loss ( RPL )</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_RPL_Chromosomal" name="chkDiag_RPL" value="Chromosomal" /> Chromosomal
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_RPL_Anatomical" name="chkDiag_RPL" value="Anatomical" /> Anatomical
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_RPL_Thrombophilia" name="chkDiag_RPL" value="Thrombophilia" /> Thrombophilia
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_RPL_Immunological" name="chkDiag_RPL" value="Immunological" /> Immunological
                        </label>
                    </div>
                    <div>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_RPL_Unexplained" name="chkDiag_RPL" value="Unexplained" /> Unexplained
                        </label>
                    </div>
                </div>
            </div>

            <!-- 3. Advanced maternal age -->
            <div>
                <span class="ivf-label-title">Advanced maternal age</span>
                <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Age:</span>
                    <input type="text" id="txtDiag_AdvMaternalAge" class="ivf-input-sm" style="width: 55px; text-align: center;" />
                    <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                        <input type="checkbox" id="chkDiag_AdvMaternalAge_Discussion" name="chkDiag_AdvMaternalAge" value="DiscussionDone" /> Discussion re: success rates / donor egg / embryo donation
                    </label>
                </div>
            </div>

            <!-- 4. Premature ovarian insufficiency ( POI ) -->
            <div>
                <span class="ivf-label-title">Premature ovarian insufficiency ( POI )</span>
                <div style="display: flex; flex-direction: column; gap: 6px;">
                    <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                        <span style="font-weight: 700; font-size: 13px; color: #212529;">FSH:</span>
                        <input type="text" id="txtDiag_POI_FSH" class="ivf-input-sm" style="width: 55px; text-align: center;" />

                        <span style="font-weight: 700; font-size: 13px; color: #212529; margin-left: 6px;">AMH:</span>
                        <input type="text" id="txtDiag_POI_AMH" class="ivf-input-sm" style="width: 55px; text-align: center;" />

                        <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                            <input type="checkbox" id="chkDiag_POI_Autoimmune" name="chkDiag_POI" value="Autoimmune" /> Autoimmune
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_POI_Genetic" name="chkDiag_POI" value="Genetic" /> Genetic
                        </label>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_POI_Iatrogenic" name="chkDiag_POI" value="Iatrogenic" /> Latrogenic
                        </label>
                    </div>
                    <div>
                        <label class="ivf-check-label" style="margin-bottom: 0;">
                            <input type="checkbox" id="chkDiag_POI_Idiopathic" name="chkDiag_POI" value="Idiopathic" /> Idiopathic
                        </label>
                    </div>
                </div>
            </div>

            <!-- 5. Genetic / chromosomal diagnosis -->
            <div>
                <span class="ivf-label-title">Genetic / chromosomal diagonsis</span>
                <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                    <span style="font-weight: 700; font-size: 13.5px; color: #212529;">Karotype</span>
                    <input type="text" id="txtDiag_Karyotype" class="ivf-input-sm" style="width: 60px; text-align: center;" />

                    <label class="ivf-check-label" style="margin-bottom: 0; margin-left: 6px;">
                        <input type="checkbox" id="chkDiag_Genetic_PGTA" name="chkDiag_Genetic" value="PGTA_Required" /> PGT-A requried
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Genetic_PGTM" name="chkDiag_Genetic" value="PGTM" /> PGT-M
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Genetic_PGTSR" name="chkDiag_Genetic" value="PGTSR" /> PGT-SR
                    </label>
                </div>
            </div>

            <!-- 6. Immunological infertility -->
            <div>
                <span class="ivf-label-title">Immunological infertility</span>
                <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Immune_AntiSperm" name="chkDiag_Immune" value="AntiSpermAntibodies" /> Anti-sperm antibodies
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Immune_NKCells" name="chkDiag_Immune" value="NKCellsElevated" /> NK cells elevated
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Immune_APS" name="chkDiag_Immune" value="APS" /> APS
                    </label>
                    <label class="ivf-check-label" style="margin-bottom: 0;">
                        <input type="checkbox" id="chkDiag_Immune_ANA" name="chkDiag_Immune" value="ANAPositive" /> ANA positive
                    </label>
                </div>
            </div>

        </div>

    </div>

 
      <!-- ================= Full-Width Bottom Notes ================= -->
    <div style="margin-top: 15px;">
        <span class="ivf-label-title" style="margin-bottom: 6px;">
            Additional diagnosis / notes:
        </span>
                <textarea id="txtDiag_AdditionalNotes" rows="5" placeholder="Enter additional clinical diagnosis notes..." style="width: 100%; height: 105px; padding: 8px 10px; font-size: 13.5px; border: 1px solid #ced4da; border-radius: 4px; resize: none; overflow-y: auto; line-height: 1.5; font-family: inherit; outline: none; box-sizing: border-box; background-color: #fff;"></textarea>
    </div>


</div>


        </div>

    </div>

   
  

</div>

<!-- JavaScript to Open, Close, Datepickers & Validations -->
<script type="text/javascript">
$(document).ready(function() {
    InitIVFDatepickers();
    InitIVFValidations();
    InitIVFScrollSpy();
});

function OpenIVFHistoryModal() {
    // Move to body to keep background dim strictly behind the popup
    $("body").append($("#Hist_M_IVFHistory"));
    $("#popupOverlay").show();
    $("#Hist_M_IVFHistory").css("display", "flex");

    // 1. Immediately reset scroll position to the very top
    $("#Hist_C_IVFHistory").scrollTop(0);

    // 2. Immediately reset active tab to Female Partner
    $(".ivf-tab-btn").removeClass("active");
    $(".ivf-tab-btn[href='#secIVF_Female']").addClass("active");

    // 3. Bind datepickers and initialize ScrollSpy after modal is visible
    InitIVFDatepickers();
    setTimeout(function() {
        $("#Hist_C_IVFHistory").scrollTop(0);
        InitIVFScrollSpy();
    }, 60);
}

function CloseIVFHistoryModal() {
    $("#Hist_M_IVFHistory").hide();
    $("#popupOverlay").hide();

    // Reset scroll and tab so it is ready for next open
    $("#Hist_C_IVFHistory").scrollTop(0);
    $(".ivf-tab-btn").removeClass("active");
    $(".ivf-tab-btn[href='#secIVF_Female']").addClass("active");
}

// ScrollSpy & Smooth Swipe Navigation (Forward & Reverse Tracking)
var isManualScroll = false;

function InitIVFScrollSpy() {
    var $container = $("#Hist_C_IVFHistory");
    var containerElem = document.getElementById("Hist_C_IVFHistory");

    // 1. Click Tab: Smoothly swipes/scrolls to the section
    $(document).off("click.ivfNav", ".ivf-tab-btn").on("click.ivfNav", ".ivf-tab-btn", function(e) {
        e.preventDefault();
        var targetId = $(this).attr("href");
        var targetElem = $(targetId);

        if (targetElem.length && $container.length) {
            isManualScroll = true;
            $(".ivf-tab-btn").removeClass("active");
            $(this).addClass("active");

            var scrollPos = targetElem.offset().top - $container.offset().top + $container.scrollTop() - 15;
            $container.stop().animate({ scrollTop: scrollPos }, 380, function() {
                setTimeout(function() {
                    isManualScroll = false;
                }, 50);
            });
        }
    });

    // 2. Scroll Event: Accurately tracks forward and reverse
    $container.off("scroll.ivfScrollSpy").on("scroll.ivfScrollSpy", function() {
        if (isManualScroll) return;
        if (!$("#Hist_M_IVFHistory").is(":visible")) return;

        var scrollTop = $container.scrollTop();

        // If at the very top (first 60px), ALWAYS highlight Female Partner
        if (scrollTop <= 60) {
            $(".ivf-tab-btn").removeClass("active");
            $(".ivf-tab-btn[href='#secIVF_Female']").addClass("active");
            return;
        }

        var activeId = "secIVF_Female";

        // Check if user reached the very bottom of the popup body
        if (containerElem && (containerElem.scrollTop + containerElem.clientHeight >= containerElem.scrollHeight - 30)) {
            activeId = "secIVF_Diagnosis";
        } else {
            // Find the furthest section header that has entered the viewport (works forward AND reverse)
            var checkPoint = scrollTop + 120;
            $(".ivf-scroll-section").each(function() {
                var top = $(this).offset().top - $container.offset().top + scrollTop;
                if (checkPoint >= top) {
                    activeId = $(this).attr("id");
                }
            });
        }

        if (activeId) {
            $(".ivf-tab-btn").removeClass("active");
            $(".ivf-tab-btn[href='#" + activeId + "']").addClass("active");
        }
    });
    }




// 1. Initialize jQuery UI Datepickers with Working "Today" and "Done"
function InitIVFDatepickers() {
    if ($.fn.datepicker) {
        $(".ivf-datepicker").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            changeYear: true,
            yearRange: "c-100:c+10",
            dateFormat: "dd/mm/yy",
            maxDate: new Date(),
            beforeShow: function(input, inst) {
                // Enable the Today button as soon as the popup opens
                setTimeout(function() {
                    $("#ui-datepicker-div .ui-datepicker-current")
                        .removeAttr("disabled")
                        .removeClass("ui-state-disabled");
                }, 10);
            },
            onChangeMonthYear: function(year, month, inst) {
                // Keep Today button enabled when switching months/years
                setTimeout(function() {
                    $("#ui-datepicker-div .ui-datepicker-current")
                        .removeAttr("disabled")
                        .removeClass("ui-state-disabled");
                }, 10);
            }
        });

        // Make "Today" button click set today's date & close
        $(document).off("click.dpToday", ".ui-datepicker-current").on("click.dpToday", ".ui-datepicker-current", function(e) {
            e.preventDefault();
            e.stopPropagation();
            var activeInput = $.datepicker._lastInput;
            if (activeInput) {
                $(activeInput).datepicker("setDate", new Date());
                $(activeInput).trigger("change");
                $.datepicker._hideDatepicker();
                $(activeInput).blur();
            }
        });

        // Make "Done" button click reliably close the datepicker
        $(document).off("click.dpDone", ".ui-datepicker-close").on("click.dpDone", ".ui-datepicker-close", function(e) {
            e.preventDefault();
            e.stopPropagation();
            $.datepicker._hideDatepicker();
        });
    }
 }


// 2. Complete Field Validations
function InitIVFValidations() {

    // A. DATEPICKERS: Make read-only and block keyboard typing/pasting (selection only)
    $(".ivf-datepicker").attr("readonly", true).css({
        "cursor": "pointer",
        "background-color": "#ffffff"
    });

    $(document).on("keydown paste cut", ".ivf-datepicker", function(e) {
        e.preventDefault();
        return false;
    });

    // B. YEARS: Only 4 digits (0-9)
    var yearFields = "#txtIVF_LastLaparoscopy, #txtIVF_MedCancerYear, #txtMale_SmokingYearStopped, #txtCouple_FolicStarted, input[name='txtIVF_Year'], input[name='txtIVF_FertilityYear']";
    $(document).on("input", yearFields, function() {
        this.value = this.value.replace(/[^0-9]/g, '').slice(0, 4);
    });

    // C. INTEGERS ONLY: Days, Counts, Vitals, Scores
    var intFields = "#txtIVF_CycleLength, #txtIVF_FlowDuration, #txtIVF_PBACScore, #txtIVF_StoppedSinceMonths, #txtMale_UndescendedAge, #txtMale_SmokingCigarettes, #txtMale_SmokingDuration, #txtMale_AlcoholUnits, #txtFemaleExam_BPSystolic, #txtFemaleExam_BPDiastolic, #txtFemaleExam_Pulse, #txtFemaleExam_FerrimanScore, #txtFemaleGyn_UterusSize, #txtFemaleGyn_TVUS_AFCR, #txtFemaleGyn_TVUS_AFCL, #txtDiag_UnexplainedDurationYears, #txtDiag_AdvMaternalAge, #txtDiag_DOR_AFC, input[name='txtIVF_PregNo'], input[name='txtIVF_GA'], input[name='txtIVF_FertilityNoOfCycle']";
    $(document).on("input", intFields, function() {
        this.value = this.value.replace(/[^0-9]/g, '');
        // Auto-cap Ferriman score to 36
        if (this.id === "txtFemaleExam_FerrimanScore" && parseInt(this.value, 10) > 36) {
            this.value = 36;
        }
    });

    // Set maxlengths for Integer fields (3 digits for BP/Pulse, 2 digits for Days/Counts)
    $("#txtIVF_CycleLength, #txtIVF_PBACScore, #txtIVF_StoppedSinceMonths, #txtFemaleExam_BPSystolic, #txtFemaleExam_BPDiastolic, #txtFemaleExam_Pulse").attr("maxlength", "3");
    $("#txtIVF_FlowDuration, #txtMale_UndescendedAge, #txtMale_SmokingDuration, #txtFemaleExam_FerrimanScore, #txtFemaleGyn_UterusSize, #txtFemaleGyn_TVUS_AFCR, #txtFemaleGyn_TVUS_AFCL, #txtDiag_DOR_AFC, #txtDiag_AdvMaternalAge").attr("maxlength", "2");
    
    // D. DECIMALS ALLOWED: Only numbers and a single decimal point
    var decimalFields = "#txtIVF_TSH, #txtIVF_HbA1c, #txtIVF_ObesityBMI, #txtIVF_LowBodyWeightBMI, #txtMale_LifestyleBMI, #txtCouple_FemaleBMI, #txtCouple_MaleBMI, #txtFemaleExam_BMI, #txtMaleExam_BMI, #txtCouple_FemaleHt, #txtCouple_FemaleWt, #txtCouple_MaleHt, #txtCouple_MaleWt, #txtCouple_FolicDose, #txtCouple_VitDLevel, #txtFemaleExam_Waist, #txtFemaleExam_WaistHipRatio, #txtFemaleGyn_RAdnexa_MassCm, #txtFemaleGyn_LAdnexa_MassCm, #txtFemaleGyn_TVUS_UterusW, #txtFemaleGyn_TVUS_UterusH, #txtFemaleGyn_TVUS_Endo, #txtMaleExam_RTestis_Vol, #txtMaleExam_LTestis_Vol, #txtDiag_DOR_AMH, #txtDiag_POI_FSH, #txtDiag_POI_AMH, input[name='txtIVF_BirthWt'], input[id^='txtSemen_'][id$='_Result']";
    $(document).on("input", decimalFields, function() {
        this.value = this.value.replace(/[^0-9.]/g, '');
        if ((this.value.match(/\./g) || []).length > 1) {
            this.value = this.value.substring(0, this.value.lastIndexOf("."));
        }
    });

    // Set maxlengths for Decimals (e.g. 24.5, 165.2)
    $(decimalFields).attr("maxlength", "6");

    // E. TEXT MAX LENGTH LIMITS (Prevents pasting huge overflowing texts)
    $("#txtIVF_CurrentMedications").attr("maxlength", "250");
    $("#txtIVF_DrugAllergies").attr("maxlength", "200");
    $("#txtDiag_AdditionalNotes").attr("maxlength", "500");

    $("#txtIVF_FreezingCentre, #txtIVF_HysteroscopyFinding, #txtIVF_EctopicSite, #txtMale_PregnanciesDetails, #txtMale_DrugsSpecify, #txtFam_Male_SingleGeneSpecify, #txtMaleExam_ScrotalUSS_Findings").attr("maxlength", "100");
    $("input[name='txtIVF_Complications'], input[name='txtIVF_FertilityCentre'], input[name='txtIVF_FertilityOutcome']").attr("maxlength", "100");

    $("#txtIVF_CancerType, #txtIVF_CancerTreatment, #txtIVF_ThyroidTreatment, #txtIVF_OnSSRI, #txtMale_OrchitisCause, #txtMale_AlcoholType, input[name='txtIVF_Outcome'], input[name='txtIVF_ModeOfDelivery'], input[name='txtIVF_FertilityTreatment']").attr("maxlength", "50");

    $("#txtIVF_FibroidSize, #txtIVF_FibroidLocation, #txtIVF_CystSize, #txtIVF_CystSide, #txtIVF_COCP_Stopped, #txtIVF_Mirena_Remove").attr("maxlength", "30");
    $("#txtIVF_EndometriosisStage, #txtDiag_EndoStage, #txtMale_VaricoceleGrade, #txtDiag_DOR_Poseidon").attr("maxlength", "4");
    }



// 1. Add Row to Obstetric History Table (Blank inputs, no auto-numbers)
function AddObstetricRow() {
    var tbody = $("#tblIVF_Obstetric tbody");
    var rowHtml = '<tr>' +
        '<td style="text-align: center; vertical-align: middle;">' +
        '<i class="fa fa-trash text-danger" onclick="DeleteTableRow(this);" title="Delete" style="font-size: 16px; cursor: pointer;"></i>' +
        '</td>' +
        '<td><input type="text" name="txtIVF_PregNo" style="text-align: center;" /></td>' +
        '<td><input type="text" name="txtIVF_Year" style="text-align: center;" /></td>' +
        '<td><input type="text" name="txtIVF_GA" style="text-align: center;" /></td>' +
        '<td><input type="text" name="txtIVF_Type" style="text-align: center;" /></td>' +
        '<td><input type="text" name="txtIVF_Outcome" /></td>' +
        '<td><input type="text" name="txtIVF_ModeOfDelivery" /></td>' +
        '<td><input type="text" name="txtIVF_BirthWt" style="text-align: center;" /></td>' +
        '<td><input type="text" name="txtIVF_Complications" /></td>' +
        '</tr>';
    tbody.append(rowHtml);
}

// 2. Add Row to Fertility Treatments Table
function AddFertilityRow() {
    var tbody = $("#tblIVF_Fertility tbody");
    var rowHtml = '<tr>' +
        '<td style="text-align: center; vertical-align: middle;">' +
        '<i class="fa fa-trash text-danger" onclick="DeleteTableRow(this);" title="Delete" style="font-size: 16px; cursor: pointer;"></i>' +
        '</td>' +
        '<td><input type="text" name="txtIVF_FertilityTreatment" /></td>' +
        '<td><input type="text" name="txtIVF_FertilityYear" style="text-align: center;" /></td>' +
        '<td><input type="text" name="txtIVF_FertilityNoOfCycle" style="text-align: center;" /></td>' +
        '<td><input type="text" name="txtIVF_FertilityCentre" /></td>' +
        '<td><input type="text" name="txtIVF_FertilityOutcome" /></td>' +
        '</tr>';
    tbody.append(rowHtml);
}

// 3. Delete Row Function (Deletes any row immediately)
function DeleteTableRow(btn) {
    $(btn).closest("tr").remove();
    }
    


</script>
