#!/bin/bash

#
# Script to import the Alflytics repository from a zip file.
#

# Settings
CURRENT_PATH="$PWD"
REPOSITORY_PATH="$CURRENT_PATH/Alflytics.zip"
PENTAHO_SERVER_PATH="$CURRENT_PATH/../../../../../../../.."
PENTAHO_USER="admin"
PENTAHO_PASSWORD="password"

clear;

echo ""
echo "cd \""$PENTAHO_SERVER_PATH"\""
echo ""

cd $PENTAHO_SERVER_PATH

echo "./import-export.sh --import --url=http://localhost:8080/pentaho --username=\""$PENTAHO_USER"\" --password=\""$PENTAHO_PASSWORD"\" --charset=UTF-8 --path=\"/\" --overwrite=true --permission=true --retainOwnership=true --file-path=\""$REPOSITORY_PATH"\""
echo ""

./import-export.sh --import --url=http://localhost:8080/pentaho --username=$PENTAHO_USER --password=$PENTAHO_PASSWORD --charset=UTF-8 --path="/" --overwrite=true --permission=true --retainOwnership=true --file-path="$REPOSITORY_PATH"

echo ""

