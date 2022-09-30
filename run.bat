@echo off
echo ----------------------
set /p te= <te.txt
set str="%te%" 
:STR_VISTOR
for /f "tokens=1,*" %%a in (%str%) do ( 
echo %%a
set str="%%b" 
goto STR_VISTOR
)
echo ----------------------
