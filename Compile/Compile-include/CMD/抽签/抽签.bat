@echo off &mode 30,5
setlocal enabledelayedexpansion
set file=name.txt
set num=1
rem ????
for /l %%z in (1 1 %num%) do (
	ping 127.0.1 -n 1 >nul
	call:num
)
pause>nul
exit /b
:num
set line_num=0
for /f %%i in (%file%) do set /a line_num+=1
set /a line=%random% %% %line_num%
set /a line+=1
set line_num=0
for /f "tokens=*" %%i in (!file!) do (
    set /a line_num+=1
    if !line_num!==!line! echo(µÚ!line_num!ÐÐ:%%i&goto :eof
)
