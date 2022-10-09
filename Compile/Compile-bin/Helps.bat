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

�����̷�ΪJ�Ĺ���

nircmd.exe cdrom open j:

�����̷�ΪY�Ĺ���

nircmd.exe cdrom close y:

�����������ı�����

speak text ~$clipboard$

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

nircmd.exe qboxcom "Do you want to reboot ?" "question" exitwin reboot

�رռ����

nircmd.exe exitwin poweroff

�ر�computers.txt��ָ�������м����

multiremote copy "c:\temp\computers.txt" exitwin poweroff force

���ſ������

nircmd.exe rasdial "My Internet"

�Ͽ��������

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

nircmd.exe win -style title "my computer" 0x00C00000

�ָ��ҵĵ��Դ��ڵı�����(������������ȥ����)

nircmd.exe win +style title "my computer" 0x00C00000

�����ҵĵ��Դ���Ϊ���������˳��(������ϣ������Ͱ�������)

nircmd win +exstyle title "my computer" 0x00400000

�����ҵĵ��Դ��ڵ������Ӵ���Ϊ���������˳��(����ͬ��)

nircmd win child title "my computer" +exstyle all 0x00400000

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

����calc.exe��ݷ�ʽ����ʼ�˵�->����->Calculators(������)

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

���nirsoft��ַ���ղؼ�������

nircmd.exe urlshortcut "http://www.nirsoft.net" "~$folder.favorites$\Links" "NirSoft"

��nirsoft��ַ��ݷ�ʽ������computers.txt���г������м����������

nircmd.exe multiremote copy "c:\temp\computers.txt" urlshortcut "http://www.nirsoft.net" "~$folder.common_desktop$" "NirSoft"

������ʾģʽΪ800X600��24λɫ

nircmd.exe setdisplay 800 600 24

��������ʾģʽΪ800X600��24λɫ�����Ϊ�����ݷ�ʽ

nircmd.exe cmdshortcut "~$folder.desktop$" "800x600x24" setdisplay 800 600 24

�������������ݷ�ʽ�������ļ���(f:tempdesktop)

nircmd.exe execmd copy "~$folder.desktop$\*.lnk" f:\temp\desktop

������Apache server������(windows NT/2000/XP/2003)

nircmd.exe service restart apache

������Apache server�����������Ϊ�����ݷ�ʽ

nircmd.exe cmdshortcut "~$folder.desktop$" "Restart Apache" service restart apache

����IIS(��������Ϣ����)

nircmd.exe service restart w3svc

����MySql

nircmd.exe service restart MySql

��ָ��ע�����/ֵ

nircmd.exe regedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"

����ע���༭���и��Ƶ����а��ע�����

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

��װ������ȫ�ֳ��򼯻���(like gacutil)��ָ����.NET����

nircmd.exe gac install "C:\temp\MyAssembly\bin\MyAssembly.dll"

������д����ϵĻ���վ

nircmd.exe emptybin

��һ����׼��Windows��Ϣ��ظ�ȷ��

nircmd.exe dlg "" "" click yes

�ӳ�2���ӣ�Ȼ�󱣴浱ǰ��Ļ��ͼ��shot.png

nircmd.exe cmdwait 2000 savescreenshot "f:\temp\shot.png"

ѭ������10����ͼ����ͼ���60�룬�ļ�������ʱ�������

nircmd.exe loop 10 60000 savescreenshot c:\temp\scr~$currdate.MM_dd_yyyy$-~$currtime.HH_mm_ss$.png

�ȴ�Fixfox�رգ����� "Firefox was closed"������Ѿ��رգ�

waitprocess firefox.exe speak text "Firefox was closed"

ϵͳҪ��

������߿��Թ���������32λ���Ӵ�����ϵͳ�� Windows 9x/ME, Windows NT, Windows 2000, Windows XP, Windows Server 2003,�� Windows Vista��������һЩ NirCmd ����ֻ������ Windows NT/2000/XP/2003/Vista ��������ִ�С�

��

���֤

��

����һ����������ֻҪ���Ӵ�����ȡ���ã��Ϳ������ɵ�ͨ�����̣�CD�����������������������ע���ڷ���ʱӦ�����˷������ڵ������ļ����������κ��޸ġ�

��

ʹ��NirCmd

��

��������һ�������Ŀ�ִ�г��򣬲���Ҫ�κεİ�װ���̻��߶����dll�ļ�֧�֡�ֻ��Ҫ��exe�ļ����Ƶ��κ�ָ�����ļ��У����Ҹ��������Ҫ�����Ҫ������ѡ�����м��ɡ��Ƽ�����NirCmd.exe��WindowsĿ¼�����߸��Ƶ��κ�ϵͳ��path�������������г���·���£������Ͳ���Ҫ��ÿ������ʱ����NirCmd������·����
�Ӱ汾1.50��ʼ��NirCmd��Ҳ�����ڿ���̨��ʹ�ã��ڿ���̨�汾�У����еĴ�����Ϣ������ʾ�ڿ���̨�����У������ǳ�������Ϣ����
��ʵ�ù��߿���������32λWindows����ϵͳ��Windows 9x/ME��Windows NT ��Windows 2000�� Windows XP��Windows Server 2003��Windows Vista��������һЩNirCmd����ֻ���� Windows NT/2000/XP/2003/Vista ������ִ�С�

��

NirCmd��һ���﷨

��

nircmd.exe {showerror} [command] [command parameters]

showerror�ǿ�ѡ���������ָ���˴˲�������ô���������й���������������󣬴�����Ϣ����ʾ����Ļ�ϡ����򣬻�������д���
���磺
nircmd.exe showerror rasdial "dial1"
nircmd.exe rasdial "dial1"
����������������У�NirCmd�᳢������diall��ڣ��ڵ�һ�������У��������ʧ�ܣ�������ʾһ���йش�����Ĵ�����Ϣ���ڵڶ��������У��������ʧ���򲻻���ʾ������Ϣ��

��

�����ַ�������

��

�Ӱ汾1.20��ʼ��NirCmd��������������в���������ַ���

�±��г��˿���ʹ�õ������ַ������У�

�� �� 

�� ��

~n

����(CR-LF)[�������з��ͻس���]

~q

˫���ţ�"

~t

�Ʊ�� Tab��

~xnn

��һ��������λʮ���������ֵ�ASCII�������κ��ַ������磺~x41 (�ַ�'A'), ~x27 (������)

~$variable$

����ϵͳ������������Ϣ�뿴�����ϵͳ������

~~

������~�ַ�

����:
infobox "This is the first line~n~qThis is a second line, in quotes~q" "Example"
��������ӻ���ʾһ���������е���Ϣ��

ϵͳ����

��1.40�汾��ʼ��NirCmd�ṩ�������ַ������ļ����Լ�����ϵͳ������ÿ�����������ַ�~��ͷ������ı���������������$�ڡ�
����~$folder.desktop$�ʹ�����ϵͳ��������ļ��е�·����(������nircmd infobox "~$folder.desktop"���鿴)��
�±��ָ���˿���ʹ�õ�һЩ������

������ 

�� �� 

clipboard

�����Ƶ����а���ı�����

param.paramname

��ָ��һ��param����ʱ����Ļ�ϻ���ʾһ�����봰�ڣ�Ҫ��Ϊָ���Ĳ��������ı�(�������Ϊ��������ֵ),������� �ı��ᱻ���뵽�������С���:������������У���Ҫ������2������(1��2)����������ı�����ʾ����Ϣ���С�nircmd infobox ~$param.1$ ~$param.2$

fparam.number

��ָ�����ı��м���ָ���Ĳ�����������Ϣ��ο�����paramsfile command

sys.varname

����ʹ�ô�ѡ������ʾϵͳ�ϵ��κλ�����������: ~$sys.username$, ~$sys.windir$, ~$sys.computername$, ~$sys.logonserver$, ~$sys.temp$, �ȵ�

nir.exefile

��ǰ���е�NirCmd������·��(��: c:\winnt\nircmd.exe)

loopcount

ִ��ѭ������ʱָ��ѭ������

currtime.TimeFormat

���ݡ�TimeFormat��ѡ���ʱ���ʽָ����ǰʱ�䡣
��:~%currtime.HH_mm_ss%�������ʱ���ʽ�˽����ο�currtime(ʱ���ʽ�ַ���)

currdate.DateFormat

���ݡ�DateFormat��ѡ������ڸ�ʽָ����ǰ���ڡ�
��:~%currdate.MM_dd_yyyy% ����������ڸ�ʽ�˽����ο�currdate(���ڸ�ʽ�ַ���)

folder.nircmd

NirCmd���ڵ��ļ���(·��)

folder.desktop

�û�����(·��)

folder.start_menu

�û���ʼ�˵��ļ���(·��)

folder.programs

�û���ʼ�˵������ļ���(·��)

folder.startup

�û���ʼ�˵����������ļ���(·��)

folder.recent

�û���ʼ�˵����������ļ���(·��)

folder.favorites

�û��ղؼ�(·��)

folder.cookies

cookies�ļ���(·��)

folder.appdata

Application Data�ļ���(·��)(����: C:\Documents and Settings\Administrator\Application Data)

folder.common_desktop

All user�����ļ���(·��)

folder.common_start_menu

ALL user��ʼ�˵��ļ���(·��)

folder.common_programs

ALL user��ʼ�˵������ļ���(·��)

folder.common_startup

ALL user��ʼ�˵����������ļ���(·��)

folder.common_favorites

ALL user�ղؼ�(·��)

folder.windows

Windows�ļ���(·��) (e.g.: C:\Windows)

folder.system

ϵͳ�ļ���(·��) (e.g.: C:\Windows\System32)

folder.programfiles

�����ļ����ļ���(·��) (e.g.: C:\Program Files)

folder.common_programfiles

ALL user�����ļ����ļ���(·��)(e.g.: C:\Program Files\Common)

folder.mydocuments

��My Documents���ҵ��ĵ��ļ���(·��)

���磺

1�� ������ʼ�˵������ļ��еĿ�ݷ�ʽ��
    shortcut "c:\winnt\system32\calc.exe" "~$folder.programs$\My Programs" "Calculator"
2�� ɾ���û������ĳ����ݷ�ʽ��
    execmd del "~$folder.desktop$\calc.lnk"
3�� ��ʾ��ǰ�ѵ�¼���û���
    infobox "The current logged-on user is ~$sys.username$" "logged-on user"
4�� ��ͼ���ð�����ǰʱ������ڵ��ļ������б���
    savescreenshot c:\temp\scr~$currdate.MMddyyyy$-~$currtime.HHmmss$.png

currtimeʱ���ʽ�ַ���

ʱ���ʽ�ַ����п��ܰ�����������:(��Щ��ʽ�ַ�����Ҫ���ִ�Сд!)

h

������Сʱ��ʮ��Сʱ��

hh

˫����Сʱ��ʮ��Сʱ��

H

������Сʱ����ʮ��Сʱ��

HH

˫����Сʱ����ʮ��Сʱ��

m

�����ַ���

mm

˫���ַ���

s

��������

ss

˫������

t

����ַ����ĵ���ʱ���ַ�, �� A ���� P

tt

����ַ����Ķ�ʱ���ַ�, ��AM����PM

��

currdate���ڸ�ʽ�ַ���

��

���ڸ�ʽ�ַ����п��ܰ�����������:(��Щ��ʽ�ַ�����Ҫ���ִ�Сд!)

��

d

�·��еĵ���������

dd

�·��е�˫��������

ddd

�����е���λ��������д

dddd

�����е�����ȫ��

M

�������·�

MM

˫�����·�

MMM

��λ����д�·�

MMMM

�·�ȫ��

y

���ĩβ��

yy

���ĩβ��λ��

yyyy

���ȫ��

��

��Զ�̼������ִ��NirCmd����

��

��1.40�汾��ʼ��������Զ�̼������ִ��NirCmd������ǣ�Ӧ��ע�����µ�һЩ���ƺ����⣺
1����ѡ��ֻ������Windows NT��Windows 2000��Windows XP����������Windows 9X��ʹ�á�
2�������Թ���Ա��ݵ�½Զ�̼������
3��Զ�̼�����ϵ�����ƻ�(Task Schedule)������뿪����(Ĭ�����е�NT/2000/XP��������Զ������˷������Բ��õ�����㡣)
4����������ƻ������һЩ���ƣ�����ȴ�60������ſ�����Զ�̼������ִ�С�
5��Զ�̼�����ϵ���������system�˻���ִ�У����ĳЩͬ���������ڱ���ִ�п��ܻ���������

��

��������������Զ�̼������ִ�е�NirCmd���

��

remote - ������һ̨Զ�̼������ִ������
multiremote - �����ڶ�̨Զ�̼������ִ������
����

��

������ǵ�ȷ�е��﷨�����ʱ���Բ鿴�����ļ� NirCmd (NirCmd.chm) ���߿���ʹ�ð������help command�����ᵽ�� http://nircmd.nirsoft.net/,���磺 nircmd.exe help multiremote

NirCmd����

remote {copy} [\\computer] [NirCmd command]

��Զ�̼������ִ��NirCmd������ָ����{copy}������NirCmd���Ḵ������Զ�̼������ WindowsĿ¼�¡����Զ�̼������WindowsĿ¼�²�����NirCmd.exe�������ָ��{copy}������ 
����:
remote copy \\comp1 exitwin poweroff
remote \\comp2 infobox "This is a message from NirCmd" "Hello !"
remote \\comp3 lockws

multiremote {copy} [computers file] [NirCmd command]

�ڶ�̨Զ�̼������ִ�� NirCmd������ָ���� {copy} ������NirCmd���Ḵ������Զ�̼������ WindowsĿ¼�¡����Զ�̼������WindowsĿ¼�²�����NirCmd.exe�������ָ�� {copy} ���������� [computers file] ָ��һ���ļ������ļ��������Իس����ָ�(CRLF)�ļ�����б�


�ļ�[computers file] ����:
\\comp1
\\comp2
\\winxp1
\\winxp2
\\nirsoft

�ڲ��� [NirCmd command] ��ָ���������������[computers file]ָ���ļ���������С�

����:

�ر�������computers.txt���г��ļ������
multiremote "c:\temp\computers.txt" exitwin poweroff force
����������computers.txt���г��ļ������
multiremote "c:\temp\computers.txt" lockws
����NirCmd.exe������computers.txt���г��ļ�����ϣ����ҹر�����ʾ����
multiremote copy "c:\temp\computers.txt" monitor off
����NirCmd.exe������computers.txt���г��ļ�����ϣ�����wul.exe (WinUpdatesList)���Ա㱣�����м�����ϵ�Windows������Ϣ��
multiremote copy "c:\temp\computers.txt" exec hide c:\temp\wul.exe /shtml "c:\temp\wul_~$sys.computername$.html"
cmdwait [Number of Milliseconds] [NirCmd Command]

�ȴ�ָ���ĺ�������Ȼ��ִ��ָ����NirCmd���

����:
cmdwait 1000 monitor off

loop [Number of Times] [Number of Milliseconds] [NirCmd Command]

ָ������ִ��ѭ�������� ����ִ���ڼ䣬NirCmd �ȴ��ڶ�������ָ���ĺ������� ͨ��~%loopcount% ����ָ��ѭ���еĺ��к���(��1 �� n)

����:
loop 3 2000 speak text "Call Number ~$loopcount$"
loop 10 60000 savescreenshot c:\temp\scr~$loopcount$.png

paramsfile [Parameters File] [Delimiters] [Quote Character] [NirCmd Command]

����һ����ǿ�������������һ���ı��ļ��м���һ�������������Ӷ����Գɱ���ִ��NirCmd������ı��ļ����ݿ����Զ��š�Tab���ֺŻ��� �κ��ڲ���[Delimiters]��ָ���ķ�����Ϊ�ָ�����
��һ�����ӣ������������ı��ļ���������һЩ�û��������룬��','������

user01, 123456

user02, abcfg

user03, 5fr23

user04, 33333

�����NirCmd����ᴴ���������ı��ļ���ָ����4���û��������롣(ͨ��ʹ��Windows 2000/XP����ϵͳ�ṩ��net user����)
nircmd.exe paramsfile "c:\temp\users.txt" "," "" execmd net user ~$fparam.1$ ~$fparam.2$ /add

~$fparam.1$ָÿ�еĵ�һ�����������û�����~$fparam.2$ָÿ�еĵڶ��������������롣

����:
paramsfile "c:\temp\folders.txt" "" "" execmd md ~$fparam.1$
paramsfile "c:\temp\shortcuts.txt" "," "~q" shortcut ~$fparam.1$ "~$folder.desktop$" ~$fparam.2$

infobox [message text] [title]

����Ļ����ʾһ���򵥵���Ϣ��


����:
infobox "This is a message box !" "message"

qbox [message text] [title] [program to run]

����Ļ����ʾһ��ѯ�ʶԻ�������û��ش��ǣ������г���


����:
qbox "Do you want to run the calculator ?" "question" "calc.exe"

qboxtop [message text] [title] [program to run]

ͬqbox�������ƣ�����ʾ�ĶԻ���Ϊ���ϲ㴰��

qboxcom [message text] [title] [NirCmd Command]

����Ļ����ʾһ��ѯ�ʶԻ�������û��ش��ǣ���ִ�в���[NirCmd Command]��ָ����NirCmd����

����:
qboxcom "Do you want to lock your workstation ?" "question" lockws
qboxcom "Do you want to turn off the monitor ?" "monitor" monitor off

qboxcomtop [message text] [title] [NirCmd Command]

ͬqboxcom�������ƣ�����ʵ�ĶԻ���Ϊ���ϲ㴰��

script [Script File]

�������������а�����һ���ű��ļ��е�һϵ������˽ű��ļ��ɲ���[Script File]ָ��

����:

script "c:\temp\msg.ncl"

�ű��ļ�����:

infobox "Hello !" "This is the first message"

infobox "Hello !" "This is the second message"

infobox "Hello !" "This is the third message"

regedit [key] [value name]

��ע���༭����ָ����/ֵ

����:
regedit "HKLM\Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"
regedit "HKEY_CURRENT_USER\Control Panel\Desktop" "Wallpaper"

regsetval [type] [key] [value name] [value]

��ֵд��ע�������[type]����Ϊ��"sz"��"expand_sz" ָ�ַ�����"dword" ָ32λ���֣�"binary" ָ���������ݡ�����ڲ���[key]��ָ��������ע����в����ڣ�����Զ��������
����:
regsetval dword "HKEY_CURRENT_USER\Software\Test" "Value1" "0xaabbccdd"
regsetval dword "HKCU\Software\Test" "Value2" "10561"
regsetval sz "HKCU\Software\Test" "Value3" "string value"
regsetval binary "HKLM\Software\Test" "Value4" "6a cb ab dd 80 86 95"

regdelval [key] [value]

ɾ��ע����е�ĳ��ֵ
����:
regdelval "HKEY_CURRENT_USER\Software\Test" "Value1"

regdelkey [key]

ɾ��ע����е�������ָ��������һ����������ʱ��������ʧЧ
����:
regdelkey "HKEY_CURRENT_USER\Software\Test"

inisetval [INI filename] [section] [key] [value]

��ֵд��ini�ļ�������ļ������ڣ����Զ�����
����:
inisetval "c:\windows\test.ini" "section1" "TestValue" "1"

inidelval [INI filename] [section] [key]

ɾ��ini�ļ��е�һ����-ֵ
����:
inidelval "c:\windows\test.ini" "section1" "TestValue"

inidelval [INI filename] [section]

ɾ��ini�ļ�������(��[]�ֶ�)����ɾ���˶��а���������ֵ
����:
inidelsec "c:\windows\test.ini" "section1"

regsvr [reg or unreg] [filename or wildcard] {log file}

ע�����ע��DLL/OCX�ļ���
�ڵ�һ������[reg or unreg]�У�ָ��"reg"��ʾע���ļ���ָ��"unreg"��ʾ���ע���ļ���
�ڵڶ�������[filename or wildcard]�У�����ָ��Ҫע�����ע���ĳ����һ�ļ�������ļ���ͨ���ָ����
������Ϊ��ѡ������ָ��һ����־�ļ�������ע������Ľ��
����:
regsvr reg "f:\winnt\system32\fv*.ocx" "c:\temp\log1.txt"
regsvr unreg "f:\winnt\system32\ab*.dll"

rasdial [Entry Name] {Phonebook File} {User Name} {Password} {Domain}

����ʾ�κ��û����棬�����������ӵ�RAS����ӿ�(VPN�����绰��)�����˲���[Entry Name]Ϊ���裬����������Ϊ��ѡ���������û��ָ����ѡ����������ָ��Ϊ���ַ���("")������ʹ��Ĭ��ֵ
����:
rasdial "My Internet"
rasdial "VPN1" "" "user1" "abc1234" "domain1"

inetdial [Entry Name]

�����������ӵ�RAS����ӿ�(VPN�����绰��)����ʾ���Ž��̵���Ϣ�Ի���
������ֻ������IE�汾4.0�������ϡ�ע�⣺�������ھɰ汾��Windows 98�Ͽ�����Ч
����:
inetdial "VPN1"

rasdialdlg [Entry Name] {Phonebook File} {Phone Number or IP Address}

��ʾ���ڲ������ӵ�RAS����ӿڡ����� {Phonebook File} �� {Phone Number} Ϊ��ѡ���������û��ָ������ {Phonebook File} ����ָ��Ϊ���ַ���("")����ʹ��Ĭ�ϵ绰����
������ֻ������Windows NT��Windows 2000��Windows XP����֧��Windows 98/ME
����:
rasdialdlg "Internet1" "" "9876543"
rasdialdlg "VPN1"

rashangup {Entry Name}

�ж�RAS���ӡ������ô���������ֹ֮ǰ������inetdial����rasdial���������ӡ����û��ָ������{Entry Name}�����л���Ӷ�������ֹ.
����:
rashangup "VPN1"
rashangup

setdialuplogon [Entry Name] [User Name] {Password} {Domain} {Phonebook File}

�޸Ĳ������ӵ��û��������롢����
����: 

[Entry Name]: ����������
[User Name]: �趨�������ӵ��û���
{Password}: �趨�������ӵ�����
{Domain}: �趨�������ӵ�����
{Phonebook File}: �绰���ļ�������Ҫ�޸ĵĲ���������Ŀ�����û��ָ���˲���������ʹ��Ĭ�ϵ绰��
����:
setdialuplogon "VPN1" "user1" "asder443" "domain1"
setdialuplogon "Internet1" "nirs3" "q5r4df7yh5"

exitwin [shutdown type] {additional option}

�����������رյ�ǰ�Ự���ڡ�
���� [shutdown type] ������һ��ֵ֮һ��

logoff: �������н��̣�ע����ǰ�û�����ʾ��¼�Ի������л��û�
reboot: �ر�ϵͳ����������
poweroff: �ر�ϵͳ���رյ�Դ(ֻ��֧�ִ����ʵ�ϵͳ��Ч)��
shutdown: ֻ�ر�ϵͳ�������������ص�Դ
������ʹ��һ�µĸ���ѡ�

force: ����ǿ����ֹ����Ӧ�ó���ʹ�ô�ѡ����ܻ����������еĳ���ʧ���ݡ�����ֻ�����������ʹ�ã�
forceifhung: ��ֹ����Ӧ��Ӧ�ó���������Windows 2000/XP

����:
exitwin reboot
exitwin poweroff force
exitwin logoff forceifhung

initshutdown {message} {timeout value in seconds} {force} {reboot}

ϵͳ�ػ�����������exitwin������Щ���ƣ������߱�һЩexitwin��֧�ֵĲ����������֧��Windows 95/98/ME�����û��ָ���κβ����������ڲ���ʾ�κ���Ϣ������������رռ������

������ 

{message}: ָ���ػ�ǰҪ��ʾ����Ϣ
{timeout value in seconds}: ָ���ػ�ǰ�ȴ�������
{force}: �����浱ǰ���ݣ�ǿ����ֹ����Ӧ�ó���
{reboot}: �ػ�������

����:
initshutdown "shutting down the system within 60 seconds" 60 reboot
initshutdown "" 0 force

abortshutdown

ȡ����initshutdown������еĹػ��������������κβ���
����:
abortshutdown

lockws

���������������������󣬱�������������������ֻ������Windows 2000/XP

monitor [action]

�ı���ʾ��״̬������ [action] ���԰�������ֵ��
 

off: �ر���ʾ��
on: ����ʾ��
low: ����Ϊ�ͺĵ�״̬

���������ܹ�����֧�ָ����Ե�ϵͳ��
����:
monitor off
monitor on
monitor async_off

screensaver

����Ĭ������

standby {force}

�رռ�����������ڴ���ģʽ�����ָ�� {force} ������ϵͳ�᲻��������Ӧ�ó������ֱ�ӽ������״̬�����Ƽ�ʹ�ô˲�����������֧�ִ���ģʽ��ϵͳ


����: 
standby force
standby

hibernate {force}

�رռ����������������ģʽ�����ָ�� {force} ������ϵͳ�᲻��������Ӧ�ó������ֱ�ӽ�������״̬�����Ƽ�ʹ�ô˲�����������֧������ģʽ��ϵͳ

����:
hibernate force
hibernate

shortcut [filename] [folder] [shortcut title] {arguments} {icon file} {icon resource number} {ShowCmd} {Start In Folder} {Hot Key}

�����ļ��Ŀ�ݷ�ʽ��
����: 

[filename]: ָ��Ҫ������ݷ�ʽ���ļ�
[folder]: ָ����ݷ�ʽ�Ĵ���λ�á�����ָ���κ���Ч���ļ��У�����һЩ����ϵͳ�ļ��е�����������磺~$folder.programs$ (��ʼ/�����ļ���)�ȵ�...
[shortcut title]: �˿�ݷ�ʽ������
{arguments}: ��ѡ���� - ִ�д��ļ��ĸ��Ӳ���
{icon file}: ��ѡ���� - �����ʹ������ͼ��������Ĭ��ͼ����ʹ�ô˲���
{icon resource number}: ��ѡ���� - ͼ���ļ��е�ͼ�����
{ShowCmd}: ��ѡ���� - ��󻯻���С���������д��ڡ�ָ��"max"��󻯴��ڣ�"min"��С������
{Start In Folder}: ��ѡ���� - ָ����ʼλ�á����û���ƶ��˲�������ʼλ�þ��Զ�����Ϊ�ڲ��� [filename] ��ָ�����ļ���
{Hot Key}: ��ѡ���� - ָ����ݼ�(�ȼ�)������ Alt+Ctrl+A, Alt+Shift+F8, Alt+Ctrl+Shift+Y

����:
shortcut "f:\winnt\system32\calc.exe" "~$folder.desktop$" "Windows Calculator"
shortcut "f:\winnt\system32\calc.exe" "~$folder.programs$\Calculators" "Windows Calculator"
shortcut "f:\Program Files\KaZaA\Kazaa.exe" "c:\temp\MyShortcuts" "Kazaa"
shortcut "f:\Program Files" "c:\temp\MyShortcuts" "Program Files Folder" "" "f:\winnt\system32\shell32.dll" 45
shortcut "f:\Program Files" "c:\temp\MyShortcuts" "Program Files Folder" "" "" "" "max"

cmdshortcut [folder] [shortcut title] [command]

����һ��NirCmd�����ݷ�ʽ�����п�ݷ�ʽʱ��˫������������ָ���� [command] ��������ִ��
����:
cmdshortcut "~$folder.desktop$" "Open CDROM" cdrom open k:
cmdshortcut "c:\temp" "Turn Monitor Off" monitor off

cmdshortcutkey [folder] [shortcut title] [hot key] [command]

����һ��ָ����ݼ���NirCmd�����ݷ�ʽ�������д˿�ݷ�ʽ(˫��),���� [command] ָ��������ᱻִ��
����:
cmdshortcutkey "~$folder.desktop$" "Open CDROM" "Ctrl+Shift+K" cdrom open k:
cmdshortcutkey "c:\temp" "Turn Monitor Off" "Ctrl+Shift+M" monitor off

urlshortcut [URL] [Folder] [Shortcut Title]

������ҳ��ݷ�ʽ(�����ղؼ��е���ҳ��ݷ�ʽ)������ [Folder] ָ���˿�ݷ�ʽ�Ĵ���λ�ã�����봴����ݷ�ʽ���ղؼУ���ʹ�ã�~$ folder.favorites$ variable.

����:
urlshortcut "http://www.nirsoft.net" "~$folder.favorites$" "NirSoft Web Site"
urlshortcut "http://www.google.com" "~$folder.favorites$\Search Engines" "Google"
urlshortcut "http://www.yahoo.com" "c:\temp" "Yahoo"

exec [show/hide/min/max] [application + command-line]

����һ��Ӧ�ó���,��ѡ���Ե�Ϊ�˳���ָ��һ�����������в��� [show/hide/min/max] (��ʾ/����/��С/���ֵ)] ����ָ���Ƿ���ʾ���������е�Ӧ�ó����Ҵ�����󻯻���С�������ѡ��hide(����)��ѡ��,���е�Ӧ�ó����ں�̨���в��ɼ��������max(���ֵ)��ѡ��,���е�Ӧ�ó��򴰿���󻯡����ѡ��min(��С)��ѡ��,���е�Ӧ�ó��򴰿���С����
����:
exec show "f:\winnt\system32\calc.exe"
exec hide "c:\temp\wul.exe" /savelangfile
exec max "c:\temp\test.exe"

exec2 [show/hide/min/max] [working folder] [application + command-line]

������ִ��exec����,����Ҳ�ṩ����һ������,[working folder],���������ָ���ļ���Ĭ�ϵĹ���Ŀ¼��Ӧ�ó���

 

����:
exec2 show "f:\winnt\system32" "f:\winnt\system32\calc.exe"
exec2 hide c:\temp "c:\temp\wul.exe" /savelangfile

execmd [command]

ִ��������ʾ����(����̨)����,��Ļ�ϲ���ʾ�κ���Ϣ


����:
execmd del "~$folder.desktop$\calc.lnk"
execmd mkdir f:\temp\desktop1
execmd copy "~$folder.desktop$\*.lnk" f:\temp\desktop

shexec [operation] [filename]

����ע������ļ���չ���Ķ���򿪻��ӡ�ļ����磺��չ��Ϊ.doc���ļ�������MS-Word��ʽ�򿪣�.html�ļ���Ĭ��������򿪡����ָ��һ�� ��Ч����ַ��������Ĭ��������д򿪴���ҳ������ [operation] ����Ϊ"open(��)"��"print(��ӡ)"��

����:
shexec "open" "c:\my documents\abc.doc"
shexec "print" "d:\files\1.pdf"
shexec "open" "http://www.nirsoft.net"

setfiletime [filename or wildcard] [Created Date] {Modified Date} {Accessed Date}

�޸�һ�������ļ��ġ�����/�޸�/���ʡ����ڡ���һ�����������ǵ����ļ���������ͨ���ָ�������ڲ������������и�ʽָ����"dd-mm-yyyy hh:nn:ss" �����û��ָ�����ڲ�������ָ��Ϊ�մ�(" ")�����ڲ��䡣���ָ��ʱ�����Ϊ��now(��ǰ)�������޸�Ϊ��ǰ���ں�ʱ��

��

����:
setfiletime "c:\temp\*.exe" "15-05-2004 11:22:12" "22-01-2005 21:22:55"
setfiletime "c:\temp\myfile.txt" "24-06-2003 17:57:11" "" "22-11-2005 10:21:56"
setfiletime "c:\temp\myfile.txt" now now

setfilefoldertime [filename, folder or wildcard] [Created Date] {Modified Date} {Accessed Date}

�޸�һ�������ļ��ġ�����/�޸�/���ʡ����ڡ�������ͬ setfiletime ����ǳ����ơ�Ψһ�Ĳ�ͬ���� setfilefoldertime ��������޸��ļ��е����� - ֻ������Windows 2000/XP


����:
setfilefoldertime "c:\temp\myfolder" "10-01-2003 11:22:12" "12-11-2002 02:34:11"
setfilefoldertime "c:\temp\myfolder" now now

clonefiletime [source filename] [Wildcard]

�޸�һ���ļ������ļ��ġ�����/�޸�/���ʡ����ڣ�����[ͨ���]��

��

��ʽ��NirCmd clonefiletime [source filename] [Wildcard]
������[source filename]-[Դ�ļ���] [Wildcard]-[ͨ���]

����:
clonefiletime "x:\temp\file1.txt" "x:\files\*.*"
clonefiletime "x:\temp\file1.txt" "x:\files\*.txt"
clonefiletime "x:\temp\file1.txt" "x:\files\a*.txt"
clonefiletime "x:\temp\file1.txt" "x:\temp\file2.txt"

emptybin {drive}

��ջ���վ������{drive}ָ����Ҫ��յĻ���վ���ڵĴ��̡����û��ָ���˲�������������д��̵Ļ���վ��
 
����:
emptybin f:
emptybin

setdisplay {monitor:index/name} [width] [height] [color bits] {refresh rate} {-updatereg} {-allusers}

�޸���ʾ���á����� [width] �� [height] �������Ļ�ϵ����ص��������� [color bits]��ʾ��Ļ����ɫλ��(8 - 256 color, 16 - 16bit color, 24 - 24bit color�ȵ� {refresh rate} �ǿ�ѡ������ָ����ʾ����ˢ��Ƶ�ʡ����ָ���� {-updatereg} �����������ûᱣ����ע����С����ͬʱָ�� {-updatereg} �� {-allusers} �����������û�Ӧ���������������û������ұ�����ע����С�

��

����:
setdisplay 800 600 24 -updatereg
setdisplay 1024 768 24 90
setdisplay 1024 768 8
setdisplay monitor:1 1024 768 24 90
setdisplay monitor:name1 1024 768 24 90

setprimarydisplay [Monitor index/name]

Ϊϵͳ������ʾ�����õ���Ҫ��ء�������[��� ָ��/����]

��

����:
setprimarydisplay 0
setprimarydisplay 1

killprocess [process]

����ָ�����̡��ڲ��� [process] �У�����ָ��������������·��(�磺C:\Program Files\Internet Explorer\iexplore.exe)����ָֻ��������(��: iexplore.exe)��������ͨ����׺'/'ָ�����̵�ID(�磺 /1120)��

����:
killprocess iexplore.exe
killprocess "c:\winnt\system32\calc.exe"
killprocess /1830

closeprocess [process]

ͨ���رն�������������ָ�����̡���killprocess�����෴��closeprocess����ǿ�������������̡��෴������ָ�����̵Ķ������ڷ��� һ��WM_CLOSE��Ϣ��ע�⣺�������û���û�����Ľ�����Ч��
�ڲ��� [process] �У�����ָ��������������·��(�磺C:\Program Files\Internet Explorer\iexplore.exe)����ֻ�ǽ�����(�磺iexplorer.exe)��������ͨ����׺'/'ָ�����̵�ID(�磺 /1120)��
 
����:
closeprocess iexplore.exe
closeprocess "c:\winnt\system32\calc.exe"
closeprocess /1830

waitprocess [process] {Command}

�ȴ�ֱ��ָ�����̽���
�ڲ��� [process] �У�����ָ��������������·��(�磺C:\Program Files\Internet Explorer\iexplore.exe)����ֻ�ǽ�����(�磺iexplorer.exe)��������ͨ����׺'/'ָ�����̵�ID(�磺 /1120)��
 
����:
waitprocess iexplore.exe
waitprocess firefox.exe speak text "Firefox was closed"
waitprocess "c:\winnt\system32\calc.exe"
waitprocess /1830

setprocesspriority [process] [priority]

Ϊָ�����������µ����ȼ�
�ڲ��� [priority] �У�����ָ������ֵ��

normal, low, belownormal, abovenormal, high, realtime
�ڲ��� [process] �У�����ָ��������������·��(�磺C:\Program Files\Internet Explorer\iexplore.exe)����ֻ�ǽ�����(�磺iexplorer.exe)��������ͨ����׺'/'ָ�����̵�ID(�磺 /1120)��

����:
setprocesspriority iexplore.exe high
setprocesspriority "c:\winnt\system32\calc.exe" low
setprocesspriority /1830 abovenormal

setprocessaffinity [process] [list of processor numbers]

���ý��̹���,
�ڲ��� [process] �У�ָ������ʹ�õĴ������������ж���������ļ������������ָ������·�����Ľ��� (��: 'C:Program Files\Internet Explorer\iexplore.exe') ����ֻ�ǽ�����(��: iexplore.exe). )��������ͨ����׺'/'ָ�����̵�ID(�磺 /1120)���ڲ��� [list of processor numbers] �У�����ָ����Ҫ�Ĵ��������֣�0�ǵ�һ����������1�ǵڶ�������������.

��

����:
setprocessaffinity iexplore.exe 0 1
setprocessaffinity "c:\winnt\system32\calc.exe" 0 1 2 3
setprocessaffinity /1830 0

memdump [process] [dump file] [bytes per line] {bytes to read} {start address} {nohex} {noascii}

����ָ���Ĳ�������ȡ���̵��ڴ棬��д���ļ���
����:

[process]: ��Ҫ��ȡ���ڴ�Ľ��̡�����ָ������·������������������ú�׺'/'ָ������ID��(����:/ 520)
[dump file]: ��������ָ�������ڴ�����ݵ��ļ���
[bytes per line]: dump file��ÿ�е��ڴ��ֽ���
{bytes to read}: ��ȡ���ֽ���
{start address}: ָ�����̵Ŀ�ʼ��ȡ��ַ
{nohex}: ��ѡ���������ָ���˲������ڴ����ݲ�����ʮ��������ʽ����
{noascii}: ��ѡ���������ָ���˲������ڴ����ݲ�����ASCII��ʽ����

����:
memdump iexplore.exe "c:\temp\dump.txt" "16" "0x10000" "0x400000"
memdump calc.exe "c:\temp\calc.txt" "32" "0x30000" "0x400000" nohex
memdump /525 "c:\temp\dump.txt" "16" "0x100000" "0x120000" noascii

service {\\Computer} [action] [service name]

�ı������ͷ����״̬����������
����:
 

{\\Computer}: ��ѡ������ָ��Զ�̼��������������Դ˲�����Ĭ��ʹ�ñ��ؼ����.
[action]: Ҫ���еĲ������˲�����������ֵ:
start: ����ָ���ķ������������.
stop: ָֹͣ���ķ������������.
pause: ��ָͣ���ķ������������.
continue: ����ָ���ķ������������.
restart: ֹͣ������ָ���ķ������������.
auto: �޸�ָ���ķ������������Ϊ�Զ�.
manual: �޸�ָ���ķ������������Ϊ�ֶ�.
disabled: ����ָ���ķ������������.
boot: (ֻ��������������)�޸�ָ������������Ϊ����(boot).
system: (ֻ��������������)�޸�ָ������������Ϊϵͳ(system).
[service name]: ���������������.

����:
service start schedule
service \\remote stop schedule
service restart w3svc

win [action] [find] [window to find] [Additional Parameters]

����Ӵ���:

win child [find] [top window to find] [action] [find] [child window to find] [Additional Parameters]

ͨ����������Թرա����ء���ʾ����󻯺���С��ָ���Ĵ��ڡ�
����:

[action]: ��ָ���Ĵ���Ҫ���еĲ���:
child: ��ָ���������ڵ��Ӵ��ڽ��в���.
close: �ر�ָ������.
hide: ����ָ������.
show: ��ʾָ������(����hide�������غ�).
hideshow: ����ָ������Ȼ������ʾ�˴��ڡ����ô�����������д��������.
activate: ��ָ�����ڷŵ��ϲ�.
flash: Flashָ���Ĵ��ڡ�[Additional Parameters]��ֵָ����֡�Ĵ�����Ĭ����5����ÿ֡�ĺ�����.
max: ���ָ������.
min: ��С��ָ������.
normal: �����С��ָ�����ں󣬻ָ�������״̬.
trans: ʹָ������͸�������� [Additional Parameters] ָ��͸���̶ȣ�ֵλ��0 - 255֮�䡣0 = ��ȫ͸����255 = ��ȫ��͸�� 
setsize: �趨ָ�����ڵĴ�С������ [Additional Parameters] ָ�����ڵĴ�С��ֵ����x��y��width(��)��height(��). 
move: �ƶ�/�������ڡ����� [Additional Parameters] ָ��Ҫ�ƶ�/���������ص�����ֵ������x��y��width(��)��height(��).  
center: ָ�����ھ���.
settopmost: ����ָ�����ڵ����ϲ���ʾ״̬��������� [Additional Parameters] Ϊ1��ָ������Ϊ���ϲ���ʾ�����Ϊ0����ȡ�����ϲ���ʾ
redraw: ˢ��ָ������.
settext: �޸�ָ�����ڱ���/����.
focus: ��ָ�����������ý���.
disable: ����ָ������.
enable: ����ָ������.
+style: ��ָ������������ʽ���������� [Additional Parameters] ָ�������ӵ���ʽ����.
-style: �Ƴ�ָ�����ڵ���ʽ���������� [Additional Parameters] ָ��Ҫ�Ƴ�����ʽ����.
+exstyle: ��ָ������������չ��ʽ���������� [Additional Parameters] ָ��Ҫ���ӵ���չ��ʽ����.
-exstyle: �Ƴ�ָ�����ڵ���չ��ʽ���������� [Additional Parameters] ָ��Ҫ�Ƴ�����չ��ʽ����.
postmsg: ������Ϣ��ָ�����ڡ����� [Additional Parameters] �е�����ֵָ������Ϣ������Msg, wParam, lParam.
sendmsg: ������Ϣ��ָ�����ڡ����� [Additional Parameters] �е�����ֵָ������Ϣ������Msg, wParam, lParam.
dlgclick: ����һ����굥������Ի����ڵİ�ť������ [Additional Parameters] ָ���˰�ť�Ŀؼ�ID����������Ԥ����İ�ť֮һ�� yes, no, ok, cancel, retry, ignore, close, help.
dlgsettext: �����ı����Ի����ڲ�ָ���ؼ������� [Additional Parameters] ָ���˿ؼ�ID.
dlgsetfocus: ���ý��㵽�Ի����ڲ�ָ���ؼ������� [Additional Parameters] ָ���˰�ť�Ŀؼ�ID.
[find]: ָ�����ҵ����ڵķ�ʽ:
handle: ͨ���ڲ��� [window to find] ��ָ�����ھ��������ָ������.
id: ͨ��ָ���Ӵ��ڵ�ID������Ҫ���Ӵ��ڡ��������Ӵ���.
class: ͨ���ڲ���[window to find]��ָ����������������ָ������.
title: ͨ���ڲ���[window to find]��ָ����ȷ�Ĵ�����������ָ������.
stitle: ͨ���ڲ���[window to find]��ָ�����ڵ�ǰ�����ַ�������ָ������.
ititle: ͨ��ָ��һϵ�д����ڴ��ڱ����е��ַ�������ָ������ͨ��ָ��һϵ�д����ڴ��ڱ����е��ַ�������ָ������.
alltop: ���ж��㴰��.
alltopnodesktop: ���ж��㴰�ڣ������������̷�����.
active: ��ǰ�����.
foreground: ǰ̨����.
desktop: ���洰��.
process: ͨ��ָ������ID(����: /3412)����̵�����(����: firefox.exe)�ҵ�����.
[window to find]: ����ǰ�������ֵ��ͨ������������������ָ������.

����:
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

���������ڴ򿪺͹ر�CD-ROM�������������̡� [action] ���������á�open(����)���� ��close(�ر�)�������δָ�� {drive:} ������������Ĭ������CD-ROM����������.


����:
cdrom open
cdrom close
cdrom open J:
cdrom close R:

clipboard [Action] [Parameter]

����д���Լ���ռ��а�.

[Action] �������в���ֵ֮һ��

set - ����ָ���ı��ļ������а�.
readfile - ����ָ���ı����������а�.
clear - ��ռ��а�.
writefile - �Ѽ��а�������д���ļ���(ֻ�������ı��ļ�)
addfile - �Ѽ��а���������ӵ��ļ���(ֻ�������ı��ļ�)
saveimage - ������а��е�ͼ���ļ�.
copyimage - ����ָ��ͼ���ļ��е�ͼ�񵽼��а�.
saveclp - ���浱ǰ���������ݵ�ϵͳ�������ļ�.
loadclp - ����ϵͳ�������ļ���������.
����copyimage �� saveimage ������֧�����¸�ʽ��.

bmp, .gif, .jpg, .png, .tiff - ֻ�ڰ�װ��GDI+�ļ��������Ч(��XP/2003/Vista�ϣ�GDI+�Ѿ���Ϊ����ϵͳ��һ���ֱ���װ�ڼ������)��
 
����:
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

����װȫ�ֳ��򼯻���(GAC)�е�һ������.
����:
gac install "C:\temp\MyAssembly\bin\Release\6\MyAssembly.dll"

beep [Frequency] [Duration]

������������������ [Frequency] ָ������Ƶ�ʣ���λ���ȡ����� [Duration] ָ����������ʱ�䣬��λ���롣��Windows 95/98/ME��, ���ϲ��������ԣ�ֻ�ᷢ��һ����׼����������


����:
beep 500 2000

stdbeep

����Windows��׼��������.
����:
stdbeep

setvolume [device] [left-volume] [right-volume]

�������������� [device] ���������豸��ʶ�������������£��˲�������Ϊ0����Windows Vista�£�Ĭ���ط��豸ָ��Ϊ1��Ĭ��¼���豸ָ��Ϊ0��
���� [left-volume] �� [right-volume] ֵλ��0(����)��65535(�������)֮�䣬��������������������.

��

����:
setvolume 0 0 0
setvolume 0 32768 32768
setvolume 0 0xffff 0

setsysvolume [volume] {Component} {Device Index}

����ϵͳ�������޸Ĵ�ֵ���Ӱ���������µ��������á����� [volume] ��ֵλ��0(����)��65535(�������) ֮�䡣
{Component} �ǿ�ѡ������ָ���������������֮һ��master(������)��waveout(�������)��synth(�ϳ���)��cd��microphone(��˷�)��phone��aux(��Ƶ�����)��line(��·)��headphones(����)��wavein(��������)��Ĭ��ֵ��master(������)����Windows Vista�£���������(�������->����)�µ���ʾ���豸����ʶ��������������豸�������ո����߱�������š�
{Device Index} �ǿ�ѡ������ָ���������豸�����������һ��������������ô����ʹ�ô˲��������û���ƶ��˲�����Ĭ��ʹ�ÿ��������ָ��������


����:
setsysvolume 0x8000
setsysvolume 0
setsysvolume 25000 waveout
setsysvolume 25000 master 1

Vista ����:
setsysvolume 0x8000
setsysvolume 0 "front mic"
setsysvolume 25000 speakers
setsysvolume 25000 "line in"
setsysvolume 25000 default_record

setsysvolume2 [left volume] [right volume] {Component} {Device Index}

������setsysvolume�����������������������������ǵ���������������������.


����:
setsysvolume2 10000 20000
setsysvolume2 30000 0
setsysvolume2 25000 15000 waveout
setsysvolume2 30000 0 master 1

changesysvolume [volume change] {Component} {Device Index}

���ӻ򽵵�ϵͳ���������� [volume change] ָ�����ӻ򽵵͵ĵ�λ��(�������ͣ���������)
{Component} �ǿ�ѡ������ָ���������������֮һ��master(������)��waveout(�������)��synth(�ϳ���)��cd��microphone(��˷�)��phone��aux(��Ƶ�����)��line(��·)��headphones(����)��wavein(��������)��Ĭ��ֵ��master(������)����Windows Vista�£���������(�������->����)�µ���ʾ���豸����ʶ��������������豸�������ո����߱�������š�
{Device Index} �ǿ�ѡ������ָ���������豸�����������һ��������������ô����ʹ�ô˲��������û���ƶ��˲�����Ĭ��ʹ�ÿ��������ָ��������

��

����:
changesysvolume 5000
changesysvolume -3000
changesysvolume 0x1000 waveout
changesysvolume 0x1000 master 1

Vista ����:
changesysvolume 5000
changesysvolume -3000
changesysvolume 0x1000 "line in"
changesysvolume 0x1000 "speakers" 1
changesysvolume 0x1000 default_record

changesysvolume2 [left volume change] [right volume change] {Component} {Device Index}

����changesysvolume�����������������������������ǵ���������������������

��

����:
changesysvolume2 1000 -1000
changesysvolume2 -3000 0
changesysvolume2 0 -5000 waveout
changesysvolume2 -3000 0 master 1

mutesysvolume [action] {Component} {Device Index}

����/ȡ������
���� [action] �У�ָ��1��ʾ������0��ʾȡ��������2��ʾ�ھ���������֮���л���
�ڶ�������Ϊ��ѡ����������ָ�������������֮һ��master(������)��waveout(�������)��synth(�ϳ���)��cd�� microphone(��˷�)��phone��aux(��Ƶ�����)��line(��·)��headphones(����)��wavein(��������)��Ĭ�� ֵ��master(������)����Windows Vista�£���������(�������->����)�µ���ʾ���豸����ʶ��������������豸�������ո����߱�������š�
{Device Index} �ǿ�ѡ������ָ���������豸�����������һ��������������ô����ʹ�ô˲��������û���ƶ��˲�����Ĭ��ʹ�ÿ��������ָ��������

��

����:
mutesysvolume 1
mutesysvolume 0
mutesysvolume 2 waveout
mutesysvolume 1 master 1

Vista ����:
mutesysvolume 1
mutesysvolume 0
mutesysvolume 2 "rear mic"
mutesysvolume 1 speakers 1
mutesysvolume 1 default_record

 

setappvolume [Process] [volume level] {Device Name/Index}

���������� Windows 7/Vista/2008 �ľ���Ӧ�õľ���Ӧ��.
���� [process] ����ָ����exe���ļ���(����: Firefox.exe, iexplore.exe, wmplayer.exe),������·���ļ���(����:��F:\Program Files\Internet Explorer\iexplore.exe��)�����ID(����: /3426)
�����Ҫ����������������ֵ������ָ����focused�����������
 [volume level] ������ƽ������0��1֮�䡣������˵,���������������͵�50%,��Ӧ�ð������������Ϊ0.5
 {Device Name/Index} �豸 ����/ָ�����һ����ѡ����������㲻ָ����,�����Ĭ���豸�������ָ���豸ָ��Ϊ����ֵ(0����һ���豸,1���ڶ��豸,�ȵ�),��Ҳָ���������豸������,�������������������ϵͳ�����е���Ƶ�豸,ʹ�� showsounddevices ���

��

����:
setappvolume iexplore.exe 0.2
setappvolume wmplayer.exe 0.75 Speakers
setappvolume /1275 0.25 1
setappvolume Firefox.exe 0.5
setappvolume focused 0.75

changeappvolume [Process] [volume level] {Device Name/Index}

�������� Increase/decrease(����/����)��Windows 7/Vista/2008ϵͳ�ľ���Ӧ�á�
 [process] ������������ָ����.exe�ļ���(���磺Firefox.exe, iexplore.exe, wmplayer.exe)��������·���ļ���(����:��F:\Program Files\Internet Explorer\iexplore.exe��)�����ID(���磺/3426)
�������Ҫ���������������á�focused��������
 [volume level] ����������һ������0��1��������������������������������С���������磬����������Ӵ�20%(Ŀǰ����)��70%����Ӧ�ý��˲�������Ϊ0.5
 {Device Name/Index} �豸����/ָ��}�ǿ�ѡ�Ĳ���������㲻ָ������Ĭ�ϵ�����豸ʹ�á�����������豸ָ��Ϊ����ֵ(0����һ���豸,1���ڶ��豸,�ȵ�)��������ָ��ϲ�������Ȼ�����������豸���ơ�Ϊ���ҳ������豸������ϵͳ��ʹ��showsounddevices���

��

����:
changeappvolume iexplore.exe -0.2
changeappvolume wmplayer.exe 0.55 Speakers
changeappvolume /1275 -0.25 1
changeappvolume Firefox.exe 0.5

muteappvolume [Process] [mute mode] {Device Name/Index}

��Windows 7/Vista/2008ϵͳ�У�Increase/decrease �ľ���Ӧ�á�
��[process] ��������ָ����exe���ļ���(����: Firefox.exe, iexplore.exe, wmplayer.exe),������·���ļ���(����:��F:\Program Files\Internet Explorer\iexplore.exe��)�����ID(����: /3426)
ѡ��������������������þ��������������� mute/unmute ����/����������
 [mute mode] ����ģʽ�������в���ֵ:
0 =��������
1 =����
2 =����/��������֮��״̬�л���
 {Device Name/Index} �豸����/ָ���ѡ��Ĳ���������㲻ָ����,Ĭ������豸ʹ�á������ָ���豸ָ����Ϊ����ֵ(0����һ���豸,1���ڶ��豸,�ȵ�),Ҳ����ָ���������豸������,�������������������ϵͳ�����е���Ƶ�豸,ʹ��showsounddevices���

��

����:
muteappvolume iexplore.exe 0
muteappvolume wmplayer.exe 1 Speakers
muteappvolume /1275 2 1
muteappvolume Firefox.exe 1

showsounddevices

��Windows Vista/7/2008ϵͳ�У�����ʾ������Ƶ�豸����Ϣ���б�
�������֧��Windows Vista/7/2008ϵͳ��װ����Ƶ�豸��

wait [milliseconds]

�ȴ�ָ���ĺ�����.

����:
wait 1000
wait 500

shellrefresh

����Windows��Դ��������ȫ��ˢ�¡����������ע�������ص�����ļ����ͣ�������Ҫ������Ч��������ǳ���Ч�� (��������ı���gif�ļ�ͼ��) 

sysrefresh {Refresh Type}

����ȫ���ϵͳˢ�¡��ڸ�����ע����е�ϵͳ���ú����ʹ�ô�����ˢ��ϵͳ(����������ͼ���С�����������ȵ�...)��{Refresh Type}Ϊ��ѡ����������ָ������ֵ֮һ�� "environment" - ����ϵͳ������"policy" - ���²������ã� "intl" - ���±������á�

����:
sysrefresh
sysrefresh environment
sysrefresh policy

setcursor [X] [Y]

�������λ�á����� [X] �� [Y] ָ�����λ��


����:
setcursor 100 50

setcursorwin [X] [Y]

����������λ��,����ڵ�ǰ���ڵ����Ͻǡ����� [X] �� [Y] ָ������Ĺ��λ�á�


����:
setcursor 100 50

movecursor [X] [Y]

�ƶ���ꡣ���� [X] �� [Y] ָ���ƶ������ص���

��

����:
movecursor 10 10

dlg [Process Name] [Window Title] [Action] [Parameters]

������Windows��׼�Ի������Ϣ����н�������һ���Ի���ʱ������ʹ�ô�����"���"ȷ��/ȡ��/��/��ť�����߽��ı�������Ի���
���磬���������Ὣcalc.exe��������Windows��"����"�Ի���Ȼ����"ȷ��"��ť��12298��"����"�Ի������ı���Ŀؼ�ID�� ����ʹ��΢���Spy++����ʹ��my WinExplorer utility�����ҿؼ�ID��

dlg "explorer.exe" "run" settext 12298 "calc.exe"
dlg "explorer.exe" "run" click ok

��

������������κ���Դ��������ѯ�ʶԻ�����"��"��
dlg "explorer.exe" "" click yes

��

������������κν��̵�ѯ�ʶԻ�����"��"��
dlg "" "" click cancel

��

��������:

[Process Name]: ָ��Ҫ�����Ĵ����������Ľ��̡����Խ�ָ�����������߽��̵�����·��������˲���Ϊ�մ�("")����������κν�����ִ��.
[Window Title]: ָ��Ҫ�����Ĵ��ڵı��⡣����˲���Ϊ��("")������᲻�ܱ�������κδ�����ִ��.
[Action]: ����ָ������ѡ��֮һ:
click: ���ָ����ť������ָ������Ԥ��ֵ֮һ(�������ڱ�׼Windows�Ի���)�� yes, no, ok, cancel, retry, ignore, close, help.������ָ���κοؼ�ID��Ϊ������ֵ.
settext: ����ָ���ؼ����ı����˲����ĵ�һ������ָ���ؼ�ID���ڶ�������ָ���ı�.
dlgany [Process Name] [Window Title] [Action] [Parameters]

������dlg��������������������κδ��ڣ������Ǳ�׼Windows�Ի���.

returnval [Return Value]

����������ΪNirCmd����ָ������ֵ�����ⲿ�������NirCmd.exe�ǻ��õ�����ֵ��
���磬�����������У�����û�ѡ��"��"����NirCmd����ֵΪ0x30��

qboxcom "Do you want to continue ?" "question" returnval 0x30

sendkeypress [Keys Combination 1] [Keys Combination 2] [Keys Combination 3] ...

����һ������������ϡ�����ϵͳ����ȫ�����û�����Ϊ��İ���ָ���������ϼ���
 [Key Combination] ��ϼ�����ָ��һ�����������ͻ�һ����ϼ�(Shift/Ctrl/Alt/Windows��)���á�+�����(���磺Shift+A��Ctrl+K��Alt+I��Ctrl+Alt+I���ȵ�)��

��Down�·�ҳ��Up�Ϸ�ҳ��Left����Right�ҷ���Home��ҳ�ף�End��ҳβ��Insert��д����Deleteɾ������Plus�Ӻţ�Comma���ţ�Minus���ţ�Period��ţ�Down��ҳ��(��)��Up��ҳ��(��)��Left�����(��)��Right�����(��)��Home��ҳ�ף�End��ҳβ��Insert��д����Deleteɾ������Plus�Ӻţ�Comma���ţ�Minus���ţ�Period��ţ�Lwin��Rwin����(Windows��)��ϡ���

��appsӦ�ó��򡿣���pageup��ҳ��(��)������pagedown��ҳ��(��)������Tab Tab��������multiply�˺š�����add�Ӻš�����subtract���š�����seperator���š�����divide�ֺŽ�������backspace�˸񽡡�����pause��ͣ��������capslock��д��������numlockС���̿��ء�����scroll������������printscreen��ĻӲ��������

��

ʹ�����ϵ� [Key Combination] ��ϼ����һ���������

 ������һЩʹ�����ӣ�

��ʾ�������������:
sendkeypress ctrl+shift+esc
��ʾ����������Ĵ���,Ȼ���ƶ�����һ�����ڡ�alt+tab����ǩ:
sendkeypress ctrl+shift+esc alt+tab
��дСдģʽת��:
sendkeypress capslock
��ӡ��ǰ���ı��༭������(Shift�������������ȡ�Ĵ�д��ĸ):
sendkeypress Shift+n i r spc shift+s o f e r
���浱ǰ��Ļͼ�񵽼�����(��ͬ����Ctrl+PrintScreen):
sendkeypress Ctrl+printscreen
ִ��'Ctrl+Shift+K'��'Ctrl+Shift+A'��'Alt+Shift+P'����:
sendkeypress ctrl+shift+k ctrl+shift+a alt+shift+p
sendkey [Key] [press | down | up]

��ϵͳ���ͻ����������ϵͳ�ᰴ��ִ�У��ͺ����û���İ�ѹ�˼�����ָ����һ����
����[key]ָ�����������(�磺0x2e����delete��)��������Ϊ����Ԥ��ֵ֮һ��a - z �� 0 - 9(��Ӧ��ĸ���ּ�)��F1 - F24 (��ӦFxx��), shift, ctrl, alt, enter, esc��
�ڶ�������ָ����ָ�����Ĳ�����'press', 'down',���� 'up'�� ��ÿһ��down��������Ӧ�����up������
������Ľű������У�ϵͳ��ִ�оͺ����û�����Shift+Ctrl+Escһ�� (����ʾ���������):
 
sendkey shift down
sendkey ctrl down
sendkey esc down
sendkey shift up
sendkey ctrl up
sendkey esc up

��������:
sendkey a press
sendkey f10 press
sendkey enter press
sendkey 0x2e press

sendmouse [right | left | middle] [down | up | click | dblclick]

sendmouse [move] [x] [y]

sendmouse [wheel] [Wheel Value]

��ϵͳ����ָ��������¼�������ϵͳ��ִ�оͺ����û����������ָ������������
һЩsendmouse���������:
���͵������Ҽ��¼�(�Դ����Ӧ�ó�����ԣ����һ�������ı�Ŀ¼)��

��

���͵������Ҽ��¼�(�Դ����Ӧ�ó�����ԣ����һ�������ı�Ŀ¼)��
sendmouse right click
����һ��˫���������¼�:
sendmouse left dblclick
����������������������ƶ�20���ص㣬�����ƶ�30���ص㣬Ȼ���ɿ�������:
sendmouse left down
sendmouse move -30 20
sendmouse left up
����10����λ(��׼�������)����껬�֡�(�ڱ�׼��������ϣ�����ֵ��120�ı���).
sendmouse wheel 1200
convertimage [source filename] [destionation filename]

��ͼ���ļ�ת��Ϊ������ʽ��֧��һ�¸�ʽ��.bmp, .gif, .png, .jpg, .tiff
������Windows XP/2003/Vista (��ҪGDI+)

����:
convertimage "c:\temp\test1.gif" "c:\temp\test1.png"
convertimage "c:\temp\test1.jpg" "c:\temp\test1.gif"

convertimages [source wildcard] [extension]

�Ѷ��ͼ���ļ�ת��Ϊ������ʽ��֧�����¸�ʽ��.bmp, .gif, .png, .jpg, .tiff
������Windows XP/2003/Vista (��ҪGDI+)

����:
convertimages "c:\temp\a*.gif" .png
convertimages "c:\temp\*.jpg" .gif

savescreenshot [filename]

���浱ǰ��Ļ��ͼ��ָ����ͼ���ļ���֧�����¸�ʽ.bmp, .gif, .png, .jpg, .tiff
������Windows XP/2003/Vista (��ҪGDI+)

����:
savescreenshot "c:\temp\shot.png"

savescreenshotfull [filename]

����savescreenshot�����ھ��ж���������ļ�����ϣ�������ɼ����м���������Ļ��ͼ�� savescreenshotֻ�ɼ�������������Ļ��ͼ.

savescreenshotwin [filename]

���浱ǰ����ڽ�ͼ��ָ��ͼ���ļ�֧�����¸�ʽ .bmp, .gif, .png, .jpg, .tiff
������Windows XP/2003/Vista (��ҪGDI+)

����:
savescreenshotwin "c:\temp\win.png"

shellcopy [source file or wildcard] [destination] {Flags}

��һ���ļ��и���һ�������ļ��������ļ��У����Ҿ�����Դ�������¸����ļ�ʱһ����ʾ���̿�
���ڲ���{Flags}������ָ��һ����������ֵ��

yestoall: ������ѯ�ʻش�"��".
noerrorui: ���û����治��ʾ������Ϣ.
silent: ����ģʽ - ����ʾ���ƽ�����Ϣ.
nosecattr: �������ļ����������.
����:
shellcopy "c:\temp\*.*" "d:\temp"
shellcopy "c:\temp\*.*" "d:\temp" yestoall noerrorui

filldelete [source file or wildcard]

���ֽ����ָ���ļ���ͨ����ļ���Ȼ��ɾ���ļ�����Ҳ����ζ���ô�����ɾ�������ļ������ٱ��ָ�.

����:
filldelete "c:\temp\*.*"
filldelete "c:\temp\myfile.dat"

speak [type] [text/Filename] {rate} {volume}

ͨ��ʹ��Windows XP��Windows Vista�е�������(SAPI),�ʶ�ָ�����ı������ļ�������.
��[type]��������ָ���������ͣ� 

text: �򵥵��ı�.
xml: ����XML�����ı�.
file: �ı��ļ����ļ���.
{rate}��һ����ѡ��ָ�����ٵĲ�������ֵ��-10���ǳ���������10���ǳ��죩֮��.{volume}����ָ����������ֵ��0��100֮��.

����:
speak text ~$clipboard$
speak text "Please visit the Web site of NirSoft at http://www.nirsoft.net" 2 80
speak file "c:\temp\speak1.txt"

elevate [Program] {Command-Line Parameters}

����Windows Vista/7/2008ֻ���Թ���ԱȨ�����г��򡣵�[Program]����һ�������ո��ַ�,�����������������

��

����:
elevate notepad.exe
elevate notepad.exe C:\Windows\System32\Drivers\etc\HOSTS
elevate "c:\program files\my software\abc.exe"

elevatecmd [NirCmd command]

����Windows Vista/7/2008����:����һ������ԱȨ��NirCmd���

����:
elevatecmd regsetval binary "HKLM\Software\Test" "Value1" "6a cb ab dd 80 86 95"

runas [Domain\User] [Password] [Process and Command-Line Parameters]

���й�����ָ���� name/password �û���/���롣��һ������,���԰��������3�ָ�ʽ: user@domain�û���  User\Domain�û�\��

����:
runas admin1 Password1 "F:\Program Files\Mozilla Firefox\firefox.exe"
runas Domain01\user01 myp234Jk c:\temp\myprogram.exe
runas user01@domain.com Nm1923a "c:\temp\myprogram.exe" -a -k

trayballoon [Title] [Balloon Text] [Icon File] [Timeout]

��ʾһ�����̵�����(Windows XP�����ϰ汾)��ע��,��ʹ���������,NirCmd����������,һֱ��������رջ���ʧ��
[Title]�����������ǵ������ [Balloon Text] ���������ֲ�����ָ���ı���ʾ�ڵ������ڡ��� [Icon File]����,�����ָ��.ico�ļ�(����:c:\icons\myicon.ico)��exe�ļ���dllͼ���ļ���(����: shell32.dll,-154)
[Timeout]����ָ���˵ĺ��������ȴ����������ʧ��

����:
trayballoon "Hello" "This is a test..." "shell32.dll,22" 15000
trayballoon "Hello" "This is the text that will be appear inside the balloon !" "shell32.dll,-154" 10000
trayballoon "Hello" "This is the text that will be appear inside the balloon !" "c:\temp\icon1.ico" 10000

setconsolemode [mode]

���ÿ���̨��ʾģʽ������nircmdc.exe�й�
����[mode]����,����ָ��1Ϊȫ��ģʽ��2����̨����ģʽ��

setconsolecolor [forecolor] [backcolor]

����nircmdc.exe�ο�
���õ�ǰ��ǰ���ͱ�����ɫ�������ڿ���̨���ڡ���������ı������ı�����ɫ,�������ı��͵�stdout(����)consolewrite����������ʾָ������ɫ��
���� forecolor/backcolor ����,����ָ���κ�EGAɫ�Ž���0��15:

0 - ��ɫ
1 - ��ɫ
2 - ��ɫ
3 - ��ɫ
4 - ��ɫ
5 - Ʒ��
6 - ��ɫ
7 - ��ɫ
8 - ���ɫ
9 - ����ɫ
10 - ����ɫ
11 - ����ɫ
12 - �ʺ�ɫ
13 - �����
14 - ����ɫ
15 - ����ɫ 
����:
setconsolecolor 10 0
setconsolecolor 1 15

consolewrite [text]

��ָ���ı��������׼���(stdout). 

debugwrite [text]

д�ض��ı������������������Բ鿴���ı����͵���������Ч���� 

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