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
echo;  ^< Ŀ¼ ^>
echo;
CmdMenuSel 0708 "  - ��һ�� ��װ��ʹ��" "  - �ڶ��� �����̳�" "  - ������ ���׽̳�" "  - ������ �˽Ȿ�ⲿ�����" "  - ������ �ⲿ����" "  - ������ ��д�ⲿ����"
cls
goto :book_%errorlevel%

:book_1
gotoxy -l 0 0
echo;  - ��һ�� ��װ��ʹ��
echo;
echo;  - ������,������
echo;  - ѧ���˰�,���ȷ��
length "ȷ��"
call :mouse 40 7 %errorlevel% 7 70 "ȷ��" 1
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
echo;  - �ڶ��� �����̳�

call :showcmd "paths"
call paths
printf 0x0a %used%@%COMPUTERNAME%
printf 0x09 [%cd%]
printf 0x07 "$ "
timeout 1 >nul
printf -t 0x07 100 "path | sed \"s/;/\n/g\" | sed \"/^$/d\" | nl"
timeout 1 >nul
call :Type "  - �鿴��������"
path | sed "s/;/\n/g" | sed "/^$/d" | nl

exit /b

:book_3
echo;  - ������ ���׽̳�
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
echo;  - ������ �˽Ȿ�ⲿ�����
echo;
echo;[����] �鷳û�����㣬�ͱ�ȥ�����鷳��  - ��ESC����
echo;[��ʾ] ��һ���ĸ�trouble�Ƕ��ʣ��ڶ�������trouble�����ʡ�
words "[-] Never trouble trouble" "till" "trouble troubles you��"
echo;	                  ----
call :showcmd "pause >nul"
pause >nul

echo;[��������]till
echo;	v.���������
echo;	prep.ֱ����Ϊֹ��ֱ�����š����ڡ�ǰ(����)
echo;	conj.ֱ����Ϊֹ���ڡ�֮ǰ
echo;	n.����̨�����ֽ���ɻ��ģ���Ǯ�ĳ���
echo;	����ֱ������Ϊֹ���������ԣ�����
echo;	�����˳Ƶ�����tills  ���ڷִʣ�tilling  ��ȥʽ��tilled
exit /b

:book_5
echo;  - ������ �ⲿ����
call :showcmd "start cmatrix"
start cmatrix.exe
echo;	�������������
call :showcmd "zms"
start zms.exe
echo;	����ΪProgman�Ӵ��ڣ�Ƕ������
exit /b

:book_6
title;������ ��д�ⲿ����

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
echo;����  %cd%
gotoxy -l %wide% 2
echo;��   ��  test.c     
gotoxy -l %wide% 3
echo;����  server
gotoxy -l %wide% 4
echo;��   ��  callbacks.h     
gotoxy -l %wide% 5
echo;��   ���� ini
gotoxy -l %wide% 6
echo;��   ��      ini.h
gotoxy -l %wide% 7
echo;����  zombie 

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
echo;����  %cd% 
gotoxy -l %wide% 2           
echo;��      test.c        
gotoxy -l %wide% 3         
echo;��      test.exe       
gotoxy -l %wide% 4        
echo;����  server             
gotoxy -l %wide% 5
echo;��   ��  callbacks.h       
gotoxy -l %wide% 6
echo;��   ���� ini         
gotoxy -l %wide% 7
echo;��          ini.h      
gotoxy -l %wide% 8
echo;����  zombie    

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
	echos 0x06 [��������]
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

	Set "Block=��"
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
%= ����: 2022 �� 9 �� 10 �� =%
%= ����: Type =%
%= ����: ģ����� =%
%= ����: String Ҫ��ʾ���ַ��� =%
%= ��ע: �˺���Ҫ���ʻ������� _._ =%
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
%= VT100 ���� =%
%================================================================================================================================%

%================================================================%
%= ����: 2022 �� 9 �� 9 �� =%
%= ����: InitVT100 =%
%= ����: ��ʼ�� Windows 10 �� �����ն����� =%
%================================================================%
:InitVT100
%= { =%

	%= ��ȡ ESC �ַ� =%

	Set "ESC="

	%= ���û�ж��� ESC �ַ������������Ϊ�˷�ֹ��̳�������ĵ� ESC �ַ� =%
	If Not Defined ESC (

		For /F "Delims=#" %%_ in ('Prompt #$E# ^& Echo On ^& For %%$ in ^(1^) Do DosKey') Do Set "ESC=%%_"
		REM for /F %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
	)

%= } =%
@Goto :Eof

%================================================================%
%= ����: 2022 �� 9 �� 9 �� =%
%= ����: GotoXY =%
%= ����: ��λ��굽ָ��λ�� =%
%= ����: X ���� X �����꣬���ʡ�Ի���Ϊ 0��������Ϊ1 =%
%= ����: Y ���� Y �����꣬���ʡ�Ի���Ϊ 0��������Ϊ1 =%
%================================================================%
:GotoXY <X> <Y>
%= { =%

	%= ���û�ж��� ESC �ַ� =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	%= ��λ��� =%
	Set /P=%ESC%[%2;%1H< Nul

%= } =%
@Goto :Eof

%================================================================%
%= ����: 2022 �� 9 �� 9 �� =%
%= ����: SetConsoleTextAttribute =%
%= ����: ���ÿ���̨�ı���ɫ =%
%= ����: BGCOL ���� RGB ��ɫֵ����ʽΪR-G-B =%
%= ����: FGCOL ǰ�� RGB ��ɫֵ����ʽΪR-G-B =%
%================================================================%
:SetConsoleTextAttribute <BGCOL> <FGCOL>
%= { =%

	%= ���û�ж��� ESC �ַ� =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	%= ���ñ���ɫ =%
	For /F "Delims=-, Tokens=1,2,3" %%I in ("%1") Do (
		Set /P=%ESC%[48;2;%%I;%%J;%%Km< Nul
	)

	%= ����ǰ��ɫ =%
	For /F "Delims=-, Tokens=1,2,3" %%I in ("%2") Do (
		Set /P=%ESC%[38;2;%%I;%%J;%%Km< Nul
	)

%= } =%
@Goto :Eof

%================================================================%
%= ����: 2022 �� 9 �� 9 �� =%
%= ����: SetConsoleCursorInfo =%
%= ����: ���ÿ���̨������� =%
%= ����: CursorVisibility ���ɼ�����˸״̬��ȡֵ1~4���ֱ�Ϊ�� =%
%=       1 ��ʾ��� =%
%=       2 ���ع�� =%
%=       3 ��ʼ�����˸ =%
%=       4 ֹͣ��˸��� =%
%= ����: CursorShape      �Զ�������״��ȡֵ0~6���ֱ�Ϊ�� =%
%=       0 �û����õ�Ĭ�Ϲ����״ =%
%=       1 ��˸������״ =%
%=       2 �ȶ�������״ =%
%=       3 ��˸�»��߹����״ =%
%=       4 �ȶ��»��߹����״ =%
%=       5 ��˸���ι����״ =%
%=       6 �ȶ����ι����״ =%
%================================================================%
:SetConsoleCursorInfo <CursorVisibility> <CursorShape>
%= { =%

	%= ���û�ж��� ESC �ַ� =%
	If Not Defined ESC (

		@Call :InitVT100

	)

	%= ���ù��ɼ�����˸״̬ =%
	For /F "Delims=-, Tokens=%1" %%I in ("25h-25l-12h-12l") Do (
		Set /P=%ESC%[?%%I< Nul
	)

	Set /P=%ESC%[%2 q< Nul

%= } =%
@Goto :Eof

%================================================================%
%= ����: 2022 �� 9 �� 9 �� =%
%= ����: SetConsoleTextAttributeEx =%
%= ����: ��ʽ������̨�ı� =%
%= ����: Code �������룬ȡֵ1~6���ֱ�Ϊ�� =%
%=       1 Ĭ�ϣ�ͨ���൱��Color 07 =%
%=       2 ����/�� =%
%=       3 �޴���/�� =%
%=       4 �»��� =%
%=       5 ���»��� =%
%=       6 ����ǰ��ɫ�ͱ���ɫ =%
%================================================================%
:SetConsoleTextAttributeEx <Code>
%= { =%

	%= ���û�ж��� ESC �ַ� =%
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

ִ��cmdow @����ʾΪ
Handle Lev Pid -Window status- Image Caption
0x230088 1 3356 Res Act Ena Vis cmd C:\WINDOWS\system32\cmd.exe - cmd - cm
window ָ��Ҫ�г��Ĵ��ڣ�ʹ�ô��ڱ��������ָ����û�б�����ô�������档���û��ָ�����г����д��ڡ���@����ʾ�˴��ڣ��������д��ڡ�
/T ֻ�г��������Ĵ���
/B ����������ӣ��������������ʾ��һ��
/F ��ʾ��������
/P �г�����λ�á������
����
Handle �����16���Ƹ�ʽ
Window status ����״̬��Minimized, Maximized, Restored, Active, Inactive, Enabled, Disabled, Visible or Hidden��

CMDOW /TH | /TV | /CW | /MA | /UW | /AT | /FS | /WM/TH ����ƽ�̴���
/TV ����ƽ�̴���
/CW �������
/MA ��С�����д���
/UW ȡ��/TH, /TV, /CW , /MA
/AT �൱��Alt+Esc
/FS ȫ�������д��ڣ��൱��Alt+Enter
/WM ȡ��ȫ�������ٰ�һ��Alt+Enter

CMDOW window {[/ACT] [/INA] [/ENA] [/DIS] [/VIS] [/HID] [/MIN] [/MAX] [/RES] [/TOP] [/NOT] [/REN caption] [/MOV left top] [/SIZ width height] [/CLS] [/END]}/ACT ����ָ������
/INA ��֪��ɶ��
/DIS �Ѵ��ڱ�Ϊ��ֻ����׼�������޷��ƶ���������Ҽ���Ч������˵�����ˡ��������ÿ�ݼ��رա�
/ENA ���/DIS
/HID ���ش��ڣ������������̽Կ�����
/VIS ��ʾ�����صĴ���
/MIN ��С��ָ������
/MAX ���ָ������
/RES ���������糷��������ԭ���Ĵ�С��λ�á����ܳ������Σ������󲻿��Է��س���ǰ��״̬��
/TOP �ö����ڡ����ö��˶�������һ���ö��������棬�ö��˵Ķ��ᱣ���ö�״̬��
/NOT ȡ�������ö�
/REN caption ���������ڱ���
/MOV left top �ƶ����� ����߾��� ���ϱ߾���
/SIZ width height �ı䴰�ڿ���
/CLS �رմ���
/END �������̡��ֲ�������ͬPID�Ļ�һ��Kill����С��ʹ�ã�

cmdow @ /siz 700 350

CMDOW /RUN [state] file [args]state ���з�ʽ��/MIN /MAX /HID��

  REM - jpeg

-te <����jpeg�ļ�>
������jpeg�ļ���eixf����Ŀ��jpeg������"jhead �Cte D:\My Pictures\B.jpg D:\My Pictures\A.jpg"

-dc
ɾ��jpeg��Ϣ�еı�ע��ע�⣬jpeg�ļ���������ע��һ�Ǻ������ļ�һ���ı�ע����һ����exif��Ϣ�еı�ע��jhead����exif��Ϣ��Ч��
-de
��ȫɾ��exif��Ϣ��
-du
ɾ����ԭʼexif��Ϣ������Photoshop��Turbophoto֮��༭���޸�exif���µ���Ϣ��
-purejpg
ɾ������jpeg�ļ��Ǳ������Ϣ���൱��-de��-dc��-du�ļ��ϣ����Խ��ļ���С��k��
-ce
�޸��ļ���jpeg�ļ�ͷ���ֱ�ע���˱�ע����exif��Ϣ������ָ�����ı��༭�������ڱ༭���ر�ʱ����ע��Ϣ�����ļ���
-cs <�ı��ļ�>
������ע������"jhead �Ccs D:\1.txt D:\My Pictures\A.jpg"
-ci <�ı��ļ�>
���뱸ע������"jhead �Cci D:\1.txt D:\My Pictures\A.jpg"
-cl <��ע����>
ֱ�����뱸ע��������"jhead �Ccl �ҵı�ע D:\My Pictures\A.jpg"
��������ָ��
ʱ������
-ft ��jpeg�ļ��ġ��޸�ʱ�䡱�޸�Ϊexif��Ϣ�м�¼��ʱ�䡣
-n[<��ʽ-˳��>] ��ָ��Ὣ�ļ����޸�Ϊexif��Ϣ�м�¼�ġ�����ʱ�䡱�����jpeg�ļ�û��exif����exif�еĴ���ʱ�䲻���ã����ļ����޸�Ϊ�ļ��ġ��޸�ʱ�䡱��
Ĭ�ϵĸ�ʽ-˳��ΪMMDD-HHMMSS
��ʽ-˳��������£�
%d-��(01-31)
%H-Сʱ(00-23)
%j-һ���еĵڼ���(001-366)
%m-��(01-12)
%M-����(00-59)
%S-��(00-59)
%U-һ���еĵڼ���(00-53)
%w-���ڼ�(0-6������Ϊ0)
%y-��λ������(00-99)
%Y-��λ������
%i-����������
���磺
jhead -n%Y%m%d-%H%M%S d:\*.jpg
������jpg�ļ��޸�ΪYYYYMMDD-HHMMSS.jpg�ĸ�ʽ��
-nf �롰-n����ͬ������ͬ��������ԭ�ļ�����
-a �޸Ĳ�ͬ��չ����ͬ���ļ�������������avi��Ƭexif��Ϣ�洢������ͬ����thm�ļ��У����ô�ָ���avi�ļ�������һ���롰-n��ָ�ͬʹ�á�
-ta<ʱ��> ����ʱ�����ʱ�����ʱ��ȷ��������+1:00����-1:00
-da<����>-<����> �������ڡ����ڸ�ʽ��yyyy:mm:dd��yyyy:nn:dd+hh:mm���� yyyy:mm:dd+hh:mm:ss������ǰ�����ʱ������exif��ʱ�䡣
-ts<����-ʱ��> ֱ���޸�exif�е�����ʱ�䣬����-ʱ���ʽΪyyyy:mm:dd-hh:mm:ss
����ͼ

-dt ɾ��exif�е�����ͼ���������ͼһ��Ϊ240x160���أ�10k��С���������������Windows XP�鿴��Ƭ��ɾ��������Ӱ�칤����
-st <�ļ���> ��exif�е�����ͼ����Ϊ��һ��jpeg�ļ�
-rt <�ļ���> ����һ��jpeg�ļ��滻exif�е�����ͼ
-rgt[��С] ˢ��exif����ͼ�����д�СΪ����ͼ�����߳���
��ת
-autorot ����exif�м�¼��ˮƽ������Ϣת��jpeg��Ƭ��
-norot ���exif�е�ˮƽ������Ϣ��


  REM - nircmd

nircmd setdefaultsounddevice

�����̷�ΪJ�Ĺ���

NirCmd.exe cdrom open j:

�����̷�ΪY�Ĺ���

nircmd.exe cdrom close y:

����2000����λ��ϵͳ����(���65535)

nircmd.exe changesysvolume 2000

����5000����λ��ϵͳ����(���65535)

nircmd.exe changesysvolume -5000

����Ϊ�������

nircmd.exe setsysvolume 65535

����Ϊ����

nircmd.exe mutesysvolume 1

ȡ������

nircmd.exe mutesysvolume 0

�ھ���������״̬֮���л�

nircmd.exe mutesysvolume 2

�����洴������������״̬�л�����Ŀ�ݷ�ʽ

nircmd.exe cmdshortcut "~$folder.desktop$" "Switch Volume" mutesysvolume 2

�ر���ʾ��

nircmd.exe monitor off

����Ĭ������

nircmd.exe screensaver

�������״̬

nircmd.exe standby

ע����ǰ�û�

nircmd.exe exitwin logoff

�����Ի���ѯ���Ƿ�������ѡ��������������

nircmd.exe qboxcom "Do you want to reboot?" "question" exitwin reboot

�ر�computers.txt��ָ�������м����

multiremote copy "c:\temp\computers.txt" exitwin poweroff force

�������ӵ�"My Internet"

nircmd.exe rashangup "My Internet"

����IE����Ϊ75%͸����(192/256)

nircmd.exe win trans ititle "internet explorer" 192

��С�����е�IE����

nircmd.exe win min class "IEFrame"

�ر����е�IE����

nircmd.exe win close class "IEFrame"

�ر����е���Դ����������(�ҵĵ��ԡ��ļ��е�)

nircmd.exe win close class "CabinetWClass"

�������е�IE����

nircmd.exe win hide class "IEFrame"

��ʾ���е�IE����(���������������غ�)

nircmd.exe win show class "IEFrame"

�����еĶ������ھ���

nircmd.exe win center alltop

ȥ���ҵĵ��Դ��ڵı�����

nircmd.exe win -style title "my computer" 0x00C0000

�ָ��ҵĵ��Դ��ڵı�����(������������ȥ����)

nircmd.exe win +style title "my computer" 0x00C0000

�����ҵĵ��Դ���Ϊ���������˳��(������ϣ������Ͱ�������)

nircmd.exe win +exstyle title "my computer" 0x00400000

�����ҵĵ��Դ��ڵ������Ӵ���Ϊ���������˳��(����ͬ��)

nircmd.exe win child title "my computer" +exstyle all 0x00400000

�����洴�����Թر�����IE���ڵĿ�ݷ�ʽ

nircmd.exe cmdshortcut " "~$folder.desktop$ "Close All IE" win close class "IEFrame"

�����洴��������������IE���ڵĿ�ݷ�ʽ

nircmd.exe cmdshortcut " "~$folder.desktop$ "Hide All IE" win hide class "IEFrame"

�����洴�������ٴ���ʾ����IE���ڵĿ�ݷ�ʽ

nircmd.exe cmdshortcut " "~$folder.desktop$ "Show All IE" win show class "IEFrame"

��calculator��������Ϊ���ϲ㴰��(����������֮��)

nircmd.exe win settopmost title "Calculator" 1

�ָ�calculator����Ϊԭʼ����״̬(���������ϲ�)

nircmd.exe win settopmost title "Calculator" 0

����calc.exe��ݷ�ʽ����ʼ�˵�->����->Calculators

nircmd.exe shortcut "f:\winnt\system32\calc.exe" "~$folder.programs$\Calculators" "Windows Calculator"

������������ͼ��

nircmd.exe win hide class progman

��ʾ��������ͼ��(�������������ع���)

nircmd.exe win show class progman

����ϵͳ��ʼ��ť

nircmd.exe win child class "Shell_TrayWnd" hide class "button"

��ʾϵͳ��ʼ��ť

nircmd.exe win child class "Shell_TrayWnd" show class "button"

����ϵͳʱ��

nircmd.exe win child class "Shell_TrayWnd" hide class "TrayClockWClass"

��ʾϵͳʱ��

nircmd.exe win child class "Shell_TrayWnd" show class "TrayClockWClass"

��ֹ����IEʵ��

nircmd.exe killprocess iexplore.exe

���������ݷ�ʽ�����м��ɵ�������(K��)

nircmd.exe cmdshortcut "~$folder.desktop$" "Open CDROM" cdrom open k:

��nirsoft��ַ�����������ݷ�ʽ

nircmd.exe urlshortcut "http://www.nirsoft.net" "~$folder.desktop$" "NirSoft"

���nirsoft��ַ���ղؼ�\������

nircmd.exe urlshortcut "http://www.nirsoft.net" "~$folder.favorites$\Links" "NirSoft"

��nirsoft��ַ��ݷ�ʽ������computers.txt���г������м����������

nircmd.exe multiremote copy "c:\temp\computers.txt" urlshortcut "http://www.nirsoft.net" "~$folder.common_desktop$" "NirSoft"

������ʾģʽΪ800X600��24λɫ

nircmd.exe setdisplay 800 600 24

��������ʾģʽΪ800X600��24λɫ�����Ϊ�����ݷ�ʽ

nircmd.exe cmdshortcut "~$folder.desktop$" "800x600x24" setdisplay 800 600 24

�������������ݷ�ʽ�������ļ���(f:\temp\desktop)

nircmd.exe execmd copy "~$folder.desktop$\*.lnk" f:\temp\desktop

�������Apache server������(windows NT/2000/XP/2003)

nircmd.exe service restart apache

������Apache server�����������Ϊ�����ݷ�ʽ

nircmd.exe cmdshortcut "~$folder.desktop$" "Restart Apache" service restart apache

����IIS(��������Ϣ����)

nircmd.exe service restart w3svc

����MySql

nircmd.exe service restart MySql

��ָ��ע�����/ֵ

nircmd.exe regedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"

������ע���༭���и��Ƶ����а��ע�����

nircmd regedit "~$clipboard$"

��������

nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 0

ȡ����������

nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 1

�ı�ָ���ļ�������/ʱ��(����ʱ����޸�ʱ��)

nircmd.exe setfiletime "c:\temp\myfile.txt" "24-06-2003 17:57:11" "22-11-2005 10:21:56"

������������·�������а�

nircmd.exe clipboard set ~$folder.desktop$

���ƿ�ʼ�˵��ļ���·�������а�

nircmd.exe clipboard set ~$folder.start_menu$

�����ı�info1.txt�е����ݵ����а�

nircmd.exe clipboard readfile "c:\My Files\info1.txt"

�����а���������ӵ��ı�info1.txt��

nircmd.exe clipboard addfile "c:\My Files\info1.txt"

��ռ��а�

nircmd.exe clipboard clear

����������"c:\temp\folders.txt"��ָ�����ļ��У��ļ���·�����ûس�������

nircmd.exe paramsfile "c:\temp\folders.txt" "" "" execmd md ~$fparam.1$

��װ������ȫ�ֳ��򼯻���(GAC)��ָ����.NET����

nircmd.exe gac install "C:\temp\MyAssembly\bin\MyAssembly.dll"

������д����ϵĻ���վ

nircmd.exe emptybin

��һ����׼��Windows��Ϣ��ظ�ȷ��

nircmd.exe dlg "" "" click yes

�ӳ�2���ӣ�Ȼ�󱣴浱ǰ��Ļ��ͼ��shot.png

nircmd.exe cmdwait 2000 savescreenshot "f:\temp\shot.png"


cdrom open     cdrom close    cdrom open *:            cdrom close *:              monitor off
�򿪹���           �رչ���          ��ָ������               �ر�ָ������                  �ر���ʾ��

exitwin logoff       clipboard clear      screensaver     standby    exitwin logoff
ע��                     ��ռ�����           ��������            ����         ע����ǰ�û�

exitwin poweroff       setdisplay 800 600 24
�رռ����                ������ʾ��800��600���� 24λ��ɫ

ֱ�ӽ�ϵͳ�����������
nircmd.exe setsysvolume 65535

clipboard readfile "c:\***\2123.txt"
��ָ�����ı��ļ������ݷ���ļ��а�

clipboard addfile "c:\***\2123.txt"
�����а�����׷�ӵ�ָ���ı��ı�

infobox [message text] [title]
��ʾһ���򵥵���Ϣ������Ļ�ϡ�
���ӣ�infobox "����" "����"

shellcopy [source file or wildcard] [destination] {Flags}
�ļ�����
�� yestoall ȫ��
�� noerrorui ����ʾ�����û�������Ϣ
�� silent ����ģʽ-����ʾ�ļ����ƽ���
�� nosecattr ��Ҫ���Ƶİ�ȫ���Ե��ļ���
���ӣ�
shellcopy "c:\temp\*.*" "d:\temp"
shellcopy "c:\temp\*.*" "d:\temp" yestoall noerrorui

filldelete [source file or wildcard]
����ɾ���ļ����������վ
���ӣ�
�� filldelete "C:\WINDOWS\*.log"
�� filldelete "C:\1.dat"

infobox [message text] [title]
����Ļ����ʾһ���򵥵���Ϣ�򣨣���
���ӣ�infobox "��ʾ" "����"

qbox [message text] [title] [program to run]
��ʾһ������Ի�������Ļ�ϡ�����û��ش�" yes " �����г���
���ӣ�qbox "ȷ�����м�������" "��ʾ" "calc.exe"

qboxtop [message text] [title] [program to run]
��ʾһ���ö�����Ի�������Ļ�ϡ�����û��ش�" yes " �����г���
���ӣ�qboxtop "ȷ�����м�������" "��ʾ" "calc.exe"

regedit [key] [value name]
��ע�����ָ���ļ�/ֵ��
���ӣ�regedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"

regdelval [key] [value]
ɾ��ע���ֵ
���ӣ�regdelval "HKEY_CURRENT_USER\Software\Test" "Value1"

regdelkey [key]
ɾ��ע����
���ӣ�regdelkey "HKEY_CURRENT_USER\Software\Test"

������Ļ��������
nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 0

������Ļ��������
nircmd.exe regsetval sz "HKCU\control panel\desktop" "ScreenSaveActive" 1

setcursor [X] [Y]
�����������Ļλ��
���ӣ�setcursor 100 50

win settopmost title "������" 1         win settopmost title "������" 0
���� Windows �����������ö���ʾ      ȡ�� Windows �����������ö���ʾ

sendmouse [right|left|middle] [down|up|click|dblclick]
������
���ӣ�
�� sendmouse right click �Ҽ����
�� sendmouse left click  ������
�� sendmouse left dblclick ˫��������
�� sendmouse left down  ����������
�� sendmouse left up  �ɿ�������
�� sendmouse middle click

inisetval  inisetval [INI filename] [section] [key] [value]
д��ֵ�� INI �ļ�. ����ļ��������򽫱��Զ�����.
��: inisetval "c:\windows\test.ini" "section1" "TestValue" "1"

inidelval  inidelval [INI filename] [section] [key]
ɾ�� INI �ļ���ĳ��ֵ.
��: inidelval "c:\windows\test.ini" "section1" "TestValue"

inidelsec  inidelval [INI filename] [section]
ɾ�� INI �ļ���ĳ�����μ������е�ֵ.
��: inidelsec "c:\windows\test.ini" "section1"

regsvr  regsvr [reg or unreg] [filename or wildcard] {log file}
ע�����ע�� DLL/OCX �ļ�.
��һ������ָ�� "reg" ��ע���ļ�, "unreg" ���ע���ļ�.
�ڶ�������ָ����Ҫע�����ע����ǵ����ļ����Ƕ���ļ�, ֧��ͨ���.
�����������ǿ�ѡ��, ָ���Ƿ����������¼.
��:
regsvr reg "f:\winnt\system32\fv*.ocx" "c:\temp\log1.txt"
regsvr unreg "f:\winnt\system32\ab*.dll"

regsetval [type] [key] [value name] [value]
���û򴴽�ע���ֵ
���ӣ�
regsetval dword "HKEY_CURRENT_USER\Software\Test" "Value1" "0xaabbccdd"
regsetval dword "HKCU\Software\Test" "Value2" "10561"
regsetval sz "HKCU\Software\Test" "Value3" "string value"
regsetval binary "HKLM\Software\Test" "Value4" "6a cb ab dd 80 86 95"

win [action] [find] [window to find] [Additional Parameters]
���ô���
���ӣ�
�� win close title "�ޱ��� - ���±�"  �ر�ָ�����ڣ��ȽϾ�ȷƥ�䣩
�� win activate title "�ޱ��� - ���±�"  ����ָ������
�� win max title "�ޱ��� - ���±�"  ���ָ������
�� win trans title "�ޱ��� - ���±�" 80  ͸����ָ�����ڣ�0-255������СԽ͸����
�� win center title "�ޱ��� - ���±�"  ���Ծ���ָ������
�� win close stitle "�ޱ���"  �ر�ָ�����ڣ�ģ��ƥ�䣩

Ŀ¼
~$folder.windows$  C:\Windows Ŀ¼
nir.exefile  ��ǰ���е� NirCmd ���ڵ�����·�� (��: c:\winnt\nircmd.exe)
folder.nircmd  ��ǰ���е� NirCmd ���ڵ�Ŀ¼.
folder.desktop  ����Ŀ¼.
folder.start_menu  ��ʼ�˵�Ŀ¼.
folder.programs  ��ʼ�˵�������Ŀ¼.
folder.startup  "����" Ŀ¼.
folder.recent  ������ĵ�Ŀ¼.
folder.favorites  �ղؼ�Ŀ¼.
folder.cookies  Cookies Ŀ¼.
folder.appdata  ���ó�������Ŀ¼. (��: C:\Documents and Settings\Administrator\Application Data)
folder.common_desktop  ��������Ŀ¼.
folder.common_start_menu  ���п�ʼ�˵�Ŀ¼.
folder.common_programs  ���п�ʼ�˵�������Ŀ¼.
folder.common_startup  ���� "����" Ŀ¼.
folder.common_favorites  �����ղؼ�Ŀ¼.
folder.windows  Windows Ŀ¼. (��: C:\Windows)
folder.system  ϵͳĿ¼. (��: C:\Windows\System32)

exec show "notepad.exe"
����ָ������

shexec [operation] [filename]
��ָ��������в���
���ӣ�
�� shexec "open" "c:\my documents\abc.doc"
�� shexec "print" "d:\files\1.pdf"
�� shexec "open" "http://www.nirsoft.net"

urlshortcut "http://www.****.***" "~$folder.desktop$" "����"
����URL��ݷ�ʽ����ǰ�û�����

ɾ���ļ���
execmd rd "~$folder.appdata$\PE Explorer"

�����ļ���
execmd md "~$folder.appdata$\PE Explorer"

sendkey 0x25 press      sendkey 0x27 press sendkey 0x26 press
�������  �������  �������
sendkey 0x28 press��������ơ�

0x1 ������
0x2 ����Ҽ�
0x8 BackSpace��
0x9 TAB��
0xD Enter��
0x11 Ctrl��
0x14 Caps Lock��
0x1B ESC��


������HANGEUL 0x15 /* old name - should be here for compatibility */
������HANGUL 0x15
������JUNJA 0x17
������FINAL 0x18
������HANJA 0x19
������KANJI 0x19
������ESCAPE 0x1B
������CONVERT 0x1C
������NONCONVERT 0x1D
������ACCEPT 0x1E
������MODECHANGE 0x1F
������SPACE 0x20
������PRIOR 0x21
������NEXT 0x22
������END 0x23
������HOME 0x24
������LEFT 0x25
������UP 0x26
������RIGHT 0x27
������DOWN 0x28
������Select 0x29
������PRINT 0x2A
������EXECUTE 0x2B
������SNAPSHOT 0x2C
������Insert 0x2D
������Delete 0x2E
������HELP 0x2F
/*������0 thru������9 are the same as ASCII '0' thru '9' (0x30 - 0x39) */
/*������A thru������Z are the same as ASCII 'A' thru 'Z' (0x41 - 0x5A) */
��������WIN 0x5B
��������WIN 0x5C
������SEPARATOR 0x6C
������SUBTRACT 0x6D
������DECIMAL 0x6E
������DIVIDE 0x6F
LButton 0x1 ������ RButton 0x2 ����Ҽ�
Cancel 0x3 CANCEL �� MButton 0x4 ����м�
0x8 BACKSPACE �� 0x9 TAB ��
0xC CLEAR��  0xD ENTER ��
0x10 SHIFT��  0x11 CTRL ��
0x12 MENU��  0x13 PAUSE ��
0x14 CAPSLOCK �� 0x1B ESC ��
0x20 SPACEBAR �� 0x21 PAGE UP ��
0x22 PAGE DOWN �� 0x23 END ��
0x24 HOME ��
0x25 �� �� 0x26 �� �� 0x27 �� �� 0x28 �� ��
0x29 SELECT ��  0x2A PRINT SCREEN ��
0x2B EXECUTE ��  0x2C SNAPSHOT ��
0x2D INSERT ��  0x2E DELETE ��
0x2F HELP ��  0x90 NUMLOCK ��
0x60 NUM(0) �� 0x61 NUM(1) �� 0x62 NUM(2) ��
0x63 NUM(3) �� 0x64 NUM(4) �� 0x65 NUM(5) ��
0x66 NUM(6) �� 0x67 NUM(7) �� 0x68 NUM(8) ��
0x69 NUM(9) �� 0x6A NUM(*) �� 0x6B NUM(+) ��
0x6C NUM(ENTER)�� 0x6D NUM(-) ��
0x6E NUM(.) �� 0x6F NUM(/) ��
0x70 F1�� 0x71 F2�� 0x72 F3�� 0x73 F4��
0x74 F5�� 0x75 F6�� 0x76 F7�� 0x77 F8��
0x78 F9�� 0x79 F10�� 0x7A F11�� 0x7B F12��
0x7C F13�� 0x7D F14�� 0x7E F15�� 0x7F F16��

:helps
cls
findstr "^::" "%~f0"|more
echo;
::
::  - FILE: DIY����̨,gcc 3.4.0,notepad++ 8.1.0 ,Gvim��ȡ
::  - Compile: Tcc,sed,nircmd,sed,grep...���ⲿ�����.bat�ű�����,
::    ����exe��Դ�ļ�.cpp/.c
::  - ɱ��������ܱ�����������,�ⲿ�������ϵͳAPI��������������,
::    �������ע��������Ҫ����ԱȨ��
::