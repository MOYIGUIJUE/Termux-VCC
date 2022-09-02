@echo off
if "%~1"=="-h" goto :help_main
set used=%USERNAME%
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do ( 
	call set used=%%used:%%i=%%i%%
)
cls
echo;
echo;^> gcc@3.4.0 serve
echo;
printf 0x10 " INFO "
echos 0x0b " Starting development server..."
printf 0x20 " DONE "
echos 0x02 " Already update in version 1.3.0"
echo;

echo;
echo;  Open sourse at:
printf 0x07 "  - Gitee: "
printf 0x03 https://gitee.com/cctv3058084277/main
echo;
printf 0x07 "  - Github: "
printf 0x03 https://gitee.com/cctv3058084277/main
echo;
echo;
printf 0x07 "  Press any key to show or run "
printf 0x03 "helps -h"
echo; to accelerate.
pause >nul
cls
echos 0x0e [0]��ʾ����
echo;
call :showcmd "topmost"
topmost.exe
call :showcmd "modes 89 22"
modes 89 22
call :showcmd "paths"
call paths
call :showcmd "vcc"
call vcc
call :showcmd "vcc -v"
call vcc -v
call :showcmd "vcc -h"
call vcc -h
call :showcmd "start .\Compile\Compile-include\tables"
start .\Compile\Compile-include\tables
call :showcmd "vcc -d"
call vcc -d
call :showcmd "com"
call com
call :showcmd "com 1.cpp"
call com 1.cpp
call :showcmd "com -c 1.cpp"
call com -c 1.cpp
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
call :showcmd "start doodle.hta"
start doodle.hta
call :showcmd "taskkill -f -im mshta.exe"
taskkill -f -im mshta.exe
call :showcmd "start cmd /c server 1234"
start cmd /c server 1234
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
call :showcmd "cls"
:help_main
cls
echos 0x0e [1]��װ��ȷ�ϰ�װ����(helps -h����ֱ����������)
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
echos 0x0e [7]Clearˢ��
echo;^> start https://gitee.com/cctv3058084277/main 
echo;	�鿴���������°汾
echo;^> clear
echo;	�ص���ʼ����
echo;^> exit /b	����	^> exit
echo;	�㷢�ִ˽̳̽�����,��ʾ����û����ɫ��
echo;	����������������������
echos 0x0e [8]������ͻ���������,�������ʿ�����һ��,��ESC����
echo;[����]�鷳û�����㣬�ͱ�ȥ�����鷳��
words "1. Never trouble trouble" "till" "trouble troubles you��"
echo;	                 ----
echo;	��һ���ĸ�trouble�Ƕ��ʣ��ڶ�������trouble�����ʡ�
echo;[��������]till
echo;	v.���������
echo;	prep.ֱ����Ϊֹ��ֱ�����š����ڡ�ǰ(����)
echo;	conj.ֱ����Ϊֹ���ڡ�֮ǰ
echo;	n.����̨�����ֽ���ɻ��ģ���Ǯ�ĳ���
echo;	����ֱ������Ϊֹ���������ԣ�����
echo;	�����˳Ƶ�����tills  ���ڷִʣ�tilling  ��ȥʽ��tilled  
echo;			--^> press any key to continue
pause >nul
echo;
echo;2. He never saw a saw saw a saw��
echo;	������û����һ�Ѿ��Ӿ���һ�Ѿ��ӡ�
echo;	��һ��saw�Ƕ���see�Ĺ�ȥʱ���ڶ��͵��ĸ�saw���в����ڴ�\"a\"��ǰ��������\"����\",������saw�Ƕ���\"��\"��
exit /b
REM echo;^> helps -
REM echo;	����copy con %tmp%\temp_cmd.bat
REM echo;	���Լ򵥿���дһ����������ִ��
REM echo;	ctrl+z�س�����
REM echo;	������ģ��mysql���������ģʽ,��⵽;����
REM echo;
REM set /p "tmpcmd=vcc_cmd> "
REM if "%tmpcmd%"=="" (
	REM set tmpcmd=
	REM set used=
	REM exit /b
REM )
REM echo;%tmpcmd% >>%tmp%\temp_cmd.bat

REM :vcc_cmd_home
REM printf 0x07 "      "
REM set /p "tmpcmd=-> "
REM echo;%tmpcmd% >>%tmp%\temp_cmd.bat
REM echo;%tmpcmd%|findstr ";" >nul && (
	REM call %tmp%\temp_cmd.bat
	REM del /f /q %tmp%\temp_cmd.bat
	REM set tmpcmd=
	REM set used=
	REM exit /b
REM )
REM goto :vcc_cmd_home

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

