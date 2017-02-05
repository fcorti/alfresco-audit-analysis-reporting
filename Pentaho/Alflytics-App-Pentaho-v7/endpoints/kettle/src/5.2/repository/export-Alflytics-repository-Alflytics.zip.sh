#!/bin/bash

#
# Script to export the Alflytics repository into a zip file in the current directory.
#

# Settings
CURRENT_PATH="$PWD"
REPOSITORY_NAME="Alflytics.$(date +\%Y-%m-%d.%H:%M)"
REPOSITORY_PATH="$CURRENT_PATH/$REPOSITORY_NAME.zip"
PENTAHO_SERVER_PATH="$CURRENT_PATH/../../../../../../../.."
PENTAHO_USER="admin"
PENTAHO_PASSWORD="password"

echo ""
echo "Exporting the Alflytics repository into '$REPOSITORY_NAME.zip'..."
echo ""

cd "$PENTAHO_SERVER_PATH"

./import-export.sh --export --url=http://localhost:8080/pentaho --username=$PENTAHO_USER --password=$PENTAHO_PASSWORD --charset=UTF-8 --path="/public/Alflytics" --file-path="$REPOSITORY_PATH"

cd "$CURRENT_PATH"

echo ""
echo "Changing '$REPOSITORY_NAME' to properly update the content..."

mkdir "$REPOSITORY_NAME"
unzip -qq "$REPOSITORY_PATH" -d "$REPOSITORY_NAME"
cd "$REPOSITORY_NAME"
mkdir "public"
mv "Alflytics" "public"
sed 's/rootFolder="\/public\/"/rootFolder="\/"/g' "exportManifest.xml" > "exportManifest.new.1.xml"
sed 's/path="Alflytics/path=\"public\/Alflytics/g' "exportManifest.new.1.xml" > "exportManifest.new.2.xml"
rm "exportManifest.new.1.xml"
rm "exportManifest.xml"
mv "exportManifest.new.2.xml" "exportManifest.xml"
zip -rq "$REPOSITORY_NAME.zip" "public" "exportManifest.xml"

echo "done!"
echo ""
echo "Updating the '$REPOSITORY_NAME.zip'..."

rm "../$REPOSITORY_NAME.zip"
mv "$REPOSITORY_NAME.zip" "../$REPOSITORY_NAME.zip"

cd ".."
rm -rf "$REPOSITORY_NAME"

echo "done!"
echo ""

