A.A.A.R. - Pentaho sparkl application
===

This project develop the Pentaho sparkl application to be released in Pentaho BA Server.

To make it work, you need a Linux based operating system and can follow the instruction below.

1) Clone the code from GitHub.

2) Make sure you have a Pentaho BA Server on port 8181 and Pentaho Data Integration correctly installed.

3) Create a AAAR folder into the '<bi-server>/pentaho-solutions/system' path and put the whole files inside.

4) Edit 'importExport.xml' and 'ImportHandlerMimeTypeDefinitions.xml' as described here (http://fcorti.com/alfresco-audit-analysis-reporting/aaar-how-to-install/aaar-get/).

5) Start the Pentaho BIServer using the ‘start-pentaho’ script (you can find them in the ‘biserver-ce’ folder). The suggestion is to install Pentaho into a different port from 8080 or 8081 used from Alfresco.

6) Please read here (http://fcorti.com/alfresco-audit-analysis-reporting/aaar-how-to-install/aaar-install/) to understand how to install and use it.

For more informations:
http://fcorti.com/alfresco-audit-analysis-reporting/
