{
  "count": ${count!0},
  "list": [<#list results as result>${result}<#if result_has_next>,</#if></#list>],
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
