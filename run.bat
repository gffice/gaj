@echo off
echo ----------------------
set str="AAA BBB CCC" 
:STR_VISTOR
for /f "tokens=1,*" %%a in (%str%) do ( 
echo %%a
set str="%%b" 
goto STR_VISTOR
)
echo ----------------------
