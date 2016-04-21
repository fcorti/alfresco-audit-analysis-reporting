A.A.A.R. - Pentaho v6.0, v6.1 App builder Application
===

This project develops a Pentaho sparkl application to be released into an installation of the Pentaho BA Server.
To make it work, a Linux based operating system is required, with some customizations detailed in the tutorial about [Pentaho v6 for A.A.A.R.](../Pentaho v6.0 development environment setup.md)
After the development environment has been prepared, please follow the instructions below.

Open a terminal and execute the commands detailed below.

    cd ~
    git clone https://github.com/fcorti/alfresco-audit-analysis-reporting.git
    cd alfresco-audit-analysis-reporting/Pentaho/AAAR-Pentaho-CE-v6-App-builder
    mkdir <bi-server>/pentaho-solutions/system/AAAR
    cp -R * <bi-server>/pentaho-solutions/system/AAAR
    rm -rf <bi-server>/pentaho-solutions/system/AAAR/build
    cd <bi-server>
    start-pentaho.sh

Follow the instruction described [here](http://fcorti.com/alfresco-audit-analysis-reporting/aaar-how-to-install/aaar-install/) to install A.A.A.R. and use it.

For more informations:
http://fcorti.com/alfresco-audit-analysis-reporting/
