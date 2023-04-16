REM query4.cmd - script to query the db and copy output
set myErrors=0



REM get password
d:
call \testdb01\cmd\db_login.cmd openffs
if %errorlevel% NEQ 0 goto badend

@echo on
REM run sql
sqlplus -l %connectstring% @\testdb01\sqll\query4.sql
if %errorlevel% NEQ 0 (set /A myErrors+=1)

REM copy output
copy \testdb01\log\sql4.log \testapp01\input\
if %errorlevel% NEQ 0 (set /A myErrors+=1)

:end
exit /b %myErrors%

:badend
set myErrors=1
echo script failed
exit /b %myErrors%
