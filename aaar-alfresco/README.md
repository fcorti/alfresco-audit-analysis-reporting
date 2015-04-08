A.A.A.R. - Alfresco
===

This project develop the AMP package to be released in Alfresco Repository for the webscript and customizations for AAAR.

To make it work, you need a Linux based operating system and can follow the instruction below.

1) Clone the code from GitHub.

2) Open a terminal and enter into the project folder. Run the './run.sh' command.

4) Access to 'http://localhost:8080/alfresco' (no Share client is available).

ATTENTION: during the very first run you probably have to execute the run.sh script multiple times because the archetype needs to be downloaded and it's a huge work. ;-)

This execution will build an AMP file too into the target folder.

Many thanks to Ole Hejlskov (https://github.com/ohej) for his great work on the tutorial about Aikau framework. The tutorial is mainly the major reference for this solution.
Please read here for further informations: http://ohej.github.io/alfresco-tutorials/tutorial/aikau/tutorial.html

Another thank to Gabriele Columbro (http://mindthegab.com/) for his work on the Alfresco SDK and, of course, for sharing documentation about it.
https://artifacts.alfresco.com/nexus/content/repositories/alfresco-docs/alfresco-sdk-aggregator/latest/index.html

For more informations on the solution:
http://fcorti.com/alfresco-audit-analysis-reporting/
