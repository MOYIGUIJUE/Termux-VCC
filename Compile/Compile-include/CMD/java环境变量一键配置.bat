@echo off
mshta vbscript:msgbox("请把bat文件放在JDK目录下执行,比如C:\Program Files\JDK\jdk-16.0.2下面，就是和bin同目录",4096,"JAVA环境变量配置")(window.close)
echo 请把bat文件放在JDK目录下执行,比如C:\Program Files\JDK\jdk-16.0.2下面，就是和bin同目录
echo 当前目录：%cd%
echo 按1退出，按2执行
choice /C "12" /N 
if %errorlevel%==2 goto next
exit
:next
::获取管理员权限方法一：
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
::保持当前目录下运行:
cd /d "%~dp0"

::后面是jdk安装路径，更改成自己的jdk安装路径

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