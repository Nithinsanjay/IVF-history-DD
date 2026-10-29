using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace OncologyEMR.App_Start
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            //bundles.Add(new StyleBundle("~/Styles/JQueryUi").Include(
                      
            //      "~/JQueryUi/jquery.ui.theme.css",                  
            //      "~/JQueryUi/jquery.ui.css"));
            //bundles.Add(new StyleBundle("~/font-awesome").Include(
            //     "~/font-awesome/css/font-awesome.css",
            //       "~/font-awesome/css/font-awesome.min.css"
            //    ));
            //  bundles.Add(new StyleBundle("~/Styles/bootstrap").Include(
            //    "~/bootstrap/Icon.css" 
            //    ));
            // bundles.Add(new StyleBundle("~/Styles/plugin").Include(
            //    "~/plugins/select2/select2.css"
            //    ));
            //   bundles.Add(new StyleBundle("~/Styles/dist").Include(
            //       "~/dist/css/AdminLTE.css",
            //        "~/dist/css/skins/skin-blue.min.css"        
               
            //    ));
            //  bundles.Add(new StyleBundle("~/Styles/jqGrid").Include(
            //    "~/jqGrid/css/ui.jqgrid.css"
            //    ));
            //  bundles.Add(new StyleBundle("~/Styles/LoadingCursor").Include(
            //      "~/LoadingCursor/css/style.css",
            //     new CssRewriteUrlTransform()
            //    ));
            //bundles.Add(new StyleBundle("~/Styles/css").Include(
            //     "~/Styles/multi-select.css",
            //    "~/Styles/jqGrid.bootstrap.css",
            //         "~/Styles/bootstrap.css"
            //   ));
            //bundles.Add(new ScriptBundle("~/Scripts/jquery").Include(
            //    "~/Scripts/jquery-1-10-2.js",
            //    "~/dist/js/app.min.js",
            //   "~/Scripts/jquery-1-10-2.js",
            //     "~/dist/js/app.min.js",
            //     "~/Scripts/jquery-1-11-1-ui.js",
            //     "~/LoadingCursor/jquery-loader.js"
            //    )
            //);
            //bundles.Add(new ScriptBundle("~/Scripts/bootstrap").Include(
            //   "~/bootstrap/js/bootstrap.min.js",
            //     "~/bootstrap/js/jquery.messager.js",
            //     "~/bootstrap/js/dropdown.js",
            //      "~/plugins/slimScroll/jquery.slimscroll.js",
            //     "~/plugins/input-mask/jquery.inputmask.js",
            //       "~/plugins/input-mask/jquery.inputmask.date.extensions.js",
            //     "~/plugins/input-mask/jquery.inputmask.regex.extensions.js",
            //     "~/plugins/input-mask/jquery.inputmask.extensions.js",
            //      "~/Scripts/multi-select.js",
            //     "~/plugins/select2/select2.full.min.js")
            //);

            bundles.Add(new ScriptBundle("~/Scripts/jqGrid").Include(
                "~/js/jquery.jqGrid.js",
                "~/jqGrid/js/i18n/grid.locale-en.js",
                 "~/jqGrid/js/jquery.jqGrid.min.js")
            );

            BundleTable.EnableOptimizations = true;
           
        }
    }
}