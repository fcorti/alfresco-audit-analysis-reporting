#!/bin/bash

# Settings.
VERSION='2.2'
CURRENT_PATH="$PWD"
ENDPOINTS_PATH="$PWD/.."
LOGS_PATH="$ENDPOINTS_PATH/logs"
LOG_PATH="$LOGS_PATH/AAAR.log"

# Set by writeConfiguration.kjb.
KETTLE_PATH="/opt/data-integration"

if [ "$1" != "silent" ]; then
    clear

    echo
    echo A.A.A.R. - Alfresco Audit Analysis and Reporting
    echo Export procedure version $VERSION.
    echo "Author: Francesco Corti (all rights reserved)"
    echo "Date: 01 December, 2014"
    echo
    echo "Disclaimer:"
    echo "We can't be responsible for any damage done to your system,"
    echo "which hopefully will not happen."
fi

# KETTLE_PATH
while [ ! -d "$KETTLE_PATH" ]; do
    echo
    read -e -p "Please, enter the <data-integration> path (es.:/opt/data-integration): " KETTLE_PATH
done

if [ "$1" != "silent" ]; then
    echo
    echo "You are going to execute this command:"
    echo './kitchen.sh /rep:"AAAR_Kettle" /job:"Report all" /dir:/Alfresco /user:admin /pass:admin /log="'$LOG_PATH'" /level:Basic'
    echo
    read -e -p "Press <enter> to start import."
    echo
fi

cd $KETTLE_PATH

./kitchen.sh /rep:"AAAR_Kettle" /job:"Report all" /dir:/Alfresco /user:admin /pass:admin /log="$LOG_PATH" /level:Basic

if [ "$1" != "silent" ]; then
    echo
    echo "Publication complete!"
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
    echo "Enjoy A.A.A.R.!"
    echo
fi
