@echo off & title 
%2start /min mshta vbscript:createobject("shell.application").shellexecute("""%~0""","%1 ::",,"runas",1)(window.close)&exit
setlocal enabledelayedexpansion
path=%path%;E:\Compile\Compile-bin
modes 70 15
sc query "clicktorunsvc"
net stop "clicktorunsvc"
REM net start "clicktorunsvc"
taskkill -f -im OfficeClickToRun.exe
taskkill -f -im oCamTask.exe /t
taskkill -f -im msedge.exe /t
taskkill -f -im LISFService.exe /t
taskkill -f -im mmc.exe /t
taskkill -f -im spoolsv.exe /t

REM sc [����������] getkeyname ������ʾ���� [��������С]
REM sc config �������� start= auto���Զ���
REM sc config �������� start= demand���ֶ���
REM sc config �������� start= disabled�����ã�
REM net stop ��������

REM sc query |findstr "Connected"
REM sc config "DiagTrack" start=disabled

REM sc config "Diagnostic Policy Service" start= disabled
REM net stop "Diagnostic Execution Service"
REM net stop "Connected User Experiences and Telemetry"


REM sc getkeyname "Diagnostic Service Host"
REM sc config WdiServiceHost start=disabled

REM sc getkeyname "Diagnostic System Host"
REM sc query "WdiSystemHost"
REM C:\Program Files (x86)\Lenovo
REM sc delete lisfservice
REM pause
echo;--------
tasklist | findstr /i "spoolsv"
pause>nul
taskkill -f -im explorer.exe
taskkill -f -im const.exe /t &taskkill -f -im cmd.exe /t

set /p serve=��ʾ����:
sc getkeyname "%serve%" >nul || sc query "%serve%" && echo;sc config "%serve%" start=disabled
for /f "tokens=1,2 delims== " %%i in ('sc getkeyname "%serve%"^|find "����"') do (
	echo;sc config "%%j" start=disabled
)
pause


exit




Human Interface Device Service�����������رջ�������ʼǱ��������Ƽ�ʧЧ�������������б���ɾ����

********************************************************

Application Layer Gateway Service

http://ASP.NET State Service

BCL EasyConverter SDK 4 Loader

Connected User Experiences and Telemetry

Diagnostic Policy Service

Diagnostic Service Host

Diagnostic System Host

Distributed Link Tracking Client

Downloaded Maps Manager

Function Discovery Provider Host

HomeGroup Listener

HomeGroup Provider

Internet Connection Sharing (ICS)

IP Helper

IPsec Policy Agent

Link-Layer Topology Discovery Mapper

Microsoft App-V Client

Microsoft iSCSI Initiator Service

Microsoft Software Shadow Copy Provider

Net.Tcp Port Sharing Service

Offline Files

Performance Logs & Alerts

Portable Device Enumerator Service

Program Compatibility Assistant Service

Quality Windows Audio Video Experience

Remote Desktop Configuration�����������ʱ��رգ�

Remote Desktop Services�����������ʱ��رգ�

Remote Desktop Services UserMode Port Redirector�����������ʱ��رգ�

Remote Registry�����������ʱ��رգ�

Routing and Remote Access

Secondary Logon�����������ʱ��رգ�

Security Center

Server

Shared PC Account Manager

Shell Hardware Detection

Smart Card

Smart Card Device Enumeration Service

Smart Card Removal Policy

SSDP Discovery

Superfetch

SynTPEnh Caller Service

TCP/IP NetBIOS Helper

Telephony

User Experience Virtualization Service

Windows Biometric Service

Windows Search�����������ʱ��رգ�

Windows Update�����������ʱ��رգ�

Windows ���ݣ����������ʱ��رգ�

Windows ����֪ͨϵͳ����

WinHTTP Web Proxy Auto-Discovery Service

Workstation

Xbox Live �����֤������

Xbox Live ��Ϸ����

XboxNetApiSvc


---------------------------

1��Application Experience������ʱΪ������Ӧ�ó�������Ի�������

2��Computer Browser��ά�������ϼ�����ĸ����б�����Ҫ�����Ļ����Ը�Ϊ�ֶ���

3��Diagnostic Policy Service����ϲ��Է��񣩣����������ʱ��رգ�

4��Distributed Link Tracking Client��ά��������ڵ�NTFS�ļ�֮������ӣ�

5��IP Helper��ʹ��IPv6ת��������

6��Offline Files���ѻ��ļ�����

7��Program Compatibility Assistant Service��ΪӦ�ó�������������ṩ֧�֣�

8��Portable Device Enumerator Service��ǿ�ƿ��ƶ��������洢�豸������ԣ�

9��Print Spooler��û�д�ӡ���Ļ����Թر�����

��Դ��

list3��

Win10�ɽ��÷���һ��������Щ������ã�

Application Layer Gateway Service��Win10 Application Layer Gateway Service������ʲô�á�



http://ASP.NET State Service��Win10 ASP.NET State Service������ʲô��



Connected User Experiences and Telemetry ������ʲô����Ϊʲô���Խ��òο�����Win10 Connected User Experiences and Telemetry������Խ�����



Diagnostic Policy Service ��Diagnostic Policy Service������ʲô�� www.winwin7.com Win7ϵͳ֮�ң����������ʱ��رգ�



Diagnostic Service Host ������Diagnostic Policy Service/Diagnostic Service Host��ͬ��,����һ�����



Diagnostic System Host ͬ��



Distributed Link Tracking Client �ο���Distributed Link Tracking Client��ʲô����



Downloaded Maps Manager ����Ӧ�ó�����������ص�ͼ�� Windows ���񡣴˷����ɷ��������ص�ͼ��Ӧ�ó��������������ô˷�����ֹӦ�÷��ʵ�ͼ����



Function Discovery Provider Host �������Լ�����󣬹����ļ���Ҫ��һ�����񣬷�������ã�



HomeGroup Listener ����ͥ����ط��񣬲�ʹ�ü�ͥ��ͽ��ã�



HomeGroup Provider ����ͥ����ط��񣬲�ʹ�ü�ͥ��ͽ��ã� http://www.winwin7.com Win7ϵͳ֮��





Internet Connection Sharing (ICS) �����߹�����ط����粻��Ҫ���߹���AP�ȵ�ȿɹرշ���Ҫ�أ�



IP Helper ��IP V6Э��汾��ط���Ŀ����˵Ӧ�ò��࣬���Թرգ�



IPsec Policy Agent ������ǽ��أ�������Э�̺�����IPSEC��ȫ���Եģ�һ���û����ò��ϣ����Խ�ֹ����



Link-Layer Topology Discovery Mapper ������ӳ����أ���ʹ�ÿɽ��ã�



Microsoft App-V Client ��App-V��΢��Ӧ�ó������⻯�����ͻ��ˣ�һ���ò��ϣ����ã�



Microsoft iSCSI Initiator Service ��iscsiԶ�����ӷ��񣬽��ðɣ�



Microsoft Software Shadow Copy Provider ����Ӱ����,ò�ƺͱ��ݻ�ԭ�е��񣬵����ò�����



Net.Tcp Port Sharing Service ��TCP�˿ڹ������һ���û��ò��ϣ�



Offline Files ��="http://www.winwin7.com/JC/Win7JC-2559.html">Offline Files��ʲô���� �ѻ�����һ���ò��ϣ�



Performance Logs & Alerts ���Ѽ���������ܡ���־��������Ϣ�ķ����



Portable Device Enumerator Service ��Portable Device Enumerator Service������ʲô�ã�



Program Compatibility Assistant Service ��Windows���������������������ԣ���Ҫ���Ͼ������������Ҫ�ɹرգ�



Quality Windows Audio Video Experience ��Quality Windows Audio Video Experience��ʲô����



Remote Desktop Configuration ��Զ��������ط��񣬲�ʹ�ÿɹأ�



Remote Desktop Services ��Զ��������ط��񣬲�ʹ�ÿɹأ�



Remote Desktop Services UserMode Port Redirector ��Զ��������ط��񣬲�ʹ�ÿɹأ�



Remote Registry ��f="http://www.winwin7.com/JC/5990.html">Remote Registry��ʲô���������Զ��ע�����񣬽�����á�



Routing and Remote Access (��·�ɷ��񣬿ɽ���)



Secondary Logon �����ε�¼���񣬽���رգ�

http://www.winwin7.com Win7ϵͳ֮��

Security Center ��Windows��ȫ���ķ��񣬲���Ҫ�Ļ��ͽ��ðɣ���ϸ���ܣ�Win10 Security Center��ʲô������Խ����𣩣�

Server ��������������ط��񣬲�ʹ�þ��������Խ��� ��

Shared PC Account Manager ������PC�ʻ������������Խ��ã�

Shell Hardware Detection ���ṩ�Զ������¼�֪ͨ�����ã�

Smart Card �����ܿ����񣬽��ã�

Smart Card Device Enumeration Service ��ͬ�ϣ����Ƿ��������ܿ������ã�

Smart Card Removal Policy �����ܿ���ط���

SSDP Discovery �����������ϵ�UPnP�豸�����緢����ط��񣬲�ʹ�þ������ɽ��ã�

Superfetch ��superfetch��ʲô���� ����Ԥ��ȡ���� ������Ӱ�죩

SynTPEnh Caller Service ��ͬ���绰���з��� ���ã�

TCP/IP NetBIOS Helper ��������������ط��񣬲��ÿɽ��ã�

Telephony ���绰Ӧ�ó����̽ӿ� (TAPI) �ṩ֧�� �������û���Ҫ�أ������ͽ��ã�

User Experience Virtualization Service ���û��������⻯���񣬲���Ҫ���ã�

Windows Biometric Service ������ʶ����񣬲�ʹ��ָ�ơ���ʹ������ʶ����Խ��ã�

Windows Search ��Windows��������Ϊ�ļ����������ӿ������ٶȣ�

Windows Update ���Զ����·��񣬲����Զ����µĿ��Խ��ã�

Windows ���� ��������ط���һ��Ҳ����ȥ�ã�

Windows ����֪ͨϵͳ���� ������رգ����ռ�ڴ桢CPU��

WinHTTP Web Proxy Auto-Discovery Service ��Ĭ���ֶ����ɽ��ã�

Workstation (������������أ�����Ҫ�ɽ���)

Xbox Live �����֤������ �����ã�

Xbox Live ��Ϸ���� �����ã�

XboxNetApiSvc �����ã�

----��Դ1---
Application Layer Gateway Service��Win10 Application Layer Gateway Service������ʲô�á�


ASP.NET State Service��Win10 ASP.NET State Service������ʲô��


Connected User Experiences and Telemetry ������ʲô����Ϊʲô���Խ��òο�����Win10 Connected User Experiences and Telemetry������Խ�����


Diagnostic Policy Service ��Diagnostic Policy Service������ʲô�� www.winwin7.com Win7ϵͳ֮��


Diagnostic Service Host  ������Diagnostic Policy Service/Diagnostic Service Host��ͬ��,����һ�����


Diagnostic System Host  ͬ��


Distributed Link Tracking Client  �ο���Distributed Link Tracking Client��ʲô����


Downloaded Maps Manager ����Ӧ�ó�����������ص�ͼ�� Windows ���񡣴˷����ɷ��������ص�ͼ��Ӧ�ó��������������ô˷�����ֹӦ�÷��ʵ�ͼ����


Function Discovery Provider Host  �������Լ�����󣬹����ļ���Ҫ��һ�����񣬷�������ã�


HomeGroup Listener  ����ͥ����ط��񣬲�ʹ�ü�ͥ��ͽ��ã�


HomeGroup Provider  ����ͥ����ط��񣬲�ʹ�ü�ͥ��ͽ��ã� www.winwin7.com Win7ϵͳ֮��


Human Interface Device Service  ���򵥵�֧��һЩ��ý�幦�ܵļ��̣����������ϵĿ��ư�ť��ûɶ�ã�


Internet Connection Sharing (ICS)  �����߹�����ط����粻��Ҫ���߹���AP�ȵ�ȿɹرշ���Ҫ�أ�


IP Helper  ��IP V6Э��汾��ط���Ŀ����˵Ӧ�ò��࣬���Թرգ�


IPsec Policy Agent  ������ǽ��أ�������Э�̺�����IPSEC��ȫ���Եģ�һ���û����ò��ϣ����Խ�ֹ����


Link-Layer Topology Discovery Mapper  ������ӳ����أ���ʹ�ÿɽ��ã�


Microsoft App-V Client  ��App-V��΢��Ӧ�ó������⻯�����ͻ��ˣ�һ���ò��ϣ����ã�


Microsoft iSCSI Initiator Service ��iscsiԶ�����ӷ��񣬽��ðɣ�


Microsoft Software Shadow Copy Provider ����Ӱ����,ò�ƺͱ��ݻ�ԭ�е��񣬵����ò�����


Net.Tcp Port Sharing Service  ��TCP�˿ڹ������һ���û��ò��ϣ�


Offline Files  ��Offline Files��ʲô���� �ѻ�����һ���ò��ϣ�


Performance Logs & Alerts   ���Ѽ���������ܡ���־��������Ϣ�ķ����


Portable Device Enumerator Service  ��Portable Device Enumerator Service������ʲô�ã�


Program Compatibility Assistant Service  ��Windows���������������������ԣ���Ҫ���Ͼ������������Ҫ�ɹرգ�


Quality Windows Audio Video Experience   ��Quality Windows Audio Video Experience��ʲô����


Remote Desktop Configuration  ��Զ��������ط��񣬲�ʹ�ÿɹأ�


Remote Desktop Services  ��Զ��������ط��񣬲�ʹ�ÿɹأ�


Remote Desktop Services UserMode Port Redirector  ��Զ��������ط��񣬲�ʹ�ÿɹأ�


Remote Registry   ��Remote Registry��ʲô���������Զ��ע�����񣬽�����á�


Routing and Remote Access  (��·�ɷ��񣬿ɽ���)


Secondary Logon  �����ε�¼���񣬽���رգ�

 www.winwin7.com Win7ϵͳ֮��

Security Center   ��Windows��ȫ���ķ��񣬲���Ҫ�Ļ��ͽ��ðɣ���ϸ���ܣ�Win10 Security Center��ʲô������Խ����𣩣�

Server  ��������������ط��񣬲�ʹ�þ��������Խ��� ��

Shared PC Account Manager  ������PC�ʻ������������Խ��ã�

Shell Hardware Detection  ���ṩ�Զ������¼�֪ͨ�����ã�

Smart Card   �����ܿ����񣬽��ã�

Smart Card Device Enumeration Service   ��ͬ�ϣ����Ƿ��������ܿ������ã�

Smart Card Removal Policy   �����ܿ���ط���

SSDP Discovery  �����������ϵ�UPnP�豸�����緢����ط��񣬲�ʹ�þ������ɽ��ã�

Superfetch   ��superfetch��ʲô����  ����Ԥ��ȡ���� ������Ӱ�죩

SynTPEnh Caller Service   ��ͬ���绰���з��� ���ã�

TCP/IP NetBIOS Helper  ��������������ط��񣬲��ÿɽ��ã�

Telephony  ���绰Ӧ�ó����̽ӿ� (TAPI) �ṩ֧�� �������û���Ҫ�أ������ͽ��ã�

User Experience Virtualization Service  ���û��������⻯���񣬲���Ҫ���ã�

Windows Biometric Service  ������ʶ����񣬲�ʹ��ָ�ơ���ʹ������ʶ����Խ��ã�

Windows Search  ��Windows��������Ϊ�ļ����������ӿ������ٶȣ�

Windows Update  ���Զ����·��񣬲����Զ����µĿ��Խ��ã�

Windows ����  ��������ط���һ��Ҳ����ȥ�ã�

Windows ����֪ͨϵͳ����  ������رգ����ռ�ڴ桢CPU��

WinHTTP Web Proxy Auto-Discovery Service  ��Ĭ���ֶ����ɽ��ã�

Workstation  (������������أ�����Ҫ�ɽ���)

Xbox Live �����֤������  �����ã�

Xbox Live ��Ϸ����   �����ã�

XboxNetApiSvc  �����ã�

������ʾ����  ����ʾ���ã�

�Զ�ʱ�����³���  ��ʱ��ͬ��������Ҫ�ɽ��ã�