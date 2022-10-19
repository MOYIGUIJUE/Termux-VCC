@echo off
setlocal enabledelayedexpansion
pushd %~dp0..\..
set VCC_HOME=%CD%
popd
for %%i in (%VCC_HOME%) do set "home=%%~pnxi"
call vcc -v >nul

if "%~1"=="-c" (
	cd /d %~dp0
	if not "%~3"=="" set version=%3
	goto :check
) else if "%~1"=="-l" (
	cd /d %~dp0
	goto :log
) else if "%~1"=="-t" (
	dir /b %temp%\?.?.?.log %temp%\?.?.?.cmd
) else (
	echo;
	echo;Usage: update [arguments] [-c] [path] [version]
	echo;   or: update [arguments] {[-t][-l]}
	echo;  
	echo;Arguments:
	echo;   -l:  生成本版本文件目录信息
	echo;   -c:  生成更新脚本 [path]为目标路径 
	echo;                     [version]为自定义要对比的版本
	echo;   -t:  查看临时目录下版本文件
	exit /b
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
echo;@echo off >"%temp%\run_update.cmd"
echo;copy /y "%VCC_HOME%\Termux.bat" "%~2\" >>"%temp%\run_update.cmd"

REM 计数
set reduce=0
set add=0
set change=0

echo;
for /f "delims=" %%i in (%tmp%\%version%.log) do (
	if not exist "%VCC_HOME%%%i" (
		echo;  - %VCC_HOME%%%i
		set /a reduce+=1
		echo;del /f /q "%~2%%~i" >>"%temp%\run_update.cmd"
	)
)
for /r "%VCC_HOME%\Compile" %%i in (*) do (
	set "tm=%%~pnxi"
	if "%home%"=="\" (set "tmps=!tm!") else set "tmps=!tm:%home%=!"
	call set name=%%Arr!tmps!%%
	if "!name!" NEQ "%%~zi" (
		if "!name!"=="" ( echo;  + %%i & set /a add+=1 ) else echo;  * %%i & set /a change+=1
		echo;copy /y "%%~i" "%~2!tmps!" >>"%temp%\run_update.cmd"
	)
)
echo;
if "%~2"=="" ( echo;  -- [ CHANGE %change% ADD %add% REDUCE %reduce% ] --  ) else echo;  -- RUN CODE --  [%%TEMP%%\RUN_UPDATE.CMD]
exit /b
