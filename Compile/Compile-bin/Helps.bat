@echo off
title VCCʹ����
modes 70 15
if "%~1"=="-" goto :tmpcmd
set used=%USERNAME%
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do ( 
	call set used=%%used:%%i=%%i%%
)
cls

echos 0x0e [0]��ʾ����
echo;
call :showcmd "topmost"
topmost.exe
call :showcmd "vcc"
call vcc
call :showcmd "vcc -d"
call vcc -d
call :showcmd "vcc -v"
call vcc -v
call :showcmd "com"
call com
call :showcmd "com 1.cpp"
call com 1.cpp
call :showcmd "type 1.cpp"
type 1.cpp
call :showcmd "com 1.cpp"
call com 1.cpp
call :showcmd "1.exe"
1.exe
call :showcmd "del 1.cpp"
del 1.cpp
call :showcmd "del 1.exe"
del 1.exe
call :showcmd "colortype"
call colortype
echo;
call :showcmd "start cmatrix"
start cmatrix
call :showcmd "taskkill -f -im cmatrix.exe"
taskkill -f -im cmatrix.exe
call :showcmd "start doodle.hta"
start doodle.hta
call :showcmd "taskkill -f -im mshta.exe"
taskkill -f -im mshta.exe
call :showcmd "start cmd /c server 1234"
start cmd /c server 1234
call :showcmd "modes 85 15"
modes 85 15
call :showcmd "start cmd /c client %IPv4% 1234 1�ſͻ�"
start cmd /c client %IPv4% 1234 1�ſͻ�
call :showcmd "start cmd /c client %IPv4% 1234 2�ſͻ�"
start cmd /c client %IPv4% 1234 2�ſͻ�
call :showcmd "shutdown -s -t 100"
shutdown -s -t 100
call :showcmd "shutdown -a"
shutdown -a
echos 0x0e [��ʾ]shutdown -p�����Ϲػ�,shutdown -a������
call :showcmd "shutdown -p"
echo;������Ц
REM call :showcmd "start Desk_API"
REM start Desk_API
REM call :showcmd "taskkill -f -im Desk_API.exe"
REM taskkill -f -im Desk_API.exe

REM call :showcmd "taskkill -f -im explorer.exe"
REM taskkill -f -im explorer.exe
REM call :showcmd "start explorer.exe"
REM start explorer.exe
call :showcmd "pause"
pause
call :showcmd "mode 70,15"
mode 70,15
call :showcmd "cls"
cls
echos 0x0e [1]��װ��ȷ�ϰ�װ����
echo;^> install -vcc [path]
echo;	������Ӱ�װ·��,����ӵ����ļ���ѡ���
echo;	���ΰ�װ�ڵ����Ĺ���Ա�ڿ�������all,�س�,�ر�
echo;^> exec [path]
echo;	������Ӱ�װ·��,�������3��ע����
echo;	gccpath���Ҽ�notepad++���Ҽ�termux
	call :command
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [2]�����һ��C/C++����
echo;^> com 1.cpp 
echo;	1.cpp�粻������ᴴ��һ������1.cpp
echo;	Ȼ���ٴ����� com 1.cpp �ͻ����
echo;^> com -c [path\filename]
echo;	��������ļ���,���������Ҳ�ᴴ��
echo;	�����,������һ������̨����ɹ�ѡ��
	call :command
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [3]��cpp�ļ�
echo;^> note 1.cpp 
echo;	����notepad++��1.cpp
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [4]�鿴������Ϣ
echo;^> [command] {[--help][/?][-h][]}
echo;	command������,�����ǳ����Ĳ���
echo;	��������չ����󲿷��ǲ���������ʾ������Ϣ
echo;	����ls --help ��dir /?��vcc ��cs -h
echo;^> ll
echo;	һ����ɫ�ǿ�ִ���ļ�,��ɫΪ�ļ���
echo;	����̨ԭ������ɫΪ��ͨ�ļ�
	call :command
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [5]wsl/bash��windows�Դ���linux��ϵͳ
echo;^> bash
echo;	������ʹ��ubantuϵ��
echo;^> wsl
echo;	��������������һ��
echo;	��ѧϰһ��linux����,дһЩbash�ű�
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [6]�����̳��Ѿ�����,�����ǽ����淨
echo;^> vcc -
echo;	������չ�����ļ�Ŀ¼,����ll�鿴��ִ���ļ�����
echo;	���������������ǵڶ��׶ε�ѧϰ����
echo;	���ϲ��termux.bat�ڻ���һЩ������
echo;	�����׶ξ���DIY���������
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [7]SHOW TIME
echo;^> helps -
echo;	����copy con %tmp%\temp_cmd.bat
echo;	���Լ򵥿���дһ����������ִ��
echo;	ctrl+z�س�����
echo;	������ģ��mysql���������ģʽ,��⵽;����
echo;
set /p "tmpcmd=vcc_cmd> "
if "%tmpcmd%"=="" (
	set tmpcmd=
	set used=
	exit /b
)
echo;%tmpcmd% >>%tmp%\temp_cmd.bat

:vcc_cmd_home
printf 0x07 "      "
set /p "tmpcmd=-> "
echo;%tmpcmd% >>%tmp%\temp_cmd.bat
echo;%tmpcmd%|findstr ";" >nul && (
	call %tmp%\temp_cmd.bat
	del /f /q %tmp%\temp_cmd.bat
	set tmpcmd=
	set used=
	exit /b
)
goto :vcc_cmd_home

exit /b
:command
	echos 0x06 [��������]
	printf 0x0a %used%@%COMPUTERNAME%
	printf 0x09 [%cd%]
	set /p "comd=$ "
	if not defined comd exit /b 404
	call %comd%
	set comd=
exit /b


:showcmd
printf 0x0a %used%@%COMPUTERNAME%
printf 0x09 [%cd%]
printf 0x07 "$ "
timeout 1 >nul
printf -t 0x07 100 "%~1"
timeout 1 >nul
echo;
exit /b

:tmpcmd
copy con %tmp%\temp_cmd.bat >nul
call %tmp%\temp_cmd.bat
del /f /q %tmp%\temp_cmd.bat
exit /b