@echo off&setlocal enabledelayedexpansion
path=%~dp0bin;%path%
path=%~dp0out;%path%
path=%~dp0bin\vim82;%path%
title Compile
location
set "time_start=%~dpnx0"
for %%i in ("%~1") do (
	if /i "%%~xi" == ".exe" goto :exes
)
if "%~1" == "time_seconds_ms" goto :%1
if not "%~1" == "" (
	modes 60 10
	set "lwsock32=-lwsock32"
	:main
	if "%~1"=="" pause&goto lip
	set "input=%~1"
	call :names "%~1"
	if !errorlevel! equ 404 echos 0x0c [%~nx1]不是可编译文件 &shift &goto :main
	call :compile "%~1"
	echo.
	shift
	goto main
) else (
	modes 60 4
	:input
	cls
	echos 0x0c 本程序只支持.c和.cpp两种文件的编译
	set "lwsock32=-lwsock32"
	set /p "input=请输入或拖入文件名:"
	set "input=!input:"=!"
	if not exist "!input!" (
		echo;未找到指定文件,创建!input!中...
		ping 127.1 -n 3 >nul
		call :file-names "!input!"
		start cmd /c "modes 80 30 & location 1200 200 & vim.exe" !input!
	)
	call :names "!input!"
	if !errorlevel! equ 404 echos 0x0c [!input!]不是可编译文件 &pause&goto :input
)
:lip
cls
echos 0x0e "[1]编译并运行 [2]编译 [3]运行 [4]重选文件 [5]添加ico图标"
choice /C 123456789Q /N /M "[6]修改编译参数 [7]中止程序 [8]使用Vim打开 [9]添加文件"
REM /T 1 /D 7
if %errorlevel%==1 cls&call :compile-tmp & if !errorlevel! equ 1 (
	start %time_start% time_seconds_ms "%tmp%\%name%"
	pause
) else (
	pause
)
if %errorlevel%==3 start %time_start% time_seconds_ms "%name%"
if %errorlevel%==2 cls&call :compile &pause
if %errorlevel%==4 goto input
if %errorlevel%==7 (
	taskkill /f /fi "WINDOWTITLE eq !name!.exe"
	Taskkill /f /im cmd.exe /fi "Windowtitle ne %name_com% - Compile"
	taskkill /f /im "!name!.exe"
	del /f .%name_com%.un~
	del /f %name_com%~
	REM https://blog.csdn.net/leiyong0326/article/details/38334003
)
if %errorlevel%==6 echos 0x0c "---当前编译参数---" &echo;%com% "%input%" -o "%name%" %lwsock32% &set /p lwsock32=^>:
if %errorlevel%==5 set /p icon=请输入ico(路径)全名[可拖入]: &call :icon !icon!
if %errorlevel%==8 start cmd /c "modes 80 30 & location 1200 200 & vim.exe" %input%
if %errorlevel%==9 (
	set /p new_file=请输入新建文件名: 
	if "!new_file!"=="" goto :lip
	call :file-names "!new_file!" 
	start cmd /c "modes 80 20 & location 1800 200 & title !new_file! - editor &copy con !new_file!"
)
if %errorlevel%==10 start cmd /k " modes 80 20 & location 1200 200 & title Console ^< Terminal - Linux - wsl - bash ^> "
	
goto :lip
rem -----------------compile---------------(-static -libgcc -lgdi32 -fexec-charset=GBK)
:compile
echos 0x03 "正在编译[%name_com%]请稍候..."
%com% "%input%" -o "%name%" %lwsock32% && (  echos 0x0a ====编译成功==== & exit /b 1 ) || (  echos 0x0c ====编译失败==== & exit /b 0 )
goto :eof

:compile-tmp
echos 0x03 "正在编译[%name_com%]请稍候..."
%com% "%input%" -o "%tmp%\%name%" && (  echos 0x0a ====编译成功==== & exit /b 1 ) || (  echos 0x0c ====编译失败==== & exit /b 0 )
goto :eof

rem -----------------names------------------
:names
	if "%~x1" == ".cpp" (set "com=g++") Else (
			if /i "%~x1" == ".c" (set "com=gcc") Else ( exit /b 404 )
	)

	cd /d %~dp1
	title %~nx1 - Compile
	set "name_com=%~nx1"
	set "name=%~n1"
exit /b 1

rem ----------------file-names-------------------
:file-names
	if /i "%~x1" == ".cpp" (
		echo;#include ^<iostream^>>%1
		echo;using namespace std;>>%1
		echo;int main^(^)>>%1
		echo;{>>%1
		echo;	cout^<^<"hello world!"^<^<endl;>>%~1
		echo;	system^("pause"^);>>%1
		echo;	return 0;>>%1
		echo;}>>%1
	) Else (
		if /i "%~x1" == ".c" (
			echo;#include ^<stdio.h^>>%1
			echo;int main^(^)>>%1
			echo;{>>%1
			echo;	printf^("hello world!"^);>>%~1
			echo;	system^("pause"^);>>%1
			echo;	return 0;>>%1
			echo;}>>%1
		) Else ( goto :input )
	)
exit /b

rem ----------------------time_seconds_ms--------------------
:time_seconds_ms
modes 60 10
if exist "%~2.exe" (
	title %~2.exe
	path=E:\Desktop\CPP\mingw64-8.1.0-sjlj\bin;!path!
	set a=!time!
	call "%~2.exe"
	set b=!time!
) else (
	title 未找到[%~nx2] & modes 50 4
	choice /C "yn" /N /M "项目未编译,是否立即编译,y/n"
	if !errorlevel!==1 call :compile &pause
	if !errorlevel!==1 start cmd /c "modes 60 20& !time_start! time_seconds_ms !name!"
	exit
)

set /a h1=%a:~0,2%
set /a m1=1%a:~3,2%-100
set /a s1=1%a:~6,2%-100
set /a h2=%b:~0,2%
set /a m2=1%b:~3,2%-100
set /a s2=1%b:~6,2%-100
if %h2% LSS %h1% set /a h2=%h2%+24

if %h1% NEQ %h2% (
	set /a ts1=%h1%*3600+%m1%*60+%s1%
	set /a ts2=%h2%*3600+%m2%*60+%s2%
) else (
	if %m1% NEQ %m2% (
		set /a ts1=%m1%*60+%s1%
		set /a ts2=%m2%*60+%s2%
	) else (
		set /a ts1=%s1%
		set /a ts2=%s2%
	)
)

set /a ts=%ts2%-%ts1%
set ms_b=%a:~-2%
set ms_e=%b:~-2%
if %ms_e% lss %ms_b% set /a ms_e=%ms_e%+100
set /a ms_=%ms_e%-%ms_b%
rem ------------time_main------------
echo.
echos 0x08 -------------------------------
echos 0x08 Process exited after %ts%.%ms_% seconds with return value %errorlevel%
echos 0x08 请按任意键退出. . .
mshta vbscript:CreateObject("Wscript.Shell").AppActivate("%~nx2 - Compile")(window.close)
pause>nul
exit

:icon
echo A ICON %1 >prog.rc
windres -i prog.rc --input-format=rc -o prog.res -O coff
g++ -c -o prog.o "%input%"
g++ prog.o prog.res -o %name%.exe %lwsock32%
pause
del prog.rc prog.res prog.o
goto :eof

:exes
for %%i in ("%1") do (
	if /i "%%~xi" == ".exe" (
		start %time_start% time_seconds_ms "%%~ni"
		shift
		goto :exes
	) else (
		exit
	)
)
