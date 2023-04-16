REM script to set passwords and connectstrings to login to db

REM accounts and passwords in this file are not real and are only for demonstration and case study purposes. in a real production environment passwords are encrypted and retrieved from a secure secrets store.

set DB_SID=GFMP

@echo off

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

:connectstring
set CONNECTSTRING=%USER_NAME%/%PASS_WORD%@%DB_SID%

:good_end
echo %~n0: Successfully set PASS_WORD for %user_name%
exit /B 0

:abort_end
echo %~n0: Unable to set PASS_WORD for %~1
exit /B 1
