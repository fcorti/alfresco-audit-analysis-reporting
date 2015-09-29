{
  "count": ${count!0},
  "list": [<#list results as result>${result}<#if result_has_next>,</#if></#list>],
  "parameters": {
    "baseType": "<#if parameters["baseType"]??>${parameters["baseType"]}<#else></#if>",
    "dt": "<#if parameters["dt"]??>${parameters["dt"]}<#else></#if>",
    "skip": <#if parameters["skip"]??>${parameters["skip"]}<#else>0</#if>,
    "limit": <#if parameters["limit"]??>${parameters["limit"]}<#else>0</#if>
  },
  "newParameters": {
    "baseType": "<#if newParameters["baseType"]??>${newParameters["baseType"]}<#else></#if>",
    "dt": "<#if newParameters["dt"]??>${newParameters["dt"]}<#else></#if>",
    "skip": <#if newParameters["skip"]??>${newParameters["skip"]}<#else>0</#if>,
    "limit": <#if newParameters["limit"]??>${newParameters["limit"]}<#else>0</#if>
  }
}
