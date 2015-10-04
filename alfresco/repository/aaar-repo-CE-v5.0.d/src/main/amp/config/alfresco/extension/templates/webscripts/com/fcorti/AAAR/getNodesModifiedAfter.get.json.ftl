{
  "count": ${count!0},
  "list": [
  <#list results! as result>
    {
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
      "mimetype":"<#if parameters["mimetype"]??>${parameters["mimetype"]}<#else></#if>",
      "size":<#if parameters["size"]??>${parameters["size"]}<#else>0</#if>,
      "encoding":"<#if parameters["encoding"]??>${parameters["encoding"]}<#else></#if>",
      "content-locale":"<#if parameters["content-locale"]??>${parameters["content-locale"]}<#else></#if>",
      "parent-node-uuid":"${result["parent-node-uuid"]}"
    }<#if result_has_next>,</#if>
  </#list>
  ],
  "parameters": {
    "baseType":"<#if parameters["baseType"]??>${parameters["baseType"]}<#else></#if>",
    "dt":"<#if parameters["dt"]??>${parameters["dt"]}<#else></#if>",
    "limit":<#if parameters["limit"]??>${parameters["limit"]}<#else>0</#if>,
    "skip":<#if parameters["skip"]??>${parameters["skip"]}<#else>0</#if>
  },
  "newParameters": {
    "baseType":"<#if newParameters["baseType"]??>${newParameters["baseType"]}<#else></#if>",
    "dt":"<#if newParameters["dt"]??>${newParameters["dt"]}<#else></#if>",
    "limit":<#if newParameters["limit"]??>${newParameters["limit"]}<#else>0</#if>,
    "skip":<#if newParameters["skip"]??>${newParameters["skip"]}<#else>0</#if>
  }
}
