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

REM sc [服务器名称] getkeyname 服务显示名称 [缓冲区大小]
REM sc config 服务名称 start= auto（自动）
REM sc config 服务名称 start= demand（手动）
REM sc config 服务名称 start= disabled（禁用）
REM net stop 服务名称

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

set /p serve=显示名称:
sc getkeyname "%serve%" >nul || sc query "%serve%" && echo;sc config "%serve%" start=disabled
for /f "tokens=1,2 delims== " %%i in ('sc getkeyname "%serve%"^|find "名称"') do (
	echo;sc config "%%j" start=disabled
)
pause


exit




Human Interface Device Service另外这个服务关闭会让联想笔记本音量控制键失效，我已在下面列表中删除。

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

Remote Desktop Configuration（若无替代暂时别关闭）

Remote Desktop Services（若无替代暂时别关闭）

Remote Desktop Services UserMode Port Redirector（若无替代暂时别关闭）

Remote Registry（若无替代暂时别关闭）

Routing and Remote Access

Secondary Logon（若无替代暂时别关闭）

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

Windows Search（若无替代暂时别关闭）

Windows Update（若无替代暂时别关闭）

Windows 备份（若无替代暂时别关闭）

Windows 推送通知系统服务

WinHTTP Web Proxy Auto-Discovery Service

Workstation

Xbox Live 身份验证管理器

Xbox Live 游戏保存

XboxNetApiSvc


---------------------------

1、Application Experience（启动时为程序处理应用程序兼容性缓存请求）

2、Computer Browser（维护网络上计算机的更新列表，不需要联网的话可以改为手动）

3、Diagnostic Policy Service（诊断策略服务）（若无替代暂时别关闭）

4、Distributed Link Tracking Client（维护计算机内的NTFS文件之间的链接）

5、IP Helper（使用IPv6转换技术）

6、Offline Files（脱机文件服务）

7、Program Compatibility Assistant Service（为应用程序兼容性助手提供支持）

8、Portable Device Enumerator Service（强制可移动大容量存储设备的组策略）

9、Print Spooler（没有打印机的话可以关闭它）

来源：

list3：

Win10可禁用服务一览：（有些必须禁用）

Application Layer Gateway Service《Win10 Application Layer Gateway Service服务有什么用》



http://ASP.NET State Service《Win10 ASP.NET State Service服务是什么》



Connected User Experiences and Telemetry 关于是什么服务为什么可以禁用参考：《Win10 Connected User Experiences and Telemetry服务可以禁用吗》



Diagnostic Policy Service 《Diagnostic Policy Service服务是什么》 www.winwin7.com Win7系统之家（若无替代暂时别关闭）



Diagnostic Service Host 基本和Diagnostic Policy Service/Diagnostic Service Host是同类,可以一起禁用



Diagnostic System Host 同上



Distributed Link Tracking Client 参考《Distributed Link Tracking Client是什么服务》



Downloaded Maps Manager （供应用程序访问已下载地图的 Windows 服务。此服务由访问已下载地图的应用程序按需启动。禁用此服务将阻止应用访问地图。）



Function Discovery Provider Host （当电脑加入域后，共享文件需要的一个服务，非域则禁用）



HomeGroup Listener （家庭组相关服务，不使用家庭组就禁用）



HomeGroup Provider （家庭组相关服务，不使用家庭组就禁用） http://www.winwin7.com Win7系统之家





Internet Connection Sharing (ICS) （无线共享相关服务，如不需要无线共享，AP热点等可关闭否则不要关）



IP Helper （IP V6协议版本相关服务，目关来说应用不多，可以关闭）



IPsec Policy Agent （防火墙相关，是用来协商和配置IPSEC安全策略的，一般用户都用不上，可以禁止掉）



Link-Layer Topology Discovery Mapper （网络映射相关，不使用可禁用）



Microsoft App-V Client （App-V是微软应用程序虚拟化技术客户端，一般用不上，禁用）



Microsoft iSCSI Initiator Service （iscsi远程连接服务，禁用吧）



Microsoft Software Shadow Copy Provider （卷影服务,貌似和备份还原有点像，但是用不到）



Net.Tcp Port Sharing Service （TCP端口共享服务，一般用户用不上）



Offline Files （="http://www.winwin7.com/JC/Win7JC-2559.html">Offline Files是什么服务 脱机服务，一般用不上）



Performance Logs & Alerts （搜集计算机性能、日志、报警信息的服务项）



Portable Device Enumerator Service （Portable Device Enumerator Service服务有什么用）



Program Compatibility Assistant Service （Windows兼容性助理，处理程序兼容性（主要是老旧软件），不需要可关闭）



Quality Windows Audio Video Experience 《Quality Windows Audio Video Experience是什么服务》



Remote Desktop Configuration （远程桌面相关服务，不使用可关）



Remote Desktop Services （远程桌面相关服务，不使用可关）



Remote Desktop Services UserMode Port Redirector （远程桌面相关服务，不使用可关）



Remote Registry 《f="http://www.winwin7.com/JC/5990.html">Remote Registry是什么服务》这个是远程注册表服务，建议禁用。



Routing and Remote Access (软路由服务，可禁用)



Secondary Logon （二次登录服务，建议关闭）

http://www.winwin7.com Win7系统之家

Security Center （Windows安全中心服务，不需要的话就禁用吧，详细介绍（Win10 Security Center是什么服务可以禁用吗））

Server （局域网共享相关服务，不使用局域网可以禁用 ）

Shared PC Account Manager （共享PC帐户管理器，可以禁用）

Shell Hardware Detection （提供自动播放事件通知，禁用）

Smart Card （智能卡服务，禁用）

Smart Card Device Enumeration Service （同上，还是服务于智能卡，禁用）

Smart Card Removal Policy （智能卡相关服务）

SSDP Discovery （发现网络上的UPnP设备，网络发现相关服务，不使用局域网可禁用）

Superfetch （superfetch是什么服务 超级预读取服务 禁用无影响）

SynTPEnh Caller Service （同步电话呼叫服务 禁用）

TCP/IP NetBIOS Helper （局域网共享相关服务，不用可禁用）

Telephony （电话应用程序编程接口 (TAPI) 提供支持 ，拨号用户不要关，其它就禁用）

User Experience Virtualization Service （用户体验虚拟化服务，不需要禁用）

Windows Biometric Service （生物识别服务，不使用指纹、不使用人脸识别可以禁用）

Windows Search （Windows搜索服务，为文件建立索引加快搜索速度）

Windows Update （自动更新服务，不想自动更新的可以禁用）

Windows 备份 （备份相关服务，一般也不会去用）

Windows 推送通知系统服务 （建议关闭，会狂占内存、CPU）

WinHTTP Web Proxy Auto-Discovery Service （默认手动，可禁用）

Workstation (局域网共享相关，不需要可禁用)

Xbox Live 身份验证管理器 （禁用）

Xbox Live 游戏保存 （禁用）

XboxNetApiSvc （禁用）

----来源1---
Application Layer Gateway Service《Win10 Application Layer Gateway Service服务有什么用》


ASP.NET State Service《Win10 ASP.NET State Service服务是什么》


Connected User Experiences and Telemetry 关于是什么服务为什么可以禁用参考：《Win10 Connected User Experiences and Telemetry服务可以禁用吗》


Diagnostic Policy Service 《Diagnostic Policy Service服务是什么》 www.winwin7.com Win7系统之家


Diagnostic Service Host  基本和Diagnostic Policy Service/Diagnostic Service Host是同类,可以一起禁用


Diagnostic System Host  同上


Distributed Link Tracking Client  参考《Distributed Link Tracking Client是什么服务》


Downloaded Maps Manager （供应用程序访问已下载地图的 Windows 服务。此服务由访问已下载地图的应用程序按需启动。禁用此服务将阻止应用访问地图。）


Function Discovery Provider Host  （当电脑加入域后，共享文件需要的一个服务，非域则禁用）


HomeGroup Listener  （家庭组相关服务，不使用家庭组就禁用）


HomeGroup Provider  （家庭组相关服务，不使用家庭组就禁用） www.winwin7.com Win7系统之家


Human Interface Device Service  （简单的支持一些多媒体功能的键盘，蓝牙耳机上的控制按钮，没啥用）


Internet Connection Sharing (ICS)  （无线共享相关服务，如不需要无线共享，AP热点等可关闭否则不要关）


IP Helper  （IP V6协议版本相关服务，目关来说应用不多，可以关闭）


IPsec Policy Agent  （防火墙相关，是用来协商和配置IPSEC安全策略的，一般用户都用不上，可以禁止掉）


Link-Layer Topology Discovery Mapper  （网络映射相关，不使用可禁用）


Microsoft App-V Client  （App-V是微软应用程序虚拟化技术客户端，一般用不上，禁用）


Microsoft iSCSI Initiator Service （iscsi远程连接服务，禁用吧）


Microsoft Software Shadow Copy Provider （卷影服务,貌似和备份还原有点像，但是用不到）


Net.Tcp Port Sharing Service  （TCP端口共享服务，一般用户用不上）


Offline Files  （Offline Files是什么服务 脱机服务，一般用不上）


Performance Logs & Alerts   （搜集计算机性能、日志、报警信息的服务项）


Portable Device Enumerator Service  （Portable Device Enumerator Service服务有什么用）


Program Compatibility Assistant Service  （Windows兼容性助理，处理程序兼容性（主要是老旧软件），不需要可关闭）


Quality Windows Audio Video Experience   《Quality Windows Audio Video Experience是什么服务》


Remote Desktop Configuration  （远程桌面相关服务，不使用可关）


Remote Desktop Services  （远程桌面相关服务，不使用可关）


Remote Desktop Services UserMode Port Redirector  （远程桌面相关服务，不使用可关）


Remote Registry   《Remote Registry是什么服务》这个是远程注册表服务，建议禁用。


Routing and Remote Access  (软路由服务，可禁用)


Secondary Logon  （二次登录服务，建议关闭）

 www.winwin7.com Win7系统之家

Security Center   （Windows安全中心服务，不需要的话就禁用吧，详细介绍（Win10 Security Center是什么服务可以禁用吗））

Server  （局域网共享相关服务，不使用局域网可以禁用 ）

Shared PC Account Manager  （共享PC帐户管理器，可以禁用）

Shell Hardware Detection  （提供自动播放事件通知，禁用）

Smart Card   （智能卡服务，禁用）

Smart Card Device Enumeration Service   （同上，还是服务于智能卡，禁用）

Smart Card Removal Policy   （智能卡相关服务）

SSDP Discovery  （发现网络上的UPnP设备，网络发现相关服务，不使用局域网可禁用）

Superfetch   （superfetch是什么服务  超级预读取服务 禁用无影响）

SynTPEnh Caller Service   （同步电话呼叫服务 禁用）

TCP/IP NetBIOS Helper  （局域网共享相关服务，不用可禁用）

Telephony  （电话应用程序编程接口 (TAPI) 提供支持 ，拨号用户不要关，其它就禁用）

User Experience Virtualization Service  （用户体验虚拟化服务，不需要禁用）

Windows Biometric Service  （生物识别服务，不使用指纹、不使用人脸识别可以禁用）

Windows Search  （Windows搜索服务，为文件建立索引加快搜索速度）

Windows Update  （自动更新服务，不想自动更新的可以禁用）

Windows 备份  （备份相关服务，一般也不会去用）

Windows 推送通知系统服务  （建议关闭，会狂占内存、CPU）

WinHTTP Web Proxy Auto-Discovery Service  （默认手动，可禁用）

Workstation  (局域网共享相关，不需要可禁用)

Xbox Live 身份验证管理器  （禁用）

Xbox Live 游戏保存   （禁用）

XboxNetApiSvc  （禁用）

零售演示服务  （演示禁用）

自动时区更新程序  （时间同步，不需要可禁用）