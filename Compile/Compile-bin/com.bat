@echo off & setlocal enabledelayedexpansion
path=%~dp0..\..\FILE\bin;%path%
if "%1"=="-c" start cmd /c "%~dp0..\Com.bat" %2 %3 &exit /b
if "%1"=="time_seconds_ms" goto :%1
for %%i in ("%1") do ( if /i "%%~xi" == ".exe" call :time_seconds_ms 1 %%~ni &exit /b)
set "time_start=%~dpnx0"
if not "%~1" == "" (
	:main
	if "%~1"=="" exit /b
	call :names %1
	if !errorlevel! equ 404 echos 0x0c [%~nx1]����c/c++�ļ� &shift &goto :main
	shift
	goto main
) else (
	echo;Usage: com [name][.cpp/.c] ���Զ���ļ�
	echo;   or: com [name][.exe]
	echo;   or: com [arguments][-c] [name] ����Com.bat
	echo;   or: com ��������ʾ������Ϣ
	exit /b
)
rem --------------------compile--------------------
:compile
echos 0x03 ���ڱ���[%~nx1]���Ժ�...
echos 0x0e %com% "%~1" -o "%~n1"
%com% "%~1" -o "%~n1" && echos 0x0a ====����ɹ�==== || echos 0x0c ====����ʧ��====
goto :eof
rem ----------------names-----------------
:names
	if /i "%~x1" == ".cpp" (set "com=g++") Else (
		if /i "%~x1" == ".c" (set "com=gcc") Else ( exit /b 404 )
	)
	if not exist "%~1" (
		call :file-names %1
	) else (
		call :compile %1
	)
exit /b

rem ----------------file-names-------------------
:file-names
if /i "%~x1" == ".cpp" (
	echo;#include ^<iostream^>>%1
	echo;using namespace std;>>%1
	echo;int main^(int argc,char *argv[]^)>>%1
	echo;{>>%1
	echo;	cout^<^<"hello world!"^<^<endl;>>%~1
	echo;	return 0;>>%1
	echo;}>>%1
) Else if /i "%~x1" == ".c" (
		echo;#include ^<stdio.h^>>%1
		echo;#include ^<stdlib.h^>>>%1
		echo;int main^(^)>>%1
		echo;{>>%1
		echo;	printf^("hello world! \n"^);>>%~1
		echo;	return 0;>>%1
		echo;}>>%1
) Else ( echos 0x0c "����ʧ��,��������ȷ�ļ�����" & exit /b 404 )
exit /b
rem --------------------time_seconds_ms----------------------
:time_seconds_ms
if exist %2.exe (
	set a=!time!
	call %2.exe
	set b=!time!
) else (
	set /p "ch=��Ŀδ����,�Ƿ���������,y/n "
	if "!ch!" == "y" call :compile &pause
	exit /b
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
echo.&echo;-------------------------------
echo;Process exited after %ts%.%ms_% seconds with return value %errorlevel%