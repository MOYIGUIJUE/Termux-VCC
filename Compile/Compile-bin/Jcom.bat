@echo off
setlocal enabledelayedexpansion
if "%~1"=="-p" (
	call :judge_java_home %2
	exit /b
) else if "%~1"=="-j" (
	goto :java_jar
) else if "%~1"=="-jc" (
	goto :compile_java
) else if "%~1"=="-jr" (
	goto :run_compile_java
) else if "%~1"=="-ja" (
	goto :compile_java_jar
) else if "%~1"=="" (
	echo;Usage: %~n0 [drive:][path] [filename]
	echo;   or: %~n0 [-p] [drive:][path] 
	echo;   or: %~n0 {[-j][-jc]} [project_name] [package_name]
	echo;   or: %~n0 [-jr] [project_name] [main_class]
	echo;   or: %~n0 [-jar] [jar_name] [project_name] [main_class]
	echo;
	echo;Arguments:
	echo;   -p:   配置环境变量
	echo;   -j:   综合编译
	echo;   -jc:  编译
	echo;   -ja:  打包
	echo;   [project_name] 项目名程,src上层目录
	echo;   [package_name] 选择要编译的包 Eg: com.ch01.demo
	echo;   [main_class]   主类 EG: %~n0 -jr hello com.ch01.demo.main
	exit /b
) else (
	if exist "%~1" (
		pushd %~dp1
		if "%~x1"==".java" (
			if exist "%~n1.class" (
				java %~n1
			) else (
				javac %1
				java %~n1
			)
		) else if "%~x1"==".class" (
			java %~n1
		) else (
			echo;ERROR:文件类型
		)
		popd
		exit /b
	) else goto :new_file
)

:new_file
pushd %~dp1
if exist "%~1.class" (
	REM echo;java %~n1 [.class]
	java %~n1
) else if exist "%~1.java" (
	REM echo;javac "%~1.java" [.java]
	javac "%~1.java"
	java "%~n1"
) else if /i "%~x1" == ".java" (
	echo;public class %~n1 { >%1
	echo;	public static void main^(String[] args^){ >>%1
	echo;		System.out.println^("hello world"^);>>%1
	echo;		System.out.println^("你好,世界"^);>>%1
	echo;	}>>%1
	echo;}>>%1
) else (
	echo;文件名不正确
)
popd
exit /b

:java_jar
if "%~2"=="" (
	set /p project_name=项目名称: 
	if "!project_name!"=="" exit /b
) else (
	set "project_name=%~2"
)
if not exist "%project_name%" (
	echo;项目不存在，创建中...
	md %project_name% || ( echo;名称有误 & exit /b )
)

title %project_name%
cd /d %project_name%

if "%~3"=="" (
	set /p package_name=包名[com.main]:
) else set "package_name=%~3"
if not exist "%package_name:.=\%" (
	echo;包不存在
	exit /b
)

:start_Project
choice /C 1234 /N /M "[1]编译 [2]新建包 [3]打开项目"
if %errorlevel% EQU 1 goto :compile_java
if %errorlevel% EQU 2 goto :creat_package
if %errorlevel% EQU 3 goto :open_Project
if %errorlevel% EQU 4 goto :eof

exit /b

:open_Project
set /p project_name=项目路径:
if exist "%project_name%" ( title %project_name% ) else echo;项目不存在
goto :start_Project

:creat_package
set /p package_name=包名:
if not exist "%package_name:.=\%" md %package_name:.=\%
set /p main_class=新建主类[main]:
(
echo;package %package_name%;
echo;public class %main_class% {
echo;
echo;}
)>%package_name:.=\%\%main_class%.java
goto :start_Project

:compile_java
echo;javac -cp %project_name%\target %package_name%\*.java -d target
javac -cp %project_name%\target %package_name%\*.java -d target
exit /b

:run_compile_java
echo;java -cp %project_name%\target %main_class%
java -cp %project_name%\target %main_class%
exit /b


:compile_java_jar
REM jar -cvf my.jar -C target .
REM java -cp my.jar com.ch07.demo1.TestSound
(
echo;Manifest-Version: 1.0 
echo;Main-Class: %main_class%
) >MANIFEST.MF
jar -cvfm my.jar MANIFEST.MF -C target .
java -jar my.jar
exit /b



REM :break
REM set break=
REM DIR >&0 2>NUL

REM :strcmp
REM set "str1=%~1"
REM set "str2=%~2"
REM if "!str1:%str2%=!"=="%str1%" (exit /b 0) else exit /b 1

REM set break=0
REM for /f "usebackq tokens=1,2,3,*" %%i in ("%~1") do (
	REM echo;%%i %%j %%k %%l|findstr /i "public" >nul && echo;ren %%~k "%~1"
	REM if !break! equ 404 call :break
REM )
REM :ren_public
REM if not "%~n2"=="%~1" ren %~2 %~1.java
REM echo;java %~dp2%1.java
REM java -cp jar包; 文件
REM if exist "%~dpn2.class" (
	REM echo;java %~n2 [class]
	REM java %~n2
REM ) else (
	REM echo;java %~dp2%1.java [java]
	REM java %~dp2%1.java
REM )
REM set /a break=404
REM goto :eof

REM javac -cp e:/jdom.jar test1.java 
REM javac -cp d:\workspace\lib\commons-lang3-3.2.jar; StringUtilsTest.java
REM ----------------cp为classpath的缩写----------------
REM java -cp d:\workspace\lib\commons-lang3-3.2.jar; StringUtilsTest
REM java -classpath e:/jdom.jar; test1

	REM set "JAVA_HOME=F:\JDK\jdk-16.0.2"
	REM set "CLASSPATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar"
	REM path=%path%;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin
	REM path=%path%;E:\MAIN\U-MAIN\MAIN\TOOL\apache-maven-3.8.4\bin

:judge_java_home
if exist "%~1" ( set "cd=%~1" )
if exist "%cd%\bin\java.exe" ( echo;  + %cd%\bin\java.exe ) else ( goto :error )
if exist "%cd%\bin\javac.exe" ( echo;  + %cd%\bin\javac.exe ) else ( goto :error )
if exist "%cd%\lib" (
	if exist "%cd%\lib\tools.jar" ( echo;  + %cd%\lib\tools.jar & set "JAVA_CLASSPATH=.;%%JAVA_HOME%%\lib\dt.jar;%%JAVA_HOME%%\lib\tools.jar;" ) else (
		echo;  + %cd%\lib & set "JAVA_CLASSPATH=.;%%JAVA_HOME%%\lib;"
	)
) else ( goto :error )
if exist "%cd%\jre\bin\java.exe" (
	echo;  + %cd%\jre\bin\java.exe & set "JRE_PATH=%%JAVA_HOME%%\jre\bin;"
) else ( echo;  - %cd%\bin\jlink.exe --module-path jmods --add-modules java.desktop --output jre  )
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
setx /M CLASSPATH "%JAVA_CLASSPATH%" >nul && echo;  + CLASSPATH 添加成功
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