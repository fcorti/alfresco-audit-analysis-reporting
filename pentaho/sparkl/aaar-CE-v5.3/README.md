A.A.A.R. - Pentaho sparkl application
===

This project develops a Pentaho sparkl application to be released into an installation of the Pentaho BA Server.
To make it work, a Linux based operating system is required, with some customizations detailed in the tutorial about [Pentaho v5.3+ for A.A.A.R.](../../Pentaho v5.3 development environment setup.md).
After the development environment has been prepared, please follow the instructions below.

1) Clone the project from GitHub, as described [here](../../Pentaho v5.3 development environment setup.md).

2) Access to the project folder, executing `cd alfresco-audit-analysis-reporting/pentaho/sparkl/aaar-vX.X`.

3) Copy the `aaar-vX.X` folder into the `<bi-server>/pentaho-solutions/system` and rename it as `AAAR`.

4) Start the Pentaho BA Server using the `start-pentaho` script (you can find them in the `biserver-ce` folder).

5) Follow the instruction described [here](http://fcorti.com/alfresco-audit-analysis-reporting/aaar-how-to-install/aaar-install/) to install AAAR and use it.

For more informations:
http://fcorti.com/alfresco-audit-analysis-reporting/
