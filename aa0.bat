dir /b /s /a:-d *.txt >ghl.txt
setlocal enabledelayedexpansion
for /f   %%i in (ghl.txt)  do [
set dit=%%i
for /f "delims=\n\ tokens=1,*" %%b in (%dit%) do (echo %%b>>%dit%)
]

