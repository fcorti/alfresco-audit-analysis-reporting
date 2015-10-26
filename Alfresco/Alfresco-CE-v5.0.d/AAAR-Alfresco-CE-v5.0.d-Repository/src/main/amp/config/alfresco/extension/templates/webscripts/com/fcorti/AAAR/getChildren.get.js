
// Check that noderef has been provided.
if (args.nodeRef == undefined || args.nodeRef.length == 0) {
   status.code = 400;
   status.message = "'nodeRef' parameter has not been provided.";
   status.redirect = true;
}
else {

   var node = search.findNode(args.nodeRef);

   var nodeChildren = [];
   if (node != undefined) {
      nodeChildren = node.children;
   }

   model.nodeRef = args.nodeRef;
   model.children = nodeChildren;
}
