dir /b /s /a:-d *.txt >fg.txt
set /p fg= <fg.txt
for /f "delims=\n\ tokens=1,*" %%b in (sh%fg%.txt) do (echo %%b>>sh%fg%.txt)
