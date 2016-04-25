{
 "count":${count!0},
 "list":[<#list results! as result> {
  "property":"${result["property"]}",
  "prefixedProperty":"${result["prefixedProperty"]}",
  "namespaceuri":"${result["namespaceuri"]}",
  "prefix":"${result["prefix"]}",
  "name":"${result["name"]}",
  "dataType":"${result["dataType"]}",
  "prefixedDataType":"${result["prefixedDataType"]}",
  "class":"${result["class"]}",
  "prefixedClass":"${result["prefixedClass"]}",
  "classIsAspect":"${result["classIsAspect"]}",
  "classIsContentSubtype":"${result["classIsContentSubtype"]}",
  "classIsFolderSubtype":"${result["classIsFolderSubtype"]}"
 }<#if result_has_next>,</#if></#list>]
}