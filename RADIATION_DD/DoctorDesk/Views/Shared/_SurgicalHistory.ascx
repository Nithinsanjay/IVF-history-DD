<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style>
    .surgery-card {
        border: 1px solid #ccc;
        font-family: Arial, sans-serif;
        margin: 10px 0;
        border-radius: 4px;
        overflow: hidden;
    }

    .surgery-card-header {
        background-color: #507eb3;
        color: white;
        padding: 10px 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-weight: bold;
        font-size: 14px;
    }

    .surgery-card-body {
        padding: 10px;
        font-size: 14px;
    }

    .surgery-SurgeryName-info-box {
        background-color: #e6f0fa;
        border-left: 4px solid #507eb3;
        padding: 10px 12px;
        border-radius: 6px;
        margin: 10px 0;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        font-size: 14px;
        font-weight: 600;
        color: #003366;
    }

    .surgery-section-title {
        font-weight: bold;
        text-decoration: underline;
    }

    .surgery-list {
        margin-top: 5px;
        margin-bottom: 10px;
        padding-left: 20px;
    }

    .surgery-footer {
        background-color: #f5faff;
        text-align: right;
        padding: 5px 10px;
        font-weight: bold;
    }

    .notes-textarea {
        width: 100%;
        border: 1px solid #ccc;
        border-radius: 3px;
        padding: 4px;
        margin-top: 5px;
    }


    /*//adde new record*/
    .add-surgery-form {
        background: #f9f9f9;
        padding: 12px 16px;
        border-radius: 8px;
        margin-bottom: 16px;
    }

    .form-row {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
        margin-bottom: 8px;
    }

    .form-group {
        flex: 1;
        min-width: 180px;
        display: flex;
        flex-direction: column;
        margin-bottom: 8px;
    }

        .form-group label {
            font-weight: 600;
            font-size: 13px;
            margin-bottom: 4px;
        }

    .input-field {
        padding: 6px 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 13px;
        height: 32px;
    }

    textarea.input-field {
        height: auto;
        resize: vertical;
    }

    .btn-add {
        padding: 6px 14px;
        background-color: #0056b3;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
        margin-top: 4px;
    }

        .btn-add:hover {
            background-color: #007bff;
        }

    .custom-modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.6);
        z-index: 999;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .custom-modal-box {
        background-color: white;
        padding: 20px;
        border-radius: 6px;
        width: 500px;
        position: relative;
    }

    .close-modal {
        position: absolute;
        top: 10px;
        right: 15px;
        font-size: 20px;
        cursor: pointer;
        color: #aaa;
    }

        .close-modal:hover {
            color: black;
        }

    .form-group {
        margin-bottom: 12px;
    }

    .input-field {
        width: 100%;
        padding: 6px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .form-row {
        display: flex;
        gap: 15px;
    }

        .form-row .form-group {
            flex: 1;
        }

    #btnSaveSurgery {
        margin-left: 35%;
    }

    #txtNotes {
        width: 100%;
    }

    legend {
        color: #fff;
    }

    .notes-textarea {
        width: 100%;
        border: 1px solid #ccc;
        border-radius: 3px;
        padding: 6px;
        resize: none;
        overflow: hidden;
        min-height: 100px;
        box-sizing: border-box;
        font-size: 13px;
    }

    .btn-Tabs {
        background: #e6f0fa;
        color: #333;
        border: 1px solid #ccc;
        padding: 10px 18px;
        border-radius: 6px 6px 0 0;
        font-weight: bold;
        cursor: pointer;
        font-size: 14px;
        transition: all 0.3s ease;
    }

        .btn-Tabs:hover {
            background: #d6d6d6;
        }

        .btn-Tabs.active {
            background: #507eb3;
            color: white;
            border-bottom: none;
            position: relative;
            top: 2px;
            z-index: 2;
        }
</style>
<script type="text/javascript">

    $(document).ready(function () {
        $("#txtSurgeryDate").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            maxDate: new Date()
        });
        $('#txtSurgeryDate').datepicker('setDate', 'today');
        $("#divSurgInfo").show();
        $("#btnAddRecord").css("visibility", "visible");
        //HelperToolsLoad();
        PageLoadSurgicalHist();
        //preloadHiddenIframes();
        //var iframe = document.getElementById('myIframe');
        //var menuL = document.querySelector('[id="iframe menuList"]');
        //menuL.style.display = "block";
        $("#btnSaveSurgery").on("click", function () {
            const newSurgery = {
                MRNO: sessionStorage.getItem('PatMRNO'),
                UniqueId: $("#txtUniqueID").val(),
                SurgeonDoctorName: $("#txtDoctorName").val().trim(),
                SurgeryDate: $("#txtSurgeryDate").val(),
                SurgeryName: $("#txtSurgeryName").val().trim(),
                SurgeryNotes: encodeURIComponent($("#txtNotes").val().trim()),
                gact: "N",
            };
            SaveSurgicalHistory(newSurgery);
            //cleardata();
            //$('#surgeryModal').fadeOut();
            //GetSurgData(sessionStorage.getItem('PatMRNO'));
            //getSurgicalHistory();
        });
        $('#btnAddRecord').click(function () {
            cleardata();
            $('#surgeryModal').fadeIn();
        });
        $('#closeModal').click(function () {
            $('#surgeryModal').fadeOut();
        });

        $("#btnUpdateSurgery").on("click", function () {
            const newSurgery = {
                MRNO: sessionStorage.getItem('PatMRNO'),
                UniqueId: $("#txtUniqueID").val(),
                SurgeonDoctorName: $("#txtDoctorName").val().trim(),
                SurgeryDate: $("#txtSurgeryDate").val(),
                SurgeryName: $("#txtSurgeryName").val().trim(),
                SurgeryNotes: encodeURIComponent($("#txtNotes").val().trim()),
                gact: "E",
            };
            SaveSurgicalHistory(newSurgery);
            //cleardata();
            //$('#surgeryModal').fadeOut();
            //GetSurgData(sessionStorage.getItem('PatMRNO'));
            //getSurgicalHistory();
        });

    });

    function PageLoadSurgicalHist() {
        var mrno = sessionStorage.getItem('PatMRNO');
        GetSurgData(mrno);
    }

    function cleardata() {
        // Clear input fields
        $("#txtUniqueID").val('');
        $("#txtDoctorName").val('');
        $("#txtSurgeryDate").val('');
        $("#txtSurgeryName").val('');
        $("#txtNotes").val('');
        $('#txtSurgeryDate').datepicker('setDate', 'today');
        $("#btnSaveSurgery").show();
        $("#btnUpdateSurgery").hide();

    }
    //function
    function GetSurgData(strMrNo) {
      /*  HoldOn.open();*/
        $.ajax({
            type: "get",
            datatype: "json",
            url: '../DoctorDesk/GetSurgicalHistoryData',
            data: { strMrNo: strMrNo },
            success: function (response) {
                //debugger;
                if (Array.isArray(response)) {
                    surgeryDataList = $.map(response, function (item) {
                        item.IsNew = false;
                        return item;
                    });
                } else {
                    response.IsNew = false;
                    surgeryDataList = [response];
                }
                BindData(surgeryDataList);
                //autoResizeTextareas();

            },
            complete: function () { /*HoldOn.close(); */},
            error: function (XMLHttpRequest, textStatus, errorThrown) { /*HoldOn.close()*/; }
        });
    }
    function BindData(dataList) {
        //debugger;
        var html = "";

        $.each(dataList, function (index, surgery) {
            var rawNotes = surgery.SurgeryNotes || '';
            var decodedNotes = decodeURIComponent(rawNotes).replace(/<[^>]*>/g, '');

            html += '<div class="surgery-card">';
            //html += '<div class="surgery-card-header">';
            var headerStyle = (surgery.UniqueId == "0")
                ? ' style="background-color: #28666e;"' // light orange or use your custom color
                : '';
            var DateStyle = (surgery.UniqueId != "0")
                ? ' style="margin-left:-115px"'
                : '';

            html += '<div class="surgery-card-header"' + headerStyle + '>';


            html += '<div><strong>Doctor :</strong> ' + surgery.SurgeonDoctorName + '</div>';
            html += '<div' + DateStyle + '><strong>Date :</strong> ' + surgery.SurgeryDate + '</div>';
            html += '<div style="display:none"><strong>UniqueId:</strong> ' + surgery.UniqueId + '</div>';

            //  Edit icon
            //  Only show edit for new records
            if (surgery.UniqueId != "0") {
                html += '<div style="cursor:pointer;" onclick="editSurgeryRecord(' + index + ')">';
                html += '<span title="Edit">&#9998;</span>';
                html += '</div>';
            }
            else {
                html += '<div><strong>Inhouse Surgery Done</strong></div>';
            }

            html += '</div>'; // header

            html += '<div class="surgery-card-body">';
            html += '<div class="surgery-SurgeryName-info-box"><strong>Surgery Name : </strong> ' + surgery.SurgeryName + '</div>';
            html += '<div><label><strong>Notes: </strong></label><br>';
            html += '<textarea class="notes-textarea auto-expand" rows="3" readonly>' + decodedNotes + '</textarea></div>';
            html += '</div>'; // body

            html += '</div>'; // card
        });


        $("#surgeryInfoContainer").html(html);
    }

    function editSurgeryRecord(index) {
        $('#surgeryModal').fadeIn();
        const item = surgeryDataList[index];
        if (!item) return;

        $("#txtUniqueID").val(item.UniqueId);

        $("#txtDoctorName").val(item.SurgeonDoctorName);
        $("#txtSurgeryDate").val(item.SurgeryDate);
        $("#txtSurgeryName").val(item.SurgeryName);
        $("#txtNotes").val(decodeURIComponent(item.SurgeryNotes || ''));

        $("#btnSaveSurgery").hide();
        $("#btnUpdateSurgery").show();

    }

    function SaveSurgicalHistory(datatosend) {
        //HoldOn.open();
        //priyanka 14/04/2026
        if ($("#txtDoctorName").val() === "" || $("#txtDoctorName").val() === null || $("#txtDoctorName").val() === undefined) {
            $("#txtDoctorName").css("border-color", "red");
            $("#txtDoctorName").focus();
            ToastMsg("Please Enter Doctor Name", "Information");
            return false;
        }
        if ($("#txtSurgeryName").val() === "" || $("#txtSurgeryName").val() === null || $("#txtSurgeryName").val() === undefined) {
            $("#txtSurgeryName").css("border-color", "red");
            $("#txtSurgeryName").focus();
            ToastMsg("Please Enter Surgery Name", "Information");
            return false;
        }
        if ($("#txtNotes").val() === "" || $("#txtNotes").val() === null || $("#txtNotes").val() === undefined) {
            $("#txtNotes").css("border-color", "red");
            $("#txtNotes").focus();
            ToastMsg("Please Enter Notes", "Information");
            return false;
        }
        //End
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/SaveSurgicalHistory',
            contentType: "application/json",
            data: JSON.stringify(datatosend),
            success: function (response) {
                ToastMsg( response,'Information');
                var mrno = $('#txtPACMRNO').val();
                //priyanka 14/04/2026
                cleardata();
                $('#surgeryModal').fadeOut();
                GetSurgData(sessionStorage.getItem('PatMRNO'));
                getSurgicalHistory();
                //end
            },
            complete: function () { /*HoldOn.close();*/ },
            error: function (XMLHttpRequest, textStatus, errorThrown) { /*HoldOn.close();*/ }
        });
    }
    //Remove Validation Color ! Priyanka 14/04/2026
    function MakeNormal(Id) {
        $("#" + Id).css("border-color", "");
    }
</script>
<div style="display: flex; justify-content: end; align-items: center;">
    <button type="button" id="btnAddRecord" class="btn-add">➕ Add Surgery History</button>
</div>
<div style="display: flex; justify-content: center; align-items: center;">
    <div id="divSurgInfo" class="tab-panel" style="width:100%"<%--style="display: none;"--%>>
        <div id="surgeryInfoContainer" style="width:100%"></div>
    </div>
</div>

    <div id="surgeryModal" class="custom-modal-overlay" style="display: none;">
        <div class="custom-modal-box">
            <span class="close-modal" id="closeModal">&times;</span>
            <h4>Add Surgical History</h4>

             <div class="form-row">
                <div class="form-group">
                    <label for="txtDoctorName">Doctor Name:</label>
                    <input type="text" id="txtDoctorName" class="input-field" placeholder="Enter doctor name"  onchange="MakeNormal(this.id);"/>
                </div>
                <div class="form-group" style="display: none">
                    <label for="txtUniqueID">Unique ID:</label>
                    <input type="text" id="txtUniqueID" class="input-field" placeholder="Unique Id"  />
                </div>
                <div class="form-group">
                    <label for="txtSurgeryDate">Surgery Date:</label>
                    <input type="text" id="txtSurgeryDate" class="input-field" readonly  />
                </div>
            </div>

            <div class="form-group">
                <label for="txtSurgeryName">Surgery Name:</label>
                <input type="text" id="txtSurgeryName" class="input-field" placeholder="Enter surgery name"  onchange="MakeNormal(this.id);" />
            </div>

            <div class="form-group">
                <label for="txtNotes">Notes:</label>
                <textarea id="txtNotes" class="input-field" rows="3" placeholder="Enter notes" maxlength="748"  onchange="MakeNormal(this.id);"></textarea>
            </div>

            <%-- <button type="button" id="btnAddSurgery" class="btn-add">➕ Add</button>--%>
            <button type="button" id="btnSaveSurgery" class="btn-add">💾 Save</button>

            <button type="button" id="btnUpdateSurgery" class="btn-add" style="display: none;">🔁 Update</button>
        </div>
    </div>

