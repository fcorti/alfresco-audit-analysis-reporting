A.A.A.R. - Alfresco share addon
===

This project creates the AMP package to be released in the Alfresco Share for the customizations requested for AAAR.

To make it work, you need a Linux based operating system and can follow the instruction below.

1) Clone the project from GitHub.

2) Make sure you have an Alfresco instance running on port 8080.

3) Open a terminal and access to the project folder. Run the './run.sh' command.

4) Access to 'http://localhost:8081/share'.

ATTENTION: during the very first run you probably have to execute the run.sh script multiple times because the archetype needs to be downloaded and it's a huge work. ;-)

This execution will build an AMP file into the target folder.
To create the AMP file into the target folder, execute 'mvn install'.

For more informations on the solution:
http://fcorti.com/alfresco-audit-analysis-reporting/