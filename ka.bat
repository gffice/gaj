setlocal enabledelayedexpansion
dir /b /s /a:-d *.txt >>$
for /f "" %%i in ($) do (
cmd /c aa0.bat %%i
)
