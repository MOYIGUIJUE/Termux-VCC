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
echos 0x0e [0]演示环节
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
call :showcmd "start cmd /c client %IPv4% 1234 1号客户"
start cmd /c client %IPv4% 1234 1号客户
call :showcmd "start cmd /c client %IPv4% 1234 2号客户"
start cmd /c client %IPv4% 1234 2号客户
call :showcmd "shutdown -s -t 100"
shutdown -s -t 100
call :showcmd "shutdown -a"
shutdown -a
echos 0x0e [提示]shutdown -p是马上关机,shutdown -a来不及
call :showcmd "shutdown -p"
echo;开个玩笑
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
echos 0x0e [1]安装及确认安装环境(helps -h可以直接跳到这里)
echo;^> install -vcc [path]
echo;	后面添加安装路径,或不添加弹出文件夹选择框
echo;	初次安装在弹出的管理员黑框中输入all,回车,关闭
echo;^> exec [path]
echo;	后面添加安装路径,这里包含3个注册项
echo;	gccpath、右键notepad++、右键termux
	call :command
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [2]编译第一个C/C++程序
echo;^> com 1.cpp 
echo;	1.cpp如不存在则会创建一个范例1.cpp
echo;	然后再次输入 com 1.cpp 就会编译
echo;^> com -c [path\filename]
echo;	后面添加文件名,如果不存在也会创建
echo;	不添加,将会有一个控制台界面可供选择
	call :command
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [3]打开cpp文件
echo;^> note 1.cpp 
echo;	会用notepad++打开1.cpp
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [4]查看帮助信息
echo;^> [command] {[--help][/?][-h][]}
echo;	command是命令,后面是常见的参数
echo;	本程序扩展命令大部分是不带参数显示帮助信息
echo;	比如ls --help 、dir /?、vcc 、cs -h
echo;^> ll
echo;	一般绿色是可执行文件,蓝色为文件夹
echo;	控制台原来的颜色为普通文件
	call :command
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [5]wsl/bash是windows自带的linux子系统
echo;^> bash
echo;	这里是使用ubantu系列
echo;^> wsl
echo;	这个和上面的命令一样
echo;	简单学习一下linux命令,写一些bash脚本
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [6]基本教程已经结束,下面是进阶玩法
echo;^> vcc -
echo;	进入扩展程序文件目录,输入ll查看可执行文件命令
echo;	这里的所有命令就是第二阶段的学习内容
echo;	最上层的termux.bat内还有一些宏命令
echo;	第三阶段就是DIY这个集合了
	call :command
	if errorlevel 404 ( cls ) else pause >nul &cls
echos 0x0e [7]Clear刷新
echo;^> start https://gitee.com/cctv3058084277/main 
echo;	查看并下载最新版本
echo;^> clear
echo;	回到初始界面
echo;^> exit /b	或者	^> exit
echo;	你发现此教程结束后,提示符又没有颜色了
echo;	你可以输入以上命令解锁它
echos 0x0e [8]到这里就基本结束了,下面的填词可以试一试,按ESC结束
echo;[翻译]麻烦没来找你，就别去自找麻烦。
words "1. Never trouble trouble" "till" "trouble troubles you。"
echo;	                 ----
echo;	第一、四个trouble是动词，第二、三个trouble是名词。
echo;[单词释意]till
echo;	v.耕作；犁地
echo;	prep.直到…为止；直到…才…；在…前(不…)
echo;	conj.直到…为止；在…之前
echo;	n.收银台；（现金出纳机的）放钱的抽屉
echo;	网络直到……为止；爱的誓言；耕种
echo;	第三人称单数：tills  现在分词：tilling  过去式：tilled  
echo;			--^> press any key to continue
pause >nul
echo;
echo;2. He never saw a saw saw a saw。
echo;	他从来没见过一把锯子锯另一把锯子。
echo;	第一个saw是动词see的过去时，第二和第四个saw带有不定冠词\"a\"在前，是名词\"锯子\",第三个saw是动词\"锯\"。
exit /b
REM echo;^> helps -
REM echo;	运用copy con %tmp%\temp_cmd.bat
REM echo;	可以简单快速写一点批处理当场执行
REM echo;	ctrl+z回车保存
REM echo;	下面是模仿mysql里面的输入模式,检测到;结束
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
	echos 0x06 [输入命令]
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

