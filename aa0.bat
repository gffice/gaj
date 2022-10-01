dir /b /s /a:-d *.txt >ghl.txt
setlocal enabledelayedexpansion
for /f   %%i in (ghl.txt)  do [
for /f "delims=\n\ tokens=1,*" %%b in (%%i) do (echo %%b>>%%i)
]

