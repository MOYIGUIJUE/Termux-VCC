@ECHO %DBG% OFF&mode 30,5
set num=1
rem 渇議繁方
for /l %%z in (1 1 %num%) do (
	ping 127.0.1 -n 1 >nul
	call:num
)
pause>nul
exit /b
:num
　　SETLOCAL ENABLEDELAYEDEXPANSION
　　FOR /F "TOKENS=*" %%i IN (name.txt) DO (SET /A h+=1 & SET r!h!=%%i)
　　SET /A s=%RANDOM%%%%h%+1
　　ECHO %s%:!r%s%!&goto :eof
pause 2>nul