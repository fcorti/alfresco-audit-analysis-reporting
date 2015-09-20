// Checks.
if (args.protocol == undefined || args.protocol.length == 0) {
   status.code = 400;
   status.message = "Parameter 'protocol' has not been provided.";
   status.redirect = true;
}
else if (args.host == undefined || args.host.length == 0) {
   status.code = 400;
   status.message = "Parameter 'host' has not been provided.";
   status.redirect = true;
}
else if (args.port == undefined || args.port.length == 0) {
   status.code = 400;
   status.message = "Parameter 'port' has not been provided.";
   status.redirect = true;
}
else if (args.app == undefined || args.app.length == 0) {
   status.code = 400;
   status.message = "Parameter 'app' has not been provided.";
   status.redirect = true;
}
else {

   // Configuration of the dashlet.
   var config = new XML(config.script);

   // Definition of the pentaho url.
   var pentahoUrl = args.protocol + "://" + args.host + ":" + args.port + config.pentaho.service;
   pentahoUrl += "?" + config.pentaho.parameters.action.@name + "=" + config.pentaho.parameters.action;
   pentahoUrl += "&" + config.pentaho.parameters.application + "=" + args.app;
   pentahoUrl += "&" + config.pentaho.parameters.user + "=" + user.name;

   try {

      // Get Pentaho ticket in JSON structure.
      var connector = remote.connect(args.protocol);
      var JSONString = connector.get(pentahoUrl);

      // Create json object from data.
      var pentahoJSON = eval('(' + JSONString + ')');
      model.pentahoTicket = pentahoJSON[config.pentaho.field];

   }
   catch (e) {
      model.pentahoTicket = "";
   }
}
