#!/bin/bash

#
# Script to export the Alflytics repository in the 'Alflytics.zip' file in the current directory.
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

echo "cp \""$REPOSITORY_PATH"\" \""$REPOSITORY_PATH".old\""
echo ""

cp $REPOSITORY_PATH $REPOSITORY_PATH.old

echo "./import-export.sh --export --url=http://localhost:8080/pentaho --username=\""$PENTAHO_USER"\" --password=\""$PENTAHO_PASSWORD"\" --charset=UTF-8 --path=\"/public/Alflytics\" --file-path=\""$REPOSITORY_PATH"\""
echo ""

./import-export.sh --export --url=http://localhost:8080/pentaho --username=$PENTAHO_USER --password=$PENTAHO_PASSWORD --charset=UTF-8 --path="/public/Alflytics" --file-path="$REPOSITORY_PATH"

echo ""
echo "ATTENTION: Remember to modify the 'Alflytics.zip' file as described below:"
echo " 1. Add a folder called 'public' and move the 'Alflytics' folder into it."
echo " 2. Edit the 'exportManifest.xml' file."
echo "    2.1 Change the 'rootFolder' attibute to '/' instead of '/public/'."
echo "    2.2 Replace all the 'path=\"Alflytics' strings with 'path=\"public/Alflytics'."
echo " 3. In 'Alflytics.zip.old' you can find the previous version of the 'Alflytics.zip' file."
echo ""

