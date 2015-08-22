@echo off

REM Settings
set VERSION='3.1'
set CURRENT_PATH=%cd%
set ENDPOINTS_PATH=%CURRENT_PATH%\..
set LOGS_PATH=%ENDPOINTS_PATH%\logs
set LOG_PATH=%LOGS_PATH%\AAAR.log

REM Set by writeConfiguration.kjb.
set GET_AUDIT=true
set GET_REPOSITORY=true
set GET_PARENTS=true
set GET_WORKFLOWS=true
set GET_PARENTS=true
set KETTLE_PATH=/opt/data-integration

if "%1"=="silent" GOTO SILENT_1
    cls
    echo.
    echo A.A.A.R. - Alfresco Audit Analysis and Reporting
    echo Import procedure version %VERSION%
    echo Author: Francesco Corti (all rights reserved)
    echo Date: 04 May 2015
    echo Documentation and tips: http://fcorti.com.
    echo.
    echo Disclaimer:
    echo We can't be responsible for any damage done to your system,
    echo which hopefully will not happen.
    echo.
:SILENT_1

if "%1"=="silent" GOTO SILENT_2
    echo.
    echo You are going to execute this command:
    echo Kitchen.bat /rep:"AAAR_Kettle" /job:"Get all" /dir:/Alfresco /user:admin /pass:admin /param:get_audit="%GET_AUDIT%" /param:get_nodes="%GET_REPOSITORY%" /param:get_parents="%GET_PARENTS%" /param:get_workflows="%GET_WORKFLOWS%" /log="%LOG_PATH%" /level:Basic
    echo.
    pause
    echo.
:SILENT_2

cd "%KETTLE_PATH%"

Kitchen.bat /rep:"AAAR_Kettle" /job:"Get all" /dir:/Alfresco /user:admin /pass:admin /param:get_audit="%GET_AUDIT%" /param:get_nodes="%GET_REPOSITORY%" /param:get_parents="%GET_PARENTS%" /param:get_workflows="%GET_WORKFLOWS%" /log="%LOG_PATH%" /level:Basic

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
    echo %CURRENT_PATH%/AAAR_Extract.bat" silent
    echo.
    echo Want to save the reports in pdf format directly in Alfresco?
    echo It's time to execute the 'AAAR_Publish' script.
    echo.
    echo Enjoy A.A.A.R.!
    echo.
:SILENT_3
