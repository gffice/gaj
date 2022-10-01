@echo off
setlocal EnableDelayedExpansion
 
set "CurrCD=%~dp0"
set "strOld=  "
set "strNew= "
 
:: 将当前目录(包括子目录)下的所有 TXT 文本中的 aaaaa 替换为 zzzzz
for /f %%i in ('dir /b /s /a:-d *.txt') do (
  powershell -Command "(gc %%i) -replace '%strOld%', '%strNew%' | Out-File -Encoding ANSII %%i"
)
