@echo off

REM Settings
set VERSION='2.3'
set CURRENT_PATH=%cd%
set ENDPOINTS_PATH=%CURRENT_PATH%\..
set LOGS_PATH=%ENDPOINTS_PATH%\logs
set LOG_PATH=%LOGS_PATH%\AAAR.log

REM Set by writeConfiguration.kjb.
set JOB_NAME=Get all
set GET_PARENTS=false
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
    echo.
    echo Tip:
    echo Want to reduce the time of execution?
    echo Edit this script and change 'JOB_NAME' and 'GET_PARENTS' variables.
    echo If you don't know how, look at the FAQ at http://fcorti.com.
:SILENT_1

REM JOB_NAME
:WHILE_JOB_NAME
if "%JOB_NAME%"=="Get audit" GOTO END_WHILE_JOB_NAME
if "%JOB_NAME%"=="Get nodes" GOTO END_WHILE_JOB_NAME
if "%JOB_NAME%"=="Get all" GOTO END_WHILE_JOB_NAME
set JOB_NAME=
echo.
set /p JOB_NAME_ANSWER="Do you want to import audit trail, repository data or both? (audit/repository/both): "
if /i "%JOB_NAME_ANSWER%"=="audit" set JOB_NAME=Get audit
if /i "%JOB_NAME_ANSWER%"=="repository" set JOB_NAME=Get nodes
if /i "%JOB_NAME_ANSWER%"=="both" set JOB_NAME=Get all
GOTO WHILE_JOB_NAME
:END_WHILE_JOB_NAME

REM GET_PARENTS
:WHILE_GET_PARENTS
if "%JOB_NAME%"=="Get audit" GOTO END_WHILE_GET_PARENTS
if "%GET_PARENTS%"=="true" GOTO END_WHILE_GET_PARENTS
if "%GET_PARENTS%"=="false" GOTO END_WHILE_GET_PARENTS
set GET_PARENTS=
echo.
set /p GET_PARENTS_ANSWER="Do you want to import repository structure? (y/n): "
if /i "%GET_PARENTS_ANSWER%"=="y" set GET_PARENTS=true
if /i "%GET_PARENTS_ANSWER%"=="n" set GET_PARENTS=false
GOTO WHILE_GET_PARENTS
:END_WHILE_GET_PARENTS

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
    echo Kitchen.bat /rep:"AAAR_Kettle" /job:"%JOB_NAME%" /dir:/Alfresco /user:admin /pass:admin /param:get_parents="%GET_PARENTS%" /log="%LOG_PATH%" /level:Basic
    echo.
    pause
    echo.
:SILENT_2

cd "%KETTLE_PATH%"

Kitchen.bat /rep:"AAAR_Kettle" /job:"%JOB_NAME%" /dir:/Alfresco /user:admin /pass:admin /param:get_parents="%GET_PARENTS%" /log="%LOG_PATH%" /level:Basic

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
