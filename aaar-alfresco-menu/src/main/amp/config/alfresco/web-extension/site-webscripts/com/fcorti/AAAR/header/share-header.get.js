
var headerMenu = widgetUtils.findObject(model.jsonModel, "id", "HEADER_APP_MENU_BAR");

if (headerMenu != null && config.scoped["AAAR"]["visible"].getValue() == "true") {

	var AAARMenu = {
        id: "HEADER_AAAR_DROPDOWN",
        name: "alfresco/header/AlfMenuBarPopup",
        config: {
            label: msg.get("AAAR_Menu.desc"),
            widgets: []
        }
    };

	AAARMenu_appendGroupWidget(
        "alfresco/menus/AlfMenuGroup",
        AAARMenu.config.widgets, 
        "AAAR_Menu.dashboard.group", 
        config.scoped["AAAR"]["dashboards"].getChildren("link"));

	AAARMenu_appendGroupWidget(
	        "alfresco/menus/AlfMenuGroup",
	        AAARMenu.config.widgets, 
	        "AAAR_Menu.report.group", 
	        config.scoped["AAAR"]["reports"].getChildren("link"));

	AAARMenu_appendGroupWidget(
	        "alfresco/menus/AlfMenuGroup",
	        AAARMenu.config.widgets, 
	        "AAAR_Menu.free-analysis.group", 
	        config.scoped["AAAR"]["free-analysis"].getChildren("link"));

	if (config.scoped["AAAR"]["visible-credits"].getValue() == "true") {
		AAARMenu_appendGroupWidget(
		        "alfresco/menus/AlfMenuGroup",
		        AAARMenu.config.widgets, 
		        "AAAR_Menu.credits.group", 
		        config.scoped["AAAR"]["credits"].getChildren("link"));
	}

	// Put the item immediately before the admin console or at the end.
	for (var i = 0; i < headerMenu.config.widgets.length && headerMenu.config.widgets[i].id != 'HEADER_ADMIN_CONSOLE'; ++i) {
	}
	headerMenu.config.widgets.splice(i, 0, AAARMenu);

}

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

    	// Adding item.
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
