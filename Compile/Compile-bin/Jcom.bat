@echo off & setlocal enabledelayedexpansion
if "%~1"=="" (
	echo;JCOM [drive:][path][filename]
	echo;JCOM -p [drive:][path] 配置环境变量
	exit /b
)
if "%~1"=="-p" (
	call :judge_java_home %2
	exit /b
)
if not exist "%~1" goto :new_file
set break=0
for /f "usebackq tokens=1,2,3,*" %%i in ("%~1") do (
	echo;%%i %%j %%k %%l|findstr /i "public" >nul && call :ren_public %%~k "%~1"
	if !break! equ 404 call :break
)
exit /b

:new_file
if exist "%~1.java" (
	echo;java "%~1.java" [.java]
	java "%~1.java"
) else if exist "%~1.class" (
	echo;java %1 [.class]
	java %1
) else if /i "%~x1" == ".java" (
	echo;public class %~n1 { >%1
	echo;	public static void main^(String[] args^){ >>%1
	echo;		System.out.println^("hello world"^);>>%1
	echo;	}>>%1
	echo;}>>%1
) else (
	echo;文件名不正确
)
exit /b

:break
set break=
DIR >&0 2>NUL

REM :strcmp
REM set "str1=%~1"
REM set "str2=%~2"
REM if "!str1:%str2%=!"=="%str1%" (exit /b 0) else exit /b 1

:ren_public
if not "%~n2"=="%~1" ren %~2 %~1.java
REM echo;java %~dp2%1.java
REM java -cp jar包; 文件
if exist "%~dpn2.class" (
	echo;java %~n2 [class]
	java %~n2
) else (
	echo;java %~dp2%1.java [java]
	java %~dp2%1.java
)
set /a break=404
goto :eof

javac -cp e:/jdom.jar test1.java 
javac -cp d:\workspace\lib\commons-lang3-3.2.jar; StringUtilsTest.java
----------------cp为classpath的缩写----------------
java -cp d:\workspace\lib\commons-lang3-3.2.jar; StringUtilsTest
java -classpath e:/jdom.jar; test1
	REM set "JAVA_HOME=F:\JDK\jdk-16.0.2"
	REM set "CLASSPATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar"
	REM path=%path%;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin
	REM path=%path%;E:\MAIN\U-MAIN\MAIN\TOOL\apache-maven-3.8.4\bin

:judge_java_home
if exist "%~1" set "cd=%~1"
if exist "%cd%\bin\java.exe" ( echo;  + %cd%\bin\java.exe ) else ( goto :error )
if exist "%cd%\bin\javac.exe" ( echo;  + %cd%\bin\javac.exe ) else ( goto :error )
if exist "%cd%\lib" ( echo;  + %cd%\lib ) else ( goto :error )
if exist "%cd%\jre\bin\java.exe" (
	echo;  + %cd%\jre\bin\java.exe & set "JRE_PATH=%%JAVA_HOME%%\jre\bin;" 
) else ( echo;  - %cd%\jre\bin\java.exe )
echo;
IF "%JAVA_HOME%"=="%cd%" (
	echo;  - 你已经配置了 %%JAVA_HOME%% 环境变量: %JAVA_HOME% 
	choice /N /M "--> 是否回车覆盖配置[Y,N]?"
	if !errorlevel! equ 2 goto :show
)

:add_environment_variable
echo;

for /f "tokens=3* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path') do (
	if "%%j"=="" ( echo;%%i >path.tmp ) else echo;%%i %%j >path.tmp
)

type path.tmp | sed "s/\(.*\)\(.\)/\1\n/g" | sed "s/;/\n/g" | sed "/^$/d" >paths.tmp
timeout 1 >nul
for /f "delims=" %%i in (paths.tmp) do (
	echo;%%~i | find /i "%JAVA_HOME%">nul || set /p.=%%~i;<nul>>pathr.tmp
	if exist "%%~i" ( echo;  - %%i ) else echo;  - %%i [ERROR]
)
timeout 1 >nul
echo;
for /f "delims=" %%i in (pathr.tmp) do setx /M PATH "%%i%%JAVA_HOME%%\bin;%JRE_PATH%" >nul && echo;  + PATH 添加成功
del path*.tmp
set "JAVA_HOME=%cd%"
setx /M JAVA_HOME "%cd%" >nul && echo;  + JAVA_HOME 添加成功
setx /M CLASSPATH ".;%%JAVA_HOME%%\lib" >nul && echo;  + CLASSPATH 添加成功
echo;

:show
echo;  - JAVA_HOME:	%JAVA_HOME%
echo;  - CLASSPATH:	%CLASSPATH%
echo;&echo;^> javac -version
javac -version
echo;&echo;^> java -version
java -version
echo;
exit /b 404

:error
echo;  - [%cd%] 不是 JAVA_HOME 目录
echo;  - Download: https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe
echo;  - 例如 C:\Program Files\Java\jdk1.8.0_131
echo;  - 输入 JAVA_HOME 地址 或者 把此文件放到 JAVA_HOME 目录下
:cds
set cds=
set /p "cds=--> 地址: "
if "%cds%"=="" exit /b 404
if exist "%cds%" ( cd /d %cds% ) else (  echo;  - [%cds%] 路径不存在 & goto :cds )
cls
goto :judge_java_home