@echo off
setlocal enabledelayedexpansion
pushd %~dp0..\..
set VCC_HOME=%CD%
popd
for %%i in (%VCC_HOME%) do set "home=%%~pnxi"
call vcc -v >nul
set FILE_CHECK=REM 
if "%~1"=="-c" (
	if not "%~3"=="" set version=%3
	goto :check
) else if "%~1"=="-f" (
	if not "%~3"=="" set version=%3
	set FILE_CHECK=
	goto :check
) else if "%~1"=="-l" (
	goto :log
) else if "%~1"=="-t" (
	dir /b %temp%\?.?.?.log %temp%\?.?.?.cmd
) else (
	echo;
	echo;Usage: update [arguments] {[-c][-f]} [path] [version]
	echo;   or: update [arguments] {[-t][-l]}
	echo;  
	echo;Arguments:
	echo;   -l:  生成本版本文件目录信息
	echo;   -c:  比较[version]版本信息记录的文件大小、生成更新脚本
	echo;   -f:  比较[path]文件内容、生成更新脚本
	echo;   -t:  查看临时目录下版本文件
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

REM 计数
set reduce=0
set add=0
set adds=0
set change=0
set changes=0
set REMSS=REM
if exist "%~2" set REMSS=

%FILE_CHECK% %REMSS% echo;  - 对比 %VCC_HOME% 和 %2 [ - ]
%FILE_CHECK% %REMSS% echo;  - Press any key to continue ...
%FILE_CHECK% %REMSS% pause >nul

call %tmp%\%version%.cmd
%REMSS% echo;@echo off >"%temp%\run_update.cmd"
%REMSS% echo;copy /y "%VCC_HOME%\Termux.bat" "%~2\" >>"%temp%\run_update.cmd"

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
	) else (
		%FILE_CHECK% %REMSS% if "%home%"=="\" (set "tmps=!tm!") else set "tmps=!tm:%home%=!"
		%FILE_CHECK% %REMSS% FC "%%i" "%~2!tmps!" 2>nul>nul || ( if !errorlevel! EQU 2 ( echo;  # %~2!tmps! & set /a adds+=1 ) else echo;  @ %%i & set /a changes+=1 )
	)
)
echo;
if exist "%~2" (
echo;  -- [ REDUCE %reduce% CHANGE %change% ADD %add% FCA %adds% FCC %changes% ] --
) else echo;  -- [ REDUCE %reduce% CHANGE %change% ADD %add% ] --
exit /b
