A.A.A.R. - Alfresco repository addon
===

This project creates the AMP package to be released in the Alfresco Repository for the customizations requested for A.A.A.R.
To make it work, a Linux based operating system is required, with some customizations detailed in the tutorial about [Alfresco SDK 1.x for A.A.A.R.](../../Alfresco SDK 1.x development environment setup.md).
After the development environment has been prepared, please follow the instructions below.

1) Clone the project from GitHub, as described [here](../../Alfresco SDK 1.x development environment setup.md).

2) Access to the project folder, executing `cd alfresco-audit-analysis-reporting/<name of the current project>`. 

3) Run the command `mvn integration-test -Pamp-to-war` to build the package and start the Tomcat instance.

4) Access to 'http://localhost:8080/alfresco' (no Alfresco Share client is available).

This execution will build also the AMP file into the target folder.
To create the AMP file into the target folder with any other task, in the step 3 execute `mvn install`.

For more informations on the solution:
http://fcorti.com/alfresco-audit-analysis-reporting/
