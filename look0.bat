set targe=''
setlocal enabledelayedexpansion
for /f   %%o in (%1)  do (
cmd /c run.bat %%o >>look0.txt
set /p dm= <look0.txt
md %dm%
del look0.txt

) 
dir
