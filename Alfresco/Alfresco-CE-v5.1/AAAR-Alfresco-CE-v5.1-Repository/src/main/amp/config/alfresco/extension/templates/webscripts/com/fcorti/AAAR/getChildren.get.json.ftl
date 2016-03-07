{
  "data": {
    "nodeRef": "${nodeRef}",
    "children": [
<#list children as child>
      "${child.nodeRef}"<#if child_has_next>,</#if>
</#list>
    ]
  }
}
