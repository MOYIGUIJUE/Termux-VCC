@echo off & title 
For %%i in (- / \) Do (
	If /i "%1"=="%%ih" Goto :helps
)
if not "%~1"=="" (
	for /f "delims=:" %%a in ('findstr /n "helps_%1.*$" %~fs0') do (
		REM echo;sed -n "%%a,4p" "%~fs0"
		echo;[more +%%a %~f0]
		more +%%a "%~fs0"
	)
	exit /b
)
set used=%USERNAME%
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
	call set used=%%used:%%i=%%i%%
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
echo;  Open sourse at:
printf 0x07 "  - Gitee: "
echos 0x0b https://gitee.com/cctv3058084277/main
printf 0x07 "  - Github: "
echos 0x0b https://github.com/MOYIGUIJUE/cctv
echo;
printf 0x07 "  Press any key to show or run "
Call :SetConsoleTextAttributeEx 4
set /p .=helps -h<nul
Call :SetConsoleTextAttributeEx 5
echo; to accelerate.
echo;
CmdMenuSel 0708 "  - CONTINUE" "  - HELP" "  - QUIT"
if %errorlevel% equ 2 goto :helps
if %errorlevel% equ 3 exit /b
cls
echo;  ^< 目录 ^>
echo;
CmdMenuSel 0708 "  - 第一章 安装和使用" "  - 第二章 基础教程" "  - 第三章 进阶教程" "  - 第四章 了解本外部命令集合" "  - 第五章 外部命令" "  - 第六章 编写外部命令"
cls
goto :book_%errorlevel%

:book_1
gotoxy -l 0 0
echo;  - 第一章 安装和使用
echo;
echo;  - 就这样,再那样,学会了吧,点击确定后
echo;  - 右下角托盘处会有一个图标,右键点击quit退出
length "确定"
call :mouse 40 7 %errorlevel% 7 70 "确定" 1
if %errorlevel% EQU 1 goto :TimeMain
goto :book_1

:mouse <X> <Y> <EX> <EY> <color> <str> <RE>
set /a X=%1
set /a Y=%2
set /a EX=%3+%1
set /a EY=%4

gotoxy -l %X% %Y%
echos 0x%5 %6

for /f "tokens= 1,2,3 delims= " %%i in ('Mouse.exe') do (
	set MX=%%k
	set MY=%%j
)
REM echo;[%X%,%Y%,%EX%,%EY%]
if %MX% GEQ %X% if %MX% LEQ %EX% if %MY% GEQ %Y% if %MY% LEQ %EY% exit /b %7
exit /b 0

:book_2
echo;  - 第二章 基础教程

call :showcmd "paths"
call paths
printf 0x0a %used%@%COMPUTERNAME%
printf 0x09 [%cd%]
printf 0x07 "$ "
timeout 1 >nul
printf -t 0x07 100 "path | sed \"s/;/\n/g\" | sed \"/^$/d\" | nl"
timeout 1 >nul
call :Type "  - 查看环境变量"
path | sed "s/;/\n/g" | sed "/^$/d" | nl

exit /b

:book_3
echo;  - 第三章 进阶教程
	For /L %%I in (0,16,255) Do (
		For /L %%J in (0,16,255) Do (
			For /L %%K in (0,16,255) Do (
				Call :SetConsoleTextAttribute %%I-%%J-%%K %%I-%%J-%%K
				Set /P=#< Nul
			)
		)
	)
exit /b

:book_4
call :game_loop
cls
echo;  - 第四章 了解本外部命令集合
echo;
echo;[翻译] 麻烦没来找你，就别去自找麻烦。  - 按ESC跳过
echo;[提示] 第一、四个trouble是动词，第二、三个trouble是名词。
words "[-] Never trouble trouble" "till" "trouble troubles you。"
echo;	                  ----
echo;[单词释意]till
echo;	v.耕作；犁地
echo;	prep.直到…为止；直到…才…；在…前(不…)
echo;	conj.直到…为止；在…之前
echo;	n.收银台；（现金出纳机的）放钱的抽屉
echo;	网络直到……为止；爱的誓言；耕种
echo;	第三人称单数：tills  现在分词：tilling  过去式：tilled
exit /b

:book_5
echo;  - 第五章 外部命令
call :showcmd "start cmatrix"
start cmatrix.exe
echo;  - 启动数字雨程序
call :showcmd "zms"
sleep 2000
zms.exe
echo;  - 设置为Progman子窗口,嵌入桌面
exit /b

:book_6
title;第六章 编写外部命令
nircmd.exe win center foreground
Topmost
(for /f %%i in ('CWnd find /!') do (
	CWnd Disable %%i min
	CWnd Disable %%i max
	CWnd Disable %%i close
)) 2>nul
cmdow @ /DIS 2>nul
cls
modes 75 16
call vcc -h
for /l %%i in (1,1,9) do echos 0x08 "                                           |"
echos 0x08 "___________________________________________|________________________________"
echo;
set /a wide=45
gotoxy -l %wide% 1
echo;├─  %cd%
gotoxy -l %wide% 2
echo;│   └  test.c     
gotoxy -l %wide% 3
echo;├─  server
gotoxy -l %wide% 4
echo;│   │  callbacks.h     
gotoxy -l %wide% 5
echo;│   └─ ini
gotoxy -l %wide% 6
echo;│   │      ini.h
gotoxy -l %wide% 7
echo;└─  zombie 

gotoxy -l 0 0

set /a code_num=0
call :code_show

printf -t 0x08 10 "#include "
printf -t 0x06 10 "<iostream>"
call :code_show
printf -t 0x03 10 "using namespace "
printf -t 0x07 10 "std;"
call :code_show
printf -t 0x03 10 "int "
printf -t 0x07 10 "main("
printf -t 0x03 10 "int "
printf -t 0x07 10 "argc,"
printf -t 0x03 10 "char *"
printf -t 0x07 10 "argv[])"
call :code_show
printf -t 0x07 10 {
call :code_show
printf -t 0x07 10 "	cout<<"
printf -t 0x06 10 "\"hello world\""
printf -t 0x07 10 ", 0);	"
call :code_show
printf -t 0x03 10 "	return "
printf -t 0x02 10 0
printf -t 0x07 10 ;
call :code_show
printf -t 0x07 10 }


gotoxy -l 0 11
call :showcmd "g++ test.cpp -o test.exe"
timeout 2 >nul

gotoxy -l %wide% 1
echo;├─  %cd% 
gotoxy -l %wide% 2           
echo;│      test.c        
gotoxy -l %wide% 3         
echo;│      test.exe       
gotoxy -l %wide% 4        
echo;├─  server             
gotoxy -l %wide% 5
echo;│   │  callbacks.h       
gotoxy -l %wide% 6
echo;│   └─ ini         
gotoxy -l %wide% 7
echo;│          ini.h      
gotoxy -l %wide% 8
echo;└─  zombie    

gotoxy -l 0 12

call :showcmd "test.exe"
echo;hello world

cmdow @ /ENA 2>nul
cmdow @ /NOT 2>nul>nul
(for /f %%i in ('CWnd find /!') do (
	CWnd enable %%i min
	CWnd enable %%i max
	CWnd enable %%i close
)) 2>nul>nul
taskkill -f -im cmatrix.exe 2>nul>nul

call :SetConsoleCursorInfo 1 3
exit /b


:code_show
set /a code_num+=1
echo;
if %code_num% GTR 9 ( printf 0x08 " %code_num% " ) else printf 0x08 "  %code_num% "
exit /b

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
printf 0x07 "%used%@%COMPUTERNAME%[%cd%]$ "
timeout 1 >nul
printf -t 0x07 100 "%~1"
timeout 1 >nul
echo;
exit /b

:TimeMain
tasklist | findstr /i tray.exe || start tray "cmd.exe /c %~dp0..\..\Termux.bat" %~dp0..\home\console.ico %~dp0..\home\console-off.ico
@Mode Con: Cols=128 Lines=9 & Chcp 437 > Nul & Title Clock & @SetLocal EnableExtensions EnableDelayedExpansion
	@Call :SetConsoleTextAttribute 0-0-0 58-150-221
	@Cls
	@Call :SetConsoleCursorInfo 2 0
	@Call :ShowTime
@Exit /B 0

:ShowTime
	@Call :GotoXY 61 2
	@Call :SetConsoleTextAttribute 0-0-0 58-150-221
	Set _Temp_Time_=%Time:~0,8%
	Set /P=#%_Temp_Time_%< Nul
	Set _Temp_Time_=%_Temp_Time_: =0+%
	Set _Temp_Time_=%_Temp_Time_::0=:0+%

	Set "Block=圹"
	Set "Block=%Block:~0,1%"

	For /F "Delims=:, Tokens=1,2,3" %%i in ("%_Temp_Time_%") Do (
		Set /A _Temp_H_=%%i
		Set /A _Temp_M_=%%j
		Set /A _Temp_S_=%%k
	)

	@Call :SetConsoleTextAttribute 255-255-255 58-150-221

	@Call :GotoXY 5 4
	For /L %%i in (0,1,23) Do (
		For /L %%j in (0,1,4) Do (
			If %%i Lss !_Temp_H_! (
				Set /P=#%Block%< Nul
			) Else Set /P=# < Nul
		)
	)

	@Call :GotoXY 5 6
	For /L %%i in (0,1,59) Do (
		For /L %%j in (0,1,1) Do (
			If %%i Lss !_Temp_M_! (
				Set /P=#%Block%< Nul
			) Else Set /P=# < Nul
		)
	)

	@Call :GotoXY 5 8
	For /L %%i in (0,1,59) Do (
		For /L %%j in (0,1,1) Do (
			If %%i Lss !_Temp_S_! (
				Set /P=#%Block%< Nul
			) Else Set /P=# < Nul
		)
	)

@Goto :ShowTime





%================================================================%
%= 日期: 2022 年 9 月 10 日 =%
%= 名称: Type =%
%= 作用: 模拟打字 =%
%= 参数: String 要显示的字符串 =%
%= 备注: 此函数要访问环境变量 _._ =%
%================================================================%
:Type <String>
	If "%~1"=="" @Goto :Eof
	Set "_._=%~1"
	Set /P=#%_._:~0,1%< Nul
	Set "_._=%_._:~1%"
	TimeOut /T 0 > Nul 2> Nul
	If Defined _._ @Call :Type "%_._%"
@Goto :Eof

%================================================================================================================================%
%= VT100 函数 =%
%================================================================================================================================%

%================================================================%
%= 日期: 2022 年 9 月 9 日 =%
%= 名称: InitVT100 =%
%= 作用: 初始化 Windows 10 的 虚拟终端序列 =%
%================================================================%
:InitVT100
%= { =%

	%= 获取 ESC 字符 =%

	Set "ESC="

	%= 如果没有定义 ESC 字符，这个过程是为了防止论坛误吞上文的 ESC 字符 =%
	If Not Defined ESC (

		For /F "Delims=#" %%_ in ('Prompt #$E# ^& Echo On ^& For %%$ in ^(1^) Do DosKey') Do Set "ESC=%%_"
		REM for /F %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
	)

%= } =%
@Goto :Eof

%================================================================%
%= 日期: 2022 年 9 月 9 日 =%
%= 名称: GotoXY =%
%= 作用: 定位光标到指定位置 =%
%= 参数: X 光标的 X 轴坐标，如果省略或设为 0，则设其为1 =%
%= 参数: Y 光标的 Y 轴坐标，如果省略或设为 0，则设其为1 =%
%================================================================%
:GotoXY <X> <Y>
%= { =%

	%= 如果没有定义 ESC 字符 =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	%= 定位光标 =%
	Set /P=%ESC%[%2;%1H< Nul

%= } =%
@Goto :Eof

%================================================================%
%= 日期: 2022 年 9 月 9 日 =%
%= 名称: SetConsoleTextAttribute =%
%= 作用: 设置控制台文本颜色 =%
%= 参数: BGCOL 背景 RGB 颜色值，格式为R-G-B =%
%= 参数: FGCOL 前景 RGB 颜色值，格式为R-G-B =%
%================================================================%
:SetConsoleTextAttribute <BGCOL> <FGCOL>
%= { =%

	%= 如果没有定义 ESC 字符 =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	%= 设置背景色 =%
	For /F "Delims=-, Tokens=1,2,3" %%I in ("%1") Do (
		Set /P=%ESC%[48;2;%%I;%%J;%%Km< Nul
	)

	%= 设置前景色 =%
	For /F "Delims=-, Tokens=1,2,3" %%I in ("%2") Do (
		Set /P=%ESC%[38;2;%%I;%%J;%%Km< Nul
	)

%= } =%
@Goto :Eof

%================================================================%
%= 日期: 2022 年 9 月 9 日 =%
%= 名称: SetConsoleCursorInfo =%
%= 作用: 设置控制台光标属性 =%
%= 参数: CursorVisibility 光标可见和闪烁状态，取值1~4，分别为： =%
%=       1 显示光标 =%
%=       2 隐藏光标 =%
%=       3 开始光标闪烁 =%
%=       4 停止闪烁光标 =%
%= 参数: CursorShape      自定义光标形状，取值0~6，分别为： =%
%=       0 用户配置的默认光标形状 =%
%=       1 闪烁块光标形状 =%
%=       2 稳定块光标形状 =%
%=       3 闪烁下划线光标形状 =%
%=       4 稳定下划线光标形状 =%
%=       5 闪烁条形光标形状 =%
%=       6 稳定条形光标形状 =%
%================================================================%
:SetConsoleCursorInfo <CursorVisibility> <CursorShape>
%= { =%

	%= 如果没有定义 ESC 字符 =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	%= 设置光标可见和闪烁状态 =%
	For /F "Delims=-, Tokens=%1" %%I in ("25h-25l-12h-12l") Do (
		Set /P=%ESC%[?%%I< Nul
	)

	Set /P=%ESC%[%2 q< Nul

%= } =%
@Goto :Eof

%================================================================%
%= 日期: 2022 年 9 月 9 日 =%
%= 名称: SetConsoleTextAttributeEx =%
%= 作用: 格式化控制台文本 =%
%= 参数: Code 操作代码，取值1~6，分别为： =%
%=       1 默认，通常相当于Color 07 =%
%=       2 粗体/亮 =%
%=       3 无粗体/亮 =%
%=       4 下划线 =%
%=       5 无下划线 =%
%=       6 交换前景色和背景色 =%
%================================================================%
:SetConsoleTextAttributeEx <Code>
%= { =%

	%= 如果没有定义 ESC 字符 =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	For /F "Delims=-, Tokens=%1" %%I in ("0-1-22-4-24-7") Do (
		Set /P=%ESC%[%%Im< Nul
	)

%= } =%
@Goto :Eof


:game_loop
call :SetConsoleCursorInfo 2 0
mode 70,16
set MAX_X=20
set MAX_Y=13
for /l %%i in (1,1,15) do (
echo;                                          ^|
)
echo;------------------------------------------+ [20,13] wasd ESC退出
set X=2
set Y=2
title [%X%,%Y%]
gotoxy -l 4 2
set /p.=我<nul
:loop_game
title [%X%,%Y%]
words -key
if %errorlevel% EQU 119 (
	if %Y% GEQ 1 (
		set /a Y-=1
		printfs "  "
		gotoxy -2 -1
		set /p.=我<nul
	)
) else if %errorlevel% EQU 97 (
	if %X% GEQ 1 (
		set /a X-=1
		REM gotoxy -4 0
		printfs "  "
		set /p.=我<nul
	)
) else if %errorlevel% EQU 115 (
	if %Y% LSS %MAX_Y% (
		set /a Y+=1
		printfs "  "
		gotoxy -2 1
		set /p.=我<nul
	)
) else if %errorlevel% EQU 100 (
	if %X% LSS %MAX_X% (
		set /a X+=1
		set /p.=  我<nul
	)
) else if %errorlevel% EQU 27 (
	call :SetConsoleCursorInfo 1 3
	exit /b
) 
goto :loop_game

REM ----------------------------------------------help command----------------------------------------------

::::::::::::::::::::helps_cmdow.exe::::::::::::::::::::::

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

::::::::::::::::::::helps_png2ico.exe::::::::::::::::::::::
png2ico -i "png" -o "ico" -s 16 32bpp -s 24 32bpp -s 32 32bpp -s 48 32bpp -s 64 32bpp -s 72 32bpp -s 96 32bpp -s 128 32bpp -noconfirm
           "png"    "ico" 只能是文件夹名称
		   
::::::::::::::::::::helps_jpeg.exe::::::::::::::::::::::

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


::::::::::::::::::::helps_nircmd.exe::::::::::::::::::::::

弹出盘符为J的光驱

nircmd.exe cdrom open j:

弹入盘符为Y的光驱

nircmd.exe cdrom close y:

读出剪贴板文本内容

speak text ~$clipboard$

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

nircmd.exe qboxcom "Do you want to reboot ?" "question" exitwin reboot

关闭计算机

nircmd.exe exitwin poweroff

关闭computers.txt中指定的所有计算机

multiremote copy "c:\temp\computers.txt" exitwin poweroff force

拨号宽带连接

nircmd.exe rasdial "My Internet"

断开宽带连接

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

nircmd.exe win -style title "my computer" 0x00C00000

恢复我的电脑窗口的标题栏(当用上面命令去除后)

nircmd.exe win +style title "my computer" 0x00C00000

设置我的电脑窗口为从右至左的顺序(适用于希伯来语和阿拉伯语)

nircmd win +exstyle title "my computer" 0x00400000

设置我的电脑窗口的所有子窗口为从右至左的顺序(适用同上)

nircmd win child title "my computer" +exstyle all 0x00400000

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

创建calc.exe快捷方式到开始菜单->程序->Calculators(计算器)

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

添加nirsoft网址到收藏夹链接下

nircmd.exe urlshortcut "http://www.nirsoft.net" "~$folder.favorites$\Links" "NirSoft"

将nirsoft网址快捷方式创建到computers.txt中列出的所有计算机的桌面

nircmd.exe multiremote copy "c:\temp\computers.txt" urlshortcut "http://www.nirsoft.net" "~$folder.common_desktop$" "NirSoft"

设置显示模式为800X600，24位色

nircmd.exe setdisplay 800 600 24

将设置显示模式为800X600，24位色命令创建为桌面快捷方式

nircmd.exe cmdshortcut "~$folder.desktop$" "800x600x24" setdisplay 800 600 24

复制所有桌面快捷方式到其他文件夹(f:tempdesktop)

nircmd.exe execmd copy "~$folder.desktop$\*.lnk" f:\temp\desktop

重启的Apache server服务器(windows NT/2000/XP/2003)

nircmd.exe service restart apache

将重启Apache server服务器命令创建为桌面快捷方式

nircmd.exe cmdshortcut "~$folder.desktop$" "Restart Apache" service restart apache

重启IIS(互联网信息服务)

nircmd.exe service restart w3svc

重启MySql

nircmd.exe service restart MySql

打开指定注册表项/值

nircmd.exe regedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"

打开在注册表编辑器中复制到剪切板的注册表项

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

安装所有在全局程序集缓存(like gacutil)中指定的.NET程序集

nircmd.exe gac install "C:\temp\MyAssembly\bin\MyAssembly.dll"

清空所有磁盘上的回收站

nircmd.exe emptybin

对一个标准的Windows信息框回复确认

nircmd.exe dlg "" "" click yes

延迟2秒钟，然后保存当前屏幕截图到shot.png

nircmd.exe cmdwait 2000 savescreenshot "f:\temp\shot.png"

循环保存10个截图，截图间隔60秒，文件名包含时间和日期

nircmd.exe loop 10 60000 savescreenshot c:\temp\scr~$currdate.MM_dd_yyyy$-~$currtime.HH_mm_ss$.png

等待Fixfox关闭，读出 "Firefox was closed"（火狐已经关闭）

waitprocess firefox.exe speak text "Firefox was closed"

系统要求

这个工具可以工作在所有32位的视窗操作系统的 Windows 9x/ME, Windows NT, Windows 2000, Windows XP, Windows Server 2003,和 Windows Vista。不过，一些 NirCmd 命令只能用在 Windows NT/2000/XP/2003/Vista 的命令行执行。

　

许可证

　

这是一款免费软件。只要不从此中收取费用，就可以自由的通过软盘，CD，网络或者其他方法发布。注意在发布时应包含此发布包内的所有文件，不得有任何修改。

　

使用NirCmd

　

这款软件是一个独立的可执行程序，不需要任何的安装过程或者额外的dll文件支持。只需要把exe文件复制到任何指定的文件夹，并且根据你的需要添加需要的命令选项运行即可。推荐复制NirCmd.exe到Windows目录，或者复制到任何系统中path环境变量中所列出的路径下，这样就不需要在每次运行时输入NirCmd的完整路径。
从版本1.50开始，NirCmd的也可以在控制台中使用，在控制台版本中，所有的错误信息都会显示在控制台窗口中，而不是出现在信息框中
此实用工具可以在所有32位Windows操作系统：Windows 9x/ME，Windows NT ，Windows 2000， Windows XP，Windows Server 2003和Windows Vista。不过，一些NirCmd命令只能在 Windows NT/2000/XP/2003/Vista 命令行执行。

　

NirCmd的一般语法

　

nircmd.exe {showerror} [command] [command parameters]

showerror是可选参数。如果指定了此参数，那么在命令运行过程中如果发生错误，错误信息会显示在屏幕上。否则，会忽略所有错误。
例如：
nircmd.exe showerror rasdial "dial1"
nircmd.exe rasdial "dial1"
在上面的两个例子中，NirCmd会尝试连接diall入口，在第一个例子中，如果连接失败，将会显示一条有关此问题的错误信息；在第二个例子中，如果连接失败则不会显示错误信息。

　

特殊字符串序列

　

从版本1.20开始，NirCmd允许在命令参数中插入特殊的字符。

下表列出了可以使用的特殊字符串序列：

序 列 

描 述

~n

换行(CR-LF)[包含换行符和回车符]

~q

双引号："

~t

制表符 Tab键

~xnn

用一个包含两位十六进制数字的ASCII来代表任何字符。例如：~x41 (字符'A'), ~x27 (单引号)

~$variable$

代表系统变量，更多信息请看下面的系统变量。

~~

代表单个~字符

例如:
infobox "This is the first line~n~qThis is a second line, in quotes~q" "Example"
上面的例子会显示一个包含两行的信息框。

系统变量

从1.40版本开始，NirCmd提供了特殊字符代表文件夹以及其他系统变量。每个变量都以字符~开头，后面的变量名包含在两个$内。
例：~$folder.desktop$就代表了系统桌面这个文件夹的路径。(可以用nircmd infobox "~$folder.desktop"来查看)。
下表就指定了可以使用的一些变量：

变量名 

描 述 

clipboard

代表复制到剪切板的文本内容

param.paramname

当指定一个param变量时，屏幕上会显示一个输入窗口，要求为指定的参数输入文本(可以理解为给参数赋值),所输入的 文本会被插入到命令行中。例:在下面的命令中，会要求输入2个参数(1和2)，所输入的文本会显示在信息框中。nircmd infobox ~$param.1$ ~$param.2$

fparam.number

从指定的文本中加载指定的参数，更多信息请参考命令paramsfile command

sys.varname

可以使用此选项来表示系统上的任何环境变量。例: ~$sys.username$, ~$sys.windir$, ~$sys.computername$, ~$sys.logonserver$, ~$sys.temp$, 等等

nir.exefile

当前运行的NirCmd的完整路径(如: c:\winnt\nircmd.exe)

loopcount

执行循环命令时指定循环次数

currtime.TimeFormat

根据“TimeFormat”选择的时间格式指定当前时间。
如:~%currtime.HH_mm_ss%，如需对时间格式了解更多参考currtime(时间格式字符串)

currdate.DateFormat

根据“DateFormat”选择的日期格式指定当前日期。
如:~%currdate.MM_dd_yyyy% ，如需对日期格式了解更多参考currdate(日期格式字符串)

folder.nircmd

NirCmd所在的文件夹(路径)

folder.desktop

用户桌面(路径)

folder.start_menu

用户开始菜单文件夹(路径)

folder.programs

用户开始菜单程序文件夹(路径)

folder.startup

用户开始菜单程序启动文件夹(路径)

folder.recent

用户开始菜单程序启动文件夹(路径)

folder.favorites

用户收藏夹(路径)

folder.cookies

cookies文件夹(路径)

folder.appdata

Application Data文件夹(路径)(例如: C:\Documents and Settings\Administrator\Application Data)

folder.common_desktop

All user桌面文件夹(路径)

folder.common_start_menu

ALL user开始菜单文件夹(路径)

folder.common_programs

ALL user开始菜单程序文件夹(路径)

folder.common_startup

ALL user开始菜单程序启动文件夹(路径)

folder.common_favorites

ALL user收藏夹(路径)

folder.windows

Windows文件夹(路径) (e.g.: C:\Windows)

folder.system

系统文件夹(路径) (e.g.: C:\Windows\System32)

folder.programfiles

程序文件的文件夹(路径) (e.g.: C:\Program Files)

folder.common_programfiles

ALL user程序文件的文件夹(路径)(e.g.: C:\Program Files\Common)

folder.mydocuments

“My Documents”我的文档文件夹(路径)

例如：

1、 创建开始菜单程序文件夹的快捷方式：
    shortcut "c:\winnt\system32\calc.exe" "~$folder.programs$\My Programs" "Calculator"
2、 删除用户桌面的某个快捷方式：
    execmd del "~$folder.desktop$\calc.lnk"
3、 显示当前已登录的用户：
    infobox "The current logged-on user is ~$sys.username$" "logged-on user"
4、 截图并用包含当前时间和日期的文件名进行保存
    savescreenshot c:\temp\scr~$currdate.MMddyyyy$-~$currtime.HHmmss$.png

currtime时间格式字符串

时间格式字符串中可能包含以下内容:(这些格式字符串需要区分大小写!)

h

单数字小时；十二小时制

hh

双数字小时；十二小时制

H

单数字小时；二十四小时制

HH

双数字小时；二十四小时制

m

单数字分钟

mm

双数字分钟

s

单数字秒

ss

双数字秒

t

标记字符串的单个时间字符, 如 A 或者 P

tt

标记字符串的多时间字符, 如AM或者PM

　

currdate日期格式字符串

　

日期格式字符串中可能包含以下内容:(这些格式字符串需要区分大小写!)

　

d

月份中的单数字日期

dd

月份中的双数字日期

ddd

星期中的三位数日期缩写

dddd

星期中的日期全称

M

单数字月份

MM

双数字月份

MMM

三位数缩写月份

MMMM

月份全称

y

年份末尾数

yy

年份末尾两位数

yyyy

年份全称

　

在远程计算机上执行NirCmd命令

　

从1.40版本开始，可以在远程计算机上执行NirCmd命令。但是，应该注意以下的一些限制和问题：
1、此选项只可用于Windows NT，Windows 2000和Windows XP。不可以在Windows 9X下使用。
2、必须以管理员身份登陆远程计算机。
3、远程计算机上的任务计划(Task Schedule)服务必须开启。(默认所有的NT/2000/XP计算机都自动开启此服务，所以不用担心这点。)
4、由于任务计划服务的一些限制，必须等待60秒命令才可以在远程计算机上执行。
5、远程计算机上的命令是在system账户下执行，因此某些同样的命令在本地执行可能会有所区别。

　

这是两条在用于远程计算机上执行的NirCmd命令：

　

remote - 用于在一台远程计算机上执行命令
multiremote - 用于在多台远程计算机上执行命令
帮助

　

如果不记得确切的语法命令，随时可以查看帮助文件 NirCmd (NirCmd.chm) 或者可以使用帮助命令（help command）中提到的 http://nircmd.nirsoft.net/,例如： nircmd.exe help multiremote

NirCmd命令

remote {copy} [\\computer] [NirCmd command]

在远程计算机上执行NirCmd命令。如果指定了{copy}参数，NirCmd将会复制自身到远程计算机的 Windows目录下。如果远程计算机的Windows目录下不存在NirCmd.exe，则必须指定{copy}参数。 
例如:
remote copy \\comp1 exitwin poweroff
remote \\comp2 infobox "This is a message from NirCmd" "Hello !"
remote \\comp3 lockws

multiremote {copy} [computers file] [NirCmd command]

在多台远程计算机上执行 NirCmd命令。如果指定了 {copy} 参数，NirCmd将会复制自身到远程计算机的 Windows目录下。如果远程计算机的Windows目录下不存在NirCmd.exe，则必须指定 {copy} 参数。参数 [computers file] 指定一个文件，此文件包含了以回车符分隔(CRLF)的计算机列表。


文件[computers file] 举例:
\\comp1
\\comp2
\\winxp1
\\winxp2
\\nirsoft

在参数 [NirCmd command] 中指定的命令会在所有[computers file]指定的计算机上运行。

例如:

关闭所有在computers.txt中列出的计算机。
multiremote "c:\temp\computers.txt" exitwin poweroff force
锁定所有在computers.txt中列出的计算机。
multiremote "c:\temp\computers.txt" lockws
复制NirCmd.exe到所有computers.txt中列出的计算机上，并且关闭其显示器。
multiremote copy "c:\temp\computers.txt" monitor off
复制NirCmd.exe到所有computers.txt中列出的计算机上，运行wul.exe (WinUpdatesList)，以便保存所有计算机上的Windows更新信息。
multiremote copy "c:\temp\computers.txt" exec hide c:\temp\wul.exe /shtml "c:\temp\wul_~$sys.computername$.html"
cmdwait [Number of Milliseconds] [NirCmd Command]

等待指定的毫秒数，然后执行指定的NirCmd命令。

例如:
cmdwait 1000 monitor off

loop [Number of Times] [Number of Milliseconds] [NirCmd Command]

指定命令执行循环次数， 命令执行期间，NirCmd 等待第二个参数指定的毫秒数， 通过~%loopcount% 变量指定循环中的呼叫号码(从1 到 n)

例如:
loop 3 2000 speak text "Call Number ~$loopcount$"
loop 10 60000 savescreenshot c:\temp\scr~$loopcount$.png

paramsfile [Parameters File] [Delimiters] [Quote Character] [NirCmd Command]

这是一个很强大的命令，它允许从一个文本文件中加载一个或多个参数，从而可以成倍的执行NirCmd命令。此文本文件内容可以以逗号、Tab、分号或者 任何在参数[Delimiters]中指定的符号作为分隔符。
举一个例子：假设有如下文本文件，包含了一些用户名和密码，以','隔开：

user01, 123456

user02, abcfg

user03, 5fr23

user04, 33333

下面的NirCmd命令将会创建在以上文本文件中指定的4个用户名和密码。(通过使用Windows 2000/XP操作系统提供的net user命令)
nircmd.exe paramsfile "c:\temp\users.txt" "," "" execmd net user ~$fparam.1$ ~$fparam.2$ /add

~$fparam.1$指每行的第一个词条，即用户名。~$fparam.2$指每行的第二个词条，即密码。

例如:
paramsfile "c:\temp\folders.txt" "" "" execmd md ~$fparam.1$
paramsfile "c:\temp\shortcuts.txt" "," "~q" shortcut ~$fparam.1$ "~$folder.desktop$" ~$fparam.2$

infobox [message text] [title]

在屏幕上显示一个简单的信息框


例如:
infobox "This is a message box !" "message"

qbox [message text] [title] [program to run]

在屏幕上显示一个询问对话框。如果用户回答是，则运行程序


例如:
qbox "Do you want to run the calculator ?" "question" "calc.exe"

qboxtop [message text] [title] [program to run]

同qbox命令类似，但显示的对话框为最上层窗口

qboxcom [message text] [title] [NirCmd Command]

在屏幕上显示一个询问对话框。如果用户回答是，则执行参数[NirCmd Command]中指定的NirCmd命令

例如:
qboxcom "Do you want to lock your workstation ?" "question" lockws
qboxcom "Do you want to turn off the monitor ?" "monitor" monitor off

qboxcomtop [message text] [title] [NirCmd Command]

同qboxcom命令类似，但现实的对话框为最上层窗口

script [Script File]

此命令允许运行包含在一个脚本文件中的一系列命令，此脚本文件由参数[Script File]指定

例如:

script "c:\temp\msg.ncl"

脚本文件样例:

infobox "Hello !" "This is the first message"

infobox "Hello !" "This is the second message"

infobox "Hello !" "This is the third message"

regedit [key] [value name]

打开注册表编辑器的指定项/值

例如:
regedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"
regedit "HKEY_CURRENT_USER\Control Panel\Desktop" "Wallpaper"

regsetval [type] [key] [value name] [value]

把值写入注册表。参数[type]可以为："sz"或"expand_sz" 指字符串；"dword" 指32位数字；"binary" 指二进制数据。如果在参数[key]中指定的项在注册表中不存在，则会自动创建此项。
例如:
regsetval dword "HKEY_CURRENT_USER\Software\Test" "Value1" "0xaabbccdd"
regsetval dword "HKCU\Software\Test" "Value2" "10561"
regsetval sz "HKCU\Software\Test" "Value3" "string value"
regsetval binary "HKLM\Software\Test" "Value4" "6a cb ab dd 80 86 95"

regdelval [key] [value]

删除注册表中的某个值
例如:
regdelval "HKEY_CURRENT_USER\Software\Test" "Value1"

regdelkey [key]

删除注册表中的整项。如果指定的项有一个或多个子项时，此命令失效
例如:
regdelkey "HKEY_CURRENT_USER\Software\Test"

inisetval [INI filename] [section] [key] [value]

把值写入ini文件。如果文件不存在，则自动创建
例如:
inisetval "c:\windows\test.ini" "section1" "TestValue" "1"

inidelval [INI filename] [section] [key]

删除ini文件中的一对项-值
例如:
inidelval "c:\windows\test.ini" "section1" "TestValue"

inidelval [INI filename] [section]

删除ini文件的整段(以[]分段)，且删除此段中包含的所有值
例如:
inidelsec "c:\windows\test.ini" "section1"

regsvr [reg or unreg] [filename or wildcard] {log file}

注册或解除注册DLL/OCX文件。
在第一个参数[reg or unreg]中，指定"reg"表示注册文件，指定"unreg"表示解除注册文件。
在第二个参数[filename or wildcard]中，可以指定要注册或解除注册的某个单一文件，多个文件用通配符指定。
第三个为可选参数，指定一个日志文件来保存注册操作的结果
例如:
regsvr reg "f:\winnt\system32\fv*.ocx" "c:\temp\log1.txt"
regsvr unreg "f:\winnt\system32\ab*.dll"

rasdial [Entry Name] {Phonebook File} {User Name} {Password} {Domain}

不显示任何用户界面，建立拨号连接到RAS服务接口(VPN网络或电话线)。除了参数[Entry Name]为必需，其他参数都为可选参数。如果没有指定可选参数，或者指定为空字符串("")，将会使用默认值
例如:
rasdial "My Internet"
rasdial "VPN1" "" "user1" "abc1234" "domain1"

inetdial [Entry Name]

建立拨号连接到RAS服务接口(VPN网络或电话线)，显示拨号进程的信息对话框。
此命令只适用于IE版本4.0及其以上。注意：此命令在旧版本的Windows 98上可能无效
例如:
inetdial "VPN1"

rasdialdlg [Entry Name] {Phonebook File} {Phone Number or IP Address}

显示用于拨号连接的RAS服务接口。参数 {Phonebook File} 和 {Phone Number} 为可选参数。如果没有指定参数 {Phonebook File} 或者指定为空字符串("")，则使用默认电话簿。
此命令只适用于Windows NT，Windows 2000和Windows XP。不支持Windows 98/ME
例如:
rasdialdlg "Internet1" "" "9876543"
rasdialdlg "VPN1"

rashangup {Entry Name}

中断RAS连接。可以用此命令来中止之前用命令inetdial或者rasdial创建的连接。如果没有指定参数{Entry Name}，所有活动连接都将被终止.
例如:
rashangup "VPN1"
rashangup

setdialuplogon [Entry Name] [User Name] {Password} {Domain} {Phonebook File}

修改拨号连接的用户名、密码、域名
参数: 

[Entry Name]: 拨号连接名
[User Name]: 设定拨号连接的用户名
{Password}: 设定拨号连接的密码
{Domain}: 设定拨号连接的域名
{Phonebook File}: 电话簿文件包含了要修改的拨号连接条目。如果没有指定此参数，将会使用默认电话簿
例如:
setdialuplogon "VPN1" "user1" "asder443" "domain1"
setdialuplogon "Internet1" "nirs3" "q5r4df7yh5"

exitwin [shutdown type] {additional option}

此命令用来关闭当前会话窗口。
参数 [shutdown type] 可以是一下值之一：

logoff: 结束所有进程，注销当前用户，显示登录对话框来切换用户
reboot: 关闭系统，重新启动
poweroff: 关闭系统，关闭电源(只对支持此性质的系统有效)。
shutdown: 只关闭系统，不重启，不关电源
还可以使用一下的附加选项：

force: 立即强制终止所有应用程序。使用此选项可能会是正在运行的程序丢失数据。建议只在特殊情况下使用！
forceifhung: 终止无响应的应用程序。适用于Windows 2000/XP

例如:
exitwin reboot
exitwin poweroff force
exitwin logoff forceifhung

initshutdown {message} {timeout value in seconds} {force} {reboot}

系统关机。此命令与exitwin命令有些相似，但它具备一些exitwin不支持的操作。此命令不支持Windows 95/98/ME。如果没有指定任何参数，将会在不显示任何信息的情况下立即关闭计算机。

参数： 

{message}: 指定关机前要显示的信息
{timeout value in seconds}: 指定关机前等待的秒数
{force}: 不保存当前数据，强制终止所有应用程序
{reboot}: 关机后重启

例如:
initshutdown "shutting down the system within 60 seconds" 60 reboot
initshutdown "" 0 force

abortshutdown

取消用initshutdown命令进行的关机操作，不接受任何参数
例如:
abortshutdown

lockws

锁定计算机。锁定计算机后，必须输入密码来解锁。只适用于Windows 2000/XP

monitor [action]

改变显示器状态。参数 [action] 可以包含下列值：
 

off: 关闭显示器
on: 打开显示器
low: 设置为低耗电状态

这个命令仅能工作在支持该特性的系统中
例如:
monitor off
monitor on
monitor async_off

screensaver

开启默认屏保

standby {force}

关闭计算机，并处于待机模式。如果指定 {force} 参数，系统会不经过所有应用程序许可直接进入待机状态，不推荐使用此参数。适用于支持待机模式的系统


例如: 
standby force
standby

hibernate {force}

关闭计算机，并处于休眠模式。如果指定 {force} 参数，系统会不经过所有应用程序许可直接进入休眠状态，不推荐使用此参数。适用于支持休眠模式的系统

例如:
hibernate force
hibernate

shortcut [filename] [folder] [shortcut title] {arguments} {icon file} {icon resource number} {ShowCmd} {Start In Folder} {Hot Key}

创建文件的快捷方式：
参数: 

[filename]: 指定要创建快捷方式的文件
[folder]: 指定快捷方式的创建位置。可以指定任何有效的文件夹，包括一些代表系统文件夹的特殊变量，如：~$folder.programs$ (开始/程序文件夹)等等...
[shortcut title]: 此快捷方式的名字
{arguments}: 可选参数 - 执行此文件的附加参数
{icon file}: 可选参数 - 如果想使用其他图标来代替默认图标则使用此参数
{icon resource number}: 可选参数 - 图标文件中的图标号码
{ShowCmd}: 可选参数 - 最大化或最小化程序运行窗口。指定"max"最大化窗口，"min"最小化窗口
{Start In Folder}: 可选参数 - 指定开始位置。如果没有制定此参数，起始位置就自动设置为在参数 [filename] 中指定的文件夹
{Hot Key}: 可选参数 - 指定快捷键(热键)。例： Alt+Ctrl+A, Alt+Shift+F8, Alt+Ctrl+Shift+Y

例如:
shortcut "f:\winnt\system32\calc.exe" "~$folder.desktop$" "Windows Calculator"
shortcut "f:\winnt\system32\calc.exe" "~$folder.programs$\Calculators" "Windows Calculator"
shortcut "f:\Program Files\KaZaA\Kazaa.exe" "c:\temp\MyShortcuts" "Kazaa"
shortcut "f:\Program Files" "c:\temp\MyShortcuts" "Program Files Folder" "" "f:\winnt\system32\shell32.dll" 45
shortcut "f:\Program Files" "c:\temp\MyShortcuts" "Program Files Folder" "" "" "" "max"

cmdshortcut [folder] [shortcut title] [command]

创建一个NirCmd命令快捷方式。运行快捷方式时（双击），命令中指定的 [command] 参数将被执行
例如:
cmdshortcut "~$folder.desktop$" "Open CDROM" cdrom open k:
cmdshortcut "c:\temp" "Turn Monitor Off" monitor off

cmdshortcutkey [folder] [shortcut title] [hot key] [command]

创建一个指定快捷键的NirCmd命令快捷方式。当运行此快捷方式(双击),参数 [command] 指定的命令会被执行
例如:
cmdshortcutkey "~$folder.desktop$" "Open CDROM" "Ctrl+Shift+K" cdrom open k:
cmdshortcutkey "c:\temp" "Turn Monitor Off" "Ctrl+Shift+M" monitor off

urlshortcut [URL] [Folder] [Shortcut Title]

创建网页快捷方式(类似收藏夹中的网页快捷方式)。参数 [Folder] 指定此快捷方式的创建位置，如果想创建快捷方式到收藏夹，则使用：~$ folder.favorites$ variable.

例如:
urlshortcut "http://www.nirsoft.net" "~$folder.favorites$" "NirSoft Web Site"
urlshortcut "http://www.google.com" "~$folder.favorites$\Search Engines" "Google"
urlshortcut "http://www.yahoo.com" "c:\temp" "Yahoo"

exec [show/hide/min/max] [application + command-line]

运行一个应用程序,可选择性地为此程序指定一个或多个命令行参数 [show/hide/min/max] (显示/隐藏/最小/最大值)] 参数指定是否显示或隐藏运行的应用程序且窗口最大化或最小化。如果选择“hide(隐藏)”选项,运行的应用程序在后台运行不可见。如果“max(最大值)”选项,运行的应用程序窗口最大化。如果选择“min(最小)”选项,运行的应用程序窗口最小化。
例如:
exec show "f:\winnt\system32\calc.exe"
exec hide "c:\temp\wul.exe" /savelangfile
exec max "c:\temp\test.exe"

exec2 [show/hide/min/max] [working folder] [application + command-line]

类似于执行exec命令,但是也提供了另一个参数,[working folder],你可以运行指定文件夹默认的工作目录的应用程序。

 

例如:
exec2 show "f:\winnt\system32" "f:\winnt\system32\calc.exe"
exec2 hide c:\temp "c:\temp\wul.exe" /savelangfile

execmd [command]

执行命令提示符下(控制台)命令,屏幕上不显示任何信息


例如:
execmd del "~$folder.desktop$\calc.lnk"
execmd mkdir f:\temp\desktop1
execmd copy "~$folder.desktop$\*.lnk" f:\temp\desktop

shexec [operation] [filename]

根据注册表中文件扩展名的定义打开或打印文件。如：扩展名为.doc的文件将会以MS-Word方式打开，.html文件以默认浏览器打开。如果指定一个 有效的网址，将会在默认浏览器中打开此网页。参数 [operation] 可以为"open(打开)"或"print(打印)"。

例如:
shexec "open" "c:\my documents\abc.doc"
shexec "print" "d:\files\1.pdf"
shexec "open" "http://www.nirsoft.net"

setfiletime [filename or wildcard] [Created Date] {Modified Date} {Accessed Date}

修改一个或多个文件的“创建/修改/访问”日期。第一个参数可以是单个文件名或者用通配符指定。日期参数必须以下列格式指定："dd-mm-yyyy hh:nn:ss" 。如果没有指定日期参数或者指定为空串(" ")则日期不变。如果指定时间参数为“now(当前)”，则修改为当前日期和时间

　

例如:
setfiletime "c:\temp\*.exe" "15-05-2004 11:22:12" "22-01-2005 21:22:55"
setfiletime "c:\temp\myfile.txt" "24-06-2003 17:57:11" "" "22-11-2005 10:21:56"
setfiletime "c:\temp\myfile.txt" now now

setfilefoldertime [filename, folder or wildcard] [Created Date] {Modified Date} {Accessed Date}

修改一个或多个文件的“创建/修改/访问”日期。此命令同 setfiletime 命令非常相似。唯一的不同在于 setfilefoldertime 命令还可以修改文件夹的日期 - 只适用于Windows 2000/XP


例如:
setfilefoldertime "c:\temp\myfolder" "10-01-2003 11:22:12" "12-11-2002 02:34:11"
setfilefoldertime "c:\temp\myfolder" now now

clonefiletime [source filename] [Wildcard]

修改一个文件或多个文件的“创建/修改/访问”日期，可用[通配符]。

　

格式：NirCmd clonefiletime [source filename] [Wildcard]
参数：[source filename]-[源文件名] [Wildcard]-[通配符]

例如:
clonefiletime "x:\temp\file1.txt" "x:\files\*.*"
clonefiletime "x:\temp\file1.txt" "x:\files\*.txt"
clonefiletime "x:\temp\file1.txt" "x:\files\a*.txt"
clonefiletime "x:\temp\file1.txt" "x:\temp\file2.txt"

emptybin {drive}

清空回收站。参数{drive}指定想要清空的回收站所在的磁盘。如果没有指定此参数，则清空所有磁盘的回收站。
 
例如:
emptybin f:
emptybin

setdisplay {monitor:index/name} [width] [height] [color bits] {refresh rate} {-updatereg} {-allusers}

修改显示设置。参数 [width] 和 [height] 代表的屏幕上的像素点数。参数 [color bits]表示屏幕的颜色位数(8 - 256 color, 16 - 16bit color, 24 - 24bit color等等 {refresh rate} 是可选参数，指定显示器的刷新频率。如果指定了 {-updatereg} 参数，新设置会保存在注册表中。如果同时指定 {-updatereg} 和 {-allusers} 参数，新设置会应用与计算机上所有用户，并且保存在注册表中。

　

例如:
setdisplay 800 600 24 -updatereg
setdisplay 1024 768 24 90
setdisplay 1024 768 8
setdisplay monitor:1 1024 768 24 90
setdisplay monitor:name1 1024 768 24 90

setprimarydisplay [Monitor index/name]

为系统与多个显示器设置的主要监控。参数：[监控 指数/名称]

　

例如:
setprimarydisplay 0
setprimarydisplay 1

killprocess [process]

结束指定进程。在参数 [process] 中，可以指定进程名的完整路径(如：C:\Program Files\Internet Explorer\iexplore.exe)或者只指定进程名(如: iexplore.exe)。还可以通过后缀'/'指定进程的ID(如： /1120)。

例如:
killprocess iexplore.exe
killprocess "c:\winnt\system32\calc.exe"
killprocess /1830

closeprocess [process]

通过关闭顶级窗口来结束指定进程。与killprocess命令相反，closeprocess并不强制立即结束进程。相反，它给指定进程的顶级窗口发送 一个WM_CLOSE消息。注意：此命令对没有用户界面的进程无效。
在参数 [process] 中，可以指定进程名的完整路径(如：C:\Program Files\Internet Explorer\iexplore.exe)或者只是进程名(如：iexplorer.exe)。还可以通过后缀'/'指定进程的ID(如： /1120)。
 
例如:
closeprocess iexplore.exe
closeprocess "c:\winnt\system32\calc.exe"
closeprocess /1830

waitprocess [process] {Command}

等待直到指定进程结束
在参数 [process] 中，可以指定进程名的完整路径(如：C:\Program Files\Internet Explorer\iexplore.exe)或者只是进程名(如：iexplorer.exe)。还可以通过后缀'/'指定进程的ID(如： /1120)。
 
例如:
waitprocess iexplore.exe
waitprocess firefox.exe speak text "Firefox was closed"
waitprocess "c:\winnt\system32\calc.exe"
waitprocess /1830

setprocesspriority [process] [priority]

为指定进程设置新的优先级
在参数 [priority] 中，可以指定以下值：

normal, low, belownormal, abovenormal, high, realtime
在参数 [process] 中，可以指定进程名的完整路径(如：C:\Program Files\Internet Explorer\iexplore.exe)或者只是进程名(如：iexplorer.exe)。还可以通过后缀'/'指定进程的ID(如： /1120)。

例如:
setprocesspriority iexplore.exe high
setprocesspriority "c:\winnt\system32\calc.exe" low
setprocesspriority /1830 abovenormal

setprocessaffinity [process] [list of processor numbers]

设置进程关联,
在参数 [process] 中，指定进程使用的处理器（仅具有多个处理器的计算机），可以指定完整路径名的进程 (如: 'C:Program Files\Internet Explorer\iexplore.exe') 或者只是进程名(如: iexplore.exe). )。还可以通过后缀'/'指定进程的ID(如： /1120)。在参数 [list of processor numbers] 中，可以指定需要的处理器数字，0是第一个处理器，1是第二个，依此类推.

　

例如:
setprocessaffinity iexplore.exe 0 1
setprocessaffinity "c:\winnt\system32\calc.exe" 0 1 2 3
setprocessaffinity /1830 0

memdump [process] [dump file] [bytes per line] {bytes to read} {start address} {nohex} {noascii}

根据指定的参数，读取进程的内存，并写入文件。
参数:

[process]: 想要读取其内存的进程。可以指定完整路径，或仅进程名，或用后缀'/'指定进程ID。(例如:/ 520)
[dump file]: 用来保存指定进程内存的内容的文件名
[bytes per line]: dump file中每行的内存字节数
{bytes to read}: 读取的字节数
{start address}: 指定进程的开始读取地址
{nohex}: 可选参数。如果指定此参数，内存数据不会以十六进制形式保存
{noascii}: 可选参数。如果指定此参数，内存数据不会以ASCII格式保存

例如:
memdump iexplore.exe "c:\temp\dump.txt" "16" "0x10000" "0x400000"
memdump calc.exe "c:\temp\calc.txt" "32" "0x30000" "0x400000" nohex
memdump /525 "c:\temp\dump.txt" "16" "0x100000" "0x120000" noascii

service {\\Computer} [action] [service name]

改变驱动和服务的状态和启动类型
参数:
 

{\\Computer}: 可选参数。指定远程计算机名。如果忽略此参数，默认使用本地计算机.
[action]: 要进行的操作。此参数包含以下值:
start: 开启指定的服务或驱动程序.
stop: 停止指定的服务或驱动程序.
pause: 暂停指定的服务或驱动程序.
continue: 继续指定的服务或驱动程序.
restart: 停止并开启指定的服务或驱动程序.
auto: 修改指定的服务或驱动程序为自动.
manual: 修改指定的服务或驱动程序为手动.
disabled: 禁用指定的服务或驱动程序.
boot: (只适用于驱动程序)修改指定的驱动程序为引导(boot).
system: (只适用于驱动程序)修改指定的驱动程序为系统(system).
[service name]: 服务或驱动程序名.

例如:
service start schedule
service \\remote stop schedule
service restart w3svc

win [action] [find] [window to find] [Additional Parameters]

针对子窗口:

win child [find] [top window to find] [action] [find] [child window to find] [Additional Parameters]

通过此命令，可以关闭、隐藏、显示、最大化和最小化指定的窗口。
参数:

[action]: 对指定的窗口要进行的操作:
child: 对指定顶级窗口的子窗口进行操作.
close: 关闭指定窗口.
hide: 隐藏指定窗口.
show: 显示指定窗口(在用hide命令隐藏后).
hideshow: 隐藏指定窗口然后再显示此窗口。可用此命令重新填写窗口内容.
activate: 把指定窗口放到上层.
flash: Flash指定的窗口。[Additional Parameters]的值指定了帧的次数（默认是5）和每帧的毫秒数.
max: 最大化指定窗口.
min: 最小化指定窗口.
normal: 最大、最小化指定窗口后，恢复到正常状态.
trans: 使指定窗口透明。参数 [Additional Parameters] 指定透明程度，值位于0 - 255之间。0 = 完全透明。255 = 完全不透明 
setsize: 设定指定窗口的大小。参数 [Additional Parameters] 指定窗口的大小，值包括x，y，width(宽)，height(高). 
move: 移动/调整窗口。参数 [Additional Parameters] 指定要移动/调整的像素点数，值包括：x，y，width(宽)，height(高).  
center: 指定窗口居中.
settopmost: 设置指定窗口的最上层显示状态。如果参数 [Additional Parameters] 为1，指定窗口为最上层显示，如果为0，则取消最上层显示
redraw: 刷新指定窗口.
settext: 修改指定窗口标题/名称.
focus: 在指定窗口上设置焦点.
disable: 禁用指定窗口.
enable: 启用指定窗口.
+style: 对指定窗口增加样式常量。参数 [Additional Parameters] 指定了增加的样式常量.
-style: 移除指定窗口的样式常量。参数 [Additional Parameters] 指定要移除的样式常量.
+exstyle: 对指定窗口增加扩展样式常量。参数 [Additional Parameters] 指定要增加的扩展样式常量.
-exstyle: 移除指定窗口的扩展样式常量。参数 [Additional Parameters] 指定要移除的扩展样式常量.
postmsg: 传递信息到指定窗口。参数 [Additional Parameters] 中的三个值指定了信息参数：Msg, wParam, lParam.
sendmsg: 发送信息到指定窗口。参数 [Additional Parameters] 中的三个值指定了信息参数：Msg, wParam, lParam.
dlgclick: 发送一个鼠标单击命令到对话框内的按钮。参数 [Additional Parameters] 指定了按钮的控件ID，或者下列预定义的按钮之一： yes, no, ok, cancel, retry, ignore, close, help.
dlgsettext: 设置文本到对话框内部指定控件。参数 [Additional Parameters] 指定了控件ID.
dlgsetfocus: 设置焦点到对话框内部指定控件。参数 [Additional Parameters] 指定了按钮的控件ID.
[find]: 指定了找到窗口的方式:
handle: 通过在参数 [window to find] 中指定窗口句柄来查找指定窗口.
id: 通过指定子窗口的ID查找需要的子窗口。适用于子窗口.
class: 通过在参数[window to find]中指定窗口类名来查找指定窗口.
title: 通过在参数[window to find]中指定精确的窗口名来查找指定窗口.
stitle: 通过在参数[window to find]中指定窗口的前几个字符来查找指定窗口.
ititle: 通过指定一系列存在于窗口标题中的字符来查找指定窗口通过指定一系列存在于窗口标题中的字符来查找指定窗口.
alltop: 所有顶层窗口.
alltopnodesktop: 所有顶层窗口，除了桌面与盘符窗口.
active: 当前活动窗口.
foreground: 前台窗口.
desktop: 桌面窗口.
process: 通过指定进程ID(例如: /3412)或进程的名字(例如: firefox.exe)找到窗口.
[window to find]: 根据前面参数的值，通过句柄、类名或标题来指定窗口.

例如:
win close title "calculator"
win hide stitle "calculat"
win hide ititle "culat"
win show class "SciCalc"
win activate title "my computer"
win flash title "calculator" 10 500
win max handle 0x00009c01
win redraw alltop
win trans ititle "internet explorer" 192
win setsize class "IEFrame" 50 50 400 300
win settopmost class "SciCalc" 1
win child class "Shell_TrayWnd" hide class "button"
win child class "Shell_TrayWnd" show class "button"
win child title "calculator" hide id 128
win -style title "my computer" 0x00C00000
win child title "my computer" +exstyle all 0x00400000
win sendmsg title "calculator" 0x10 0 0
win dlgclick class "#32770" cancel
win max process firefox.exe
win max process /1275

cdrom [action] {drive:}

该命令用于打开和关闭CD-ROM光盘驱动器托盘。 [action] 参数可设置“open(开启)”或 “close(关闭)”。如果未指定 {drive:} 驱动器参数，默认所有CD-ROM光盘驱动器.


例如:
cdrom open
cdrom close
cdrom open J:
cdrom close R:

clipboard [Action] [Parameter]

允许写入以及清空剪切板.

[Action] 包含下列参数值之一：

set - 储存指定文本文件至剪切板.
readfile - 储存指定文本内容至剪切板.
clear - 清空剪切板.
writefile - 把剪切板中内容写入文件。(只适用于文本文件)
addfile - 把剪切板中内容添加到文件。(只适用于文本文件)
saveimage - 保存剪切板中的图像到文件.
copyimage - 复制指定图像文件中的图像到剪切板.
saveclp - 保存当前剪贴板数据到系统剪贴板文件.
loadclp - 加载系统剪贴板文件到剪贴板.
对于copyimage 和 saveimage 操作，支持以下格式：.

bmp, .gif, .jpg, .png, .tiff - 只在安装有GDI+的计算机上有效(在XP/2003/Vista上，GDI+已经作为操作系统的一部分被安装在计算机上)。
 
例如:
clipboard set "123456"
clipboard set ~$folder.desktop$
clipboard set ~$folder.start_menu$
clipboard readfile "c:\temp\info1.txt"
clipboard addfile "c:\temp\clip1.txt"
clipboard clear
clipboard saveimage "c:\temp\clip01.png"
clipboard saveimage "c:\temp\clip01.gif"
clipboard copyimage "c:\temp\img01.gif"
clipboard saveclp "c:\temp\1.clp"
clipboard loadclp "c:\temp\1.clp"

gac [Action] [Parameter]

允许安装全局程序集缓存(GAC)中的一个程序集.
例如:
gac install "C:\temp\MyAssembly\bin\Release\6\MyAssembly.dll"

beep [Frequency] [Duration]

发出嘟嘟响铃声。参数 [Frequency] 指定发声频率，单位赫兹。参数 [Duration] 指定发声持续时间，单位毫秒。在Windows 95/98/ME中, 以上参数被忽略，只会发出一声标准的嘟嘟响铃声


例如:
beep 500 2000

stdbeep

发出Windows标准嘟嘟响铃声.
例如:
stdbeep

setvolume [device] [left-volume] [right-volume]

设置音量。参数 [device] 代表声音设备标识符。大多数情况下，此参数设置为0。在Windows Vista下，默认重放设备指定为1，默认录音设备指定为0。
参数 [left-volume] 和 [right-volume] 值位于0(静音)和65535(最大音量)之间，代表了音量的左右声道.

　

例如:
setvolume 0 0 0
setvolume 0 32768 32768
setvolume 0 0xffff 0

setsysvolume [volume] {Component} {Device Index}

设置系统音量。修改此值亦会影响控制面板下的音量设置。参数 [volume] 的值位于0(静音)和65535(最大音量) 之间。
{Component} 是可选参数，指定了下列声音组件之一：master(主音量)、waveout(波形输出)、synth(合成器)、cd、microphone(麦克风)、phone、aux(音频输入口)、line(线路)、headphones(耳机)、wavein(波形输入)。默认值是master(主音量)。在Windows Vista下，声音窗口(控制面板->声音)下的显示的设备必须识别此组件名。如果设备名包含空格，两边必须加引号。
{Device Index} 是可选参数，指定了声音设备索引。如果有一个以上声卡，那么可以使用此参数。如果没有制定此参数，默认使用控制面板中指定的声卡


例如:
setsysvolume 0x8000
setsysvolume 0
setsysvolume 25000 waveout
setsysvolume 25000 master 1

Vista 例如:
setsysvolume 0x8000
setsysvolume 0 "front mic"
setsysvolume 25000 speakers
setsysvolume 25000 "line in"
setsysvolume 25000 default_record

setsysvolume2 [left volume] [right volume] {Component} {Device Index}

类似于setsysvolume命令，但此命令不是设置整个音量，而是单独设置左声道和右声道.


例如:
setsysvolume2 10000 20000
setsysvolume2 30000 0
setsysvolume2 25000 15000 waveout
setsysvolume2 30000 0 master 1

changesysvolume [volume change] {Component} {Device Index}

增加或降低系统音量。参数 [volume change] 指定增加或降低的单位。(负数降低，正数增加)
{Component} 是可选参数，指定了下列声音组件之一：master(主音量)、waveout(波形输出)、synth(合成器)、cd、microphone(麦克风)、phone、aux(音频输入口)、line(线路)、headphones(耳机)、wavein(波形输入)。默认值是master(主音量)。在Windows Vista下，声音窗口(控制面板->声音)下的显示的设备必须识别此组件名。如果设备名包含空格，两边必须加引号。
{Device Index} 是可选参数，指定了声音设备索引。如果有一个以上声卡，那么可以使用此参数。如果没有制定此参数，默认使用控制面板中指定的声卡

　

例如:
changesysvolume 5000
changesysvolume -3000
changesysvolume 0x1000 waveout
changesysvolume 0x1000 master 1

Vista 例如:
changesysvolume 5000
changesysvolume -3000
changesysvolume 0x1000 "line in"
changesysvolume 0x1000 "speakers" 1
changesysvolume 0x1000 default_record

changesysvolume2 [left volume change] [right volume change] {Component} {Device Index}

类似changesysvolume命令，但此命令不是设置整个音量，而是单独设置左声道和右声道

　

例如:
changesysvolume2 1000 -1000
changesysvolume2 -3000 0
changesysvolume2 0 -5000 waveout
changesysvolume2 -3000 0 master 1

mutesysvolume [action] {Component} {Device Index}

静音/取消静音
参数 [action] 中，指定1表示静音，0表示取消静音，2表示在静音与正常之间切换。
第二个参数为可选参数，可以指定下列声音组件之一：master(主音量)、waveout(波形输出)、synth(合成器)、cd、 microphone(麦克风)、phone、aux(音频输入口)、line(线路)、headphones(耳机)、wavein(波形输入)。默认 值是master(主音量)。在Windows Vista下，声音窗口(控制面板->声音)下的显示的设备必须识别此组件名。如果设备名包含空格，两边必须加引号。
{Device Index} 是可选参数，指定了声音设备索引。如果有一个以上声卡，那么可以使用此参数。如果没有制定此参数，默认使用控制面板中指定的声卡

　

例如:
mutesysvolume 1
mutesysvolume 0
mutesysvolume 2 waveout
mutesysvolume 1 master 1

Vista 例如:
mutesysvolume 1
mutesysvolume 0
mutesysvolume 2 "rear mic"
mutesysvolume 1 speakers 1
mutesysvolume 1 default_record

 

setappvolume [Process] [volume level] {Device Name/Index}

音量调整在 Windows 7/Vista/2008 的具体应用的具体应用.
参数 [process] 可以指定“exe”文件名(例如: Firefox.exe, iexplore.exe, wmplayer.exe),或完整路径文件名(例如:“F:\Program Files\Internet Explorer\iexplore.exe”)或进程ID(例如: /3426)
如果想要设置音量其中任意值，可以指定“focused”这个参数。
 [volume level] 音量电平参数在0和1之间。举例来说,如果你想把音量降低到50%,你应该把这个参数设置为0.5
 {Device Name/Index} 设备 名称/指令，这是一个可选参数。如果你不指定它,输出到默认设备。你可以指定设备指令为数字值(0＝第一个设备,1＝第二设备,等等),你也指定完整的设备的名称,如扬声器或耳机。查找系统中已有的音频设备,使用 showsounddevices 命令。

　

例如:
setappvolume iexplore.exe 0.2
setappvolume wmplayer.exe 0.75 Speakers
setappvolume /1275 0.25 1
setappvolume Firefox.exe 0.5
setappvolume focused 0.75

changeappvolume [Process] [volume level] {Device Name/Index}

音量控制 Increase/decrease(增加/减少)在Windows 7/Vista/2008系统的具体应用。
 [process] 参数，您可以指定的.exe文件名(例如：Firefox.exe, iexplore.exe, wmplayer.exe)，或完整路径文件名(例如:“F:\Program Files\Internet Explorer\iexplore.exe”)或进程ID(例如：/3426)
如果你想要改音量，可以设置“focused”参数。
 [volume level] 音量参数是一个介于0和1的正数或负数。正数增加音量，负数减小音量。例如，如果你想增加从20%(目前数量)到70%，你应该将此参数设置为0.5
 {Device Name/Index} 设备名称/指令}是可选的参数。如果你不指定它，默认的输出设备使用。你可以设置设备指令为数字值(0＝第一个设备,1＝第二设备,等等)您还可以指定喜欢的喇叭或耳机完整的设备名称。为了找出声音设备在您的系统，使用showsounddevices命令。

　

例如:
changeappvolume iexplore.exe -0.2
changeappvolume wmplayer.exe 0.55 Speakers
changeappvolume /1275 -0.25 1
changeappvolume Firefox.exe 0.5

muteappvolume [Process] [mute mode] {Device Name/Index}

在Windows 7/Vista/2008系统中，Increase/decrease 的具体应用。
用[process] 参数可以指定“exe”文件名(例如: Firefox.exe, iexplore.exe, wmplayer.exe),或完整路径文件名(例如:“F:\Program Files\Internet Explorer\iexplore.exe”)或进程ID(例如: /3426)
选择其中任意参数，可设置静音或消除静音。 mute/unmute 静音/消除静音。
 [mute mode] 静音模式包含下列参数值:
0 =消除静音
1 =静音
2 =静音/消除静音之间状态切换。
 {Device Name/Index} 设备名称/指令，可选择的参数。如果你不指定它,默认输出设备使用。你可以指定设备指令作为数字值(0＝第一个设备,1＝第二设备,等等),也可以指定完整的设备的名称,如扬声器或耳机。查找系统中已有的音频设备,使用showsounddevices命令。

　

例如:
muteappvolume iexplore.exe 0
muteappvolume wmplayer.exe 1 Speakers
muteappvolume /1275 2 1
muteappvolume Firefox.exe 1

showsounddevices

在Windows Vista/7/2008系统中，能显示所有音频设备的消息框列表。
这个命令支持Windows Vista/7/2008系统安装的音频设备。

wait [milliseconds]

等待指定的毫秒数.

例如:
wait 1000
wait 500

shellrefresh

进行Windows资源管理器的全面刷新。如果更改了注册表中相关的外壳文件类型，并且需要立即生效，此命令非常有效。 (例：如果改变了gif文件图标) 

sysrefresh {Refresh Type}

进行全面的系统刷新。在更改了注册表中的系统设置后可以使用此命令刷新系统(例：更改了图标大小，环境变量等等...)。{Refresh Type}为可选参数。可以指定下列值之一： "environment" - 更新系统变量，"policy" - 更新策略设置， "intl" - 更新本地设置。

例如:
sysrefresh
sysrefresh environment
sysrefresh policy

setcursor [X] [Y]

设置鼠标位置。参数 [X] 和 [Y] 指定光标位置


例如:
setcursor 100 50

setcursorwin [X] [Y]

设置鼠标光标的位置,相对于当前窗口的左上角。参数 [X] 和 [Y] 指定所需的光标位置。


例如:
setcursor 100 50

movecursor [X] [Y]

移动鼠标。参数 [X] 和 [Y] 指定移动的像素点数

　

例如:
movecursor 10 10

dlg [Process Name] [Window Title] [Action] [Parameters]

允许与Windows标准对话框和信息框进行交互。打开一个对话框时，可以使用此命令"点击"确认/取消/是/否按钮，或者将文本框填入对话框。
例如，下面的命令会将calc.exe进程填入Windows的"运行"对话框，然后点击"确认"按钮。12298是"运行"对话框中文本框的控件ID。 可以使用微软的Spy++或者使用my WinExplorer utility来查找控件ID。

dlg "explorer.exe" "run" settext 12298 "calc.exe"
dlg "explorer.exe" "run" click ok

　

下面的命令会对任何资源管理器的询问对话框点击"是"。
dlg "explorer.exe" "" click yes

　

下面的命令会对任何进程的询问对话框点击"否"。
dlg "" "" click cancel

　

参数描述:

[Process Name]: 指定要操作的窗口所从属的进程。可以仅指定进程名或者进程的完整路径。如果此参数为空串("")，命令会在任何进程上执行.
[Window Title]: 指定要操作的窗口的标题。如果此参数为空("")，命令会不管标题而在任何窗口上执行.
[Action]: 可以指定下列选项之一:
click: 点击指定按钮。可以指定下列预设值之一(仅适用于标准Windows对话框)： yes, no, ok, cancel, retry, ignore, close, help.还可以指定任何控件ID作为数字型值.
settext: 设置指定控件的文本。此操作的第一个参数指定控件ID，第二个参数指定文本.
dlgany [Process Name] [Window Title] [Action] [Parameters]

类似于dlg命令，但还可以用于其他任何窗口，包括非标准Windows对话框.

returnval [Return Value]

此命令允许为NirCmd命令指定返回值。在外部程序调用NirCmd.exe是会用到返回值。
例如，在下面命令中，如果用户选择"是"，则NirCmd返回值为0x30。

qboxcom "Do you want to continue ?" "question" returnval 0x30

sendkeypress [Keys Combination 1] [Keys Combination 2] [Keys Combination 3] ...

发送一个或多个按键组合。操作系统将完全按照用户的行为真的按下指定的组合组合键。
 [Key Combination] 组合键参数指定一个按键来发送或一个组合键(Shift/Ctrl/Alt/Windows键)，用“+”组合(例如：Shift+A，Ctrl+K，Alt+I，Ctrl+Alt+I，等等)。

【Down下翻页，Up上翻页，Left左方向，Right右方向，Home到页首，End到页尾，Insert改写键，Delete删除键，Plus加号，Comma逗号，Minus减号，Period句号，Down翻页键(下)，Up翻页键(上)，Left方向键(左)，Right方向键(右)，Home到页首，End到页尾，Insert改写键，Delete删除键，Plus加号，Comma逗号，Minus减号，Period句号，Lwin，Rwin，与(Windows键)组合】；

【apps应用程序】，【pageup翻页键(上)】，【pagedown翻页键(下)】，【Tab Tab键】，【multiply乘号】，【add加号】，【subtract减号】，【seperator除号】，【divide分号健】，【backspace退格健】，【pause暂停键】，【capslock大写键】，【numlock小键盘开关】，【scroll滚动键】，【printscreen屏幕硬拷贝】，

　

使用以上的 [Key Combination] 组合键组成一个或多个命令。

 下面是一些使用例子：

显示任务管理器窗口:
sendkeypress ctrl+shift+esc
显示任务管理器的窗户,然后移动到下一个窗口‘alt+tab’标签:
sendkeypress ctrl+shift+esc alt+tab
大写小写模式转换:
sendkeypress capslock
打印当前的文本编辑器内容(Shift键组合是用来获取的大写字母):
sendkeypress Shift+n i r spc shift+s o f e r
保存当前屏幕图像到剪贴板(等同按下Ctrl+PrintScreen):
sendkeypress Ctrl+printscreen
执行'Ctrl+Shift+K'与'Ctrl+Shift+A'和'Alt+Shift+P'命令:
sendkeypress ctrl+shift+k ctrl+shift+a alt+shift+p
sendkey [Key] [press | down | up]

向系统发送击键命令。操作系统会按照执行，就好像用户真的按压了键盘上指定键一样。
参数[key]指定虚拟键代码(如：0x2e代表delete键)，或者作为下列预设值之一：a - z 和 0 - 9(对应字母数字键)，F1 - F24 (对应Fxx键), shift, ctrl, alt, enter, esc。
第二个参数指定了指定键的操作：'press', 'down',或者 'up'。 对每一个down操作，还应该添加up操作。
在下面的脚本例子中，系统会执行就好像用户按了Shift+Ctrl+Esc一样 (会显示任务管理器):
 
sendkey shift down
sendkey ctrl down
sendkey esc down
sendkey shift up
sendkey ctrl up
sendkey esc up

更多例子:
sendkey a press
sendkey f10 press
sendkey enter press
sendkey 0x2e press

sendmouse [right | left | middle] [down | up | click | dblclick]

sendmouse [move] [x] [y]

sendmouse [wheel] [Wheel Value]

向系统发送指定的鼠标事件。操作系统会执行就好像用户真的做出了指定的鼠标操作。
一些sendmouse命令的例子:
发送点击鼠标右键事件(对大多数应用程序而言，会打开一个上下文本目录)：

　

发送点击鼠标右键事件(对大多数应用程序而言，会打开一个上下文本目录)：
sendmouse right click
发送一个双击鼠标左键事件:
sendmouse left dblclick
按下鼠标左键，把鼠标往左移动20像素点，向下移动30像素点，然后松开鼠标左键:
sendmouse left down
sendmouse move -30 20
sendmouse left up
滚动10个单位(标准滑轮鼠标)的鼠标滑轮。(在标准滑轮鼠标上，滑轮值是120的倍数).
sendmouse wheel 1200
convertimage [source filename] [destionation filename]

把图像文件转化为其他格式。支持一下格式：.bmp, .gif, .png, .jpg, .tiff
适用于Windows XP/2003/Vista (需要GDI+)

例如:
convertimage "c:\temp\test1.gif" "c:\temp\test1.png"
convertimage "c:\temp\test1.jpg" "c:\temp\test1.gif"

convertimages [source wildcard] [extension]

把多个图像文件转化为其他格式。支持以下格式：.bmp, .gif, .png, .jpg, .tiff
适用于Windows XP/2003/Vista (需要GDI+)

例如:
convertimages "c:\temp\a*.gif" .png
convertimages "c:\temp\*.jpg" .gif

savescreenshot [filename]

保存当前屏幕截图到指定的图像文件。支持以下格式.bmp, .gif, .png, .jpg, .tiff
适用于Windows XP/2003/Vista (需要GDI+)

例如:
savescreenshot "c:\temp\shot.png"

savescreenshotfull [filename]

类似savescreenshot，但在具有多个监视器的计算机上，该命令将采集所有监视器的屏幕截图， savescreenshot只采集主监视器的屏幕截图.

savescreenshotwin [filename]

保存当前活动窗口截图到指定图像文件支持以下格式 .bmp, .gif, .png, .jpg, .tiff
适用于Windows XP/2003/Vista (需要GDI+)

例如:
savescreenshotwin "c:\temp\win.png"

shellcopy [source file or wildcard] [destination] {Flags}

从一个文件夹复制一个或多个文件到其他文件夹，并且就像资源管理器下复制文件时一样显示进程框。
对于参数{Flags}，可以指定一个或多个下列值：

yestoall: 对所有询问回答"是".
noerrorui: 在用户界面不显示错误信息.
silent: 安静模式 - 不显示复制进度信息.
nosecattr: 不复制文件的相关属性.
例如:
shellcopy "c:\temp\*.*" "d:\temp"
shellcopy "c:\temp\*.*" "d:\temp" yestoall noerrorui

filldelete [source file or wildcard]

零字节填充指定文件或通配符文件，然后删除文件。这也就意味着用此命令删除掉的文件不可再被恢复.

例如:
filldelete "c:\temp\*.*"
filldelete "c:\temp\myfile.dat"

speak [type] [text/Filename] {rate} {volume}

通过使用Windows XP和Windows Vista中的语音库(SAPI),朗读指定的文本或者文件的内容.
在[type]参数可以指定下列类型： 

text: 简单的文本.
xml: 语音XML数据文本.
file: 文本文件的文件名.
{rate}是一个可选的指定语速的参数，数值在-10（非常缓慢）和10（非常快）之间.{volume}参数指定音量，数值在0和100之间.

例如:
speak text ~$clipboard$
speak text "Please visit the Web site of NirSoft at http://www.nirsoft.net" 2 80
speak file "c:\temp\speak1.txt"

elevate [Program] {Command-Line Parameters}

对于Windows Vista/7/2008只有以管理员权限运行程序。当[Program]包含一个或多个空格字符,你必须把它放在引号里。

　

例如:
elevate notepad.exe
elevate notepad.exe C:\Windows\System32\Drivers\etc\HOSTS
elevate "c:\program files\my software\abc.exe"

elevatecmd [NirCmd command]

对于Windows Vista/7/2008命令:运行一个管理员权限NirCmd命令。

例如:
elevatecmd regsetval binary "HKLM\Software\Test" "Value1" "6a cb ab dd 80 86 95"

runas [Domain\User] [Password] [Process and Command-Line Parameters]

运行过程中指定的 name/password 用户名/密码。第一个参数,可以按照下面的3种格式: user@domain用户名  User\Domain用户\域

例如:
runas admin1 Password1 "F:\Program Files\Mozilla Firefox\firefox.exe"
runas Domain01\user01 myp234Jk c:\temp\myprogram.exe
runas user01@domain.com Nm1923a "c:\temp\myprogram.exe" -a -k

trayballoon [Title] [Balloon Text] [Icon File] [Timeout]

显示一个托盘弹出框(Windows XP及以上版本)。注意,当使用这个命令,NirCmd将继续运行,一直到弹出框关闭或消失。
[Title]参数的书名是弹出框和 [Balloon Text] 弹出框文字参数，指定文本显示在弹出框内。在 [Icon File]参数,你可以指定.ico文件(例如:c:\icons\myicon.ico)或exe文件与dll图标文件。(例如: shell32.dll,-154)
[Timeout]参数指定了的毫秒数来等待弹出框就消失。

例如:
trayballoon "Hello" "This is a test..." "shell32.dll,22" 15000
trayballoon "Hello" "This is the text that will be appear inside the balloon !" "shell32.dll,-154" 10000
trayballoon "Hello" "This is the text that will be appear inside the balloon !" "c:\temp\icon1.ico" 10000

setconsolemode [mode]

设置控制台显示模式。仅供nircmdc.exe有关
设置[mode]参数,可以指定1为全屏模式或2控制台窗口模式。

setconsolecolor [forecolor] [backcolor]

仅供nircmdc.exe参考
设置当前的前景和背景颜色的文字在控制台窗口。这个命令不会改变现有文本的颜色,但所有文本送到stdout(命令)consolewrite后这个命令将显示指定的颜色。
利用 forecolor/backcolor 参数,可以指定任何EGA色号介于0到15:

0 - 黑色
1 - 蓝色
2 - 绿色
3 - 青色
4 - 红色
5 - 品红
6 - 棕色
7 - 白色
8 - 深灰色
9 - 亮蓝色
10 - 亮绿色
11 - 亮青色
12 - 鲜红色
13 - 亮洋红
14 - 亮黄色
15 - 亮白色 
例如:
setconsolecolor 10 0
setconsolecolor 1 15

consolewrite [text]

将指定文本输出到标准输出(stdout). 

debugwrite [text]

写特定文本进入调试输出。您可以查看该文本发送的这个命令的效果。 

:helps
cls
findstr "^::" "%~f0"|more
echo;
exit /b
::
::  - FILE: DIY控制台,gcc 3.4.0,notepad++ 8.1.0 ,Gvim提取
::  - Compile: Tcc,sed,nircmd,sed,grep...等外部命令和.bat脚本集合,
::    部分exe有源文件.cpp/.c
::  - 杀毒软件可能报毒是正常的,外部命令调用系统API才能做更多事情,
::    随后的添加注册表操作需要管理员权限
::

::::::::::::::::::::helps_xconvert.exe::::::::::::::::::::::

/*&@echo off
set "file=%~1"
set "exefile=%~dp0\xconvert.exe"
for /f "delims=" %%a in ('dir /a-d-h-s-r/b/s "%file%\*.jp*";"%file%\*.png"') do (
    for /f "tokens=1,2 delims=x" %%b in ('cscript -nologo -e:jscript "%~f0" "%%~a"') do (
		echo;IF [%%~b ^< %%~c] DO %%a
		if %%~b lss %%~c (
		     "%exefile%" "%%a" +repage -rotate -90 "%%a"
			  echo;%%~a**%%~b*%%~c
		)
	)
)
pause
exit
*/
var wi=new ActiveXObject('WIA.ImageFile');
var w=0;
var h=0;
try{
    wi.LoadFile(WSH.Arguments(0));
    w=wi.Width;
    h=wi.Height;
}catch(e){}
WSH.echo(w.toString()+'x'+h.toString());
wi =null;
WSH.Quit();