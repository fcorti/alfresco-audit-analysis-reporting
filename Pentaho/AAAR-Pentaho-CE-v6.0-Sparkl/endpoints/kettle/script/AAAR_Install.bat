@echo off

REM Settings
set VERSION='4.3'
set CURRENT_PATH=%cd%
set ENDPOINTS_PATH=%CURRENT_PATH%\..
set LOGS_PATH=%ENDPOINTS_PATH%\logs
set CONFIGURATIONS_PATH=%ENDPOINTS_PATH%\conf
set LOG_PATH=%LOGS_PATH%\AAAR.log
set CONFIGURATION_FILE=%1
if "%1"=="" set CONFIGURATION_FILE=AAARConfiguration.xml
set CONFIGURATION_PATH=%CONFIGURATIONS_PATH%\%CONFIGURATION_FILE%

REM Set by writeConfiguration.kjb.
set KETTLE_PATH=/home/aaar/Desktop/data-integration

cls

echo.
echo A.A.A.R. - Alfresco Audit Analysis and Reporting
echo Installation procedure version %VERSION%.
echo Author: Francesco Corti (all rights reserved)
echo Date: 01 May 2016
echo.
echo Disclaimer:
echo We can't be responsible for any damage done to your system,
echo which hopefully will not happen.
echo.
echo Instructions:
echo The installation script is going to use the configuration file below:
echo %CONFIGURATION_PATH%
echo.
echo If you want to use another, press CTRL+C and execute:
echo AAAR_Install.bat [configurationFileName]

REM PENTAHO_URL
set PENTAHO_URL=
:WHILE_PENTAHO_URL
echo.
set /p PENTAHO_URL="Please, enter the complete Pentaho BI-Server url (es.:http://localhost:8080/pentaho): "
if "%PENTAHO_URL%"=="" GOTO WHILE_PENTAHO_URL

REM PENTAHO_LOGIN
set PENTAHO_LOGIN=
:WHILE_PENTAHO_LOGIN
echo.
set /p PENTAHO_LOGIN="Please, enter the Pentaho BI-Server login (es.:admin): "
if "%PENTAHO_LOGIN%"=="" GOTO WHILE_PENTAHO_LOGIN

REM PENTAHO_PASSWORD
set PENTAHO_PASSWORD=
:WHILE_PENTAHO_PASSWORD
echo.
set /p PENTAHO_PASSWORD="Please, enter the Pentaho BI-Server password (es.:password): "
if "%PENTAHO_PASSWORD%"=="" GOTO WHILE_PENTAHO_PASSWORD

REM KETTLE_PATH
if EXIST "%KETTLE_PATH%" GOTO END_WHILE_KETTLE_PATH
set KETTLE_PATH=
:WHILE_KETTLE_PATH
echo.
set /p KETTLE_PATH="Please, enter the <data-integration> path (es.:C:\data-integration): "
if "%KETTLE_PATH%"=="" GOTO WHILE_KETTLE_PATH
:END_WHILE_KETTLE_PATH

echo.
pause
echo.

cd "%KETTLE_PATH%"

Kitchen.bat /file="%ENDPOINTS_PATH%/installFromConfiguration.kjb" /param:configurationFile="%CONFIGURATION_FILE%" /param:pentahoUrl="%PENTAHO_URL%" /param:pentahoLogin="%PENTAHO_LOGIN%" /param:pentahoPassword="%PENTAHO_PASSWORD%" /log="%LOG_PATH%" /level=Basic

cd "%CURRENT_PATH%"

echo.
echo Installation complete!
echo.
echo Log file has been generated in the file below:
echo %LOG_PATH%
echo.
echo Check for ERRORS but exclude the ones with description '...Folder/File [...] exists, failing.' because they are not real errors.
echo If you can't find them, everything has gone alright.
echo.
echo Unfortuantely Pentaho does not permit to define a custom data source using PDI.
echo Please, remember to create them manually as described below:
echo AAAR_AuditTrail is a Analysis data source on AAAR_AuditTrail.xml mondrian schema and AAAR_DataMart JDBC data source.
echo AAAR_Repository is a Analysis data source on AAAR_Repository.xml mondrian schema and AAAR_DataMart JDBC data source.
echo.
echo To import your data in the Database you can now execute the 'AAAR_Export' script.
echo And remember to execute it periodically. ;-)
echo.
