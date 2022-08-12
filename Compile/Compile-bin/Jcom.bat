@echo off & setlocal enabledelayedexpansion
path=E:\Compile\Compile-bin;%path%
REM for %%i in (%upp_low:~0,1%:) do if %upp_low%:==%%~di (echo UPPER) else set "upp_low=%%~di"
if "%~1"=="" (
	echo;JCOM [drive:][path][filename]
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
if /i "%~x1" == ".java" (
	echo;public class %~n1 { >%1
	echo;	public static void main^(String[] args^){ >>%1
	echo;		System.out.println^("hello world"^);>>%1
	echo;	}>>%1
	echo;}>>%1
)
exit /b

:break
set break=
DIR >&0 2>NUL

:strcmp
set "str1=%~1"
set "str2=%~2"
if "!str1:%str2%=!"=="%str1%" (exit /b 0) else exit /b 1

:ren_public
if not "%~n2"=="%~1" ren %~2 %~1.java
REM echo;java %~dp2%1.java
REM java -cp jar包; 文件
java %~dp2%1.java
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

    
                                                               
             ,---._                                            
           .-- -.' \    ,---,                     ,---,        
           |    |   :  '  .' \            ,---.  '  .' \       
           :    ;   | /  ;    '.         /__./| /  ;    '.     
           :        |:  :       \   ,---.;  ; |:  :       \    
           |    :   ::  |   /\   \ /___/ \  | |:  |   /\   \   
           :         |  :  ' ;.   :\   ;  \ ' ||  :  ' ;.   :  
           |    ;   ||  |  ;/  \   \\   \  \: ||  |  ;/  \   \ 
       ___ l         '  :  | \  \ ,' ;   \  ' .'  :  | \  \ ,' 
     /    /\    J   :|  |  '  '--'    \   \   '|  |  '  '--'   
    /  ../  `..-    ,|  :  :           \   `  ;|  :  :         
    \    \         ; |  | ,'            :   \ ||  | ,'         
     \    \      ,'  `--''               '---" `--''           
      "---....--'                                              
                                                              