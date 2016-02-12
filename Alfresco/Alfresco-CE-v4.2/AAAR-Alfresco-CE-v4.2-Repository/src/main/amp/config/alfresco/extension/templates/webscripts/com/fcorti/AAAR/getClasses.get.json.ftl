{
 "count":${count!0},
 "list":[<#list results! as result> {
  "class":"${result["class"]}",
  "prefixedClass":"${result["prefixedClass"]}",
  "namespaceuri":"${result["namespaceuri"]}",
  "prefix":"${result["prefix"]}",
  "name":"${result["name"]}"
 }<#if result_has_next>,</#if></#list>],
