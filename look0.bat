set targe=''
setlocal enabledelayedexpansion
for /f   %%o in (%1)  do (
echo %%o >>look0.txt
cmd /c run.bat look0.txt >>look1.txt
set /p dm= <look1.txt
md %dm%
copy look0.txt %dm%
del look0.txt
del look1.txt
) 
dir
