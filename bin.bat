set targe=''
setlocal enabledelayedexpansion
for /f   %%i in (sh0.txt)  do (
curl https://data.gtimg.cn/flashdata/hushen/latest/daily/sh%%i.js >sh%%i.txt
cmd /c set out0=%%i & aa0.bat
) 
dir
