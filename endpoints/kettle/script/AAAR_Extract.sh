#!/bin/bash

# Settings
VERSION='2.4.1'
CURRENT_PATH="$PWD"
ENDPOINTS_PATH="$PWD/.."
LOGS_PATH="$ENDPOINTS_PATH/logs"
LOG_PATH="$LOGS_PATH/AAAR.log"

# Set by writeConfiguration.kjb.
JOB_NAME="Get all" 
GET_PARENTS="false"
KETTLE_PATH="/opt/data-integration"

if [ "$1" != "silent" ]; then
    clear

    echo
    echo A.A.A.R. - Alfresco Audit Analysis and Reporting
    echo Import procedure version $VERSION.
    echo "Author: Francesco Corti (all rights reserved)"
    echo "Date: 01 December, 2014"
    echo
    echo "Disclaimer:"
    echo "We can't be responsible for any damage done to your system,"
    echo "which hopefully will not happen."
    echo
    echo "Tip:"
    echo "Want to reduce the time of execution?"
    echo "Edit this script and change 'JOB_NAME' and 'GET_PARENTS' variables."
    echo "If you don't know how, look at the FAQ at http://fcorti.com."
fi

# JOB_NAME
while [ "$JOB_NAME" != "Get audit" -a "$JOB_NAME" != "Get nodes" -a "$JOB_NAME" != "Get all" ]; do
    echo 
    read -e -p "Do you want to import audit trail, repository data or both? (audit/repository/both): " -i "both" EXTRACTION_TYPE
    if [ "$EXTRACTION_TYPE" = "audit" ]; then
        JOB_NAME="Get audit"
    fi
    if [ "$EXTRACTION_TYPE" = "repository" ]; then
        JOB_NAME="Get nodes"
        ASK_GET_PARENTS="true"
    fi
    if [ "$EXTRACTION_TYPE" = "both" ]; then
        JOB_NAME="Get all"
        ASK_GET_PARENTS="true"
    fi
done

# GET_PARENTS
if [ "$JOB_NAME" != "Get audit" ]; then
    while [ "$GET_PARENTS" != "true" -a "$GET_PARENTS" != "false" ]; do
        read -e -p "Do you want to import repository structure? (y/n): " -i "n" GET_PARENTS
        if [ "$GET_PARENTS" = "y" ]; then
           GET_PARENTS="true";
        fi
        if [ "$GET_PARENTS" = "n" ]; then
           GET_PARENTS="false";
        fi
    done
fi

# KETTLE_PATH
while [ ! -d "$KETTLE_PATH" ]; do
    echo
    read -e -p "Please, enter the <data-integration> path (es.:/opt/data-integration): " KETTLE_PATH
done

if [ "$1" != "silent" ]; then
    echo
    echo "You are going to execute this command:"
    echo './kitchen.sh /rep:"AAAR_Kettle" /job:"'$JOB_NAME'" /dir:/Alfresco /user:admin /pass:admin /param:get_parents='$GET_PARENTS' /log="'$LOG_PATH'" /level:Basic'
    echo
    read -e -p "Press <enter> to start import."
    echo
fi

cd $KETTLE_PATH

./kitchen.sh /rep:"AAAR_Kettle" /job:"$JOB_NAME" /dir:/Alfresco /user:admin /pass:admin /param:get_parents=$GET_PARENTS /log="$LOG_PATH" /level:Basic

if [ "$1" != "silent" ]; then
    echo
    echo "Extraction complete!"
    echo
    echo "Log file has been generated in the file below:"
    echo $LOG_PATH
    echo
    echo "Check for ERRORS in the log."
    echo "If you can't find them, everything has gone alright."
    echo "Please, remember to schedule the command periodically or to execute it manually."
    echo
    echo "Tip:"
    echo "You can schedule this command using the silent execution with the command below:"
    echo $CURRENT_PATH/$0" silent"
    echo
    echo "Want to save the reports in pdf format directly in Alfresco?"
    echo "It's time to execute the 'AAAR_Publish' script."
    echo
    echo "Enjoy A.A.A.R.!"
    echo
fi
