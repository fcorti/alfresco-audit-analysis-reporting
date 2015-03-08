
var headerMenu = widgetUtils.findObject(model.jsonModel, "id", "HEADER_APP_MENU_BAR");

if (headerMenu != null) {

	var AAARMenu = {};

    if (config.scoped["AAAR"]["visible"]) {

        if (config.scoped["AAAR"]["visible"].getValue() == "true") {

            AAARMenu = {
                id: "HEADER_AAAR_DROPDOWN",
                name: "alfresco/header/AlfMenuBarPopup",
                config: {
                    label: msg.get("AAAR_Menu.desc"),
                    widgets: []
                }
            };

            if (config.scoped["AAAR"]["dashboards"]) {
                AAARMenu_appendGroupWidget(
                    "alfresco/menus/AlfMenuGroup",
                    AAARMenu.config.widgets, 
                    "AAAR_Menu.dashboard.group",
                    config.scoped["AAAR"]["dashboards"].getChildren("link")
                );
            }

            if (config.scoped["AAAR"]["reports"]) {
                AAARMenu_appendGroupWidget(
                    "alfresco/menus/AlfMenuGroup",
                    AAARMenu.config.widgets, 
                    "AAAR_Menu.report.group", 
                    config.scoped["AAAR"]["reports"].getChildren("link")
                );
            }

            if (config.scoped["AAAR"]["free-analysis"]) {
                AAARMenu_appendGroupWidget(
                    "alfresco/menus/AlfMenuGroup",
                    AAARMenu.config.widgets, 
                    "AAAR_Menu.free-analysis.group", 
                    config.scoped["AAAR"]["free-analysis"].getChildren("link")
                );
            }

            if (config.scoped["AAAR"]["visible-credits"]) {
                if (config.scoped["AAAR"]["visible-credits"].getValue() == "true") {
                    if (config.scoped["AAAR"]["credits"]) {
                        AAARMenu_appendGroupWidget(
                            "alfresco/menus/AlfMenuGroup",
                            AAARMenu.config.widgets, 
                            "AAAR_Menu.credits.group", 
                            config.scoped["AAAR"]["credits"].getChildren("link")
                        );
                    }
                    else {
                        AAARMenu.config.widgets.push({
                            name: "alfresco/menus/AlfMenuGroup",
                            config: {
                                label: msg.get("AAAR_Menu.credits.group"),
                                widgets: [{
                                    name: "alfresco/menus/AlfMenuBarItem",
                                    config: {
                                        label: msg.get("AAAR_Menu.credits"),
                                        targetUrl: "http://fcorti.com/alfresco-audit-analysis-reporting/",
                                        targetUrlType: "FULL_PATH",
                                        targetUrlLocation: "NEW"
                                    }
                                }]
                            }
                        });
                    }
                }
            }
            else {
                if (config.scoped["AAAR"]["credits"]) {
                    AAARMenu_appendGroupWidget(
                        "alfresco/menus/AlfMenuGroup",
                        AAARMenu.config.widgets, 
                        "AAAR_Menu.credits.group", 
                        config.scoped["AAAR"]["credits"].getChildren("link")
                    );
                }
                else {
                    AAARMenu.config.widgets.push({
                        name: "alfresco/menus/AlfMenuGroup",
                        config: {
                            label: msg.get("AAAR_Menu.credits.group"),
                            widgets: [{
                                name: "alfresco/menus/AlfMenuBarItem",
                                config: {
                                    label: msg.get("AAAR_Menu.credits"),
                                    targetUrl: "http://fcorti.com/alfresco-audit-analysis-reporting/",
                                    targetUrlType: "FULL_PATH",
                                    targetUrlLocation: "NEW"
                                }
                            }]
                        }
                    });
                }
            }
        }
    }
    else {

        // Share-config-custom is not set.
        AAARMenu = {
            id: "HEADER_AAAR_DROPDOWN",
            name: "alfresco/header/AlfMenuBarPopup",
            config: {
                label: msg.get("AAAR_Menu.desc"),
                widgets: [{
                    name: "alfresco/menus/AlfMenuBarItem",
                    config: {
                        label: msg.get("AAAR_Menu.help"),
                        iconClass: "alf-user-help-icon",
                        targetUrl: "http://fcorti.com/alfresco-audit-analysis-reporting/",
                        targetUrlType: "FULL_PATH",
                        targetUrlLocation: "NEW"
                    }
                },
                {
                    name: "alfresco/menus/AlfMenuGroup",
                    config: {
                        label: msg.get("AAAR_Menu.credits.group"),
                        widgets: [{
                            name: "alfresco/menus/AlfMenuBarItem",
                            config: {
                                label: msg.get("AAAR_Menu.credits"),
                                targetUrl: "http://fcorti.com/alfresco-audit-analysis-reporting/",
                                targetUrlType: "FULL_PATH",
                                targetUrlLocation: "NEW"
                            }
                        }]
                    }
                }]
            }
        }
    }

	// Put the item immediately before the admin console or at the end.
    for (var i = 0; i < headerMenu.config.widgets.length && headerMenu.config.widgets[i].id != 'HEADER_ADMIN_CONSOLE'; ++i) {
    }
    headerMenu.config.widgets.splice(i, 0, AAARMenu);
}

/**
 * Append a group and items to the menu. 
 * @param widgetName
 * @param widgets
 * @param labelId
 * @param links
 */
function AAARMenu_appendGroupWidget(widgetName, widgets, labelId, links) {

    // Adding group item.
    var AAARMenuGroup = {
        name: widgetName,
        config: {
            label: msg.get(labelId),
            widgets: []
        }
    };

    for (var i = 0; i < links.size(); ++i) {

        var link = links.get(i);

        AAARMenuGroup.config.widgets.push({
            name: "alfresco/menus/AlfMenuBarItem",
            config: {
                label: msg.get(link.attributes["label-id"]),
                iconClass: link.attributes["icon-class"],
                targetUrl: link.attributes["target-url"],
                targetUrlType: "FULL_PATH",
                targetUrlLocation: "NEW"
            }
        });
   }

    widgets.push(AAARMenuGroup);
}
