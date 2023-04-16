REM script to copy file to share
set myErrors=0

copy \testapp01\output\test.txt \\rm15fs01\crms\
if %errorlevel% NEQ 0 set /A myErrors+=1

:end
exit /b %myErrors%
