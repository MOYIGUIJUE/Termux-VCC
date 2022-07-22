@echo off & setlocal enabledelayedexpansion
path=%path%;..\Compile-bin
modes 120 9
set /a MAX_NUM_X = 0
set /a MAX_NUM_Y = 0
set /a Y=0
set "paths=%~dp0table"
rem -----------外部实现------------
table.exe "%paths%"
if "%date:~12,1%" == "六" (
	select time,星期一 from "%paths%"
) else if "%date:~12,1%" == "日" (
	select time,星期一 from "%paths%"
) else (
	select time,星期%date:~12,1% from "%paths%"
)

rem ------------读入数组------------
for %%j in ("%paths%\*.tb") do (
	set /a Y+=1
	set /a X=0
	for /f "usebackq tokens=* delims=" %%i in ("%%j") do (
		set /a X+=1
		set "arr[!X!][!Y!]=%%i"
			REM echo;arr[!X!][!Y!]=%%i
	)
	if !X! GEQ !MAX_NUM_X! set MAX_NUM_X=!X!
)

set /a MAX_NUM_Y = %Y%

rem -------获取每一列最长字符数-------
for /l %%j in (1,1,%MAX_NUM_Y%) do (
	for /l %%i in (1,1,%MAX_NUM_X%) do (
		call length "!arr[%%i][%%j]!"
		if !errorlevel! GEQ !arr_len[%%j]! set /a arr_len[%%j] = !errorlevel!
			REM echo;arr_len[%%j]=!arr_len[%%j]!
	)
)

rem --------参考数据---------
REM echo;MAX_NUM_X:%MAX_NUM_X%
REM echo;MAX_NUM_Y:%MAX_NUM_Y%
set sum=0
for /l %%i in (1,1,%MAX_NUM_Y%) do (
	set /a sum+=!arr_len[%%i]!
)
set /a SUM_X = %sum% + %MAX_NUM_Y% + 13
REM set /a SUM_Y= %MAX_NUM_X% + 4
set /a SUM_Y= %MAX_NUM_X% + 5
modes %SUM_X% %SUM_Y%
REM echo;mode[%SUM_X%,%SUM_Y%]
rem ---------------打印表格头------------
set t=0
for /f "usebackq tokens=* delims=" %%i in ("%paths%\titles.tl") do (
	set /a t+=1
	set "t_arr[!t!]=%%i"
)

call :cout
for /l %%i in (1,1,%MAX_NUM_Y%) do (
	set /a t+=1
	printf 0x07 "| "
	printf 0x07 "!t_arr[%%i]! "
	call length "!t_arr[%%i]!"
	set /a tmp=!arr_len[%%i]!-!errorlevel!
	printf -n "0x07" "!tmp!" " "
)
echo;^|
rem ---------------打印表格--------------
call :cout
for /l %%j in (1,1,%MAX_NUM_X%) do (
	for /l %%i in (1,1,%MAX_NUM_Y%) do (
		printf 0x07 "| "
		printf 0x07 "!arr[%%j][%%i]! "
		call length "!arr[%%j][%%i]!"
		set /a tmp=!arr_len[%%i]!-!errorlevel!
		printf -n "0x07" "!tmp!" " "
	)
	echo;^|
)
call :cout
rem -------------END---------------
title %date% %time%
if "%date:~12,1%" == "一" (
	set /a date_x=1
) else if "%date:~12,1%" == "二" (
	set /a date_x=2
) else if "%date:~12,1%" == "三" (
	set /a date_x=3
) else if "%date:~12,1%" == "四" (
	set /a date_x=4
) else if "%date:~12,1%" == "五" (
	set /a date_x=5
) else (
	set /a date_x=6
)

if %time:~0,2% LEQ 8 (
	set /a date_y=1
) else if %time:~0,2% LEQ 10 (
	set /a date_y=2
) else if %time:~0,2% LEQ 14 (
	set /a date_y=3
) else if %time:~0,2% LEQ 16 (
	set /a date_y=4
) else  (
	set /a date_x+=1
	set /a date_y=1
) 

if %date_x% GTR 5 set /a date_x=1 && set /a date_y=1

set /a date_x+=1
for /l %%i in (%date_y%,1,%MAX_NUM_X%) do (
	printf 0x07 "+" &printf -n "0x07" 20 "-" 
	printf 0x07 "+" &printf -n "0x07" 20 "-" &echo;+
	printf 0x07 "| "
	printf 0x07 "!arr[%%i][1]! "
	call length "!arr[%%i][1]!"
	set /a tmp=18-!errorlevel!
	printf -n "0x07" "!tmp!" " "
	
	printf 0x07 "| "
	printf 0x07 "!arr[%%i][%date_x%]! "
	call length "!arr[%%i][%date_x%]!"
	set /a tmp=18-!errorlevel!
	printf -n "0x07" "!tmp!" " "
	
	echo;^|
)
printf 0x07 "+" &printf -n "0x07" 20 "-"
printf 0x07 "+" &printf -n "0x07" 20 "-" &echo;+
pause>nul
exit /b

:cout
for /l %%j in (1,1,%MAX_NUM_Y%) do (
	printf 0x07 "+"
	set /a len=!arr_len[%%j]!+2
	printf -n "0x07" "!len!" "-"
)
echo;+
goto :eof

