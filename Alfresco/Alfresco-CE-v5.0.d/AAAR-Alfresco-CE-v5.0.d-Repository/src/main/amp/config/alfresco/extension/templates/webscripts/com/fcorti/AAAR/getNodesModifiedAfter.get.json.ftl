{
 "count":${count!0},
 "list":[<#list results! as result> {
  "node-dbid":${result["node-dbid"]},
  "store-protocol":"${result["store-protocol"]}",
  "store-identifier":"${result["store-identifier"]}",
  "node-uuid": "${result["node-uuid"]}",
  "name":"${result["name"]}",
  "type":"${result["type"]}",
  "creator":"${result["creator"]}",
  "created":"${result["created"]}",
  "locale":"${result["locale"]}",
  "modifier":"${result["modifier"]}",
  "modified":"${result["modified"]}",
  "path":"${result["path"]}",
  "mimetype":"<#if result["mimetype"]??>${result["mimetype"]}<#else></#if>",
  "size":<#if result["size"]??>${result["size"]}<#else>0</#if>,
  "encoding":"<#if result["encoding"]??>${result["encoding"]}<#else></#if>",
  "content-locale":"<#if result["content-locale"]??>${result["content-locale"]}<#else></#if>",
  "customTypes":[<#list result["customTypes"]! as customType>{
   "name":"${customType["name"]}",
   "properties":[<#list customType["properties"]! as customProperty>{"${customProperty["name"]}":"${customProperty["value"]}"}<#if customProperty_has_next>,</#if></#list>]
  }<#if customType_has_next>,</#if></#list>],
  "customAspects":[<#list result["customAspects"]! as customAspect>{
   "name":"${customAspect["name"]}",
   "properties":[<#list customAspect["properties"]! as customProperty>{"${customProperty["name"]}":"${customProperty["value"]}"}<#if customProperty_has_next>,</#if></#list>]
  }<#if customAspect_has_next>,</#if></#list>],
  "parent-node-uuid":"${result["parent-node-uuid"]}"
 }<#if result_has_next>,</#if></#list>],
 "parameters": {
  "baseType":"${parameters["baseType"]}",
  "dt":"${parameters["dt"]}",
  "limit":${parameters["limit"]},
  "skip":${parameters["skip"]},
  "namespaceuriCompacted":${parameters["namespaceuriCompacted"]}
 },
 "newParameters": {
  "baseType":"${newParameters["baseType"]}",
  "dt":"${newParameters["dt"]}",
  "limit":${newParameters["limit"]},
  "skip":${newParameters["skip"]},
  "namespaceuriCompacted":${parameters["namespaceuriCompacted"]}
 }
}
