function dashboardHeader () {

  // Urls and paths.
  var platformPath = "/pentaho";
  var alflyticsPrefix = platformPath + "/api/repos/%3Apublic%3AAlflytics%3A";
  var alflyticsDashboardPrefix = alflyticsPrefix + "Dashboards%3A";
  var alflyticsDashboardSuffix = ".wcdf/generatedContent";
  var alflyticsReportPrefix = alflyticsPrefix + "Reports%3A";
  var alflyticsReportSuffix = ".prpt/viewer";
  var saikuPath = platformPath + "/content/saiku-ui/index.html?biplugin5=true&dimension_prefetch=false#query/open/%3Apublic%3AAlflytics%3AOLAP%3A";

  document.write("<nav class=\"navbar navbar-default\" style=\"border-radius: 0px; border-left-width: 0px; border-right-width: 0px; background: #ffffff url('/pentaho/api/repos/Alflytics/static/system/img/pluginLogo.png') no-repeat center right; background-size: 100px;\">");

  document.write("<div class=\"container-fluid\">");

  // Application logo. Modify here to customize the application.
  document.write("<div class=\"navbar-header\">");
  document.write(" <a class=\"navbar-brand\" href=\"" + alflyticsDashboardPrefix + "main" + alflyticsDashboardSuffix + "\"><b>Alflytics</b></a>");
  document.write("</div>");

  // Menu. Modify this section to customize the header menu.
  document.write("<ul class=\"nav navbar-nav\">");

  // Dashboards.
  document.write("<li class=\"dropdown\">");
  document.write(" <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">Dashboards <span class=\"caret\"></span></a>");
  document.write(" <ul class=\"dropdown-menu\">");
  document.write("  <li><a href=\"" + alflyticsDashboardPrefix + "main" + alflyticsDashboardSuffix + "\">Main dashboard</a></li>");
  document.write(" </ul>");
  document.write("</li>");

  // Reports.
  document.write("<li class=\"dropdown\">");
  document.write(" <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">Reports <span class=\"caret\"></span></a>");
  document.write(" <ul class=\"dropdown-menu\">");
  document.write("  <li class=\"dropdown-header\">Alfresco users</li>");
  document.write("  <li><a href=\"" + alflyticsReportPrefix + "alfresco_auditTrail_topUsers" + alflyticsReportSuffix + "\" target=\"_blank\">Most active users</a></li>");
  document.write("  <li><a href=\"" + alflyticsReportPrefix + "alfresco_auditTrail_user" + alflyticsReportSuffix + "\" target=\"_blank\">Audit per user (Excel)</a></li>");
  document.write("  <li class=\"dropdown-header\">Alfresco audit trail</li>");
  document.write("  <li><a href=\"" + alflyticsReportPrefix + "alfresco_auditTrail_actions" + alflyticsReportSuffix + "\" target=\"_blank\">Audit per actions</a></li>");
  document.write("  <li><a href=\"" + alflyticsReportPrefix + "alfresco_auditTrail_topContent" + alflyticsReportSuffix + "\" target=\"_blank\">Most accessed content</a></li>");
  document.write("  <li><a href=\"" + alflyticsReportPrefix + "alfresco_auditTrail_days" + alflyticsReportSuffix + "\" target=\"_blank\">Audit per day</a></li>");
  document.write("  <li><a href=\"" + alflyticsReportPrefix + "alfresco_auditTrail_time" + alflyticsReportSuffix + "\" target=\"_blank\">Audit per hour</a></li>");
  document.write("  <li><a href=\"" + alflyticsReportPrefix + "alfresco_auditTrail_details" + alflyticsReportSuffix + "\" target=\"_blank\">Audit trail (Excel)</a></li>");
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
