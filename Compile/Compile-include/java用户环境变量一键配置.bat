@echo off & setlocal enabledelayedexpansion 
cd /d %~dp0 & title 当前文件目录路径:[%~dp0]
echo;[1]判断 %~dp0 是否为 JAVA_HOME 目录
if exist "%~dp0bin\java.exe" ( echo;  + %~dp0bin\java.exe ) else ( goto :error )
if exist "%~dp0bin\javac.exe" ( echo;  + %~dp0bin\javac.exe ) else ( goto :error )
if exist "%~dp0lib" ( echo;  + %~dp0lib ) else ( goto :error )
if exist "%~dp0jre\bin\java.exe" ( 
	echo;  - %~dp0jre\bin\java.exe & set "JRE_PATH=%%JAVA_HOME%%\jre\bin;" 
) else ( echo;  - JRE 虚拟机目录不在此目录下 )
echo;
IF "%JAVA_HOME%"=="%cd%" (
	echo;  - 你已经配置了 %%JAVA_HOME%% 环境变量: %JAVA_HOME% 
	echo;  - 不建议你再配置用户环境变量
	choice /N /M "--> 是否回车配置[Y,N]?"
	if errorlevel 2 goto :show
	pause >nul
)
echo;[2]正在去除旧的系统path中含有%%JAVA_HOME%%的项

REG delete HKCU\Environment /v JAVA_HOME /f 2>nul>nul && echo;  - JAVA_HOME 删除成功
REG delete HKCU\Environment /v CLASSPATH /f 2>nul>nul && echo;  - CLASSPATH 删除成功

call :sourse_u
call :paths 
for /l %%i in (1,1,%num%) do (
	REM echo;[%%i]	!paths%%i!
	if not "!paths%%i!"=="" set "new_path=!new_path!!paths%%i!;"
)
REM echo;new_path:%new_path%
set "paths=%new_path%"
REG ADD HKCU\Environment /v PATH /t REG_SZ /d "%paths%" /f >nul && echo;  - PATH 修改成功
echo;
echo;  - 如果已经配置系统环境变量不建议再配置用户环境变量
pause >nul
echo;[3]添加环境变量中...&echo;

set "JAVA_HOME=%cd%"
REG ADD HKCU\Environment /v JAVA_HOME /t REG_SZ /d "%cd%" /f >nul && echo;  - JAVA_HOME 添加成功
REG ADD HKCU\Environment /v CLASSPATH /t REG_SZ /d ".;%JAVA_HOME%\lib" /f >nul && echo;  - CLASSPATH 添加成功
REG ADD HKCU\Environment /v PATH /t REG_SZ /d "%paths%%JAVA_HOME%\bin;%JRE_PATH%" /f >nul && echo;  - PATH 添加成功
echo;

REM -------------- TEST -------------

:show
echo;[4]查看结果
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
echo;[5]查看PATH用户环境变量
echo;
call :sourse_u 
call :paths -
pause >nul
exit /b
REM ----------------------------------
pause >nul
exit /b

:error
echo;  - 当前不是 JAVA_HOME 目录
echo;  - -^> 请把此文件放到 JAVA_HOME 目录下
echo;  - 例如 C:\Program Files\Java\jdk1.8.0_131
pause >nul
exit /b

REM --------------- paths ---------------
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