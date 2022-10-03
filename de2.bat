SET /A N=2
FOR /F "tokens=1 delims=" %%I IN ('echo %1') DO ((MORE +%N% "%%I">"%%I_")&(DEL /A /F /Q "%%I")&(REN "%%I_" "%%I"))
findstr /n . %1 | find /c /v "" >>tem.txt
set /p temt= <tem.txt
set /a ded=%temt%-1
echo %ded%
