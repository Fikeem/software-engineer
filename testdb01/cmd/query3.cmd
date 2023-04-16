REM query3.cmd - script to verify input
set myErrors=0



:end
exit /b %myErrors%

:badend
set myErrors=1
echo script failed
exit /b %myErrors%