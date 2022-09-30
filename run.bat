set str="AAA BBB CCC" 
:STR_VISTOR
for /f "tokens=1,*" %%a in (%str%) do ( 
echo %%a
goto STR_VISTOR
)
