@echo off
setlocal enabledelayedexpansion
set judge_project_name_error=REM
if "%~1"=="-p" (
	call :judge_java_home %2
	exit /b
) else if "%~1"=="-j" (
	if exist "%~2" (
		cd /d %2
	)
	call :compile_java !cd!
	exit /b
) else if "%~1"=="" (
	echo;Usage: %~n0 [drive:][path] [filename]
	echo;   or: %~n0 [-p] [drive:][path]
	echo;   or: %~n0 [-j] [path]
	echo;
	echo;Arguments:
	echo;   -p:   ���û�������
	echo;   -j:   ������Ŀ
	echo;         filename: Ҫ�����java�ļ���
	echo;         path: ��Ŀ·��,srcͬ��Ŀ¼
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
			echo;ERROR:�ļ�����
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
	echo;		System.out.println^("���,����"^);>>%1
	echo;	}>>%1
	echo;}>>%1
) else (
	echo;�ļ�������ȷ
)
popd
exit /b

:compile_java_tree
set FILE_NAME=0
for /f %%i in ('dir /b') do set /a FILE_NAME+=1
for /f %%i in ('dir /b') do (
	cd %%i 2>nul && (
		printf -n 07 !deep! "��   "
		echo;���� %%i
		set /a deep+=1
		call :compile_java_tree
	) || (
		printf -n 07 !deep! "��   "
		if "%%~xi"==".java" (
			findstr /C:"public static void main" %%i >nul && (
				set main_class=%%~pni
				set main_class_copy=%%~pni
				echo;���� %%i [main class]
			) || echo;���� %%i 
		) else echo;���� %%i
	)
)

set /a deep-=1
if "%cd%"=="%cds%" exit /b
cd..
exit /b

REM -----------
:compile_java <-j>
	set deep=0
	echo;
	echo;[%cd%]
	echo;
	set cds=%cd%
	set main_class=
	set FILE_NUM=0
call :compile_java_tree
echo;
if not exist "src\" (
	echo;  - Ŀ¼����
	exit /b
)
if "%main_class%"=="" (
	echo;  - δ�ҵ������
	exit /b
)


set cds=%cd:~2%\src\
set main_class=!main_class:%cds%=!


choice /M ". - �Ƿ����"
if errorlevel 2 goto :java_jar
echo;
if not exist target md target
for /r %%i in (*.java) do (
	if not "%%~pni"=="%main_class_copy%" (
		echo;  - %%~nxi
		javac -cp target "%%~i" -d target
	)
)
echo;
echo;$ javac -cp target src\%main_class%.java -d target
javac -cp target src\%main_class%.java -d target

:java_jar
set main_class=%main_class:\=.%
choice /M ". - �Ƿ���"
echo;
echo;[RUN CODE]$ java -cp target %main_class%
echo;
if errorlevel 2 (
	echo;[RUN CODE]$ java -jar %~n1.jar
	echo;
	echo;$ jar -cvf %~n1.jar -C target .
	echo;$ java -cp %~n1.jar %main_class%
	exit /b
)

(
echo;Manifest-Version: 1.0
echo;Main-Class: %main_class%
) >MANIFEST.MF
echo;$ jar -cvfm "%~n1.jar" MANIFEST.MF -C target .
echo;
jar -cvfm "%~n1.jar" MANIFEST.MF -C target .
echo;
echo;[RUN CODE]$ java -jar %~n1.jar
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
REM java -cp jar��; �ļ�
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
REM ----------------cpΪclasspath����д----------------
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
	echo;  - ���Ѿ������� %%JAVA_HOME%% ��������: %JAVA_HOME% 
	choice /N /M "--> �Ƿ�س���������[Y,N]?"
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
for /f "delims=" %%i in (pathr.tmp) do setx /M PATH "%%i%%JAVA_HOME%%\bin;%JRE_PATH%" >nul && echo;  + PATH ��ӳɹ�
del path*.tmp
set "JAVA_HOME=%cd%"
setx /M JAVA_HOME "%cd%" >nul && echo;  + JAVA_HOME ��ӳɹ�
setx /M CLASSPATH "%JAVA_CLASSPATH%" >nul && echo;  + CLASSPATH ��ӳɹ�
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
echo;  - [%cd%] ���� JAVA_HOME Ŀ¼
echo;  - Download: https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe
echo;  - ���� C:\Program Files\Java\jdk1.8.0_131
echo;  - ���� JAVA_HOME ��ַ ���� �Ѵ��ļ��ŵ� JAVA_HOME Ŀ¼��
:cds
set cds=
set /p "cds=--> ��ַ: "
if "%cds%"=="" exit /b 404
if exist "%cds%" ( cd /d %cds% ) else (  echo;  - [%cds%] ·�������� & goto :cds )
cls
goto :judge_java_home