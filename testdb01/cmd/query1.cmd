REM query1.cmd - script to query the db and copy output
set myErrors=0

REM get password and connectstring
d:
call \testdb01\cmd\db_login.cmd opstest_ro
if %errorlevel% NEQ 0 goto badend

REM run sql
sqlplus -l %connectstring% @\testdb01\sql\query1.sql
if %errorlevel% NEQ 0 (set /A myErrors+=1)

REM copy output
copy \testdb01\log\sql1.log \testapp01\input\ 
if %errorlevel% NEQ 0 (set /A myErrors+=1)

:end
echo Success!
exit /b 0

:badend
set myErrors=1
echo script failed
exit /b %myErrors%
