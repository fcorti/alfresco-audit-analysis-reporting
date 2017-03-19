function dashboardHeader () {

  // Urls and paths.
  var platformPath = "/pentaho";
  var alflyticsPath = platformPath + "/api/repos/%3Apublic%3AAlflytics%3ADashboards%3A";
  var alflyticsSuffix = ".wcdf/generatedContent";
  var saikuPath = platformPath + "/content/saiku-ui/index.html?biplugin5=true&dimension_prefetch=false#query/open/%3Apublic%3AAlflytics%3AOLAP%3A";

  document.write("<nav class=\"navbar navbar-default\" style=\"border-radius: 0px; border-left-width: 0px; border-right-width: 0px; background: #ffffff url('/pentaho/api/repos/Alflytics/static/system/img/pluginLogo.png') no-repeat center right; background-size: 100px;\">");

  document.write("<div class=\"container-fluid\">");

  // Application logo. Modify here to customize the application.
  document.write("<div class=\"navbar-header\">");
  document.write(" <a class=\"navbar-brand\" href=\"/pentaho/api/repos/%3Apublic%3AAlflytics%3ADashboards%3Amain.wcdf/generatedContent\"><b>Alflytics</b></a>");
  document.write("</div>");

  // Menu. Modify this section to customize the header menu.
  document.write("<ul class=\"nav navbar-nav\">");

  // Dashboards.
  document.write("<li class=\"dropdown\">");
  document.write(" <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">Dashboards <span class=\"caret\"></span></a>");
  document.write(" <ul class=\"dropdown-menu\">");
  document.write("  <li><a href=\"" + alflyticsPath + "main" + alflyticsSuffix + "\">Main dashboard</a></li>");
  document.write(" </ul>");
  document.write("</li>");

  // Reports.
  document.write("<li class=\"dropdown\">");
  document.write(" <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">Reports <span class=\"caret\"></span></a>");
  document.write(" <ul class=\"dropdown-menu\">");
  document.write("  <li><a href=\"#\">...</a></li>");
  document.write(" </ul>");
  document.write("</li>");

  // Free analysis.
  document.write("<li class=\"dropdown\">");
  document.write(" <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">Free analysis <span class=\"caret\"></span></a>");
  document.write(" <ul class=\"dropdown-menu\">");
  document.write("  <li class=\"dropdown-header\">Alfresco audit trail</li>");
  document.write("  <li><a href=\"" + saikuPath + "/alfresco%20audit%20trail.saiku\" target=\"_blank\">Alfresco audit trail (alfresco-access)</a></li>");
  document.write("  <li role=\"separator\" class=\"divider\"></li>");
  document.write("  <li class=\"dropdown-header\">Alfresco repository</li>");
  document.write("  <li><a href=\"" + saikuPath + "/alfresco%20content.saiku\" target=\"_blank\">Alfresco content</a></li>");
  document.write("  <li><a href=\"" + saikuPath + "/alfresco%20folder.saiku\" target=\"_blank\">Alfresco folders</a></li>");
  document.write("  <li><a href=\"" + saikuPath + "/alfresco%20categories.saiku\" target=\"_blank\">Alfresco categories</a></li>");
  document.write("  <li><a href=\"" + saikuPath + "/alfresco%20tags.saiku\" target=\"_blank\">Alfresco tags</a></li>");
  document.write("  <li role=\"separator\" class=\"divider\"></li>");
  document.write("  <li class=\"dropdown-header\">Alfresco processes</li>");
  document.write("  <li><a href=\"" + saikuPath + "/alfresco%20process%20instances.saiku\" target=\"_blank\">Alfresco process instances</a></li>");
  document.write("  <li><a href=\"" + saikuPath + "/alfresco%20process%20tasks.saiku\" target=\"_blank\">Alfresco process tasks</a></li>");
  document.write(" </ul>");
  document.write("</li>");

  // About.
  document.write("<li><a href=\"/pentaho/plugin/Alflytics/api/about\" target=\"_blank\">About</a></li>");

  document.write("</ul>");

  document.write("</div>");

  document.write("</nav>");

}
