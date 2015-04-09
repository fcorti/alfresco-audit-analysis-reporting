{
  "data": {
    "package": "${packageNodeRef}",
    "items": {
<#list items as itemNodeRef>
      "item": "${itemNodeRef.nodeRef}"<#if itemNodeRef_has_next>,</#if>
</#list>
    ]
  }
}
