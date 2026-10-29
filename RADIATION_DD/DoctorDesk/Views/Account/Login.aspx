<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.AccountModel>" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <link href="<%=ResolveUrl("~/JQueryUi/jquery.ui.theme.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/JQueryUi/jquery.ui.css")%>" rel="stylesheet" />

    <!-- Font Awesome -->
    <link href="<%=ResolveUrl("~/font-awesome/css/font-awesome.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/font-awesome/css/font-awesome.min.css")%>" rel="stylesheet" />
    <!-- Ionicons -->
    <link href="<%=ResolveUrl("~/bootstrap/Icon.css")%>" rel="stylesheet" />

    <link href="<%=ResolveUrl("~/LoadingCursor/css/style.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/Styles/multi-select.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/plugins/select2/select2.css")%>" rel="stylesheet" />
    <!-- Theme style -->
    <link href="<%=ResolveUrl("~/dist/css/AdmidnLTE.css")%>" rel="stylesheet" />

    <link href="<%=ResolveUrl("~/dist/css/skins/skin-blue.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/dist/css/skins/skin-yellow.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/jqGrid/css/ui.jqgrid.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/Styles/jqGrid.bootstrap.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/Styles/bootstrap.css")%>" rel="stylesheet" />

    <script src="<%=ResolveUrl("~/Scripts/jquery-1-10-2.js")%>"></script>
    <script src="<%=ResolveUrl("~/dist/js/app.min.js")%>"></script>
    <script src="<%=ResolveUrl("~/css/Toaster/dist/main.js")%>"></script>
    <script src="<%=ResolveUrl("~/css/Toaster/src/Toast.js")%>"></script>
    <link href="<%=ResolveUrl("~/css/Toaster/src/toasts.css")%>" rel="stylesheet" />
   <script src="<%=ResolveUrl("~/bootstrap/js/bootstrap.min.js")%>"></script>
    <script src="<%=ResolveUrl("~/bootstrap/js/jquery.messager.js")%>"></script>
    <script src="<%=ResolveUrl("~/bootstrap/js/dropdown.js")%>"></script>
    <script src="<%=ResolveUrl("~/Scripts/jquery-1-11-1-ui.js")%>"></script>
    <script src="<%=ResolveUrl("~/plugins/slimScroll/jquery.slimscroll.js")%>"></script>
    <script src="<%=ResolveUrl("~/plugins/input-mask/jquery.inputmask.js")%>"></script>
    <script src="<%=ResolveUrl("~/plugins/input-mask/jquery.inputmask.date.extensions.js")%>"></script>
    <script src="<%=ResolveUrl("~/plugins/input-mask/jquery.inputmask.regex.extensions.js")%>"></script>
    <script src="<%=ResolveUrl("~/plugins/input-mask/jquery.inputmask.extensions.js")%>"></script>
    <script src="<%=ResolveUrl("~/jqGrid/js/i18n/grid.locale-en.js")%>"></script>
    <script src="<%=ResolveUrl("~/jqGrid/js/jquery.jqGrid.min.js")%>"></script>
    <script src="<%=ResolveUrl("~/LoadingCursor/jquery-loader.js")%>"></script>
    <script src="<%=ResolveUrl("~/Scripts/multi-select.js")%>"></script>
    <script src="<%=ResolveUrl("~/plugins/select2/select2.full.min.js")%>"></script>
    <link rel="shortcut icon" type="image/png" href="../../Images/favicon.ico">
     <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
    <title>EHR Login</title>

    <style type="text/css">
        /* MODERN LOGIN STYLES */
        
        /* 1. Body: Flex Container */
        body.mdn-body-bg {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', 'Helvetica Neue', sans-serif;
            overflow-x: hidden; 
        }

        /* 2. Wrapper: Ensures full centering inside body */
        .mdn-full-wrapper {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* 3. Form: Must allow centering of children */
        #LoginForm {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* 4. Card: The actual white box */
        .mdn-login-card {
            background: white;
            width: 100%;
            max-width: 420px; /* Desktop Width */
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            text-align: center;
            position: relative;
            z-index: 10;
            margin: 0 auto; /* Horizontal Center Backup */
        }

        /* Responsive Logic */
        @media screen and (max-width: 480px) {
            .mdn-login-card {
                max-width: 90%; /* On mobile, take 90% of screen */
                padding: 20px;
                margin: 20px;
            }
        }

        /* Branding */
        .mdn-logo-container img {
            max-width: 160px;
            height: auto;
            margin-bottom: 15px;
        }

        .mdn-title-main {
            color: #2c3e50;
            font-size: 24px;
            font-weight: 700;
            margin: 0;
            letter-spacing: -0.5px;
        }

        .mdn-title-sub {
            color: #7f8c8d;
            font-size: 13px;
            margin-top: 5px;
            margin-bottom: 25px;
            font-weight: 500;
        }

        .mdn-divider {
            height: 1px;
            background: #e0e0e0;
            margin: 20px 0;
            width: 100%;
        }

        .mdn-login-header {
            color: #34495e;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 20px;
            display: block;
        }

        /* Inputs */
        .mdn-input-group {
            margin-bottom: 15px;
            position: relative;
            width: 100%; /* Ensure inputs fill the card */
        }

        .mdn-input-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #dce4ec;
            border-radius: 6px;
            font-size: 14px;
            color: #34495e;
            background: #f9f9f9;
            transition: all 0.3s ease;
            box-sizing: border-box; 
            text-align: center;
        }

        .mdn-input-control:focus {
            background: #fff;
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .mdn-input-control::placeholder {
            color: #95a5a6;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 1px;
        }

        /* Buttons */
        .mdn-btn-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-top: 20px;
        }

        .mdn-btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .mdn-btn-primary {
            background: #007cc3;
            color: white;
            box-shadow: 0 4px 6px rgba(0, 124, 195, 0.2);
        }

        .mdn-btn-secondary {
            background: #fff;
            color: #007cc3;
            border: 1px solid #007cc3;
        }

        .mdn-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        /* Legacy Overrides */
        .MaincontSize { width: 100% !important; margin: 0 !important; box-shadow: none !important; background: transparent !important; }
        .noTitleStuff .ui-dialog-titlebar { display: none; }
        .loadingScreenWindow .ui-dialog-titlebar-close { display: none; }
        #loadingScreen { background: url(../Images/ajax-loader.gif) no-repeat 6px 4px; padding-left: 25px; margin: 30px; color: black; font-weight: bold; }
        .ui-widget-overlay { opacity: 0.5; }
        .select2 { font-size: 12px !important; }
    </style>

</head>
<body class="mdn-body-bg">
    <script type="text/javascript">
        var DoctrClinc;
        var NewUIRedirectYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("AutoCompltPrescript")%>';
        $(document).ready(function (event) {



           $('.MaincontSize').css('height', function () {
                if ($(window).width() < 450) {
                    return ($(window).height() - 15);
                }
            });

            $('.MaincontSize').css('margin-top', function () {
                if ($(window).width() < 450)
                    return 10;
                else
                    return ($(window).height() - $(this).height()) / 2;
            });

            //$('.MaincontSize').css('height', function () {
            //    if ($(window).width() < 450) {
            //        return ($(window).height() + 50);
            //    }
            //});

            $('.HeaderFont').css('height', function () {
                if ($(window).width() < 450) {
                    return ($(window).height()-30);
                }
            });

            $('#txtUserID').focus();

            $('.HeaderFont').css('width', function () {
                if ($(window).width() < 450) {
                    return ($(window).width());
                }
            });

            $('.MaincontSize').css('width', function () {
                if ($(window).width() < 450) {
                    return ($(window).width());
                }
            });

            if (localStorage.getItem('DDUSERID') != null && localStorage.getItem('DDUSERID') != '') {
                //$("#txtUserID").val(localStorage.getItem('DDUSERID'))
                //$("#headLabel")[0].textContent="Welcome, Dr. " + localStorage.getItem('DDNAME')
                window.location.replace("../Account/PINLogin");
            }
            $("#loadingScreen").dialog({
                autoOpen: false,    // set this to false so we can manually open it
                dialogClass: "loadingScreenWindow",
                closeOnEscape: false,
                draggable: false,
                width: 200,
                position: {
                    my: "center",
                    at: "center",
                    of: window
                },
                minHeight: 50,
                modal: true,
                buttons: {},
                resizable: false,
                dialogClass: 'noTitleStuff',
                open: function () {
                    // scrollbar fix for IE
                    $('#loadingScreen').parent().css('border', 'none');
                    $('#loadingScreen').parent().css('background', 'none');
                    $('body').css('overflow', 'hidden');
                },
                close: function () {
                    // reset overflow
                    $('body').css('overflow', 'auto');
                }
            }); // end of dialog

            if (("" + ('<%= Session["USERID"]%>')).toString() != "") {
                ToastMsg("You have already logged in..", "Information");
                //  window.location.href = "about:blank";
            }

            $('#txtPwd').keypress(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    $('#btnLogin').click();
                    event.preventDefault();
                }
            });
            $('#txtPwd').keydown(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);

                if (keycode == '90') {
                    //$('#btnLogin').click();
                    $('#txtPwd').val("");
                    event.preventDefault();
                }
            });//
            $('#txtUserID').keypress(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    $('#btnLogin').click();
                    event.preventDefault();
                }
            });

            $('#btnContinue').click(function () {
                var ClincCode = $("#cmbComplaint")[0].value;
                window.location.replace("../DoctorDesk/PatientEntry?DoctrClincStr=" + ClincCode);
                //$.ajax({
                //    url: '../Oncology/PatientEntry',                 

                //    data: {'DoctrClincStr': ClincCode },

                //    success: function (result) {
                //        $.loader.close();

                //        if (result.Status == "Failed") {
                //            $.messager.alert("Information", result.Message);
                //        }
                //        else {

                //            window.location.href = result.Message;
                //        }
                //    },
                //    error: function (xhr, textStatus, errorThrown) {

                //        $.loader.close();
                //    }

                //});
            })
            $('#btnLogin').click(function () {
                //var elem = document.getElementById("btnLogin");       //unnati   -- to make it full screen
                //if (elem.requestFullscreen) {
                //    elem.requestFullscreen();
                //} else if (elem.msRequestFullscreen) {
                //    elem.msRequestFullscreen();
                //} else if (elem.mozRequestFullScreen) {
                //    elem.mozRequestFullScreen();
                //} else if (elem.webkitRequestFullscreen) {
                //    elem.webkitRequestFullscreen();
                //}
                var status = checkValid();
                if (status == true) {
                    // $('#blnkNewNotes').click();
                    CheckLogin();

                }

            });

            $("#btnRegister").click(function () {
                var status = checkValid();
                if (status == true) {
                    CheckPINLogin();
                }
            });
        })

        function waitingDialog(waiting) { // I choose to allow my loading screen dialog to be customizable, you don't have to
            $("#loadingScreen").html('Processing...');
            $("#loadingScreen").dialog('open');
        }

        function closeWaitingDialog() {
            $("#loadingScreen").dialog('close');
        }


        function CheckLogin() {
            //debugger;
            $.loader.open();
            var urls = "<%=Url.Action("GetLoginCheck","Account")%>";
            var formData = $("#LoginForm").serialize();
            $.ajax({
                type: "POST",
                url: urls,

                data: formData,
                success: function (response) {
                    $.loader.close();
                    if (response == "false") {
                        closeWaitingDialog();
                        ToastMsg("Invalid Credentials.", "error");
                    }
                    else if (response == "doctor") {
                        if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("NewUI")%>' == "Y") {
                            window.location.replace("<%=Url.Action("SinglePageMenuList", "SinglePage")%>");
                        }
                        else
                        {
                            window.location.replace("<%=Url.Action("MenuList", "Account",new { pageId = "Menu" })%>");
                        }
                    }
                    else if (response == "staff") {
                        window.location.replace("<%=Url.Action("ClinicEntry", "ClinicalNotes")%>");
                    }
                    else {
                        closeWaitingDialog();
                        ToastMsg(response, "Information");
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    ToastMsg(errorThrown, "Error");
                }
            });
        }

        function CheckPINLogin() {
            $.loader.open();
            var urls = "<%=Url.Action("GetLoginCheck","Account")%>";
            var formData = $("#LoginForm").serialize();
            $.ajax({
                type: "POST",
                url: urls,
                data: formData,
                success: function (response) {
                    $.loader.close();
                    if (response == "false") {
                        closeWaitingDialog();
                        ToastMsg("Invalid Credentials.", "Error");
                    }
                    else if (response == "doctor") {
                        localStorage.setItem('TEMPUSERID', $("#txtUserID").val());
                        window.location.replace("<%=Url.Action("SetPIN", "Account")%>");
                    }
                    else if (response == "doctwp") {
                        localStorage.setItem('DDUSERID', $("#txtUserID").val());
                        window.location.replace("<%=Url.Action("PINLogin", "Account")%>");
                    }
                    else if (response == "staff") {
                        window.location.replace("<%=Url.Action("ClinicEntry", "ClinicalNotes")%>");
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    ToastMsg(errorThrown, "Error");
                }
            });
        }

        function checkValid() {
            var i = 0;
            if ($("#txtUserID").val() == '') {
                $("#txtUserID").css("border-color", "red");
                $("#txtUserID").focus();
                i = 1;
            }
            if ($("#txtPwd").val() == '') {
                $("#txtPwd").css("border-color", "red");
                $("#txtPwd").focus();
                i = 1;
            }

            if ($("#cmbStore").val() == '') {
                $("#cmbStore").css("border-color", "red");
                $("#cmbStore").focus();
                i = 1;
            }

            if (i == 1)
                return false;
            else
                return true;
        }

    </script>

    <div class="mdn-full-wrapper">
        <form id="LoginForm" runat="server" action="./">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            
            <div class="mdn-login-card">
                
                <div class="MaincontSize HeaderFont">
                    
                    <div class="mdn-logo-container">
                        <img src="../Images/CompLogo.png" alt="Logo">
                    </div>

                    <h1 class="mdn-title-main">Electronic Health Records</h1>
                    <p class="mdn-title-sub">(Patient Management at Doctor's Workstation)</p>

                    <div class="mdn-divider"></div>

                    <span class="mdn-login-header">Sign In to Your Account</span>

                    <div class="mdn-input-group">
                        <%:Html.TextBoxFor(x => Model.UserID, new { 
                            id="txtUserID", 
                            @placeholder="USER ID",
                            @class="mdn-input-control", 
                            @autocomplete="off",
                            @Style="text-transform: uppercase;"
                        })%>
                    </div>

                    <div class="mdn-input-group">
                        <%:Html.PasswordFor(x => Model.Password, new { 
                            id = "txtPwd",
                            @maxlength="15", 
                            @class="mdn-input-control", 
                            @autocomplete="off", 
                            @placeholder="PASSWORD"
                        })%>
                    </div>

                    <div class="mdn-btn-group">
                        <input type="button" name="btnSave" id="btnLogin" class="mdn-btn mdn-btn-primary" value="Sign In" />
                        <input type="button" name="btnSave" id="btnRegister" class="mdn-btn mdn-btn-secondary " style="display:none" value="Register" />
                    </div>

                    <div style="margin-top:20px; opacity:0.3;">
                         <input type="button" data-toggle="modal" data-target="#mdNewNotes" id="blnkNewNotes" style="background:none; border:none; color:#ccc; font-size:10px;" value="DDS" />
                    </div>

                </div>
            </div>

            <div class="modal fade" id="mdNewNotes" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Select Clinic</h4>
                        </div>
                        <div class="modal-body">
                            <label>Clinic</label>
                            <select id="cmbComplaint" class="form-control" style="width:100%"></select>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="btnContinue" class="btn btn-primary btn-block">Continue</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="loadingScreen" style="display:none;"></div>
        </form>
    </div>
          <div id="ToasterContainer" class="DivToasterContainer" style="display: none"></div>
</body>
</html>

