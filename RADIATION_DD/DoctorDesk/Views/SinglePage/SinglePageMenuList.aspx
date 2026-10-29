<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SinglePage.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        /* Unique Container */
        .sp-menu-container {
            text-align: center;
            padding-top: 200px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Unique Title */
        .sp-menu-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 40px;
            color: #333;
        }

        /* Unique Row Container */
        .sp-menu-row {
            display: flex;
            justify-content: center;
            gap: 75px;
            flex-wrap: wrap;
        }

        /* Unique Card Style */
        .sp-menu-card {
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 12px;
            width: 350px;
            height: 300px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            text-decoration: none;
        }

        /* Unique Hover Effect */
        .sp-menu-card:hover {
            border-color: #007bff;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.2);
            transform: translateY(-5px);
        }

        /* Unique Icon/Image Style */
        .sp-menu-icon {
            width: 200px;  /* Adjust based on your actual image size */
            height: 200px;
            margin-bottom: 8px;
            object-fit: contain;
        }

        /* Unique Label Text Style */
        .sp-menu-label {
            font-size: 25px;
            font-weight: bold;
            color: #007bff;
            text-transform: uppercase;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function (e) {
            sessionStorage.removeItem('ConsultationDate');  // Abhishesh || 20260714
            SetOPDPatInfoClick(false);
            SetShowAllPatList(false);
            SetIPDPatInfoClick(false);
            SetIPDPatSearch(false);
            setModuleSession(false);
        });

        $(window).on("pageshow", function (event) {
            sessionStorage.removeItem('ConsultationDate');  // Abhishesh || 20260714
            SetOPDPatInfoClick(false);
            SetShowAllPatList(false);
            SetIPDPatInfoClick(false);
            SetIPDPatSearch(false);
            setModuleSession(false);
        });

        function onModuleClick(moduleFlag) {
            if (ValidationForRedirectModule(moduleFlag) == true) {
                setModuleSession(true, moduleFlag);
                if (moduleFlag === "OPD") {
                    SetClincForDoct();
                    //window.location.href = "../SinglePage/WaitingListOPD";
                }
                else if (moduleFlag === "IPD") {
                    window.location.href = "../SinglePage/WaitingListIPD";
                }
                else if (moduleFlag === "PAC") {
                    window.location.href = "../SinglePage/WaitingListPAC";
                }
            }
        }

        function SetClincForDoct() {
            GetClinicsList("Y");
        }

        function ValidationForRedirectModule(moduleFlag) {
            //if (moduleFlag != "IPD" && (!sessionStorage.getItem("ClinicCode") || sessionStorage.getItem("ClinicCode") == "")) {
            //    ToastMsg("Please Select Clinic", "warning");
            //    return false;
            //}
            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="sp-menu-container">
        
        <%--<h2 class="sp-menu-title">Select The Following</h2>--%>

        <div class="sp-menu-row">
            
            <div class="sp-menu-card" onclick="SetClincForDoct()">
                <img class="sp-menu-icon" src="../Images/Singlepage/OpdDr.png" alt="OPD Icon" /> 
                <span class="sp-menu-label">Outpatient</span>
            </div>
<%--            <%  if (Session["RMOYN"].ToString() != "Y" && Session["AUTHYN"].ToString() != "Y")--%>
            <%  if (("" + Session["gDoctCode"]).ToString() != "")
                {  %>
            <div class="sp-menu-card" onclick="onModuleClick('IPD')">
                <img class="sp-menu-icon" src="../Images/Singlepage/IPD.png" alt="IPD Icon" />
                <span class="sp-menu-label">Inpatient</span>
            </div>
            <%} %>
<%--            <div class="sp-menu-card" onclick="onModuleClick('PAC')">
                <img class="sp-menu-icon" src="../Images/Singlepage/PAC.png" alt="PAC Icon" />
                <span class="sp-menu-label">Pre-Anaesthesia Checkup</span>
            </div>--%>

        </div>
    </div>

</asp:Content>