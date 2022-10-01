set targe=''
setlocal enabledelayedexpansion
for /f   %%i in (sh0.txt)  do (
curl https://data.gtimg.cn/flashdata/hushen/latest/daily/sh%%i.js >sh%%i.txt
for /f "delims=\n\ tokens=1,*" %%b in (%%i.txt) do (echo %%b>>%%i.txt)
) 
dir
