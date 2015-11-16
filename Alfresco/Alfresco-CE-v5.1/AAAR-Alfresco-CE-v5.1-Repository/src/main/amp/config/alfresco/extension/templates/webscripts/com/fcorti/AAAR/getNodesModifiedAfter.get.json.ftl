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
      "mimetype":"<#if result["mimetype"]??>${result["mimetype"]}<#else></#if>",
      "size":<#if result["size"]??>${result["size"]}<#else>0</#if>,
      "encoding":"<#if result["encoding"]??>${result["encoding"]}<#else></#if>",
      "content-locale":"<#if result["content-locale"]??>${result["content-locale"]}<#else></#if>",
      "parent-node-uuid":"${result["parent-node-uuid"]}"
    }<#if result_has_next>,</#if>
  </#list>
  ],
  "parameters": {
    "baseType":"${parameters["baseType"]}",
    "dt":"${parameters["dt"]}",
    "limit":${parameters["limit"]},
    "skip":${parameters["skip"]}
  },
  "newParameters": {
    "baseType":"${newParameters["baseType"]}",
    "dt":"${newParameters["dt"]}",
    "limit":${newParameters["limit"]},
    "skip":${newParameters["skip"]}
  }
}
