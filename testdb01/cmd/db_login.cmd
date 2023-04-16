REM script to set passwords and connectstrings to login to db

REM accounts and passwords in this file are not real and are only for demonstration and case study purposes. in a real production environment passwords are encrypted and retrieved from a secure secrets store.

set DB_SID=GFMP
REM Oracle DB - SystemID: GFMP?


@echo off
REM turns off command echoing in the batch script, so commands are not displayed in the console as they are executed.

REM %1 == first command-line arg

REM arg == opstest
if /i "%1" EQU "opstest" (
set USER_NAME=%~1
set PASS_WORD=strongPass1
goto connectstring
)

if /i "%1" EQU "opstest_ro" (
set USER_NAME=%~1
set PASS_WORD=strongPass2
goto connectstring
)

if /i "%1" EQU "opstest_up" (
set USER_NAME=%~1
set PASS_WORD=strongPass3
goto connectstring
)

echo %~n0: %~1 is an invalid user
goto abort_end


REM Set DB Connection String
:connectstring
set CONNECTSTRING=%USER_NAME%/%PASS_WORD%@%DB_SID%

REM Test the connection, jump if fail
sqlplus -l %CONNECTSTRING% @\testdb01\sql\query3.sql
if %errorlevel% NEQ 0 goto abort_end

:good_end
echo %~n0: Successfully set PASS_WORD for %user_name%
exit /b 0

:abort_end
echo %~n0: Unable to set PASS_WORD for %~1
exit /b 1
