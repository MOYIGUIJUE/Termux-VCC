@echo off & title 
For %%i in (- / \) Do (
	If /i "%1"=="%%ih" Goto :helps
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
echo;  ^< Ä¿Â¼ ^>
echo;
CmdMenuSel 0708 "  - µÚÒ»ÕÂ °²×°ºÍÊ¹ÓÃ" "  - µÚ¶şÕÂ »ù´¡½Ì³Ì" "  - µÚÈıÕÂ ½ø½×½Ì³Ì" "  - µÚËÄÕÂ ÁË½â±¾Íâ²¿ÃüÁî¼¯ºÏ" "  - µÚÎåÕÂ Íâ²¿ÃüÁî" "  - µÚÁùÕÂ ±àĞ´Íâ²¿ÃüÁî"
cls
goto :book_%errorlevel%

:book_1
gotoxy -l 0 0
echo;  - µÚÒ»ÕÂ °²×°ºÍÊ¹ÓÃ
echo;
echo;  - ÏÈÕâÑù,ÔÙÄÇÑù
echo;  - Ñ§»áÁË°É,µã»÷È·¶¨
length "È·¶¨"
call :mouse 40 7 %errorlevel% 7 70 "È·¶¨" 1
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
echo;  - µÚ¶şÕÂ »ù´¡½Ì³Ì

call :showcmd "paths"
call paths
printf 0x0a %used%@%COMPUTERNAME%
printf 0x09 [%cd%]
printf 0x07 "$ "
timeout 1 >nul
printf -t 0x07 100 "path | sed \"s/;/\n/g\" | sed \"/^$/d\" | nl"
timeout 1 >nul
call :Type "  - ²é¿´»·¾³±äÁ¿"
path | sed "s/;/\n/g" | sed "/^$/d" | nl

exit /b

:book_3
echo;  - µÚÈıÕÂ ½ø½×½Ì³Ì
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
echo;  - µÚËÄÕÂ ÁË½â±¾Íâ²¿ÃüÁî¼¯ºÏ
echo;
echo;[·­Òë] Âé·³Ã»À´ÕÒÄã£¬¾Í±ğÈ¥×ÔÕÒÂé·³¡£  - °´ESCÌø¹ı
echo;[ÌáÊ¾] µÚÒ»¡¢ËÄ¸ötroubleÊÇ¶¯´Ê£¬µÚ¶ş¡¢Èı¸ötroubleÊÇÃû´Ê¡£
words "[-] Never trouble trouble" "till" "trouble troubles you¡£"
echo;	                  ----
call :showcmd "pause >nul"
pause >nul

echo;[µ¥´ÊÊÍÒâ]till
echo;	v.¸û×÷£»ÀçµØ
echo;	prep.Ö±µ½¡­ÎªÖ¹£»Ö±µ½¡­²Å¡­£»ÔÚ¡­Ç°(²»¡­)
echo;	conj.Ö±µ½¡­ÎªÖ¹£»ÔÚ¡­Ö®Ç°
echo;	n.ÊÕÒøÌ¨£»£¨ÏÖ½ğ³öÄÉ»úµÄ£©·ÅÇ®µÄ³éÌë
echo;	ÍøÂçÖ±µ½¡­¡­ÎªÖ¹£»°®µÄÊÄÑÔ£»¸ûÖÖ
echo;	µÚÈıÈË³Æµ¥Êı£ºtills  ÏÖÔÚ·Ö´Ê£ºtilling  ¹ıÈ¥Ê½£ºtilled
exit /b

:book_5
echo;  - µÚÎåÕÂ Íâ²¿ÃüÁî
call :showcmd "start cmatrix"
start cmatrix.exe
echo;	Æô¶¯Êı×ÖÓê³ÌĞò
call :showcmd "zms"
start zms.exe
echo;	ÉèÖÃÎªProgman×Ó´°¿Ú£¬Ç¶Èë×ÀÃæ
exit /b

:book_6
title;µÚÁùÕÂ ±àĞ´Íâ²¿ÃüÁî

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
echo;©À©¤  %cd%
gotoxy -l %wide% 2
echo;©¦   ©¸  test.c     
gotoxy -l %wide% 3
echo;©À©¤  server
gotoxy -l %wide% 4
echo;©¦   ©¦  callbacks.h     
gotoxy -l %wide% 5
echo;©¦   ©¸©¤ ini
gotoxy -l %wide% 6
echo;©¦   ©¦      ini.h
gotoxy -l %wide% 7
echo;©¸©¤  zombie 

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
echo;©À©¤  %cd% 
gotoxy -l %wide% 2           
echo;©¦      test.c        
gotoxy -l %wide% 3         
echo;©¦      test.exe       
gotoxy -l %wide% 4        
echo;©À©¤  server             
gotoxy -l %wide% 5
echo;©¦   ©¦  callbacks.h       
gotoxy -l %wide% 6
echo;©¦   ©¸©¤ ini         
gotoxy -l %wide% 7
echo;©¦          ini.h      
gotoxy -l %wide% 8
echo;©¸©¤  zombie    

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
	echos 0x06 [ÊäÈëÃüÁî]
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

	Set "Block=ÛÛ"
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
%= ÈÕÆÚ: 2022 Äê 9 ÔÂ 10 ÈÕ =%
%= Ãû³Æ: Type =%
%= ×÷ÓÃ: Ä£Äâ´ò×Ö =%
%= ²ÎÊı: String ÒªÏÔÊ¾µÄ×Ö·û´® =%
%= ±¸×¢: ´Ëº¯ÊıÒª·ÃÎÊ»·¾³±äÁ¿ _._ =%
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
%= VT100 º¯Êı =%
%================================================================================================================================%

%================================================================%
%= ÈÕÆÚ: 2022 Äê 9 ÔÂ 9 ÈÕ =%
%= Ãû³Æ: InitVT100 =%
%= ×÷ÓÃ: ³õÊ¼»¯ Windows 10 µÄ ĞéÄâÖÕ¶ËĞòÁĞ =%
%================================================================%
:InitVT100
%= { =%

	%= »ñÈ¡ ESC ×Ö·û =%

	Set "ESC="

	%= Èç¹ûÃ»ÓĞ¶¨Òå ESC ×Ö·û£¬Õâ¸ö¹ı³ÌÊÇÎªÁË·ÀÖ¹ÂÛÌ³ÎóÍÌÉÏÎÄµÄ ESC ×Ö·û =%
	If Not Defined ESC (

		For /F "Delims=#" %%_ in ('Prompt #$E# ^& Echo On ^& For %%$ in ^(1^) Do DosKey') Do Set "ESC=%%_"
		REM for /F %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
	)

%= } =%
@Goto :Eof

%================================================================%
%= ÈÕÆÚ: 2022 Äê 9 ÔÂ 9 ÈÕ =%
%= Ãû³Æ: GotoXY =%
%= ×÷ÓÃ: ¶¨Î»¹â±êµ½Ö¸¶¨Î»ÖÃ =%
%= ²ÎÊı: X ¹â±êµÄ X Öá×ø±ê£¬Èç¹ûÊ¡ÂÔ»òÉèÎª 0£¬ÔòÉèÆäÎª1 =%
%= ²ÎÊı: Y ¹â±êµÄ Y Öá×ø±ê£¬Èç¹ûÊ¡ÂÔ»òÉèÎª 0£¬ÔòÉèÆäÎª1 =%
%================================================================%
:GotoXY <X> <Y>
%= { =%

	%= Èç¹ûÃ»ÓĞ¶¨Òå ESC ×Ö·û =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	%= ¶¨Î»¹â±ê =%
	Set /P=%ESC%[%2;%1H< Nul

%= } =%
@Goto :Eof

%================================================================%
%= ÈÕÆÚ: 2022 Äê 9 ÔÂ 9 ÈÕ =%
%= Ãû³Æ: SetConsoleTextAttribute =%
%= ×÷ÓÃ: ÉèÖÃ¿ØÖÆÌ¨ÎÄ±¾ÑÕÉ« =%
%= ²ÎÊı: BGCOL ±³¾° RGB ÑÕÉ«Öµ£¬¸ñÊ½ÎªR-G-B =%
%= ²ÎÊı: FGCOL Ç°¾° RGB ÑÕÉ«Öµ£¬¸ñÊ½ÎªR-G-B =%
%================================================================%
:SetConsoleTextAttribute <BGCOL> <FGCOL>
%= { =%

	%= Èç¹ûÃ»ÓĞ¶¨Òå ESC ×Ö·û =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	%= ÉèÖÃ±³¾°É« =%
	For /F "Delims=-, Tokens=1,2,3" %%I in ("%1") Do (
		Set /P=%ESC%[48;2;%%I;%%J;%%Km< Nul
	)

	%= ÉèÖÃÇ°¾°É« =%
	For /F "Delims=-, Tokens=1,2,3" %%I in ("%2") Do (
		Set /P=%ESC%[38;2;%%I;%%J;%%Km< Nul
	)

%= } =%
@Goto :Eof

%================================================================%
%= ÈÕÆÚ: 2022 Äê 9 ÔÂ 9 ÈÕ =%
%= Ãû³Æ: SetConsoleCursorInfo =%
%= ×÷ÓÃ: ÉèÖÃ¿ØÖÆÌ¨¹â±êÊôĞÔ =%
%= ²ÎÊı: CursorVisibility ¹â±ê¿É¼ûºÍÉÁË¸×´Ì¬£¬È¡Öµ1~4£¬·Ö±ğÎª£º =%
%=       1 ÏÔÊ¾¹â±ê =%
%=       2 Òş²Ø¹â±ê =%
%=       3 ¿ªÊ¼¹â±êÉÁË¸ =%
%=       4 Í£Ö¹ÉÁË¸¹â±ê =%
%= ²ÎÊı: CursorShape      ×Ô¶¨Òå¹â±êĞÎ×´£¬È¡Öµ0~6£¬·Ö±ğÎª£º =%
%=       0 ÓÃ»§ÅäÖÃµÄÄ¬ÈÏ¹â±êĞÎ×´ =%
%=       1 ÉÁË¸¿é¹â±êĞÎ×´ =%
%=       2 ÎÈ¶¨¿é¹â±êĞÎ×´ =%
%=       3 ÉÁË¸ÏÂ»®Ïß¹â±êĞÎ×´ =%
%=       4 ÎÈ¶¨ÏÂ»®Ïß¹â±êĞÎ×´ =%
%=       5 ÉÁË¸ÌõĞÎ¹â±êĞÎ×´ =%
%=       6 ÎÈ¶¨ÌõĞÎ¹â±êĞÎ×´ =%
%================================================================%
:SetConsoleCursorInfo <CursorVisibility> <CursorShape>
%= { =%

	%= Èç¹ûÃ»ÓĞ¶¨Òå ESC ×Ö·û =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	%= ÉèÖÃ¹â±ê¿É¼ûºÍÉÁË¸×´Ì¬ =%
	For /F "Delims=-, Tokens=%1" %%I in ("25h-25l-12h-12l") Do (
		Set /P=%ESC%[?%%I< Nul
	)

	Set /P=%ESC%[%2 q< Nul

%= } =%
@Goto :Eof

%================================================================%
%= ÈÕÆÚ: 2022 Äê 9 ÔÂ 9 ÈÕ =%
%= Ãû³Æ: SetConsoleTextAttributeEx =%
%= ×÷ÓÃ: ¸ñÊ½»¯¿ØÖÆÌ¨ÎÄ±¾ =%
%= ²ÎÊı: Code ²Ù×÷´úÂë£¬È¡Öµ1~6£¬·Ö±ğÎª£º =%
%=       1 Ä¬ÈÏ£¬Í¨³£Ïàµ±ÓÚColor 07 =%
%=       2 ´ÖÌå/ÁÁ =%
%=       3 ÎŞ´ÖÌå/ÁÁ =%
%=       4 ÏÂ»®Ïß =%
%=       5 ÎŞÏÂ»®Ïß =%
%=       6 ½»»»Ç°¾°É«ºÍ±³¾°É« =%
%================================================================%
:SetConsoleTextAttributeEx <Code>
%= { =%

	%= Èç¹ûÃ»ÓĞ¶¨Òå ESC ×Ö·û =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	For /F "Delims=-, Tokens=%1" %%I in ("0-1-22-4-24-7") Do (
		Set /P=%ESC%[%%Im< Nul
	)

%= } =%
@Goto :Eof

REM ----------------------------------------------help command----------------------------------------------

  REM - cmdow

Ö´ĞĞcmdow @£¬ÏÔÊ¾Îª
Handle Lev Pid -Window status- Image Caption
0x230088 1 3356 Res Act Ena Vis cmd C:\WINDOWS\system32\cmd.exe - cmd - cm
window Ö¸¶¨ÒªÁĞ³öµÄ´°¿Ú£¬Ê¹ÓÃ´°¿Ú±êÌâ»ò¾ä±úÀ´Ö¸¶¨£¬Ã»ÓĞ±êÌâµÄÓÃ´°¿ÚÀà´úÌæ¡£Èç¹ûÃ»ÓĞÖ¸¶¨ÔòÁĞ³öËùÓĞ´°¿Ú¡£¡°@¡±±íÊ¾´Ë´°¿Ú£¬¼´ÃüÁîĞĞ´°¿Ú¡£
/T Ö»ÁĞ³öÈÎÎñÀ¸µÄ´°¿Ú
/B ÈçÉÏÃæµÄÀı×Ó£¬¼ÓÕâ¸ö²ÎÊıÔò²»ÏÔÊ¾µÚÒ»ĞĞ
/F ÏÔÊ¾ÍêÕû±êÌâ
/P ÁĞ³ö´°¿ÚÎ»ÖÃ¡¢¿íÓë¸ß
ÁíÍâ
Handle ¾ä±ú£¬16½øÖÆ¸ñÊ½
Window status ´°¿Ú×´Ì¬£¨Minimized, Maximized, Restored, Active, Inactive, Enabled, Disabled, Visible or Hidden£©

CMDOW /TH | /TV | /CW | /MA | /UW | /AT | /FS | /WM/TH ºáÏòÆ½ÆÌ´°¿Ú
/TV ×İÏòÆ½ÆÌ´°¿Ú
/CW ²ãµş´°¿Ú
/MA ×îĞ¡»¯ËùÓĞ´°¿Ú
/UW È¡Ïû/TH, /TV, /CW , /MA
/AT Ïàµ±ÓëAlt+Esc
/FS È«ÆÁÃüÁîĞĞ´°¿Ú£¬Ïàµ±ÓÚAlt+Enter
/WM È¡ÏûÈ«ÆÁ£¬¼´ÔÙ°´Ò»´ÎAlt+Enter

CMDOW window {[/ACT] [/INA] [/ENA] [/DIS] [/VIS] [/HID] [/MIN] [/MAX] [/RES] [/TOP] [/NOT] [/REN caption] [/MOV left top] [/SIZ width height] [/CLS] [/END]}/ACT ¼¤»îÖ¸¶¨´°¿Ú
/INA ²»ÖªÓĞÉ¶ÓÃ
/DIS °Ñ´°¿Ú±äÎª¡°Ö»Ğí¿´²»×¼Ãş¡±£ºÎŞ·¨ÒÆ¶¯¡¢Êó±ê×óÓÒ¼üÎŞĞ§£¬¸ü±ğËµÊäÈëÁË¡£µ«¿ÉÒÔÓÃ¿ì½İ¼ü¹Ø±Õ¡£
/ENA ½â³ı/DIS
/HID Òş²Ø´°¿Ú£¬ÈÎÎñÀ¸ºÍÍĞÅÌ½Ô¿´²»µ½
/VIS ÏÔÊ¾±»Òş²ØµÄ´°¿Ú
/MIN ×îĞ¡»¯Ö¸¶¨´°¿Ú
/MAX ×î´ó»¯Ö¸¶¨´°¿Ú
/RES ³·Ïú¡£±ÈÈç³·Ïúµ½´°¿ÚÔ­À´µÄ´óĞ¡ºÍÎ»ÖÃ¡£²»ÄÜ³·ÏúÁ½´Î£¬³·Ïúºó²»¿ÉÒÔ·µ»Ø³·ÏúÇ°µÄ×´Ì¬¡£
/TOP ÖÃ¶¥´°¿Ú¡£ÈçÖÃ¶¥ÁË¶à¸ö£¬ÔòµÚÒ»¸öÖÃ¶¥ÔÚ×îÉÏÃæ£¬ÖÃ¶¥ÁËµÄ¶¼»á±£ÁôÖÃ¶¥×´Ì¬¡£
/NOT È¡Ïû´°¿ÚÖÃ¶¥
/REN caption ÖØÃüÃû´°¿Ú±êÌâ
/MOV left top ÒÆ¶¯´°¿Ú ¾à×ó±ß¾àÀë ¾àÉÏ±ß¾àÀë
/SIZ width height ¸Ä±ä´°¿Ú¿í¡¢¸ß
/CLS ¹Ø±Õ´°¿Ú
/END ½áÊø½ø³Ì¡£¿Ö²ÀµÄÊÇÏàÍ¬PIDµÄ»áÒ»ÆğKillµô£¬Ğ¡ĞÄÊ¹ÓÃ£¡

cmdow @ /siz 700 350

CMDOW /RUN [state] file [args]state ÔËĞĞ·½Ê½£¨/MIN /MAX /HID£©

  REM - jpeg

-te <ÆäËûjpegÎÄ¼ş>
½«ÆäËûjpegÎÄ¼şµÄeixfµ¼ÈëÄ¿±êjpeg¡£ÀıÈç"jhead ¨Cte D:\My Pictures\B.jpg D:\My Pictures\A.jpg"

-dc
É¾³ıjpegĞÅÏ¢ÖĞµÄ±¸×¢¡£×¢Òâ£¬jpegÎÄ¼şÓĞÁ½¸ö±¸×¢£¬Ò»ÊÇºÍÆäËûÎÄ¼şÒ»ÑùµÄ±¸×¢£¬ÁíÒ»¸öÊÇexifĞÅÏ¢ÖĞµÄ±¸×¢¡£jhead½ö¶ÔexifĞÅÏ¢ÓĞĞ§¡£
-de
ÍêÈ«É¾³ıexifĞÅÏ¢¡£
-du
É¾³ı·ÇÔ­Ê¼exifĞÅÏ¢£¬ÀıÈçPhotoshop¡¢TurbophotoÖ®Àà±à¼­ºóĞŞ¸ÄexifÁôÏÂµÄĞÅÏ¢¡£
-purejpg
É¾³ıËùÓĞjpegÎÄ¼ş·Ç±ØĞëµÄĞÅÏ¢¡£Ïàµ±ÓÚ-de¡¢-dcºÍ-duµÄ¼¯ºÏ£¬¿ÉÒÔ½«ÎÄ¼ş¼õĞ¡Êık¡£
-ce
ĞŞ¸ÄÎÄ¼şµÄjpegÎÄ¼şÍ·²¿·Ö±¸×¢£¨´Ë±¸×¢²¢·ÇexifĞÅÏ¢£©¡£¸ÃÖ¸Áî»á´ò¿ªÎÄ±¾±à¼­Æ÷£¬²¢ÔÚ±à¼­Æ÷¹Ø±ÕÊ±½«±¸×¢ĞÅÏ¢´æÈëÎÄ¼ş¡£
-cs <ÎÄ±¾ÎÄ¼ş>
µ¼³ö±¸×¢¡£ÀıÈç"jhead ¨Ccs D:\1.txt D:\My Pictures\A.jpg"
-ci <ÎÄ±¾ÎÄ¼ş>
µ¼Èë±¸×¢¡£ÀıÈç"jhead ¨Cci D:\1.txt D:\My Pictures\A.jpg"
-cl <±¸×¢ÎÄ×Ö>
Ö±½ÓÊäÈë±¸×¢¡£¡£ÀıÈç"jhead ¨Ccl ÎÒµÄ±¸×¢ D:\My Pictures\A.jpg"
¶ş¡¢ÆäËûÖ¸Áî
Ê±¼äÈÕÆÚ
-ft ½«jpegÎÄ¼şµÄ¡°ĞŞ¸ÄÊ±¼ä¡±ĞŞ¸ÄÎªexifĞÅÏ¢ÖĞ¼ÇÂ¼µÄÊ±¼ä¡£
-n[<¸ñÊ½-Ë³Ğò>] ¸ÃÖ¸Áî»á½«ÎÄ¼şÃûĞŞ¸ÄÎªexifĞÅÏ¢ÖĞ¼ÇÂ¼µÄ¡°´´½¨Ê±¼ä¡±£»Èç¹ûjpegÎÄ¼şÃ»ÓĞexif»òÕßexifÖĞµÄ´´½¨Ê±¼ä²»¿ÉÓÃ£¬Ôò½«ÎÄ¼şÃûĞŞ¸ÄÎªÎÄ¼şµÄ¡°ĞŞ¸ÄÊ±¼ä¡±¡£
Ä¬ÈÏµÄ¸ñÊ½-Ë³ĞòÎªMMDD-HHMMSS
¸ñÊ½-Ë³Ğò²ÎÊıÈçÏÂ£º
%d-ÈÕ(01-31)
%H-Ğ¡Ê±(00-23)
%j-Ò»ÄêÖĞµÄµÚ¼¸Ìì(001-366)
%m-ÔÂ(01-12)
%M-·ÖÖÓ(00-59)
%S-Ãë(00-59)
%U-Ò»ÄêÖĞµÄµÚ¼¸ÖÜ(00-53)
%w-ĞÇÆÚ¼¸(0-6£¬ÖÜÈÕÎª0)
%y-Á½Î»Êı¼ÍÄê(00-99)
%Y-ËÄÎ»Êı¼¸Äê
%i-Ìí¼ÓÊı×ÖĞòºÅ
ÀıÈç£º
jhead -n%Y%m%d-%H%M%S d:\*.jpg
½«ËùÓĞjpgÎÄ¼şĞŞ¸ÄÎªYYYYMMDD-HHMMSS.jpgµÄ¸ñÊ½¡£
-nf Óë¡°-n¡±ÏàÍ¬¹¦ÄÜÏàÍ¬£¬²»±£ÁôÔ­ÎÄ¼şÃû¡£
-a ĞŞ¸Ä²»Í¬À©Õ¹ÃûµÄÍ¬ÃûÎÄ¼şÃû£¬Ïà»úÅÄÉãµÄavi¶ÌÆ¬exifĞÅÏ¢´æ´¢ÔÚÓëÆäÍ¬ÃûµÄthmÎÄ¼şÖĞ£¬¿ÉÓÃ´ËÖ¸Áî¸øaviÎÄ¼ş¸üÃû¡£Ò»°ãÓë¡°-n¡±Ö¸Áî¹²Í¬Ê¹ÓÃ¡£
-ta<Ê±²î> ĞŞÕıÊ±²î£¬ÀıÈçÊ±²î¸ù¾İÊ±ÇøÈ·¶¨£¬ÀıÈç+1:00»òÕß-1:00
-da<ÈÕÆÚ>-<ÈÕÆÚ> ĞŞÕıÈÕÆÚ¡£ÈÕÆÚ¸ñÊ½ÊÇyyyy:mm:dd¡¢yyyy:nn:dd+hh:mm»òÕß yyyy:mm:dd+hh:mm:ss¡£¸ù¾İÇ°ºó²ÎÊıÊ±¼ä²îµ÷ÕûexifµÄÊ±¼ä¡£
-ts<ÈÕÆÚ-Ê±¼ä> Ö±½ÓĞŞ¸ÄexifÖĞµÄÅÄÉãÊ±¼ä£¬ÈÕÆÚ-Ê±¼ä¸ñÊ½Îªyyyy:mm:dd-hh:mm:ss
ËõÂÔÍ¼

-dt É¾³ıexifÖĞµÄËõÂÔÍ¼¡£Õâ¸öËõÂÔÍ¼Ò»°ãÎª240x160ÏñËØ£¬10k´óĞ¡£¬ÓÃÓÚÊıÂëÏà»ú¡¢Windows XP²é¿´ÕÕÆ¬£¬É¾³ıËü²»»áÓ°Ïì¹¤×÷¡£
-st <ÎÄ¼şÃû> ½«exifÖĞµÄËõÂÔÍ¼¸´ÖÆÎªÁíÒ»¸öjpegÎÄ¼ş
-rt <ÎÄ¼şÃû> ÓÃÁíÒ»¸öjpegÎÄ¼şÌæ»»exifÖĞµÄËõÂÔÍ¼
-rgt[´óĞ¡] Ë¢ĞÂexifËõÂÔÍ¼£¬ÆäÖĞ´óĞ¡ÎªËõÂÔÍ¼µÄ×î´ó±ß³¤¡£
Ğı×ª
-autorot ¸ù¾İexifÖĞ¼ÇÂ¼µÄË®Æ½·½ÏòĞÅÏ¢×ª¶¯jpegÕÕÆ¬¡£
-norot Çå³ıexifÖĞµÄË®Æ½·½ÏòĞÅÏ¢¡£


  REM - nircmd

nircmd setdefaultsounddevice

µ¯³öÅÌ·ûÎªJµÄ¹âÇı

NirCmd.exe cdrom open j:

µ¯ÈëÅÌ·ûÎªYµÄ¹âÇı

nircmd.exe cdrom close y:

Ôö¼Ó2000¸öµ¥Î»µÄÏµÍ³ÒôÁ¿(×î´ó65535)

nircmd.exe changesysvolume 2000

½µµÍ5000¸öµ¥Î»µÄÏµÍ³ÒôÁ¿(×î´ó65535)

nircmd.exe changesysvolume -5000

ÉèÖÃÎª×î¸ßÒôÁ¿

nircmd.exe setsysvolume 65535

ÉèÖÃÎª¾²Òô

nircmd.exe mutesysvolume 1

È¡Ïû¾²Òô

nircmd.exe mutesysvolume 0

ÔÚ¾²ÒôÓëÕı³£×´Ì¬Ö®¼äÇĞ»»

nircmd.exe mutesysvolume 2

ÔÚ×ÀÃæ´´½¨¾²ÒôÓëÕı³£×´Ì¬ÇĞ»»ÃüÁîµÄ¿ì½İ·½Ê½

nircmd.exe cmdshortcut "~$folder.desktop$" "Switch Volume" mutesysvolume 2

¹Ø±ÕÏÔÊ¾Æ÷

nircmd.exe monitor off

Æô¶¯Ä¬ÈÏÆÁ±£

nircmd.exe screensaver

½øÈë´ı»ú×´Ì¬

nircmd.exe standby

×¢Ïúµ±Ç°ÓÃ»§

nircmd.exe exitwin logoff

µ¯³ö¶Ô»°¿ò£¬Ñ¯ÎÊÊÇ·ñÖØÆô¡£Ñ¡ÔñÊÇÔòÖØÆôµçÄÔ

nircmd.exe qboxcom "Do you want to reboot?" "question" exitwin reboot

¹Ø±Õcomputers.txtÖĞÖ¸¶¨µÄËùÓĞ¼ÆËã»ú

multiremote copy "c:\temp\computers.txt" exitwin poweroff force

²¦ºÅÁ¬½Óµ½"My Internet"

nircmd.exe rashangup "My Internet"

ÉèÖÃIE´°¿ÚÎª75%Í¸Ã÷¶È(192/256)

nircmd.exe win trans ititle "internet explorer" 192

×îĞ¡»¯ËùÓĞµÄIE´°¿Ú

nircmd.exe win min class "IEFrame"

¹Ø±ÕËùÓĞµÄIE´°¿Ú

nircmd.exe win close class "IEFrame"

¹Ø±ÕËùÓĞµÄ×ÊÔ´¹ÜÀíÆ÷´°¿Ú(ÎÒµÄµçÄÔ¡¢ÎÄ¼ş¼ĞµÈ)

nircmd.exe win close class "CabinetWClass"

Òş²ØËùÓĞµÄIE´°¿Ú

nircmd.exe win hide class "IEFrame"

ÏÔÊ¾ËùÓĞµÄIE´°¿Ú(ÔÚÓÃÉÏÃæÃüÁîÒş²Øºó)

nircmd.exe win show class "IEFrame"

°ÑËùÓĞµÄ¶¥¼¶´°¿Ú¾ÓÖĞ

nircmd.exe win center alltop

È¥µôÎÒµÄµçÄÔ´°¿ÚµÄ±êÌâÀ¸

nircmd.exe win -style title "my computer" 0x00C0000

»Ö¸´ÎÒµÄµçÄÔ´°¿ÚµÄ±êÌâÀ¸(µ±ÓÃÉÏÃæÃüÁîÈ¥³ıºó)

nircmd.exe win +style title "my computer" 0x00C0000

ÉèÖÃÎÒµÄµçÄÔ´°¿ÚÎª´ÓÓÒÖÁ×óµÄË³Ğò(ÊÊÓÃÓÚÏ£²®À´ÓïºÍ°¢À­²®Óï)

nircmd.exe win +exstyle title "my computer" 0x00400000

ÉèÖÃÎÒµÄµçÄÔ´°¿ÚµÄËùÓĞ×Ó´°¿ÚÎª´ÓÓÒÖÁ×óµÄË³Ğò(ÊÊÓÃÍ¬ÉÏ)

nircmd.exe win child title "my computer" +exstyle all 0x00400000

ÔÚ×ÀÃæ´´½¨¿ÉÒÔ¹Ø±ÕËùÓĞIE´°¿ÚµÄ¿ì½İ·½Ê½

nircmd.exe cmdshortcut " "~$folder.desktop$ "Close All IE" win close class "IEFrame"

ÔÚ×ÀÃæ´´½¨¿ÉÒÔÒş²ØËùÓĞIE´°¿ÚµÄ¿ì½İ·½Ê½

nircmd.exe cmdshortcut " "~$folder.desktop$ "Hide All IE" win hide class "IEFrame"

ÔÚ×ÀÃæ´´½¨¿ÉÒÔÔÙ´ÎÏÔÊ¾ËùÓĞIE´°¿ÚµÄ¿ì½İ·½Ê½

nircmd.exe cmdshortcut " "~$folder.desktop$ "Show All IE" win show class "IEFrame"

°Ñcalculator´°¿ÚÉèÖÃÎª×îÉÏ²ã´°¿Ú(ÔÚÆäËû´°¿ÚÖ®ÉÏ)

nircmd.exe win settopmost title "Calculator" 1

»Ö¸´calculator´°¿ÚÎªÔ­Ê¼´°¿Ú×´Ì¬(²»´¦ÓÚ×îÉÏ²ã)

nircmd.exe win settopmost title "Calculator" 0

´´½¨calc.exe¿ì½İ·½Ê½µ½¿ªÊ¼²Ëµ¥->³ÌĞò->Calculators

nircmd.exe shortcut "f:\winnt\system32\calc.exe" "~$folder.programs$\Calculators" "Windows Calculator"

Òş²Ø×ÀÃæËùÓĞÍ¼±ê

nircmd.exe win hide class progman

ÏÔÊ¾×ÀÃæËùÓĞÍ¼±ê(ÓÃÒÔÉÏÃüÁîÒş²Ø¹ıºó)

nircmd.exe win show class progman

Òş²ØÏµÍ³¿ªÊ¼°´Å¥

nircmd.exe win child class "Shell_TrayWnd" hide class "button"

ÏÔÊ¾ÏµÍ³¿ªÊ¼°´Å¥

nircmd.exe win child class "Shell_TrayWnd" show class "button"

Òş²ØÏµÍ³Ê±¼ä

nircmd.exe win child class "Shell_TrayWnd" hide class "TrayClockWClass"

ÏÔÊ¾ÏµÍ³Ê±¼ä

nircmd.exe win child class "Shell_TrayWnd" show class "TrayClockWClass"

ÖÕÖ¹ËùÓĞIEÊµÀı

nircmd.exe killprocess iexplore.exe

´´½¨×ÀÃæ¿ì½İ·½Ê½£¬ÔËĞĞ¼´¿Éµ¯³ö¹âÇı(KÅÌ)

nircmd.exe cmdshortcut "~$folder.desktop$" "Open CDROM" cdrom open k:

½«nirsoftÍøÖ·´´½¨µ½×ÀÃæ¿ì½İ·½Ê½

nircmd.exe urlshortcut "http://www.nirsoft.net" "~$folder.desktop$" "NirSoft"

Ìí¼ÓnirsoftÍøÖ·µ½ÊÕ²Ø¼Ğ\Á´½ÓÏÂ

nircmd.exe urlshortcut "http://www.nirsoft.net" "~$folder.favorites$\Links" "NirSoft"

½«nirsoftÍøÖ·¿ì½İ·½Ê½´´½¨µ½computers.txtÖĞÁĞ³öµÄËùÓĞ¼ÆËã»úµÄ×ÀÃæ

nircmd.exe multiremote copy "c:\temp\computers.txt" urlshortcut "http://www.nirsoft.net" "~$folder.common_desktop$" "NirSoft"

ÉèÖÃÏÔÊ¾Ä£Ê½Îª800X600£¬24Î»É«

nircmd.exe setdisplay 800 600 24

½«ÉèÖÃÏÔÊ¾Ä£Ê½Îª800X600£¬24Î»É«ÃüÁî´´½¨Îª×ÀÃæ¿ì½İ·½Ê½

nircmd.exe cmdshortcut "~$folder.desktop$" "800x600x24" setdisplay 800 600 24

¸´ÖÆËùÓĞ×ÀÃæ¿ì½İ·½Ê½µ½ÆäËûÎÄ¼ş¼Ğ(f:\temp\desktop)

nircmd.exe execmd copy "~$folder.desktop$\*.lnk" f:\temp\desktop

ÖØÆôÄãµÄApache server·şÎñÆ÷(windows NT/2000/XP/2003)

nircmd.exe service restart apache

½«ÖØÆôApache server·şÎñÆ÷ÃüÁî´´½¨Îª×ÀÃæ¿ì½İ·½Ê½

nircmd.exe cmdshortcut "~$folder.desktop$" "Restart Apache" service restart apache

ÖØÆôIIS(»¥ÁªÍøĞÅÏ¢·şÎñ)

nircmd.exe service restart w3svc

ÖØÆôMySql

nircmd.exe service restart MySql

´ò¿ªÖ¸¶¨×¢²á±íÏî/Öµ

nircmd.exe regedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"

´ò¿ªÄãÔÚ×¢²á±í±à¼­Æ÷ÖĞ¸´ÖÆµ½¼ôÇĞ°åµÄ×¢²á±íÏî

nircmd regedit "~$clipboard$"

½ûÓÃÆÁ±£

nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 0

È¡Ïû½ûÓÃÆÁ±£

nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 1

¸Ä±äÖ¸¶¨ÎÄ¼şµÄÈÕÆÚ/Ê±¼ä(´´½¨Ê±¼äºÍĞŞ¸ÄÊ±¼ä)

nircmd.exe setfiletime "c:\temp\myfile.txt" "24-06-2003 17:57:11" "22-11-2005 10:21:56"

¸´ÖÆ×ÀÃæËùÔÚÂ·¾¶µ½¼ôÇĞ°å

nircmd.exe clipboard set ~$folder.desktop$

¸´ÖÆ¿ªÊ¼²Ëµ¥ÎÄ¼ş¼ĞÂ·¾¶µ½¼ôÇĞ°å

nircmd.exe clipboard set ~$folder.start_menu$

¸´ÖÆÎÄ±¾info1.txtÖĞµÄÄÚÈİµ½¼ôÇĞ°å

nircmd.exe clipboard readfile "c:\My Files\info1.txt"

½«¼ôÇĞ°åÖĞÄÚÈİÌí¼Óµ½ÎÄ±¾info1.txtÖĞ

nircmd.exe clipboard addfile "c:\My Files\info1.txt"

Çå¿Õ¼ôÇĞ°å

nircmd.exe clipboard clear

´´½¨ËùÓĞÔÚ"c:\temp\folders.txt"ÖĞÖ¸¶¨µÄÎÄ¼ş¼Ğ£¬ÎÄ¼ş¼ĞÂ·¾¶ÃûÓÃ»Ø³µ·û¸ô¿ª

nircmd.exe paramsfile "c:\temp\folders.txt" "" "" execmd md ~$fparam.1$

°²×°ËùÓĞÔÚÈ«¾Ö³ÌĞò¼¯»º´æ(GAC)ÖĞÖ¸¶¨µÄ.NET³ÌĞò¼¯

nircmd.exe gac install "C:\temp\MyAssembly\bin\MyAssembly.dll"

Çå¿ÕËùÓĞ´ÅÅÌÉÏµÄ»ØÊÕÕ¾

nircmd.exe emptybin

¶ÔÒ»¸ö±ê×¼µÄWindowsĞÅÏ¢¿ò»Ø¸´È·ÈÏ

nircmd.exe dlg "" "" click yes

ÑÓ³Ù2ÃëÖÓ£¬È»ºó±£´æµ±Ç°ÆÁÄ»½ØÍ¼µ½shot.png

nircmd.exe cmdwait 2000 savescreenshot "f:\temp\shot.png"


cdrom open     cdrom close    cdrom open *:            cdrom close *:              monitor off
´ò¿ª¹âÇı           ¹Ø±Õ¹âÇı          ´ò¿ªÖ¸¶¨¹âÇı               ¹Ø±ÕÖ¸¶¨¹âÇı                  ¹Ø±ÕÏÔÊ¾Æ÷

exitwin logoff       clipboard clear      screensaver     standby    exitwin logoff
×¢Ïú                     Çå¿Õ¼ôÌù°å           ÔËĞĞÆÁ±£            ´ı»ú         ×¢Ïúµ±Ç°ÓÃ»§

exitwin poweroff       setdisplay 800 600 24
¹Ø±Õ¼ÆËã»ú                ÉèÖÃÏÔÊ¾Æ÷800¡Á600ÏñËØ 24Î»ÑÕÉ«

Ö±½Ó½«ÏµÍ³ÒôÁ¿µ÷ÖÁ×î¸ß
nircmd.exe setsysvolume 65535

clipboard readfile "c:\***\2123.txt"
½«Ö¸¶¨µÄÎÄ±¾ÎÄ¼şµÄÄÚÈİ·ÅÈëµÄ¼ôÇĞ°å

clipboard addfile "c:\***\2123.txt"
½«¼ôÇĞ°åÄÚÈİ×·¼Óµ½Ö¸¶¨ÎÄ±¾ÎÄ±¾

infobox [message text] [title]
ÏÔÊ¾Ò»¸ö¼òµ¥µÄÏûÏ¢¿òÔÚÆÁÄ»ÉÏ¡£
Àı×Ó£ºinfobox "ÄÚÈİ" "±êÌâ"

shellcopy [source file or wildcard] [destination] {Flags}
ÎÄ¼ş¸´ÖÆ
¢Ù yestoall È«ÊÇ
¢Ú noerrorui ²»ÏÔÊ¾´íÎóÓÃ»§½çÃæĞÅÏ¢
¢Û silent °²¾²Ä£Ê½-²»ÏÔÊ¾ÎÄ¼ş¸´ÖÆ½ø¶È
¢Ü nosecattr ²»Òª¸´ÖÆµÄ°²È«ÊôĞÔµÄÎÄ¼ş¡£
Àı×Ó£º
shellcopy "c:\temp\*.*" "d:\temp"
shellcopy "c:\temp\*.*" "d:\temp" yestoall noerrorui

filldelete [source file or wildcard]
³¹µ×É¾³ıÎÄ¼ş²»·ÅÈë»ØÊÕÕ¾
Àı×Ó£º
¢Ù filldelete "C:\WINDOWS\*.log"
¢Ú filldelete "C:\1.dat"

infobox [message text] [title]
ÔÚÆÁÄ»ÉÏÏÔÊ¾Ò»¸ö¼òµ¥µÄĞÅÏ¢¿ò£¨£¡£©
Àı×Ó£ºinfobox "ÌáÊ¾" "±êÌâ"

qbox [message text] [title] [program to run]
ÏÔÊ¾Ò»¸öÎÊÌâ¶Ô»°¿òÔÚÆÁÄ»ÉÏ¡£Èç¹ûÓÃ»§»Ø´ğ" yes " £¬ÔËĞĞ³ÌĞò
Àı×Ó£ºqbox "È·¶¨ÔËĞĞ¼ÆËãÆ÷Âğ£¿" "ÌáÊ¾" "calc.exe"

qboxtop [message text] [title] [program to run]
ÏÔÊ¾Ò»¸öÖÃ¶¥ÎÊÌâ¶Ô»°¿òÔÚÆÁÄ»ÉÏ¡£Èç¹ûÓÃ»§»Ø´ğ" yes " £¬ÔËĞĞ³ÌĞò
Àı×Ó£ºqboxtop "È·¶¨ÔËĞĞ¼ÆËãÆ÷Âğ£¿" "ÌáÊ¾" "calc.exe"

regedit [key] [value name]
´ò¿ª×¢²á±íÓëÖ¸¶¨µÄ¼ü/Öµ¡£
Àı×Ó£ºregedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"

regdelval [key] [value]
É¾³ı×¢²á±íÖµ
Àı×Ó£ºregdelval "HKEY_CURRENT_USER\Software\Test" "Value1"

regdelkey [key]
É¾³ı×¢²á±í¼ü
Àı×Ó£ºregdelkey "HKEY_CURRENT_USER\Software\Test"

½ûÓÃÆÁÄ»±£»¤³ÌĞò
nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 0

ÆôÓÃÆÁÄ»±£»¤³ÌĞò
nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 1

setcursor [X] [Y]
ÉèÖÃÊó±êÔÚÆÁÄ»Î»ÖÃ
Àı×Ó£ºsetcursor 100 50

win settopmost title "¼ÆËãÆ÷" 1         win settopmost title "¼ÆËãÆ÷" 0
ÉèÖÃ Windows ¼ÆËãÆ÷´°¿ÚÖÃ¶¥ÏÔÊ¾      È¡Ïû Windows ¼ÆËãÆ÷´°¿ÚÖÃ¶¥ÏÔÊ¾

sendmouse [right|left|middle] [down|up|click|dblclick]
°´Êó±ê¼ü
Àı×Ó£º
¢Ù sendmouse right click ÓÒ¼üÊó±ê
¢Ú sendmouse left click  ×ó¼üÊó±ê
¢Û sendmouse left dblclick Ë«»÷Êó±ê×ó¼ü
¢Ü sendmouse left down  °´ÏÂÊó±ê×ó¼ü
¢İ sendmouse left up  ËÉ¿ªÊó±ê×ó¼ü
¢Ş sendmouse middle click

inisetval  inisetval [INI filename] [section] [key] [value]
Ğ´ÈëÖµµ½ INI ÎÄ¼ş. Èç¹ûÎÄ¼ş²»´æÔÚÔò½«±»×Ô¶¯´´½¨.
Èç: inisetval "c:\windows\test.ini" "section1" "TestValue" "1"

inidelval  inidelval [INI filename] [section] [key]
É¾³ı INI ÎÄ¼şÖĞÄ³¸öÖµ.
Èç: inidelval "c:\windows\test.ini" "section1" "TestValue"

inidelsec  inidelval [INI filename] [section]
É¾³ı INI ÎÄ¼şÖĞÄ³¸öÇø¶Î¼°ÆäËùÓĞµÄÖµ.
Èç: inidelsec "c:\windows\test.ini" "section1"

regsvr  regsvr [reg or unreg] [filename or wildcard] {log file}
×¢²á»ò½â³ı×¢²á DLL/OCX ÎÄ¼ş.
µÚÒ»¸ö²ÎÊıÖ¸¶¨ "reg" Ôò×¢²áÎÄ¼ş, "unreg" ½â³ı×¢²áÎÄ¼ş.
µÚ¶ş¸ö²ÎÊıÖ¸¶¨ÄãÒª×¢²á»ò½â³ı×¢²áµÄÊÇµ¥¸öÎÄ¼ş»¹ÊÇ¶à¸öÎÄ¼ş, Ö§³ÖÍ¨Åä·û.
µÚÈı¸ö²ÎÊıÊÇ¿ÉÑ¡Ïî, Ö¸¶¨ÊÇ·ñÊä³ö²Ù×÷¼ÇÂ¼.
Èç:
regsvr reg "f:\winnt\system32\fv*.ocx" "c:\temp\log1.txt"
regsvr unreg "f:\winnt\system32\ab*.dll"

regsetval [type] [key] [value name] [value]
ÉèÖÃ»ò´´½¨×¢²á±íÖµ
Àı×Ó£º
regsetval dword "HKEY_CURRENT_USER\Software\Test" "Value1" "0xaabbccdd"
regsetval dword "HKCU\Software\Test" "Value2" "10561"
regsetval sz "HKCU\Software\Test" "Value3" "string value"
regsetval binary "HKLM\Software\Test" "Value4" "6a cb ab dd 80 86 95"

win [action] [find] [window to find] [Additional Parameters]
ÉèÖÃ´°¿Ú
Àı×Ó£º
¢Ù win close title "ÎŞ±êÌâ - ¼ÇÊÂ±¾"  ¹Ø±ÕÖ¸¶¨´°¿Ú£¨±È½Ï¾«È·Æ¥Åä£©
¢Ú win activate title "ÎŞ±êÌâ - ¼ÇÊÂ±¾"  ¼¤»îÖ¸¶¨´°¿Ú
¢Û win max title "ÎŞ±êÌâ - ¼ÇÊÂ±¾"  ×î´ó»¯Ö¸¶¨´°¿Ú
¢Ü win trans title "ÎŞ±êÌâ - ¼ÇÊÂ±¾" 80  Í¸Ã÷»¯Ö¸¶¨´°¿Ú£¨0-255£¬Êı×ÖĞ¡Ô½Í¸Ã÷£©
¢İ win center title "ÎŞ±êÌâ - ¼ÇÊÂ±¾"  ¾ø¶Ô¾ÓÖĞÖ¸¶¨´°¿Ú
¢Ş win close stitle "ÎŞ±êÌâ"  ¹Ø±ÕÖ¸¶¨´°¿Ú£¨Ä£ºıÆ¥Åä£©

Ä¿Â¼
~$folder.windows$  C:\Windows Ä¿Â¼
nir.exefile  µ±Ç°ÔËĞĞµÄ NirCmd ËùÔÚµÄÍêÕûÂ·¾¶ (Èç: c:\winnt\nircmd.exe)
folder.nircmd  µ±Ç°ÔËĞĞµÄ NirCmd ËùÔÚµÄÄ¿Â¼.
folder.desktop  ×ÀÃæÄ¿Â¼.
folder.start_menu  ¿ªÊ¼²Ëµ¥Ä¿Â¼.
folder.programs  ¿ªÊ¼²Ëµ¥³ÌĞò×éÄ¿Â¼.
folder.startup  "Æô¶¯" Ä¿Â¼.
folder.recent  ×î½ü´ò¿ªÎÄµµÄ¿Â¼.
folder.favorites  ÊÕ²Ø¼ĞÄ¿Â¼.
folder.cookies  Cookies Ä¿Â¼.
folder.appdata  ÓÃÓÃ³ÌĞòÊı¾İÄ¿Â¼. (Èç: C:\Documents and Settings\Administrator\Application Data)
folder.common_desktop  ¹«ÓĞ×ÀÃæÄ¿Â¼.
folder.common_start_menu  ¹«ÓĞ¿ªÊ¼²Ëµ¥Ä¿Â¼.
folder.common_programs  ¹«ÓĞ¿ªÊ¼²Ëµ¥³ÌĞò×éÄ¿Â¼.
folder.common_startup  ¹«ÓĞ "Æô¶¯" Ä¿Â¼.
folder.common_favorites  ¹«ÓĞÊÕ²Ø¼ĞÄ¿Â¼.
folder.windows  Windows Ä¿Â¼. (Èç: C:\Windows)
folder.system  ÏµÍ³Ä¿Â¼. (Èç: C:\Windows\System32)

exec show "notepad.exe"
ÔËĞĞÖ¸¶¨³ÌĞò

shexec [operation] [filename]
¶ÔÖ¸¶¨³ÌĞò½øĞĞ²Ù×÷
Àı×Ó£º
¢Ù shexec "open" "c:\my documents\abc.doc"
¢Ú shexec "print" "d:\files\1.pdf"
¢Û shexec "open" "http://www.nirsoft.net"

urlshortcut "http://www.****.***" "~$folder.desktop$" "Ãû³Æ"
´´½¨URL¿ì½İ·½Ê½µ½µ±Ç°ÓÃ»§×ÀÃæ

É¾³ıÎÄ¼ş¼Ğ
execmd rd "~$folder.appdata$\PE Explorer"

½¨Á¢ÎÄ¼ş¼Ğ
execmd md "~$folder.appdata$\PE Explorer"

sendkey 0x25 press      sendkey 0x27 press sendkey 0x26 press
¹â±ê×óÒÆ  ¹â±êÓÒÒÆ  ¹â±êÉÏÒÆ
sendkey 0x28 press¡¾¹â±êÏÂÒÆ¡¿

0x1 Êó±ê×ó¼ü
0x2 Êó±êÓÒ¼ü
0x8 BackSpace¼ü
0x9 TAB¼ü
0xD Enter¼ü
0x11 Ctrl¼ü
0x14 Caps Lock¼ü
0x1B ESC¼ü


°´¼ü£ºHANGEUL 0x15 /* old name - should be here for compatibility */
°´¼ü£ºHANGUL 0x15
°´¼ü£ºJUNJA 0x17
°´¼ü£ºFINAL 0x18
°´¼ü£ºHANJA 0x19
°´¼ü£ºKANJI 0x19
°´¼ü£ºESCAPE 0x1B
°´¼ü£ºCONVERT 0x1C
°´¼ü£ºNONCONVERT 0x1D
°´¼ü£ºACCEPT 0x1E
°´¼ü£ºMODECHANGE 0x1F
°´¼ü£ºSPACE 0x20
°´¼ü£ºPRIOR 0x21
°´¼ü£ºNEXT 0x22
°´¼ü£ºEND 0x23
°´¼ü£ºHOME 0x24
°´¼ü£ºLEFT 0x25
°´¼ü£ºUP 0x26
°´¼ü£ºRIGHT 0x27
°´¼ü£ºDOWN 0x28
°´¼ü£ºSelect 0x29
°´¼ü£ºPRINT 0x2A
°´¼ü£ºEXECUTE 0x2B
°´¼ü£ºSNAPSHOT 0x2C
°´¼ü£ºInsert 0x2D
°´¼ü£ºDelete 0x2E
°´¼ü£ºHELP 0x2F
/*°´¼ü£º0 thru°´¼ü£º9 are the same as ASCII '0' thru '9' (0x30 - 0x39) */
/*°´¼ü£ºA thru°´¼ü£ºZ are the same as ASCII 'A' thru 'Z' (0x41 - 0x5A) */
°´¼ü£º×óWIN 0x5B
°´¼ü£ºÓÒWIN 0x5C
°´¼ü£ºSEPARATOR 0x6C
°´¼ü£ºSUBTRACT 0x6D
°´¼ü£ºDECIMAL 0x6E
°´¼ü£ºDIVIDE 0x6F
LButton 0x1 Êó±ê×ó¼ü RButton 0x2 Êó±êÓÒ¼ü
Cancel 0x3 CANCEL ¼ü MButton 0x4 Êó±êÖĞ¼ü
0x8 BACKSPACE ¼ü 0x9 TAB ¼ü
0xC CLEAR¼ü  0xD ENTER ¼ü
0x10 SHIFT¼ü  0x11 CTRL ¼ü
0x12 MENU¼ü  0x13 PAUSE ¼ü
0x14 CAPSLOCK ¼ü 0x1B ESC ¼ü
0x20 SPACEBAR ¼ü 0x21 PAGE UP ¼ü
0x22 PAGE DOWN ¼ü 0x23 END ¼ü
0x24 HOME ¼ü
0x25 ¡û ¼ü 0x26 ¡ü ¼ü 0x27 ¡ú ¼ü 0x28 ¡ı ¼ü
0x29 SELECT ¼ü  0x2A PRINT SCREEN ¼ü
0x2B EXECUTE ¼ü  0x2C SNAPSHOT ¼ü
0x2D INSERT ¼ü  0x2E DELETE ¼ü
0x2F HELP ¼ü  0x90 NUMLOCK ¼ü
0x60 NUM(0) ¼ü 0x61 NUM(1) ¼ü 0x62 NUM(2) ¼ü
0x63 NUM(3) ¼ü 0x64 NUM(4) ¼ü 0x65 NUM(5) ¼ü
0x66 NUM(6) ¼ü 0x67 NUM(7) ¼ü 0x68 NUM(8) ¼ü
0x69 NUM(9) ¼ü 0x6A NUM(*) ¼ü 0x6B NUM(+) ¼ü
0x6C NUM(ENTER)¼ü 0x6D NUM(-) ¼ü
0x6E NUM(.) ¼ü 0x6F NUM(/) ¼ü
0x70 F1¼ü 0x71 F2¼ü 0x72 F3¼ü 0x73 F4¼ü
0x74 F5¼ü 0x75 F6¼ü 0x76 F7¼ü 0x77 F8¼ü
0x78 F9¼ü 0x79 F10¼ü 0x7A F11¼ü 0x7B F12¼ü
0x7C F13¼ü 0x7D F14¼ü 0x7E F15¼ü 0x7F F16¼ü

:helps
cls
findstr "^::" "%~f0"|more
echo;
::
::  - FILE: DIY¿ØÖÆÌ¨,gcc 3.4.0,notepad++ 8.1.0 ,GvimÌáÈ¡
::  - Compile: Tcc,sed,nircmd,sed,grep...µÈÍâ²¿ÃüÁîºÍ.bat½Å±¾¼¯ºÏ,
::    ²¿·ÖexeÓĞÔ´ÎÄ¼ş.cpp/.c
::  - É±¶¾Èí¼ş¿ÉÄÜ±¨¶¾ÊÇÕı³£µÄ,Íâ²¿ÃüÁîµ÷ÓÃÏµÍ³API²ÅÄÜ×ö¸ü¶àÊÂÇé,
::    ËæºóµÄÌí¼Ó×¢²á±í²Ù×÷ĞèÒª¹ÜÀíÔ±È¨ÏŞ
::