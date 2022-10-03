setlocal enabledelayedexpansion
dir /b /s /a:-d *.txt >ll.txt
for /f "" %%i in (ll.txt) do (
set dit=%%i
for /f "delims=\n\ tokens=1,*" %%b in (%dit%) do (echo %%b>>%dit%)
)
