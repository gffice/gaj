for /f "delims=\n\ tokens=1,*" %%b in (sh%1.txt) do (echo %%b>>%1.txt)
