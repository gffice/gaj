set targe=''
setlocal enabledelayedexpansion
for /f   %%i in (sh0.txt)  do (
curl https://data.gtimg.cn/flashdata/hushen/latest/daily/sh%%i.js >sh%%i.txt
cmd /c aa0.bat %%i
del sh%%i.txt
cmd /c de2.bat %%i.txt
cmd /c look0.bat %%i.txt
) 
dir
