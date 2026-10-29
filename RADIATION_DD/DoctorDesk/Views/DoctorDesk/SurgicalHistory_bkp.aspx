<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">

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





        /*//modal*/

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

    <script>
        let surgeryDataList = [];
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


            var mrno = ($.session.get('PatMRNO'));
            GetBindingData(mrno);



            //added new record 
            //$("#btnSaveSurgery").on("click", function () {
            //    const newSurgery = {
            //        UniqueId:"",
            //        DoctorName: $("#txtDoctorName").val().trim(),
            //        SurgeryDate: $("#txtSurgeryDate").val(),
            //        SurgeryName: $("#txtSurgeryName").val().trim(),
            //        Notes: encodeURIComponent($("#txtNotes").val().trim()),
            //        IsNew: true // Mark as newly added
            //    };

            //    if (!newSurgery.DoctorName || !newSurgery.SurgeryDate || !newSurgery.SurgeryName) {
            //        alert("Please fill in Doctor Name, Date, and Surgery Name.");
            //        return;
            //    }

            //    surgeryDataList.push(newSurgery);
            //    BindData(surgeryDataList);
            //    cleardata();
            //    $('#surgeryModal').fadeOut();

            //});
            $("#btnSaveSurgery").on("click", function () {
                const newSurgery = {
                    MRNO: mrno,
                    UniqueId: $("#txtUniqueID").val(),
                    SurgeonDoctorName: $("#txtDoctorName").val().trim(),
                    SurgeryDate: $("#txtSurgeryDate").val(),
                    SurgeryName: $("#txtSurgeryName").val().trim(),
                    SurgeryNotes: encodeURIComponent($("#txtNotes").val().trim()),
                    gact: "N",
                };
                SaveSurgicalHistory(newSurgery);
                cleardata();
                $('#surgeryModal').fadeOut();

            });

            $("#btnUpdateSurgery").on("click", function () {
                const newSurgery = {
                    MRNO: mrno,
                    UniqueId: $("#txtUniqueID").val(),
                    SurgeonDoctorName: $("#txtDoctorName").val().trim(),
                    SurgeryDate: $("#txtSurgeryDate").val(),
                    SurgeryName: $("#txtSurgeryName").val().trim(),
                    SurgeryNotes: encodeURIComponent($("#txtNotes").val().trim()),
                    gact: "E",
                };
                SaveSurgicalHistory(newSurgery);
                cleardata();
                $('#surgeryModal').fadeOut();
            });


            //open the model
            $('#btnAddRecord').click(function () {
                cleardata();
                $('#surgeryModal').fadeIn();
            });

            $('#closeModal').click(function () {
                $('#surgeryModal').fadeOut();
            });

            // Optional: close when clicking outside modal
            //$(document).mouseup(function (e) {
            //    var modal = $(".custom-modal-box");
            //    if (!modal.is(e.target) && modal.has(e.target).length === 0) {
            //        $('#surgeryModal').fadeOut();
            //    }
            //});


           
            $(".tab-panel").hide();
            $("#divSurgInfo").show();
            GetBindingData(mrno);

            $("#TabSurg").click(function () {
                $(".tab-panel").hide();
                $("#divSurgInfo").show();
                $("#btnAddRecord").css("visibility", "visible");
                GetBindingData($.session.get('PatMRNO'));
            });

            $("#TabChemo").click(function () {
                $(".tab-panel").hide();
                $("#divChemoInfo").show();
                $("#btnAddRecord").css("visibility", "hidden"); 
                PatMedicationHistory(); 
            });

            $("#TabRadiation").click(function () {
                $(".tab-panel").hide();
                $("#btnAddRecord").css("visibility", "hidden"); 
                $("#divRadiationInfo").show();
            });

            $("#TabPAC").click(function () {
                $(".tab-panel").hide();
                GetPACHistoryLst();
                $("#btnAddRecord").css("visibility", "hidden"); 
                $("#divPACInfo").show();
            });

            $(".btn-Tabs").click(function () {
                $(".btn-Tabs").removeClass("active");
                $(this).addClass("active");
            });
        });

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
        function GetBindingData(strMrNo) {
            HoldOn.open();
            $.ajax({
                type: "get",
                datatype: "json",
                url: 'GetSurgicalHistoryData',
                data: { strMrNo: strMrNo },
                success: function (response) {

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
                    autoResizeTextareas();

                },
                complete: function () { HoldOn.close(); },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
            });
        }
        function BindData(dataList) {
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

        var editIndex = -1; // Track which index is being edited

        function editSurgeryRecord(index) {
            $('#surgeryModal').fadeIn();
            const item = surgeryDataList[index];
            if (!item) return;

            $("#txtUniqueID").val(item.UniqueId);

            $("#txtDoctorName").val(item.SurgeonDoctorName);
            $("#txtSurgeryDate").val(item.SurgeryDate);
            $("#txtSurgeryName").val(item.SurgeryName);
            $("#txtNotes").val(decodeURIComponent(item.SurgeryNotes || ''));

            editIndex = index;
            $("#btnSaveSurgery").hide();
            $("#btnUpdateSurgery").show();

        }

        function SaveSurgicalHistory(datatosend) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: 'SaveSurgicalHistory',
                contentType: "application/json",
                data: JSON.stringify(datatosend),
                success: function (response) {
                    $.messager.alert('Information', response);
                    var mrno = ($.session.get('PatMRNO'));
                    GetBindingData(mrno);
                },
                complete: function () { HoldOn.close(); },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
            });
        }
        function SetpageDirctn() {
            window.location.href = '../DoctorDesk/PatientEntry';
        }
        function autoResizeTextareas() {
            $(".auto-expand").each(function () {
                this.style.height = 'auto'; // Reset height
                this.style.height = Math.max(this.scrollHeight, 100) + 'px'; // Apply new height
            });
        }

        function PatMedicationHistory() {
            var mrno = $.session.get('PatMRNO');
            $("#chemoInfoContainer").empty();
            HoldOn.open();

            $.ajax({
                type: "POST",
                url: 'GetchemoHistory',
                datatype: "json",
                data: { strMrNo: mrno },
                success: function (result) {
                    console.log(result);
                    BindChemoData(result);
                },
                complete: function () { HoldOn.close(); },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert(textStatus, "Error");
                    HoldOn.close();
                }
            });
        }

        function BindChemoData(dataList) {
            var html = "";

            if (Array.isArray(dataList) && dataList.length > 0) {
                var totalCycle = dataList.length;
                var currentCycle = dataList.filter(x => x.CYCLENO && x.CYCLENO.trim() !== "").length;
                var pendingCycle = totalCycle - currentCycle;

                // 🔹 Summary header
                html += `
                    <div style='background-color: #28666e; color: white; padding: 10px; font-weight: bold; font-size: 14px; border-radius: 6px; margin-bottom: 10px; display: flex; justify-content: space-between;'>
                        <span>✅ Total Cycle: ${totalCycle}</span>
                        <span>✔️ Complete Cycle: ${currentCycle}</span>
                        <span>⏳ Pending Cycle: ${pendingCycle}</span>
                    </div>
                `;

                // 🔁 Each record
                $.each(dataList, function (i, item) {
                    html += `<div class="chemo-card" style="border:1px solid #ccc; border-radius:6px; margin-bottom:10px; overflow:hidden;">`;

                    // Header
                    html += `<div class="chemo-card-header" style="background-color:#28666e; color:white; padding:6px 10px; font-weight:bold; font-size:14px; display:flex; justify-content:space-between;">`;

                    if (item.CYCLENO && item.CYCLENO.trim() !== "") {
                        html += `<span style="color:#b9ffb1; font-size:1.2em;"><i class="fa fa-check"></i></span>
                                 <span>Plan No : ${item.PLANID} (IP VISIT)</span>
                                 <span>Date: ${formatDate(item.TRANDATE)} &nbsp;&nbsp; CycleNo : ${item.CYCLENO}</span>`;
                    } else {
                        html += `<span style="color:#b9ffb1; font-size:1.2em;"><i class="fa fa-check"></i></span>
                                 <span>Plan No : ${item.PLANID} (OP VISIT)</span>
                                 <span>Date: ${formatDate(item.TRANDATE)}</span>`;
                    }

                    html += `</div>`; // header

                    // Body (always visible → removed display:none)
                    html += `<div class="chemo-card-body" style="background:#fff; padding:10px 15px; font-size:14px;">`;

                    if (item.CYCLENO && item.CYCLENO.trim() !== "") {
                        html += `<div class="surgery-SurgeryName-info-box">
                        Day: ${item.DAY} &nbsp;&nbsp; Start Date: ${formatDate(item.STARTDATE)} &nbsp;&nbsp; End Date: ${formatDate(item.ENDDATE)}
                        </div>
                        <div style="margin-bottom:10px;"><b>Chemotherapy Name:</b> ${item.NAME}</div>
                        <div><b>Protocol:</b><br>
                            <div style="border:1px solid #ccc; padding:10px; background-color:#f9f9f9; font-size:13px; line-height:1.6; white-space:pre-wrap;">
                                ${item.PROTOCOL}
                        </div>
                    </div>`;
                    } else {
                        html += `<div><b>Modification During Treatment:</b><br>
                                    <div style="border:1px solid #ccc; padding:10px; background-color:#f9f9f9; font-size:13px; line-height:1.6; white-space:pre-wrap;">
                                        ${item.MODIFYMEDS}
                        </div>
                     </div>`;
                    }

                    html += `</div></div>`; // body + card
                });
            } else {
                html = `<div style="font-size:20px; text-align:center; font-weight:bold; color:#555;">No History Found for this record</div>`;
                }

            $("#chemoInfoContainer").html(html);
        }


        function formatDate(yyyymmdd) {
            if (!yyyymmdd || yyyymmdd.length !== 8) return yyyymmdd; // fallback
            var year = yyyymmdd.substring(0, 4);
            var month = yyyymmdd.substring(4, 6);
            var day = yyyymmdd.substring(6, 8);
            return day + "-" + month + "-" + year;
        }
      
    </script>



    <%-- PAC History --%>
    <script type="text/javascript">
        function GetPACHistoryLst(){
            var mrno = $.session.get('PatMRNO');
            HoldOn.open();
            var PACHistList =[];
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/GetPACHistory',
                datatype: "json",
                async:false,
                data: { Mrno: mrno },
                success: function (result) {
                    PACHistList = result == "" ? [] : result;
                },
                complete: function () { HoldOn.close(); },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert(textStatus, "Error");
                    HoldOn.close();
                }
            });
            BindPACHistoryList(PACHistList);
            HoldOn.close();
        }

        function BindPACHistoryList(PACHistList) {
            $("#TBodyPACHist").empty();
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCCONTENT}</td>";
            $.grep(PACHistList, function (a) {
                var RplIcon = "<i class='fa fa-eye IFrameEyeIcon' onclick=\"openIframe('" + a.MRNO + "','"+ a.PACCONSNO+ "','"  + a.PACFITDATE+ "','" + a.PACFITTIME  + "')\"></i>";
                var RplIconTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", RplIcon);
                var RplTranNoTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.PACCONSNO);
                var RplRefDoctTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.DOCTNAME);
                var RplSurgAdvDTTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.SURGADVDATE);
                var RplSurgeryTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.SURGNMADVICE);
                var NatOfSurg = a.SURGADVTYPE == "R" ? "Regular" : (a.SURGADVTYPE == "E" ? "Emergency" : (a.SURGADVTYPE == "T" ? "Tentative" : ""))
                var RplNatOfSurgTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", NatOfSurg);
                var PacStatus = a.PACSTATUS == "F" ? "Fit" : (a.PACSTATUS == "W" ? "Fit, with Accepted Risk" : (a.PACSTATUS == "U" ? "UnFit": "Pending"))
                var RplPacStatusTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", PacStatus);
                var RplPacStatusDTTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", (a.PACFITDATE + " " + a.PACFITTIME));
                var RplCreatedByTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.PACDONEBY);
                var RplTr = Tr.replace("{TRCONTENT}", (RplIconTd + RplTranNoTd + RplRefDoctTd + RplSurgAdvDTTd + RplSurgeryTd + RplNatOfSurgTd + RplPacStatusTd + RplPacStatusDTTd + RplCreatedByTd));
                $("#TBodyPACHist").append(RplTr);
            });
        }

        function openIframe(Mrno, TranNo,PACDate , PACTime) {
            const iframeMain = document.getElementById('iframeMain');
            iframeMain.style.display = 'block';
            iframeMain.classList.remove('minimized');
            $("#iframeContainer").empty();
            document.getElementById('PACHistFrameLbl').innerText = TranNo + " ("+PACDate + " " + PACTime+")";
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

        function minimizeIframe() {
            const container = document.getElementById('iframeMain');
            container.classList.toggle('minimized');
        }
    </script>

    <style>
                .Tablewrapper {
            overflow-x: auto;
            width: 100%;
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

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div style="display: flex; justify-content: space-between; align-items: center; margin: 10px 0;">
        <!-- Back Button (Left) -->
        <a class="button1 button1-green" id="divForBack" onclick="SetpageDirctn()">
            <i class="fa fa-arrow-left"></i>Back
        </a>

        <div class="tab-container">
            <button type="button" id="TabSurg" class="btn-Tabs active">Surgical</button>
            <button type="button" id="TabChemo" class="btn-Tabs">Chemo</button>
            <button type="button" id="TabRadiation" class="btn-Tabs">Radiation</button>
            <button type="button" id="TabPAC" class="btn-Tabs">PAC</button>
        </div>

          <!-- Add Surgery History Button (Right) -->
        <button type="button" id="btnAddRecord" class="btn-add">➕ Add Surgery History</button>
    </div>



    <!-- Modal Overlay and Box -->
    <div id="surgeryModal" class="custom-modal-overlay" style="display: none;">
        <div class="custom-modal-box">
            <span class="close-modal" id="closeModal">&times;</span>
            <h4>Add Surgical History</h4>

            <div class="form-row">
                <div class="form-group">
                    <label for="txtDoctorName">Doctor Name:</label>
                    <input type="text" id="txtDoctorName" class="input-field" placeholder="Enter doctor name" />
                </div>
                <div class="form-group" style="display: none">
                    <label for="txtUniqueID">Unique ID:</label>
                    <input type="text" id="txtUniqueID" class="input-field" placeholder="Unique Id" />
                </div>
                <div class="form-group">
                    <label for="txtSurgeryDate">Surgery Date:</label>
                    <input type="text" id="txtSurgeryDate" class="input-field" readonly />
                </div>
            </div>

            <div class="form-group">
                <label for="txtSurgeryName">Surgery Name:</label>
                <input type="text" id="txtSurgeryName" class="input-field" placeholder="Enter surgery name" />
            </div>

            <div class="form-group">
                <label for="txtNotes">Notes:</label>
                <textarea id="txtNotes" class="input-field" rows="3" placeholder="Enter notes" maxlength="748"></textarea>
            </div>

            <%-- <button type="button" id="btnAddSurgery" class="btn-add">➕ Add</button>--%>
            <button type="button" id="btnSaveSurgery" class="btn-add">💾 Save</button>

            <button type="button" id="btnUpdateSurgery" class="btn-add" style="display: none;">🔁 Update</button>
        </div>
    </div>



    <%--<div id="surgeryInfoContainer"></div>--%>

    <div id="tabContent">
        <div id="divSurgInfo" class="tab-panel" style="display: none;">
            <div id="surgeryInfoContainer"></div>
        </div>

        <div id="divChemoInfo" class="tab-panel" style="display: none;">
            <div id="chemoInfoContainer"></div>
        </div>

        <div id="divRadiationInfo" class="tab-panel" style="display: none;">
            No Data Found.
        </div>

        <div id="divPACInfo" class="tab-panel" style="display: none;">
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

</asp:Content>
