{
  "data": {
    "nodeRef": "${nodeRef}",
    "children": [
<#list children as child>
      "nodeRef": "${child.nodeRef}"<#if child_has_next>,</#if>
</#list>
    ]
  }
}