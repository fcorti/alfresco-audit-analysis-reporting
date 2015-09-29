#!/bin/bash

# Settings
VERSION='4.0'
CURRENT_PATH="$PWD"
ENDPOINTS_PATH="$PWD/.."
LOGS_PATH="$ENDPOINTS_PATH/logs"
LOG_PATH="$LOGS_PATH/AAAR.log"

# Set by writeConfiguration.kjb.
GET_AUDIT="true"
GET_REPOSITORY="true"
GET_PARENTS="true"
GET_WORKFLOWS="true"
KETTLE_PATH="/opt/data-integration"

if [ "$1" != "silent" ]; then
    clear

    echo
    echo A.A.A.R. - Alfresco Audit Analysis and Reporting
    echo Import procedure version $VERSION.
    echo "Author: Francesco Corti (all rights reserved)"
    echo "Date: 07 November 2015"
    echo "Documentation and tips: http://fcorti.com."
    echo
    echo "Disclaimer:"
    echo "We can't be responsible for any damage done to your system,"
    echo "which hopefully will not happen."
fi

if [ "$1" != "silent" ]; then
    echo
    echo "You are going to execute this command:"
    echo './kitchen.sh /rep:"AAAR_Kettle" /job:"'Get all'" /dir:/Alfresco /user:admin /pass:admin /param:get_audit='$GET_AUDIT' /param:get_nodes='$GET_REPOSITORY' /param:get_parents='$GET_PARENTS' /param:get_workflows='$GET_WORKFLOWS' /log="'$LOG_PATH'" /level:Basic'
    echo
    read -e -p "Press <enter> to start import."
    echo
fi

cd $KETTLE_PATH

./kitchen.sh /rep:"AAAR_Kettle" /job:"Get all" /dir:/Alfresco /user:admin /pass:admin /param:get_audit=$GET_AUDIT /param:get_nodes=$GET_REPOSITORY /param:get_parents=$GET_PARENTS /param:get_workflows=$GET_WORKFLOWS /log="$LOG_PATH" /level:Basic

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
