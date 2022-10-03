setlocal enabledelayedexpansion
dir /b /s /a:-d *.txt >>$
for /f "" %%i in ($) do (
set dit=%%i
for /f "delims=\n\ tokens=1,*" %%b in (%dit%) do (echo %%b>>%dit%)
)
