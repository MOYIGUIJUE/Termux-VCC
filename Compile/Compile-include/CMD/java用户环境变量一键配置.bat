@echo off & setlocal enabledelayedexpansion 
cd /d %~dp0 & title ��ǰ�ļ�Ŀ¼·��:[%~dp0]
echo;[1]�ж� %~dp0 �Ƿ�Ϊ JAVA_HOME Ŀ¼
if exist "%~dp0bin\java.exe" ( echo;  + %~dp0bin\java.exe ) else ( goto :error )
if exist "%~dp0bin\javac.exe" ( echo;  + %~dp0bin\javac.exe ) else ( goto :error )
if exist "%~dp0lib" ( echo;  + %~dp0lib ) else ( goto :error )
if exist "%~dp0jre\bin\java.exe" ( 
	echo;  - %~dp0jre\bin\java.exe & set "JRE_PATH=%%JAVA_HOME%%\jre\bin;" 
) else ( echo;  - JRE �����Ŀ¼���ڴ�Ŀ¼�� )
echo;
IF "%JAVA_HOME%"=="%cd%" (
	echo;  - ���Ѿ������� %%JAVA_HOME%% ��������: %JAVA_HOME% 
	echo;  - ���������������û���������
	choice /N /M "--> �Ƿ�س�����[Y,N]?"
	if errorlevel 2 goto :show
	pause >nul
)
echo;[2]����ȥ���ɵ�ϵͳpath�к���%%JAVA_HOME%%����

REG delete HKCU\Environment /v JAVA_HOME /f 2>nul>nul && echo;  - JAVA_HOME ɾ���ɹ�
REG delete HKCU\Environment /v CLASSPATH /f 2>nul>nul && echo;  - CLASSPATH ɾ���ɹ�

call :sourse_u
call :paths 
for /l %%i in (1,1,%num%) do (
	REM echo;[%%i]	!paths%%i!
	if not "!paths%%i!"=="" set "new_path=!new_path!!paths%%i!;"
)
REM echo;new_path:%new_path%
set "paths=%new_path%"
REG ADD HKCU\Environment /v PATH /t REG_SZ /d "%paths%" /f >nul && echo;  - PATH �޸ĳɹ�
echo;
echo;  - ����Ѿ�����ϵͳ���������������������û���������
pause >nul
echo;[3]��ӻ���������...&echo;

set "JAVA_HOME=%cd%"
REG ADD HKCU\Environment /v JAVA_HOME /t REG_SZ /d "%cd%" /f >nul && echo;  - JAVA_HOME ��ӳɹ�
REG ADD HKCU\Environment /v CLASSPATH /t REG_SZ /d ".;%JAVA_HOME%\lib" /f >nul && echo;  - CLASSPATH ��ӳɹ�
REG ADD HKCU\Environment /v PATH /t REG_SZ /d "%paths%%JAVA_HOME%\bin;%JRE_PATH%" /f >nul && echo;  - PATH ��ӳɹ�
echo;

REM -------------- TEST -------------

:show
echo;[4]�鿴���
echo;
echo;  - JAVA_HOME:	%JAVA_HOME%
echo;  - CLASSPATH:	%CLASSPATH%
echo;
echo;^> javac -version
javac -version
echo;
echo;^> java -version
java -version
echo;
echo;
echo;[5]�鿴PATH�û���������
echo;
call :sourse_u 
call :paths -
pause >nul
exit /b
REM ----------------------------------
pause >nul
exit /b

:error
echo;  - ��ǰ���� JAVA_HOME Ŀ¼
echo;  - -^> ��Ѵ��ļ��ŵ� JAVA_HOME Ŀ¼��
echo;  - ���� C:\Program Files\Java\jdk1.8.0_131
pause >nul
exit /b

REM --------------- paths ---------------
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