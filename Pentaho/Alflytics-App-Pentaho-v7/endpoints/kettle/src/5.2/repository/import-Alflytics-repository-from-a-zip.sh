#!/bin/bash

#
# Script to import the Alflytics repository from a zip file in the current directory.
#

# Settings
CURRENT_PATH="$PWD"
REPOSITORY_NAME="Alflytics"
REPOSITORY_PATH="$CURRENT_PATH/$REPOSITORY_NAME.zip"
PENTAHO_SERVER_PATH="$CURRENT_PATH/../../../../../../../.."
PENTAHO_USER="admin"
PENTAHO_PASSWORD="password"

echo ""
echo "Importing the Alflytics repository from '$REPOSITORY_NAME.zip'..."
echo ""

cd $PENTAHO_SERVER_PATH

./import-export.sh --import --url=http://localhost:8080/pentaho --username=$PENTAHO_USER --password=$PENTAHO_PASSWORD --charset=UTF-8 --path="/" --overwrite=true --permission=true --retainOwnership=true --file-path="$REPOSITORY_PATH"

echo ""

