<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<style>
    /* ================= COMMON UTILITY CLASSES ================= */
    .h-font-size {
        font-size: 18px;
    }

    .h-icon-size {
        width: 28px;
        height: 28px;
        border: 1px solid transparent;
        border-radius: 4px;
        padding: 1px;
        transition: all 0.3s ease;
        object-fit: contain;
    }

        .h-icon-size:hover {
            /*border-color: #007bff;*/
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.2);
            transform: translateY(-5px);
            /*background-color: #fff;*/
        }

        .h-icon-size.disabled {
            pointer-events: none;
            cursor: auto;
        }

    .h-icon-DoctLogo {
        width: 36px;
        /* height: 36px;*/
        border: 1px solid transparent;
        border-radius: 4px;
        padding: 1px;
        transition: all 0.3s ease;
        object-fit: contain;
    }
    /* ================= HEADER LAYOUT ================= */
    .header_container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 12px;
        background: #ffffff;
        border-bottom: 1px solid #e5e5e5;
        gap: 10px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        flex-wrap: nowrap;
        align-items: flex-start;
    }

    .header_left {
        display: flex;
        align-items: center;
        gap: 20px;
        flex-wrap: wrap;
    }

    /* ================= LOCATION ================= */
    .header_location {
        display: flex;
        align-items: center;
        /* gap: 12px;*/
        font-weight: 600;
        color: #ff7a00;
        cursor: pointer;
        font-size: 14px;
    }

        .header_location.disabled {
            pointer-events: none;
            cursor: auto;
        }

    .header_doctor {
        font-size: 22px;
        font-weight: 600;
        color: #000;
    }

    /* ================= SPECIALITY DROPDOWN ================= */
    .header_speciality_box {
        position: relative;
    }

    .header_speciality_selected {
        display: flex;
        align-items: center;
        justify-content: space-between;
        min-width: 150px;
        padding: 6px 12px;
        border: 1px solid #4e73df;
        border-radius: 6px;
        background: #eef3ff;
        color: #4e73df;
        cursor: pointer;
        font-size: 13px;
    }

        .header_speciality_selected.disabled {
            pointer-events: none;
            cursor: auto;
        }

    .header_speciality_dropdown {
        display: none;
        position: absolute;
        top: 36px;
        left: 0;
        width: 100%;
        background: #e8f0ff;
        border: 1px solid #4e73df;
        border-radius: 6px;
        z-index: 1000;
        max-height: 90vh;
        overflow: auto;
    }

    .header_speciality_item {
        padding: 8px 12px;
        cursor: pointer;
        font-size: 14px;
    }

        .header_speciality_item:hover {
            background: #dbe7ff;
        }

    .header_speciality_selected.single-clinic::after {
        content: ''; /* hides arrow if you use ::after for arrow */
    }
    /* ================= OPD DROPDOWN ================= */
    .header_OpdIpd_box {
        position: relative;
    }

    .header_OpdIpd_selected {
        display: flex;
        align-items: center;
        justify-content: space-between;
        min-width: 80px;
        padding: 6px 12px;
        border: 1px solid #060606;
        border-radius: 6px;
        background: #ffffff;
        color: #000000;
        cursor: pointer;
        font-size: 14px;
    }

        .header_OpdIpd_selected.disabled {
            pointer-events: none;
            cursor: auto;
        }

    .header_OpdIpd_dropdown {
        display: none;
        position: absolute;
        top: 36px;
        left: 0;
        width: 100%;
        background: white;
        border: 1px solid #080808;
        border-radius: 6px;
        z-index: 1000;
    }

    .header_OpdIpd_item {
        padding: 8px 12px;
        cursor: pointer;
        font-size: 14px;
    }

        .header_OpdIpd_item:hover {
            background: #dbe7ff;
        }
    /* ================= RIGHT ICONS ================= */
    .header_right {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .header_icon_wrapper,
    .header_settings {
        width: 36px;
        height: 36px;
        border: 1px solid #dcdcdc;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        background: #fff;
        transition: all 0.3s ease;
        position: relative; /* Added for notification positioning */
    }

        .header_icon_wrapper:hover,
        .header_settings:hover {
            background: #f8f9fa;
        }

    /* ================= SETTINGS DROPDOWN (FIXED) ================= */
    .header_settings {
        position: relative;
    }

        .header_settings::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 10px;
            background: transparent;
            display: block;
        }

    .header_settings_dropdown {
        display: none;
        position: absolute;
        right: 0;
        top: 40px;
        width: 215px;
        background: #fff;
        border: 1px solid #ddd;
        box-shadow: 0 4px 10px rgba(0,0,0,0.12);
        z-index: 1000;
    }

    .header_settings:hover .header_settings_dropdown {
        display: block;
    }

    .header_settings_item {
        padding: 10px;
        cursor: pointer;
        border-bottom: 1px solid #f0f0f0;
    }

        .header_settings_item:hover {
            background: #f2f2f2;
        }

    /* ================= POPUP STYLES ================= */
    .MaxMinpopup {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 600px; /* Increased width for grid */
        background: #fff;
        border: 1px solid #ccc;
        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        z-index: 9999;
        border-radius: 5px;
        overflow: hidden;
        display: flex;
        flex-direction: column;
    }

    .MaxMinpopup-header {
        background: #343a40;
        color: white;
        padding: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        cursor: move;
    }

        .MaxMinpopup-header h5 {
            margin: 0;
            font-size: 15px;
            font-weight: 600;
        }

    .popup-minimized {
        top: auto !important;
        bottom: 0 !important;
        left: 20px !important;
        transform: none !important;
        width: 250px !important;
        border-radius: 5px 5px 0 0;
    }

        .popup-minimized .MaxMinpopup-body {
            display: none !important;
        }

    /*    .MaxMinpopup-body {
        height: 100%;
    }
*/
    /* ================= LOCATION MODAL ================= */
    .header_modal {
        display: none; /* Toggle to 'flex' using JS */
        position: fixed;
        inset: 0; /* Modern shorthand for top/left/right/bottom: 0 */
        background: rgba(0, 0, 0, 0.6); /* Slightly darker for contrast */
        z-index: 2000;
        justify-content: center;
        align-items: center;
        backdrop-filter: blur(5px); /* Blurs the background content */
        animation: fadeIn 0.2s ease-out;
    }

    /* 2. Main Card Styling */
    .header_modal_content {
        background: #fff;
        padding: 30px;
        width: 350px; /* Slightly wider for better spacing */
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2); /* Deep shadow */
        animation: slideUp 0.3s ease-out;
        font-family: 'Segoe UI', sans-serif;
    }

        .header_modal_content h4 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 20px;
            color: #333;
            font-weight: 600;
        }

        /* 3. Modern Select Box */
        .header_modal_content select {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background-color: #f9fafb;
            font-size: 15px;
            color: #374151;
            outline: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

            .header_modal_content select:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.15); /* Blue glow ring */
                background-color: #fff;
            }

        /* 4. Primary Action Button */
        .header_modal_content button {
            width: 100%; /* Full width looks more modern on modals */
            padding: 10px 20px;
            background: linear-gradient(145deg, #0d6efd, #0b5ed7); /* Subtle gradient */
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            transition: transform 0.1s, box-shadow 0.2s;
        }

            .header_modal_content button:hover {
                background: linear-gradient(145deg, #0b5ed7, #0a58ca);
                box-shadow: 0 4px 12px rgba(13, 110, 253, 0.3);
                transform: translateY(-1px);
            }

            .header_modal_content button:active {
                transform: translateY(0);
            }

    /* 5. Location Text & Arrow (Header items) */
    .header_location_text {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-weight: 500;
        color: #444;
    }

    .location-arrow {
        font-size: 12px;
        cursor: pointer;
        color: #0d6efd;
        transition: transform 0.2s;
        background: rgba(13, 110, 253, 0.1);
        width: 20px;
        height: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
    }

        .location-arrow:hover {
            background: rgba(13, 110, 253, 0.2);
            transform: rotate(180deg); /* Visual cue that it opens something */
        }

    /* Animations */
    @keyframes fadeIn {
        from {
            opacity: 0;
        }

        to {
            opacity: 1;
        }
    }

    @keyframes slideUp {
        from {
            transform: translateY(20px);
            opacity: 0;
        }

        to {
            transform: translateY(0);
            opacity: 1;
        }
    }
    /* ==========================================================
       UNIQUE: "ADD Plus img NEW MASTER" MODAL STYLES (2ND IMAGE POPUP)
       ========================================================== */
    .adm-modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        /* FIX: Increased Z-Index to be higher than MaxMinPopup (which is 9999) */
        z-index: 99999 !important;
        justify-content: center;
        align-items: center;
    }

    .adm-modal-box {
        background: #fff;
        width: 450px;
        border-radius: 8px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        overflow: hidden;
        animation: admSlideDown 0.3s ease;
    }

    /* ================= SIGNATORY STYLES ================= */
    .signatory-container {
        width: 100%;
        padding: 12px;
        box-sizing: border-box;
        background: #ededed;
    }

    .signatory-card {
        background: #f8fbff;
        border-radius: 8px;
        padding: 14px;
        margin-bottom: 18px;
        border: 1px solid #dbe5f1;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    }

    .signatory-title {
        font-size: 15px;
        font-weight: 600;
        color: #004c8c;
        margin-bottom: 8px;
    }

    .signatory-textarea {
        width: 100%;
        min-height: 110px;
        padding: 10px;
        border-radius: 6px;
        border: 1px solid #c7d6ea;
        font-size: 14px;
        resize: vertical;
        box-sizing: border-box;
    }

    .signature-row {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
        margin-top: 10px;
        align-items: center;
    }

    .signature-preview {
        background: #fff;
        border: 1px dashed #b7c7dc;
        border-radius: 6px;
        padding: 10px;
        min-width: 180px;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 60px;
    }

    .signature-upload {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
        align-items: center;
    }

    .btn-remove-file {
        background: #dc3545;
        color: #fff;
        border: none;
        padding: 6px 14px;
        border-radius: 5px;
        cursor: pointer;
    }

    .signatory-save-btn {
        background: #2196f3;
        color: #fff;
        border: none;
        padding: 10px 26px;
        border-radius: 25px;
        font-size: 14px;
        cursor: pointer;
        box-shadow: 0 3px 8px rgba(33,150,243,0.3);
        float: right;
        margin-top: 10px;
        margin-bottom: 20px;
    }
    /* ================= MASTER SETUP UNIQUE STYLES ================= */
    .mst-wrapper {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #333;
        padding-bottom: 20px;
    }

    /* --- Top Filter Bar --- */
    .mst-top-bar {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        padding: 15px;
        background: #eef3ff;
        border-bottom: 1px solid #d1d9e6;
        align-items: center;
    }

    .mst-form-group {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .mst-label {
        font-weight: 600;
        font-size: 14px;
    }

    .mst-input {
        padding: 5px 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    .mst-input-sm {
        width: 60px;
    }

    /* Gender Toggle Buttons */
    .mst-gender-group {
        display: flex;
        border: 1px solid #007bff;
        border-radius: 4px;
        overflow: hidden;
    }

    .mst-gender-btn {
        border: none;
        padding: 5px 15px;
        background: #fff;
        color: #007bff;
        cursor: pointer;
        font-size: 13px;
        transition: 0.2s;
    }

        .mst-gender-btn.active {
            background: #007bff;
            color: #fff;
        }

        .mst-gender-btn:not(:last-child) {
            border-right: 1px solid #007bff;
        }

    /* --- Accordion Sections --- */
    .mst-section {
        border: 1px solid #dcdcdc;
        margin: 10px 15px;
        border-radius: 5px;
        overflow: hidden;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }

    .mst-header {
        background: #004b87; /* Blue Header */
        color: white;
        padding: 10px 15px;
        cursor: pointer;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-weight: 600;
    }

        .mst-header:hover {
            background: #0056b3;
        }

    .mst-header-tools {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .mst-icon-btn {
        cursor: pointer;
        color: white;
        font-weight: bold;
        font-size: 18px;
    }

    .mst-body {
        background: #fff;
        padding: 10px;
        display: none; /* Collapsed by default */
    }
    /* Show body when active */
    .mst-section.active .mst-body {
        display: block;
    }

    /* --- Search & List --- */
    .mst-search-box {
        position: relative;
        margin-bottom: 10px;
    }

    .mst-search-input {
        width: 100%;
        padding: 8px 30px 8px 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .mst-clear-link {
        color: #007bff;
        font-size: 12px;
        cursor: pointer;
        display: block;
        margin-top: 5px;
        text-decoration: underline;
        text-align: right;
    }

    .mst-list-container {
        max-height: 200px;
        overflow-y: auto;
        border: 1px solid #eee;
        padding: 5px;
        border-radius: 4px;
    }

    .mst-list-item {
        padding: 6px 8px;
        border-bottom: 1px solid #f5f5f5;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: background 0.2s;
    }
    /* Add this to your existing styles */
    .mst-save-btn {
        background-color: #28a745; /* Green */
        color: white;
        border: none;
        padding: 8px 20px;
        border-radius: 4px;
        font-weight: 600;
        cursor: pointer;
        margin-left: auto; /* Pushes button to the far right */
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        transition: background 0.2s;
    }

        .mst-save-btn:hover {
            background-color: #218838;
        }

    .mst-New-btn {
        background-color: #a42f2f;
        color: white;
        border: none;
        padding: 8px 20px;
        border-radius: 4px;
        font-weight: 600;
        cursor: pointer;
        margin-left: auto;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        transition: background 0.2s;
    }

        .mst-New-btn:hover {
            background-color: #680c0c;
        }

    .mst-List-btn {
        background-color: #00a1b6;
        color: white;
        border: none;
        padding: 8px 20px;
        border-radius: 4px;
        font-weight: 600;
        cursor: pointer;
        margin-left: auto;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        transition: background 0.2s;
    }

        .mst-List-btn:hover {
            background-color: #036c7a;
        }

    .mst-list-item:hover {
        background: #f9f9f9;
    }

    .mst-checkbox {
        cursor: pointer;
        width: 16px;
        height: 16px;
        accent-color: #007bff;
    }

    .mst-item-text {
        font-size: 14px;
    }

    /* Highlight checked items */
    .mst-list-item.checked-item {
        background-color: #e3f2fd;
        font-weight: 500;
    }

    /* ================= RX TABULATOR UNIQUE STYLES ================= */
    #mst-rx-grid {
        margin-top: 15px;
        border: 1px solid #d1d9e6;
        border-radius: 4px;
        background-color: #fff;
    }

        /* Header Styling */
        #mst-rx-grid .tabulator-header {
            background-color: #004b87; /* Primary Blue */
            color: white;
            border-bottom: 2px solid #0056b3;
        }

        #mst-rx-grid .tabulator-col {
            background-color: #004b87;
            border-right: 1px solid #0069d9;
        }

        #mst-rx-grid .tabulator-col-content {
            padding: 8px;
        }

        /*  /////*/

        /* 1. Allow Header Text to Wrap */
        #mst-rx-grid .tabulator-col-title {
            white-space: normal !important; /* Allows text to wrap */
            text-overflow: clip !important; /* Removes the "..." dots */
            overflow: visible !important;
            text-align: center; /* Center align looks better when wrapped */
            line-height: 1.2; /* Adjust line height for stacked text */
            height: 100%; /* Ensure it fills the header height */
            display: flex; /* Center vertically */
            align-items: center;
            justify-content: center;
        }

        /* 2. Allow Header to grow in height automatically */
        #mst-rx-grid .tabulator-header .tabulator-col-content {
            height: 100% !important;
            padding: 8px 4px; /* Slightly tighter padding */
        }

        /* 3. Allow Data Cells to Wrap (Optional: if you want row data to wrap too) */
        #mst-rx-grid .tabulator-cell {
            white-space: normal !important;
            word-break: break-word; /* Breaks long words if needed */
            line-height: 1.4;
        }
        /*///*/

        /* Row & Cell Styling */
        #mst-rx-grid .tabulator-row {
            border-bottom: 1px solid #eee;
        }

            #mst-rx-grid .tabulator-row:hover {
                background-color: #f1f8ff;
            }


    /* --- THE HEADER PLUS BUTTON --- */

    .mst-col-plus {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background-color: #536ebd; /* Green */
        color: white;
        width: 20px;
        height: 20px;
        border-radius: 5px; /* 👈 key change */
        margin-left: 8px;
        margin-right: 6px;
        cursor: pointer;
        font-size: 14px;
        font-weight: bold;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        transition: transform 0.2s ease, background 0.2s ease;
    }


        .mst-col-plus:hover {
            transform: scale(1.2);
            background-color: #4e73df;
        }


    /* ================= Mater Setup STYLES End ================= */

    /* ================= STATUS LISTS (Plan Completion & Scheme Approval) ================= */
    .stat-wrapper {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f9f9f9;
    }

    /* Blue Title Bar (Top) */
    .stat-title-bar {
        background: #8CA9FF; /* Matches screenshot blue */
        color: white;
        padding: 10px 15px;
        border-radius: 5px 5px 0 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-weight: 600;
        font-size: 16px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .stat-title-icons {
        display: flex;
        gap: 10px;
    }

    .stat-icon-btn {
        cursor: pointer;
        width: 24px;
        height: 24px;
        background: rgba(255,255,255,0.2);
        border-radius: 4px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: 0.2s;
    }

        .stat-icon-btn:hover {
            background: rgba(255,255,255,0.4);
        }

    /* Filter Row */
    .stat-filter-row {
        background: #fff;
        padding: 15px;
        border: 1px solid #ddd;
        border-top: none;
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        align-items: center;
        margin-bottom: 15px;
    }

    .stat-form-group {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .stat-label {
        font-weight: 600;
        font-size: 14px;
        color: #333;
    }

    .stat-input {
        padding: 6px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 13px;
        outline: none;
    }

        .stat-input:focus {
            border-color: #5b73e8;
        }

    /* Sub Header (Details Bar) */
    .stat-sub-header {
        background: #6a82fb; /* Slightly lighter blue for the grid header bar */
        color: white;
        padding: 8px;
        text-align: center;
        font-weight: bold;
        font-size: 14px;
        border-radius: 4px 4px 0 0;
    }
    /* ================= STATUS LISTS (Plan Completion & Scheme Approval End ) ================= */

    /* ================= SIGNATORY STYLES ================= */
    .signatory-container {
        width: 100%;
        padding: 12px;
        box-sizing: border-box;
        background: #ededed;
    }

    .signatory-card {
        background: #f8fbff;
        border-radius: 8px;
        padding: 14px;
        margin-bottom: 18px;
        border: 1px solid #dbe5f1;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    }

    .signatory-textarea {
        width: 100%;
        min-height: 110px;
        padding: 10px;
        border-radius: 6px;
        border: 1px solid #c7d6ea;
        font-size: 14px;
        resize: vertical;
        box-sizing: border-box;
    }

    .signature-preview {
        background: #fff;
        border: 1px dashed #b7c7dc;
        border-radius: 6px;
        padding: 10px;
        min-width: 180px;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 60px;
    }

    .btn-remove-file {
        background: #dc3545;
        color: #fff;
        border: none;
        padding: 6px 14px;
        border-radius: 5px;
        cursor: pointer;
    }

    .signatory-save-btn {
        background: #2196f3;
        color: #fff;
        border: none;
        padding: 10px 26px;
        border-radius: 25px;
        font-size: 14px;
        cursor: pointer;
        box-shadow: 0 3px 8px rgba(33,150,243,0.3);
        float: right;
        margin-top: 10px;
        margin-bottom: 20px;
    }
    /* Fixed footer save button */
    .signatory-footer-fixed {
        position: sticky;
        bottom: 50px;
        text-align: right;
        z-index: 5;
    }

    /* Signature preview size restriction */
    .signatory-preview-img {
        max-width: 300px;
        max-height: 120px;
        object-fit: contain;
    }

    /* Error message */
    .signatory-error {
        color: #dc3545;
        font-size: 12px;
        margin-top: 4px;
    }

    .header_container,
    .ntf-popup,
    .header_settings_dropdown {
        z-index: 40000 !important;
    }


    /* ==========================================================
       UNIQUE: NOTIFICATION POPUP STYLES (BELL ICON) 
       ========================================================== */
    .ntf-popup {
        display: none;
        position: absolute;
        top: 45px;
        right: -50px;
        width: min(700px, 95vw); /* 🔥 KEY FIX */
        background: #fff;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.15);
        z-index: 40000;
        overflow: hidden;
    }

    .ntf-header {
        background: #f8f9fa;
        padding: 12px 16px;
        font-weight: 600;
        border-bottom: 1px solid #eee;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .ntf-close {
        font-size: 18px;
        cursor: pointer;
        color: #888;
    }

    .ntf-body {
        max-height: 50vh;
        overflow-y: auto;
    }

    .ntf-item {
        padding: 12px 16px;
        border-bottom: 1px solid #f5f5f5;
        display: flex;
        gap: 10px;
        cursor: pointer;
        transition: background 0.2s;
        align-items: center;
    }

    .ntf-icon {
        color: #007bff;
        font-size: 16px;
        margin-bottom: 17px;
    }

    .ntf-content {
        width: 100%;
    }

        .ntf-content h6 {
            margin: 0 0 4px 0;
            font-size: 14px;
            color: #333;
        }

        .ntf-content p {
            margin: 0;
            font-size: 12px;
            color: #000000;
        }

    .ntf-content-footer {
        font-size: 11px;
        color: #000000;
        text-align: right;
        font-style: italic;
        font-weight: bold;
    }
    /* =========================================================
   COMMON LEGEND & FOOTER STYLES (Tumor Board & Surgical)
   Prefix: .leg-
   ========================================================= */

    /* Main Container (Wrapper) */
    .leg-wrapper {
        display: flex;
        justify-content: space-between; /* Pushes content to edges */
        align-items: center;
        flex-wrap: wrap; /* Key for responsiveness */
        gap: 15px;
        padding: 12px 10px;
        margin-top: 10px;
        background-color: #fff;
        border-top: 1px solid #e0e0e0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 13px;
    }

    /* Sub-Groups (Used to cluster items together) */
    .leg-group {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }

    /* Individual Item (Dot + Text) */
    .leg-item {
        display: flex;
        align-items: center;
        gap: 6px;
        white-space: nowrap; /* Keeps dot and text together */
        color: #444;
        font-weight: 500;
        cursor: default;
    }

    /* The Circular Dot */
    .leg-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        display: inline-block;
        flex-shrink: 0;
        box-shadow: 0 1px 2px rgba(0,0,0,0.15);
    }

    /* The Symbol Icon (for Doctor Leave) */
    .leg-icon-symbol {
        font-size: 16px;
        line-height: 1;
        display: inline-block;
        font-weight: bold;
    }

    /* Action Button (For Surgical Schedule) */
    .leg-btn-action {
        background-color: #0d6efd; /* Blue */
        color: white;
        border: none;
        padding: 6px 20px;
        border-radius: 4px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
        box-shadow: 0 2px 4px rgba(0,0,0,0.15);
    }

        .leg-btn-action:hover {
            background-color: #0b5ed7;
        }

    /* --- Color Utility Classes --- */
    .leg-bg-blue {
        background-color: #2364b5;
    }

    .leg-bg-orange {
        background-color: #f37b00;
    }

    .leg-bg-red {
        background-color: #dc3545;
    }

    .leg-bg-yellow {
        background-color: #ffc107;
    }

    .leg-bg-green {
        background-color: #28a745;
    }

    .leg-bg-cyan {
        background-color: #17a2b8;
    }

    .leg-col-purple {
        color: #6f42c1;
    }

    /* --- Mobile Responsiveness --- */
    @media only screen and (max-width: 650px) {
        .leg-wrapper {
            justify-content: center; /* Center everything on mobile */
            flex-direction: column-reverse; /* For Surgical: puts button at bottom */
        }

        .leg-group {
            justify-content: center;
        }

        /* Make button full width on mobile */
        .leg-btn-action {
            width: 100%;
            min-width: 200px;
        }
    }

    /* =====================calannder color code css=====================================*/

    /* ==========================================================
       UNIQUE: "ADD NEW MASTER" MODAL STYLES (2ND IMAGE POPUP)
       ========================================================== */
    .adm-modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        z-index: 10000; /* Higher than MaxMinPopup */
        justify-content: center;
        align-items: center;
    }

    .adm-modal-box {
        background: #fff;
        width: 450px;
        border-radius: 8px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        overflow: hidden;
        animation: admSlideDown 0.3s ease;
    }

    @keyframes admSlideDown {
        from {
            transform: translateY(-20px);
            opacity: 0;
        }

        to {
            transform: translateY(0);
            opacity: 1;
        }
    }

    .adm-header {
        background: #007bff;
        color: #fff;
        padding: 15px;
        font-size: 16px;
        font-weight: 600;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .adm-close-btn {
        background: none;
        border: none;
        color: #fff;
        font-size: 20px;
        cursor: pointer;
    }

        .adm-close-btn:hover {
            transform: scale(1.5);
        }

    .adm-body {
        padding: 20px;
        max-height: calc(100vh - 120px);
        overflow-y: auto;
    }

    .adm-form-group {
        margin-bottom: 15px;
    }

    .adm-label {
        display: block;
        margin-bottom: 6px;
        font-weight: 500;
        font-size: 14px;
        color: #444;
    }

    .adm-input {
        width: 100%;
        padding: 8px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .adm-footer {
        padding: 15px;
        background: #f8f9fa;
        text-align: right;
        border-top: 1px solid #eee;
    }

    .adm-btn-cancel {
        background: #6c757d;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        margin-right: 10px;
    }

    .adm-btn-save {
        background: #28a745;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
    }

        .adm-btn-save:hover {
            color: black;
        }

    @media (min-width: 576px) {
        .header_container {
            flex-direction: row;
        }

        .header_right {
            width: auto;
        }
    }

    .ntf-content-NoData {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 10px;
    }

    .ntf-content-NoData-h2 {
        font-size: medium;
        color: grey;
        font-weight: bold;
    }

    #MasterSettingTable .tabulator-row .tabulator-cell {
        border: 1px solid #aaa;
    }

    #MasterSettingTable .CancelClass {
        color: rgb(220, 9, 9) !important;
        background-image: none;
        font-weight: bold !important;
    }

    #MasterSettingTable .MasterSettingGridIcon {
        cursor: pointer;
    }

        #MasterSettingTable .MasterSettingGridIcon:hover {
            transform: scale(1.5);
        }

    .opdn {
        background-color: #ffcece;
    }

    .ipdn {
        background-color: #9fc4e985;
    }

    .tabulator-row.tabulator-row-even {
        background-color: #ffffff;
    }
</style>

<%-- Load --%>
<script type="text/javascript">
    <% var RightsUnitSamp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
    var RightUnitList = JSON.parse(JSON.stringify(<%:Html.Raw(RightsUnitSamp.Serialize(ViewBag.RightUnitList))%>));
    var curFormURL = ("" + '<%= Request.Url.AbsolutePath %>').toString().toUpperCase().trim();
    var loadedFormName = curFormURL.substr(curFormURL.lastIndexOf("/") + 1);
    var CalenderActionType = "N";
    var SendEventToSave = [];
    var PACClinicCode = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PACClinicCD")%>';
    $(document).ready(function (e) { 
        if (loadedFormName.toUpperCase() != "SINGLEPAGEMENULIST") {
            $("#RightHeaderMenu").removeClass("d-none");
        }
        if (loadedFormName.toUpperCase() != "SINGLEPAGEMENULIST") {
            document.getElementById("QuickredirectPatList").style.display = "block";
        }
        else {
            document.getElementById("QuickredirectPatList").style.display = "none";
        }

        if (loadedFormName.toUpperCase() != "SINGLEPAGEMENULIST" && sessionStorage.getItem("MODULE_FLAG") != "IPD") {
            document.getElementById("ClinicSelectionDiv").style.display = "block";
        }
        else {
            document.getElementById("ClinicSelectionDiv").style.display = "none";
        }

        $(document).click(function () {
            $(".header_speciality_dropdown").hide();
            $(".header_OpdIpd_dropdown").hide();
            $("#ntfPopup").hide();
        });
        if (gDoctId == "") {
            var YFunc = "Signout()";
            openPopup("Information", "Session Timeout. Please Login Again", YFunc, "");
        }
        if (loadedFormName.toUpperCase() != "SINGLEPAGEMENULIST") {
            $(".header_location").addClass("disabled");
            $(".header_location_text").addClass("disabled");
        }
        else {
            $("#header_location_save").click(function () {
                SetHospital();
            });
            $(".header_location").click(function () {
                BindUnitLst();
                $("#cmbHospUnit").val(UnitCd);
                $("#header_location_modal").css("display", "flex");
            });
        }
        if (UnitCd == "") {
            $(".header_location").trigger('click');
        }
        if (loadedFormName.toUpperCase() != "SINGLEPAGEMENULIST" && loadedFormName.toUpperCase() != "WAITINGLISTOPD" && loadedFormName.toUpperCase() != "WAITINGLISTPAC") {
            $(".header_speciality_selected").addClass("disabled");
        }
        else {
            sessionStorage.setItem("ConsultDoctorName", "");
            sessionStorage.setItem("ConsultDoctorCode", "");
            $(".header_speciality_item").click(function () {
                var text = $(this).text();
                var value = $(this).data("value");
                var ClincType = $(this).data("clinictype");
                SetClinic(value, text, ClincType);
            });
            if (loadedFormName.toUpperCase() != "SINGLEPAGEMENULIST") {
                if (gClinicCode == "") {
                    GetClinicsList("Y");
                    var FirstClinic = $(".header_speciality_dropdown .header_speciality_item").first();
                    if (FirstClinic.length) {
                        FirstClinic.trigger("click");
                    }
                    else {
                        ToastMsg("No Clinic is Allocated. Please Contact Adminstration", "warning");
                    }
                }
                else {
                    GetClinicsList("N");
                }
            }
        }
        BindOpdIpd();

        $(".header_OpdIpd_selected").click(function (e) {
            e.stopPropagation();
            $(".header_OpdIpd_dropdown").toggle();
        });
        $(".header_OpdIpd_item").click(function () {
            var text = $(this).text();
            var value = $(this).data("value");
            onModuleClickHeader(value);
        });

        var value = sessionStorage.getItem("MODULE_FLAG") == "PAC" ? "OPD" : sessionStorage.getItem("MODULE_FLAG");

        if (value) {
            var $item = $('.header_OpdIpd_item[data-value="' + value + '"]');
            if ($item.length > 0) {
                $('.header_OpdIpd_selected').html($item.text() + ' <span class="clinic-arrow" style="font-size:12px;">▼</span>');
                $('.header_OpdIpd_selected').attr('data-value', value);
            }
        }
        $("#btnBellIcon").click(function (e) {
            e.stopPropagation();
            GetReferalDoctList();
            $("#ntfPopup").toggle();
        });
        $("#closeNtf").click(function (e) {
            e.stopPropagation();
            $("#ntfPopup").hide();
        });
        $(".ntf-popup").click(function (e) {
            e.stopPropagation();
        });
        GetReferalDoctList();
        var doctorName = sessionStorage.getItem("ConsultDoctorName");
        var div = document.getElementById("LblConsultDoctorDiv");

        if ('<%: Session["RMOYN"] ?? "" %>' == "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y") {

            if (doctorName && doctorName.trim() != "") {
                document.getElementById("LblConsultDoctor").innerText = "Dr." + doctorName;
                div.style.display = "block";
            } else {
                div.style.display = "none";
            }
        }
        //added by Nithin
        $("#OtbookingRedirect").click(function() {
           openIframe();
         
        });
    });  //end readyy
    function centerPopup(id) {
        $("#" + id).css({
            top: "50%",
            left: "50%",
            transform: "translate(-50%, -50%)"
        });
    }
    function SignoutConfirm() {
        openPopupDynamic("Confirmation", "Do You Want to Continue ?", [
            { text: "Logout", class: "btn btn-yes", action: "Signout()" },
            { text: "Cancel", class: "btn btn-no", action: "closePopup()" }
        ]);

    }


    function BindUnitLst() {
        $("#cmbHospUnit").empty();
        var Option = "<option value='{OPTVALUE}'>{OPTEXT}</option>";
        var DefRplOption = Option.replace("{OPTVALUE}", "").replace("{OPTEXT}", "---Select---");
        $("#cmbHospUnit").append(DefRplOption);
        $.grep(RightUnitList, function (a) {
            var RplOption = Option.replace("{OPTVALUE}", a.Value).replace("{OPTEXT}", a.Text);
            $("#cmbHospUnit").append(RplOption);
        });
    }

    function SetHospital() {
        if ($("#cmbHospUnit").val() == "") {
            $("#cmbHospUnit").css("border-color", "red");
            $("#cmbHospUnit").focus();
            return false;
        }
        var datatosend = {
            HospUnit: $("#cmbHospUnit").val()
        }
        //startLoading("Loading");
        $.ajax({
            type: "POST",
            url: '../Account/ChangeUnitSel',
            data: datatosend,
            async: true,
            success: function (response) {
                if (response == "doctor") {
                    stopLoading();
                    window.location.reload();
                }
                else if (response == "staff") {
                    stopLoading();
                    window.location.reload();
                }
                else {
                    stopLoading();
                    ToastMsg(response, "warning");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading();
                ToastMsg(textStatus, "error");
            }
        });
    }

    function GetClinicsList(TiggerPageYN) {
        $.ajax({
            type: "POST",
            url: "../Account/GetDctrAllClinic",
            data: {},
            async: false,
            success: function (result) {
                var CList = [];
                if (result.length > 0) {
                    CList = result;
                }
                BindClinicCmb(CList, TiggerPageYN);
            },
            complete: function (jqXHR, status) {

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });
    }

    function BindClinicCmb(ClinicLst, TriggerFirstYN) {
        $(".header_speciality_dropdown").empty();
        var Option = "<div class='header_speciality_item h-font-size' data-ClinicType='{OPTTYPE}' data-value='{OPTVALUE}'>{OPTEXT}</div>";
        $.each(ClinicLst, function (i, a) {
            var RplOption = Option.replace("{OPTVALUE}", a.ClinicCode).replace("{OPTEXT}", a.ClinicName).replace("{OPTTYPE}", a.ClinicType);
            $(".header_speciality_dropdown").append(RplOption);
        });
        $(".header_speciality_item").click(function () {
            var text = $(this).text();
            var value = $(this).data("value");
            var ClincType = $(this).data("clinictype");
            SetClinic(value, text, ClincType);
        });

        if (TriggerFirstYN == "Y") {
            var FirstClinic = $(".header_speciality_dropdown .header_speciality_item").first();
            if (FirstClinic.length) {
                FirstClinic.trigger("click");
            }
        }
        if (ClinicLst.length <= 1) {
            $(".header_speciality_selected .clinic-arrow").hide();
            $(".header_speciality_selected").off("click");
        } else {
            $(".header_speciality_selected .clinic-arrow").show();
            $(".header_speciality_selected").click(function (e) {
                e.stopPropagation();
                $(".header_speciality_dropdown").toggle();
            });
        }
        BindOpdIpd();
    }

    function BindOpdIpd() {
        $('.header_OpdIpd_dropdown').empty();
        $('.header_OpdIpd_dropdown').append("<div class='header_OpdIpd_item h-font-size' data-value='OPD'>OPD</div>");
        if ('<%: Session["gDoctCode"] ?? "" %>' != "" && '<%: Session["AUTHYN"] ?? "" %>' != "Y") {
            $('.header_OpdIpd_dropdown').append("<div class='header_OpdIpd_item h-font-size' data-value='IPD'>IPD</div>");
        }
        if (sessionStorage.getItem("MODULE_FLAG") == "PAC")
            $('.header_OpdIpd_selected').attr('data-value', "OPD");
        else
            $('.header_OpdIpd_selected').attr('data-value', sessionStorage.getItem("MODULE_FLAG"));
    }

    function BindDropDownListWithoutPAC() { 
        $('.header_OpdIpd_dropdown').empty();
        $('.header_OpdIpd_dropdown').append("<div class='header_OpdIpd_item h-font-size' data-value='OPD'>OPD</div>");
        if ('<%: Session["gDoctCode"] ?? "" %>' != "" && '<%: Session["AUTHYN"] ?? "" %>' != "Y") {
            $('.header_OpdIpd_dropdown').append("<div class='header_OpdIpd_item h-font-size' data-value='IPD'>IPD</div>");
        }
    }
    function SetClinic(value, text, ClinicTyp) {
        var datatosend = {
            ClinicCode: value,
            ClinicName: text,
            ClinicType: ClinicTyp,
        }
        //startLoading("Loading");
        $.ajax({
            type: "POST",
            url: '../Account/SetClinic',
            data: datatosend,
            async: true,
            success: function (response) {
                handleClinicClick(true, datatosend);
                var moduleFlag = "OPD";
                if (sessionStorage.getItem("ClinicType") == "P") {
                    moduleFlag = "PAC";
                }
                setModuleSession(true, moduleFlag);
                if (moduleFlag === "OPD") {
                    window.location.href = "../SinglePage/WaitingListOPD";
                }
                else if (moduleFlag === "PAC") {
                    window.location.href = "../SinglePage/WaitingListPAC";
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading();
                ToastMsg(textStatus, "error");
            }
        });
    }
    function onModuleClickHeader(moduleFlag) {
        if (ValidationForRedirectModule() == true) {
            setModuleSession(true, moduleFlag);
            if (moduleFlag === "OPD") {
                GetClinicsList("N");
                SetClinic(sessionStorage.getItem("ClinicCode"), sessionStorage.getItem("ClinicName"), sessionStorage.getItem("ClinicType"));
            }
            else if (moduleFlag === "IPD") {
                window.location.href = "../SinglePage/WaitingListIPD";
            }
            else if (moduleFlag === "PAC") {
                window.location.href = "../SinglePage/WaitingListPAC";
            }
        }
    }
    function ValidationForRedirectModule() {
        return true;
    }
    function OpenSettingPopup(HeaderNM, Section, MaxFlag) {
        $("#popupOverlay").show();
        var ExistingID = "Hist_M_" + Section;
        if ($("#" + ExistingID).length > 0) {
            $("#" + ExistingID).remove();
        }
        var MainDivID = "Hist_M_" + Section;
        var HeaderDivID = "Hist_H_" + Section;
        var CloseBtnID = "Hist_H_Close_" + Section;
        var ContentID = "Hist_C_" + Section;

        var MinDiv = "<div class='MaxMinpopup " + (MaxFlag == true ? "maximized" : "") + "' id='" + MainDivID + "' style='display:none; max-height: 80vh;'>{ALLPOPMAINCONTENT}</div>";
        var HeaderDiv = "<div class='MaxMinpopup-header' id='" + HeaderDivID + "'>{ALLPOPHEAD}</div>";
        var HeaderLbl = "<h5>" + HeaderNM + "</h5>";
        var MaxBtn = "<button class='btn btn-sm btn-light' style='margin-left:auto; margin-right:5px;' onclick=\"maximizePopup('" + MainDivID + "');ReloadTableHeight('" + Section + "');\">⬜</button>";
        var CloseBtn = "<button id='" + CloseBtnID + "' class='btn btn-sm btn-danger' onclick=\"closeMaxMinPopup('" + MainDivID + "')\">✕</button>";
        var ContentDiv = "<div class='container-fluid MaxMinpopup-body' id='" + ContentID + "' style='overflow-y: auto;'>{ALLPOPCONTENT}</div>";
        var Content = "";
        var LoaderScreenMasterSetting = "<div id='loading-Master-Setting' class='loading-screen' style='display: none; opacity: 0;'></div>";

        if (Section == "MasterSetting") {
            Content = MasterSettingCont();
        }
        else if (Section == "UploadSignatory") {
            Content = GetUploadSignatoryHtml();
        }
        else if (Section == "UploadExamination") {
            Content = GetUploadExaminationHtml();
        }
        else if (Section == "MasterSetup") {
            Content = GetMasterSetupHtml();
        }
        else if (Section == "AppSettingConfig") {

            var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", HeaderLbl + MaxBtn + CloseBtn);

            LoadCalendarPartial(
                '../SinglePage/AppSettingConfig',
                RplHeaderDiv,
                ContentDiv,
                MinDiv,
                MainDivID
            );

            return;
        }
        else if (Section == "ErrorLog") {

            var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", HeaderLbl + MaxBtn + CloseBtn);

            LoadCalendarPartial(
                '../SinglePage/ErrorLogInfo',
                RplHeaderDiv,
                ContentDiv,
                MinDiv,
                MainDivID
            );

            return;

        }
        else if (Section == "MasterSetupList") {
            MaxBtn = "";
            LoaderScreenMasterSetting = "";
            Content = GetMasterSetupListHtml();
        }
        else if (Section == "PlanCompletionStatus") {
            Content = GetPlanCompletionStatusHtml();
        }
        else if (Section == "SchemeApprovalStatus") {
            Content = GetSchemeApprovalStatusHtml();
        }
        else if (Section == "OTPlanning") {
            MaxBtn = "";
            var otUrl = getOTUrl("/OT/OTPlanningVersion");
            Content = "<iframe id='iframeOTPlanning' src='" + otUrl + "' style='width:100%; height:100%; border:none; display:block;'></iframe>";
        }
        else if (Section == "OTBooking") {
            MaxBtn = "";
            var otUrl = getOTUrl("/OT/OTBookingV");
            Content = "<iframe id='iframeOTBooking' src='" + otUrl + "' style='width:100%; height:100%; border:none; display:block;'></iframe>";
        }

        else if (Section == "OTNotes") {
            MaxBtn = "";
            var otUrl = getOTUrl("/OT/OTNotesVersion");
            Content = "<iframe id='iframeOTNotes' src='" + otUrl + "' style='width:100%; height:100%; border:none; display:block;'></iframe>";
        }


        else if (Section == "OTPlanning") {
            Content = GetMasterSetupListHtml();
        }
        else if (Section == "OTBooking") {
            Content = GetMasterSetupListHtml();
        }

        else if (Section == "TumorBoardSchedule") {
            MaxBtn = "";
            CalenderActionType = "N";
            SendEventToSave = [];
            var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", HeaderLbl + MaxBtn + CloseBtn);
            Content = LoadCalendarPartial('../SinglePage/SingleTumorSchedule', RplHeaderDiv, ContentDiv, MinDiv, MainDivID);
            initializeCalendar();
            return;
        }
        else if (Section == "SurgicalSchedule") {
            MaxBtn = "";
            CalenderActionType = "N";
            SendEventToSave = [];
            var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", HeaderLbl + MaxBtn + CloseBtn);
            Content = LoadCalendarPartial('../SinglePage/SingleSurgicalSchedule', RplHeaderDiv, ContentDiv, MinDiv, MainDivID);
            initializeCalendar();
            return;
        }
        else {
            Content = "<div>No content defined for " + Section + "</div>";
        }
        var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", HeaderLbl + MaxBtn + CloseBtn);
        var RplContentDiv = ContentDiv.replace("{ALLPOPCONTENT}", Content + LoaderScreenMasterSetting);
        var RplMinDiv = MinDiv.replace("{ALLPOPMAINCONTENT}", RplHeaderDiv + RplContentDiv);
        $("body").append(RplMinDiv);
        $("#" + MainDivID).show();
        centerPopup(MainDivID);

        if (Section == "OTPlanning" || Section == "OTBooking" || Section == "OTNotes") {
            $("#" + MainDivID).css({
                "width": "98vw",
                "max-width": "98vw",
                "height": "96vh",
                "max-height": "96vh",
                "top": "50%",
                "left": "50%",
                "transform": "translate(-50%, -50%)",
                "border-radius": "6px",
                "box-shadow": "0 10px 30px rgba(0,0,0,0.5)"
            });
            $("#" + ContentID).css({
                "padding": "0px",
                "height": "calc(100% - 42px)",
                "overflow": "hidden"
            });
            $("#" + HeaderDivID).css({
                "background-color": "#174478",
                "padding": "8px 12px"
            });
        }

        

        if (Section == "MasterSetup") {
            MasterSetUpTranCode = "";
            LoadMasterSetupForm();
        }
        if (Section == "UploadSignatory") {
            GetUploadSignatoryData();
        }
        if (Section == "PlanCompletionStatus") {
            LoadPlanCompletionStatusGrid([]);
        }
        if (Section == "SchemeApprovalStatus") {
            LoadSchemeApprovalStatusGrid([]);
        }
    }

    function LoadCalendarPartial(Urls, RplHeaderDiv, ContentDiv, MinDiv, MainDivID) {
        $.ajax({
            url: Urls,
            type: 'GET',
            async: false,
            success: function (data) {
                var RplContentDiv = ContentDiv.replace("{ALLPOPCONTENT}", data);
                var RplMinDiv = MinDiv.replace("{ALLPOPMAINCONTENT}", RplHeaderDiv + RplContentDiv);
                $("body").append(RplMinDiv);
                $("#" + MainDivID).show();
                centerPopup(MainDivID);
            },
            error: function (xhr, status, error) {

            }
        });
    }

    function ReloadTableHeight() {
        if (Tabulator.findTable("#MasterSettingTable") != false)
            Tabulator.findTable("#MasterSettingTable")[0].setHeight(GetHeightOfMasterSettingGrid() + "px");
    }


    //function getOTUrl(relativePath) {
      //  var origin = window.location.origin;
        //var curURL = window.location.href.toUpperCase();
        //return "http://localhost:60436" + relativePath;
        // if (curURL.indexOf("TESTDOCTORDESK") !== -1 || curURL.indexOf("TESTWEBHMIS") !== -1) {
        //     return <or></or>igin + "/TestWebOTCath" + relativePath;
        // } else if (curURL.indexOf("DOCTORDESK") !== -1 || curURL.indexOf("WEBHMIS") !== -1) {
        //     return origin + "/WebOTCath" + relativePath;
        // } else if (window.location.hostname === "localhost") {
        //     return window.location.protocol + "//" + window.location.hostname + ":60436" + relativePath;
        // } else {
        //     return origin + relativePath;
        // }
//}

    function getOTUrl(targetPath) {
        var origin = window.location.origin;
        var curURL = window.location.href.toUpperCase();
        var baseUrl = "";

        // 1. Test / Staging Environment on IIS
        if (curURL.indexOf("TESTDOCTORDESK") !== -1 || curURL.indexOf("TESTWEBHMIS") !== -1) {
            baseUrl = origin + "/TestWebOTCath";
        }
        // 2. Production Environment on IIS
        else if (curURL.indexOf("DOCTORDESK") !== -1 || curURL.indexOf("WEBHMIS") !== -1) {
            baseUrl = origin + "/WebOTCath";
        }
        // 3. Local Development in Visual Studio (port 60436)
        else if (window.location.hostname === "localhost") {
            baseUrl = window.location.protocol + "//" + window.location.hostname + ":60436";
        }


        // 4. Default Fallback
        else {
            baseUrl = origin + "/WebOTCath";
        }

        // Active Doctor Desk User and Hospital Unit
        var userId = (typeof gDoctId !== "undefined" && gDoctId !== "") ? gDoctId : '<%: Session["gOncoUserId"] ?? "" %>';
        var unitCode = (typeof UnitCd !== "undefined" && UnitCd !== "") ? UnitCd : '<%: Session["UNITCODE"] ?? "" %>';

        // Active Patient Details from SessionStorage
        var ipno = sessionStorage.getItem("IPPatIPNO") || $("#HeaderSection_PatDetails_ipNo").text().trim() || "";
        var mrno = sessionStorage.getItem("IPPatMRNO") || $("#HeaderSection_PatDetails_MRNO").text().trim() || sessionStorage.getItem("PatMRNO") || "";


        // Pass doctor, unit, and patient directly to the OTController method:
        var queryParams = "?refID=" + encodeURIComponent(userId)
            + "&UnitCode=" + encodeURIComponent(unitCode)
            + "&ipno=" + encodeURIComponent(ipno)
            + "&mrno=" + encodeURIComponent(mrno);

        return baseUrl + targetPath + queryParams;

    }


    function cleanOTIframe(iframe) {
        try {
            var doc = iframe.contentDocument || iframe.contentWindow.document;
            if (doc) {
                $(doc).find("#header, #cssmenu, #menuList, .main-header, .header-section, #sessionPopupOverlay").hide();
                $(doc).find(".content, .main-body-wrapper, #secCont, #MainDiv").css({
                    "margin-left": "0px",
                    "padding": "0px",
                    "width": "100%"
                });
            }
        } catch (e) {
            console.warn("Iframe styling handled: ", e);
    }
}


function openIframe() {
    const iframeMain = document.getElementById('iframeMain');
    iframeMain.style.display = 'block';
    iframeMain.classList.remove('minimized');

    // Automatically resolves localhost:60436 locally and /WebOTCath in Production
    const url = getOTUrl('/OT/OTBookingV');

    $("#iframeContainer").html(`<iframe id="myIframe" src="${url}" style="width:100%; height:100%; border:none;"></iframe>`);
    }


</script>



<%-- Referal Notes Notification --%>
<script type="text/javascript">
    function GetReferalDoctList() {
        startLoading("Loading", "loading-Referal-Doctor-Notes");
        $.ajax({
            url: '../DoctorDesk/GetReferralNotesList',
            type: "POST",
            datatype: "json",
            async: true,
            success: function (data) {
                BindReferalDoctList(data);
                var count = data.length;
                if (count > 0) {
                    $("#btnBellIconCount").text(count).show();
                } else {
                    $("#btnBellIconCount").hide();
                }
                stopLoading("loading-Referal-Doctor-Notes");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Referal-Doctor-Notes");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function BindReferalDoctList(NotesLstData) {
        $("#ReferralNotification").empty();
        if (NotesLstData == "" || NotesLstData == null || NotesLstData.length == 0) {
            NoDataFound("No Data Found", "ReferralNotification", "NoDataFoundStyle2", "NoDataFoundStyle2h2");
        }
        else {

            for (var i = 0; i < NotesLstData.length; i++) {
                var Statement = ""; 
                var formattedNote = NotesLstData[i].NOTE;
                if (NotesLstData[i].ISDOCT === "Y") {
                    Statement = "<label><b>Dr." + NotesLstData[i].REFBYDOCTOR + "</b> referred <b>" + NotesLstData[i].PATNAME + "</b> with the note: '" + formattedNote + "'</label>";
                }
                else {
                    Statement = "<label><b>" + NotesLstData[i].REFBYDOCTOR + "</b> referred <b>" + NotesLstData[i].PATNAME + "</b> with the note: '" + formattedNote + "'</label>";
                }
                if (NotesLstData[i].IPNO)
                    var ReferalDoctContentDiv = "<div class='ntf-item ipdn'><div class='ntf-icon'>●</div><div class='ntf-content'><p>" + Statement + "</p><div class='ntf-content-footer'>" + NotesLstData[i].Date + " - " + NotesLstData[i].Time + "</div></div> </div>";
                else
                    var ReferalDoctContentDiv = "<div class='ntf-item opdn'><div class='ntf-icon'>●</div><div class='ntf-content '><p>" + Statement + "</p><div class='ntf-content-footer'>" + NotesLstData[i].Date + " - " + NotesLstData[i].Time + "</div></div> </div>";
                $("#ReferralNotification").append(ReferalDoctContentDiv);
            }
        }
    }
</script>

<%-- Master Setting --%>
<script type="text/javascript">
    var MasterSettingTable;
    var gMasterSettingSelList = [
        { Id: "select", Value: "S", Text: "-- Select --" },
        { Id: "complaints", Value: "C", Text: "Complaints" },
        { Id: "diagnosis", Value: "D", Text: "Diagnosis" },
        { Id: "patadvice", Value: "A", Text: "Patient Advice" },
        { Id: "medremarks", Value: "R", Text: "Medicine Remarks" },
        { Id: "PersHistMaster", Value: "H", Text: "Personal History(Habit)" },
        { Id: "MedHistMaster", Value: "M", Text: "Medical History(Disease)" },
        { Id: "route", Value: "T", Text: "Route" },
        { Id: "ageGrp", Value: "G", Text: "Age Group" },
        { Id: "Freq", Value: "F", Text: "Frequency" },
        { Id: "Allergy", Value: "L", Text: "Allergy" }
    ];
    var MasterSettingAllergyTypeListRes = [];
    <% var MasterSettingSamp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
    var AllergyTypeList = '<%:Html.Raw(MasterSettingSamp.Serialize(ViewBag.AllergyTypeLst))%>';
    AllergyTypeList = JSON.parse(AllergyTypeList);
    function MasterSettingSelListString() {
        var MasterSettingListResult = "";
        var Option = "<option id='{ID}' value='{OPTVALUE}'>{OPTEXT}</option>";
        $.grep(gMasterSettingSelList, function (a) {
            var RplOption = Option.replace("{ID}", a.Id).replace("{OPTVALUE}", a.Value).replace("{OPTEXT}", a.Text);
            MasterSettingListResult = MasterSettingListResult + RplOption;
        });
        return MasterSettingListResult;
    }

    function MasterSettingAllergyTypeList() {
        MasterSettingAllergyTypeListRes = {};
        jQuery.each(AllergyTypeList, function (i, e) {
            MasterSettingAllergyTypeListRes[e.Value] = e.Text;
        });
    }

    function MasterSettingCont() {
        var MasterSetCont = "";
        var dropdownOpts = MasterSettingSelListString();
        var toolbarHtml = ' <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;" id="MasterSettingSelDiv"><select id="MasterCategorySelect" class="form-control" style="width: 250px;" onchange="GetMasterSettingReportData()">' + dropdownOpts + '</select>' +
            '<div style="display:flex; gap:10px;"><img src="../Images/Singlepage/Plus.png" alt="Add" style="width:34px; height:34px; cursor:pointer; object-fit:contain;" title="Add New Entry" onclick="AddNewMasterSettingItem()" />' +
            '<button id="btnSaveMaster" class="btn btn-primary" onclick="SaveMasterSettingData()"><i class="fa fa-save"></i> Save</button></div></div>';
        var gridHtml = "<div id='MasterSettingTable'></div>";
        MasterSetCont = toolbarHtml + gridHtml;
        return MasterSetCont;
    }
    function GetMasterSettingReportData() {
        var stype = document.getElementById('MasterCategorySelect').value;
        var GetReportDataresp = [];
        var table = Tabulator.findTable("#MasterSettingTable")[0];
        if (table) {
            table.destroy();
        }
        if (stype != 'S' && stype != "G") {
            startLoading("Loading", "loading-Master-Setting");
            $.ajax({
                type: "GET",
                url: "../Clinicalnotes/GetReportData",
                data: { strType: stype },
                async: false,
                datatype: "json",
                success: function (result) {
                    if (result != "null" && result != "") {
                        GetReportDataresp = JSON.parse(result);
                    }
                    if (stype == "F") {
                        LoadFrequencyMasterSettingGrid(GetReportDataresp);
                    }
                    else if (stype == "L") {
                        LoadAllergyMasterSettingGrid(GetReportDataresp);
                    }
                    else {
                        LoadCommonMasterSettingGrid(GetReportDataresp);
                    }
                    stopLoading("loading-Master-Setting");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    stopLoading("loading-Master-Setting");
                    ToastMsg(textStatus, "error");
                }
            });
        }
        if (stype == 'G') {
            startLoading("Loading", "loading-Master-Setting");
            $.ajax({
                type: "post",
                url: "../Clinicalnotes/GetAgeGroupLst",
                data: {},
                async: false,
                datatype: "json",
                success: function (result) {
                    if (result != "null" && result != "") {
                        GetReportDataresp = result;
                    }
                    LoadAgeGrpMasterSettingGrid(GetReportDataresp);
                    stopLoading("loading-Master-Setting");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    stopLoading("loading-Master-Setting");
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }

    function LoadCommonMasterSettingGrid(tableData) {
        var table = new Tabulator("#MasterSettingTable", {
            data: tableData,
            height: (GetHeightOfMasterSettingGrid() + "px"),
            layout: "fitColumns",
            rowFormatter: function (row) {
                var data = row.getData();
                if (data.STATUS === "I") {
                    row.getElement().classList.add("CancelClass");
                }
            },
            rowHeader: {
                headerSort: false,
                resizable: false,
                frozen: true,
                headerHozAlign: "center",
                hozAlign: "center",
                formatter: "rowSelection",
                titleFormatter: "rowSelection",
                cellClick: function (e, cell) {
                    cell.getRow().toggleSelect();
                },
                width: 60
            },
            columns: [
                { title: "CODE", field: "CODE", headerFilter: "input", editor: false, visible: false, tooltip: true },
                {
                    title: "Name", field: "NAME", editor: "input", headerFilter: "input", tooltip: true,
                    editable: function (cell) {
                        return cell.getRow().isSelected();
                    }
                },
                {
                    title: "Hindi", field: "HINDI", editor: "input", headerFilter: "input", tooltip: true,
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                {
                    title: "Marathi", field: "MARATHI", editor: "input", headerFilter: "input", tooltip: true,
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                {
                    title: "Gujrati", field: "GUJRATI", editor: "input", headerFilter: "input", tooltip: true,
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                { title: "Created By", field: "CREATEDBY", headerFilter: "input", editor: false, tooltip: true },
                {
                    title: "Status",
                    field: "STATUS",
                    editor: "list",
                    tooltip: true,
                    editorParams: { values: { "I": "Inactive", "A": "Active" } },
                    formatter: "lookup",
                    formatterParams: { "I": "Inactive", "A": "Active" },
                    headerFilter: "list",
                    headerFilterParams: { values: { "": "All", "I": "Inactive", "A": "Active" } },
                    editable: function (cell) { return cell.getRow().isSelected(); }
                }
            ],
        });
    }

    function LoadAllergyMasterSettingGrid(tableData) {
        MasterSettingAllergyTypeList();
        var MasterSettingAllergyTypeLst = MasterSettingAllergyTypeListRes;
        var AllMasterSettingAllergyTypeLst = Object.assign({}, MasterSettingAllergyTypeLst);
        AllMasterSettingAllergyTypeLst[""] = "All";
        var table = new Tabulator("#MasterSettingTable", {
            data: tableData,
            height: (GetHeightOfMasterSettingGrid() + "px"),
            layout: "fitColumns",
            rowFormatter: function (row) {
                var data = row.getData();
                if (data.STATUS === "I") {
                    row.getElement().classList.add("CancelClass");
                }
            },
            rowHeader: {
                headerSort: false,
                resizable: false,
                frozen: true,
                headerHozAlign: "center",
                hozAlign: "center",
                formatter: "rowSelection",
                titleFormatter: "rowSelection",
                cellClick: function (e, cell) {
                    cell.getRow().toggleSelect();
                },
                width: 60
            },
            columns: [
                { title: "CODE", field: "CODE", headerFilter: "input", editor: false, visible: false, tooltip: true },
                {
                    title: "Type",
                    field: "ALLERGYTYPE",
                    editor: "list",
                    tooltip: true,
                    editorParams: { values: MasterSettingAllergyTypeLst },
                    formatter: "lookup",
                    formatterParams: MasterSettingAllergyTypeLst,
                    headerFilter: "list",
                    headerFilterParams: { values: AllMasterSettingAllergyTypeLst },
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                {
                    title: "Name", field: "NAME", editor: "input", headerFilter: "input", tooltip: true,
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                { title: "Created By", field: "CREATEDBY", headerFilter: "input", editor: false, tooltip: true },
                {
                    title: "Status",
                    field: "STATUS",
                    tooltip: true,
                    editor: "list",
                    editorParams: { values: { "I": "Inactive", "A": "Active" } },
                    formatter: "lookup",
                    formatterParams: { "I": "Inactive", "A": "Active" },
                    headerFilter: "list",
                    headerFilterParams: { values: { "": "All", "I": "Inactive", "A": "Active" } },
                    editable: function (cell) { return cell.getRow().isSelected(); }
                }
            ],
        });
    }

    function LoadFrequencyMasterSettingGrid(tableData) {
        var table = new Tabulator("#MasterSettingTable", {
            data: tableData,
            height: (GetHeightOfMasterSettingGrid() + "px"),
            layout: "fitColumns",
            rowFormatter: function (row) {
                var data = row.getData();
                if (data.STATUS === "I") {
                    row.getElement().classList.add("CancelClass");
                }
            },
            rowHeader: {
                headerSort: false,
                resizable: false,
                frozen: true,
                headerHozAlign: "center",
                hozAlign: "center",
                formatter: "rowSelection",
                titleFormatter: "rowSelection",
                cellClick: function (e, cell) {
                    cell.getRow().toggleSelect();
                },
                width: 60
            },
            columns: [
                { title: "CODE", field: "CODE", headerFilter: "input", editor: false, visible: false, tooltip: true },

                {
                    title: "Name", field: "NAME", editor: "input", headerFilter: "input", tooltip: true,
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                {
                    title: "Tab Count",
                    field: "TABCOUNT",
                    width: 160,
                    tooltip: true,
                    headerSort: true,
                    resizable: true,
                    visible: (CalcQtyYN == "Y"),
                    headerFilter: "input",
                    editor: "number",
                    editorParams: {
                        step: 0.5,
                        min: 0
                    },
                    cellEdited: function (cell) {
                        var value = cell.getValue();
                        value = String(value).replace(/[^0-9.]/g, "");
                        if ((value.match(/\./g) || []).length > 1) {
                            value = value.slice(0, -1);
                        }
                        cell.setValue(value);
                    },
                    formatter: "number",
                    formatterParams: {
                        decimal: ".",
                        thousand: ",",
                        precision: 2,
                        default: "1.00"
                    },
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                {
                    title: "Hindi", field: "HINDI", editor: "input", headerFilter: "input", tooltip: true,
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                {
                    title: "Marathi", field: "MARATHI", editor: "input", headerFilter: "input", tooltip: true,
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                {
                    title: "Gujrati", field: "GUJRATI", editor: "input", headerFilter: "input", tooltip: true,
                    editable: function (cell) { return cell.getRow().isSelected(); }
                },
                { title: "Created By", field: "CREATEDBY", headerFilter: "input", editor: false, tooltip: true },
                {
                    title: "Status",
                    field: "STATUS",
                    editor: "list",
                    tooltip: true,
                    editorParams: { values: { "I": "Inactive", "A": "Active" } },
                    formatter: "lookup",
                    formatterParams: { "I": "Inactive", "A": "Active" },
                    headerFilter: "list",
                    headerFilterParams: { values: { "": "All", "I": "Inactive", "A": "Active" } },
                    editable: function (cell) { return cell.getRow().isSelected(); }
                }
            ],
        });
    }

    function LoadAgeGrpMasterSettingGrid(tableData) {
        var table = new Tabulator("#MasterSettingTable", {
            data: tableData,
            height: (GetHeightOfMasterSettingGrid() + "px"),
            layout: "fitColumns",
            rowFormatter: function (row) {
                var data = row.getData();
                if (data.STATUS === "I") {
                    row.getElement().classList.add("CancelClass");
                }
            },
            columns: [
                {
                    title: "",
                    field: "edit",
                    width: 60,
                    hozAlign: "center",
                    headerSort: false,
                    frozen: true,
                    formatter: function () {
                        return "<i class='fa fa-edit MasterSettingGridIcon' style='cursor:pointer;'></i>";
                    },
                    cellClick: function (e, cell) {
                        var code = cell.getRow().getData().CODE;
                        AddNewMasterSettingItem(code);
                    }
                },
                { title: "CODE", field: "CODE", headerFilter: "input", editor: false, visible: false, tooltip: true },
                { title: "Seq", field: "SEQ", headerFilter: "input", editor: false, width: 80, tooltip: true },
                { title: "Age Group", field: "AGEGRP", editor: false, headerFilter: "input", tooltip: true },
                { title: "From Age", field: "FRMAGE", editor: false, headerFilter: "input", width: 100, tooltip: true },
                { title: "To Age", field: "TOAGE", editor: false, headerFilter: "input", width: 80, tooltip: true },
                { title: "Remark", field: "REMARK", editor: false, headerFilter: "input", tooltip: true },
                { title: "Created By", field: "CREATEDBY", headerFilter: "input", editor: false, width: 150, tooltip: true },
                {
                    title: "Status",
                    field: "STATUS",
                    width: 100,
                    tooltip: true,
                    editor: false,
                    formatter: "lookup",
                    formatterParams: { "I": "Inactive", "A": "Active" },
                    headerFilter: "list",
                    headerFilterParams: { values: { "": "All", "I": "Inactive", "A": "Active" } }
                }
            ],
        });
        table.on("rowClick", function (e, row) {
            alert("Row " + row.getIndex() + " Clicked!!!!")
        });
    }

    function GetHeightOfMasterSettingGrid() {
        var FilterHeight = document.getElementById("MasterSettingSelDiv").offsetHeight;
        var ContHeight = document.getElementById("Hist_C_MasterSetting").offsetHeight;
        var FHeight = ContHeight - FilterHeight - 60;
        if (FHeight > 150) {
            return FHeight;
        }
        return 150;
    }

    function SaveMasterSettingData() {
        var stype = document.getElementById('MasterCategorySelect').value;
        if (stype == "" || stype == "S") {
            ToastMsg("Please Select Master Type", "warning");
            return false;
        }
        if (Tabulator.findTable("#MasterSettingTable") == "" || Tabulator.findTable("#MasterSettingTable") == false || Tabulator.findTable("#MasterSettingTable") == null || Tabulator.findTable("#MasterSettingTable")[0].getSelectedData().length == 0) {
            ToastMsg("No Data Found For Save.", "warning");
            return false;
        }
        var data = Tabulator.findTable("#MasterSettingTable")[0].getSelectedData();
        if (stype == "L") {
            data.forEach(function (item) {
                item.FIELD3COL = item.ALLERGYTYPE;
                delete item.ALLERGYTYPE;
                delete item.TABCOUNT;
            });
        }
        var datatosend = {
            data: JSON.stringify(data),
            strType: stype
        };
        startLoading("Saving", "loading-Master-Setting");
        $.ajax({
            type: 'post',
            data: datatosend,
            url: '../Clinicalnotes/SendData',
            cache: false,
            dataType: "json",
            async: true,
            success: function (result) {
                stopLoading("loading-Master-Setting");
                if (result.search("Success") > -1)
                    ToastMsg("Saved Successfully", "success");
                else
                    ToastMsg(result, "warning");
                GetMasterSettingReportData();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Master-Setting");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function AddNewMasterSettingItem(AgeGrpCode) {
        $("#AddMasterModal").empty();
        var category = $("#MasterCategorySelect").val();
        if (!category || category == "" || category == "S") {
            ToastMsg("Please select a Category from the dropdown before adding new items.", "warning");
            return;
        }
        if (category == "L") {
            AllergyNewMasterSettingItemContent();
        }
        else if (category == "G") {
            AgeGroupNewMasterSettingItemContent(AgeGrpCode);
        }
        else if (category == "F") {
            FrequencyNewMasterSettingItemContent();
        }
        else {
            CommonNewMasterSettingItemContent();
        }
        $("#AddMasterModal").appendTo("body");
        $("#AddMasterModal").css("display", "flex");
    }

    function MasterSettingClinicIndexChanged() {
        var urls = '../Clinicalnotes/ClinicIndexChanged';
        var MasterSettingClinicIndexOptions = "";
        $.ajax({
            type: "POST",
            url: urls,
            async: false,
            dataType: "json",
            success: function (response) {
                if (response != null) {
                    var opts = '<option value="">' + '--Select--' + '</option>'
                    for (var m = 0; m < response.length; m++) {
                        opts += '<option value="' + response[m].Value + '" >' + response[m].Text + '</option>'
                    }
                    MasterSettingClinicIndexOptions = opts;
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                MsgDia('An error occurred while processing your request.', "Error Information");
            }
        });
        return MasterSettingClinicIndexOptions;
    }

    function MasterSettingAllergyTypeOpt() {
        var MasterSettingAlgTypeoptResp = "";
        jQuery.each(AllergyTypeList, function (i, e) {
            MasterSettingAlgTypeoptResp = MasterSettingAlgTypeoptResp + '<option value="' + e.Value + '" >' + e.Text + '</option>';
        });
        return MasterSettingAlgTypeoptResp;
    }

    function CommonNewMasterSettingItemContent() {
        var HeaderName = "";
        $.grep(gMasterSettingSelList, function (a) {
            if ($("#MasterCategorySelect").val() == a.Value) {
                HeaderName = a.Text;
            }
        });
        var MasterSettingClinicIndexOptions = MasterSettingClinicIndexChanged();
        var CommonNewMasterSettingItemContentString =
            '<div class="adm-modal-box">' +
            '<div class="adm-header">' +
            '<span>Add New ' + HeaderName + ' Entry</span>' +
            '<button class="adm-close-btn" onclick="CloseNewMasterSettingItem()">×</button>' +
            '</div>' +
            '<div class="adm-body">' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Clinic</label>' +
            '<select id="admClinic" class="form-control adm-input">' + MasterSettingClinicIndexOptions + '</select>' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (English)</label>' +
            '<input type="text" id="admName" autocomplete="off" class="adm-input" placeholder="Enter Name" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (Hindi)</label>' +
            '<input type="text" id="admHindi" autocomplete="off" class="adm-input" placeholder="Enter Hindi Name" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (Marathi)</label>' +
            '<input type="text" id="admMarathi" autocomplete="off" class="adm-input" placeholder="Enter Marathi Name" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (Gujarati)</label>' +
            '<input type="text" id="admGujrati" autocomplete="off" class="adm-input" placeholder="Enter Gujarati Name" />' +
            '</div>' +
            '</div>' +
            '<div class="adm-footer">' +
            '<button class="adm-btn-save" onclick="SaveNewMasterEntry()">Save</button>' +
            '</div>' +
            '<div id="loading-NewMasterSetting" class="loading-screen" style="display: none; opacity: 0;"></div>' +
            '</div>';
        $("#AddMasterModal").append(CommonNewMasterSettingItemContentString);
    }

    function AllergyNewMasterSettingItemContent() {
        var HeaderName = "";
        $.grep(gMasterSettingSelList, function (a) {
            if ($("#MasterCategorySelect").val() == a.Value) {
                HeaderName = a.Text;
            }
        });
        var MasterSettingClinicIndexOptions = MasterSettingClinicIndexChanged();
        var MasterSettingAllergyTypeOptions = MasterSettingAllergyTypeOpt();

        var AllergyNewMasterSettingItemContentString =
            '<div class="adm-modal-box">' +
            '<div class="adm-header">' +
            '<span>Add New ' + HeaderName + ' Entry</span>' +
            '<button class="adm-close-btn" onclick="CloseNewMasterSettingItem()">×</button>' +
            '</div>' +
            '<div class="adm-body">' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Clinic</label>' +
            '<select id="admClinic" class="form-control adm-input">' + MasterSettingClinicIndexOptions + '</select>' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Allergy Type</label>' +
            '<select id="admAllergyType" class="form-control adm-input">' + MasterSettingAllergyTypeOptions + '</select>' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (English)</label>' +
            '<input type="text" id="admName" autocomplete="off" class="adm-input" placeholder="Enter Name" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (Hindi)</label>' +
            '<input type="text" id="admHindi" autocomplete="off" class="adm-input" placeholder="Enter Hindi Name" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (Marathi)</label>' +
            '<input type="text" id="admMarathi" autocomplete="off" class="adm-input" placeholder="Enter Marathi Name" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (Gujarati)</label>' +
            '<input type="text" id="admGujrati" autocomplete="off" class="adm-input" placeholder="Enter Gujarati Name" />' +
            '</div>' +
            '</div>' +
            '<div class="adm-footer">' + '<button class="adm-btn-save" onclick="SaveNewMasterEntry()">Save</button>' +
            '</div>' +
            '<div id="loading-NewMasterSetting" class="loading-screen" style="display: none; opacity: 0;"></div>' +
            '</div>';
        $("#AddMasterModal").append(AllergyNewMasterSettingItemContentString);
    }

    function FrequencyNewMasterSettingItemContent() {
        var HeaderName = "";
        $.grep(gMasterSettingSelList, function (a) {
            if ($("#MasterCategorySelect").val() == a.Value) {
                HeaderName = a.Text;
            }
        });
        var MasterSettingClinicIndexOptions = MasterSettingClinicIndexChanged();

        var FrequencyNewMasterSettingItemContentString =
            '<div class="adm-modal-box">' +
            '<div class="adm-header">' +
            '<span>Add New ' + HeaderName + ' Entry</span>' +
            '<button class="adm-close-btn" onclick="CloseNewMasterSettingItem()">×</button>' +
            '</div>' +
            '<div class="adm-body">' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Clinic</label>' +
            '<select id="admClinic" class="form-control adm-input">' + MasterSettingClinicIndexOptions + '</select>' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Tablet Count</label>' +
            '<input type="number" id="admTabCount" autocomplete="off" class="adm-input" placeholder="Tablet Count" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (English)</label>' +
            '<input type="text" id="admName" autocomplete="off" class="adm-input" placeholder="Enter Name" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (Hindi)</label>' +
            '<input type="text" id="admHindi" autocomplete="off" class="adm-input" placeholder="Enter Hindi Name" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (Marathi)</label>' +
            '<input type="text" id="admMarathi" autocomplete="off" class="adm-input" placeholder="Enter Marathi Name" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">' + HeaderName + ' (Gujarati)</label>' +
            '<input type="text" id="admGujrati" autocomplete="off" class="adm-input" placeholder="Enter Gujarati Name" />' +
            '</div>' +
            '</div>' +
            '<div class="adm-footer">' + '<button class="adm-btn-save" onclick="SaveNewMasterEntry()">Save</button>' +
            '</div>' +
            '<div id="loading-NewMasterSetting" class="loading-screen" style="display: none; opacity: 0;"></div>' +
            '</div>';
        $("#AddMasterModal").append(FrequencyNewMasterSettingItemContentString);
    }

    function AgeGroupNewMasterSettingItemContent(AgeGrpMasterSettingCode) {
        var HeaderName = "";
        $.grep(gMasterSettingSelList, function (a) {
            if ($("#MasterCategorySelect").val() == a.Value) {
                HeaderName = a.Text;
            }
        });
        var AgeGrpMasterSettingAction = "N";
        var rowData = [];
        if (AgeGrpMasterSettingCode != "" && AgeGrpMasterSettingCode != undefined && AgeGrpMasterSettingCode != null) {
            AgeGrpMasterSettingAction = "E";
            rowData = Tabulator.findTable("#MasterSettingTable")[0].searchRows("CODE", "=", AgeGrpMasterSettingCode)[0].getData();
        }
        var MasterSettingAgeGroupStatusOptions = "<option value='A'>Active</option><option value='I'>InActive</option>";
        var AgeGroupNewMasterSettingItemContentString =
            '<div class="adm-modal-box">' +
            '<div class="adm-header">' +
            '<span>' + (AgeGrpMasterSettingAction == "N" ? "Add New" : "Update") + ' ' + HeaderName + ' Entry</span>' +
            '<button class="adm-close-btn" onclick="CloseNewMasterSettingItem()">×</button>' +
            '</div>' +
            '<div class="adm-body">' +
            '<div class="adm-form-group" style="display:none">' +
            '<label class="adm-label">Age Group</label>' +
            '<input type="text" id="admAgeGrpCode" autocomplete="off" class="adm-input" placeholder="Enter Age Group" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Age Group</label>' +
            '<input type="text" id="admAgeGrp" autocomplete="off" class="adm-input" placeholder="Enter Age Group" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Seq No.</label>' +
            '<input type="number" id="admSeqNo" autocomplete="off" class="adm-input" placeholder="Enter Seq No." />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">From Age</label>' +
            '<input type="text" id="admFromAge" autocomplete="off" class="adm-input" placeholder="Enter From Age" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">To Age</label>' +
            '<input type="text" id="admToAge" autocomplete="off" class="adm-input" placeholder="Enter To Age" />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Remark</label>' +
            '<textarea class="adm-input TextAreaBorder" id="admRemark" placeholder="Enter Remark" autocomplete="off" maxlength="500"></textarea>' +
            '</div>' +
            '<div class="adm-form-group" style=' + (AgeGrpMasterSettingAction == "N" ? "display:none" : "") + '>' +
            '<label class="adm-label">Status</label>' +
            '<select id="cmbadmStatus" onchange="AgeGroupMasterSettingStatusChange()" class="form-control adm-input">' + MasterSettingAgeGroupStatusOptions + '</select>' +
            '</div>' +
            '</div>' +
            '<div class="adm-footer">' + '<button class="adm-btn-save" onclick="SaveUpdateAgeGrpNewMasterEntry()">' + (AgeGrpMasterSettingAction == "N" ? "Save" : "Update") + '</button>' +
            '</div>' +
            '<div id="loading-NewMasterSetting" class="loading-screen" style="display: none; opacity: 0;"></div>' +
            '</div>';
        $("#AddMasterModal").append(AgeGroupNewMasterSettingItemContentString);
        $("#admFromAge").inputmask('###:##:##');
        $("#admToAge").inputmask('###:##:##');
        if (AgeGrpMasterSettingAction !== "N" && rowData) {
            $("#admAgeGrpCode").val(rowData.CODE || "");
            $("#admAgeGrp").val(rowData.AGEGRP || "");
            $("#admSeqNo").val(rowData.SEQ || "");
            $("#admFromAge").val(rowData.FRMAGE || "");
            $("#admToAge").val(rowData.TOAGE || "");
            $("#admRemark").val(rowData.REMARK || "");
            $("#cmbadmStatus").val(rowData.STATUS || "A");
        }
    }

    function AgeGroupMasterSettingStatusChange() {
        if ($("#admStatus").val() == "I") {
            $(".adm-modal-box").find("input[type='text'], textarea").prop("disabled", true);
        }
        else {
            $(".adm-modal-box").find("input[type='text'], textarea").prop("disabled", false);
        }
    }

    function MasterSettingAgeGroupVaccineContent(code, rowData) {
        $("#AddMasterModal").empty();
        var MasterSettingAgeGroupVaccineContentString =
            '<div class="adm-modal-box">' +
            '<div class="adm-header">' +
            '<span>Vaccine</span>' +
            '<button class="adm-close-btn" onclick="CloseNewMasterSettingItem()">×</button>' +
            '</div>' +
            '<div class="adm-body">' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Code</label>' +
            '<input type="text" id="admAgeGrpCode" autocomplete="off" class="adm-input" readonly />' +
            '</div>' +
            '<div class="adm-form-group">' +
            '<label class="adm-label">Age Group</label>' +
            '<input type="text" id="admAgeGrpName" autocomplete="off" class="adm-input" readonly />' +
            '</div>' +
            '<div id="MasterSettingAgeGrpVaccineTable"></div>'
        '</div>' +
            '<div class="adm-footer">' + '<button class="adm-btn-save" onclick="SaveNewMasterEntry()">Save</button>' +
            '</div>' +
            '<div id="loading-NewMasterSetting" class="loading-screen" style="display: none; opacity: 0;"></div>' +
            '</div>';
        $("#AddMasterModal").append(MasterSettingAgeGroupVaccineContentString);
        $("#admAgeGrpCode").val(code);
        $("#admAgeGrpName").val(rowData.AGEGRP);
        $("#AddMasterModal").appendTo("body");
        $("#AddMasterModal").css("display", "flex");
    }

    function GetMasterSettingAgeGroupVaccineData(code, rowData) {
        MasterSettingAgeGroupVaccineContent(code, rowData);
        startLoading("Loading", "loading-NewMasterSetting");
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetVaccinationLst",
            data: { AgeGrpCode: rowData.CODE },
            async: false,
            success: function (result) {
                var res = [];
                if (result[0] != null) {
                    res = result[0];
                }
                LoadCommonMasterSettingAgeGroupVaccineGrid(res);
                stopLoading("loading-NewMasterSetting");
            },
            onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-NewMasterSetting");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function LoadCommonMasterSettingAgeGroupVaccineGrid(tableData) {
        var table = new Tabulator("#MasterSettingAgeGrpVaccineTable", {
            data: tableData,
            height: "150px",
            layout: "fitColumns",
            rowFormatter: function (row) {
                var data = row.getData();
                if (data.STATUS === "I") {
                    row.getElement().classList.add("CancelClass");
                }
            },
            rowHeader: {
                headerSort: false,
                resizable: false,
                frozen: true,
                headerHozAlign: "center",
                hozAlign: "center",
                formatter: "rowSelection",
                titleFormatter: "rowSelection",
                cellClick: function (e, cell) {
                    cell.getRow().toggleSelect();
                },
                width: 60
            },
            columns: [
                { title: "CODE", field: "CODE", headerFilter: "input", editor: false, visible: false, tooltip: true },
                {
                    title: "Vaccine", field: "NAME", editor: "input", headerFilter: "input", tooltip: true,
                    editable: true
                },
                {
                    title: "Age Grp Code", field: "AGEGRPCD", editor: false, visible: false, headerFilter: "input", tooltip: true,
                    editable: false
                },
                {
                    title: "Status",
                    field: "STATUS",
                    editor: "list",
                    tooltip: true,
                    editorParams: { values: { "I": "Inactive", "A": "Active" } },
                    formatter: "lookup",
                    formatterParams: { "I": "Inactive", "A": "Active" },
                    headerFilter: "list",
                    headerFilterParams: { values: { "": "All", "I": "Inactive", "A": "Active" } },
                    editable: function (cell) { return cell.getRow().isSelected(); }
                }
            ],
        });
    }

    function CloseNewMasterSettingItem() {
        $("#AddMasterModal").hide();
    }

    function SaveNewMasterEntry() {
        var HeaderName = "";
        $.grep(gMasterSettingSelList, function (a) {
            if ($("#MasterCategorySelect").val() == a.Value) {
                HeaderName = a.Text;
            }
        });
        var SaveNewMasterEntrytype = $("#MasterCategorySelect").val();
        if (SaveNewMasterEntrytype == "S" || SaveNewMasterEntrytype == "") {
            ToastMsg("Please select a Category from the dropdown before adding new items.", "warning");
            return false;
        }
        if ($("#admClinic").val() == "") {
            ToastMsg("Please Select Clinic.", "warning");
            return false;
        }
        var Field3 = "1.00";
        if (SaveNewMasterEntrytype == "L") {
            if ($("#admAllergyType").val() == "") {
                ToastMsg("Please Select Allergy Type.", "warning");
                return false;
            }
            Field3 = $("#admAllergyType").val();
        }
        if (SaveNewMasterEntrytype == "F") {
            if ($("#admTabCount").val() == "") {
                ToastMsg("Please Enter Tablet Count.", "warning");
                return false;
            }
            Field3 = $("#admTabCount").val();
        }
        if ($("#admName").val() == "") {
            ToastMsg("Please Enter " + HeaderName + " in English", "warning");
            return false;
        }
        startLoading("Loading", "loading-NewMasterSetting");
        var urls = '../Clinicalnotes/AddLanguageEntry';
        var datatosend = {
            NAME: $("#admName").val(),
            strType: SaveNewMasterEntrytype,
            strHindi: $("#admHindi").val(),
            strMarathi: $("#admHindi").val(),
            strGujrati: $("#admGujrati").val(),
            Field3: Field3
        }
        $.ajax({
            type: "POST",
            data: datatosend,
            url: urls,
            async: true,
            dataType: "json",
            success: function (result) {
                stopLoading("loading-NewMasterSetting");
                if (result.toUpperCase().includes("SUCCESS")) {
                    ToastMsg(result, "success");
                    CloseNewMasterSettingItem();
                    GetMasterSettingReportData();
                }
                else {
                    ToastMsg(result, "error");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-NewMasterSetting");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function validateAgeRange() {
        var fromVal = $("#admFromAge").val();
        var toVal = $("#admToAge").val();
        function toDays(str) {
            var parts = str.split(":");
            if (parts.length !== 3) return NaN;
            var years = parseInt(parts[0], 10) || 0;
            var months = parseInt(parts[1], 10) || 0;
            var days = parseInt(parts[2], 10) || 0;
            return (years * 365) + (months * 30) + days;
        }
        var fromDays = toDays(fromVal);
        var toDays = toDays(toVal);
        if (isNaN(fromDays) || isNaN(toDays)) {
            ToastMsg("Invalid format", "warning");
            return false;
        }
        if (fromDays >= toDays) {
            ToastMsg("From Age must be less than To Age", "warning");
            return false;
        }
        return true;
    }

    function SaveUpdateAgeGrpNewMasterEntry() {
        var urls = '../Clinicalnotes/SaveAgeGrouop';
        var MasterSettingAgeGroupCode = "";
        if ($("#admAgeGrp").val() == "") {
            ToastMsg("Please Enter Age Group", "warning");
            return false;
        }
        if ($("#admSeqNo").val() == "") {
            ToastMsg("Please Enter Sequence Number", "warning");
            return false;
        }
        if ($("#admFromAge").val() == "") {
            ToastMsg("Please Enter From Age", "warning");
            return false;
        }
        if ($("#admToAge").val() == "") {
            ToastMsg("Please Enter To Age", "warning");
            return false;
        }
        if (validateAgeRange() == false)
            return false;
        if ($("#admAgeGrpCode").val() != undefined && $("#admAgeGrpCode").val() != null) {
            MasterSettingAgeGroupCode = $("#admAgeGrpCode").val();
        }
        var datatosend = {
            ageGrp: $("#admAgeGrp").val(),
            frmAge: $("#admFromAge").val(),
            toAge: $("#admToAge").val(),
            remark: $("#admRemark").val(),
            status: $("#cmbadmStatus").val(),
            seq: $("#admSeqNo").val(),
            AgeGroupCode: MasterSettingAgeGroupCode
        }
        startLoading("Loading", "loading-NewMasterSetting");
        $.ajax({
            type: "POST",
            data: datatosend,
            url: urls,
            async: true,
            dataType: "json",
            success: function (result) {
                stopLoading("loading-NewMasterSetting");
                if (result.toUpperCase().indexOf("SUCCESSFUL") != -1) {
                    if (MasterSettingAgeGroupCode != "")
                        ToastMsg("Age Group updated Successfully", "success");
                    else
                        ToastMsg("Age Group added Successfully", "success");
                    CloseNewMasterSettingItem();
                    GetMasterSettingReportData();
                }
                else {
                    ToastMsg(result, "error");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-NewMasterSetting");
                ToastMsg(textStatus, "error");
            }
        });
    }

</script>

<%-- Master Setup --%>
<script type="text/javascript">
    var MasterSetUpTranCode = "";
    var MasterSetupDataLists = {};
    var SetupNoFrMedTaper = 0;
    var MasterSetupRemarksArray = [];
    var MasterSetupRouteArray = [];
    var MasterSetupIntakeArray = [];
    var MasterSetupDaysArray = [];
    var MasterSetupDrugFormsArray = [];
    var MasterSetupDurationArray = [];
    var MasterSetupFoodArray = [];
    var MasterSetupListUrls = [
        { Id: "complaint", Title: "Complaint List", Url: "GetMainCompList" },
        { Id: "diagnosis", Title: "Diagnosis List", Url: "GetMainDiagnoList" },
        { Id: "investigation", Title: "Investigation List", Url: "GetInvestigationList" },
        { Id: "advice", Title: "Patient Advice List", Url: "GetPatAdvList" }
    ];
    if (gCIMSYN == "Y") {
        MasterSetupListUrls.push({ Id: "rx", Title: "Rx List", Url: "GetFregqentMaterialCIMS" });
    } else {
        MasterSetupListUrls.push({ Id: "rx", Title: "Rx List", Url: "GetFregqentMaterial" });
    }

    function LoadMasterSetupForm() {
        $("#mstName").val("");
        document.querySelectorAll('#mstGenderGroup .mst-gender-btn').forEach(btn => btn.classList.remove('active'));
        $("#mstAgeFrom").val("");
        $("#mstAgeTo").val("");
        $("#mstStatus").val("A");
        MasterSetupDataLists = {};
        SetupNoFrMedTaper = 0;
        MasterSetupload_Intake();
        LoadMasterSetupAllComboList();
        MasterSetupload_Days();
        MasterSetupload_DrugForms();
        MasterSetupload_Duration();
        MasterSetupload_Food();
        GetAllMasterSetUpValues();
        mstToggleSection('sec-complaint');
    }

    function GetAllMasterSetUpValues() {
        let completed = 0;
        for (let i = 0; i < MasterSetupListUrls.length; i++) {
            let MasterSetUpIndx = i;
            let kk = MasterSetupListUrls[i].Url.toString();
            let urlal = (kk == "GetMainCompList" || kk == "GetMainDiagnoList" || kk == "GetPatAdvList")
                ? "../DoctorDesk/" + kk + "?ClinicCode=" + gClinicCode
                : "../DoctorDesk/" + kk;
            startLoading("Loading", "loading-Master-Setting");
            $.ajax({
                type: "POST",
                url: urlal,
                data: {},
                async: true,
                success: function (response) {
                    completed++;
                    if (response && response !== "Unsucessfull" && response !== "UNSUCCESSFULL") {
                        let key = MasterSetupListUrls[MasterSetUpIndx].Id;
                        if (kk === "GetMainCompList") {
                            let data = JSON.parse(response);
                            let list = data.Table1.map(obj => ({
                                id: obj.CODE,
                                name: obj.NAME,
                                checked: false
                            }));
                            MasterSetupDataLists[key] = list;
                            mstRenderList(list, key);
                        }
                        else if (kk === "GetMainDiagnoList") {
                            let list = response.map(obj => ({
                                id: obj.DESCCD,
                                name: obj.DESC,
                                checked: obj.CHECK.toUpperCase() === 'TRUE'
                            }));
                            MasterSetupDataLists[key] = list;
                            mstRenderList(list, key);
                        }
                        else if (kk === "GetFregqentMaterial") {
                            let data = JSON.parse(response);
                            let list = data.Table.map(obj => ({
                                id: GeneralWiseYN == "Y" ? obj.GENERICID : obj.MTRLCODE,
                                name: GeneralWiseYN == "Y" ? obj.GENERICNAM : obj.MTRLNAME,
                                checked: false
                            }));
                            MasterSetupDataLists[key] = list;
                            mstRenderList(list, key);
                            mstLoadRxTable();
                        }
                        else if (kk === "GetFregqentMaterialCIMS") {
                            let data = JSON.parse(response);
                            let list = data.Table.map(obj => ({
                                id: GeneralWiseYN == "Y" ? obj.GENERICID : obj.MTRLCODE,
                                name: GeneralWiseYN == "Y" ? obj.GENERICNAM : obj.MTRLNAME,
                                checked: false
                            }));
                            MasterSetupDataLists[key] = list;
                            mstRenderList(list, key);
                            mstLoadRxTable();
                        }
                        else if (kk === "GetInvestigationList") {
                            let list = response.map(obj => ({
                                id: obj.TESTCODE,
                                name: obj.TESTNAME,
                                checked: false
                            }));
                            MasterSetupDataLists[key] = list;
                            mstRenderList(list, key);
                        }
                        else {
                            let list = response.map(obj => ({
                                id: obj.DESCCD,
                                name: obj.DESC,
                                checked: false
                            }));
                            MasterSetupDataLists[key] = list;
                            mstRenderList(list, key);
                        }
                    }
                    if (completed == MasterSetupListUrls.length) {
                        if (MasterSetUpTranCode != "")
                            BindMasterSetupSavedData(MasterSetUpTranCode);
                        else
                            stopLoading("loading-Master-Setting");
                    }
                },
                onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                    stopLoading("loading-Master-Setting");
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }

    function mstRenderList(DataList, key) {
        MasterSetupDataLists[key] = DataList;
        var container = $("#list-" + key);
        container.empty();
        DataList.forEach(item => {
            var checkedClass = item.checked ? 'checked-item' : '';
            var checkedAttr = item.checked ? 'checked' : '';
            var html = `
        <div class="mst-list-item ${checkedClass}">
            <input type="checkbox" class="mst-checkbox" data-id="${item.id}" ${checkedAttr}
        onchange="mstCheckItem('${key}', '${item.id}', this)">
 <span class="mst-item-text">${item.name}</span>
</div>
        `;
            container.append(html);
        });
    }

    function LoadMasterSetupAllComboList() {
        $.ajax({
            type: "GET",
            url: "../SinglePage/GetMasterSetupAllDetails",
            dataType: "json",
            async: true,
            success: function (data) {
                MasterSetupload_Route(data.Routes || []);
                MasterSetupload_Remarks(data.Remarks || [])
            },
            error: function (xhr, status, error) {

            }
        });
    }

    function MasterSetupload_Intake() {
        MasterSetupIntakeArray = [];
        $.ajax({
            url: '../DoctorDesk/GetMedicineInTake',
            type: 'get',
            dataType: 'json',
            async: false,
            success: function (response) {
                if (response !== "Unsucessfull") {
                    var IntakeREsult = JSON.parse(response);
                    MasterSetupIntakeArray.push({ label: "--select--", value: "" });
                    for (let i = 0; i < IntakeREsult.Intake.length; i++) {
                        MasterSetupIntakeArray.push({
                            label: IntakeREsult.Intake[i].INTAKE,
                            value: IntakeREsult.Intake[i].CODE
                        });
                    }
                }
            }
        });
    }

    function MasterSetupload_Days() {
        MasterSetupDaysArray = [{ label: "--select--", value: "" }];
        for (let i = 0; i <= 30; i++) {
            MasterSetupDaysArray.push({ label: i.toString(), value: i.toString() });
        }
    }

    function MasterSetupload_DrugForms() {
        MasterSetupDrugFormsArray = [
            "BILAYER CO", "CAP", "CHEWABLE T", "COATED TAB", "CREAM", "DISPERTAB", "DR TAB", "EAR DROPS", "ENTERIC-CO", "ER CAP",
            "ER TAB", "EXTENTAB", "EYE DROPS", "EYE/EAR DR", "FILM-COATE", "GRANULES F", "INHALATION", "INJ", "MDI", "MODIFIED-R", "NASAL DROP",
            "NASAL SPRA", "OINT", "ORAL EMULS", "ORAL LIQD", "ORAL SOLN", "ORAL SUSP", "PENFILL", "POWD FOR I", "POWD FOR O",
            "PRE-FILLED", "SOFT-GELAT", "SOFTGEL", "SR CAP", "SR COATED", "SR TAB", "SR-FC TAB", "SUSP FOR I", "SYR", "TAB", "TOPICAL GE", "VAG SUPP"
        ];
    }

    function MasterSetupload_Duration() {
        MasterSetupDurationArray = [
            { label: "--select--", value: "" },
            { label: "Days", value: "Days" },
            { label: "Weeks", value: "Weeks" },
            { label: "Months", value: "Months" },
            { label: "Years", value: "Years" }
        ];
    }

    function MasterSetupload_Food() {
        MasterSetupFoodArray = [
            { label: "--select--", value: "" },
            { label: "After", value: "After" },
            { label: "Before", value: "Before" }
        ];
    }

    function MasterSetupload_Route(RouteArray) {
        MasterSetupRouteArray = [{ label: "--select--", value: "" }];
        if (RouteArray && RouteArray.length) {
            for (let i = 0; i < RouteArray.length; i++) {
                MasterSetupRouteArray.push({ label: RouteArray[i].Text, value: RouteArray[i].Value });
            }
        }
    }

    function MasterSetupload_Remarks(RemarkArray) {
        MasterSetupRemarksArray = [{ label: " ", value: "" }];
        if (RemarkArray && RemarkArray.length) {
            for (let i = 0; i < RemarkArray.length; i++) {
                MasterSetupRemarksArray.push({ label: RemarkArray[i].Text, value: RemarkArray[i].Value });
            }
        }
    }

    function MasterSetupCancelImg(cell) {
        return '<span class="ui-icon ui-icon-cancel">Remove</span>';
    }

    function MasterSetupAddNewFrequencyRemark(Type) {
        $("#MstGenericAddModal").empty();
        var title = "Add New " + Type;
        $("#mstAddModalTitle").text(title);
        $("#mstNewItemName").val("");
        let saveFn;
        if (Type === "Remark") {
            saveFn = "MasterSetupAddNewRemark";
        } else {
            saveFn = "MasterSetupAddNewFrequency";
        }
        var ContentAppend = `
         <div class="adm-modal-box">
            <div class="adm-header">
                <span id="mstAddModalTitle">${title}</span>
                <button class="adm-close-btn" onclick="mstCloseGenericModal()">×</button>
            </div>
            <div class="adm-body">
                <div class="adm-form-group">
                    <label class="adm-label">Enter Name</label>
                    <input type="text" id="mstNewItemName" class="adm-input" placeholder="Enter here..." />
                </div>
            </div>
            <div class="adm-footer">
                <button class="adm-btn-cancel" onclick="mstCloseGenericModal()">Cancel</button>
                <button class="adm-btn-save" onclick="${saveFn}()">Save</button>
            </div>
         </div>
        `;
        $("#MstGenericAddModal").append(ContentAppend);
        $("#MstGenericAddModal").appendTo("body").css("display", "flex");
        $("#mstNewItemName").focus();
    }

    function MasterSetupAddNewFrequency() {
        if ($("#mstNewItemName").val() == "") {
            ToastMsg("Enter Frequency.", "warning")
            return false;
        }
        var intake = $("#mstNewItemName").val();
        $.ajax({
            url: '../DoctorDesk/saveMedIntkCombintn',
            type: 'post',
            datatype: 'json',
            data: { strMedIntkComb: intake },
            success: function (response) {
                if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                    ToastMsg("Intake added successfully.", "success");
                    MasterSetupload_Intake();
                    window.rxTable.updateColumnDefinition("INTAKE", {
                        editorParams: { values: MasterSetupIntakeArray }
                    });
                    mstCloseGenericModal();
                }
                else {
                    ToastMsg(response, "warning");
                }
            }
        });
    }

    function MasterSetupAddNewRemark() {
        if ($("#mstNewItemName").val() == "") {
            ToastMsg("Enter Remark.", "warning")
            return false;
        }
        var NewRemark = $('#mstNewItemName').val();
        $.ajax({
            type: "post",
            datatype: "json",
            async: true,
            url: '../DoctorDesk/saveIntakeRemark',
            data: { strNewRemark: NewRemark, },
            success: function (response) {
                if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                    ToastMsg("Remark added successfully.", "success");
                    MasterSetupload_Remarks();
                    window.rxTable.updateColumnDefinition("REMARK", {
                        editorParams: { values: MasterSetupRemarksArray }
                    });
                    mstCloseGenericModal();
                }
                else {
                    ToastMsg(response, "warning");
                }
            },
        });
    }

    function mstLoadRxTable() {
        const containerId = "#mst-rx-grid";
        if (!document.querySelector(containerId)) return;
        if (window.rxTable) {
            window.rxTable.destroy();
        }

        window.rxTable = new Tabulator(containerId, {
            index: "CODE",
            layout: "fitColumns",
            height: 200,
            width: 870,
            data: [],
            columns: [
                {
                    title: "", field: "act", width: 25, formatter: MasterSetupCancelImg,
                    cellClick: function (e, cell) {
                        let rowData = cell.getRow().getData();
                        let code = rowData.CODE;
                        rxTable.deleteRow(cell.getRow());
                        $(`.mst-checkbox[data-id="'${code}'"]`).prop("checked", false);
                        let list = MasterSetupDataLists["rx"] || [];
                        let item = list.find(x => x.id === code);
                        if (item) { item.checked = false; }
                        mstRenderList(MasterSetupDataLists["rx"], "rx");
                    }
                },
                { title: "Code", field: "CODE", visible: false },
                { title: "Medicine Name", field: "NAME", width: 300, visible: GeneralWiseYN == "Y" ? false : true },
                { title: "Generic Name", field: "GENERICNAM", width: 170, visible: GeneralWiseYN == "Y" ? true : false },
                { title: "Dose", field: "DOSAGE", width: 80, editor: "input" },
                {
                    title: "Frequency",
                    field: "INTAKE",
                    editor: "list",
                    width: 150,
                    editorParams: {
                        values: MasterSetupIntakeArray,
                        autocomplete: true,
                        freetext: false,
                        clearable: true
                    },
                    formatter: function (cell) {
                        let val = cell.getValue();
                        let opts = MasterSetupIntakeArray;
                        let found = opts.find(o => o.value === val);
                        return found ? found.label : val;
                    },
                    titleFormatter: function () {
                        return `<span class="mst-col-plus" onclick="event.stopPropagation(); MasterSetupAddNewFrequencyRemark('Frequency')">+</span> Frequency`;
                    }
                },
                { title: "Intake Calculated", field: "INTAKECALC", width: 100, visible: false },
                {
                    title: "Days", field: "DAYS", width: 100, editor: "list", editorParams: {
                        values: MasterSetupDaysArray,
                        autocomplete: true,
                        freetext: false,
                        clearable: true
                    },
                    formatter: function (cell) {
                        let val = cell.getValue();
                        let opts = MasterSetupDaysArray;
                        let found = opts.find(o => o.value === val);
                        return found ? found.label : val;
                    }
                },
                {
                    title: "Duration", field: "DURATION", width: 100, editor: "list", editorParams: {
                        values: MasterSetupDurationArray,
                        autocomplete: true,
                        freetext: false,
                        clearable: true
                    },
                    formatter: function (cell) {
                        let val = cell.getValue();
                        let opts = MasterSetupDurationArray;
                        let found = opts.find(o => o.value === val);
                        return found ? found.label : val;
                    }
                },
                {
                    title: "Food", field: "FOOD", width: 80, editor: "list", editorParams: {
                        values: MasterSetupFoodArray,
                        autocomplete: true,
                        freetext: false,
                        clearable: true
                    },
                    formatter: function (cell) {
                        let val = cell.getValue();
                        let opts = MasterSetupFoodArray;
                        let found = opts.find(o => o.value === val);
                        return found ? found.label : val;
                    }
                },
                {
                    title: "Route", field: "ROUTE", width: 150, editor: "list", editorParams: {
                        values: MasterSetupRouteArray,
                        autocomplete: true,
                        freetext: false,
                        clearable: true
                    },
                    formatter: function (cell) {
                        let val = cell.getValue();
                        let opts = MasterSetupRouteArray;
                        let found = opts.find(o => o.value === val);
                        return found ? found.label : val;
                    }
                },
                {
                    title: "Remark", field: "REMARK", width: 150, editor: "list", editorParams: {
                        values: MasterSetupRemarksArray,
                        autocomplete: true,
                        freetext: false,
                        clearable: true
                    },
                    formatter: function (cell) {
                        let val = cell.getValue();
                        let opts = MasterSetupRemarksArray;
                        let found = opts.find(o => o.value === val);
                        return found ? found.label : val;
                    },
                    titleFormatter: function () {
                        return `<span class="mst-col-plus" onclick="event.stopPropagation(); MasterSetupAddNewFrequencyRemark('Remark')">+</span>  Remark`;
                    }
                },
                { title: "Generic Id", field: "GENERICID", width: 120, visible: false },
                {
                    title: "Drug Form", field: "DRUGFORM", width: 150, editor: "list", editorParams: {
                        values: MasterSetupDrugFormsArray
                    },
                    formatter: function (cell) {
                        let val = cell.getValue();
                        let opts = MasterSetupDrugFormsArray;
                        let found = opts.find(o => o.value === val);
                        return found ? found.label : val;
                    }
                }
            ],
            cellEdited: function (cell) {
                console.log("Cell edited:", cell.getField(), cell.getValue());
            }
        });
    }

    function mstCheckItem(key, id, checkbox) {
        let list = MasterSetupDataLists[key] || [];
        let item = list.find(x => x.id === id);
        if (item) item.checked = checkbox.checked;

        MasterSetupDataLists[key] = [
            ...list.filter(x => x.checked),
            ...list.filter(x => !x.checked)
        ];

        mstRenderList(MasterSetupDataLists[key], key);

        if (key === "rx" && window.rxTable) {
            if (checkbox.checked) {
                let newRow = {
                    act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                    CODE: item.id,
                    NAME: item.name,
                    GENERICNAM: item.name,
                    DOSAGE: "",
                    INTAKE: "",
                    INTAKECALC: "",
                    DAYS: "",
                    DURATION: "",
                    FOOD: "",
                    ROUTE: "",
                    REMARK: "",
                    GENERICID: item.id,
                    DRUGFORM: ""
                };
                window.rxTable.addRow(newRow, "top");
            } else {
                window.rxTable.deleteRow(id);
            }
        }
    }

    function mstGetCheckedCodes(key) {
        let codes = [];
        let names = [];
        $("#list-" + key + " .mst-checkbox:checked").each(function () {
            let code = $(this).data("id");
            if (code) {
                codes.push(code);
            }
        });
        return codes;
    }

    function mstToggleSection(id) {
        $("#" + id).toggleClass("active");
    }

    function GetMasterSetupHtml() {
        let sectionsHtml = MasterSetupListUrls.map(item => {
            return MasterSetupSectionHTML(item.Title, item.Id);
        }).join("\n");
        return `
    <div class="mst-wrapper">
        <div class="mst-top-bar">
            <div class="mst-form-group">
                <label class="mst-label">Name:</label>
                <input type="text" id="mstName" class="mst-input" style="width:150px;">
            </div>
            <div class="mst-form-group">
                <label class="mst-label">Gender:</label>
                <div class="mst-gender-group" id="mstGenderGroup">
                    <button class="mst-gender-btn active" onclick="mstToggleGender(this)" data-val="M">Male</button>
                    <button class="mst-gender-btn" onclick="mstToggleGender(this)" data-val="F">Female</button>
                    <button class="mst-gender-btn" onclick="mstToggleGender(this)" data-val="B">Both</button>
                </div>
            </div>
            <div class="mst-form-group">
                <label class="mst-label">Age:</label>
                <span style="font-size:13px">From</span>
                <input type="number" id="mstAgeFrom" class="mst-input mst-input-sm">
                <span style="font-size:13px">To</span>
                <input type="number" id="mstAgeTo" class="mst-input mst-input-sm">
            </div>
            <div class="mst-form-group">
                <label class="mst-label">Status:</label>
                <select id="mstStatus" class="mst-input">
                    <option value="A">Active</option>
                    <option value="I">Inactive</option>
                </select>
            </div>
            <div class="mst-form-group" style="margin-left: auto;">
             <button class="mst-New-btn" onclick="LoadMasterSetupForm()">
                 <i class="fa fa-eraser"></i> Clear
             </button>
             <button class="mst-List-btn" onclick="OpenSavedListMasterSetup()">
                 <i class="fa fa-list"></i> List
             </button>
             <button class="mst-save-btn" onclick="SaveAllMasterSetUp()">
                 <i class="fa fa-save"></i> Save Data
             </button>
            </div>
        </div>
    ${sectionsHtml}
    </div>
              `;
    }

    function MasterSetupSectionHTML(title, key) {
        const isRx = key === "rx";
        const sectionId = `sec-${key}`;
        const listId = `list-${key}`;
        const searchPlaceholder = isRx ? "Search in RxData List" : `Search in ${title}`;
        const headerTitle = isRx ? "RxData List" : title;
        return `
        <div class="mst-section" id="${sectionId}">
            <div class="mst-header" onclick="mstToggleSection('${sectionId}')">
                <span>${headerTitle}</span>
                <div class="mst-header-tools">
                    <span class="mst-icon-btn" onclick="event.stopPropagation(); mstAddItem('${key}')" ${isRx ? "" : 'title="Add New"'}>+</span>
                    <span class="mst-icon-btn">▼</span>
                </div>
            </div>
            <div class="mst-body">
                <div class="mst-search-box">
                    <span class="mst-clear-link" onclick="mstClearSelection('${key}')">ClearSelection</span>
                    <input type="text" class="mst-search-input" placeholder="${searchPlaceholder}" onkeyup="mstFilterList('${key}', this.value)">
                </div>
                <div class="mst-list-container" id="${listId}"></div>
        ${isRx ? `<div id="mst-rx-grid"></div>` : ""}
    </div>
</div>
`;
    }

    function mstClearSelection(key) {
        $("#list-" + key + " .mst-checkbox").prop("checked", false);
        $("#list-" + key + " .mst-list-item").removeClass("checked-item");
        $("#sec-" + key + " .mst-search-input").val("");
        $("#list-" + key + " .mst-list-item").show();
        if (key === "rx") {
            mstLoadRxTable();
        }
    }

    function mstFilterList(key, searchText) {
        searchText = searchText.toLowerCase();
        $("#list-" + key + " .mst-list-item").each(function () {
            var itemText = $(this).find(".mst-item-text").text().toLowerCase();
            if (itemText.indexOf(searchText) > -1) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }

    function mstToggleGender(btn) {
        $(".mst-gender-btn").removeClass("active");
        $(btn).addClass("active");
    }

    function mstAddItem(key) {
        $("#MstGenericAddModal").empty();
        var title = "Add New " + key.charAt(0).toUpperCase() + key.slice(1);
        $("#mstAddModalTitle").text(title);
        $("#mstNewItemName").val("");

        var ContentAppend = `
            <div class="adm-modal-box">
                <div class="adm-header">
                    <span id="mstAddModalTitle">${title}</span>
                    <button class="adm-close-btn" onclick="mstCloseGenericModal()">×</button>
                </div>
                <div class="adm-body">
                    <div class="adm-form-group">
                        <label class="adm-label">Enter Name</label>
                        <input type="text" id="mstNewItemName" class="adm-input" placeholder="Enter here..." />
                    </div>
                </div>
                <div class="adm-footer">
                    <button class="adm-btn-cancel" onclick="mstCloseGenericModal()">Cancel</button>
                    <button class="adm-btn-save" onclick="mstSaveGenericItem('${key}', '${title}')">Save</button>
                </div>
            </div>
        `;
        $("#MstGenericAddModal").append(ContentAppend);
        $("#MstGenericAddModal").appendTo("body").css("display", "flex");
        $("#mstNewItemName").focus();
    }

    function mstCloseGenericModal() {
        $("#MstGenericAddModal").hide().empty();
    }

    function mstSaveGenericItem(key, title) {
        var newName = $("#mstNewItemName").val().trim();
        if (!newName) {
            ToastMsg("Enter New " + title, "warning");
            return false;
        }
        $('#mstNewItemName').css({ 'border-color': '' });
        var exists = false;
        $("#list-" + key + " .mst-item-text").each(function () {
            if ($(this).text().trim().toLowerCase() === newName.toLowerCase()) {
                exists = true;
                return false;
            }
        });
        if (exists) {
            ToastMsg("Item already exists in " + key + " list", "warning")
            return false;
        }
        SetupNoFrMedTaper = SetupNoFrMedTaper + 1;
        var newCode = "NEW" + SetupNoFrMedTaper;
        var newItem = {
            id: newCode,
            name: newName,
            checked: true
        };
        var container = $("#list-" + key);
        var html = `
            <div class="mst-list-item checked-item">
                <input type="checkbox" class="mst-checkbox" data-id="${newItem.id}" checked
            onchange="mstCheckItem('${key}', '${newItem.id}', this)">
     <span class="mst-item-text">${newItem.name}</span>
 </div>
        `;
        container.prepend(html);
        if (key === "rx") {
            let newRow = {
                act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                CODE: newItem.id,
                NAME: newItem.name,
                GENERICNAM: newItem.name,
                DOSAGE: "",
                INTAKE: "",
                INTAKECALC: "",
                DAYS: "",
                DURATION: "",
                FOOD: "",
                ROUTE: "",
                REMARK: "",
                GENERICID: newItem.id,
                DRUGFORM: ""
            };
            window.rxTable.addRow(newRow, "bottom");
        }
        mstCloseGenericModal();
    }

    function SaveAllMasterSetUp() {
        var flag = 0;
        if ($("#mstName").val() == '') {
            ToastMsg("Please Enter Name.", "warning");
            return false;
        }
        if ($("#mstGenderGroup .mst-gender-btn.active").data("val") == '' || $("#mstGenderGroup .mst-gender-btn.active").data("val") == null || $("#mstGenderGroup .mst-gender-btn.active").data("val") == undefined) {
            ToastMsg("Please Select Gender.", "warning");
            return false;
        }
        if ($("#mstAgeFrom").val() == '' || $("#mstAgeTo").val() == '') {
            if ($("#mstAgeFrom").val() == '') {
                ToastMsg("Please Enter From Age.", "warning");
                return false;
            }
            if ($("#mstAgeTo").val() == '') {
                ToastMsg("Please Enter To Age.", "warning");
                return false;
            }
        } else {
            if ((Number($("#mstAgeTo").val()) < Number($("#mstAgeFrom").val()))) {
                ToastMsg("Age To must be greater than Age From.", "warning");
                $("#mstAgeFrom").val('');
                $("#mstAgeTo").val('');
                return false;
            }
        }
        var MasterSetupstrComplaints = '', MasterSetupstrDiagnosis = '', MasterSetupstrRxdata = '', MasterSetupstrInvestigtn = '', MasterSetupstrPatadv = '';
        var MasterSetupstrComplaintsTitle = '', MasterSetupstrDiagnosisTitle = '', MasterSetupstrRxdataTitle = '', MasterSetupstrInvestigtnTitle = '', MasterSetupstrPatadvTitle = '';
        var MasterSetupSaveArray = [];
        var MasterSetupServiceData = "";

        for (i = 0; i < MasterSetupListUrls.length; i++) {
            var key = MasterSetupListUrls[i].Id;
            var MasterSetupcodes = [];
            var MasterSetupnames = [];
            $("#list-" + key + " .mst-checkbox:checked").each(function () {
                let MasterSetupcode = $(this).data("id");
                let MasterSetupname = $(this).siblings(".mst-item-text").text().trim();
                if (MasterSetupcode) {
                    MasterSetupcodes.push(MasterSetupcode);
                    MasterSetupnames.push(MasterSetupname);
                }
            });
            if (MasterSetupListUrls[i].Url == "GetMainCompList") {
                MasterSetupstrComplaints = MasterSetupcodes.join(",");
                MasterSetupstrComplaintsTitle = MasterSetupnames.join(",");
            }
            if (MasterSetupListUrls[i].Url == "GetMainDiagnoList") {
                MasterSetupstrDiagnosis = MasterSetupcodes.join(",");
                MasterSetupstrDiagnosisTitle = MasterSetupnames.join(",");
            }
            else if (MasterSetupListUrls[i].Url == "GetFregqentMaterial" || MasterSetupListUrls[i].Url == "GetFregqentMaterialCIMS") {
                MasterSetupstrRxdata = MasterSetupcodes.join(",");
                MasterSetupstrRxdataTitle = MasterSetupnames.join(",");

                // Get all row data from Tabulator
                let myDataWithIds = window.rxTable.getData().map(row => {
                    let DRUGNM = row.NAME ? row.NAME.replace(
                        '<span class="fa fa-info-circle fa-1x medInfoSpan FromGrid" title="Medicine info" style="color:#4086bf"></span>',
                        ""
                    ).trim() : "";
                    let DAYS = (row.DAYS && row.DAYS !== "--select--") ? row.DAYS : "";
                    let DURATION = (row.DURATION && row.DURATION !== "--select--") ? row.DURATION : "";
                    if (DURATION === "STAT") DURATION = "T";
                    let ABFOOD = "";
                    if (row.FOOD && row.FOOD !== "--select--") {
                        ABFOOD = row.FOOD.startsWith("B") ? "E" :
                            row.FOOD.startsWith("A") ? "A" : "";
                    }
                    let INTAKEDESC = (row.INTAKE && row.INTAKE !== "--select--") ? row.INTAKE : "";
                    let INTAKECD = (row.INTAKE && row.INTAKE !== "--select--") ? row.INTAKE : "";
                    let SOSYN = (row.DURATION && row.DURATION.startsWith("S")) ? "Y" : "N";
                    return {
                        DRUGNM: DRUGNM,
                        DOSSAGE: row.DOSAGE || "",
                        DAYS: DAYS,
                        Remarks: row.REMARK || "",
                        ROUTE: row.ROUTE || "",
                        GENERICID: row.GENERICID || "",
                        GENERICNAME: row.GENERICNAM || "",
                        DRUGCD: row.CODE || "",
                        DRUGFORM: row.DRUGFORM || "",
                        SOSYN: SOSYN,
                        DURATION: DURATION,
                        ABFOOD: ABFOOD,
                        INTAKEDESC: INTAKEDESC,
                        INTAKECD: INTAKECD
                    };
                });
                var servData = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC == "" || e.INTAKEDESC == "--select--") });
                var servicedt = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC != "" || e.INTAKEDESC != "--select--") });
                var servDossage = $.grep(myDataWithIds, function (e) { return (e.DOSSAGE == "" || e.DOSSAGE == null) });//
                var servRoute = $.grep(myDataWithIds, function (e) { return (e.ROUTE == "" || e.ROUTE == null) });//
                var servDrugForm = $.grep(myDataWithIds, function (e) { return (e.DRUGFORM == "" || e.DRUGFORM == null) });//
                MasterSetupServiceData = (JSON.stringify(servicedt));
                if (servData.length > 0) {
                    ToastMsg("Please select frequency for all medicines.", "warning");
                    return false;
                }
                if (servDossage.length > 0) {
                    if (DoseMandatoryYN == "Y") {
                        ToastMsg("Please select Dossage for all medicines.", "warning");
                        return false;
                    }
                }
                if (servRoute.length > 0) {
                    ToastMsg("Please select Route for all medicines.", "warning");
                    return false;
                }
                if (servDrugForm.length > 0) {
                    ToastMsg("Please select Drug Form for all medicines.", "warning");
                    return false;
                }
                else {
                    var emptyDays = $.grep(myDataWithIds, function (e) { return ((e.DAYS == "" || e.DAYS == "--select--") && e.INTAKEDESC != "SOS" && e.INTAKEDESC != "STAT" && e.INTAKEDESC != "CONTD.") });
                    var emptyDuration = $.grep(myDataWithIds, function (e) { return ((e.DURATION == "" || e.DURATION == "--select--") && e.INTAKEDESC != "SOS" && e.INTAKEDESC != "STAT" && e.INTAKEDESC != "CONTD.") });
                    if (emptyDays.length > 0 || emptyDuration.length > 0) {
                        ToastMsg("Please select duration for all medicines.", "warning");
                        return false;
                    }
                }
            }
            else if (MasterSetupListUrls[i].Url == "GetInvestigationList") {
                MasterSetupstrInvestigtn = MasterSetupcodes.join(",");
                MasterSetupstrInvestigtnTitle = MasterSetupnames.join(",");
            }
            else if (MasterSetupListUrls[i].Url == "GetPatAdvList") {
                MasterSetupstrPatadv = MasterSetupcodes.join(",");
                MasterSetupstrPatadvTitle = MasterSetupnames.join(",");
            }
        }

        if (MasterSetupstrComplaints == '' && MasterSetupstrDiagnosis == '' && MasterSetupstrRxdata == '' && MasterSetupstrInvestigtn == '' && MasterSetupstrPatadv == '') {
            ToastMsg("Select atleast one list data.", "warning");
            return false;
        }

        var MasterSetupDataToSend = {
            masterSetup: $("#mstName").val(),
            Gender: $("#mstGenderGroup .mst-gender-btn.active").data("val"),
            AgeF: $("#mstAgeFrom").val(),
            AgeT: $("#mstAgeTo").val(),
            strComplaints: MasterSetupstrComplaints,
            strDiagnosis: MasterSetupstrDiagnosis,
            strRxdata: MasterSetupServiceData.toString(),
            strInvestigtn: MasterSetupstrInvestigtn,
            strPatadv: MasterSetupstrPatadv,
            strComplaintsTitle: MasterSetupstrComplaintsTitle,
            strDiagnosisTitle: MasterSetupstrDiagnosisTitle,
            strInvestigtnTitle: MasterSetupstrInvestigtnTitle,
            strPatadvTitle: MasterSetupstrPatadvTitle,
            setUpCode: MasterSetUpTranCode,
            status: $("#mstStatus").val()
        }

        $.ajax({
            type: "post",
            datatype: "json",
            url: '../Clinicalnotes/AddMasterSetUp',
            data: MasterSetupDataToSend,
            success: function (response) {
                if (("" + response).toUpperCase().indexOf("INSERTED") != -1) {
                    LoadMasterSetupForm()
                    ToastMsg("Record inserted successfully", "success");
                }
                else if (("" + response).toUpperCase().indexOf("UPDATED") != -1) {
                    LoadMasterSetupForm()
                    ToastMsg("Record Updated successfully", "success");
                }
                else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {
                    ToastMsg("This Set Up is already Present.", "warning");
                }
                else {
                    ToastMsg("Error!!Please Contact IT Dept.", "error");
                }
            }
        });
    }

    function GetMasterSetupListHtml() {
        return `
        <div id="MasterSetupListTable"></div>
        `;
    }

    function OpenSavedListMasterSetup() {
        OpenSettingPopup("Master Setup List", "MasterSetupList", false);
        $("#Hist_C_MasterSetupList").append("<div id='loading-Master-Setup-List' class='loading-screen' style='display: none; opacity: 0;'></div>");
        GetSavedListMasterSetup();
    }

    function GetSavedListMasterSetup() {
        startLoading("Loading", "loading-Master-Setup-List");
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetMasterSetUpList",
            data: { strAge: "", strCimsYN: gCIMSYN },
            async: true,
            success: function (response) {
                var result = [];
                if (response != "" && response.toUpperCase() != "UNSUCCESSFULL") {
                    result = JSON.parse(response)
                    result = result.Table1;
                }
                MasterSetupListGrid(result);
                stopLoading("loading-Master-Setup-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Master-Setup-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function BindMasterSetupSavedData(MasterSetupCode) {
        $.ajax({
            url: "../Clinicalnotes/GetMasterSetUpData",
            datatype: "json",
            type: "get",
            async: true,
            data: { strSetUpCode: MasterSetupCode },
            success: function (response) {
                if (response[0] != null) {
                    $("#mstName").val(response[0][0].NAME);
                    $("#mstSetupCode").val(MasterSetUpTranCode); 
                    $("#mstGenderGroup .mst-gender-btn[data-val='" + response[0][0].Gender + "']").addClass("active");
                    $("#mstAgeFrom").val(response[0][0].FromAge);
                    $("#mstAgeTo").val(response[0][0].ToAge);
                    $("#mstStatus").val(response[0][0].STATUS);
                }

                if (response[1] != null) {
                    for (i = 0; i < response[1].length; i++) {
                        var newRow = {
                            SETUPCODE: response[1][i].SETUPCODE.toString().trim(),
                            CODE: response[1][i].CODE.toString().trim(),
                            NAME: response[1][i].NAME.toString().trim(),
                            INTAKE: response[1][i].INTAKE.toString().trim(),
                            DAYS: response[1][i].DAYS.toString().trim(),
                            DURATION: response[1][i].DURATION.toString().trim(),
                            FOOD: response[1][i].FOOD.toString().trim(),
                            DOSAGE: response[1][i].DOSAGE.toString().trim(),
                            REMARK: response[1][i].REMARK.toString().trim(),
                            GENERICID: response[1][i].GENERICID.toString().trim(),
                            GENERICNAM: response[1][i].GENERICNAM.toString().trim(),
                            DRUGFORM: response[1][i].DRUGFORM.toString().trim(),
                            ROUTE: response[1][i].ROUTE.toString().trim(),
                        };
                        if (window.rxTable) {
                            window.rxTable.addRow(newRow, "bottom").then(function (row) {
                                let data = row.getData();
                                if (!data.DRUGFORM) {
                                    row.update({ DRUGFORM: "" });
                                    row.getCell("DRUGFORM").getElement().classList.add("editable-cell");
                                } else {
                                    row.getCell("DRUGFORM").getElement().classList.add("not-editable-cell");
                                    if (["TAB", "SYP", "CAP", "FILM-COATE"].includes(data.DRUGFORM)) {
                                        row.update({ ROUTE: "09" });
                                    } else if (["INJ", "IV", "CAP"].includes(data.DRUGFORM)) {
                                        row.update({ ROUTE: "02" });
                                    }
                                }
                            });
                        }
                    }
                    $.each(response[1], function (i, item) {
                        var medCode = item.CODE;
                        $("#list-rx .mst-checkbox[data-id='" + medCode + "']").prop("checked", true);
                    })
                    MasterSetupreorderCheckedItems("list-rx");
                }

                if (response[2] != null) {
                    $.each(response[2], function (i, item) {
                        var invstCd = item.TESTCODE;
                        $("#list-investigation .mst-checkbox[data-id='" + invstCd + "']").prop("checked", true)
                    });
                    MasterSetupreorderCheckedItems("list-investigation");
                }

                if (response[3] != null) {
                    $.each(response[3], function (i, item) {
                        var patAdvCd = item.PATADVICECODE;
                        $("#list-advice .mst-checkbox[data-id='" + patAdvCd + "']").prop("checked", true)
                    });
                    MasterSetupreorderCheckedItems("list-advice");
                }

                if (response[4] != null) {
                    $.each(response[4], function (i, item) {
                        var dignoCode = item.DIAGNCD;
                        $("#list-diagnosis .mst-checkbox[data-id='" + dignoCode + "']").prop("checked", true)
                    });
                    MasterSetupreorderCheckedItems("list-diagnosis");
                }

                if (response[5] != null) {
                    $.each(response[5], function (i, item) {
                        var cmplntCode = item.CMPLNTCODE;
                        $("#list-complaint .mst-checkbox[data-id='" + cmplntCode + "']").prop("checked", true)
                    });
                    MasterSetupreorderCheckedItems("list-complaint");
                }
                stopLoading("loading-Master-Setup-List");
                stopLoading("loading-Master-Setting");
                closeMaxMinPopup('Hist_M_MasterSetupList');
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Master-Setup-List");
                stopLoading("loading-Master-Setting");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function MasterSetupreorderCheckedItems(MainDivIds) {
        let $list = $("#" + MainDivIds);
        let $items = $list.children(".mst-list-item");
        $items.sort(function (a, b) {
            let aChecked = $(a).find(".mst-checkbox").prop("checked");
            let bChecked = $(b).find(".mst-checkbox").prop("checked");
            return (aChecked === bChecked) ? 0 : aChecked ? -1 : 1;
        });
        $list.html($items);
    }

    function MasterSetupListGrid(DataMasterSetupListTable) {
        var table = new Tabulator("#MasterSetupListTable", {
            data: DataMasterSetupListTable,
            height: "350px",
            layout: "fitColumns",
            rowFormatter: function (row) {
                var data = row.getData();
                if (data.STATUS === "I") {
                    row.getElement().classList.add("CancelClass");
                }
            },
            columns: [
                { title: "CODE", field: "CODE", headerFilter: "input", editor: false, visible: false, tooltip: true },
                { title: "Name", field: "NAME", headerFilter: "input", tooltip: true, editable: false },
                {
                    title: "Gender",
                    field: "GENDER",
                    editor: "list",
                    tooltip: true,
                    editorParams: { values: { "M": "Male", "F": "Female", "B": "Both" } },
                    formatter: "lookup",
                    formatterParams: { "M": "Male", "F": "Female", "B": "Both" },
                    headerFilter: "list",
                    headerFilterParams: { values: { "": "All", "M": "Male", "F": "Female", "B": "Both" } },
                    editable: false
                },
                {
                    title: "Age",
                    field: "AGE",
                    headerFilter: "input",
                    tooltip: true,
                    editable: false,
                    formatter: function (cell) {
                        let data = cell.getRow().getData();
                        let fromAge = data.FROMAGE || "";
                        let toAge = data.TOAGE || "";
                        return fromAge && toAge ? `${fromAge} - ${toAge}` : fromAge || toAge || "";
                    }
                },
                { title: "Created By", field: "CREATEDBY", headerFilter: "input", editor: false, tooltip: true },
                {
                    title: "Status",
                    field: "STATUS",
                    editor: "list",
                    tooltip: true,
                    editorParams: { values: { "I": "Inactive", "A": "Active" } },
                    formatter: "lookup",
                    formatterParams: { "I": "Inactive", "A": "Active" },
                    headerFilter: "list",
                    headerFilterParams: { values: { "": "All", "I": "Inactive", "A": "Active" } },
                    editable: false
                }
            ]
        });
        table.on("rowDblClick", function (e, row) {
            startLoading("Loading", "loading-Master-Setup-List");
            var MasterSetupCode = row._row.data.CODE;
            MasterSetUpTranCode = MasterSetupCode;
            $("#Hist_C_MasterSetup").empty();
            $("#Hist_C_MasterSetup").append(`<div id="loading-Master-Setting" class="loading-screen" style="display: none; opacity: 0;"></div>`);
            $("#Hist_C_MasterSetup").append(GetMasterSetupHtml());
            $("#mstSetupCode").val(MasterSetupCode);
            LoadMasterSetupForm();
        });
    }

</script>

<%-- Signature --%>
<script type="text/javascript">
    function GetUploadSignatureBlock(no) {
        return `
        <div class="signatory-card">
            <div class="signatory-title">Digital Signature ${no}</div>
            <div class="signature-row">
                <div class="signature-preview">
                    <img id="imgUploadSign${no}" class="signatory-preview-img" style="display:none;" />
                    <span id="lblPrev${no}" style="font-size:12px;color:#999;">No Image</span>
                </div>
                <div class="signature-upload">
                    <input type="file"
        id="fuSign${no}"
        accept="image/*"
        onchange="validateAndPreviewSignatory(
        this,
        'imgUploadSign${no}',
        'lblPrev${no}',
        'errSign${no}'
                                   )" />
        <button type="button"
                                    class="btn-remove-file"
                                    onclick="clearImage(
        'fuSign${no}',
        'imgUploadSign${no}',
        'lblPrev${no}',
        'errSign${no}'
                                    )">
                                Remove File
                            </button>
                            <div id="errSign${no}" style="display:none" class="signatory-error"></div>
                        </div>
                    </div>
                    <div class="signatory-details">
                        <textarea id="txtUploadSignatory${no}" class="signatory-textarea TextAreaBorder" placeholder="Enter details for Signature ${no}">
                        </textarea>
                    </div>
                </div>`;
    }

    function GetUploadSignatoryHtml() {
        var html = `
 <div class="signatory-footer-fixed">
     <button class="btn btn-primary" onclick="SaveUploadSignatoryData()">
         <i class="fa fa-save"></i> Save Signatories
     </button>
 </div>
                <div class="signatory-container">
                    ${GetUploadSignatureBlock("1")}
        ${GetUploadSignatureBlock("2")}
        ${GetUploadSignatureBlock("3")}

        <div id="loading-Upload-Signatory" class="loading-screen" style="display: none; opacity: 0;"></div>
    </div>
                `;
        return html;
    }

    function GetUploadSignatoryData() {
        var datatotosend = {
            strdoctcode: gDoctCode
        }
        startLoading("Loading", "loading-Upload-Signatory");
        $.ajax({
            type: "GET",
            url: "../DoctorDesk/GetSignatory",
            data: datatotosend,
            cache: false,
            success: function (result) {
                var data = JSON.parse(result);
                $('#txtUploadSignatory1').val("");
                $('#txtUploadSignatory2').val("");
                $('#txtUploadSignatory3').val("");
                $('#imgUploadSign1')[0].src = "";
                $('#imgUploadSign2')[0].src = "";
                $('#imgUploadSign3')[0].src = "";
                if (Array.isArray(data) && data.length > 0) {
                    $('#txtUploadSignatory1').val(data[0]["SIGN"]);
                    $('#txtUploadSignatory2').val(data[0]["SIGN2"]);
                    $('#txtUploadSignatory3').val(data[0]["SIGN3"]);
                }
                $('#lblPrev1').show();
                $('#lblPrev2').show();
                $('#lblPrev3').show();
                $('#imgUploadSign1').hide();
                $('#imgUploadSign2').hide();
                $('#imgUploadSign3').hide();

                if (Array.isArray(data) && data.length > 0) {
                    if (data[0]["DIGSIGN1"] != "") {
                        $('#lblPrev1').hide();
                        $('#imgUploadSign1')[0].src = "data:image/jpeg;base64," + data[0]["DIGSIGN1"];
                        $('#imgUploadSign1').show();
                    }
                    if (data[0]["DIGSIGN2"] != "") {
                        $('#lblPrev2').hide();
                        $('#imgUploadSign2')[0].src = "data:image/jpeg;base64," + data[0]["DIGSIGN2"];
                        $('#imgUploadSign2').show();
                    }
                    if (data[0]["DIGSIGN3"] != "") {
                        $('#lblPrev3').hide();
                        $('#imgUploadSign3')[0].src = "data:image/jpeg;base64," + data[0]["DIGSIGN3"];
                        $('#imgUploadSign3').show();
                    }
                }
                stopLoading("loading-Upload-Signatory");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Upload-Signatory");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function validateAndPreviewSignatory(input, imgId, lblId, errId) {
        const file = input.files[0];
        $("#" + errId).text("");
        if (!file) return;
        if (MaxUpldSignatureSizeKB != "") {
            const maxBytes = MaxUpldSignatureSizeKB * 1024;
            if (file.size > maxBytes) {
                ToastMsg("Max file size allowed is " + MaxUpldSignatureSizeKB + " KB", "warning");
                $("#" + errId).text("Max file size allowed is " + MaxUpldSignatureSizeKB + " KB");
                input.value = "";
                return;
            }
        }
        const reader = new FileReader();
        reader.onload = function (e) {
            const img = new Image();
            img.onload = function () {
                if (MaxUpldSignatureWidth != "" && MaxUpldSignatureHeight != "") {
                    if (img.width > MaxUpldSignatureWidth || img.height > MaxUpldSignatureHeight) {
                        ToastMsg(`Image size must be within ${MaxUpldSignatureWidth}px × ${MaxUpldSignatureHeight}px`, "warning");
                        $("#" + errId).text(`Image size must be within ${MaxUpldSignatureWidth}px × ${MaxUpldSignatureHeight}px`);
                        input.value = "";
                        return;
                    }
                }
                $("#" + imgId).attr("src", e.target.result).css("display", "block");
                $("#" + lblId).hide();
            };
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }

    function clearImage(inputId, imgId, lblId, errId) {
        $("#" + inputId).val("");
        $("#" + imgId).hide().attr("src", "");
        $("#" + lblId).show();
        $("#" + errId).text("");
    }

    function SaveUploadSignatoryData() {
        var postData = new Array();
        var data = new FormData();
        if (validationForSaveUploadSignatoryData() == false)
            return false;
        var imgsrc1 = $('#imgUploadSign1')[0].currentSrc;
        imgsrc1 = imgsrc1.substr(imgsrc1.indexOf(',') + 1);
        var imgsrc2 = $('#imgUploadSign2')[0].currentSrc;
        imgsrc2 = imgsrc2.substr(imgsrc2.indexOf(',') + 1);
        var imgsrc3 = $('#imgUploadSign3')[0].currentSrc;
        imgsrc3 = imgsrc3.substr(imgsrc3.indexOf(',') + 1);
        data.append("Signatory1", imgsrc1);
        data.append("Signatory2", imgsrc2);
        data.append("Signatory3", imgsrc3);
        data.append("TextArea1", $('#txtUploadSignatory1').val());
        data.append("TextArea2", $('#txtUploadSignatory2').val());
        data.append("TextArea3", $('#txtUploadSignatory3').val());
        startLoading("Loading", "loading-Upload-Signatory");
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/SaveSignatory",
            data: data,
            dataType: "json",
            cache: false,
            contentType: false,
            processData: false,
            success: function (result) {
                stopLoading("loading-Upload-Signatory");
                if (result.toUpperCase().includes("SUCCESS")) {
                    ToastMsg(result, "success");
                    GetUploadSignatoryData();
                }
                else {
                    ToastMsg(result, "warning");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Upload-Signatory");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function validationForSaveUploadSignatoryData() {
        if ($('#fuSign1').val() == "" && $('#txtUploadSignatory1').val().trim() == "") {
            ToastMsg("Please upload Signature 1 or enter details in Text Area 1", "warning");
            return false;
        }
        return true;
    }
</script>

<style>
    /* --- UPLOAD STYLES --- */
    .upl-wrapper {
        padding: 15px;
    }

    .upl-header-box {
        background: #eef2f7;
        padding: 15px;
        border-radius: 4px;
        border: 1px solid #d1d9e6;
        margin-bottom: 20px;
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .upl-btn-upload {
        background-color: #28a745;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 4px;
        font-weight: 600;
        cursor: pointer;
        font-size: 14px;
    }

    .upl-section {
        margin-bottom: 20px;
        border: 1px solid #dae0e5;
        border-radius: 4px;
        overflow: hidden;
    }

    .upl-title {
        background: #f1f3f4;
        padding: 8px 15px;
        font-weight: 700;
        color: #003f74;
        border-bottom: 1px solid #dae0e5;
        font-size: 14px;
    }

    .upl-list {
        background: #fff;
        min-height: 50px;
    }

    .upl-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 15px;
        border-bottom: 1px solid #eee;
    }

    .upl-link {
        color: #0d6efd;
        text-decoration: none;
        font-size: 13px;
        font-weight: 500;
        cursor: pointer;
    }

        .upl-link:hover {
            text-decoration: underline;
        }

    .upl-btn-deleteExamImg {
        background-color: #f94f4f;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 4px;
        font-weight: 600;
        cursor: pointer;
        font-size: 14px;
    }
</style>
<script>
    function GetUploadExaminationHtml() { //priyanka 09/04/2026
        getExaminationImages();
        var Display = "";
        var RMOFlagNotesYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEUPLOADYN")%>' == "Y" ? "N" : "Y") : "N";
        return `
        <div class="upl-wrapper">
            <div class="upl-header-box ${Display}">
                <span style="font-weight:600;">Upload File:</span>
                <input type="file" id="uplExamFile" style="font-size:13px;"accept="image/*" >
                <button class="upl-btn-upload" onclick="UploadExaminationImagesFile()">Upload File</button>
            </div>
            <div class="upl-section">
                <div class="upl-title">Attachments</div>
                <div id="UplExaminationAttachmentsList" class="upl-list">
                   <div class="upl-item">
                   </div>
                </div>
            </div>
            <div id="loading-UploadExaminatin-popup" class="loading-screen" style="display: none; opacity: 0;"></div>
        </div>`;
    }
    function UploadExaminationImagesFile() {
        var fileInput = document.getElementById('uplExamFile');
        if (fileInput.files.length === 0) {
            ToastMsg("Please select a file first.", "info");
            return;
        }
        var file = fileInput.files[0];
        var blobUrl = URL.createObjectURL(file);
        var MRNO = GetSessionMRNO();
        var DoctCD = gDoctCode;

        if (gDoctCode) {
            var formData = new FormData();
            formData.append("File", file);
            formData.append("Mrno", MRNO);
            formData.append("DoctCode", DoctCD);
            startLoading("Loading...", "loading-UploadExamination-popup");
            $.ajax({
                type: "POST",
                url: '../SinglePage/UploadExaminationFile',
                data: formData,
                dataType: 'json',
                contentType: false,
                processData: false,
                success: function (response) {
                    console.log(response);
                    if (response.Message.toLowerCase().includes("success")) {
                        ToastMsg(response.Message, "info");
                        showUploadedExamImages([file.name]);
                    } else {
                        ToastMsg(response.Message || "File upload failed", "error");
                        document.getElementById("uplExamFile").value = "";
                    }
                    stopLoading("loading-UploadExamination-popup");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                    stopLoading("loading-UploadExamination-popup");
                }
            });
        }
    }

    function getExaminationImages() {
        var mr = GetSessionMRNO();
        $.ajax({
            type: "Post",
            url: '../SinglePage/GetUploadedExamImages',
            dataType: 'json',
            data: { MRNO: mr },
            success: function (response) {
                showUploadedExamImages(response);
                stopLoading("loading-UploadExaminatin-popup");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                stopLoading("loading-UploadExaminatin-popup");
            }
        });
    }

    function showUploadedExamImages(files) {
        if (files && files.length > 0) {
            files.forEach(function (fileObj) {
                var itemHtml = `
                <div class="upl-item">
                    <a  target="_blank" class="upl-link" onclick='openNewWindow(this)'>
                        <i class="fa fa-file-text-o"></i> ${fileObj}
                    </a>
                    <button class="upl-btn-deleteExamImg"
                    onclick="deleteExamUploadedFile('${fileObj}', this)">
                    Delete
                    </button>
                </div>`;
                $("#UplExaminationAttachmentsList").append(itemHtml);
            });
        }
        document.getElementById("uplExamFile").value = "";
    }

    function deleteExamUploadedFile(FileName, btn) {
        debugger;
        var MrNo = GetSessionMRNO();

        $.ajax({
            type: "POST",
            url: '../SinglePage/DeleteUploadedExaminationFile',
            data: {
                MrNo: MrNo,
                FileName: FileName
            },
            dataType: 'json',
            success: function (response) {
                console.log(response);
                if (response.isDeleted) {
                    $(btn).closest('.upl-item').remove();
                    ToastMsg(response.Message, "Success");
                }
                else {
                    ToastMsg(response.Message, "Info");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });


    }

    function openNewWindow(obj) {
        var NAME = obj.innerText.trim();
        var MRNO = GetSessionMRNO();

        var url = "../SinglePage/ExamFileDownload?MRNo="
            + MRNO
            + "&filename="
            + NAME;

        window.open(url, 'Image/pdf', 'width=900,height=600,resizable=1');
    }
</script>

<%-- Plan Completion Status --%>
<script type="text/javascript">
    var PlanCompletionStatusGrid;

    function GetHeightOfPlanCompStatusGrid() {
        var FilterHeadHeight = document.getElementById("PCSHeaderLabel").offsetHeight;
        var FilterHeight = document.getElementById("divPCSSearchFilter").offsetHeight;
        var ContHeight = document.getElementById("Hist_C_PlanCompletionStatus").offsetHeight;
        var FHeight = ContHeight - FilterHeadHeight - FilterHeight - 60;
        if (FHeight > 150) {
            return FHeight;
        }
        return 150;
    }

    function GetPlanCompletionStatusHtml() {
        const today = new Date().toISOString().split('T')[0];
        return `
        <div class="stat-wrapper">
            <div class="stat-title-bar" id="PCSHeaderLabel">
                <span>Treatment Plan Completed Status List</span>
                
                <div class="stat-title-icons">
                    <div class="stat-icon-btn" title="Search" id="BtnPCSSearch" onclick="GetPlanCompletionStatusGridData()">
                        <img src="../Images/Singlepage/Search.png" alt="Search" 
        style="width:18px; height:18px; object-fit:contain;" />
</div>

<div class="stat-icon-btn" title="Refresh" id="BtnPCSReset" onclick="ResetForGetPlanCompletionStatus()">
    <img src="../Images/Singlepage/Refresh.png" alt="Refresh" 
        style="width:18px; height:18px; object-fit:contain;" />
</div>
</div>
</div>

<div class="stat-filter-row" id="divPCSSearchFilter">
    <div class="stat-form-group">
        <input type="checkbox" id="chkDatePCS" class="Chkbox" checked />
        <label class="stat-label" for="chkDatePCS">Date</label>
    </div>
    <div class="stat-form-group">
        <span class="stat-label">From</span>
        <input type="date" class="stat-input" id="txtPCSFromDT" value=${today} onchange='validateDate("txtPCSFromDT","txtPCSToDT")'/>
    </div>
    <div class="stat-form-group">
        <span class="stat-label">To</span>
        <input type="date" class="stat-input" id="txtPCSToDT" value=${today} onchange='validateDate("txtPCSFromDT","txtPCSToDT")'/>
    </div>
    <div class="stat-form-group">
        <span class="stat-label">MR No.</span>
        <input type="text" class="stat-input" id="txtPCSMRNo" style="width:100px;" />
    </div>
    <div class="stat-form-group">
        <span class="stat-label">Patient Name</span>
        <input type="text" class="stat-input" id="txtPCSPatName" style="width:200px;" />
    </div>
</div>

<div class="stat-sub-header" style="display:none">Treatment Plan Completed Status Details</div>
<div id="PlanCompletionStatusGrid" class="stat-grid-container"></div>
<div id="loading-Plan-Completion-Status" class="loading-screen" style="display: none; opacity: 0;"></div>
</div>
`;
    }

    function ValidationForGetPlanCompletionStatusGridData() {
        if ($("#chkDatePCS").prop('checked') == true) {
            if ($("#txtPCSFromDT").val() == "") {
                ToastMsg("Please Select From Date", "warning");
                return false;
            }
            if ($("#txtPCSToDT").val() == "") {
                ToastMsg("Please Select To Date", "warning");
                return false;
            }
        }
        else if ($('#txtPCSMRNo').val() == "" && $('#txtPCSPatName').val() == "") {
            ToastMsg("Please Enter MRNo or Patient Name", "warning");
            return false;
        }
        return true;
    }
    function validateDate(frmid, toid) {
        const fromdt = document.getElementById(frmid).value;
        const todt = document.getElementById(toid).value;

        if (!fromdt || !todt) return;

        if (new Date(fromdt) > new Date(todt)) {
            ToastMsg('From Date cannot be greater than To Date .', "Information");
            document.getElementById(toid).value = "";
        }
    }
    function ResetForGetPlanCompletionStatus() {
        $("#BtnPCSSearch").show();
        $("#divPCSSearchFilter").find('*').attr('disabled', false);
        LoadPlanCompletionStatusGrid([]);
    }

    function GetPlanCompletionStatusGridData() {
        $("#divPCSSearchFilter").find('*').attr('disabled', false);
        if (ValidationForGetPlanCompletionStatusGridData() == false)
            return false;
        var sfrom = "";
        var sto = "";
        var MRNumber = $('#txtPCSMRNo').val();
        var PatName = $('#txtPCSPatName').val();
        var PlanNumber = "";
        var SearchCriData = "";
        if ($("#chkDatePCS").prop('checked')) {
            sfrom = ("" + document.getElementById("txtPCSFromDT").value);
            sto = ("" + document.getElementById("txtPCSToDT").value);
        }
        if (sto.trim() == '') {
            sto = sfrom;
            $('#txtPCSToDT').val(sfrom);
        }
        if (MRNumber != "")
            SearchCriData = SearchCriData + "MR No. : " + MRNumber + ", ";
        if (PatName != "")
            SearchCriData = SearchCriData + "Patient Name : " + PatName + ", ";
        $("#divPCSSearchFilter").find('*').attr('disabled', true);
        var urlq = '../DoctorDesk/GetPlanCompletedStatus?FromDT=' + sfrom + '&&ToDT=' + sto + '&&PlanNumber=' + PlanNumber + '&&MRNumber=' + MRNumber + '&&PatName=' + PatName;
        startLoading("Loading", "loading-Plan-Completion-Status");
        $.ajax({
            type: "POST",
            url: urlq,
            async: true,
            success: function (result) {
                var res = [];
                if (result != null && result.length > 0) {
                    res = result;
                    $("#BtnPCSSearch").hide();
                }
                else {
                    $("#divPCSSearchFilter").find('*').attr('disabled', false);
                    ToastMsg("No Data Found.", "info");
                    $("#BtnPCSSearch").show();
                }
                LoadPlanCompletionStatusGrid(res);
                stopLoading("loading-Plan-Completion-Status");
            },
            onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Plan-Completion-Status");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function LoadPlanCompletionStatusGrid(tableData) {
        if (PlanCompletionStatusGrid) {
            PlanCompletionStatusGrid.destroy();
            PlanCompletionStatusGrid = null;
        }
        PlanCompletionStatusGrid = new Tabulator("#PlanCompletionStatusGrid", {
            data: tableData,
            height: GetHeightOfPlanCompStatusGrid() + "px",
            layout: "fitColumns",
            columns: [
                { title: "Plan No.", field: "PLANNO", width: 120, headerFilter: "input", tooltip: true },
                { title: "MR No", field: "MRNO", width: 90, headerFilter: "input", tooltip: true },
                { title: "Patient Name", field: "PATNAME", width: 150, headerFilter: "input", tooltip: true },
                { title: "Address", field: "ADDRESS", width: 150, headerFilter: "input", tooltip: true },
                { title: "Pat. Category", field: "PATCATG", width: 150, headerFilter: "input", tooltip: true },
                { title: "Company", field: "COMPANY", width: 150, headerFilter: "input", tooltip: true },
                { title: "Tariff", field: "TARIFF", width: 100, headerFilter: "input", tooltip: true },
                { title: "Pay Type", field: "PAYTYPE", width: 100, headerFilter: "input", tooltip: true },
                { title: "Contact No.", field: "CONTACTNO", width: 150, headerFilter: "input", tooltip: true },
                { title: "Chemotherapy Name", field: "CHEMONAME", width: 250, headerFilter: "input", tooltip: true },
                { title: "Chemotherapy Cycles Planned", field: "TOTALCYCLES", width: 250, hozAlign: "right", headerFilter: "input", tooltip: true },
                { title: "Chemotherapy Cycles Completed", field: "COMPLETEDCYCLES", width: 250, hozAlign: "right", headerFilter: "input", tooltip: true },
                { title: "Status", field: "STATUS", width: 100, headerFilter: "input", tooltip: true }
            ],
        });

    }
</script>

<%-- Scheme Approvel Status --%>
<script type="text/javascript">
    var SchemeApprovalStatusGrid;

    function GetHeightOfSchemeApprovalStatusGrid() {
        var FilterHeadHeight = document.getElementById("SASHeaderLabel").offsetHeight;
        var FilterHeight = document.getElementById("divSASSearchFilter").offsetHeight;
        var ContHeight = document.getElementById("Hist_C_SchemeApprovalStatus").offsetHeight;
        var FHeight = ContHeight - FilterHeadHeight - FilterHeight - 60;
        if (FHeight > 150) {
            return FHeight;
        }
        return 150;
    }

    function GetSchemeApprovalStatusHtml() {
        const today = new Date().toISOString().split('T')[0];
        return `
        <div class="stat-wrapper">
            <div class="stat-title-bar" id="SASHeaderLabel">
                <span></span>
                <div class="stat-title-icons">
                    <div class="stat-icon-btn" title="Search" id="BtnSASSearch" onclick="GetSchemeApprovalStatusGridData()">
                        <img src="../Images/Singlepage/Search.png" alt="Search" 
        style="width:18px; height:18px; object-fit:contain;" />
</div>
<a class="stat-icon-btn" title="Excel" id="BtnSASExcel" onclick="ExcelForSchemeApprovalStatus()">
    <img src="../Images/Singlepage/Excel.png" alt="Excel" style="width:18px; height:18px; object-fit:contain;" />
</a>
<div class="stat-icon-btn" title="Refresh" id="BtnSASReset" onclick="ResetForSchemeApprovalStatus()">
    <img src="../Images/Singlepage/Refresh.png" alt="Refresh" 
        style="width:18px; height:18px; object-fit:contain;" />
</div>
</div>
</div>

<div class="stat-filter-row" id="divSASSearchFilter">
    <div class="stat-form-group">
        <input type="checkbox" id="chkDateSAS" checked />
        <label class="stat-label" for="chkDateSAS">Date</label>
    </div>
    <div class="stat-form-group">
        <span class="stat-label">From</span>
        <input type="date" class="stat-input" id="txtSASFromDT" value="${today}" onchange="validateDate('txtSASFromDT','txtSASToDT')"/>
    </div>
    <div class="stat-form-group">
        <span class="stat-label">To</span>
        <input type="date" class="stat-input" id="txtSASToDT" value="${today}"  onchange="validateDate('txtSASFromDT','txtSASToDT')"/>
    </div>
    <div class="stat-form-group">
        <span class="stat-label">Pre Auth Approval Status</span>
        <select id="cmbSASPreAPAuthStatus" class="stat-input" style="width:200px;" >
            <option value="">-- All --</option>
            <option value="P">Pending</option>
            <option value="W">Waiting For Approval</option>
            <option value="A">Approved</option>
            <option value="R">Rejected</option>
        </select>
    </div>
</div>
<div class="stat-sub-header" style="display:none">Treatment Plan Completed Status Details</div>
<div id="SchemeApprovalStatusGrid" class="stat-grid-container"></div>
<div id="loading-Scheme-Approval-Status" class="loading-screen" style="display: none; opacity: 0;"></div>
</div>
`;
    }

    function ValidationForGetSchemeApprovalStatusGridData() {
        if ($("#chkDateSAS").prop('checked') == true) {
            if ($("#txtSASFromDT").val() == "") {
                ToastMsg("Please Select From Date", "warning");
                return false;
            }
            if ($("#txtSASToDT").val() == "") {
                ToastMsg("Please Select To Date", "warning");
                return false;
            }
        }
        else if ($('#cmbSASPreAPAuthStatus').val() == "") {
            ToastMsg("Please Select Pre Auth Status", "warning");
            return false;
        }
        return true;
    }

    function ResetForSchemeApprovalStatus() {
        $("#BtnSASSearch").show();
        $("#divSASSearchFilter").find('*').attr('disabled', false);
        LoadSchemeApprovalStatusGrid([]);
    }

    function GetSchemeApprovalStatusGridData() {
        $("#divSASSearchFilter").find('*').attr('disabled', false);
        if (ValidationForGetSchemeApprovalStatusGridData() == false)
            return false;
        if ($("#chkDateSAS").prop('checked')) {
            sfrom = ("" + document.getElementById("txtSASFromDT").value);
            sto = ("" + document.getElementById("txtSASToDT").value);
        }
        if (sto.trim() == '') {
            sto = sfrom;
            $('#txtSASToDT').val(sfrom);
        }
        var urlq = '../DoctorDesk/GetSchemeApprovalStatusDetails?FromDT=' + sfrom + '&&ToDT=' + sto + '&&strPreAuthStatus=' + $('#cmbSASPreAPAuthStatus').val();
        startLoading("Loading", "loading-Scheme-Approval-Status");
        $("#divSASSearchFilter").find('*').attr('disabled', true);
        $.ajax({
            type: "POST",
            url: urlq,
            async: true,
            success: function (result) {
                var res = [];
                if (result != null && result.length > 0) {
                    res = result;
                    $("#BtnSASSearch").hide();
                }
                else {
                    $("#divSASSearchFilter").find('*').attr('disabled', false);
                    ToastMsg("No Data Found.", "info");
                    $("#BtnSASSearch").show();
                }
                LoadSchemeApprovalStatusGrid(res);
                stopLoading("loading-Scheme-Approval-Status");
            },
            onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                $("#divSASSearchFilter").find('*').attr('disabled', false);
                stopLoading("loading-Scheme-Approval-Status");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function LoadSchemeApprovalStatusGrid(tableData) {
        if (SchemeApprovalStatusGrid) {
            SchemeApprovalStatusGrid.destroy();
            SchemeApprovalStatusGrid = null;
        }
        SchemeApprovalStatusGrid = new Tabulator("#SchemeApprovalStatusGrid", {
            data: tableData,
            height: GetHeightOfSchemeApprovalStatusGrid() + "px",
            layout: "fitColumns",
            columns: [
                { title: "", formatter: "rownum", width: 50, hozAlign: "center", headerSort: false },
                { title: "Transaction No.", field: "TRANNO", width: 180, headerFilter: "input", tooltip: true },
                { title: "Prescription Date / Time", field: "TRANDATETIME", width: 190, headerFilter: "input", tooltip: true },
                { title: "MR No.", field: "MRNO", width: 128, headerFilter: "input", tooltip: true },
                { title: "Patient Name", field: "PATNAME", width: 290, hozAlign: "left", headerFilter: "input", tooltip: true },
                { title: "Company Name", field: "COMPNAME", width: 290, hozAlign: "left", headerFilter: "input", tooltip: true },
                { title: "Scheme Codes", field: "SCHEMECODES", width: 190, hozAlign: "left", headerFilter: "input", tooltip: true, visible: false },
                { title: "Schemes", field: "SchemeNames", width: 350, hozAlign: "left", headerFilter: "input", tooltip: true },
                { title: "Pre Auth Approval Status", field: "PreAuthStatus", width: 200, hozAlign: "left", headerFilter: "input", tooltip: true },
                { title: "Approval Date / Time", field: "ApprovalDtTime", width: 190, headerFilter: "input", tooltip: true }//priyanka 23/04/2026
            ],
        });
    }

    function ExcelForSchemeApprovalStatus() {
        if (!SchemeApprovalStatusGrid || SchemeApprovalStatusGrid.getData().length == 0) {
            ToastMsg("No Data Found For Excel.", "warning");
            return false;
        }
        var data = SchemeApprovalStatusGrid.getData();
        var FrmDate, ToDate = "";
        if ($("#chkDateSAS").prop("checked") == true) {
            FrmDate = $('#txtSASFromDT').val();
            ToDate = $('#txtSASToDT').val();
        } else {
            FrmDate = ""; ToDate = "";
        }
        data = JSON.stringify(data);
        var SearchCriData = "Pre Auth Approvel Status : " + ($("#cmbSASPreAPAuthStatus").val() == "" ? "All" : $("#cmbSASPreAPAuthStatus option:selected").text());
        var datatosend = {
            FrmDate: FrmDate,
            ToDate: ToDate,
            data: data,
            SearchCriteria: SearchCriData
        };
        ExcelAJAXForSchemeApprovalStatus('../DoctorDesk/ExcelBindSchemeApprovalStatusLst', datatosend, true, '../DoctorDesk/DisplayExcelSchemeApprovalStatusLst', false)
    }

    function ExcelAJAXForSchemeApprovalStatus(Url, data, async, DisplayURL, flagExcel) {
        startLoading("Loading", "loading-Scheme-Approval-Status");
        $.ajax({
            type: 'POST',
            data: data,
            url: Url,
            cache: false,
            dataType: "json",
            async: async,
            success: function (result) {
                if (flagExcel == true) {
                    $('#BtnSASExcel').attr('href', DisplayURL);
                }
                else {
                    var win = window.open(DisplayURL, "_blank", '', true);
                    win.focus();
                }
                stopLoading("loading-Scheme-Approval-Status");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Scheme-Approval-Status");
                ToastMsg(textStatus, "error");
            }
        });
    }

</script>

<div class="header_container">

    <div class="header_left">
        <% if (("" + Session["REDIRECTHMIS"]).ToString().Trim() == "Y")
            {  %>
        <div class="header_settings">
            <img class="h-icon-DoctLogo" title="Redirect To Hospital" src="../Images/Singlepage/HmisRedirectIcon.png" alt="" onclick="GoToHome('ModuleList')" />
        </div>
        <% }%>
        <div class="header_location h-font-size">

            <img class="h-icon-size" src="../Images/Singlepage/Loaction.png" alt="Location" />
            <% string SetHospitalName = OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("SetHospitalNm"); %>
            <span id="header_location_text"><%: !string.IsNullOrWhiteSpace(SetHospitalName) ? SetHospitalName : Convert.ToString(Session["HOSPITALNAME"]).Trim() %> </span>

        </div>
        <% if (("" + Session["gDoctCode"]).ToString().Trim() != "")
            {  %>
        <div class="header_doctor h-font-size">
            <img class="h-icon-DoctLogo" src="../Images/Singlepage/DoctorLogoImage.png" alt="" />Dr. <%:Session["gDoctName"]%>
        </div>
        <% }
            else
            {%>
        <div class="header_doctor h-font-size"><%:Session["gDoctName"]%> </div>
        <% } %>

        <div class="header_speciality_box" id="ClinicSelectionDiv" style="display: none">
            <div class="header_speciality_selected h-font-size" data-value="<%:(""+ Session["CLINICCODE"]).ToString().Trim()%>">
                <span class="clinic-name"><%:(""+ Session["CLINICNAME"]).ToString().Trim()%></span>
                <span class="clinic-arrow" style="display: none;">▼</span>
            </div>
            <div class="header_speciality_dropdown"></div>
        </div>
        <div class="header_OpdIpd_box" id="QuickredirectPatList" style="display: none">
            <div class="header_OpdIpd_selected h-font-size" data-value="">
                <span>Select</span>
                <span id="clinic-arrowUnit">▼</span>
            </div>
            <div class="header_OpdIpd_dropdown">
            </div>
        </div>
    </div>
    <div class="header_right" id="RightHeaderMenu">

        <% if ((Session["RMOYN"] != null && ("" + Session["RMOYN"]).ToString() == "Y") || (Session["AUTHYN"] != null && ("" + Session["AUTHYN"]).ToString() == "Y"))
            {  %>
        <div class="header_doctor h-font-size" id="LblConsultDoctorDiv" style="display: none">
            <img class="h-icon-DoctLogo" src="../Images/Singlepage/DoctorLogoImage.png" alt="">
            <label id="LblConsultDoctor"></label>
        </div>
        <% } %>
        <% if ((("" + Session["RMOYN"]).ToString() != "Y" && ("" + Session["AUTHYN"]).ToString() != "Y"))
            {  %>
        <div class="header_icon_wrapper" id="btnBellIcon">
            <img class="h-icon-size" src="../Images/Singlepage/notification-bell.png" alt="Notification" />
            <span id="btnBellIconCount"
                style="position: absolute; top: -13px; right: -10px; background: red; color: white; font-size: 11px; font-weight: bold; border-radius: 50%; padding: 2px 6px; min-width: 18px; text-align: center; line-height: 14px;"></span>

            <div class="ntf-popup" id="ntfPopup">
                <div class="ntf-header">
                    <span>Referal Doctor Notes</span>
                    <div style="display: flex; align-items: center; gap: 4px;">
                        <div style="height: 15px; width: 15px;margin-left: 362px;" class="opdn"></div>
                        <label>OPD</label>
                        <div style="height: 15px; width: 15px; margin-left: 4px;" class="ipdn"></div>
                        <label>IPD</label>
                    </div>
                    <span class="ntf-close" id="closeNtf">✕</span>
                </div>
                <div class="ntf-body" id="ReferralNotification">
                </div>
                <div id="loading-Referal-Doctor-Notes" class="loading-screen" style="display: none; opacity: 0;"></div>
            </div>
        </div>
        <% } %>
        <div class="header_settings">
            <img class="h-icon-size" src="../Images/Singlepage/List.png" alt="Settings" />

            <div class="header_settings_dropdown">
                <% if ((("" + Session["RMOYN"]).ToString() != "Y" && ("" + Session["AUTHYN"]).ToString() != "Y"))
                    {  %>
                <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Tumor Board Schedule', 'TumorBoardSchedule',true)" id="TumorSetting">Tumor Board Schedule </div>
                <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Surgical Schedule', 'SurgicalSchedule',true)" id="SurgicalSetting">Surgical Schedule </div>
                <% } %>
                <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Chemo Plan Completion Status', 'PlanCompletionStatus',true)">Chemo Plan Completion Status </div>
                <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Scheme Approval Status', 'SchemeApprovalStatus',true)">Scheme Approval Status</div>
<div class="header_settings_item h-font-size" onclick="OpenSettingPopup('OT Booking', 'OTBooking', true)">OT Booking</div>
<div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Planning', 'OTPlanning', true)">OT Planning</div>

            </div>
        </div>
        <% if ((("" + Session["RMOYN"]).ToString() != "Y" && ("" + Session["AUTHYN"]).ToString() != "Y"))
            {  %>
             <div class="header_settings">
            <img class="h-icon-size" src="../Images/Singlepage/Setting.png" alt="Settings" />
            <div class="header_settings_dropdown">
                <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Master Setting', 'MasterSetting',true)">
                    <img class="h-icon-size" src="../Images/Singlepage/master-icon-notp.png" alt="Settings" title="Master Setting" />
                    Master Setting
                </div>
                <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Master Setup', 'MasterSetup',true)">
                    <img class="h-icon-size" src="../Images/Singlepage/master-setup.png" alt="Settings" title="Master Setup" />
                    Master Setup
                </div>
            <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Upload Signatory', 'UploadSignatory',true)">
                <img class="h-icon-size" src="../Images/Singlepage/upload-signator.png" alt="Settings" title="Upload Signatory" />
                Upload Signatory
            </div>
            <%--priyanka 11/04/2026--%>
            <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Upload Examination', 'UploadExamination',true)">
                <img class="h-icon-size" src="../Images/Singlepage/UploadExamination.png" alt="Settings" title="Upload Examination" />
                Upload Examination
            </div>
            <% if ((("" + Session["gOncoUserId"]).ToString() != "" && ("" + Session["gOncoUserId"]).ToString() == "SYSTEM"))
            {  %>
            <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('App Settings', 'AppSettingConfig',true)">
                <img class="h-icon-size" src="..\Images\Singlepage\app-setting.png" alt="Settings" title="App Settings" />
                App Settings
            </div>

            <div class="header_settings_item h-font-size" onclick="OpenSettingPopup('Error Log', 'ErrorLog',true)">
                <img class="h-icon-size" src="..\Images\Singlepage\Error-log.png" alt="Settings" title="Error Log" />
                Error Log
            </div>
            <% } %>
          </div>
        </div>
          <% } %>
        <div class="header_icon_wrapper" onclick="SignoutConfirm()" style="border: 2px solid red">
            <img class="h-icon-size" src="../Images/Singlepage/Logout.png" alt="Logout" />
        </div>
    </div>
</div>

<div class="header_modal" id="header_location_modal">
    <div class="header_modal_content">
        <h4>Select Hospital Unit</h4>
        <select id="cmbHospUnit"></select>
        <button type="button" id="header_location_save">Continue</button>
    </div>
</div>

<div class="adm-modal-overlay" id="MstGenericAddModal" style="display: none;"></div>

<div class="adm-modal-overlay" id="AddMasterModal"></div>


        <div id="iframeMain" style="display: none;">
            <div id="iframeHeader">
                <label id="PrevHistFrameLbl"></label>
                <div class="iframe-controls">
                    <i class="fa fa-minus-circle IFrameIcon" onclick="minimizeIframe()" aria-hidden="true"></i>
                    <i class="fa fa-times-circle IFrameIcon" onclick="closeIframe()" aria-hidden="true"></i>
                </div>
            </div>
            <div id="iframeContainer" style="height: 90%;">
            </div>
        </div>