REM script3.cmd - script to create csv
set myErrors=0

REM check for input files
if not exist \testapp01\input\sql1.txt (
    echo sql1.txt not found
    set /A myErrors+=1
)
if not exist \testapp01\input\sql2.txt (
    echo sql2.txt not found
    set /A myErrors+=1
)

REM check if any input files are missing and terminate the script if so
if %myErrors% NEQ 0 goto badend

REM use input files to create output
for /F "tokens=* delims=*" %%G in (\testapp01\input\sql1.txt) do (
@echo %%G,>>\testapp01\output\analysis.csv
)
for /F "tokens=* delims=*" %%G in (\testapp01\input\sql2.txt) do (
@echo %%G,>>\testapp01\output\analysis.csv
)

if not exist \testapp01\output\analysis.csv set /A myErrors+=1

:end
exit /b %myErrors%

:badend
set myErrors=1
echo script failed, one or more input files not found
exit /b %myErrors%
