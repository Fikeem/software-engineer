REM script3.cmd - script to create csv
set myErrors=0

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
echo script failed
exit /b %myErrors%
