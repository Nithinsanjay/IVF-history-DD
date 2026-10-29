<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.OncologyModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <script type="text/javascript">
        $(document).ready(function (e) {
        });

        function adjustTableHeight(tabulatorGridId) {
            const instances = Tabulator.findTable("#" + tabulatorGridId);
            if (!instances || instances.length === 0) return;
            const table = instances[0];
            const scrollLeft = table.rowManager.element.scrollLeft;
            const rows = table.getRows();
            let totalHeight = 0;
            rows.forEach(row => {
                totalHeight += row.getElement().offsetHeight;
            });
            const headerEl = document.querySelector(`#${tabulatorGridId} .tabulator-header`);
            if (headerEl) {
                const headerHeight = headerEl.offsetHeight;
                const newHeight = totalHeight + headerHeight + 30;
                table.setHeight(newHeight);
                setTimeout(() => {
                    table.rowManager.element.scrollLeft = scrollLeft;
                }, 0);
            }
        }

        function autoResizeTextareaForSinglePage(el) {
            const lines = el.value.split("\n").length;
            el.rows = lines;
            if (el.style.overflow === 'hidden') {
                el.style.overflow = 'auto';
            }
        }

    </script>
  <div class="opd-main-container">
  <div id="HeaderSection_PACPatInfo" class="patient-info-header"> 
      <div id='loading-PatientInfo' class='loading-screen' style='display: none; opacity: 0;'></div>
  </div> 
      <% Html.RenderAction("PAC", "DoctorDesk"); %>
  </div>
</asp:Content>
