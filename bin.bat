set targe=''
setlocal enabledelayedexpansion
for /f   %%i in (sh0.txt)  do (
set target=%%i
curl https://data.gtimg.cn/flashdata/hushen/latest/daily/sh%target%.js >sh%target%.txt
) 
dir
