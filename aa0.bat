for /f "delims=\n\ tokens=1,*" %%b in (%1) do (echo %%b>>%1)
