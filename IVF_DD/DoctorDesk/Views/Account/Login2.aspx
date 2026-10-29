<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.AccountModel>" %>

<!DOCTYPE html>
<html>
    <head runat="server">
     <title>Doctor Login</title>
        <link href="../../Styles/loginStyle.css" rel="stylesheet" />
       <%-- <link rel="stylesheet" href="https://unpkg.com/onsenui/css/onsenui.css">
        <link rel="stylesheet" href="https://unpkg.com/onsenui/css/onsen-css-components.min.css">
        <script src="https://unpkg.com/onsenui/js/onsenui.min.js"></script>

    <script src="lib/onsen/js/onsenui.js"></script>--%>
        </head>
        <body>
            <%-- <ons-page>--%>
          <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    	  <div class="modal-dialog">
				<div class="loginmodal-container">
					<h1>Login to Your Account</h1><br>
				  <form>
					<input type="text" name="user" placeholder="Username">
					<input type="password" name="pass" placeholder="Password">
					<input type="submit" name="login" class="login loginmodal-submit" value="Login">
				  </form>
					
				  <div class="login-help">
					<a href="#">Register</a> - <a href="#">Forgot Password</a>
				  </div>
				</div>
			</div>
		  </div>
               <%--  </ons-page>--%>
        </body>
   
</html>

