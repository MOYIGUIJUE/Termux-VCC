@echo off
setlocal enabledelayedexpansion
pushd %~dp0..\..
set VCC_HOME=%CD%
popd
for %%i in (%VCC_HOME%) do set "home=%%~pnxi"
call vcc -v >nul

if "%~1"=="-c" (
	cd /d %~dp0
	goto :check
) else if "%~1"=="-l" (
	cd /d %~dp0
	goto :log
) else if "%~1"=="-t" (
	dir /b %tmp%\?.?.?.log %tmp%\?.?.?.cmd
) else (
	echo;
	echo;Usage: update [arguments] {[-c][-l]}
	echo;  
	echo;Arguments:
	echo;   -l:  生成本版本文件目录信息
	echo;   -c:  生成从上一个版本到这个版本的更新脚本
	echo;   -t:  查看临时目录下版本文件
	exit /b
)
exit /b

:log
cd.>%tmp%\%version%.log
cd.>%tmp%\%version%.cmd
for /r "%VCC_HOME%\Compile" %%i in (*) do (
	set "tmp=%%~pnxi"
	if "%home%"=="\" (set "tmps=!tmp!") else set "tmps=!tmp:%home%=!"
	echo;set "Arr!tmps!=%%~zi">>%tmp%\%version%.cmd
	echo;!tmps!>>%tmp%\%version%.log
)
exit /b

:check
REM call :vcc_version_add %version%
REM echo;copy /y "termux.bat" "%%VCC_HOME%%\termux.bat">RUN-%version%.cmd
if not exist "%tmp%\%version%.cmd" echo;Not find %version%.cmd & exit /b
if not exist "%tmp%\%version%.log" echo;Not find %version%.log & exit /b

call %tmp%\%version%.cmd

for /f "delims=" %%i in (%tmp%\%version%.log) do (
	if not exist "%VCC_HOME%%%i" (
		echo;  - %VCC_HOME%%%i
		REM echo;del /f /q "%%VCC_HOME%%%%~i" >>RUN-%version%.cmd
	)
)

for /r "%VCC_HOME%\Compile" %%i in (*) do (
	set "tmp=%%~pnxi"
	if "%home%"=="\" (set "tmps=!tmp!") else set "tmps=!tmp:%home%=!"
	call set name=%%Arr!tmps!%%
	if "!name!" NEQ "%%~zi" (
		if "!name!"=="" ( echo;  + %%i ) else echo;  * %%i
		REM copy /y "%%~i" ".!tmps!"
		REM echo;copy /y ".!tmps!" "%%VCC_HOME%%!tmps!" >>RUN-%version%.cmd
	)
)
exit /b






choice /N /M ". - 是否打包[Y/N] -"
if %errorlevel% EQU 2 exit /b

for /r "%VCC_HOME%\Compile" %%i in (*) do (
	set "tmp=%%~pnxi"
	set "tmps=!tmp:%home%=!"
	call set name=%%Arr!tmps!%%
	if "!name!" NEQ "%%~zi" (
		echo;  + %%i
		copy /y "%%~i" ".!tmps!"
		REM echo;copy /y ".!tmps!" "%%VCC_HOME%%!tmps!" >>RUN-%version%.cmd
	)
)

if not exist "%~dp0Compile\" xcopy /T /E /Y %VCC_HOME%\Compile %~dp0Compile\
copy /y "%VCC_HOME%\Termux.bat" "%~dp0"


if exist TERMUX-VCC.7z del /f /q TERMUX-VCC.7z
7z a ".\TERMUX-VCC.7z" ".\Compile\" ".\*.bat" ".\*.cmd" ".\*.log"
exit /b

:vcc_version_add
set "ver=%~1"
set "ver=%ver:.=%"
set /a ver-=1
set version=%ver:~0,1%.%ver:~1,1%.%ver:~2,1%
goto :eof