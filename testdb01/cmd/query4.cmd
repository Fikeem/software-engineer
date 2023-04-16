REM query4.cmd - script to query the db and copy output
set myErrors=0

REM get password
d:
call \testdb01\cmd\db_login.cmd opstest
if %errorlevel% NEQ 0 goto badend

@echo on
REM run sql
sqlplus -l %connectstring% @\testdb01\sql\query4.sql
if %errorlevel% NEQ 0 (
set msg="could not run query"
goto badend
)

REM copy output
copy \testdb01\log\sql4.log \testapp01\input\
if %errorlevel% NEQ 0 (
set msg="could not copy file"
goto badend
)

:end
set myErrors=0
echo Success!
exit /b %myErrors%

:badend
set myErrors=1
echo script failed %msg%
exit /b %myErrors%
