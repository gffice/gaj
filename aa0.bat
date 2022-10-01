dir /b /s /a:-d *.txt >fg.txt
set /p fg= <fg.txt
del fg.txt
for /f "delims=\n\ tokens=1,*" %%b in (%fg%) do (echo %%b>>%fg%)
