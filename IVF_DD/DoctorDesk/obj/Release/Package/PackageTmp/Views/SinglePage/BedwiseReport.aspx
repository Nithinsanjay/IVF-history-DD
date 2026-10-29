<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.TISS28ScoringModel>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>BedwiseReport</title>
 <style>
        table.rptTableCls, table.rptTableCls th, table.rptTableCls td {
            border: 1px solid #666;
            border-collapse: collapse;
            font-size: 13px;

        }
         table.rptTableCls th:first-child,
         table.rptTableCls td:first-child {
             width: 15%; 
         }

        table.rptTableCls th, table.rptTableCls td {
            padding: 5px;
            text-align: left;
            width:30%;
        }

        .header-title {
            font-weight: bold;
            font-size: 16px;
            color: #222;
            text-align: center;
        }

        .icu-row {
            background-color: bisque;
        }

        .non-icu-acuity {
            font-weight: bold;
            text-align: center;
            background-color: #e9a4a4;
            font-size: 20px;
        }

        .param-header {
            background-color: #c2e9f7;
            font-weight: bold;
        }

        .category-row {
            background-color: #f0f0f0;
            font-weight: bold;
            font-size: 14px;
        }

     .total-row td{
         font-weight: bold;
         background-color: #fff176 !important; 
         color: #000;
     }   
    </style>

    <script src="<%= Url.Content("~/js/jquery-1-10-2.js") %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var rptTable = '<%= ViewData["REPORTTABLE"] %>';
            var isICU = $('#icuYN').val() === 'Y';
            var tableData = rptTable ? JSON.parse(rptTable) : [];

            if (tableData.length > 0) {
                buildReport(tableData, isICU);
            }
        });

        function buildReport(data, isICU) {
            var cols = Object.keys(data[0] || {});

            cols = cols.filter(function (c) {
                return c !== "Parameter" && c !== "Bed";
            });

            cols.unshift("Parameter");
            //cols.push("Bed");
            var table = $('#rptTable');
            var tr = $('<tr class="param-header" />');

            cols.forEach(function (col) {
                tr.append($('<th />').text(col === "Parameter" ? "Parameter Name" : col));
            });
            table.append(tr);

            data.forEach(function (rowData) {
                var isCategory = rowData["Parameter"] && rowData["Parameter"].startsWith("##CATEGORY##");
                var tr = $('<tr />');

                cols.forEach(function (col, index) {
                    var td = $('<td />');
                    if (isCategory) {
                        if (index === 0) {
                            td.attr('colspan', cols.length)
                              .addClass('category-row')
                              .text(rowData["Parameter"].replace("##CATEGORY##", ""));
                        } else {
                            td.hide();
                        }
                    } else {
                        td.text(rowData[col] || "");
                        if (col === "Parameter") {
                            td.css("text-align", "left");
                        } else {
                            td.css("text-align", "left");
                        }
                    }
                    tr.append(td);
                });
                table.append(tr);
            });

            // Total Row
            //var totalRow = $("<tr>").addClass("total-row");
            //cols.forEach(function (col, index) {
            //    var td = $("<td>");
            //    if (col === "Parameter") {
            //        td.text("Total");
            //        td.css({
            //            textAlign: "left",
            //            fontWeight: "bold",                  

            //        });
            //    } else {
            //        var sum = 0;
            //        data.forEach(function (row) {
            //            if (!row["Parameter"] || !row["Parameter"].startsWith("##CATEGORY##")) {
            //                var val = parseInt(row[col]);
            //                if (!isNaN(val)) sum += val;
            //            }
            //        });

            //        td.text(sum);
            //        td.css({
            //            textAlign: "left",
            //            fontWeight: "bold",
            //            backgroundColor: "#f1f1f1"
            //        });
            //    }
            //    totalRow.append(td);
            //});

            //table.append(totalRow);
            if (isICU) {
                var totalRow = $("<tr>").addClass("total-row");
                cols.forEach(function (col, index) {
                    var td = $("<td>");
                    if (col === "Parameter") {
                        td.text("Total").css({ textAlign: "left", fontWeight: "bold" });
                    } else {
                        var sum = 0;
                        data.forEach(function (row) {
                            if (!row["Parameter"] || !row["Parameter"].startsWith("##CATEGORY##")) {
                                var val = parseInt(row[col]);
                                if (!isNaN(val)) sum += val;
                            }
                        });
                        td.text(sum).css({
                            textAlign: "left",
                            fontWeight: "bold",
                            backgroundColor: "#f1f1f1"
                        });
                    }
                    totalRow.append(td);
                });
                table.append(totalRow);
            }


            // Acuity Score Row for non-ICU
            renderAcuityRow(table, data, cols, isICU);
        }

        function renderAcuityRow(table, rptTableData, col, isICU) {
            if (!isICU) {
                var acuityRow = $("<tr>").addClass("acuity-score-row");

                for (var i = 0; i < col.length; i++) {
                    var td = $("<td>");

                    if (i === 0) {
                        td.html("<b>Acuity Score</b>");
                        td.css({
                            fontWeight: "bold",
                            textAlign: "left",
                            backgroundColor: "#e9a4a4",
                            padding: "8px",
                            fontSize: "14px"
                        });
                    } else {
                        var scores = [];

                        for (var j = 0; j < rptTableData.length; j++) {
                            var row = rptTableData[j];
                            if (!row["Parameter"] || row["Parameter"].startsWith("##CATEGORY##")) continue;

                            var val = parseInt(row[col[i]]);
                            if (!isNaN(val)) scores.push(val);
                        }

                        var acuity = "-";
                        if (scores.indexOf(4) !== -1) {
                            acuity = "4";
                            td.css("color", "#FF5C5C");
                        } else if (scores.indexOf(3) !== -1) {
                            acuity = "3";
                            td.css("color", "#ff9213");
                        } else if (scores.filter(function (x) { return x === 2; }).length >= 2) {
                            acuity = "2";
                            td.css("color", "#f1c40f");
                        } else if (scores.indexOf(1) !== -1) {
                            acuity = "1";
                            td.css("color", "#1c871c");
                        }

                        td.text(acuity);
                        td.css({
                            backgroundColor: "#e9a4a4",
                            textAlign: "center",
                            fontWeight: "bold",
                            padding: "8px",
                            fontSize: "20px"
                        });
                    }

                    acuityRow.append(td);
                }

                table.append(acuityRow);
            }
        }
        let totalCols = document.querySelectorAll("#rptTable tr:nth-child(2) th").length;
        let colWidth = 100; // Or whatever column width you prefer
        let minWidth = totalCols * colWidth;

        document.querySelector("#rptDataDiv > div").style.minWidth = minWidth + "px";
    </script>
</head>

<body style="background-color: white; font-family: Arial;">
    <div style="padding: 20px;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 20%;">
                    <img src="../Images/nabh_accredited.jpg" style="height: 70px;" />
                </td>
                <td style="text-align: center; width: 60%;">
                    <img src="../Images/logo.jpg" style="height: 50px;" /><br />
                    <div class="header-title">
                        <%= Session["NSNAME"] ?? "Nursing Station" %> – Patient Acuity Score Report
                    </div>
                    <div style="font-weight: bold;">
                        <% if (Model.FrmDate != Model.ToDate) { %>
                            (<%= Model.FrmDate %> - <%= Model.ToDate %>)
                        <% } else { %>
                            (For Date: <%= Model.FrmDate %>)
                        <% } %>
                    </div>
                </td>
                <td style="width: 20%;">&nbsp;</td>
            </tr>
        </table>
        <hr />
        <input type="hidden" id="icuYN" value="<%= Model.ICUYN %>" />
              <div id="rptDataDiv" style="overflow-x: auto; width: 100%;">
            <div style="min-width: 2000px;">
                <table id="rptTable" class="rptTableCls" style="width: 100%; margin-top: 20px;"></table>
            </div>
        </div>
        <% if (Model.ICUYN == "Y") { %>
            <div style="text-align: center; margin-top: 20px; font-size: 14px; font-weight: bold; color: #007BFF;">
                &le;27: NPR 1:2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &ge;28: NPR 1:1
            </div>
        <% } else { %>
            <div style="margin: 30px auto; width: 40%; padding: 15px; border: 1px solid #444; border-radius: 5px; background-color: #f9f9f9;">
                <div><span style="color: green;">Acuity 1</span> – Stable patient</div>
                <div><span style="color: #ffc107;">Acuity 2</span> – Moderate risk patient</div>
                <div><span style="color: #ff9213;">Acuity 3</span> – Complex patient</div>
                <div><span style="color: red;">Acuity 4</span> – High risk patient</div>
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

