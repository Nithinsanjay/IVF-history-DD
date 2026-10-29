<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UIHelperPV>" %>

<style type="text/css">
    .panel-title > a {
        display: block;
        text-decoration: none;
    }
</style>

<script type="text/javascript">

    const dictCount = {
        '1': 'collapseOne',
        '2': 'collapseTwo',
        '3': 'collapseThree',
        '4': 'collapseFour',
        '5': 'collapseFive',
        '6': 'collapseSix',
        '7': 'collapseSeven',
        '8': 'collapseEight',
        '9': 'collapseNine',
        '10': 'collapseTen'
    };
    var GlobalcollapseId = '<%= Model.CollapseId %>';  // Getting Collapse Id To Expand Tab automatically

    $(document).ready(function () {
        HelperToolsLoad();
        PageLoad();
        preloadHiddenIframes();
        dynamicallyIframeLoad(); // Dynamically iFrame Loading.. 
        openSelectedMenu();
        //var iframe = document.getElementById('myIframe');
        //var menuL = document.querySelector('[id="iframe menuList"]');
        //menuL.style.display = "block";

    });

    function HelperToolsLoad() {
        if ($(window).width() >= 1200) {
            $("#tabMenu").css("display", "block");
        }
    }

    function PageLoad() {
        // console.log('Page Loaded!');
    }

    function preloadHiddenIframes() {
        const iframePromises = [];

        $('.collapse iframe').each(function (index, iframeElement) {
            const $iframe = $(iframeElement);
            const src = $iframe.data('src');

            if (!$iframe.attr('src') && src) {
                const loadPromise = new Promise((resolve, reject) => {
                    $iframe.on('load', function () {
                        $iframe.attr('data-loaded', 'true');
                        // Trigger a custom event to let main loader know it finished
                        $iframe.trigger('iframe-preloaded');
                        resolve();
                    });

                $iframe.on('error', function () {
                    reject(`❌ Error loading iframe: ${src}`);
                });

                    setTimeout(() => {
                        $iframe.attr('src', src);
                }, index * 100); // optional stagger
            });

            iframePromises.push(loadPromise);
          }
        });

        return Promise.all(iframePromises);
    }



    function dynamicallyIframeLoad() {
        $('.collapse').on('shown.bs.collapse', function () {
            $('.collapse').not(this).collapse('hide');

            const $iframe = $(this).find('iframe');
            const src = $iframe.data('src');

            HoldOn.open(); // Always show loader

            // If already loaded (either via preload or manual), run DOM adjustments
            if ($iframe.attr('data-loaded') === 'true') {
                // Try accessing iframe DOM
                try {
                    const iframeDoc = $iframe[0].contentDocument || $iframe[0].contentWindow.document;
                    if (iframeDoc) {
                        handleDomInIframe(iframeDoc);
                    }
                } catch (err) {
                    console.warn("Iframe DOM not accessible yet.", err);
                }

                HoldOn.close();
                return;
            }

            // Not loaded yet - listen for load
            $iframe.off('load').on('load', function () {
                const iframeLocation = this.contentWindow.location.href;
                if (iframeLocation.includes('/Account/Login')) {
                    window.location.href = iframeLocation;
                }

                const iframeDoc = this.contentDocument || this.contentWindow.document;
                if (iframeDoc) {
                    handleDomInIframe(iframeDoc);
                }

                $iframe.attr('data-loaded', 'true');
                HoldOn.close();
            });

            if (!$iframe.attr('src') && src) {
                $iframe.attr('src', src);
            }
        });

        // Optional: If iframe was already preloaded before shown, hook onto custom event
        $('iframe').on('iframe-preloaded', function () {
            // We only handle DOM adjustments when collapse is already visible
            if ($(this).closest('.collapse').hasClass('show')) {
                try {
                    const iframeDoc = this.contentDocument || this.contentWindow.document;
                    if (iframeDoc) {
                        handleDomInIframe(iframeDoc);
                    }
                } catch (err) {
                    console.warn("Could not access preloaded iframe DOM.", err);
                }

                HoldOn.close();
            }
        });
    }


    //function dynamicallyIframeLoad() {
    //    $('.collapse').on('shown.bs.collapse', function () {
    //        $('.collapse').not(this).collapse('hide');
    //        HoldOn.open();
    //        const $iframe = $(this).find('iframe');
    //        const src = $iframe.data('src');
    //        if (!$iframe.attr('src') && src) {
    //            var iframeLoaded = false;
    //            $iframe.on('load', function () {

    //                const iframeLocation = this.contentWindow.location.href;
    //                if (iframeLocation.includes('/Account/Login')) {
    //                    //alert('Session expired. Redirecting to login page.');
    //                    window.location.href = iframeLocation;
    //                }

    //                var iframe = this;
    //                var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;

    //                if (iframeDoc) {
    //                    handleDomInIframe(iframeDoc);
    //                }

    //                if (!iframeLoaded) {
    //                    iframeLoaded = true;
    //                    HoldOn.close();
    //                    return;
    //                }
    //                iframeLoaded = false;
    //                $iframe[0].src = src;
    //                HoldOn.close();
    //            });
    //            $iframe.attr('src', src);
    //        } else {
    //            HoldOn.close();
    //        }
    //    });
    //}


    function openSelectedMenu() {
       // console.log('GlobalcollapseId', GlobalcollapseId);
        let targetId = dictCount[GlobalcollapseId];
        if (targetId) {
            setTimeout(function () {
                $('#' + targetId).collapse('show');
            }, 400);
        }
    }

    function handleDomInIframe(iframeDoc) {
        var menuList = iframeDoc.getElementById('menuList');
        let mainHeaders = iframeDoc.getElementsByClassName('main-header');
        let fullContent = iframeDoc.getElementById('secCont');
        let mainContent = iframeDoc.getElementsByClassName('content'); // returns collection
        let mainContentDiv = iframeDoc.getElementById('MainDiv');
        $('#tabMenuUl').hide();
        if (menuList) {
            menuList.style.display = 'none';

            // Hide all main-header elements
            for (let i = 0; i < mainHeaders.length; i++) {
                mainHeaders[i].style.display = 'none';
            }

            // Style fullContent if found
            if (fullContent) {
                fullContent.style.marginLeft = '10px';
                fullContent.style.marginTop = '15px';
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

    function openTabInIframe(tabId) {
        $('#' + tabId).collapse('show')
    }

</script>

<style>
  .accordion .card {
    border: none;
    border-radius: 0;
    margin-bottom: 5px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .accordion .card-header {
    background-color: #3683d8;
    color: white;
    padding: 0;
  }

  .accordion .card-header h2 {
    margin: 0;
  }

  .accordion .btn-link {
    display: block;
    width: 100%;
    text-align: left;
    color: white;
    background-color: cadetblue;
    padding: 12px 20px;
    font-size: 15px;
    font-weight: 500;
    text-decoration: none;
    transition: background-color 0.3s ease;
    border: none;
  }

  .accordion .btn-link:hover,
  .accordion .btn-link:focus {
    background-color: #3f6ea1;
    text-decoration: none;
    color: white;
    box-shadow: none;
  }

    /* Rotate arrow up when expanded */
    .accordion .btn-link.collapsed .arrow::after {
      content: "▼"; /* down arrow */
    }

    .accordion .btn-link .arrow::after {
      content: "▼"; /* down arrow */
      font-size: 14px;
      transition: transform 0.3s ease;
      color: white;
    }

    /* When panel is open, show up arrow */
    .accordion .btn-link:not(.collapsed) .arrow::after {
      content: "▲"; /* up arrow */
    }


</style>

<div class="accordion" id="accordionExample">

  <!-- Panel 1 -->
  <div class="card">
    <div class="card-header" id="headingOne">
      <h2 class="mb-0">
      <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseOne"
          aria-expanded="false" aria-controls="collapseOne" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          📝 Complaint List
          <span class="arrow"></span>
        </button>
      </h2>
    </div>

    <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
      <div class="card-body p-0" style="overflow: hidden;position:relative;">
        <iframe id="collapseIframeOne" data-src="../DoctorDesk/Complaints" width="100%"  height="600" frameborder="0" style="display:block;"></iframe>
          <!-- Continue Button -->
          <div style="position: absolute;left: 53%;bottom:1%;transform: translateX(-50%); z-index: 10;">
              <button id="btnComplete" onclick="openTabInIframe('collapseTwo');"
                  class="btn"
                  style="background-color: #dd4619; color: white; border-radius: 5px; padding: 4px 15px; font-size: 14px; font-weight: 600; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                  Continue
              </button>
          </div>    
      </div>
    </div>
  </div>

  <!-- Panel 2 -->
  <div class="card">
    <div class="card-header" id="headingTwo">
      <h2 class="mb-0">
       <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo"
          aria-expanded="false" aria-controls="collapseTwo" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          🩺 Vitals
          <span class="arrow"></span>
        </button>
      </h2>
    </div>
    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
      <div class="card-body p-0" style="overflow: hidden;position:relative;">
        <iframe data-src="../DoctorDesk/Vitals" width="100%" height="600" frameborder="0" style="display:block;"></iframe>
          <%-- Added by Dhananjay 20250926 --%>
          <!-- Continue Button -->
           <div style="position: absolute;left: 61%;bottom:3.5%;transform: translateX(-50%); z-index: 10;">
              <button id="btnComplete" onclick="openTabInIframe('collapseThree');"
                  class="btn"
                  style="background-color: #dd4619; color: white; border-radius: 5px; padding: 4px 15px; font-size: 14px; font-weight: 600; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                  Continue
              </button>
          </div> 
      </div>
    </div>
  </div>

  <!-- Panel 3 -->
  <div class="card">
    <div class="card-header" id="headingThree">
      <h2 class="mb-0">
      <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree"
          aria-expanded="false" aria-controls="collapseThree" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          🩺 Examination
          <span class="arrow"></span>
        </button>

      </h2>
    </div>
    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
      <div class="card-body p-0" style="overflow: hidden;position:relative;">
           <iframe data-src="../DoctorDesk/Examination" width="100%" height="600"  frameborder="0" style="display:block;"></iframe>
           <!-- Continue Button -->
           <div style="position: absolute;left: 62%;bottom:3.5%;transform: translateX(-50%); z-index: 10;">
              <button id="btnComplete" onclick="openTabInIframe('collapseFour');"
                  class="btn"
                  style="background-color: #dd4619; color: white; border-radius: 5px; padding: 4px 15px; font-size: 14px; font-weight: 600; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                  Continue
              </button>
          </div> 
      </div>
    </div>
  </div>

   <!-- Panel 4  -->
  <div class="card">
    <div class="card-header" id="headingFour">
      <h2 class="mb-0">
      <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseFour"
          aria-expanded="false" aria-controls="collapseFour" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          📒 Clinical Notes
          <span class="arrow"></span>
        </button>

      </h2>
    </div>
    <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordionExample">
      <div class="card-body p-0" style="overflow: hidden;position:relative;">
           <iframe data-src="../DoctorDesk/ClinicalNotes" width="100%" height="600" frameborder="0" style="display:block;"></iframe>
          <!-- Continue Button -->
           <div style="position: absolute;left: 62%;bottom:3.5%;transform: translateX(-50%); z-index: 10;">
              <button id="btnComplete" onclick="openTabInIframe('collapseFive');"
                  class="btn"
                  style="background-color: #dd4619; color: white; border-radius: 5px; padding: 4px 15px; font-size: 14px; font-weight: 600; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                  Continue
              </button>
          </div> 
      </div>
    </div>
  </div>

  <!-- Panel 5 Diagnosis -->
  <div class="card">
    <div class="card-header" id="headingFive">
      <h2 class="mb-0">
       <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseFive"
          aria-expanded="false" aria-controls="collapseFive" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          🔍 Diagnosis
          <span class="arrow"></span>
        </button>

      </h2>
    </div>
    <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordionExample">
      <div class="card-body p-0" style="overflow: hidden;position:relative;">
           <iframe data-src="../DoctorDesk/Diagnosis" width="100%" height="600" frameborder="0" style="display:block;"></iframe>
            <!-- Continue Button -->
           <div style="position: absolute;left: 62%;bottom:3.5%;transform: translateX(-50%); z-index: 10;">
              <button id="btnComplete" onclick="openTabInIframe('collapseSix');"
                  class="btn"
                  style="background-color: #dd4619; color: white; border-radius: 5px; padding: 4px 15px; font-size: 14px; font-weight: 600; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                  Continue
              </button>
          </div> 
      </div>
    </div>
  </div>

  <!-- Panel 6 -->
  <div class="card">
    <div class="card-header" id="headingSix">
      <h2 class="mb-0">
       <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseSix"
          aria-expanded="false" aria-controls="collapseSix" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          🔬 Investigations Notes
          <span class="arrow"></span>
        </button>
      </h2>
    </div>
    <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordionExample">
      <div class="card-body p-0" style="overflow: hidden;position:relative;">
           <iframe data-src="../DoctorDesk/InvestigationTran" width="100%" height="600" frameborder="0" style="display:block;"></iframe>
            <!-- Continue Button -->
           <div style="position: absolute;left: 62%;bottom:3.5%;transform: translateX(-50%); z-index: 10;">
              <button id="btnComplete" onclick="openTabInIframe('collapseSeven');"
                  class="btn"
                  style="background-color: #dd4619; color: white; border-radius: 5px; padding: 4px 15px; font-size: 14px; font-weight: 600; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                  Continue
              </button>
          </div>
      </div>
    </div>
  </div>

  <!-- Panel 7 -->
  <div class="card">
    <div class="card-header" id="headingSeven">
      <h2 class="mb-0">
     <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseSeven"
          aria-expanded="false" aria-controls="collapseSeven" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          💊 Rx
          <span class="arrow"></span>
        </button>

      </h2>
    </div>
    <div id="collapseSeven" class="collapse" aria-labelledby="headingSeven" data-parent="#accordionExample">
      <div class="card-body p-0" style="overflow: hidden;position:relative;">
           <iframe data-src="../DoctorDesk/RxDesktop" width="100%" height="600" frameborder="0" style="display:block;"></iframe>
            <!-- Continue Button -->
           <div style="position: absolute;left: 62%;bottom:3.5%;transform: translateX(-50%); z-index: 10;">
              <button id="btnComplete" onclick="openTabInIframe('collapseEight');"
                  class="btn"
                  style="background-color: #dd4619; color: white; border-radius: 5px; padding: 4px 15px; font-size: 14px; font-weight: 600; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                  Continue
              </button>
          </div>
      </div>
    </div>
  </div>

 
  <!-- Panel 8 -->
  <div class="card">
    <div class="card-header" id="headingEight">
      <h2 class="mb-0">
      <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseEight"
          aria-expanded="false" aria-controls="collapseEight" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          💬 Patient Advice
          <span class="arrow"></span>
        </button>

      </h2>
    </div>
    <div id="collapseEight" class="collapse" aria-labelledby="headingEight" data-parent="#accordionExample">
      <div class="card-body p-0" style="overflow: hidden;position:relative;">
           <iframe data-src="../DoctorDesk/PatientAdvice" width="100%" height="600" frameborder="0" style="display:block;"></iframe>
          <!-- Continue Button -->
           <div style="position: absolute;left: 62%;bottom:3.5%;transform: translateX(-50%); z-index: 10;">
              <button id="btnComplete" onclick="openTabInIframe('collapseNine');"
                  class="btn"
                  style="background-color: #dd4619; color: white; border-radius: 5px; padding: 4px 15px; font-size: 14px; font-weight: 600; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                  Continue
              </button>
          </div>
      </div>
    </div>
  </div>

  <!-- Panel 9 -->
  <div class="card">
    <div class="card-header" id="headingNine">
      <h2 class="mb-0">
        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseNine"
          aria-expanded="false" aria-controls="collapseNine" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          🧬 Chemo Planning
          <span class="arrow"></span>
        </button>

      </h2>
    </div>
    <div id="collapseNine" class="collapse" aria-labelledby="headingNine" data-parent="#accordionExample">
      <div class="card-body p-0" style="overflow: hidden;position:relative;"">
           <iframe data-src="../DoctorDesk/ChmoPlanning" width="100%" height="600" frameborder="0" style="display:block;"></iframe>
          <!-- Continue Button -->
           <div style="position: absolute;left: 53%;bottom:1%;transform: translateX(-50%); z-index: 10;">
              <button id="btnComplete" onclick="openTabInIframe('collapseTen');"
                  class="btn"
                  style="background-color: #dd4619; color: white; border-radius: 5px; padding: 4px 15px; font-size: 14px; font-weight: 600; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
                  Continue
              </button>
          </div>
      </div>
    </div>
  </div>

  <!-- Panel 10 -->
  <div class="card">
    <div class="card-header" id="headingTen">
      <h2 class="mb-0">
       <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTen"
          aria-expanded="false" aria-controls="collapseTen" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
          🖨️ Prescription Print
          <span class="arrow"></span>
        </button>
      </h2>
    </div>
    <div id="collapseTen" class="collapse" aria-labelledby="headingTen" data-parent="#accordionExample">
      <div class="card-body">
           <iframe data-src="../DoctorDesk/PrescriptionPrint" width="100%" height="600" frameborder="0" style="display:block;"></iframe>
      </div>
    </div>
  </div>

</div>
