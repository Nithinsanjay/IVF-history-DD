<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.TISS28ScoringModel>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <style>
        table.rptTableCls, table.rptTableCls th, table.rptTableCls td {
            border: 1px solid #666;
            border-collapse: collapse;
            font-size: 13px;
        }

            table.rptTableCls th, table.rptTableCls td {
                border:1px solid #020202;
                padding: 3px; /* Apply cell padding */
            }
            .acuity-score-row td {
    height: 40px;
    font-size: 14px;
    font-weight: bold;
    border-top: 2px solid #999;
}
    </style>
    <meta name="viewport" content="width=device-width" />
    <title>TISSReport</title>

    <LINK href="~/Content/braviStyle.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/style.css" rel="stylesheet" type="text/css" />
    <LINK href="~/js/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/Jquery-ui-Custom.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/select2-bootstrap.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/calenderextra.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/font-awesome.min.css" rel="stylesheet" />
    <SCRIPT src="<%=ResolveUrl("~/js/jquery-1-10-2.js")%>"></SCRIPT>
    <SCRIPT src="<%=ResolveUrl("~/js/jquery-1-11-1-ui.js")%>"></SCRIPT>
    <SCRIPT src="<%=ResolveUrl("~/js/i18n/grid.locale-en.js")%>"></SCRIPT>
    <SCRIPT src="<%=ResolveUrl("~/js/jquery.jqGrid.js")%>"></SCRIPT>
    <script src="../js/canvasjs.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function (e) {
            debugger

            var rptTable = '<%= ViewData["REPORTTABLE"] %>';
           <%-- <%string bedNumber = Model.BedNumber;%>
            var bedNumber = '<%= bedNumber %>'--%>
            if (rptTable != '' && rptTable != null)
                rptTableData = JSON.parse(rptTable);
            else
                rptTableData = '';
            SetTISSReport(rptTableData);


        });

    <%--    function SetTISSReport(rptTableData) {
            var DatesCnt = '<%= Model.DistinctDateValuesCnt%>';
            //$("#rptTable").empty();
            //alert('gyug');
            //$.each(rptTableData, function (key, value) {
            //    //var row = value.length;
            //    var row = "<tr><td>" +  value.length + "</td></tr>";
            //    $("#rptTable").append(row);
            //});

            // EXTRACT VALUE FOR HTML HEADER. 
            var col = [];
            for (var i = 0; i < rptTableData.length; i++) {
                for (var key in rptTableData[i]) {
                    if (col.indexOf(key) === -1) {
                        col.push(key);
                    }
                }
            }



            // CREATE DYNAMIC TABLE.
            var table = document.getElementById('rptTable');

            var trDates = table.insertRow(-1);
            trDates.style = "background-color:#c2e9f7";
            var thEmpty = document.createElement("th");
            trDates.appendChild(thEmpty);

            var colIncrmnt = 1;
            for (var i = 0; i < DatesCnt ; i++) {
                var dateValue = col[colIncrmnt].substr(col[colIncrmnt].indexOf('-') + 1);
                var th = document.createElement("th");
                th.colSpan = 3
                if (dateValue.toString().trim().length == 8) th.innerHTML = dateValue.substr(6, 2) + "/" + dateValue.substr(4, 2) + "/" + dateValue.substr(0, 4); else th.innerHTML = "";
                trDates.appendChild(th);
                colIncrmnt = colIncrmnt + 3;
            }
            // CREATE HTML TABLE HEADER ROW USING THE EXTRACTED HEADERS ABOVE.

            //var trDates = table.insertRow(-1);
            var tr = table.insertRow(-1);                   // TABLE ROW.
            tr.style = "background-color:#c2e9f7";

            for (var i = 0; i < col.length; i++) {
                var th = document.createElement("th");
                // TABLE HEADER.
                if (col[i] == "ParaName") {
                    th.innerHTML = "Parameters";
                    th.style = "width:32%"
                }
                else {
                    th.innerHTML = col[i].substr(0, 1);
                }

                tr.appendChild(th);
            }--%>
        function SetTISSReport(rptTableData) {
            // ... your existing code before this point

            // EXTRACT VALUE FOR HTML HEADER. 
            var col = [];
            for (var i = 0; i < rptTableData.length; i++) {
                for (var key in rptTableData[i]) {
                    if (col.indexOf(key) === -1) {
                        col.push(key);
                    }
                }
            }

            // CREATE DYNAMIC TABLE.
            var table = document.getElementById('rptTable');

            // ------------------ New date header row ------------------

            // Extract unique dates from col except 'ParaName'
            var datesSet = new Set();
            for (var i = 0; i < col.length; i++) {
                if (col[i] !== "ParaName") {
                    var dashIndex = col[i].indexOf('-');
                    if (dashIndex !== -1) {
                        var datePart = col[i].substr(dashIndex + 1);
                        datesSet.add(datePart);
                    }
                }
            }
            var datesArray = Array.from(datesSet).sort(); // sort dates if needed

            var trDates = table.insertRow(-1);
            trDates.style.backgroundColor = "#c2e9f7";

            var thEmpty = document.createElement("th");
            trDates.appendChild(thEmpty);

            datesArray.forEach(function (dateValue) {
                var th = document.createElement("th");
                th.colSpan = 3;
                var bedNo = document.getElementById("bedNo").value;
                if (dateValue.trim().length == 8) {
                    var formattedDate = dateValue.substr(6, 2) + "/" + dateValue.substr(4, 2) + "/" + dateValue.substr(0, 4);
                    th.innerHTML = formattedDate + " [" + bedNo + "]";
                } else {
                    th.innerHTML = "";
                }
                trDates.appendChild(th);
            });

            // ------------------ Original header row ------------------

            var tr = table.insertRow(-1);
            tr.style.backgroundColor = "#c2e9f7";

            for (var i = 0; i < col.length; i++) {
                var th = document.createElement("th");
                if (col[i] == "ParaName") {
                    th.innerHTML = "Parameters";
                    th.style.width = "32%";
                } else {
                    th.innerHTML = col[i].substr(0, 1);
                }
                tr.appendChild(th);
            }

            // ... rest of your code (adding data rows, total row, etc.)


            // ADD JSON DATA TO THE TABLE AS ROWS.
            //for (var i = 0; i < rptTableData.length; i++) {

            //    tr = table.insertRow(-1);

            //    for (var j = 0; j < col.length; j++) {
            //        var tabCell = tr.insertCell(-1);
            //        tabCell.innerHTML = rptTableData[i][col[j]];

            //        if (j != 0)
            //            tabCell.style = "text-align:right";
            //    }
            //}

            for (var i = 0; i < rptTableData.length; i++) {
                var isCategoryRow = rptTableData[i]["ParaName"] && rptTableData[i]["ParaName"].startsWith("##CATEGORY##");

                tr = table.insertRow(-1);

                for (var j = 0; j < col.length; j++) {
                    var tabCell = tr.insertCell(-1);

                    let cellVal = rptTableData[i][col[j]];

                    // Format category row
                    if (isCategoryRow) {
                        if (j === 0) {
                            tabCell.colSpan = col.length;
                            tabCell.innerHTML = "<b>" + cellVal.replace("##CATEGORY##", "") + "</b>";
                            tabCell.style.backgroundColor = "#f0f0f0";
                            tabCell.style.fontWeight = "bold";
                            tabCell.style.textAlign = "center";
                            tabCell.style.fontSize = "14px";
                        } else {
                            tabCell.style.display = "none"; // hide other cells
                        }
                    } else {
                        tabCell.innerHTML = cellVal;
                        if (j !== 0) tabCell.style = "text-align:center";
                    }
                }
            }


            // FINALLY ADD THE NEWLY CREATED TABLE WITH JSON DATA TO A CONTAINER.
            //var divContainer = document.getElementById("showData");
            //divContainer.innerHTML = "";
            //divContainer.appendChild(table);
            var isICU = document.getElementById("icuYN").value === "Y";

            if (isICU) {
                // Existing logic for ICU total
                var tr = table.insertRow(-1);
                tr.className = "sum";
                tr.style = "background-color:bisque";
                for (var i = 0; i < col.length; i++) {
                    var td = document.createElement("td");
                    var th = document.createElement("th");
                    if (i == 0) {
                        th.innerHTML = "Total Tiss Acuity Score";
                        tr.appendChild(th);
                    } else {
                        td.className = "sum";
                        td.style = "text-align:center;font-weight:bold";
                        tr.appendChild(td);
                    }
                }
                do_sums();
            } else {
                // Non-ICU: Acuity score row
                var tr = table.insertRow(-1);
                tr.className = "acuity-score-row";

                for (var i = 0; i < col.length; i++) {
                    var td = document.createElement("td");

                    if (i === 0) {
                        td.innerHTML = "<b>Patient Acuity Score</b>";
                        td.style.fontWeight = "bold";
                        td.style.textAlign = "left";
                        td.style.backgroundColor = "#ffe6ff";
                        td.style.padding = "8px";
                        td.style.fontSize = "12px";
                    } else {
                        var shiftDate = col[i];
                        var acuityValues = [];

                        // Gather numeric values for each shift/column
                        for (var r = 0; r < rptTableData.length; r++) {
                            let paraName = rptTableData[r]["ParaName"];
                            if (paraName && paraName.startsWith("##CATEGORY##")) continue;

                            var val = rptTableData[r][shiftDate];
                            if (val && !isNaN(val)) {
                                acuityValues.push(parseInt(val));
                            }
                        }


                        var acuityLabel = "-";
                        var bgColor = "";
                        if (acuityValues.includes(4)) {
                            acuityLabel = "4";
                            td.style.color = "rgb(255, 0, 0)";
                        } else if (acuityValues.includes(3)) {
                            acuityLabel = "3";
                            td.style.color = "#cc7a00";
                        } else if (acuityValues.filter(function (x) { return x === 2; }).length >= 2) {
                            acuityLabel = "2";
                            td.style.color = "rgb(255, 234, 0)";
                        } else if (acuityValues.filter(function (x) { return x === 1 }).length > 0) {
                            acuityLabel = "1";
                            td.style.color = "#009900";
                        }

                        td.innerHTML = acuityLabel;
                        td.style.backgroundColor = "#ffe6ff";;
                        td.style.textAlign = "center";
                        td.style.fontWeight = "bold";
                        td.style.padding = "8px";
                        td.style.fontSize = "20px";
                    }

                    tr.appendChild(td);
                }
            }


        }

        function sumOfColumns(table, columnIndex) {
            var tot = 0;
            table.find("tr").children("td:nth-child(" + columnIndex + ")")
            .each(function () {
                $this = $(this);
                if (!$this.hasClass("sum") && $this.html() != "") {
                    tot += parseInt($this.html());
                }
            });
            return tot;
        }
        function do_sums() {
            $("tr.sum").each(function (i, tr) {
                $tr = $(tr);
                $tr.children().each(function (i, td) {
                    $td = $(td);
                    var table = $td.parent().parent().parent();
                    if ($td.hasClass("sum")) {
                        $td.html(sumOfColumns(table, i + 1));
                    }
                })
            });
        }
        let totalCols = document.querySelectorAll("#rptTable tr:nth-child(2) th").length;
        let colWidth = 40; // Or whatever column width you prefer
        let minWidth = totalCols * colWidth;

        document.querySelector("#rptDataDiv > div").style.minWidth = minWidth + "px";

    </script>
</head>
    
<body style ="background-color:white">
    <div id="showData" style=""><%-- margin-left:50px;margin-right:50px;margin-top:20px;--%>
  <%--      <div id="PatDataDiv">
            <div id="logo" style="float:left">
            <image src="../Images/nabh_accredited.jpg" style="height:50px; margin-left: 20px;" /><br />
            <LABEL style="color: black;font-weight:bold">FORM/JH/IP/CCFS-37/00</LABEL>
            </div>
            <div id="heading" style="float:left">
                 <image src="../Images/logo.jpg" style="height:50px;" />  <br />
                <LABEL style="color: black;font-weight:bold;font-size:14px;">TISS 28 Scoring From <%=Model.FrmDate %>-<%=Model.ToDate %> </LABEL>
            </div>
            <div id="patDetails" style="float:left">
                 <table style ="border:1px solid darkgrey;font-weight:bold">
                        <tr>
                            <td class="header"><label style="width: 100px;font-weight:bold;">Name</label></td>
                            <td>:</td>
                            <td style="width:40%"><label style="font-weight:bold;"><%=Html.DisplayFor(x => Model.PatientName, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                            <td class="header"><label style="width: 100px;font-weight:bold;">MR No.</label></td>
                                 <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.MRNo, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                        </tr>
                        <tr>
                            <td class="header"><label style="width: 100px;font-weight:bold;">Consultant</label></td>
                            <td>:</td>
                            <td>
                            <label>Dr. &nbsp;<%=Html.DisplayFor(x => Model.Consulatation, new { id="txtConsDr",@class = "TextBxFormat",@style="margin-left: 24px;"})%></label></td>
                            <td class="header"><label style="width: 100px;font-weight:bold;">IP No.</label></td>
                            <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.IPNo, new { id="txtIPNo",@class = "TextBxFormat",@style="margin-left:48px"})%></label></td>
                       </tr>  
                       <tr>
                            <td class="header"><label style="width: 100px;font-weight:bold;">Age/Gender</label></td>
                            <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.AgeGender, new { id="txtAge",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                            <td class="header"><label style="width: 100px;font-weight:bold;">Admn. Dt/Tm</label></td>
                            <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.AdmnDateTime, new { id="txtAdmnDTTM",@class = "TextBxFormat",@style="margin-left: 10px"})%></label></td>
                         </tr>   
                         <tr>
                            <td class="header"><label style="width: 100px;font-weight:bold;">Ward/Bed No.</label></td>
                              <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.WardBedNo, new { id="txtDate",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                              <td class="header"></td>
                              <td></td>
                            <td></td>
                       </tr>  
                    </table>

            </div>
            </div>--%>
    <table style ="width:100%;">
        <input type="hidden" id="icuYN" value="<%=Model.ICUYN %>" />
        <input type="hidden" id="bedNo" value="<%=Model.BedNo%>" />


            <tr>
                <td> <image src="../Images/nabh_accredited.jpg" style="height:80px; margin-left: 20px;" /><br />
                    <%--<LABEL style="color: black;font-weight:bold">FORM/JH/IP/CCFS-37/00</LABEL>--%>
                </td>
                <td style="text-align:center;padding-left: 350px;">
                <image src="../Images/logo.jpg" style="height:50px;" />  <br />
                <LABEL style="color: black;font-weight:bold;font-size:14px;">Patient Acuity Scoring</LABEL><br/>
                    <% if (Model.FrmDate != Model.ToDate)
                       { %>
                    <label style="color: black;font-weight:bold;font-size:14px;">(<%=Model.FrmDate %> - <%=Model.ToDate %>)</label>
                    <%}
                       else
                       { %>
                    <label style="color: black;font-weight:bold;font-size:14px;">(For Date : <%=Model.FrmDate %> )</label>
                    <%} %>
                </td>
                <td>
                    <table style ="float:right;border:1px solid darkgrey;font-weight:bold">
                        <tr>
                            <td class="header"><label style="width: 100px;font-weight:bold;">Name</label></td>
                            <td>:</td>
                            <td ="colspan4"><label style="font-weight:bold;"><%=Html.DisplayFor(x => Model.PatientName, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                          <%--  <td class="header"></td>
                                 <td></td>
                            <td></td>--%>
                        </tr>
                        <tr>
                            <td class="header"><label style="width: 100px;font-weight:bold;">Consultant</label></td>
                            <td>:</td>
                            <td style="width:35%">
                            <label>Dr. &nbsp;<%=Html.DisplayFor(x => Model.Consulatation, new { id="txtConsDr",@class = "TextBxFormat",@style="margin-left: 24px;"})%></label></td>
                            <td class="header"><label style="width: 100px;font-weight:bold;">MR No.</label></td>
                            <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.MRNo, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                       </tr>  
                       <tr>
                            <td class="header"><label style="width: 100px;font-weight:bold;">Age/Gender</label></td>
                            <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.AgeGender, new { id="txtAge",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                            <td class="header"><label style="width: 100px;font-weight:bold;">IP No.</label></td>
                            <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.IPNo, new { id="txtIPNo",@class = "TextBxFormat",@style="margin-left:48px"})%></label></td>
                         </tr>   
                         <tr>
                            <td class="header"><label style="width: 100px;font-weight:bold;">Ward/Bed </label></td>
                              <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.WardBedNo, new { id="txtDate",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                              <td class="header"><label style="width: 100px;font-weight:bold;">Admn. Dt/Tm</label></td>
                              <td>:</td>
                            <td><label><%=Html.DisplayFor(x => Model.AdmnDateTime, new { id="txtAdmnDTTM",@class = "TextBxFormat",@style="margin-left: 10px"})%></label></td>
                       </tr>  
                    </table>

               </td>
        </tr>

       </table>
    

        <%--<div id="heading" style ="width:100%;margin:auto;margin-top:22px">
            <label style="text-align:center;font-size:20px;font-weight:bold;color: #a72d2d">TISS 28 Scoring</label>
        </div>--%>
        <div id="rptDataDiv" style="overflow-x: auto;width: 98%;padding: 10px;">
            <div style="/*min-width: 2000px;*/" id="divrptTable">
                <table id="rptTable" class="rptTableCls" style="width: 100%;">
                </table>
            </div>
        </div>


        <%--  <div style="text-align: center; color: #00659f; font-weight: bold; margin-top: 10px;">
            <label style="font-size: 15px;"><=27 NPR  1:2</label>
            <label style="margin-left: 50px; font-size: 15px;">>=28 NPR  1:1</label>
        </div>--%>
        <% if (Model.ICUYN == "Y")
           { %>
        <!-- ICU: Show NPR Ratio -->
        <div style="text-align: left; color: #00659f; font-weight: bold; margin-top: 10px;">
            <label style="font-size: 15px;"><=27 NPR  1:2</label>
            <label style="margin-left: 50px; font-size: 15px;">>=28 NPR  1:1</label>
        </div>
        <% }
           else
           { %>
        <!-- Non-ICU: Show Acuity Score Box -->
        <div style="margin: 20px auto; width: 30%; padding: 15px; border: 2px solid #444; border-radius: 5px; background-color:#ffffff; font-size: 14px; font-weight: bold; color: #333;">
            <div style="margin-bottom: 8px;"><span style="color: green;">Acuity 1</span> – Stable patient</div>
            <div style="margin-bottom: 8px;"><span style="color: #ffc107;">Acuity 2</span> – Moderate Risk patient</div>
            <div style="margin-bottom: 8px;"><span style="color: #ff9213;">Acuity 3</span> – Complex patient</div>
            <div><span style="color: red;">Acuity 4</span> – High Risk patient</div>
        </div>
        <% } %>

        <div>
            <div id="userId" style="margin-top: 10px; float: left">
                <label style="font-size: 14px; font-weight: bold">Printed By : <%=Model.userID %></label>
            </div>
            <div id="userDateTime" style="margin-top: 8px; float: right; margin-right: 10px;">
                <label style="font-size: 14px; font-weight: bold;">Print Date/Time : <%=Model.DateDisplayInReport %> - <%=Model.TimeDisplayInReport %></label>
            </div>
        </div>
    </div>
</body>
</html>
