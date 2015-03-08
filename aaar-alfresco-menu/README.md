Alfresco Audit Analysis and Reporting - Alfresco menu
===

This project develop the AMP package to be released in Alfresco for the Alfresco menu to AAAR.

To make it work, you need a Linux based operating system and can follow the instruction below.
1) Clone the code from GitHub.
2) Make sure you have an Alfresco instance running on port 8080.
3) Open a terminal and enter into the project folder. Run the './run.sh' command.
4) Access to 'http://localhost:8081/share'.

ATTENTION: during the very first run you probably have to execute the run.sh script multiple times because the archetype needs to be downloaded and it's a huge work. ;-)

This execution will build an AMP file too into the target folder.

Many thanks to Ole Hejlskov (https://github.com/ohej) for his great work on the tutorial about Aikau framework. The tutorial is mainly the major reference for this solution.
Please read here for further informations: http://ohej.github.io/alfresco-tutorials/tutorial/aikau/tutorial.html

For more informations:
http://fcorti.com/alfresco-audit-analysis-reporting/