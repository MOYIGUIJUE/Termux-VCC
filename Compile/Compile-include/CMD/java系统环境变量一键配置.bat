@echo off & setlocal enabledelayedexpansion 
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&exit
cd /d %~dp0 & title 当前文件目录:[%~dp0]

echo;[判断 %~dp0 是否为 JAVA_HOME 目录] & call :judge_java_home
if %errorlevel% equ 404 exit /b
echo;[去除旧的系统path中含有%%JAVA_HOME%%的项，赋值系统path] & call :valuation
echo;[添加环境变量] & call :add_environment_variable
echo;[查看结果] & goto :show

:judge_java_home
if exist "%~dp0bin\java.exe" ( echo;  + %~dp0bin\java.exe ) else ( goto :error )
if exist "%~dp0bin\javac.exe" ( echo;  + %~dp0bin\javac.exe ) else ( goto :error )
if exist "%~dp0lib" ( echo;  + %~dp0lib ) else ( goto :error )
if exist "%~dp0jre\bin\java.exe" ( 
	echo;  - %~dp0jre\bin\java.exe & set "JRE_PATH=%%JAVA_HOME%%\jre\bin;" 
) else ( echo;  - JRE 虚拟机目录不在此目录下 )
echo;
IF "%JAVA_HOME%"=="%cd%" (
	echo;  - 你已经配置了 %%JAVA_HOME%% 环境变量: %JAVA_HOME% 
	choice /N /M "--> 是否回车覆盖配置[Y,N]?"
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
setx /M JAVA_HOME "%cd%" >nul && echo;  + JAVA_HOME 添加成功
setx /M CLASSPATH ".;%%JAVA_HOME%%\lib" >nul && echo;  + CLASSPATH 添加成功
setx /M PATH "%PATH%%%JAVA_HOME%%\bin;%JRE_PATH%" >nul && echo;  + PATH 添加成功
echo;
exit /b

:show
echo;  - JAVA_HOME:	%JAVA_HOME%
echo;  - CLASSPATH:	%CLASSPATH%
echo;&echo;^> javac -version
javac -version
echo;&echo;^> java -version
java -version
echo;&echo;[PATH系统环境变量]
echo;
call :sourse_s
call :paths -
echo;
pause >nul
exit /b

:error
echo;  - 当前不是 JAVA_HOME 目录
echo;  -^> 请把此文件放到 JAVA_HOME 目录下
echo;  - JDK下载地址: https://www.oracle.com/java/technologies/downloads/#license-lightbox
echo;  - Download: https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe
echo;  - 例如 C:\Program Files\Java\jdk1.8.0_131
pause >nul
exit /b 404

:paths
set num=0
if "%paths%"=="" echo;paths未赋值&exit /b
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