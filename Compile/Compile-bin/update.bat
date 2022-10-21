@echo off
setlocal enabledelayedexpansion
pushd %~dp0..\..
set VCC_HOME=%CD%
popd
for %%i in (%VCC_HOME%) do set "home=%%~pnxi"
call vcc -v >nul

REM 准备工作
set reduce=0
set add=0
set change=0
set REMSS=REM
if exist "%~2" (
	set REMSS=
	set "MD_PATH=%~2"
	if "!MD_PATH:~-1,1!"=="\" (
		echo;路径最后不能带\
		exit /b
	)
)
%REMSS% echo;@echo off >"%temp%\run_update.cmd"
%REMSS% echo;copy /y "%VCC_HOME%\Termux.bat" "%~2\" >>"%temp%\run_update.cmd"

if "%~1"=="-c" (
	if not "%~3"=="" set version=%3
	goto :check
) else if "%~1"=="-f" (
	if not exist "%~2" (
		echo;[ERROR] 路径不存在
		exit /b
	)
	goto CHECK_FILE
) else if "%~1"=="-l" (
	goto :log
) else if "%~1"=="-t" (
	dir /b %temp%\?.?.?.log %temp%\?.?.?.cmd
) else (
	echo;
	echo;Usage: update [arguments] [-c] [path] [version]
	echo;   or: update [arguments] [-f] [path]
	echo;   or: update [arguments] {[-t][-l]}
	echo;
	echo;Arguments:
	echo;   -l:  生成本版本文件目录信息
	echo;   -t:  查看临时目录下版本文件   
	echo;   -f:  比较[path]文件内容、生成更新脚本
	echo;   -c:  比较[version]版本信息记录的文件大小、生成更新脚本
	echo;
	echo;Others: 
	echo;        更新脚本位于 %%temp%%\run_update.cmd
	echo;    
)
exit /b

:log
echo;  - 为版本 %version% 生成文件目录信息 [ - ]
cd.>%tmp%\%version%.log
cd.>%tmp%\%version%.cmd
for /r "%VCC_HOME%\Compile" %%i in (*) do (
	set "tm=%%~pnxi"
	if "%home%"=="\" (set "tmps=!tm!") else set "tmps=!tm:%home%=!"
	echo;set "Arr!tmps!=%%~zi">>%tmp%\%version%.cmd
	echo;!tmps!>>%tmp%\%version%.log
)
exit /b

:check
if not exist "%tmp%\%version%.cmd" echo;Not find %version%.cmd & exit /b
if not exist "%tmp%\%version%.log" echo;Not find %version%.log & exit /b

call %tmp%\%version%.cmd

echo;
for /f "delims=" %%i in (%tmp%\%version%.log) do (
	if not exist "%VCC_HOME%%%i" (
		echo;  - %VCC_HOME%%%i
		set /a reduce+=1
		%REMSS% echo;del /f /q "%~2%%~i" >>"%temp%\run_update.cmd"
	)
)
for /r "%VCC_HOME%\Compile" %%i in (*) do (
	set "tm=%%~pnxi"
	if "%home%"=="\" (set "tmps=!tm!") else set "tmps=!tm:%home%=!"
	call set name=%%Arr!tmps!%%
	if "!name!" NEQ "%%~zi" (
		if "!name!"=="" ( echo;  + %%i & set /a add+=1 ) else echo;  * %%i & set /a change+=1
		%REMSS% echo;copy /y "%%~i" "%~2!tmps!" >>"%temp%\run_update.cmd"
	)
)
goto :show_result

:CHECK_FILE
echo;  对比 %VCC_HOME% 和 %2 [ - ]
echo;  Press any key to continue ...
pause >nul
for /r "%2\Compile" %%i in (*) do (
	set "tm=%%~pnxi"
	set "tmps=!tm:%~2=!"
	if not exist "%VCC_HOME%!tmps!" (
		echo;  - %VCC_HOME%!tmps!
		set /a reduce+=1
		echo;del /f /q "%%~i" >>"%temp%\run_update.cmd"
	)
)

for /r "%VCC_HOME%\Compile" %%i in (*) do (
	set "tm=%%~pnxi"
	if "%home%"=="\" (set "tmps=!tm!") else set "tmps=!tm:%home%=!"
	FC "%%i" "%~2!tmps!" 2>nul>nul || (
		if !errorlevel! EQU 2 (
			echo;  + %~2!tmps!
			set /a add+=1
		) else echo;  * %%i & set /a change+=1 
		echo;copy /y "%%~i" "%~2!tmps!" >>"%temp%\run_update.cmd"
	)
)

:show_result
echo;
echo;  -- [ REDUCE %reduce% CHANGE %change% ADD %add% ] --
