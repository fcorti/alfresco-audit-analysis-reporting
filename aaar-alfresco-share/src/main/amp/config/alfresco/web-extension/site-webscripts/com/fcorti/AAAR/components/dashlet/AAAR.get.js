function getAnalyticGroupSettings(dashletConfig, groupType) {

   if (typeof dashletConfig != "xml") {
      return [];
   }

   var result = [];
   for each (var link in dashletConfig.link)
   {
      result[result.length] = {
         type   : groupType, 
         icon   : link.@icon.toString(), 
         label  : link.@labelId.toString(), 
         url    : link.@url.toString(), 
         groups : link.@groups.toString().split(",")
      };
   }

   return result;
}

function getDocumentationSettings(dashletConfig) {

   if (dashletConfig == null) {
      return {
         view : false
      };
   }

   return {
      view : (dashletConfig.documentation.length() > 0),
      icon : (dashletConfig.documentation.@icon.length()) ? dashletConfig.documentation.@icon.toString() : "site-16.png",
      url : (dashletConfig.documentation.@url.length()) ? dashletConfig.documentation.@url.toString() : "http://fcorti.com/alfresco-audit-analysis-reporting/"
   };
}

function main() {

   // Configuration of the dashlet.
   var dashletConfig = new XML(config.script);

   // Settings for the documentation.
   model.documentation = getDocumentationSettings(dashletConfig);

   // Settings for the available analytics.
   var dashboardsSettings = getAnalyticGroupSettings(dashletConfig.dashboards, "dashboards");
   var reportsSettings = getAnalyticGroupSettings(dashletConfig.reports, "reports");
   var freeAnalysisSettings = getAnalyticGroupSettings(dashletConfig.freeAnalysis, "freeAnalysis");
   var analyticsSettings = dashboardsSettings.concat(reportsSettings).concat(freeAnalysisSettings);

   var dashletAAAR = {
      id : "AAAR",
      name : "Alfresco.dashlet.AAAR",
      options : {
         analytics : analyticsSettings,
         regionId : args['region-id']
      }
   };

   var dashletResizer = {
      id : "DashletResizer",
      name : "Alfresco.widget.DashletResizer",
      initArgs : ["\"" + args.htmlid + "\"", "\"" + instance.object.id + "\""],
      useMessages : false
   };

   var dashletTitleBarActions = {
      id : "DashletTitleBarActions",
      name : "Alfresco.widget.DashletTitleBarActions",
      useMessages : false,
      options : {
         actions: [
            {
               cssClass: "help",
               bubbleOnClick:
               {
                  message: msg.get("AAAR.dashlet.help")
               },
               tooltip: msg.get("dashlet.help.tooltip")
            }
         ]
      }
   };

   model.widgets = [dashletAAAR, dashletResizer, dashletTitleBarActions];
}

main();
