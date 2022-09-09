@echo off
if "%~1"=="-h" goto :help_main
set used=%USERNAME%
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do ( 
	call set used=%%used:%%i=%%i%%
)
Topmost
for /f %%i in ('CWnd find /!') do (
	CWnd Disable %%i min
	CWnd Disable %%i max
	CWnd Disable %%i close
)
cls
echo;
call vcc -v
echo;
printf 0x10 " INFO "
echo; To start: 820146120
printf 0x20 " DONE "
echo; On line: 235227728
echo;
echo;
echo;  Open sourse at:
printf 0x07 "  - Gitee: "
echos 0x0b https://gitee.com/cctv3058084277/main
printf 0x07 "  - Github: "
echos 0x0b https://github.com/MOYIGUIJUE/cctv
printf 0x07 "  - Thanks: "
echos 0x0b http://www.bathome.net
echo;
printf 0x07 "  Press any key to show or run "
printf 0x03 "helps -h"
echo; to accelerate.
echo;
printf 0x0e "  - "
set /p "choices="
if "%choices%"=="helps -h" goto :help_main
cmdow @ /DIS
cls
echos 0x0e [0]演示环节
echo;
call :showcmd "locations 50 3"
locations 50 3
call :showcmd "modes 89 22"
modes 90 30
call :showcmd "paths"
call paths

printf 0x0a %used%@%COMPUTERNAME%
printf 0x09 [%cd%]
printf 0x07 "$ "
timeout 1 >nul
printf -t 0x07 100 "path | sed \"s/;/\n/g\" | sed \"/^$/d\" | nl"
timeout 1 >nul
path | sed "s/;/\n/g" | sed "/^$/d" | nl

call :showcmd "vcc -v"
call vcc -v
call :showcmd "install -c"
call install -c
call :showcmd "colortype"
call colortype
echo;
call :showcmd "com -c"
call com -c
call :showcmd "start cmatrix"
start cmatrix
cmdow @ /ENA
call :showcmd "pause >nul"
pause >nul
call :showcmd "cls"
:help_main
set choices=
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
echo;	第一个saw是动词see的过去时，第二和第四个saw带有不定冠词\"a\"在前
echo;	是名词\"锯子\",第三个saw是动词\"锯\"。
echo;
cmdow @ /NOT
for /f %%i in ('CWnd find /!') do (
	CWnd enable %%i min
	CWnd enable %%i max
	CWnd enable %%i close
)
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

REM ----------------------------------------------help command----------------------------------------------

  REM - cmdow
  
执行cmdow @，显示为
Handle Lev Pid -Window status- Image Caption
0x230088 1 3356 Res Act Ena Vis cmd C:\WINDOWS\system32\cmd.exe - cmd - cm
window 指定要列出的窗口，使用窗口标题或句柄来指定，没有标题的用窗口类代替。如果没有指定则列出所有窗口。“@”表示此窗口，即命令行窗口。
/T 只列出任务栏的窗口
/B 如上面的例子，加这个参数则不显示第一行
/F 显示完整标题
/P 列出窗口位置、宽与高
另外
Handle 句柄，16进制格式
Window status 窗口状态（Minimized, Maximized, Restored, Active, Inactive, Enabled, Disabled, Visible or Hidden）

CMDOW /TH | /TV | /CW | /MA | /UW | /AT | /FS | /WM/TH 横向平铺窗口
/TV 纵向平铺窗口
/CW 层叠窗口
/MA 最小化所有窗口
/UW 取消/TH, /TV, /CW , /MA
/AT 相当与Alt+Esc
/FS 全屏命令行窗口，相当于Alt+Enter
/WM 取消全屏，即再按一次Alt+Enter

CMDOW window {[/ACT] [/INA] [/ENA] [/DIS] [/VIS] [/HID] [/MIN] [/MAX] [/RES] [/TOP] [/NOT] [/REN caption] [/MOV left top] [/SIZ width height] [/CLS] [/END]}/ACT 激活指定窗口
/INA 不知有啥用
/DIS 把窗口变为“只许看不准摸”：无法移动、鼠标左右键无效，更别说输入了。但可以用快捷键关闭。
/ENA 解除/DIS
/HID 隐藏窗口，任务栏和托盘皆看不到
/VIS 显示被隐藏的窗口
/MIN 最小化指定窗口
/MAX 最大化指定窗口
/RES 撤销。比如撤销到窗口原来的大小和位置。不能撤销两次，撤销后不可以返回撤销前的状态。
/TOP 置顶窗口。如置顶了多个，则第一个置顶在最上面，置顶了的都会保留置顶状态。
/NOT 取消窗口置顶
/REN caption 重命名窗口标题
/MOV left top 移动窗口 距左边距离 距上边距离
/SIZ width height 改变窗口宽、高
/CLS 关闭窗口
/END 结束进程。恐怖的是相同PID的会一起Kill掉，小心使用！

cmdow @ /siz 700 350

CMDOW /RUN [state] file [args]state 运行方式（/MIN /MAX /HID）

  REM - jpeg

-te <其他jpeg文件>
将其他jpeg文件的eixf导入目标jpeg。例如"jhead –te D:\My Pictures\B.jpg D:\My Pictures\A.jpg"

-dc
删除jpeg信息中的备注。注意，jpeg文件有两个备注，一是和其他文件一样的备注，另一个是exif信息中的备注。jhead仅对exif信息有效。
-de
完全删除exif信息。
-du
删除非原始exif信息，例如Photoshop、Turbophoto之类编辑后修改exif留下的信息。
-purejpg
删除所有jpeg文件非必须的信息。相当于-de、-dc和-du的集合，可以将文件减小数k。
-ce
修改文件的jpeg文件头部分备注（此备注并非exif信息）。该指令会打开文本编辑器，并在编辑器关闭时将备注信息存入文件。
-cs <文本文件>
导出备注。例如"jhead –cs D:\1.txt D:\My Pictures\A.jpg"
-ci <文本文件>
导入备注。例如"jhead –ci D:\1.txt D:\My Pictures\A.jpg"
-cl <备注文字>
直接输入备注。。例如"jhead –cl 我的备注 D:\My Pictures\A.jpg"
二、其他指令
时间日期
-ft 将jpeg文件的“修改时间”修改为exif信息中记录的时间。
-n[<格式-顺序>] 该指令会将文件名修改为exif信息中记录的“创建时间”；如果jpeg文件没有exif或者exif中的创建时间不可用，则将文件名修改为文件的“修改时间”。
默认的格式-顺序为MMDD-HHMMSS
格式-顺序参数如下：
%d-日(01-31)
%H-小时(00-23)
%j-一年中的第几天(001-366)
%m-月(01-12)
%M-分钟(00-59)
%S-秒(00-59)
%U-一年中的第几周(00-53)
%w-星期几(0-6，周日为0)
%y-两位数纪年(00-99)
%Y-四位数几年
%i-添加数字序号
例如：
jhead -n%Y%m%d-%H%M%S d:\*.jpg
将所有jpg文件修改为YYYYMMDD-HHMMSS.jpg的格式。 
-nf 与“-n”相同功能相同，不保留原文件名。 
-a 修改不同扩展名的同名文件名，相机拍摄的avi短片exif信息存储在与其同名的thm文件中，可用此指令给avi文件更名。一般与“-n”指令共同使用。 
-ta<时差> 修正时差，例如时差根据时区确定，例如+1:00或者-1:00 
-da<日期>-<日期> 修正日期。日期格式是yyyy:mm:dd、yyyy:nn:dd+hh:mm或者 yyyy:mm:dd+hh:mm:ss。根据前后参数时间差调整exif的时间。 
-ts<日期-时间> 直接修改exif中的拍摄时间，日期-时间格式为yyyy:mm:dd-hh:mm:ss 
缩略图

-dt 删除exif中的缩略图。这个缩略图一般为240x160像素，10k大小，用于数码相机、Windows XP查看照片，删除它不会影响工作。 
-st <文件名> 将exif中的缩略图复制为另一个jpeg文件 
-rt <文件名> 用另一个jpeg文件替换exif中的缩略图 
-rgt[大小] 刷新exif缩略图，其中大小为缩略图的最大边长。 
旋转
-autorot 根据exif中记录的水平方向信息转动jpeg照片。 
-norot 清除exif中的水平方向信息。 


  REM - nircmd
  
nircmd setdefaultsounddevice

弹出盘符为J的光驱    

NirCmd.exe cdrom open j:

弹入盘符为Y的光驱

nircmd.exe cdrom close y:

增加2000个单位的系统音量(最大65535)

nircmd.exe changesysvolume 2000

降低5000个单位的系统音量(最大65535)

nircmd.exe changesysvolume -5000

设置为最高音量

nircmd.exe setsysvolume 65535

设置为静音

nircmd.exe mutesysvolume 1

取消静音

nircmd.exe mutesysvolume 0

在静音与正常状态之间切换

nircmd.exe mutesysvolume 2

在桌面创建静音与正常状态切换命令的快捷方式

nircmd.exe cmdshortcut "~$folder.desktop$" "Switch Volume" mutesysvolume 2

关闭显示器

nircmd.exe monitor off

启动默认屏保

nircmd.exe screensaver

进入待机状态

nircmd.exe standby

注销当前用户

nircmd.exe exitwin logoff

弹出对话框，询问是否重启。选择是则重启电脑

nircmd.exe qboxcom "Do you want to reboot?" "question" exitwin reboot

关闭computers.txt中指定的所有计算机

multiremote copy "c:\temp\computers.txt" exitwin poweroff force

拨号连接到"My Internet"

nircmd.exe rashangup "My Internet"

设置IE窗口为75%透明度(192/256)

nircmd.exe win trans ititle "internet explorer" 192

最小化所有的IE窗口

nircmd.exe win min class "IEFrame"

关闭所有的IE窗口

nircmd.exe win close class "IEFrame"

关闭所有的资源管理器窗口(我的电脑、文件夹等)

nircmd.exe win close class "CabinetWClass"

隐藏所有的IE窗口

nircmd.exe win hide class "IEFrame"

显示所有的IE窗口(在用上面命令隐藏后)

nircmd.exe win show class "IEFrame"

把所有的顶级窗口居中

nircmd.exe win center alltop

去掉我的电脑窗口的标题栏

nircmd.exe win -style title "my computer" 0x00C0000

恢复我的电脑窗口的标题栏(当用上面命令去除后)

nircmd.exe win +style title "my computer" 0x00C0000

设置我的电脑窗口为从右至左的顺序(适用于希伯来语和阿拉伯语)

nircmd.exe win +exstyle title "my computer" 0x00400000

设置我的电脑窗口的所有子窗口为从右至左的顺序(适用同上)

nircmd.exe win child title "my computer" +exstyle all 0x00400000

在桌面创建可以关闭所有IE窗口的快捷方式

nircmd.exe cmdshortcut " "~$folder.desktop$ "Close All IE" win close class "IEFrame"

在桌面创建可以隐藏所有IE窗口的快捷方式

nircmd.exe cmdshortcut " "~$folder.desktop$ "Hide All IE" win hide class "IEFrame"

在桌面创建可以再次显示所有IE窗口的快捷方式

nircmd.exe cmdshortcut " "~$folder.desktop$ "Show All IE" win show class "IEFrame"

把calculator窗口设置为最上层窗口(在其他窗口之上)

nircmd.exe win settopmost title "Calculator" 1

恢复calculator窗口为原始窗口状态(不处于最上层)

nircmd.exe win settopmost title "Calculator" 0

创建calc.exe快捷方式到开始菜单->程序->Calculators

nircmd.exe shortcut "f:\winnt\system32\calc.exe" "~$folder.programs$\Calculators" "Windows Calculator"

隐藏桌面所有图标

nircmd.exe win hide class progman

显示桌面所有图标(用以上命令隐藏过后)

nircmd.exe win show class progman

隐藏系统开始按钮

nircmd.exe win child class "Shell_TrayWnd" hide class "button"

显示系统开始按钮

nircmd.exe win child class "Shell_TrayWnd" show class "button"

隐藏系统时间

nircmd.exe win child class "Shell_TrayWnd" hide class "TrayClockWClass"

显示系统时间

nircmd.exe win child class "Shell_TrayWnd" show class "TrayClockWClass"

终止所有IE实例

nircmd.exe killprocess iexplore.exe

创建桌面快捷方式，运行即可弹出光驱(K盘)

nircmd.exe cmdshortcut "~$folder.desktop$" "Open CDROM" cdrom open k:

将nirsoft网址创建到桌面快捷方式

nircmd.exe urlshortcut "http://www.nirsoft.net" "~$folder.desktop$" "NirSoft"

添加nirsoft网址到收藏夹\链接下

nircmd.exe urlshortcut "http://www.nirsoft.net" "~$folder.favorites$\Links" "NirSoft"

将nirsoft网址快捷方式创建到computers.txt中列出的所有计算机的桌面

nircmd.exe multiremote copy "c:\temp\computers.txt" urlshortcut "http://www.nirsoft.net" "~$folder.common_desktop$" "NirSoft"

设置显示模式为800X600，24位色

nircmd.exe setdisplay 800 600 24

将设置显示模式为800X600，24位色命令创建为桌面快捷方式

nircmd.exe cmdshortcut "~$folder.desktop$" "800x600x24" setdisplay 800 600 24

复制所有桌面快捷方式到其他文件夹(f:\temp\desktop)

nircmd.exe execmd copy "~$folder.desktop$\*.lnk" f:\temp\desktop

重启你的Apache server服务器(windows NT/2000/XP/2003)

nircmd.exe service restart apache

将重启Apache server服务器命令创建为桌面快捷方式

nircmd.exe cmdshortcut "~$folder.desktop$" "Restart Apache" service restart apache

重启IIS(互联网信息服务)

nircmd.exe service restart w3svc

重启MySql

nircmd.exe service restart MySql

打开指定注册表项/值

nircmd.exe regedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"

打开你在注册表编辑器中复制到剪切板的注册表项

nircmd regedit "~$clipboard$"

禁用屏保

nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 0

取消禁用屏保

nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 1

改变指定文件的日期/时间(创建时间和修改时间)

nircmd.exe setfiletime "c:\temp\myfile.txt" "24-06-2003 17:57:11" "22-11-2005 10:21:56"

复制桌面所在路径到剪切板

nircmd.exe clipboard set ~$folder.desktop$

复制开始菜单文件夹路径到剪切板

nircmd.exe clipboard set ~$folder.start_menu$

复制文本info1.txt中的内容到剪切板

nircmd.exe clipboard readfile "c:\My Files\info1.txt"

将剪切板中内容添加到文本info1.txt中

nircmd.exe clipboard addfile "c:\My Files\info1.txt"

清空剪切板

nircmd.exe clipboard clear

创建所有在"c:\temp\folders.txt"中指定的文件夹，文件夹路径名用回车符隔开

nircmd.exe paramsfile "c:\temp\folders.txt" "" "" execmd md ~$fparam.1$

安装所有在全局程序集缓存(GAC)中指定的.NET程序集

nircmd.exe gac install "C:\temp\MyAssembly\bin\MyAssembly.dll"

清空所有磁盘上的回收站

nircmd.exe emptybin

对一个标准的Windows信息框回复确认

nircmd.exe dlg "" "" click yes

延迟2秒钟，然后保存当前屏幕截图到shot.png

nircmd.exe cmdwait 2000 savescreenshot "f:\temp\shot.png"


cdrom open     cdrom close    cdrom open *:            cdrom close *:              monitor off
打开光驱           关闭光驱          打开指定光驱               关闭指定光驱                  关闭显示器

exitwin logoff       clipboard clear      screensaver     standby    exitwin logoff
注销                     清空剪贴板           运行屏保            待机         注销当前用户

exitwin poweroff       setdisplay 800 600 24
关闭计算机                设置显示器800×600像素 24位颜色

直接将系统音量调至最高
nircmd.exe setsysvolume 65535

clipboard readfile "c:\***\2123.txt"
将指定的文本文件的内容放入的剪切板

clipboard addfile "c:\***\2123.txt"
将剪切板内容追加到指定文本文本

infobox [message text] [title]
显示一个简单的消息框在屏幕上。
例子：infobox "内容" "标题"

shellcopy [source file or wildcard] [destination] {Flags}
文件复制
① yestoall 全是
② noerrorui 不显示错误用户界面信息
③ silent 安静模式-不显示文件复制进度
④ nosecattr 不要复制的安全属性的文件。
例子：
shellcopy "c:\temp\*.*" "d:\temp"
shellcopy "c:\temp\*.*" "d:\temp" yestoall noerrorui

filldelete [source file or wildcard]
彻底删除文件不放入回收站
例子：
① filldelete "C:\WINDOWS\*.log"
② filldelete "C:\1.dat"

infobox [message text] [title]
在屏幕上显示一个简单的信息框（！）
例子：infobox "提示" "标题"

qbox [message text] [title] [program to run]
显示一个问题对话框在屏幕上。如果用户回答" yes " ，运行程序
例子：qbox "确定运行计算器吗？" "提示" "calc.exe"

qboxtop [message text] [title] [program to run]
显示一个置顶问题对话框在屏幕上。如果用户回答" yes " ，运行程序
例子：qboxtop "确定运行计算器吗？" "提示" "calc.exe"

regedit [key] [value name]
打开注册表与指定的键/值。
例子：regedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"

regdelval [key] [value]
删除注册表值
例子：regdelval "HKEY_CURRENT_USER\Software\Test" "Value1"

regdelkey [key]
删除注册表键
例子：regdelkey "HKEY_CURRENT_USER\Software\Test"

禁用屏幕保护程序
nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 0

启用屏幕保护程序
nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 1

setcursor [X] [Y]
设置鼠标在屏幕位置
例子：setcursor 100 50

win settopmost title "计算器" 1         win settopmost title "计算器" 0
设置 Windows 计算器窗口置顶显示      取消 Windows 计算器窗口置顶显示

sendmouse [right|left|middle] [down|up|click|dblclick]
按鼠标键
例子：
① sendmouse right click 右键鼠标
② sendmouse left click  左键鼠标
③ sendmouse left dblclick 双击鼠标左键
④ sendmouse left down  按下鼠标左键
⑤ sendmouse left up  松开鼠标左键
⑥ sendmouse middle click

inisetval  inisetval [INI filename] [section] [key] [value]
写入值到 INI 文件. 如果文件不存在则将被自动创建.
如: inisetval "c:\windows\test.ini" "section1" "TestValue" "1"

inidelval  inidelval [INI filename] [section] [key]
删除 INI 文件中某个值.
如: inidelval "c:\windows\test.ini" "section1" "TestValue"

inidelsec  inidelval [INI filename] [section]
删除 INI 文件中某个区段及其所有的值.
如: inidelsec "c:\windows\test.ini" "section1"

regsvr  regsvr [reg or unreg] [filename or wildcard] {log file}
注册或解除注册 DLL/OCX 文件.
第一个参数指定 "reg" 则注册文件, "unreg" 解除注册文件.
第二个参数指定你要注册或解除注册的是单个文件还是多个文件, 支持通配符.
第三个参数是可选项, 指定是否输出操作记录.
如:
regsvr reg "f:\winnt\system32\fv*.ocx" "c:\temp\log1.txt"
regsvr unreg "f:\winnt\system32\ab*.dll"

regsetval [type] [key] [value name] [value]
设置或创建注册表值
例子：
regsetval dword "HKEY_CURRENT_USER\Software\Test" "Value1" "0xaabbccdd"
regsetval dword "HKCU\Software\Test" "Value2" "10561"
regsetval sz "HKCU\Software\Test" "Value3" "string value"
regsetval binary "HKLM\Software\Test" "Value4" "6a cb ab dd 80 86 95"

win [action] [find] [window to find] [Additional Parameters]
设置窗口
例子：
① win close title "无标题 - 记事本"  关闭指定窗口（比较精确匹配）
② win activate title "无标题 - 记事本"  激活指定窗口
③ win max title "无标题 - 记事本"  最大化指定窗口
④ win trans title "无标题 - 记事本" 80  透明化指定窗口（0-255，数字小越透明）
⑤ win center title "无标题 - 记事本"  绝对居中指定窗口
⑥ win close stitle "无标题"  关闭指定窗口（模糊匹配）

目录
~$folder.windows$  C:\Windows 目录
nir.exefile  当前运行的 NirCmd 所在的完整路径 (如: c:\winnt\nircmd.exe) 
folder.nircmd  当前运行的 NirCmd 所在的目录. 
folder.desktop  桌面目录. 
folder.start_menu  开始菜单目录. 
folder.programs  开始菜单程序组目录. 
folder.startup  "启动" 目录. 
folder.recent  最近打开文档目录. 
folder.favorites  收藏夹目录. 
folder.cookies  Cookies 目录. 
folder.appdata  用用程序数据目录. (如: C:\Documents and Settings\Administrator\Application Data) 
folder.common_desktop  公有桌面目录. 
folder.common_start_menu  公有开始菜单目录. 
folder.common_programs  公有开始菜单程序组目录. 
folder.common_startup  公有 "启动" 目录. 
folder.common_favorites  公有收藏夹目录. 
folder.windows  Windows 目录. (如: C:\Windows) 
folder.system  系统目录. (如: C:\Windows\System32) 

exec show "notepad.exe"
运行指定程序

shexec [operation] [filename]
对指定程序进行操作
例子：
① shexec "open" "c:\my documents\abc.doc"
② shexec "print" "d:\files\1.pdf"
③ shexec "open" "http://www.nirsoft.net"

urlshortcut "http://www.****.***" "~$folder.desktop$" "名称"
创建URL快捷方式到当前用户桌面

删除文件夹
execmd rd "~$folder.appdata$\PE Explorer"

建立文件夹
execmd md "~$folder.appdata$\PE Explorer"

sendkey 0x25 press      sendkey 0x27 press sendkey 0x26 press
光标左移  光标右移  光标上移
sendkey 0x28 press【光标下移】

0x1 鼠标左键
0x2 鼠标右键
0x8 BackSpace键
0x9 TAB键
0xD Enter键
0x11 Ctrl键
0x14 Caps Lock键
0x1B ESC键


按键：HANGEUL 0x15 /* old name - should be here for compatibility */
按键：HANGUL 0x15
按键：JUNJA 0x17
按键：FINAL 0x18
按键：HANJA 0x19
按键：KANJI 0x19
按键：ESCAPE 0x1B
按键：CONVERT 0x1C
按键：NONCONVERT 0x1D
按键：ACCEPT 0x1E
按键：MODECHANGE 0x1F
按键：SPACE 0x20
按键：PRIOR 0x21
按键：NEXT 0x22
按键：END 0x23
按键：HOME 0x24
按键：LEFT 0x25
按键：UP 0x26
按键：RIGHT 0x27
按键：DOWN 0x28
按键：Select 0x29
按键：PRINT 0x2A
按键：EXECUTE 0x2B
按键：SNAPSHOT 0x2C
按键：Insert 0x2D
按键：Delete 0x2E
按键：HELP 0x2F
/*按键：0 thru按键：9 are the same as ASCII '0' thru '9' (0x30 - 0x39) */
/*按键：A thru按键：Z are the same as ASCII 'A' thru 'Z' (0x41 - 0x5A) */
按键：左WIN 0x5B
按键：右WIN 0x5C
按键：SEPARATOR 0x6C
按键：SUBTRACT 0x6D
按键：DECIMAL 0x6E
按键：DIVIDE 0x6F
LButton 0x1 鼠标左键 RButton 0x2 鼠标右键
Cancel 0x3 CANCEL 键 MButton 0x4 鼠标中键
0x8 BACKSPACE 键 0x9 TAB 键
0xC CLEAR键  0xD ENTER 键
0x10 SHIFT键  0x11 CTRL 键
0x12 MENU键  0x13 PAUSE 键
0x14 CAPSLOCK 键 0x1B ESC 键
0x20 SPACEBAR 键 0x21 PAGE UP 键
0x22 PAGE DOWN 键 0x23 END 键
0x24 HOME 键
0x25 ← 键 0x26 ↑ 键 0x27 → 键 0x28 ↓ 键
0x29 SELECT 键  0x2A PRINT SCREEN 键
0x2B EXECUTE 键  0x2C SNAPSHOT 键
0x2D INSERT 键  0x2E DELETE 键
0x2F HELP 键  0x90 NUMLOCK 键
0x60 NUM(0) 键 0x61 NUM(1) 键 0x62 NUM(2) 键
0x63 NUM(3) 键 0x64 NUM(4) 键 0x65 NUM(5) 键
0x66 NUM(6) 键 0x67 NUM(7) 键 0x68 NUM(8) 键
0x69 NUM(9) 键 0x6A NUM(*) 键 0x6B NUM(+) 键
0x6C NUM(ENTER)键 0x6D NUM(-) 键
0x6E NUM(.) 键 0x6F NUM(/) 键
0x70 F1键 0x71 F2键 0x72 F3键 0x73 F4键
0x74 F5键 0x75 F6键 0x76 F7键 0x77 F8键
0x78 F9键 0x79 F10键 0x7A F11键 0x7B F12键
0x7C F13键 0x7D F14键 0x7E F15键 0x7F F16键