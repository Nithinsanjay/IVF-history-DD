<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.ViewLoad>" %>

<script type="text/javascript">

    var FormName = '<%= Model.FormName %>';
    var EmitUrl = '<%= Model.ViewUrl %>';

    $(document).ready(function () {
        console.log('partial view ready !');
        console.log('view name', FormName);
        console.log('EmitUrl ', EmitUrl);
        LoadIFrameConfig();
        LoadEmitView(FormName, EmitUrl);
    });

    function LoadEmitView(formName,EmitUrl) {
        let formUrl = '../DoctorDesk/' + EmitUrl;
        console.log('formurl', formUrl);
        $('#mainIFrameViewEmit').attr('src', formUrl);
    }

    function LoadIFrameConfig() {

        var iframeLoaded = false;
        $('#mainIFrameViewEmit').on('load', function () {

            const iframeLocation = this.contentWindow.location.href;
            if (iframeLocation.includes('/Account/Login')) {
                window.location.href = iframeLocation;
            }

            var iframe = this;
            var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;

            if (iframeDoc) {
                handleDomInIframe(iframeDoc);
            }

            if (!iframeLoaded) {
                iframeLoaded = true;
                return;
            }

            iframeLoaded = false;
            $iframe[0].src = src;
        });
    }

    function handleDomInIframe(iframeDoc) {
        var menuList = iframeDoc.getElementById('menuList');
        let mainHeaders = iframeDoc.getElementsByClassName('main-header');
        let fullContent = iframeDoc.getElementById('secCont');
        let mainContent = iframeDoc.getElementsByClassName('content'); // returns collection
        let mainContentDiv = iframeDoc.getElementById('MainDiv');

        if (menuList) {
            menuList.style.display = 'none';

            // Hide all main-header elements
            for (let i = 0; i < mainHeaders.length; i++) {
                mainHeaders[i].style.display = 'none';
            }

            // Style fullContent if found
            if (fullContent) {
                fullContent.style.marginLeft = '10px';
                fullContent.style.marginTop = '5px';
                fullContent.style.paddingTop = '20px';
                fullContent.style.width = '98%';
            }

            // Apply styles to all elements with class 'content'
            for (let i = 0; i < mainContent.length; i++) {
                mainContent[i].style.minHeight = '0px';
                mainContent[i].style.padding = '0px';
                mainContent[i].style.paddingLeft = '0px';
                mainContent[i].style.paddingRight = '0px';
                mainContent[i].style.marginTop = '10px !important';
            }

            if (mainContentDiv) {
                mainContentDiv.style.setProperty('width', '100%', 'important');
            }
        }
    }

</script>

<iframe id="mainIFrameViewEmit" width="100%" height="100%" frameborder="0" style="display:block;"></iframe>
