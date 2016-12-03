function renderMenu () {

  // Urls and paths.
  var basePath = "/pentaho/plugin";
  var relativePath = "/plugin";
  var aaarPath = basePath + "/AAAR";
  var aaarRelativePath = relativePath + "/AAAR";
  var aaarApiPath = aaarPath + "/api";
  var aaarApiRelativePath = aaarRelativePath + "/api";

  // Current page path.
  var pagePaths = "/main|/AAAR_Configure_Alfresco|/AAAR_Configure_DataMart|/AAAR_Configure_PDI|/AAAR_Install|/AAAR_Use|/AAAR_Use_Extract|/AAAR_Use_Publish|/AAAR_Use_Analyze|/AAAR_Customize|/AAAR_Customize_Instances|/AAAR_Customize_Properties|/AAAR_Customize_Properties_Create|/AAAR_Customize_Publish/AAAR_Extractions|/AAAR_About";
  var pagePath = location.pathname;
  pagePath = pagePath.substring(aaarApiPath.length);
  pagePath = pagePath.toLowerCase();

  document.write("<ul class=\"nav nav-pills nav-stacked\">");

  // Home.
  document.write("<li " + (pagePath == "/main"  ? "class=\"active\"" : "") + "><a " + (pagePath != "/main"  ? "href=\"" +  aaarApiPath +  "/main\"" : "") + "><span style=\"font-size:1.1em; font-weight: bold;\"><span class=\"glyphicon glyphicon-home\" aria-hidden=\"true\"></span></span> Home</a></li>");

  // Configure.
  document.write("<li " + (pagePath == "/aaar_configure_alfresco" || pagePath == "/aaar_configure_datamart" || pagePath == "/aaar_configure_pdi" ? "class=\"active\"" : "") + "><a href=\"#\"" + (pagePath != "/aaar_configure_alfresco" ? " onclick=\"loadAndRedirect(Dashboards.getWebAppPath() + '" +  aaarApiRelativePath +  "/AAAR_Configure_Alfresco');\"" : "") + "><span style=\"font-size:1.1em; font-weight: bold;\">1.</span> Configure</a></li>");

  // Install.
  document.write("<li " + (pagePath == "/aaar_install" ? "class=\"active\"" : "") + "><a href=\"#\"" + (pagePath != "/aaar_install" ? " onclick=\"loadAndRedirect(Dashboards.getWebAppPath() + '" +  aaarApiRelativePath + "/AAAR_Install');\"" : "") + "><span style=\"font-size:1.1em; font-weight: bold;\">2.</span> Install</a></li>");

  // Use.
  document.write("<li " + (pagePath == "/aaar_use" || pagePath == "/aaar_use_extract" || pagePath == "/aaar_use_publish" || pagePath == "/aaar_use_analyze" ? "class=\"active\"" : "") + "><a href=\"" + (pagePath != "/aaar_use" ? aaarApiPath + "/AAAR_Use" : "#") + "\"><span style=\"font-size:1.1em; font-weight: bold;\">3.</span> Use</a></li>");

  // Customize.
  document.write("<li " + (pagePath == "/aaar_customize" || pagePath == "/aaar_customize_instances" || pagePath == "/aaar_customize_properties" || pagePath == "/aaar_customize_properties_create" || pagePath == "/aaar_customize_publish" ? "class=\"active\"" : "") + "><a href=\"" + (pagePath != "/aaar_customize" ? aaarApiPath + "/AAAR_Customize" : "#") + "\"><span style=\"font-size:1.1em; font-weight: bold;\"><span class=\"glyphicon glyphicon-cog\" aria-hidden=\"true\"></span></span> Customize</a></li>");

  // Extractions.
  document.write("<li " + (pagePath == "/aaar_extractions" ? "class=\"active\"" : "") + "><a href=\"" + (pagePath != "/aaar_extractions" ? aaarApiPath + "/AAAR_Extractions" : "#") + "\"><span style=\"font-size:1.1em; font-weight: bold;\"><span class=\"glyphicon glyphicon-import\" aria-hidden=\"true\"></span></span> Extractions</a></li>");

  // About.
  document.write("<li " + (pagePath == "/aaar_about" ? "class=\"active\"" : "") + "><a href=\"" + (pagePath != "/aaar_about" ? aaarApiPath + "/AAAR_About" : "#") + "\"><span style=\"font-size:1.1em; font-weight: bold;\"><span class=\"glyphicon glyphicon-info-sign\" aria-hidden=\"true\"></span></span> About</a></li>");

  document.write("</ul>");

} 
