@echo off
mshta vbscript:msgbox("���bat�ļ�����JDKĿ¼��ִ��,����C:\Program Files\JDK\jdk-16.0.2���棬���Ǻ�binͬĿ¼",4096,"JAVA������������")(window.close)
echo ���bat�ļ�����JDKĿ¼��ִ��,����C:\Program Files\JDK\jdk-16.0.2���棬���Ǻ�binͬĿ¼
echo ��ǰĿ¼��%cd%
echo ��1�˳�����2ִ��
choice /C "12" /N 
if %errorlevel%==2 goto next
exit
:next
::��ȡ����ԱȨ�޷���һ��
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
::���ֵ�ǰĿ¼������:
cd /d "%~dp0"

::������jdk��װ·�������ĳ��Լ���jdk��װ·��

setx /M JAVA_HOME "%cd%"
setx /M CLASSPATH ".;%%JAVA_HOME%%\lib\dt.jar;%%JAVA_HOME%%\lib\tools.jar"
setx /M PATH "%PATH%;%%JAVA_HOME%%\bin;%%JAVA_HOME%%\jre\bin"
echo on
echo %path%
javac -version
java -version
pause
echo.------------------------
exit
JAVA_HOME
CLASSPATH
.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;