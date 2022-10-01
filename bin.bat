set targe=''
setlocal enabledelayedexpansion
for /f   %%i in (sh0.txt)  do (
set target=%%i
set dlo=!target!
curl https://data.gtimg.cn/flashdata/hushen/latest/daily/sh%dlo%.js >sh%dlo%.txt
) 
dir
