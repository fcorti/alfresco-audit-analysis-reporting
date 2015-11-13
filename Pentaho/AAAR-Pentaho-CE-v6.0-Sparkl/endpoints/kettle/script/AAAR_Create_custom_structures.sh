#!/bin/bash

# Settings
VERSION='4.1'
CURRENT_PATH="$PWD"
ENDPOINTS_PATH="$PWD/.."
LOGS_PATH="$ENDPOINTS_PATH/logs"
LOG_PATH="$LOGS_PATH/AAAR.log"

# Set by writeConfiguration.kjb.
JOB_NAME="Create structures" 
FORCE_CREATION="false"
KETTLE_PATH="/opt/data-integration"

clear

echo
echo A.A.A.R. - Alfresco Audit Analysis and Reporting
echo Creation procedure version $VERSION.
echo "Author: Francesco Corti (all rights reserved)"
echo "Date: 21 November 2015"
echo
echo "Disclaimer:"
echo "We can't be responsible for any damage done to your system,"
echo "which hopefully will not happen."

# FORCE_CREATION
while [ "$FORCE_CREATION" != "true" -a "$FORCE_CREATION" != "false" ]; do
    echo 
    read -e -p "Do you want to force the creation of existing custom data structures? (yes/no): " -i "yes" FORCE_CREATION_ANSWER
    if [ "$FORCE_CREATION_ANSWER" = "yes" ]; then
        FORCE_CREATION="true"
    fi
    if [ "$FORCE_CREATION_ANSWER" = "no" ]; then
        FORCE_CREATION="false"
    fi
done

# KETTLE_PATH
while [ ! -d "$KETTLE_PATH" ]; do
    echo
    read -e -p "Please, enter the <data-integration> path (es.:/opt/data-integration): " KETTLE_PATH
done

echo
echo "You are going to execute this command:"
echo './kitchen.sh /rep:"AAAR_Kettle" /job:"'$JOB_NAME'" /dir:"/Alfresco/Utility/Custom metadata" /user:admin /pass:admin /param:alfresco_id=1 /param:force_creation='$FORCE_CREATION' /log="'$LOG_PATH'" /level:Basic'
echo
read -e -p "Press <enter> to start import."
echo

cd $KETTLE_PATH

./kitchen.sh /rep:"AAAR_Kettle" /job:"$JOB_NAME" /dir:"/Alfresco/Utility/Custom metadata" /user:admin /pass:admin /param:alfresco_id=1 /param:force_creation=$FORCE_CREATION /log="$LOG_PATH" /level:Basic

echo
echo "Creation complete!"
echo
echo "Log file has been generated in the file below:"
echo $LOG_PATH
echo
echo "Check for ERRORS in the log."
echo "If you can't find them, everything has gone alright."
echo
echo "To import your data in the Database you can now execute the 'AAAR_Export' script."
echo "And remember to execute it periodically. ;-)"
echo
echo "Enjoy A.A.A.R.!"
echo
