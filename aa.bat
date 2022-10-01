setlocal enabledelayedexpansion
for /f "eol=* tokens=*" %%i in ('dir /b /s /a:-d *.txt') do (
rem 设置变量a为每行内容
set a=%%i
rem 如果该行有123，则将其改为456
set "a=!a:/n/=!"
rem 把修改后的全部行存入$
echo !a!>>$)
rem 用$的内容替换原来a.txt内容
move $ a.txt

