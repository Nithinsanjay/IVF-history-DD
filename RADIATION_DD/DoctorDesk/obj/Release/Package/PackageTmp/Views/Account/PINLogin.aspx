<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.AccountModel>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <link href="<%=ResolveUrl("~/JQueryUi/jquery.ui.theme.css")%>" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/Scripts/jquery-1-10-2.js")%>"></script>
    <script src="<%=ResolveUrl("~/Scripts/jquery-1-11-1-ui.js")%>"></script>
    <link href="<%=ResolveUrl("~/Styles/bootstrap.css")%>" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/LoadingCursor/jquery-loader.js")%>"></script>
    <script src="<%=ResolveUrl("~/bootstrap/js/jquery.messager.js")%>"></script>
    <link rel="shortcut icon" type="image/png" href="../Images/favicon.ico">

    <meta name="viewport" content="width=device-width" />
    <title>Doctor Login</title>

    <style type="text/css">
        input:focus,
        select:focus {
            outline: none;
        }

        .noTitleStuff .ui-dialog-titlebar {
            display: none;
        }

        .loadingScreenWindow .ui-dialog-titlebar-close {
            display: none;
        }

        #loadingScreen {
            background: url(../Images/ajax-loader.gif) no-repeat 6px 4px;
            padding-left: 25px;
            margin: 30px;
            color: black;
            font-weight: bold;
        }

        .ui-widget-overlay {
            opacity: 0.5;
        }

        @media only screen and (min-width : 992px) {

            .HeaderHeight {
                height: 72px;
            }

            .LogoSize {
                height: 51px;
                width: 145px;
            }

            .MaincontSize {
                width: 900px;
                top: 74px;
                margin-right: auto;
                margin-left: auto;
            }

            .ComLnkDivmargin {
                margin-right: auto;
                margin-left: auto;
                width: 970px;
            }
        }


        /*Potrait*/

        /* Smartphones (portrait and landscape) ----------- */
        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {

            .HeaderHeight {
                height: 72px;
            }

            .LogoSize {
                height: 45px;
                width: 100px;
            }

            .MaincontSize {
                width: 400px;
                top: 70px;
                margin-right: auto;
                margin-left: auto;
            }

            .ComLnkDivmargin {
                margin-right: auto;
                margin-left: auto;
                width: 450px;
            }
        }

        /* Smartphones (landscape) ----------- */
        @media only screen and (min-width : 600px) {
            .HeaderHeight {
                height: 22px;
            }

            .LogoSize {
                height: 45px;
                width: 100px;
            }

            .MaincontSize {
                width: 510px;
                top: 70px;
                margin-left: auto;
                margin-right: auto;
            }

            .ComLnkDivmargin {
                margin-right: auto;
                margin-left: auto;
                width: 580px;
            }

            .TextbxSize {
                width: 200px;
                height: 18px;
            }

            .pwdTextbxSize {
                width: 210px;
                height: 25px;
            }
        }

        /* Desktops and laptops ----------- */
        @media only screen and (min-width : 1200px) {
            .HeaderHeight {
                height: 72px;
            }

            .BannerHeight {
                height: 455px;
            }

            .LogoSize {
                height: 51px;
                width: 145px;
            }

            .MaincontSize {
                width: 1110px;
                top: 68px;
                margin-right: auto;
                margin-left: auto;
            }

            .ComLnkDivmargin {
                margin-right: auto;
                margin-left: auto;
                width: 1170px;
            }

            .HeaderFont {
                font-size: 24px;
                letter-spacing: 1px;
            }

            .TextbxSize {
                width: 305px;
                height: 29px;
                font-size: 14px;
            }
        }

        /* iPads (portrait and landscape) ----------- */
        @media only screen and (min-device-width : 768px) and (max-device-width : 1024px) {
            .HeaderHeight {
                height: 72px;
            }

            .LogoSize {
                height: 51px;
                width: 145px;
            }

            .MaincontSize {
                width: 900px;
                top: 68px;
                margin-right: auto;
                margin-left: auto;
            }

            .ComLnkDivmargin {
                margin-right: auto;
                margin-left: auto;
                width: 940px;
            }

            .BannerHeight {
                height: 400px;
            }
        }

        @media only screen and (min-width:1500px) {
            .MaincontSize {
                width: 1000px;
                top: 70px;
                margin-right: auto;
                margin-right: auto;
            }

            .ComLnkDivmargin {
                margin-right: auto;
                margin-left: auto;
                width: 1030px;
            }
        }

        /* Large screens ----------- */
        @media only screen and (min-width : 1824px) {
            .MaincontSize {
                width: 1450px;
                top: 70px;
                margin-right: auto;
                margin-left: auto;
            }

            .ComLnkDivmargin {
                margin-right: auto;
                margin-left: auto;
                width: 1500px;
            }
        }

        .BtnFormat {
            color: #fdfdfd;
            width: 200px;
            border-style: solid;
            border-color: #C3C2C1;
            background: #007cc3;
            padding: 5px;
            font-size: 12px;
            font-weight: bold;
        }

            .BtnFormat:hover {
                background-color: #1f1e1e !important;
                color: white;
                border: none;
                box-shadow: 6px 8px 6px #c1bfbf;
                padding: 7px;
                cursor: pointer;
            }

        .select2 {
            font-size: 10px !important;
        }
    </style>

</head>
<body>

    <script type="text/javascript">
        $(document).ready(function (event) {
            if (localStorage.getItem('DDUSERID') != null && localStorage.getItem('DDUSERID') != '') {
                $("#txtUserID").val(localStorage.getItem('DDUSERID'))
                if (localStorage.getItem('DDNAME') != null && localStorage.getItem('DDNAME') != '') {
                    $("#headLabel")[0].textContent = "Dr. " + localStorage.getItem('DDNAME')
                } else { $("#headLabel")[0].textContent = "";}
            } else {
                window.location.replace("../Account/Login");
            }

            $('#btnLogin').click(function () {
                funLogin();
            });
            $('#btnRemove').click(function () {
                localStorage.removeItem("DDUSERID");
                localStorage.removeItem("DDNAME");
                window.location.replace("../Account/Login");
            });
            $("#txtPwd").keyup(function () {
                if (document.getElementById("txtPwd").value.length == 4) {
                    funLogin();
                }
            });
        });
        function funLogin() {
            if (checkValid()) {
                $.loader.open();
                var urls = "../Account/GetPINCheck?strUserID=" + $("#txtUserID").val() + "&strPIN=" + $("#txtPwd").val();
                $.ajax({
                    type: "POST",
                    url: urls,
                    success: function (response) {
                        $.loader.close();
                        if (response == "doctor") {
                            window.location.replace("<%=Url.Action("MenuList", "Account",new { pageId = "Menu" })%>");
                        }
                        else {
                            $("#txtPwd").val("");
                            $.messager.alert("Information", 'Invalid Credentials.');
                        }
                    }, error: function (XMLHttpRequest, textStatus, errorThrown) {

                        $.loader.close();
                       
                        $.messager.alert("Error", errorThrown);
                    }
                });
            }
        }
        function checkValid() {
            if ($("#txtPwd").val() == '') {
                $("#txtPwd").css("border-color", "red");
                $("#txtPwd").focus();
                return false;
            }
            return true;
        }


    </script>

    <div>
        <form id="LoginForm" runat="server" action="./">

            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

            <div class="MaincontSize" style="box-sizing: border-box; box-shadow: 0px 0px 2px 2px #d5d5d4; background-color: #cad4dc; font-size: 11px; font-family: sans-serif; font-weight: bold; position: relative">
                <div class="HeaderFont" style="text-align: center; font-weight: bold; color: #007cc3; padding-top: 22px;">
                    <label style="font-size: initial">Welcome</label><br />
                    <label id="headLabel" style="font-size: x-large">Doctor</label>
                    <br />
                    <img style="height: 4px;" src="<%=ResolveUrl("~/Images/ContentSeparator.png")%>" />
                    <br />
                    <%:Html.TextBoxFor(x => Model.UserID, new { id="txtUserID" , @placeholder="USER ID", @Style="display:none;text-transform: uppercase; margin-top:10px;border-style:solid;border-color:transparent;box-shadow: 1px 2px 0px #3c8dbc;resize:none;text-align:center;      border-radius: 4px;   background-color: white;   width: 250px;   height: 30px;" , @class="TextbxSize"})%>
                    <%:Html.PasswordFor(x => Model.Password, new { @maxlength="4", id = "txtPwd",@class="TextbxSize" ,  @placeholder="Enter PIN",@Style="margin-bottom:10px; border-style:solid;margin-top:10px;border-color:#f5f3f3;box-shadow: 1px 2px 0px #3c8dbc;resize:none;text-align:center;border-width: 1px;  border-radius: 4px;   background-color: white;    width: 250px;  height: 30px;"})%>
                    <br />
                    <input type="button" style="margin-top: 10px; margin-bottom: 10px; width: 90px; border-radius: 7px;" name="btnSave" id="btnLogin" class="BtnFormat" value="Sign In" />
                    <br />
                    <a id="btnRemove" href="#" style="font-size: small; color: black; text-decoration: underline">Remove Account</a>
                    <br />
                    <img style="align-self: center; max-width: 100%; height: auto" src="../Images/Login_logo.png">
                </div>
            </div>

        </form>
    </div>
</body>
</html>
