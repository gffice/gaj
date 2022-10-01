for /f "delims=\n\ tokens=1,*" %%b in (sh%out0%.txt) do (echo %%b>>sh%out0%.txt)
