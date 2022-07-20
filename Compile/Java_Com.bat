@echo off & setlocal enabledelayedexpansion
if "%~1" == "new_file" goto :new_file
path=%~dp0Compile-bin;%path%
	REM set "JAVA_HOME=F:\JDK\jdk-16.0.2"
	REM set "CLASSPATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar"
	REM path=%path%;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin
	REM path=%path%;E:\MAIN\U-MAIN\MAIN\TOOL\apache-maven-3.8.4\bin
title Java_Compile
modes 70 17 & more +34 %0
path=C:\Program Files\MySQL\MySQL Server 8.0\bin;%path%
doskey new=call %0 new_file $*
prompt !used!@%COMPUTERNAME%$$$S
REM mysql -uroot -proot -Dtest < %1
mysql -uroot -proot
cmd /k
exit 

:new_file
if /i "%~x2" == ".java" (
	echo;public class %~n2 { >>%2 
	echo;	public static void main^(String[] args^){ >>%2
	echo;		System.out.println^("hello world"^);>>%2
	echo;	}>>%2
	echo;}>>%2
)
goto :eof
javac -cp e:/jdom.jar test1.java 
javac -cp d:\workspace\lib\commons-lang3-3.2.jar; StringUtilsTest.java
----------------cpÎªclasspathµÄËõÐ´----------------
java -cp d:\workspace\lib\commons-lang3-3.2.jar; StringUtilsTest
java -classpath e:/jdom.jar; test1

    
                                                               
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
                                                              