#!/bin/bash

# Settings.
VERSION='2.4.1'
CURRENT_PATH="$PWD"
ENDPOINTS_PATH="$PWD/.."
LOGS_PATH="$ENDPOINTS_PATH/logs"
CONFIGURATIONS_PATH="$ENDPOINTS_PATH/conf"
LOG_PATH="$LOGS_PATH/AAAR.log"
CONFIGURATION_FILE="$1"
if [ -z "$1" ]; then
    CONFIGURATION_FILE="AAARConfiguration.xml"
fi
CONFIGURATION_PATH="$CONFIGURATIONS_PATH/$CONFIGURATION_FILE"

# Set by writeConfiguration.kjb.
KETTLE_PATH="/home/aaar/Desktop/data-integration" 

clear

echo
echo A.A.A.R. - Alfresco Audit Analysis and Reporting
echo Installation procedure version $VERSION.
echo "Author: Francesco Corti (all rights reserved)"
echo "Date: 13 February 2015"
echo
echo "Disclaimer:"
echo "We can't be responsible for any damage done to your system,"
echo "which hopefully will not happen."
echo
echo "Instructions:"
echo "The installation script is going to use the configuration file below:"
echo $CONFIGURATION_PATH
echo
echo "If you want to use another, press <CTRL>+C and execute:"
echo "./AAAR_Install.sh <configurationFileName>"

while [ -z "$PENTAHO_URL" ]; do
    echo
    read -e -p "Please, enter the complete Pentaho BI-Server url (es.:http://localhost:8080/pentaho): " PENTAHO_URL
done

while [ -z "$PENTAHO_LOGIN" ]; do
    echo
    read -e -p "Please, enter the Pentaho BI-Server login (es.:admin): " PENTAHO_LOGIN
done

while [ -z "$PENTAHO_PASSWORD" ]; do
    echo
    read -e -p "Please, enter the Pentaho BI-Server login (es.:password): " PENTAHO_PASSWORD
done

while [ ! -d "$KETTLE_PATH" ]; do
    echo
    read -e -p "Please, enter the <data-integration> path (es.:/opt/data-integration): " KETTLE_PATH
done

echo
read -e -p "Press <enter> to install A.A.A.R."
echo

cd $KETTLE_PATH

./kitchen.sh /file="$ENDPOINTS_PATH/installFromConfiguration.kjb" /param:configurationFile="$CONFIGURATION_FILE" /param:pentahoUrl="$PENTAHO_URL" /param:pentahoLogin="$PENTAHO_LOGIN" /param:pentahoPassword="$PENTAHO_PASSWORD" /log="$LOG_PATH" /level=Basic

echo
echo "Installation complete!"
echo
echo "Log file has been generated in the file below:"
echo $LOG_PATH
echo
echo "Check for ERRORS but exclude the ones with description '...Folder/File [...] exists, failing.' because they are not real errors."
echo "If you can't find them, everything has gone alright."
echo
echo "Unfortuantely Pentaho does not permit to define a custom data source using PDI."
echo "Please, remember to create them manually as described below:"
echo "AAAR_AuditTrail is a Analysis data source on AAAR_AuditTrail.xml mondrian schema and AAAR_DataMart JDBC data source."
echo "AAAR_Repository is a Analysis data source on AAAR_Repository.xml mondrian schema and AAAR_DataMart JDBC data source."
echo
echo "To import your data in the Database you can now execute the 'AAAR_Export' script."
echo "And remember to execute it periodically. ;-)"
echo
