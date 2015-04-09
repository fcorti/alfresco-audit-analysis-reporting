
var packageNodeRef = "workspace://SpacesStore/f588b504-fb26-462a-bee2-dde2586be72d";

model.packageNodeRef = packageNodeRef;

var packageNode = search.findNode(packageNodeRef);

model.items = packageNode.children;
