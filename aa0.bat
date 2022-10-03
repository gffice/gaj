dir /b /s /a:-d *.txt >$
for /f %%i in ($)  do (
set dit=%%i
goto 4
:5
)
:4
for /f "delims=\n\ tokens=1,*" %%b in (%dit%) do (echo %%b>>%dit%)
goto 5
