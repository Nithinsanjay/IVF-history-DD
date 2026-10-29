<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div id="MainDiv">

          <div id="ContentHolderDiv">
                <%--    <div class="InputWrapper">--%>
<%--//27-11-2019 18:25--%>
      <div class="col-md-2" style='float: left;font-size:12px;margin-top:-9px;'>Note-</div><div class='square' style="margin-top:-9px;"></div>
                            &nbsp;&nbsp;<span style="font-size:12px;margin-left:-11px;margin-top:-9px;" class="col-md-3">Public</span>
                <div id="tbldiv">

              </div>
                </div>
        </div>
    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    
    <style>
        .divHeads {
            color: #f4f4f4;
            background-color: #3c8dbc;
            border-color: #ddd;
            box-shadow: none;
            font-size: 12px;
            text-align: center;
            font-weight: bold;
        }

        .divBody {
            padding: 15px;
            background-color: white; /*rgba(128, 128, 128, 0.15);*/
        }

                   Label {
            margin-left: 5px;
        }
        .panel-body {
            width:auto !important;
            height:auto !important;
        }

    </style>
    <%-- <script src="../plugins/alert/jquery-confirm.js"></script>
    <link href="../plugins/alert/jquery-confirm.css" rel="stylesheet">--%>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/PatList.js"></script>
    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var idOfDMY = "";
        var exam = "";
        $(document).ready(function (e) {
            HoldOn.open();//
            var doctCode = $.session.get('DoctCode');
            var doctName = $.session.get('DoctName');
            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');// added by vijeta on  29th march 2018

            SetPatientDtl();
            AddClinics(urls);
            GetNotes();

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";

            }

            // added by vijeta on  29th march 2018
            if (pathFrom != "") {
              
            }
            else {
                //$("#DoctorInput").val(doctName);
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
        
        });

        function GetNotes() {
            var mrNo = ($.session.get('PatMRNO'));

            $.ajax({
                type: "POST",
                url: 'GetAllNotes',
                datatype: "json",
                data: { strMrNo: mrNo },
                success: function (result) {
                    if (result[0] != null) {
                        for (var i = 0; i < result[0].length; i++) {
                            var $divPanel = $('<div>', { style: '-webkit-box-shadow: 0px 0px 6px 2px #878888;', class: 'panel' });
                            var $divPanelHead = $('<div>', { style: 'font-size:13px;height: 29px;', class: 'panel-heading divHeads' });
                            var strTable = "<table style='width:100%'><tr><td>Consultation No : " + result[0][i].TRANNO.toString() + "</td><td> Date :" + result[0][i].TRANDATE + "</td><td>Time : " + result[0][i].TRANTIME + "</td></tr></table>";
                            $divPanelHead.append(strTable);
                            //27-11-2019 17:39
                            if (result[0][i].NOTETYPE != "P")
                            { var $divPanelBody = $('<div>', { style: 'font-size:13px;', class: 'panel-body divBody' }); }
                            else {

                                var $divPanelBody = $('<div>', { style: 'font-size:13px;background-color:#f4e1ef', class: 'panel-body divBody' });
                            }


                            var str = "<label style='font-weight:100;color:#3b0707'>" + result[0][i].NOTE + "</label><br><p style='float:right'>" + "- " + result[0][i].DOCTNAME;


                            $divPanelBody.append(str);
                            $divPanel.append($divPanelHead);
                            $divPanel.append($divPanelBody);

                            $("#tbldiv").append($divPanel);

                        }


                    }
                    else {

                        document.getElementById("tbldiv").innerHTML = "<div class='panel'><div class='panel-body divBody' style='font-size:14px;'>No Data Found</div></div>";

                    }

                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
            });


        }

    </script>
    </asp:Content>