<@markup id="css" >
   <#-- CSS Dependencies -->
   <@link rel="stylesheet" type="text/css" href="${url.context}/res/components/dashlets/aaar-dashlet.css"  group="dashlets" />
</@>

<@markup id="js">
   <#-- JavaScript Dependencies -->
   <@script type="text/javascript" src="${url.context}/res/components/dashlets/aaar-dashlet.js" group="dashlets"/>
</@>

<@markup id="widgets">
   <@createWidgets group="dashlets"/>
</@>

<@markup id="html">
   <@uniqueIdDiv>
      <#assign id = args.htmlid?html>
      <div class="dashlet aaar">
         <div class="title">${msg("AAAR.dashlet.title")}</div>
         <div class="toolbar flat-button">
            <div class="hidden">
               <span class="align-left yui-button yui-menu-button" id="${id}-type">
                  <span class="first-child">
                     <button type="button" tabindex="0">${msg("AAAR.dashlet.analytics.filter.all")}</button>
                  </span>
               </span>
               <select id="${id}-type-menu">
                  <option value="all">${msg("AAAR.dashlet.analytics.filter.all")}</option>
                  <option value="dashboards">${msg("AAAR.dashlet.analytics.filter.dashboards")}</option>
                  <option value="reports">${msg("AAAR.dashlet.analytics.filter.reports")}</option>
                  <option value="freeAnalysis">${msg("AAAR.dashlet.analytics.filter.freeAnalysis")}</option>
               </select>
               <span class="align-right yui-button-align">
                  <#if documentation.view>
                  <span class="first-child">
                     <a href="${documentation.url}" id="${id}-documentation-button" class="theme-color-1" target="_blank">
                        <img src="${url.context}/res/components/images/${documentation.icon}" style="vertical-align: text-bottom" />
                        ${msg("AAAR.dashlet.documentation")}</a>
                  </span>
                  </#if>
               </span>
               <div class="clear"></div>
            </div>
         </div>
         <div id="${id}-aaar" class="body scrollableList" <#if args.height??>style="height: ${args.height?html}px;"</#if>></div>
      </div>
   </@>
</@>
