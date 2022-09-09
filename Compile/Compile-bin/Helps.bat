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
echos 0x0e [0]��ʾ����
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
echo;	��һ��saw�Ƕ���see�Ĺ�ȥʱ���ڶ��͵��ĸ�saw���в����ڴ�\"a\"��ǰ
echo;	������\"����\",������saw�Ƕ���\"��\"��
echo;
cmdow @ /NOT
for /f %%i in ('CWnd find /!') do (
	CWnd enable %%i min
	CWnd enable %%i max
	CWnd enable %%i close
)
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