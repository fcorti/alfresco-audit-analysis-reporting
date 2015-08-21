A.A.A.R. - Alfresco repository addon
===

This project creates the AMP package to be released in the Alfresco Repository for the customizations requested for AAAR.

To make it work, you need a Linux based operating system and can follow the instructions below.

1) Clone the project from GitHub.

2) Open a terminal and access to the project folder. Run the 'mvn integration-test -Pamp-to-war' command.

4) Access to 'http://localhost:8080/alfresco' (no Alfresco Share client is available).

ATTENTION: during the very first run you probably have to execute the run.sh script multiple times because the archetype needs to be downloaded and it's a huge work. ;-)

This execution will build an AMP file into the target folder.
To create the AMP file into the target folder, execute 'mvn install'.

For more informations on the solution:
http://fcorti.com/alfresco-audit-analysis-reporting/
