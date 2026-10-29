<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <html>
    <head>
        <title></title>
    </head>
    <body>

        <div style="width: 100%; text-align: center">
            <a class="button1 button1-green" id="divForBack" style="margin-bottom: 1.5%;" onclick="SetpageDirctn()">
                <i class="fa fa-arrow-left"></i>
                <strong>Back</strong>
            </a>
        </div>

        <div id="MainDiv">
            <label for="file">Upload File:</label>
            <div> 
            <input type="file" name="file" id="file" accept="image/jpeg, application/pdf" /> <br>
                <input type="button" id="btnUpload" value="Upload File" class="btn-primary" /></div>
             <br>
            <div id="wrapper" style="width: 48%;float:left;border:1px solid #3c8dbc;">
                <h5>Attachments</h5>
                <div class="tableDiv">
                    <table id="tbl" class="table" style="width: 100%">
                        <tbody id="tblsort"></tbody>
                    </table>
                </div>
            </div>
            <%--  <div id="wrapper1" style="width: 100%">
                <div class="tableDiv">
                    <table id="tbl1" class="table" style="width: 100%">
                        <tbody id="tblsort1"></tbody>
                    </table>
                </div>
            </div>--%>
             <div id="Dissum" style="width: 48%;margin-left:20px;float:left;border:1px solid #3c8dbc;">
                <h5>Discharge Summary</h5>
                <div class="tabledisSum">
                    <table id="tbldisSum" class="table" style="width: 100%">
                        <tbody id="tbldisumlist"></tbody>
                    </table>
                </div>
            </div>
        </div>

    </body>
    </html>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .btn-primary {
            color: #fff;
            background-color: #3c8dbc;
            border-color: #3c8dbc;
        }
         Label {
            margin-left: 5px;
        }
    </style>
    <script src="../Scripts/PatList.js"></script>
        <%--<script src="../Scripts/Doctorlist.js"></script>--%>
    <script type="text/javascript">
        <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var MRNO = $.session.get('PatMRNO');
        var strDoctCodeDelRestrict = '<%:Session["gDoctCode"]%>';
        var File = $.parseJSON('<%:Html.Raw(Samp.Serialize(ViewBag.Attach))%>');
        <%--var LabFile = $.parseJSON('<%:Html.Raw(Samp.Serialize(ViewBag.LabAttach))%>');--%>
        var pathFrom = "";
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var savedFiles = $.parseJSON('<%:Html.Raw(Samp.Serialize(ViewBag.Attach))%>') || []; //priyanka 15/04/2026
        var newFiles = []; //priyanka 15/04/2026
        $(document).ready(function (e) {
            HoldOn.open();//
            var doctCode = $.session.get('DoctCode');//added on 31st march 2018
            var doctName = $.session.get('DoctName');//added on 31st march 2018
            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');

          
            SetPatientDtl();
            AddClinics(urls);
            //showFiles(File,"N");//priyanka 15/04/2026
            showFiles();
           
            //showLabFiles(LabFile); //Meenakshi
            HoldOn.close();
            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";
                $("#slide_sdList").hide();
            }

            if (pathFrom != "") {
              
              }
              else {
                var doctCd = ('<%:Session["gDoctCode"]%>').toString();
                SearchFunction(doctCd);
                $("#DoctorInput").css("display", "none");
                var leftSideNenuLst = document.getElementById('menuList');
                var rightSideMenuLst = document.getElementById('sideList');
                leftSideNenuLst.style.display = "none";
                rightSideMenuLst.style.display = "none";
            }

            // added by vijeta on 7th april 2018
            var lst = document.getElementById('sideList');
            window.onclick = function (event) {
                if (event.target == document.getElementById('menuDots') && pathFrom != "") {
                    lst.style.display = "block";
                }
                else {
                    if ($(window).width() >= 996 && pathFrom != "") {
                        lst.style.display = "block";
                    }
                    else
                        lst.style.display = "none";
                }
            }

             $('#btnUpload').click(function () {
                //getAttchments();
                HoldOn.open();//
                var formData = new FormData();
                var FNameLst = [];//priyanka 16/04/2026
                if (MRNO != "") {
                    var Name = [];
                    var formData = new FormData();
                    var file = document.getElementById("file").files;

                    var fileInput = document.getElementById("file");
                    var files = fileInput.files;
                    if (files.length === 0) {
                        HoldOn.close();
                        $.messager.alert("Information", "No File Selected.");
                        return false;
                       
                    } else {
                        var formData = new FormData();
                        formData.append("File", files[0]);
                        formData.append("Mrno", MRNO);

                        FNameLst = [files[0].name];//priyanka 16/04/2026

                        console.log("Selected file:", files[0].name);
                    }
                    //formData.append("File", file[0]);
                    //var totalFiles = document.getElementById("file").files;
                   
                    //formData.append("Mrno", MRNO);
                    //var FNameLst = [file[0].name];
                    
                    
                    $.ajax({
                        type: "POST",
                        url: '../DoctorDesk/UploadFile',
                        data: formData,
                        dataType: 'json',
                        contentType: false,
                        processData: false,
                        async: false,
                        success: function (response) {
                            $.messager.alert("Information", response.Message);
                            document.getElementById("file").value = "";

                            if (response.Message.includes("Successfully")) {
                                newFiles.push(FNameLst[0]);//priyanka 16/04/2026
                            }
                            else {
                                $("#tbl tr:last").remove();
                            }
                            //showFiles(Name);
                            HoldOn.close();
                        },
                        complete: function () { HoldOn.close(); },//
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            $.messager.alert("Error Information", textStatus);
                            HoldOn.close();
                        }
                    });
                    //showFiles(FNameLst,"Y");
                    showFiles();//priyanka 15/04/2026
                    HoldOn.close();
                }
            });

            $("#tbl").on('click', '.rmvFile', function () {
                HoldOn.open();//
                //var index = $(this).data("index");

                //if (index !== undefined) {
                //    newFiles.splice(index, 1);
                //}

                //$(this).closest("tr").remove();
                var row = $(this).closest("tr");
                var filename = row.find("td:first").text();

                $(this).parent().parent().remove();
                var datatosend = {
                    filename: $(this).context.parentElement.previousElementSibling.innerText,
                    Mrno: MRNO
                }
                $.ajax({
                    type: "POST",
                    url: '../DoctorDesk/RemoveFile',
                    data: datatosend,
                    async: false,
                    success: function (response) {
                        newFiles = newFiles.filter(f => f !== filename);
                        showFiles(); 
                        $.messager.alert("Information", response);
                    },
                    complete: function () {

                        HoldOn.close();//

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $.messager.alert("Error Information", textStatus);
                        HoldOn.close();
                    }
                });
            });
            GetDisSumPdfList();
        });


        function SetpageDirctn() {
            window.location.href = "../ClinicalNotes/ClinicEntry";
        }

        function GetDisSumPdfList()
        {
           // var MRNO = ($.session.get('PatMRNO'));
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/GetDisSummaryAttachment?MRNO=' + ($.session.get('PatMRNO')),
                data: { MRNO: "66591" },
                dataType: 'json',
                contentType: false,
                async: false,
                success: function (response) {
                    $('#tbldisumlist').empty();
                    if (response.FileNames && response.FileNames.length > 0) {
                        for (var i = 0; i < response.FileNames.length; i++) {
                            var fileName = response.FileNames[i];
                            var row = '<tr>' +
                                '<td>' + fileName + '</td>' +
                                '</tr>';
                            $('#tbldisumlist').append(row);
                        }
                        var basePath = response.Directory; // Use the directory from the response
                        showDisSummFiles(response.FileNames, basePath);
                    } else {
                        $('#tbldisumlist').append('<tr><td colspan="1">No files found.</td></tr>');
                    }
                },
                complete: function () { },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error Information", textStatus);
                    HoldOn.close();
                }
            });
        }

        //function showFiles(File, showDelete) {//priyanka 15/04/2026
        //    if (File != null) {
        //        $('#tbl tbody').empty();
        //        for (i = 0; i < File.length; i++) {
        //            var rows = "<tr> <td class='disp' style='cursor:pointer' onclick='openNewWin(this)'><u>" + File[i] + "</u></td>";
        //            //if (strDoctCodeDelRestrict!="")
        //            //    rows += "<td><a  href='javascript:void(0);' class='rmvFile'>Delete</a></td>";
        //            if (showDelete === "Y") {
        //                rows += "<td><a  href='javascript:void(0);' class='rmvFile'>Delete</a></td>";
        //            }

        //            rows += "<tr>";
        //            $('#tbl tbody').append(rows);
        //        }
        //        document.getElementById("file").value = "";
        //    }
        //}

        function showFiles() { //priyanka 15/04/2026
            $('#tbl tbody').empty();
            if (savedFiles != null) {
                for (let i = 0; i < savedFiles.length; i++) {
                    var row = "<tr>";
                    row += "<td class='disp'  style='cursor:pointer' onclick='openNewWin(this)'><u>" + savedFiles[i] + "</u></td>";
                    row += "</tr>";
                    $('#tbl tbody').append(row);
                }
            }

            for (let i = 0; i < newFiles.length; i++) {
                var row = "<tr>";
                row += "<td class='disp' onclick='openNewWin(this)'><u>" + newFiles[i] + "</u></td>";
                row += "<td><a href='javascript:void(0);' class='rmvFile' data-index='" + i + "'>Delete</a></td>";
                row += "</tr>";
                $('#tbl tbody').append(row);
            }
        }

        function getAttchments() { //priyanka 15/04/2026
            var mr = sessionStorage.getItem('PatMRNO');
            $.ajax({
                type: "Post",
                url: '../DoctorDesk/GetAttachment',
                dataType: 'json',
                async: false,
                data: { MRNO: mr },
                success: function (response) {
                    showFiles(response,"N");
                    //stopLoading("loading-Upload-popup");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                    //stopLoading("loading-upload-popup");
                }
            });
        }

        function showDisSummFiles(File, directory) {
            if (File != null) {
                $('#tbldisumlist').empty();
                for (var i = 0; i < File.length; i++) {
                    //var fileName = File[i];
                    //var fullPath = directory + "/" + fileName; // Create full path
                    //console.log("Full Path:", fullPath); // Debug log
                    //var row = "<tr><td class='disp' style='cursor:pointer' onclick='openNewWinForDSView(\"" + fullPath + "\")'><u>" + fileName + "</u></td></tr>";
                    //$('#tbldisumlist').append(row);

                    var rows = "<tr> <td class='disp' style='cursor:pointer' onclick='openNewWinForDSView(this)'><u>" + File[i] + "</u></td> <tr>";
                    $('#tbldisumlist').append(rows);
                }
            }
        }

        function openNewWinForDSView(obj) {
            NAME = obj.innerText;
            var MRNO = ($.session.get('PatMRNO'));
            var url = "../DoctorDesk/FileDownload?MRNo=" + MRNO + "&&filename=" + NAME + "&&fileType=D";
            window.open(url, 'Image/pdf', 'width=900px,height=600px,resizable=1');
            return Details;
        }


        function openNewWin(obj) {
            NAME = obj.innerText;
            var MRNO = ($.session.get('PatMRNO'));
            var url = "../DoctorDesk/FileDownload?MRNo=" + MRNO + "&&filename=" + NAME
            window.open(url, 'Image/pdf', 'width=900px,height=600px,resizable=1');
            return Details;
        }

        //function showLabFiles(File) {
        //    if (File != null) {
        //        $('#tbl1 tbody').empty();
        //        for (i = 0; i < File.length; i++) {
        //            var rows = "<tr> <td class='disp' style='cursor:pointer' onclick='openLabNewWin(this)'><u>" + File[i] + "</u></td><tr>";
        //            $('#tbl1 tbody').append(rows);
        //        }
        //    }
        //}

        //function openLabNewWin(obj) {
        //    NAME = obj.innerText;
        //    var MRNO = ($.session.get('PatMRNO'));
        //    var url = "../DoctorDesk/LabFileDownload?MRNo=" + MRNO + "&&filename=" + NAME
        //    window.open(url, 'Image/pdf', 'width=900px,height=600px,resizable=1');
        //    //var Details = '<a href=' + url + ' id="imgdownload" download=' + NAME + '>Download file</a>';
        //    return Details;
        //}


    </script>
</asp:Content>
