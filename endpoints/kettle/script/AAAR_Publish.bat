@echo off

REM Settings
set VERSION='2.2'
set CURRENT_PATH=%cd%
set ENDPOINTS_PATH=%CURRENT_PATH%\..
set LOGS_PATH=%ENDPOINTS_PATH%\logs
set LOG_PATH=%LOGS_PATH%\AAAR.log

REM Set by writeConfiguration.kjb.
set KETTLE_PATH=/opt/data-integration

if "%1"=="silent" GOTO SILENT_1
    cls
    echo.
    echo A.A.A.R. - Alfresco Audit Analysis and Reporting
    echo Import procedure version %VERSION%
    echo Author: Francesco Corti (all rights reserved)
    echo Date: 01 December, 2014
    echo.
    echo Disclaimer:
    echo We can't be responsible for any damage done to your system,
    echo which hopefully will not happen.
:SILENT_1

REM KETTLE_PATH
if EXIST "%KETTLE_PATH%" GOTO END_WHILE_KETTLE_PATH
set KETTLE_PATH=
:WHILE_KETTLE_PATH
echo.
set /p KETTLE_PATH="Please, enter the <data-integration> path (es.:C:\data-integration): "
if "%KETTLE_PATH%"=="" GOTO WHILE_KETTLE_PATH
:END_WHILE_KETTLE_PATH

if "%1"=="silent" GOTO SILENT_2
    echo.
    echo You are going to execute this command:
    echo Kitchen.bat /rep:"AAAR_Kettle" /job:"Report all" /dir:/Alfresco /user:admin /pass:admin /log="%LOG_PATH%" /level:Basic
    echo.
    pause
    echo.
:SILENT_2

cd "%KETTLE_PATH%"

Kitchen.bat /rep:"AAAR_Kettle" /job:"Report all" /dir:/Alfresco /user:admin /pass:admin /log="%LOG_PATH%" /level:Basic

cd "%CURRENT_PATH%"

if "%1"=="silent" GOTO SILENT_3
    echo.
    echo Extraction complete!
    echo.
    echo Log file has been generated in the file below:
    echo %LOG_PATH%
    echo.
    echo Check for ERRORS in the log.
    echo If you can't find them, everything has gone alright.
    echo Please, remember to schedule the command periodically or to execute it manually.
    echo.
    echo Tip:
    echo You can schedule this command using the silent execution with the command below:
    echo %CURRENT_PATH%/AAAR_Publish.bat silent
    echo.
    echo Enjoy A.A.A.R.!
    echo.
:SILENT_3
