set temab= |dir /b /s /a:-d *.txt
echo %temab%
for /f "delims=\n\ tokens=1,*" %%b in (%temab%) do (echo %%b>>%temab%)
