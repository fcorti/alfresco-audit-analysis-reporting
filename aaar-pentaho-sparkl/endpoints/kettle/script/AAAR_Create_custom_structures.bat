@echo off

REM Settings
set VERSION='3.0'
set CURRENT_PATH=%cd%
set ENDPOINTS_PATH=%CURRENT_PATH%\..
set LOGS_PATH=%ENDPOINTS_PATH%\logs
set LOG_PATH=%LOGS_PATH%\AAAR.log

REM Set by writeConfiguration.kjb.
set JOB_NAME=Create structures
set FORCE_CREATION=false
set KETTLE_PATH=/opt/data-integration

cls
echo.
echo A.A.A.R. - Alfresco Audit Analysis and Reporting
echo Creation procedure version %VERSION%
echo Author: Francesco Corti (all rights reserved)
echo Date: 15 March 2015
echo.
echo Disclaimer:
echo We can't be responsible for any damage done to your system,
echo which hopefully will not happen.

REM FORCE_CREATION
:WHILE_FORCE_CREATION
if "%FORCE_CREATION%"=="true" GOTO END_WHILE_FORCE_CREATION
if "%FORCE_CREATION%"=="false" GOTO END_WHILE_FORCE_CREATION
set FORCE_CREATION=
echo.
set /p FORCE_CREATION_ANSWER="Do you want to force the creation of existing custom data structures (yes/no): "
if /i "%FORCE_CREATION_ANSWER%"=="yes" set FORCE_CREATION=true
if /i "%FORCE_CREATION_ANSWER%"=="no" set FORCE_CREATION=false
GOTO WHILE_FORCE_CREATION
:END_WHILE_FORCE_CREATION

REM KETTLE_PATH
if EXIST "%KETTLE_PATH%" GOTO END_WHILE_KETTLE_PATH
set KETTLE_PATH=
:WHILE_KETTLE_PATH
echo.
set /p KETTLE_PATH="Please, enter the <data-integration> path (es.:C:\data-integration): "
if "%KETTLE_PATH%"=="" GOTO WHILE_KETTLE_PATH
:END_WHILE_KETTLE_PATH

echo.
echo You are going to execute this command:
echo Kitchen.bat /rep:"AAAR_Kettle" /job:"%JOB_NAME%" /dir:"/Alfresco/Utility/Custom metadata" /user:admin /pass:admin /param:alfresco_id=1 /param:force_creation="%FORCE_CREATION%" /log="%LOG_PATH%" /level:Basic
echo.
pause
echo.

cd "%KETTLE_PATH%"

Kitchen.bat /rep:"AAAR_Kettle" /job:"%JOB_NAME%" /dir:"/Alfresco/Utility/Custom metadata" /user:admin /pass:admin /param:alfresco_id=1 /param:force_creation="%FORCE_CREATION%" /log="%LOG_PATH%" /level:Basic

cd "%CURRENT_PATH%"

echo.
echo Creation complete!
echo.
echo Log file has been generated in the file below:
echo %LOG_PATH%
echo.
echo Check for ERRORS in the log.
echo If you can't find them, everything has gone alright.
echo Please, remember to schedule the command periodically or to execute it manually.
echo.
echo To import your data in the Database you can now execute the 'AAAR_Export' script.
echo And remember to execute it periodically. ;-)
echo.
echo Enjoy A.A.A.R.!
echo.
