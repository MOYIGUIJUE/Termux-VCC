@echo off & setlocal enabledelayedexpansion 
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&exit
cd /d %~dp0 & title ��ǰ�ļ�Ŀ¼:[%~dp0]

echo;[�ж� %~dp0 �Ƿ�Ϊ JAVA_HOME Ŀ¼] & call :judge_java_home
if %errorlevel% equ 404 exit /b
echo;[ȥ���ɵ�ϵͳpath�к���%%JAVA_HOME%%�����ֵϵͳpath] & call :valuation
echo;[��ӻ�������] & call :add_environment_variable
echo;[�鿴���] & goto :show

:judge_java_home
if exist "%~dp0bin\java.exe" ( echo;  + %~dp0bin\java.exe ) else ( goto :error )
if exist "%~dp0bin\javac.exe" ( echo;  + %~dp0bin\javac.exe ) else ( goto :error )
if exist "%~dp0lib" ( echo;  + %~dp0lib ) else ( goto :error )
if exist "%~dp0jre\bin\java.exe" ( 
	echo;  - %~dp0jre\bin\java.exe & set "JRE_PATH=%%JAVA_HOME%%\jre\bin;" 
) else ( echo;  - JRE �����Ŀ¼���ڴ�Ŀ¼�� )
echo;
IF "%JAVA_HOME%"=="%cd%" (
	echo;  - ���Ѿ������� %%JAVA_HOME%% ��������: %JAVA_HOME% 
	choice /N /M "--> �Ƿ�س���������[Y,N]?"
	if errorlevel 2 goto :show 
	pause >nul
)
exit /b

:valuation
call :sourse_s
call :paths
for /l %%i in (1,1,%num%) do (
	REM echo;[%%i]	!paths%%i!
	if "!paths%%i:~-1!"=="\" set "paths%%i=!paths%%i:~0,-1!"
	if not "!paths%%i!"=="" set "new_path=!new_path!!paths%%i!;"
)
REM pause >nul
REM echo;new_path:%new_path%
PATH=%new_path%
exit /b

:add_environment_variable
echo;
set "JAVA_HOME=%cd%"
setx /M JAVA_HOME "%cd%" >nul && echo;  + JAVA_HOME ��ӳɹ�
setx /M CLASSPATH ".;%%JAVA_HOME%%\lib" >nul && echo;  + CLASSPATH ��ӳɹ�
setx /M PATH "%PATH%%%JAVA_HOME%%\bin;%JRE_PATH%" >nul && echo;  + PATH ��ӳɹ�
echo;
exit /b

:show
echo;  - JAVA_HOME:	%JAVA_HOME%
echo;  - CLASSPATH:	%CLASSPATH%
echo;&echo;^> javac -version
javac -version
echo;&echo;^> java -version
java -version
echo;&echo;[PATHϵͳ��������]
echo;
call :sourse_s
call :paths -
echo;
pause >nul
exit /b

:error
echo;  - ��ǰ���� JAVA_HOME Ŀ¼
echo;  -^> ��Ѵ��ļ��ŵ� JAVA_HOME Ŀ¼��
echo;  - JDK���ص�ַ: https://www.oracle.com/java/technologies/downloads/#license-lightbox
echo;  - Download: https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe
echo;  - ���� C:\Program Files\Java\jdk1.8.0_131
pause >nul
exit /b 404

:paths
set num=0
if "%paths%"=="" echo;pathsδ��ֵ&exit /b
set paths=%paths:;=" "%
if "%~1"=="-" ( call :loop_show "%paths%" ) else call :loop "%paths%"
exit /b

:loop_show
	set tmps=%1
	if not defined tmps exit /b
	if "%~1"=="" (
		shift
		goto :loop
	)
	set /a num+=1
	echo;  -	%~1[%num%]
	shift
goto :loop_show

:loop
	set tmps=%1
	if not defined tmps exit /b
	if "%~1"=="" (
		shift
		goto :loop
	)
	set /a num+=1
	REM echo;[%num%]	%~1
	echo;%~1|find /i "%JAVA_HOME%" >nul && echo;  - Delete %~1 || set "paths%num%=%~1"
	shift
goto :loop
REM -----------------------------------
:sourse_u
for /f "tokens=3* delims= " %%i in ('reg query HKCU\Environment /v path') do (
	if "%%j"=="" ( set "paths=%%i" ) else set "paths=%%i %%j"
	exit /b
)

:sourse_s
for /f "tokens=3* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
	if "%%j"=="" ( set "paths=%%i" ) else set "paths=%%i %%j"
	exit /b
)

:sourse
for /f "tokens=3* delims= " %%i in ('reg query HKCU\Environment /v path') do (
	for /f "tokens=3* delims= " %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
		if "%%j"=="" ( set "path_user=%%i" ) else set "path_user=%%i %%j"
		if "%%b"=="" ( set "path_sys=%%a" ) else set "path_sys=%%a %%b"
		set "paths=!path_user!!path_sys!"
		exit /b
	)
)