REM query2.cmd - script to query the db and copy output
set myErrors=0

REM get password; provides openffs_up as argument to db_login.cmd
d:
call \testdb01\cmd\db_login.cmd opstest_up
if %errorlevel% NEQ 0 goto badend

REM run sql
sqlplus -l %connectstring% @\testdb01\sql\query2.sql
if %errorlevel% NEQ 0 (set /A myErrors+=1)

REM copy output
copy \testdb01\log\sql2.log \testapp01\input\sql2.txt 
if %errorlevel% NEQ 0 (set /A myErrors+=1)

REM get password succeeded, sql and or copy failed
if %myErrors% NEQ 0 goto badend

:end
echo Success!
exit /b 0

:badend
set myErrors=1
echo script failed
exit /b %myErrors%
