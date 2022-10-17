@echo off & setlocal enabledelayedexpansion
title Compile
path=%~dp0Compile-bin\Sourse Com;%path%
path=%~dp0Compile-bin;%path%
set LANG=zh_CN
set path_tmp=%path%
set "gcc-v=%~dp0..\..\FILE\bin"
path=%gcc-v%;%path%
set "local_path=%~dp0"
modes 55 9
if /i "%~x1" == ".exe" start time_start %1 &exit

if "%~x1" == ".ico" ( 
	call icon %2 %1 
	call :names %2 
	goto lip
) Else if "%~x2" == ".ico" (
	call icon %1 %2
	call :names %1
	goto lip
) 

if not "%~1" == "" (
	:loop
	if not exist "%~1" (
		echo;δ�ҵ�ָ���ļ�,����%1��...
		call file_name "%~1"
		if !errorlevel! equ 404 echos 0x0e [%~nx1]���ǿɱ����ļ� &exit /b
		echos 0x0e �����ɹ�
		call :names %1
		pause
		goto lip
	)
	call :names %1
	if !errorlevel! equ 404 echos 0x0e [%~nx1]���ǿɱ����ļ� &exit /b
	if "%~2"=="" goto lip
	call compile %1
	echo. & shift & goto loop
) else (
	cd /d %~dp0Home
	:input
	REM cls
	printf 0x0a vcc@COM-FIRST
	printf 0x09 [!cd!]
	echo;$ ll !cd!
	ls --color=auto !cd!
	echo;
	echos 0x0c ������ֻ֧��.c��.cpp�����ļ��ı���
	set input=
	set /p "input=������������ļ���:"
	if "!input!"=="" (
		call choose input
		if "!input!"=="" (
			echos 0x0c δѡ���ļ�
			exit /b
		)
	)
	set "input=!input:"=!"
	if not exist "!input!" (
		echo;δ�ҵ�ָ���ļ�,����!input!��...
		call file_name "!input!"
		if !errorlevel! equ 404 pause&goto :input
		echos 0x0e �����ɹ�
		pause
	)
	call :names "!input!"
	if !errorlevel! equ 404 pause&goto :input
)

:lip 
cls & call menu
choice /C 1234567QWE /N
if %errorlevel%==1 cls & call compile "%input%" & if !errorlevel! equ 1 (
	start time_start "%input%" & pause & goto lip 
) else ( pause & goto lip ) 
if %errorlevel%==3 start time_start "%input%" & goto lip
if %errorlevel%==2 cls & call compile "%input%" & pause & goto lip
if %errorlevel%==4 set input=& goto input
if %errorlevel%==7 (
	taskkill /f /fi "WINDOWTITLE eq !name!.exe"
	Taskkill /f /im cmd.exe /fi "Windowtitle ne %name_com% - Compile"
	taskkill /f /im "!name!.exe"
	goto lip
)
if %errorlevel%==5 (
	cls
	set icon=
	set /p icon=������icoȫ��[������]:
	if "!icon!"=="" call choose icon
	if "!icon!"=="" goto lip
	call icon "%input%" "!icon!" 
	goto lip
)
if %errorlevel%==6 (
	cls
	set /p new_file=�������½��ļ���: 
	if "!new_file!"=="" goto lip
	set /p=<nul>"!new_file!"
	goto lip
)
if %errorlevel%==8 start cmd /c "%local_path%..\Termux.bat" &goto lip
if %errorlevel%==9 (
	cls 
	echo;[ -lwsock32 -static -libgcc -lgdi32 -m64 ]
	echo;[ -fexec-charset=GBK -mwindows ����ʾ����̨ ]
	echo;[ gcc -shared -o export.dll export.c ]
	echo;[ gcc -o main.exe main.c -L./ -lexport ]
	echo;&echo;��ǰ�������:%lwsock32% &echo;&set /p lwsock32=�������µı������:
	goto lip
)

if "%errorlevel%"=="10" (
	cls & echos 0x03 ��ǰʹ�õ�gcc·��:
	echos 0x0e %gcc-v%
	echo;
	echo;[1] %~dp0Compile-include\BIN
	echo;[2] E:\Desktop_copy\CPP\mingw64-8.1.0-seh\bin
	echo;[3] E:\MAIN\U-MAIN\MAIN\C++\MinGW64-4.9.2\bin
	echo;
	set "gcc-v-1=%~dp0Compile-include\BIN"
	set "gcc-v-2=E:\Desktop_copy\CPP\mingw64-8.1.0-seh\bin"
	set "gcc-v-3=E:\MAIN\U-MAIN\MAIN\C++\MinGW64-4.9.2\bin"
	set /p gcc-v=�������µ�gcc·��:
	if "!gcc-v!" == "1" set gcc-v=!gcc-v-1!
	if "!gcc-v!" == "2" set gcc-v=!gcc-v-2!
	if "!gcc-v!" == "3" set gcc-v=!gcc-v-3!
	set path=!path_tmp!
	path=!gcc-v!;!path!
)
goto lip

:names
	if /i "%~x1" == ".cpp" (
		call :write "%~1"
	) Else if /i "%~x1" == ".c" (
		call :write "%~1"
	) Else (
		echos 0x0c "��������ȷ�ļ�����" 
		exit /b 404 
	)
	exit /b 1

:write
	cd /d "%~dp1"
	set "input=%~1"
	title %~nx1 - Compile
	set "name_com=%~nx1"
	set "name=%~n1"
goto :eof