for /r %2 %%a in (*.txt) do type "%%a" | find "%1" /v >>"%%a.tmp"
for /r %2 %%a in (*.txt) do del /q "%%a" && move /y "%%a.tmp" "%%a" >nul
rem for /f "delims=\n\ tokens=1,*" %%b in (%temab%) do (echo %%b>>%temab%)
