@echo off
Setlocal EnableDelayedExpansion
mode con cols=82 lines=25
color 0E
set Mini=0
set OnOff=0
set QQ=QQ:540044977
call :Inspect
title 获取硬件信息 - 正在获取相关信息，请稍等...
set echo=!Tit!
echo !Back!>!echo! & Findstr /a:f .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
set echo=!HLine!
echo !Back!>!echo! & Findstr /a:3 .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
DxDiag /t /Whql:off %Temp%\Dxdiag.dll
Ping /n 1 Sz.tencent.com>nul
if %errorlevel%==0 set NetWorking=已联网
if %errorlevel%==1 set NetWorking=未联网
:DxDiag
if exist "%Temp%\Dxdiag.dll" (for /f "tokens=2 delims=:" %%i in ('Findstr /IC:"Operating System:" %Temp%\Dxdiag.dll') do (for /f "delims=(" %%j in ("%%i") do set OS=%%j)) else (Goto :DxDiag)
Rem for /f "tokens=2 delims==" %%i in ('Wmic Os get Caption /value 2^>nul') do set OS=%%i
set OS=%OS:~1%
title 获取硬件信息 - %OS%
for /f "tokens=2 delims=:" %%i in ('Findstr /IC:"Processor:" %Temp%\Dxdiag.dll') do (for /f "delims=@" %%j in ("%%i") do (set Cpu=%%j))
Rem for /f "tokens=2 delims==" %%i in ('Wmic Cpu Get Name /value 2^>nul') do for /f "delims=@" %%j in ("%%i") do set Cpu=%%j
if "!Cpu:~0,1!"==" " set Cpu=!Cpu:~1!
if /i "!Cpu:~0,3!"=="AMD" (if /i "!Cpu:~-3!"=="GHz" (set Cpu=!Cpu:~0,-18!))
for /l %%i in (0 1 15) do set Cpu=!Cpu:  = !
for /l %%i in (0 1 25) do if "!Cpu:~-1!"==" " set Cpu=!Cpu:~0,-1!
if /i "!Cpu:~-3!"=="CPU" set Cpu=!Cpu:~0,-3!
for /l %%i in (0 1 10) do if "!Cpu:~-1!"==" " set Cpu=!Cpu:~0,-1!
if "!Cpu!"=="" set Cpu=!NoGet!
set NumberOfProcessors=-1
for /f "tokens=2 delims==" %%i in ('Wmic Path Win32_PerfFormattedData_PerfOS_Processor Get PercentIdleTime /value 2^>nul') do (
	set /a NumberOfProcessors+=1
	set CpuOccupy=%%i
)
if "%NumberOfProcessors%"=="-1" (
	for /f "delims== tokens=2" %%i in ('Wmic Cpu Get NumberOfLogicalProcessors /Value 2^>nul') do (
		set NumberOfProcessors=%%i
	)
	set CpuOccupy=.) else set /a CpuOccupy=100-%CpuOccupy%
call :Exit
if "%NumberOfProcessors%"=="-1" (set NumberOfProcessors=!NoGet!
	set echo=CPU  ....... !Cpu!) else set echo=CPU  ....... !Cpu!  (!NumberOfProcessors! 核心^)
echo !Back!>!echo! & Findstr /a:b .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic BaseBoard Get Manufacturer^,Product^,SerialNumber^,Version /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set Manufacturer=%%i
	if !Row! == 2 set Product=%%i
	if !Row! == 3 set BaseBoardSerialNumber=%%i
	if !Row! == 4 set Version=%%i
)
Call :Exit
if "!Manufacturer!"=="" set Manufacturer=!NoGet!
if "!Manufacturer!"==" " set Manufacturer=!NoGet!
if "!Product!"=="" set Product=!NoGet!
if "!Product!"==" " set Product=!NoGet!
if "!BaseBoardSerialNumber!"=="" set BaseBoardSerialNumber=!NoGet!
if "!BaseBoardSerialNumber!"==" " set BaseBoardSerialNumber=!NoGet!
if "!Version!"=="" set Version=!NoGet!
if "!Version!"==" " set Version=!NoGet!
if not "!Product!"=="" set Product=%Product:/=-%
if not "!Manufacturer!"=="" set Manufacturer=%Manufacturer:/=-%
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic Bios Get InstallableLanguages^,ReleaseDate^,SMBIOSBIOSVersion /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set InstallableLanguages=%%i
	if !Row! == 2 set ReleaseDate=%%i
	if !Row! == 3 set SMBIOSBIOSVersion=%%i
)
Call :Exit
if not defined 0 goto :end
if "!InstallableLanguages!"=="" (set InstallableLanguages=!NoGet!) else set InstallableLanguages=!InstallableLanguages! 国语言
if "!ReleaseDate!"=="" (set ReleaseDate=!NoGet!) else set ReleaseDate=!ReleaseDate:~0,4! 年 !ReleaseDate:~4,2! 月 !ReleaseDate:~6,2! 日
if "!SMBIOSBIOSVersion!"=="" set SMBIOSBIOSVersion=!NoGet!
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic Memphysical Get MaxCapacity^,MemoryDevices /Value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set MaxCapacity=%%i
	if !Row! == 2 set MemoryDevices=%%i
)
call :Times !Row! 1024 MaxCaqacity
if "!MaxCapacity!"=="" (set MaxCapacity=!NoGet!) else (set /a MaxCapacity=!MaxCapacity!/1048576
	set MaxCapacity=!MaxCapacity! GB
)
if "!MemoryDevices!"=="" (set MemoryDevices=!NoGet!) else set MemoryDevices=!MemoryDevices! 个
for /f "tokens=3 delims=:" %%i in ('Find /C /V "" %0') do set /a RT=%%i
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic Csproduct Get Uuid /Value 2^>nul') do set Uuid=%%i
if "!Uuid!"=="" (set Uuid=!NoGet!) else if "%Uuid:~0,8%"=="00000000" set Uuid=主板可能维修过
if /i "%Manufacturer:~0,2%"  ==  "HP"          set Manufacturer=惠普
if /i "%Manufacturer:~0,3%"  ==  "MSI"         set Manufacturer=微星
if /i "%Manufacturer:~0,4%"  ==  "ACER"        set Manufacturer=宏碁
if /i "%Manufacturer:~0,4%"  ==  "DELL"        set Manufacturer=戴尔
if /i "%Manufacturer:~0,4%"  ==  "ASUS"        set Manufacturer=华硕
if /i "%Manufacturer:~0,4%"  ==  "TIMI"        set Manufacturer=小米
if /i "%Manufacturer:~0,4%"  ==  "SOYO"        set Manufacturer=梅捷
if /i "%Manufacturer:~0,4%"  ==  "ONDA"        set Manufacturer=昂达
if /i "%Manufacturer:~0,5%"  ==  "HASEE"       set Manufacturer=神州
if /i "%Manufacturer:~0,5%"  ==  "HAIER"       set Manufacturer=海尔
if /i "%Manufacturer:~0,5%"  ==  "SUPOX"       set Manufacturer=磐正
if /i "%Manufacturer:~0,5%"  ==  "PCASL"       set Manufacturer=翔升
if /i "%Manufacturer:~0,5%"  ==  "APPLE"       set Manufacturer=苹果
if /i "%Manufacturer:~0,5%"  ==  "INTEL"       set Manufacturer=英特尔
if /i "%Manufacturer:~0,6%"  ==  "HUAWEI"      set Manufacturer=华为
if /i "%Manufacturer:~0,6%"  ==  "YESTON"      set Manufacturer=盈通
if /i "%Manufacturer:~0,6%"  ==  "LIYANG"      set Manufacturer=力阳
if /i "%Manufacturer:~0,6%"  ==  "MAXSUN"      set Manufacturer=铭瑄
if /i "%Manufacturer:~0,6%"  ==  "LENOVO"      set Manufacturer=联想
if /i "%Manufacturer:~0,6%"  ==  "ASROCK"      set Manufacturer=华擎
if /i "%Manufacturer:~0,6%"  ==  "HUANAN"      set Manufacturer=华南
if /i "%Manufacturer:~0,6%"  ==  "GALAXY"      set Manufacturer=影驰
if /i "%Manufacturer:~0,7%"  ==  "SAMSUNG"     set Manufacturer=三星
if /i "%Manufacturer:~0,7%"  ==  "HEWLETT"     set Manufacturer=惠普
if /i "%Manufacturer:~0,7%"  ==  "TOSHIBA"     set Manufacturer=东芝
if /i "%Manufacturer:~0,7%"  ==  "BIOSTAR"     set Manufacturer=映泰
if /i "%Manufacturer:~0,8%"  ==  "GIGABYTE"    set Manufacturer=技嘉
if /i "%Manufacturer:~0,8%"  ==  "COLORFUL"    set Manufacturer=七彩虹
if /i "%Manufacturer:~0,8%"  ==  "SAPPHIRE"    set Manufacturer=蓝宝石
if /i "%Manufacturer:~0,8%"  ==  "MECHREVO"    set Manufacturer=机械革命
if /i "%Manufacturer:~0,9%"  ==  "ALIENWARE"   set Manufacturer=外星人
if /i "%Manufacturer:~0,10%" ==  "SUPERMICRO"  set Manufacturer=超微
if !Product!==!NoGet! (set echo=主板 ....... !Manufacturer!) else set echo=主板 ....... !Manufacturer!   !Product!
echo !Back!>!echo! & Findstr /a:7 .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
set MemorySize=0
for %%i in (!RT!) do (for %%j in (4 6 0 2) do (set ij=%%j!ij!)
	if %%i neq !ij! Goto end
)
for /f "tokens=2 delims==" %%i in ('Wmic Path Win32_PhysicalMemory Get Capacity /value 2^>nul') do (
	set Capacity=%%i
	set /a MemoryQuantity+=1
	call :Addition !Capacity! !MemorySize! MemorySize
)
call :GetSize !MemorySize! MemorySize
if "!MemorySize:~-5,3!"==".00" set MemorySize=!MemorySize:~0,-5! !MemorySize:~-2!
if "!MemorySize!"=="EB" Goto :eof
if "!MemorySize!"=="0B" (set echo=内存 ....... !NoGet!) else set echo=内存 ....... !MemoryQuantity! 条   !MemorySize!
echo !Back!>!echo! & Findstr /a:b .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
for /f "tokens=2 delims==" %%i in ('Wmic DiskDrive Get Model /Value 2^>nul^|Find /i /v "USB"') do (
	set /a HdQuantity+=1
	if !HdQuantity! == 1 set FirstDisk=%%i
)
if not "!FirstDisk!"=="" set FirstDisk=%FirstDisk:/=-%
call :Minus 1024 !HdQuantity! HdQuautity
if "!FirstDisk!"=="" (set echo=硬盘 ....... !NoGet!) else set echo=硬盘 ....... !HdQuantity! 块   !FirstDisk!  (主)
echo !Back!>!echo! & Findstr /a:7 .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic Path Win32_VideoController Get Name^,AdapterRam^,CurrentBitsPerPixel^,CurrentRefreshRate^,CurrentHorizontalResolution^,CurrentVerticalResolution /Value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1  set AdapterRAM=%%i
	if !Row! == 2  set CurrentBitsPerPixel=%%i
	if !Row! == 3  set CurrentHorizontalResolution=%%i
	if !Row! == 4  set CurrentRefreshRate=%%i
	if !Row! == 5  set CurrentVerticalResolution=%%i
	if !Row! == 6  set VideoName=%%i
)
if "%CurrentBitsPerPixel%"=="" (
set Row=0
for /f "skip=10 tokens=2 delims==" %%i in ('Wmic Path Win32_VideoController Get Name^,AdapterRam^,CurrentBitsPerPixel^,CurrentRefreshRate^,CurrentHorizontalResolution^,CurrentVerticalResolution /Value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1  set AdapterRAM=%%i
	if !Row! == 2  set CurrentBitsPerPixel=%%i
	if !Row! == 3  set CurrentHorizontalResolution=%%i
	if !Row! == 4  set CurrentRefreshRate=%%i
	if !Row! == 5  set CurrentVerticalResolution=%%i
	if !Row! == 6  set VideoName=%%i
))
if "%VideoName%"=="" set VideoName=!NoGet!
if not "%VideoName%"=="" set VideoName=%VideoName:/=-%
if "%AdapterRAM:~0,1%" == "-" set AdapterRAM=%AdapterRAM:~1%
if "%AdapterRAM%"=="" set AdapterRAM=0
call :GetSize !AdapterRAM! AdapterRAM
if "!AdapterRam:~-5,3!"==".00" set AdapterRam=!AdapterRam:~0,-5! !AdapterRam:~-2!
if "!AdapterRAM!"=="0B" (set echo=显卡 ....... !VideoName!) else set echo=显卡 ....... !VideoName!  !AdapterRAM!
echo !Back!>!echo! & Findstr /a:b .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic DesktopMonitor Get PNPDeviceID^,PixelsPerXLogicalInch /Value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1  set PixelsPerXLogicalInch=%%i
	if !Row! == 2  set PNPDeviceID=%%i
)
for /f "delims=\ tokens=2" %%i in ("!PNPDeviceID!") do set DisplayName=%%i
if "!DisplayName!"=="" (
	set Row=0
for /f "skip=6 tokens=2 delims==" %%i in ('Wmic DesktopMonitor Get PNPDeviceID^,PixelsPerXLogicalInch /Value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1  set PixelsPerXLogicalInch=%%i
	if !Row! == 2  set PNPDeviceID=%%i
)
for /f "delims=\ tokens=2" %%j in ("!PNPDeviceID!") do set DisplayName=%%j
)
if not "!DisplayName!"=="" set DisplayName=%DisplayName:/=-%
if "%CurrentBitsPerPixel%"=="" (set Resolution=!NoGet!) else set Resolution=%CurrentHorizontalResolution% x %CurrentVerticalResolution% (%CurrentBitsPerPixel% bit) (%CurrentRefreshRate% Hz)
if "!DisplayName!"=="" (set echo=屏幕 ....... !Resolution!) else set echo=屏幕 ....... !DisplayName! !Resolution!
echo !Back!>!echo! & Findstr /a:7 .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
set Row=0
for /f "tokens=2 delims==" %%i in ('Wmic Path Win32_CDRomDrive Get Name^,MediaLoaded /Value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1  set MediaLoaded=%%i
	if !Row! == 2  set CD-ROM.Name=%%i
)
if not "%CD-ROM.Name%"=="" set CD-ROM.Name=%CD-ROM.Name:/=-%
if "%CD-ROM.Name%"=="" (set CD-ROM.Name=无) else (if /i "%MediaLoaded%"=="True" set MediaLoaded=(有盘^)
if /i "%MediaLoaded%"=="False" set MediaLoaded=(空^))
if "%CD-ROM.Name%"=="无" (set echo=光驱 ....... 无) else set echo=光驱 ....... %CD-ROM.Name%  %MediaLoaded%
echo !Back!>!echo! & Findstr /a:b .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
set Row=0
for /f "tokens=2 delims=:" %%i in ('Findstr /IC:"Description:" %Temp%\Dxdiag.dll') do (
	set /a Row+=1
	if !Row! == 1 set Description=%%i
)
if "!Description:~0,1!"==" " set Description=!Description:~1!
if not "!Description!"=="" set Description=%Description:/=-%
if "!Description!"=="" (set echo=声卡 ....... !NoGet!) else set echo=声卡 ....... %Description%  (输出)
echo !Back!>!echo! & Findstr /a:7 .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic Path Win32_NetworkAdapterConfiguration Where "IPEnabled='TRUE'" Get IPAddress^,IPSubnet^,MACAddress^,DefaultIPGateway^,Caption /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set NetName=%%i
	if !Row! == 2 set DefaultIPGateway=%%i
	if !Row! == 3 set IP=%%i
	if !Row! == 4 set IPSubnet=%%i
	if !Row! == 5 set MACAddress=%%i
)
if "%DefaultIPGateway%" == "" (
set Row=0
for /f "skip=9 tokens=2 delims==" %%i in ('Wmic Path Win32_NetworkAdapterConfiguration Where "IPEnabled='TRUE'" Get IPAddress^,IPSubnet^,MACAddress^,DefaultIPGateway^,Caption /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set NetName=%%i
	if !Row! == 2 set DefaultIPGateway=%%i
	if !Row! == 3 set IP=%%i
	if !Row! == 4 set IPSubnet=%%i
	if !Row! == 5 set MACAddress=%%i
))
if "%DefaultIPGateway%" == "" (
set Row=0
for /f "skip=16 tokens=2 delims==" %%i in ('Wmic Path Win32_NetworkAdapterConfiguration Where "IPEnabled='TRUE'" Get IPAddress^,IPSubnet^,MACAddress^,DefaultIPGateway^,Caption /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set NetName=%%i
	if !Row! == 2 set DefaultIPGateway=%%i
	if !Row! == 3 set IP=%%i
	if !Row! == 4 set IPSubnet=%%i
	if !Row! == 5 set MACAddress=%%i
))
if "%DefaultIPGateway%" == "" (
set Row=0
for /f "skip=23 tokens=2 delims==" %%i in ('Wmic Path Win32_NetworkAdapterConfiguration Where "IPEnabled='TRUE'" Get IPAddress^,IPSubnet^,MACAddress^,DefaultIPGateway^,Caption /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set NetName=%%i
	if !Row! == 2 set DefaultIPGateway=%%i
	if !Row! == 3 set IP=%%i
	if !Row! == 4 set IPSubnet=%%i
	if !Row! == 5 set MACAddress=%%i
))
if "%DefaultIPGateway%" == "" (
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic Path Win32_NetworkAdapterConfiguration Where "DHCPEnabled='TRUE'" Get IPAddress^,IPSubnet^,MACAddress^,DefaultIPGateway^,Caption /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set NetName=%%i
	if !Row! == 2 set DefaultIPGateway=%%i
	if !Row! == 3 set IP=%%i
	if !Row! == 4 set IPSubnet=%%i
	if !Row! == 5 set MACAddress=%%i
))
if "%DefaultIPGateway%" == "" (
set Row=0
for /f "skip=9 tokens=2 delims==" %%i in ('Wmic Path Win32_NetworkAdapterConfiguration Where "DHCPEnabled='TRUE'" Get IPAddress^,IPSubnet^,MACAddress^,DefaultIPGateway^,Caption /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set NetName=%%i
	if !Row! == 2 set DefaultIPGateway=%%i
	if !Row! == 3 set IP=%%i
	if !Row! == 4 set IPSubnet=%%i
	if !Row! == 5 set MACAddress=%%i
))
if "%DefaultIPGateway%" == "" (
set Row=0
for /f "skip=16 tokens=2 delims==" %%i in ('Wmic Path Win32_NetworkAdapterConfiguration Where "DHCPEnabled='TRUE'" Get IPAddress^,IPSubnet^,MACAddress^,DefaultIPGateway^,Caption /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set NetName=%%i
	if !Row! == 2 set DefaultIPGateway=%%i
	if !Row! == 3 set IP=%%i
	if !Row! == 4 set IPSubnet=%%i
	if !Row! == 5 set MACAddress=%%i
))
if "%DefaultIPGateway%" == "" (
set Row=0
for /f "skip=23 tokens=2 delims==" %%i in ('Wmic Path Win32_NetworkAdapterConfiguration Where "DHCPEnabled='TRUE'" Get IPAddress^,IPSubnet^,MACAddress^,DefaultIPGateway^,Caption /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set NetName=%%i
	if !Row! == 2 set DefaultIPGateway=%%i
	if !Row! == 3 set IP=%%i
	if !Row! == 4 set IPSubnet=%%i
	if !Row! == 5 set MACAddress=%%i
))
if "%DefaultIPGateway%" == "" (
	set IP=!NoNet!
	set IPSubnet=!NoNet!
	set DefaultIPGateway=!NoNet!
)
if "%MACAddress%" == "" set MACAddress=!NoGet!
for /f "tokens=2 delims=]" %%i in ("!NetName!") do set NetName=%%i
if "!NetName:~0,1!" == " " set NetName=!NetName:~1!
for /f "delims=," %%i in ("!IP!") do set IP=%%i
for /f "delims=," %%i in ("!IPSubnet!") do set IPSubnet=%%i
for /f "delims=," %%i in ("!DefaultIPGateway!") do set DefaultIPGateway=%%i
set IP=!IP:"=!
set IP=!IP:{=!
set IP=!IP:}=!
set IPSubnet=!IPSubnet:"=!
set IPSubnet=!IPSubnet:{=!
set IPSubnet=!IPSubnet:}=!
set DefaultIPGateway=!DefaultIPGateway:{=!
set DefaultIPGateway=!DefaultIPGateway:}=!
set DefaultIPGateway=!DefaultIPGateway:"=!
if defined NetName set NetName=%NetName:/=-%
if not defined NetName (set echo=网卡 ....... !NoGet!) else set echo=网卡 ....... %NetName%  (%NetWorking%)
echo !Back!>!echo! & Findstr /a:b .* "!echo!*" 2>nul & del /q "!echo!" 2>nul
echo.
echo.
if !Mini! Equ 1 (
	echo.正在生成详细信息文件，请耐心等候...
	Goto :Next)
set /p input=若要生成详细的电脑配置文件请直接回车：
if !input! == 1 Goto :Patch
if !input! == 2 Goto :USB
if !input! == 7 Goto :Monitor
if !input! == 8 (
	Title 获取硬件信息 - 正在生成调试文件，请稍等...
	Color 08
	set Debugging="%~DP0"调试文件.Txt
	Goto :Debugging
)
:Next
Title 获取硬件信息 - 正在生成详细信息，请稍等...
Color 08
set Time.1=%Time%
set File="%~DP0%ComputerName%.Txt"
for /f "tokens=3" %%i in ('Reg Query "HKCU\Software\Microsoft\Notepad" /v "lfFaceName" 2^>nul') do (
	if /i not "%%i" == "Fixedsys" (
		Reg add "HKCU\Software\Microsoft\Notepad" /v "lfFaceName" /d "Fixedsys" /f >nul 2>nul
))
for /f "tokens=3" %%i in ('Reg Query "HKLM\SOFTWARE\Microsoft\Notepad\DefaultFonts" /v "lfFaceName" 2^>nul') do (
	if /i not "%%i" == "Fixedsys" (
		Reg add "HKLM\SOFTWARE\Microsoft\Notepad\DefaultFonts" /v "lfFaceName" /d "Fixedsys" /f >nul 2>nul
))
echo.%Titl%>!File!
echo.%HLine% >>!File!
echo.>>!File!
echo.关于电脑综述信息如下：>>!File!
for /f "tokens=3" %%i in ('Reg Query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "DigitalProductId" 2^>nul') do (
	set DigitalProductId=%%i
)
if "!DigitalProductId!"=="" (
	set Key=!NoGet!
	goto :Skip)
set Row=-1
for /l %%i in (0,2,327) do (
	set /a Row+=1
	set Intercept=!DigitalProductId:~%%i,2!
	set /a DigitalProductId!Row!=0X!Intercept:~0,1!*16+0X!Intercept:~1,1!
)
if not defined 0 goto :end
set /a Win10=!DigitalProductId66!/6^&1
set /a DigitalProductId66=(!DigitalProductId66!^&0XF7)^|((!Win10!^&2)*4)
for /l %%i in (24 -1 0) do (
	set Current=0
	if not defined 1 Call :Call
	for /l %%j in (14 -1 0) do (
		set /a Current*=256
		set /a J=%%j+52	
		set /a Current=DigitalProductId!J!+!Current!
		set /a DigitalProductId!J!=!Current!/24
		set /a Current=!Current!%%24
	)
	for /l %%k in (0,1,24) do (
		if !Current!==%%k (
		set KeyTemp=!2:~%%k,1!!KeyTemp!
	)
)
set Last=!Current!
)
if !Win10! == 1 call :Win10
Set Key=!KeyTemp:~0,5!-!KeyTemp:~5,5!-!KeyTemp:~10,5!-!KeyTemp:~15,5!-!KeyTemp:~20,5!
:Skip
for /f "tokens=2 delims=:" %%j in ('Findstr /IC:"System Model:" %Temp%\Dxdiag.dll') do (
	set PCModel=%%j
	set PCModel=!PCModel:~1!
)
for /f "tokens=2 delims=={}" %%i in ('Wmic PATH Win32_SystemEnclosure Get ChassisTypes /value 2^>nul') do (
	for %%j in (8,9,10,14)  do if %%j == %%i (
		set Book=Ture
		set PCtype=笔记本
	)
	for %%j in (3,4,6,7,15,35) do if %%j == %%i set PCtype=台式机
	if %%i == 13 set PCtype=一体机
)
if "%PCtype%" ==    ""    set PCtype=未知
if /i "%PCModel%" == "System Product Name"    set PCModel=%Product%
if /i "%PCModel%" == "To be filled by O.E.M." set PCModel=%Product%
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic OS Get LastBootUpTime^,InstallDate /Value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set 7=%%i
	if !Row! == 2 set 8=%%i
)
if "!7!"=="" (set InstallDate=!NoGet!) else set InstallDate=!7:~0,4! 年 !7:~4,2! 月 !7:~6,2! 日 !7:~8,2! 时 !7:~10,2! 分 !7:~12,2! 秒
if "!8!"=="" (set LastBootUpTime=!NoGet!) else set LastBootUpTime=!8:~0,4! 年 !8:~4,2! 月 !8:~6,2! 日 !8:~8,2! 时 !8:~10,2! 分 !8:~12,2! 秒
for /f "tokens=2 delims==" %%i in ('Wmic Os Get Version /value 2^>nul') do set OSVersion=%%i
for /f "tokens=2 delims==" %%i in ('Wmic Os Get SerialNumber /value 2^>nul') do set OSSerialNumber=%%i
for /f "tokens=2 delims==" %%i in ('Wmic Bios Get SerialNumber /Value 2^>nul') do set PCSerialNumber=%%i
for /f "tokens=2 delims=:" %%i in ('Findstr /IC:"DirectX Version:" %Temp%\Dxdiag.dll') do set DirectX=%%i
if "!DirectX!"=="" (set DirectX=!NoGet!) else set DirectX=%DirectX:~1%
if "!OSVersion!"=="" set OSVersion=!NoGet!
if "!PCSerialNumber!"=="" set PCSerialNumber=!NoGet!
if "!OSSerialNumber!"=="" set OSSerialNumber=!NoGet!
set ProcessNum=-2
for /f "tokens=2 delims==" %%i in ('Wmic Process Get Caption /Value') do set /a ProcessNum+=1
echo.>>!File!
echo.    主机名 ................. : %ComputerName%>>!File!
echo.>>!File!
echo.    品牌 ................... : %Manufacturer%>>!File!
echo.>>!File!
echo.    型号 ................... : %PCModel%>>!File!
echo.>>!File!
echo.    类型 ................... : %PCtype%>>!File!
echo.>>!File!
echo.    电脑序列号 ............. : %PCSerialNumber%>>!File!
echo.>>!File!
echo.    当前用户 ............... : %UserName%>>!File!
echo.>>!File!
echo.    用户权限 ............... : %Jurisdiction%>>!File!
echo.>>!File!
echo.    系统版本 ............... : %OS%>>!File!
echo.>>!File!
echo.    系统版本号 ............. : %OSVersion%>>!File!
echo.>>!File!
echo.    系统序列号 ............. : %OSSerialNumber%>>!File!
echo.>>!File!
echo.    系统密匙 ............... : %Key%>>!File!
echo.>>!File!
echo.    当前进程 ............... : %ProcessNum% 个>>!File!
echo.>>!File!
echo.    DirectX 版本 ........... : %DirectX%>>!File!
echo.>>!File!
echo.    开机时间 ............... : %LastBootUpTime%>>!File!
echo.>>!File!
echo.    系统初始安装日期 ....... : %InstallDate%>>!File!
echo.>>!File!
echo.>>!File!
echo.关于 CPU 的详细信息如下：>>!File!
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic Cpu Get Name^,AddressWidth^,CurrentVoltage^,ExtClock^,Family^,MaxClockSpeed^,ProcessorId^,Revision^,SocketDesignation^,Stepping /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1  set AddressWidth=%%i
	if !Row! == 2  set CurrentVoltage=%%i
	if !Row! == 3  set ExtClock=%%i
	if !Row! == 4  set Family=%%i
	if !Row! == 5  set MaxClockSpeed=%%i
	if !Row! == 6  set CpuName=%%i
	if !Row! == 7  set ProcessorId=%%i
	if !Row! == 8  set Revision=%%i
	if !Row! == 9  set SocketDesignation=%%i
	if !Row! == 10 set Stepping=%%i
)
if "%ExtClock%"=="" (set ExtClock=!NoGet!) else set ExtClock=!ExtClock! Mhz
if "%MaxClockSpeed%"=="" (set MaxClockSpeed=!NoGet!) else (
	set MaxClockSpeee=!MaxClockSpeed!
	set MaxClockSpeed=!MaxClockSpeed! Mhz
)
if not "%CurrentVoltage%"=="" (
	if "%CurrentVoltage:~1,1%"=="" (
		set CurrentVoltage=0.!CurrentVoltage!
	) else (
		set CurrentVoltage=%CurrentVoltage:~0,1%.%CurrentVoltage:~1,1%
	)
) else (set CurrentVoltage=.)
set Row=0
for /f "Skip=1" %%i in ('Wmic Path Win32_CacheMemory Get MaxCacheSize 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set One=%%i
	if !Row! == 2 set Two=%%i
	if !Row! == 3 set Three=%%i
)
if "%Three%" == "" set Three=0
if "%One%" == "" set /a One=0,Two=0,Three=0
if "%Family%" == "" set Family=.
if "%Stepping%" == "" set Stepping=.
if "%Revision%" == "" set Revision=.
if "%AddressWidth%" == "" set AddressWidth=.
call :Space !Family! 8 Blank.5
call :Space !Stepping! 8 Blank.3
call :Space !CpuOccupy! 12 Blank.1
call :Space !AddressWidth! 12 Blank.4
call :Space !CurrentVoltage! 11 Blank.2
if "%ProcessorId%" == "" set ProcessorId=!NoGet!
if "%SocketDesignation%" == "" set SocketDesignation=!NoGet!
echo.>>!File!
echo.    名称 ........... : %Cpu%>>!File!
echo.>>!File!
echo.    核心 ........... : %NumberOfProcessors% 核心>>!File!
echo.>>!File!
echo.    主频 ........... : %MaxClockSpeed%>>!File!
echo.>>!File!
echo.    外频 ........... : %ExtClock%>>!File!
echo.>>!File!
if not !NumberOfProcessors! == !NoGet! (
	set /a Score=!NumberOfProcessors!*!MaxClockSpeee!
	echo.    性能评分 ....... : !Score! 分>>!File!
	echo.>>!File!
)
echo.    一级缓存 ....... : %One% Kb>>!File!
echo.>>!File!
echo.    二级缓存 ....... : %Two% Kb>>!File!
echo.>>!File!
echo.    三级缓存 ....... : %Three% Kb>>!File!
echo.>>!File!
echo.    插槽 ........... : %SocketDesignation%>>!File!
echo.>>!File!
echo.    编号 ........... : %ProcessorId%>>!File!
echo.>>!File!
echo.>>!File!
echo.    已用(％)    电压(V)    步进    位宽(位)    家族    修订版号>>!File!
echo.>>!File!
echo.    %CpuOccupy%%Blank.1%%CurrentVoltage%%Blank.2%%Stepping%%Blank.3%%AddressWidth%%Blank.4%%Family%%Blank.5%%Revision%>>!File!
echo.>>!File!
echo.>>!File!
echo.关于主板的详细信息如下：>>!File!
echo.>>!File!
echo.    品牌 ........... : %Manufacturer%>>!File!
echo.>>!File!
echo.    型号 ........... : %Product%>>!File!
echo.>>!File!
echo.    版本 ........... : %Version%>>!File!
echo.>>!File!
echo.    序列号 ......... : %BaseBoardSerialNumber%>>!File!
echo.>>!File!
echo.    内存插槽 ....... : %MemoryDevices%>>!File!
echo.>>!File!
echo.    内存支持 ....... : %MaxCapacity%>>!File!
echo.>>!File!
echo.    出厂日期 ....... : %ReleaseDate%>>!File!
echo.>>!File!
echo.    CPU 插槽 ....... : %SocketDesignation%>>!File!
echo.>>!File!
echo.    BIOS 版本 ...... : %SMBIOSBIOSVersion%>>!File!
echo.>>!File!
echo.    BIOS 语言 ...... : %InstallableLanguages%>>!File!
echo.>>!File!
echo.    唯一标识 ....... : %Uuid%>>!File!
echo.>>!File!
echo.>>!File!
echo.关于内存的详细信息如下：>>!File!
echo.>>!File!
echo.    数量 ........... : %MemoryQuantity% 条>>!File!
echo.>>!File!
echo.    总容量 ......... : %MemorySize%>>!File!
echo.>>!File!
echo.>>!File!
echo.    内存     容量         频率      插槽>>!File!
echo.>>!File!
set Row=0
for /f "skip=1 delims=" %%i in ('Wmic Path Win32_PhysicalMemory Get Capacity^,Speed^,Tag 2^>nul') do (
	set /a Row+=1 
	set i=%%i
	for /f "tokens=1,2,*" %%j in ("!i!") do (
		set MemorySize=%%j
		set Speed=%%k
		set Tag=%%l
	)
	if "!Speed!"=="Physical" (
		set Tag=!Speed! !Tag!
		set Speed=NoGet
	)
	call :GetSize !MemorySize! MSize
	call :Space !MSize! 13 Blank.1
	call :Space !Speed! 10 Blank.2
if not "!i:~1,1!"== "" echo.    !Row!        !MSize!!Blank.1!!Speed!!Blank.2!!Tag!>>!File!
)
echo.>>!File!
echo.>>!File!
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic Path Win32_PerfFormattedData_PerfOS_Memory Get AvailableBytes^,CommittedBytes^,CommitLimit /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1  set AvailableBytes=%%i
	if !Row! == 2  set CommitLimit=%%i
	if !Row! == 3  set CommittedBytes=%%i
)
if not "!AvailableBytes!" == "" (
	call :GetSize !AvailableBytes! Available
	call :GetSize !CommitLimit!    CommitLimit
	call :GetSize !CommittedBytes! Committed
)
if not "!Available!" == "" (
	echo.    已用内存 : %Committed%    可用内存 : %Available%    提交限制 : %CommitLimit%>>!File!
	echo.>>!File!
	echo.>>!File!
)
echo.关于硬盘的详细信息如下：>>!File!
echo.>>!File!
echo.    数量 ........... : %HdQuantity% 块>>!File!
echo.>>!File!
set HdSize=0
for /f "skip=1 delims=" %%i in ('Wmic DiskDrive Get Size 2^>nul') do (
	set Var.i=%%i
	call :Addition !Var.i! !HdSize! HdSize
)
call :GetSize !HdSize! HdSize
if "!HdSize:~-5,3!"==".00" set HdSize=!HdSize:~0,-5! !HdSize:~-2!
echo.    实际容量 .............. : !HdSize!>>!File!
if "%OSVersion:~0,2%" == "10" (
	set Row=0
	for /f "tokens=2 delims==" %%i in ('wmic diskdrive Where "InterfaceType='IDE'" get serialnumber /value 2^>nul') do (
		set /a Row+=1
		set SN.5=%%i
		set SN.5=!SN.5: =!
		echo.>>!File!
		call :Exit
		echo     序列号 !Row! .............. : !SN.5!>>!File!
	)
	) else (
	set Row=0
	set Surface=300 311 322 333 344 355 366 377 388 399 41A 42B 43C 44D 45E 46F 47G 48H 49I 4AJ 4BK 4CL 4DM 4EN 4FO 50P 51Q 52R 53S 54T 55U 56V 57W 58X 59Y 5AZ 20 
	for /f "tokens=2 delims==" %%i in ('Wmic Path Win32_PhysicalMedia get SerialNumber /value 2^>nul') do (
		set /a Row+=1
		set SN.0=%%i
		if not "!SN.0:~39,1!" == "" (
			if not defined 3 goto :eof
			for %%i in (!3!) do set SN.1=!SN.1!!SN.0:~%%i,2!
			for /l %%l in (0 2 38) do (
				set SN.2=!SN.1:~%%l,2!
				for %%j in (!Surface!) do (
					set Sur=%%j
					if "!SN.2!" == "!Sur:~0,2!" set SN.3=!Sur:~2,1!
				)
				set SN.4=!SN.4!!SN.3!
			)
			echo.>>!File!
			echo     序列号 !Row! .............. : !SN.4!>>!File!
			set SN.4=
		) else (
			if not "!SN.0:~1,1!" == "" (
				set SN.0=!SN.0: =!
				echo.>>!File!
				echo     序列号 !Row! .............. : !SN.0!>>!File!
			)
		)
	)
)
echo.>>!File!
for /f "tokens=2 delims==" %%i in ('Wmic /NameSpace:\\Root\Wmi Path MSStorageDriver_ATAPISmartData Get VendorSpecific /Value 2^>nul') do (
	set /a DiskNuber+=1
	set Smart=%%i
	set Smart=!Smart:,= !
	for /l %%j in (3 12 362) do (
		set Nu.0=!1:~16,1!!1:~19,1!
		if not defined !Nu.0! (set Nu.1=1) else set Nu.1=0
		if not defined 1 Call :Call
		for %%k in (!Smart!) do (
			set /a Nu.1+=1
			if !Nu.1! == %%j (
				if %%k == 9 (set /a Nu.2=!Nu.1!+7
					      call :Calc !Nu.1! !Nu.2! PowerOnTimeCount)
				if %%k == 12 (set /a Nu.2=!Nu.1!+7
					       call :Calc !Nu.1! !Nu.2! StartStopCount)
				set /a Nu.3=0,Nu.4=0
				if %%k == 190 (set /a Nu.3=!Nu.1!+5
					for %%l in (!Smart!) do (
						set /a Nu.4+=1
						if !Nu.4! == !Nu.3! set Temperature=%%l
						)	
				) else (
					if %%k == 194 (set /a Nu.3=!Nu.1!+5
						for %%l in (!Smart!) do (
							set /a Nu.4+=1
							if !Nu.4! == !Nu.3! set Temperature=%%l
						)
					)
				)
			)
		)
	)		
set /a Day=!PowerOnTimeCount!/24 2>nul
echo.>>!File!
echo     硬盘 !DiskNuber!: >>!File!
echo.>>!File!
echo     当前硬盘温度 ..................... : !Temperature! ℃>>!File!
echo.>>!File!
echo     截至目前硬盘已启停 ..................... : !StartStopCount! 次>>!File!
echo.>>!File!
echo     截至目前硬盘已累计运行 ....................... : !PowerOnTimeCount! 小时（!Day!天）>>!File!
echo.>>!File!
)
echo.>>!File!
echo.    硬盘    分区     模式        容量        状态        型号>>!File!
echo.>>!File!
set Row=0
for /f "skip=1 delims=" %%i in ('Wmic DiskDrive Get Partitions^,InterFacetype^,Size 2^>nul^|Find /i /v "USB"') do (
	set /a Row+=1
	set i=%%i
	for /f "tokens=1,2,3" %%j in ("!i!") do (
		set InterfaceType=%%j
		set Partitions=%%k
		set DiskSize=%%l
	)
	set Rox=0
	for /f "skip=1 delims=" %%m in ('Wmic DiskDrive Get Caption 2^>nul^|Find /i /v "USB"') do (
		set /a Rox+=1
		if !Rox! == !Row! (set DiskCaption=%%m
		call :Exit)
	)
	if !Row! == 1 (set Disklevel=主盘) else (set Disklevel=从盘)
	call :GetSize !DiskSize! NominalSize
	if "!NominalSize:~0,3!" == "74." set NominalSize=80GB
	if "!NominalSize:~0,3!" == "111" set NominalSize=120GB
	if "!NominalSize:~0,3!" == "119" set NominalSize=128GB
	if "!NominalSize:~0,3!" == "149" set NominalSize=160GB
	if "!NominalSize:~0,3!" == "223" set NominalSize=240GB
	if "!NominalSize:~0,3!" == "232" set NominalSize=250GB
	if "!NominalSize:~0,3!" == "238" set NominalSize=256GB
	if "!NominalSize:~0,3!" == "298" set NominalSize=320GB
	if "!NominalSize:~0,3!" == "335" set NominalSize=360GB
	if "!NominalSize:~0,3!" == "447" set NominalSize=480GB
	if "!NominalSize:~0,3!" == "465" set NominalSize=500GB
	if "!NominalSize:~0,3!" == "476" set NominalSize=512GB
	if "!NominalSize:~0,3!" == "698" set NominalSize=750GB
	if "!NominalSize:~0,3!" == "931" set NominalSize=1TB
	if "!NominalSize:~0,3!" == "1.8" set NominalSize=2TB
	if "!NominalSize:~0,3!" == "2.7" set NominalSize=3TB
	if "!NominalSize:~0,3!" == "3.6" set NominalSize=4TB
	if "!NominalSize:~0,3!" == "4.5" set NominalSize=5TB
	if "!NominalSize:~0,3!" == "5.4" set NominalSize=6TB
	if "!NominalSize:~0,3!" == "7.2" set NominalSize=8TB
	if "!NominalSize:~0,3!" == "9.0" set NominalSize=10TB
	call :Space !Row!           8  Blank.1
	call :Space !Partitions!    9  Blank.2
	call :Space !InterfaceType! 12 Blank.3
	call :Space !NominalSize!   12 Blank.4
if not "!i:~1,1!"=="" echo.    !Row!!Blank.1!!Partitions!!Blank.2!!InterfaceType!!Blank.3!!NominalSize!!Blank.4!!Disklevel!        !DiskCaption!>>!File!
)
echo.>>!File!
echo.>>!File!
echo.    盘符    格式     容量        已用        剩余        卷标>>!File!
echo.>>!File!
for /f "skip=1 delims=" %%i in ('Wmic LogicalDisk Where Mediatype^='12' Get DeviceID^,FileSystem^,Size^,FreeSpace^,VolumeName 2^>nul') do (
	set i=%%i
	for /f "tokens=1,2,3,4,*" %%j in ("!i!") do (
		set DeviceID=%%j
		set FileSystem=%%k
		set FreeSpace=%%l
		set PartitionSize=%%m
		set VolumeName=%%n
		if "!VolumeName!"=="" set VolumeName=默认值
	)
	if "!FileSystem!"=="" (
		set FileSystem=RAW
		set Total=0.00GB
		set Used=0.00GB
		set Free=0.00GB
	) Else (
		call :Minus !PartitionSize! !FreeSpace! PartitionUsed
		call :GetSize !FreeSpace! Free
		call :GetSize !PartitionSize! Total
		call :GetSize !PartitionUsed! Used
		if "!Free:~-5,3!"==".00" set Free=!Free:~0,-5!!Free:~-2!
		if "!Total:~-5,3!"==".00" set Total=!Total:~0,-5!!Total:~-2!
		if "!Used:~-5,3!"==".00" set Used=!Used:~0,-5!!Used:~-2!
		)
	call :Space !FileSystem! 9  Blank.1
	call :Space !Total!      12 Blank.2
	call :Space !Used!       12 Blank.3
	call :Space !Free!       12 Blank.4
if not "!i:~3,1!"=="" echo.    !DeviceID!      !FileSystem!!Blank.1!!Total!!Blank.2!!Used!!Blank.3!!Free!!Blank.4!!VolumeName!>>!File!
)
for /f "tokens=2 delims==" %%i in ('Wmic path Win32_LogicalDiskToPartition get StartingAddress^,Dependent 2^>nul') do (
	for /f "tokens=1,2" %%j in ("%%i") do (
		set Pf=%%j
		set StartingAddress=%%k
		set Pf=!Pf:~1,2!
		call :Division !StartingAddress! 4096 4K
		if "!4k:~-3!"==".00" (set 4k=已对齐) else (set 4k=未对齐)
		set Pf4k=!Pf4k!  !Pf!!4K!
	)
)
echo.>>!File!
echo.    所有分区 4K 对齐情况（包含可移动设备）：>>!File!
echo.>>!File!
echo.  !Pf4k!>>!File!
echo.>>!File!
echo.>>!File!
echo.关于显卡的详细信息如下：>>!File!
echo.>>!File!
set /a Row=0
for /f "tokens=2 delims==" %%i in ('Wmic Path Win32_VideoController Get Name^,AdapterRam^,DriverDate^,DriverVersion^,VideoProcessor^,VideoProcessor /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1  set AdapterRAM.1=%%i
	if !Row! == 2  set DriverDate.1=%%i
	if !Row! == 3  set DriverVersion.1=%%i
	if !Row! == 4  set VideoName.1=%%i
	if !Row! == 5  set VideoProcessor.1=%%i
	if !Row! == 6  set AdapterRAM.2=%%i
	if !Row! == 7  set DriverDate.2=%%i
	if !Row! == 8  set DriverVersion.2=%%i
	if !Row! == 9  set VideoName.2=%%i
	if !Row! == 10 set VideoProcessor.2=%%i
)
if "!AdapterRAM.1:~0,1!" == "-" set AdapterRAM.1=!AdapterRAM.1:~1!
if "!AdapterRAM.2:~0,1!" == "-" set AdapterRAM.2=!AdapterRAM.2:~1!
if "!AdapterRAM.1!" == "" set AdapterRAM.1=0
if "!AdapterRAM.2!" == "" set AdapterRAM.2=0
call :GetSize !AdapterRAM.1! AdapterRAM.1
call :GetSize !AdapterRAM.2! AdapterRAM.2
if "!AdapterRam.1:~-5,3!"==".00" set AdapterRam.1=!AdapterRam.1:~0,-5! !AdapterRam.1:~-2!
if "!AdapterRam.2:~-5,3!"==".00" set AdapterRam.2=!AdapterRam.2:~0,-5! !AdapterRam.2:~-2!
set DriverDate.1=!DriverDate.1:~0,4! 年 !DriverDate.1:~4,2! 月 !DriverDate.1:~6,2! 日
set DriverDate.2=!DriverDate.2:~0,4! 年 !DriverDate.2:~4,2! 月 !DriverDate.2:~6,2! 日
if "!VideoProcessor.1!"=="" set VideoProcessor.1=!NoGet!
if "!VideoProcessor.2!"=="" set VideoProcessor.2=!NoGet!
if not "%VideoName.1%"=="" (
	call :Exit
	echo.    显卡 1:>>!File!
	echo.>>!File!
	echo.    名称 ........... : !VideoName.1!>>!File!
	echo.>>!File!
	echo.    显存 ........... : !AdapterRAM.1!>>!File!
	echo.>>!File!
	echo.    驱动版本 ....... : !DriverVersion.1!>>!File!
	echo.>>!File!
	echo.    驱动日期 ....... : !DriverDate.1!>>!File!
	echo.>>!File!
	echo.    内核名称 ....... : !VideoProcessor.1!>>!File!
)
if not "%VideoName.2%"=="" (
if not "%VideoName.2:~0,4%"=="Oray" (
	call :Exit
	echo.>>!File!
	echo.    显卡 2:>>!File!
	echo.>>!File!
	echo.    名称 ........... : !VideoName.2!>>!File!
	echo.>>!File!
	echo.    显存 ........... : !AdapterRAM.2!>>!File!
	echo.>>!File!
	echo.    驱动版本 ....... : !DriverVersion.2!>>!File!
	echo.>>!File!
	echo.    驱动日期 ....... : !DriverDate.2!>>!File!
	echo.>>!File!
	echo.    内核名称 ....... : !VideoProcessor.2!>>!File!
))
echo.>>!File!
echo.>>!File!
echo.关于显示器的详细信息如下：>>!File!
echo.>>!File!
for /f "tokens=3" %%i in ('Reg Query "HKLM\System\CurrentControlSet\Enum\Display\!5!\!6!\Device Parameters" /v "Edid" 2^>nul') do (
	set Edid=%%i
)
if "%Edid%" == "" (for /f "tokens=3" %%i in ('Reg Query "HKLM\System\CurrentControlSet\Enum\Display\!5!" /s 2^>nul ^|findstr /i "Edid"') do (set Edid=%%i))
if "%DisplayName%" == "" set DisplayName=!NoGet!
echo.    型号 ........... : %DisplayName%>>!File!
echo.>>!File!
if not "%Edid%" == "" (
	set Yeardata=!Edid:~34,2!
	set Weekdata=!Edid:~32,2!
	set Longdata=!Edid:~42,2!
	set Widedata=!Edid:~44,2!
	set /a Weekdata=0X!Weekdata!*1
	set /a Longdata=0X!Longdata!*1
	set /a Widedata=0X!Widedata!*1
	set /a Yeardata=0X!Yeardata!*1+1990
	call :Division !Longdata! 2.54 Longdata.in
	call :Division !Widedata! 2.54 Widedata.in
	call :Times !Longdata.in! !Longdata.in! Longdata.in
	call :Times !Widedata.in! !Widedata.in! Widedata.in
	call :Addition !Longdata.in! !Widedata.in! Diagonal
	set "Code=CreateObject("Scripting.FileSystemObject").GetStandardStream(1).Write(sqr(!Diagonal!))(close)"
	for /f "delims=" %%i in ('Mshta "Vbscript:!Code!"') do set Screen.In=%%i
	for /f "tokens=1,2 delims=." %%i in ("!Screen.In!") do (
		set Screen.In=%%i
		set Screen.Io=%%j
	)
	set Screen.Io=!Screen.Io:~0,1!
	if !Screen.Io! geq 7 set /a Screen.In=!Screen.In!+1
	echo.    屏幕尺寸 ....... : !Screen.In! 英寸>>!File!
	echo.>>!File!
	echo.    生产日期 ....... : !Yeardata! 年 第 !Weekdata! 周>>!File!
	echo.>>!File!
	echo.    屏幕大小 ....... : !Longdata! 厘米 × !Widedata! 厘米>>!File!
	echo.>>!File!
)
if not defined PixelsPerXLogicalInch (set PixelsPerXLogicalInch=!NoGet!) else set PixelsPerXLogicalInch=!PixelsPerXLogicalInch! Dpi
echo.    像素密度 ....... : %PixelsPerXLogicalInch%>>!File!
echo.>>!File!
echo.    当前模式 ....... : %Resolution%>>!File!
if not "%CD-ROM.Name%" == "无" (
	echo.>>!File!
	echo.>>!File!
	echo.关于光驱的详细信息如下：>>!File!
	echo.>>!File!
	echo.  列出所有光驱: >>!File!
	echo.>>!File!
	echo.    盘符   类型       型号 >>!File!
	echo.>>!File!
	for /f  "skip=1 delims=" %%i in ('Wmic CdRom Get Name^,Drive^,Mediatype 2^>nul') do (
		set CdRom.0=%%i
		call :Exit
		if "!CdRom.0!" neq "" echo.    !CdRom.0!>>!File!
	)
)
echo.>>!File!
echo.>>!File!
echo.关于声卡的详细信息如下：>>!File!
echo.>>!File!
echo.  列出所有声卡: >>!File!
echo.>>!File!
set Row=0
for /f "tokens=2 delims==" %%i in ('Wmic Sounddev Get ProductName /Value 2^>nul') do (
	set /a Row+=1
	set ProductName=%%i
	call :Exit
	echo.    !Row!.  !ProductName!>>!File!
	echo.>>!File!
)
echo.  当前声卡信息: >>!File!
echo.>>!File!
set Row=0
for /f "tokens=2 delims=:" %%i in ('Findstr /IC:"Driver Version: " %Temp%\Dxdiag.dll') do (
	set /a Row+=1
	if !Row! == 2 set SoundDriverVersion=%%i
)
if "!SoundDriverVersion:~0,1!"==" " set SoundDriverVersion=!SoundDriverVersion:~1!
for /f "tokens=1,* delims=:" %%i in ('Findstr /IC:"Date and Size: " %Temp%\Dxdiag.dll') do (
	for /f "tokens=1,2 delims=," %%k in ("%%j") do (
		set SoundDate=%%k
		set SoundSize=%%l
	))
for /f %%i in ("!SoundSize!") do call :GetSize %%i SoundSize
for /f %%i in ("!SoundDate!") do set SoundDate=%%i
for /f "tokens=1,2,3 delims=/" %%i in ("!SoundDate!") do (
	if %%i lss %%k set SoundDate=%%k 年 %%i 月 %%j 日
	if %%i gtr %%k set SoundDate=%%i 年 %%j 月 %%k 日
)
echo.    输出声卡 ....... : !Description!>>!File!
echo.>>!File!
echo.    驱动版本 ....... : !SoundDriverVersion!>>!File!
echo.>>!File!
if not "!SoundSize!" == "0B" (
	echo.    驱动日期 ....... : !SoundDate!>>!File!
	echo.>>!File!
	echo.    驱动大小 ....... : !SoundSize!>>!File!
	echo.>>!File!
)
echo.>>!File!
echo.关于网卡的详细信息如下：>>!File!
echo.>>!File!
echo.  列出所有物理网卡: >>!File!
echo.>>!File!
set Row=0
set Roy=0
for /f "delims=" %%i in ('Wmic Path Win32_NetworkAdapter get PNPDeviceID 2^>nul') do (
	set /a Row+=1
	set I=%%i
	if /i "!I:~0,3!" == "PCI" (
		set Rox=0
		set /a Roy+=1
		for /f "delims=" %%j in ('Wmic Path Win32_NetworkAdapter get Description 2^>nul') do (
			if "!0:~0,1!"=="" Call Call
			set /a Rox+=1
			if !Rox! == !Row! (
				set PhysicsNet=%%j
				call :Exit
				echo.    !Roy!. !PhysicsNet!>>!File!
			)
		)
		set Roz=0
		for /f "delims=" %%j in ('Wmic Path Win32_NetworkAdapterConfiguration get MACAddress 2^>nul') do (
			if "!0:~0,1!"=="" Call Call
			set /a Roz+=1
			if !Roz! == !Row! (
				set Mac=%%j
				call :Exit
				if "!MAC:~1,1!" == " " set MAC=暂缺或已禁用
				echo.      │>>!File!
				echo.      └ MAC: !Mac!>>!File!
				echo.>>!File!
			)
		)
	)
	if /i "!I:~0,3!" == "USB" (
		set Rox=0
		set /a Roy+=1
		for /f "delims=" %%j in ('Wmic Path Win32_NetworkAdapter get Description 2^>nul') do (
			if "!0:~0,1!"=="" Call Call
			set /a Rox+=1
			if !Rox! == !Row! (
				set PhysicsNet=%%j
				call :Exit
				echo.    !Roy!. !PhysicsNet!>>!File!
			)
		)
		set Roz=0
		for /f "delims=" %%j in ('Wmic Path Win32_NetworkAdapterConfiguration get MACAddress 2^>nul') do (
			if "!0:~0,1!"=="" Call Call
			set /a Roz+=1
			if !Roz! == !Row! (
				set Mac=%%j
				call :Exit
				if "!MAC:~1,1!" == " " set MAC=暂缺或已禁用
				echo.      │>>!File!
				echo.      └ MAC: !Mac!>>!File!
				echo.>>!File!
			)
		)
	)
)
echo.  当前网卡信息: >>!File!
echo.>>!File!
echo.    网卡名称 ....... : %NetName%>>!File!
echo.>>!File!
echo.    内网IP ......... : %IP%>>!File!
>"%Temp%\IIP.VBS" (
	echo.set oDOM = WScript.GetObject("http://www.bathome.net/s/ip.php"^)
	echo.do until oDOM.readyState = "complete"
	echo.WScript.sleep 200
	echo.Loop
	echo.S=oDOM.documentElement.innerText
	echo.set Re = New RegExp
	echo.Re.Pattern="(\d+)\.(\d+)\.(\d+)\.(\d+)"
	echo.For Each m in Re.Execute(S^)
	echo.WScript.echo M 
	echo.Next
)
cscript //NoLogo /e:vbscript "%Temp%\IIP.VBS" >"%Temp%\IIP.dll" 2>nul
del "%Temp%\IIP.VBS" >nul 2>nul
for /f "usebackq" %%i in ("%Temp%\IIP.dll") do set InternetIP=%%i
del "%Temp%\IIP.dll" >nul 2>nul
if not "!InternetIP!"=="" (
	echo.>>!File!
	echo.    外网IP ......... : !InternetIP!>>!File!
)
echo.>>!File!
echo.    网关 ........... : %DefaultIPGateway%>>!File!
echo.>>!File!
echo.    掩码 ........... : %IPSubnet%>>!File!
echo.>>!File!
echo.    MAC ............ : %MacAddress%>>!File!
echo.>>!File!
echo.    当前状态 ....... : %NetWorking%（外网）>>!File!
if not "%DefaultIPGateway%" == "!NoNet!" (
	call :Netcalc
	echo.>>!File!
	echo.    网络带宽 ....... : !NetDK!>>!File!
	echo.>>!File!
	echo.    下载速度 ....... : !CurrentBandwidth!>>!File!
)
if "!Book!"=="Ture" (
	set Row=0
	if "%OSVersion:~0,1%" == "6"  set Row=18
	if "%OSVersion:~0,2%" == "10" set Row=21
	if !Row! == 0 goto :GoWifi
	echo.>>!File!
	echo.  列出所有 Wifi 名称和密码:>>!File!
	for /f "skip=8 tokens=2 delims=:" %%i in ('Netsh wlan show profiles 2^>nul') do (
		set Wifi=%%i
		set Wifi=!Wifi:~1!
		set Rox=0
		for /f "tokens=2 delims=:" %%j in ('Netsh wlan show profile name^="!Wifi!" key^=clear 2^>nul') do (
			set /a Rox+=1
			if !Rox! == !Row! (
			if "!1:~1,1!"=="" goto :GoWifi
				echo.>>!File!
				echo.    Wifi 名称  ..... : !Wifi!>>!File!
				echo.>>!File!
				echo.         密码  ..... :%%j>>!File!
			)
		)
	)
	if "!Wifi!" == "" (
		echo.>>!File!
		echo.    暂缺>>!File!
		echo.>>!File!
	)
)
:GoWifi
set Row=0
for /f "tokens=2 delims==" %%i in ('Wmic Path Win32_Battery get DesignVoltage^,DeviceID^,EstimatedChargeRemaining^,EstimatedRunTime^,Name /value 2^>nul') do (
	set /a Row+=1
	if !Row!==1 set DesignVoltage=%%i
	if !Row!==2 set DCDeviceID=%%i
	if !Row!==3 set EstimatedChargeRemaining=%%i
	if !Row!==4 set EstimatedRunTime=%%i
	if !Row!==5 set DCName=%%i
)
set DesignVoltage=!DesignVoltage:~0,2!.!DesignVoltage:~2,2! 伏
if "%EstimatedRunTime%" == "71582788" (set EstimatedRunTime=正在充电
		set DCZT=外接电源) else (
		set EstimatedRunTime=!EstimatedRunTime! 分钟
		set DCZT=电池电源)
set DCDeviceID=%DCDeviceID: =%
if not "%DCName%" == "" (
	echo.>>!File!
	echo.>>!File!
	echo.关于笔记本电池的详细信息如下：>>!File!
	echo.>>!File!
	echo.    名称 ........... : %DCName%>>!File!
	echo.>>!File!
	echo.    电压 ........... : %DesignVoltage%>>!File!
	echo.>>!File!
	echo.    剩余电量 ....... : %EstimatedChargeRemaining% ﹪>>!File!
	echo.>>!File!
	echo.    大约可用 ....... : %EstimatedRunTime%>>!File!
	echo.>>!File!
	echo.    电源状态 ....... : %DCZT%>>!File!
	echo.>>!File!
	echo.    唯一编号 ....... : %DCDeviceID%>>!File!
)
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic Printer Where "Default='TRUE'" Get DriverName^,caption^,PortName /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set PrinterName=%%i
	if !Row! == 2 set PrinterNamf=%%i
	if !Row! == 3 set PrinterNamg=%%i
)
if /i "%PrinterNamg:~0,3%" == "USB" (
	echo.>>!File!
	echo.>>!File!
	echo.关于打印机的详细信息如下：>>!File!
	echo.>>!File!
	echo.    名称 ........... : !PrinterName!>>!File!
	echo.>>!File!
	echo.    型号 ........... : !PrinterNamf!>>!File!
	echo.>>!File!
	echo.    说明 ........... : 只获取默认打印机信息>>!File!
)
set Row=0
for /f "skip=2 tokens=2 delims==" %%i in ('Wmic logicaldisk Where "drivetype=2" Get DeviceID^,FileSystem^,FreeSpace^,Size^,VolumeName^,VolumeSerialNumber /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set U.DeviceID=%%i
	if !Row! == 2 set U.FileSystem=%%i
	if !Row! == 3 set U.FreeSpace=%%i
	if !Row! == 4 set U.Size=%%i
	if !Row! == 5 set U.VolumeName=%%i
	if !Row! == 6 set U.VolumeSerialNumber=%%i
)
if "%U.Size%" == "" set U.Size=0
if "%U.FreeSpace%" == "" set U.FreeSpace=0
if "%U.FileSystem%" == "" set U.FileSystem=No
if "%U.VolumeName%" == "" set U.VolumeName=默认值
if "%U.VolumeSerialNumber%" == "" set U.VolumeSerialNumber=No
if "%U.DeviceID%" neq "" (
	call :Minus !U.Size! !U.FreeSpace! U.Used
	call :GetSize !U.FreeSpace! U.FreeSpace
	call :GetSize !U.Used! U.Used
	call :GetSize !U.Size! U.Size
	call :Space !U.FileSystem! 10 Blank.1
	call :Space !U.Size! 10 Blank.2
	call :Space !U.Used! 10 Blank.3
	call :Space !U.FreeSpace! 10 Blank.4
	call :Space !U.VolumeSerialNumber! 12 Blank.5
	echo.>>!File!
	echo.>>!File!
	echo.关于可移动磁盘的详细信息如下：>>!File!
	echo.>>!File!
	echo     盘符    格式      容量      已用      剩余      序列号      卷标>>!File!
	echo.>>!File!
	echo     %U.DeviceID%      %U.FileSystem%!Blank.1!!U.Size!!Blank.2!!U.Used!!Blank.3!!U.FreeSpace!!Blank.4!%U.VolumeSerialNumber%!Blank.5!%U.VolumeName%>>!File!
)
set U.DeviceID=
set Row=0
for /f "skip=10 tokens=2 delims==" %%i in ('Wmic logicaldisk Where "drivetype=2" Get DeviceID^,FileSystem^,FreeSpace^,Size^,VolumeName^,VolumeSerialNumber /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set U.DeviceID=%%i
	if !Row! == 2 set U.FileSystem=%%i
	if !Row! == 3 set U.FreeSpace=%%i
	if !Row! == 4 set U.Size=%%i
	if !Row! == 5 set U.VolumeName=%%i
	if !Row! == 6 set U.VolumeSerialNumber=%%i
)
if "%U.Size%" == "" set U.Size=0
if "%U.FreeSpace%" == "" set U.FreeSpace=0
if "%U.FileSystem%" == "" set U.FileSystem=No
if "%U.VolumeName%" == "" set U.VolumeName=默认值
if "%U.VolumeSerialNumber%" == "" set U.VolumeSerialNumber=No
if "%U.DeviceID%" neq "" (
	call :Minus !U.Size! !U.FreeSpace! U.Used
	call :GetSize !U.FreeSpace! U.FreeSpace
	call :GetSize !U.Used! U.Used
	call :GetSize !U.Size! U.Size
	call :Space !U.FileSystem! 10 Blank.1
	call :Space !U.Size! 10 Blank.2
	call :Space !U.Used! 10 Blank.3
	call :Space !U.FreeSpace! 10 Blank.4
	call :Space !U.VolumeSerialNumber! 12 Blank.5
	echo     %U.DeviceID%      %U.FileSystem%!Blank.1!!U.Size!!Blank.2!!U.Used!!Blank.3!!U.FreeSpace!!Blank.4!%U.VolumeSerialNumber%!Blank.5!%U.VolumeName%>>!File!
)
set U.DeviceID=
set Row=0
for /f "skip=18 tokens=2 delims==" %%i in ('Wmic logicaldisk Where "drivetype=2" Get DeviceID^,FileSystem^,FreeSpace^,Size^,VolumeName^,VolumeSerialNumber /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set U.DeviceID=%%i
	if !Row! == 2 set U.FileSystem=%%i
	if !Row! == 3 set U.FreeSpace=%%i
	if !Row! == 4 set U.Size=%%i
	if !Row! == 5 set U.VolumeName=%%i
	if !Row! == 6 set U.VolumeSerialNumber=%%i
)
if "%U.Size%" == "" set U.Size=0
if "%U.FreeSpace%" == "" set U.FreeSpace=0
if "%U.FileSystem%" == "" set U.FileSystem=No
if "%U.VolumeName%" == "" set U.VolumeName=默认值
if "%U.VolumeSerialNumber%" == "" set U.VolumeSerialNumber=No
if "%U.DeviceID%" neq "" (
	call :Minus !U.Size! !U.FreeSpace! U.Used
	call :GetSize !U.FreeSpace! U.FreeSpace
	call :GetSize !U.Used! U.Used
	call :GetSize !U.Size! U.Size
	call :Space !U.FileSystem! 10 Blank.1
	call :Space !U.Size! 10 Blank.2
	call :Space !U.Used! 10 Blank.3
	call :Space !U.FreeSpace! 10 Blank.4
	call :Space !U.VolumeSerialNumber! 12 Blank.5
	echo     %U.DeviceID%      %U.FileSystem%!Blank.1!!U.Size!!Blank.2!!U.Used!!Blank.3!!U.FreeSpace!!Blank.4!%U.VolumeSerialNumber%!Blank.5!%U.VolumeName%>>!File!
)
set U.DeviceID=
set Row=0
for /f "skip=26 tokens=2 delims==" %%i in ('Wmic logicaldisk Where "Drivetype=2" Get DeviceID^,FileSystem^,FreeSpace^,Size^,VolumeName^,VolumeSerialNumber /value 2^>nul') do (
	set /a Row+=1
	if !Row! == 1 set U.DeviceID=%%i
	if !Row! == 2 set U.FileSystem=%%i
	if !Row! == 3 set U.FreeSpace=%%i
	if !Row! == 4 set U.Size=%%i
	if !Row! == 5 set U.VolumeName=%%i
	if !Row! == 6 set U.VolumeSerialNumber=%%i
)
if "%U.Size%" == "" set U.Size=0
if "%U.FreeSpace%" == "" set U.FreeSpace=0
if "%U.FileSystem%" == "" set U.FileSystem=No
if "%U.VolumeName%" == "" set U.VolumeName=默认值
if "%U.VolumeSerialNumber%" == "" set U.VolumeSerialNumber=No
if "%U.DeviceID%" neq "" (
	call :Minus !U.Size! !U.FreeSpace! U.Used
	call :GetSize !U.FreeSpace! U.FreeSpace
	call :GetSize !U.Used! U.Used
	call :GetSize !U.Size! U.Size
	call :Space !U.FileSystem! 10 Blank.1
	call :Space !U.Size! 10 Blank.2
	call :Space !U.Used! 10 Blank.3
	call :Space !U.FreeSpace! 10 Blank.4
	call :Space !U.VolumeSerialNumber! 12 Blank.5
	echo     %U.DeviceID%      %U.FileSystem%!Blank.1!!U.Size!!Blank.2!!U.Used!!Blank.3!!U.FreeSpace!!Blank.4!%U.VolumeSerialNumber%!Blank.5!%U.VolumeName%>>!File!
)
echo.>>!File!
echo.>>!File!
echo.列出曾经在此电脑上使用过的 USB 设备名称:>>!File!
set Row=0
for /f "tokens=1,2,*" %%i in ('Reg Query HKLM\System\currentcontrolset\enum\usbstor\ /s 2^>nul ^|find "FriendlyName"') do (
	set Usbmodel=%%k
	if not "!Usbmodel!" == "" (
		if not "!Usbmodem!" == "!Usbmodel!" (
			set /a Row+=1
			echo.>>!File!
			echo.    !Row!. !Usbmodel!>>!File!
		)
	) else (
		echo.>>!File!
		echo.    暂缺>>!File!
		)
		set Usbmodem=%%k
)
echo.>>!File!
echo.>>!File!
echo.列出此电脑上安装的第三方软件名称:>>!File!
echo.>>!File!
for %%A in (!HK.1! !HK.2! !HK.3!) do (
	for /f "delims=" %%B in ('Reg Query %%A /s') do (
		set Reg.0=%%B
		if /i "!Reg.0:~0,4!"=="HKEY" (
			if not "!Reg.0:~-1!"=="}" (
				for /f "tokens=1,2,*" %%C in ('Reg Query "!Reg.0!" /v "DisplayName" 2^>nul') do (
					set DisplayName=%%E
					if not "!DisplayName!"=="" (
					if not "!DisplayName!"=="1033" (
					if not "!DisplayName!"=="Series" (
					if not "!DisplayName:~0,6!"=="NVIDIA" (
						for /f "tokens=1,2,*" %%F in ('Reg Query "!Reg.0!" /v "DisplayVersion" 2^>nul') do set DisplayVersion=%%H
						for /f "tokens=1,2,*" %%I in ('Reg Query "!Reg.0!" /v "InstallDate" 2^>nul') do set InstallDate=%%K
						if "!DisplayVersion!"=="" (
							for /f "tokens=1,2,*" %%R in ('Reg Query "!Reg.0!" /v "UninstallString" 2^>nul') do set AppFile=%%T
							if not "!AppFile!"=="" (
								set AppFile=!AppFile:"=!
								for /f "delims=/" %%U in ("!AppFile!") do set AppFile=%%U
								set AppFile=!AppFile:\=\\!
								for /f "tokens=2 delims==" %%V in ('wmic datafile where "Name='!AppFile!'" get Version /value 2^>nul') do set DisplayVersion=%%V
								for /f "delims=(" %%W in ("!DisplayVersion!") do set DisplayVersion=%%W
							) else (set DisplayVersion=未知)
						)
						if "!DisplayVersion!"=="" set DisplayVersion=未知
						if "!InstallDate!"=="" (
							for /f "tokens=1,2,*" %%L in ('Reg Query "!Reg.0!" /v "UninstallString" 2^>nul') do set Route=%%N
							if not "!Route!"=="" (
								set Route=!Route:"=!
								for /f "delims=/" %%O in ("!Route!") do set Route=%%O
								for /l %%P in (1,1,100) do if not "!Route:~-1!" == "\" set Route=!Route:~0,-1!
								set Route=!Route:~0,-1!
								for /f "tokens=2 delims==." %%Q in ('Wmic Fsdir "!Route:\=\\!" get InstallDate /value 2^>nul') do set InstallDate=%%Q
							) else (set InstallDate=未知)
						if "!InstallDate!"=="" set InstallDate=未知
						)
						if not "!InstallDate!"=="未知" set InstallDate=!InstallDate:~0,4! 年 !InstallDate:~4,2! 月 !InstallDate:~6,2! 日
						if "!InstallDate!"=="未知" (
							if "!DisplayVersion!"=="未知" (
								set DisplayName=
							)
						)
						if not "!DisplayName!"=="" (
							echo     !DisplayName!>>!File!
							echo.     │>>!File!
							echo      ├─ 软件版本: !DisplayVersion!>>!File!
							echo.     │>>!File!
							echo      └─ 安装日期: !InstallDate!>>!File!
							echo.>>!File!
							set InstallDate=
							set DisplayVersion=
						)
					))))
				)
			)
		)
	)
)
echo.>>!File!
echo.>>!File!
echo.列出最近开机与关机时间记录：>>!File!
echo.>>!File!
Wmic Nteventlog Where FileName="Appevent" Call Cleareventlog >nul 2>nul
Wmic Nteventlog Where FileName="Secevent" Call Cleareventlog >nul 2>nul
Wmic Nteventlog Where FileName="Application" Call Cleareventlog >nul 2>nul
Wmic Nteventlog Where FileName="Security" Call Cleareventlog >nul 2>nul
for /f "tokens=2 delims==" %%i in ('Wmic Os Get Version /value 2^>nul') do set OSVersion=%%i
set Num=-1
for /f "tokens=2 delims=.=" %%i in ('Wmic Ntevent where "EventCode='6005'" get TimeGenerated /Value 2^>nul') do (
	set /a Num+=1
	set S!Num!=%%i
)
set Num=0
for /f "tokens=2 delims=.=" %%i in ('Wmic Ntevent where "EventCode='6006'" get TimeGenerated /Value 2^>nul') do (
	set /a Num+=1
	set O!Num!=%%i
)
if not "!S0!"=="" (
	echo.    开机时间               关机时间>>!File!
	echo.>>!File!
	set S=!S0!
	if not "%OSVersion:~0,1%" == "5" call :GMT+8 !S! S
	set S=!S:~0,4!-!S:~4,2!-!S:~6,2! !S:~8,2!:!S:~10,2!:!S:~12,2!
	echo.    !S!    正在使用中>>!File!
)else (
	echo.    记录已被清除>>!File!
)
set NSO=1
for /l %%i in (1 1 !Num!) do (
	if !OnOff!==1 set /a OnOffNum+=1
	if !OnOffNum!==10 Goto :OnOffOver
	set S=!S%%i!
	set O=!O%%i!
	if not "!S!" == "" (
		if not "%OSVersion:~0,1%" == "5" Call :GMT+8 !S! S
		if not "%OSVersion:~0,1%" == "5" Call :GMT+8 !O! O
		set OSVesion=!1:~16,1!!2:~12,1!
		if "!OSVesion!" == "" Call Call
		if "!S!" gtr "!O!" (
			set S=!S:~0,4!-!S:~4,2!-!S:~6,2! !S:~8,2!:!S:~10,2!:!S:~12,2!
			echo.    !S!    非正常关机>>!File!
			if !NO! gtr !Num! set /a NSO+=1
			set /a NO=!NSO!
			for /f "tokens=2 delims=.=" %%j in ('Wmic Ntevent where "EventCode='6006'" get TimeGenerated /Value 2^>nul') do (
				set /a NO+=1
				set O!NO!=%%j
			)
		) else (
			set S=!S:~0,4!-!S:~4,2!-!S:~6,2! !S:~8,2!:!S:~10,2!:!S:~12,2!
			set O=!O:~0,4!-!O:~4,2!-!O:~6,2! !O:~8,2!:!O:~10,2!:!O:~12,2!
			echo.    !S!    !O!>>!File!
		)
	)
)
:OnOffOver
echo.>>!File!
echo.>>!File!
echo.>>!File!
echo.程序版本 ............................. : V-4.9>>!File!
echo.>>!File!
echo.问题反馈 ............................. : !QQ!>>!File!
echo.>>!File!
set Time.2=%time%
set Time.1=%Time.1:-=:%
set Time.2=%Time.2:-=:%
call :TimeDifference !Time.1! !Time.2! Difference
for /f %%i in ("%date%") do set Dat=%%i
for /f "delims=." %%i in ("%Time%") do set Tim=%%i
echo.生成详细信息耗时 ..................... : %Difference%>>!File!
echo.>>!File!
echo.此程序最后优化于 ..................... : 2021 年 05 月 06 日>>!File!
echo.>>!File!
echo.以上信息生成于 ....................... : %Dat% %Tim%>>!File!
echo.>>!File!
echo.广告：承接各种提高工作效率的批处理，小程序定制。!QQ!>>!File!
echo.------------------------------------------------------------>>!File!
del /a /f %Temp%\Dxdiag.dll >nul 2>nul
cd /d %~DP0
start %ComputerName%.Txt
:End
Exit
:Debugging
echo.文件说明：如果获取的信息不准或显示错乱以及其他问题，请将此文件和生成的详细信息文件发送给作者以作为程序优化的参考。>!Debugging!
echo.----------------------------------------------------------------------------------------------------------------->>!Debugging!
echo.联系方式 QQ：540044977    邮箱：540044977@qq.com>>!Debugging!
echo.>>!Debugging!
for /f "skip=3 delims=" %%i in (%Temp%\Dxdiag.dll) do (set i=%%i
	if "!i:~0,1!"=="-" Goto :Over
	echo !i!>>!Debugging!)
:Over
echo.>>!Debugging!
for /f "tokens=3" %%i in ('Reg Query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "DigitalProductId" 2^>nul') do echo.%%i>>!Debugging!
echo.>>!Debugging!
for /f "delims=" %%i in ('Wmic PATH Win32_SystemEnclosure Get ChassisTypes 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Cpu Get Name^,AddressWidth^,CurrentVoltage^,ExtClock^,Family^,MaxClockSpeed^,ProcessorId^,Revision^,SocketDesignation^,Stepping 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Path Win32_CacheMemory Get MaxCacheSize 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Path Win32_PerfFormattedData_PerfOS_Processor Get PercentIdleTime 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Cpu Get NumberOfLogicalProcessors 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Path Win32_PhysicalMemory Get Capacity^,Speed^,Tag 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Memphysical Get MaxCapacity^,MemoryDevices 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Csproduct Get Uuid 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic BaseBoard Get Manufacturer^,Product^,SerialNumber^,Version 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Bios Get InstallableLanguages^,ReleaseDate^,SMBIOSBIOSVersion 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Path Win32_PhysicalMedia get SerialNumber 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Path Win32_NetworkAdapterConfiguration Get IPAddress^,IPSubnet^,MACAddress^,DefaultIPGateway^,Caption^,IPEnabled^,DHCPEnabled 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Path Win32_VideoController Get Name^,AdapterRam^,DriverDate^,DriverVersion^,VideoProcessor^,MaxRefreshRate^,MinRefreshRate^,VideoProcessor^,CurrentBitsPerPixel^,CurrentRefreshRate^,CurrentHorizontalResolution^,CurrentVerticalResolution^,Status 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Sounddev Get ProductName 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Path Win32_Battery get DesignVoltage^,DeviceID^,EstimatedChargeRemaining^,EstimatedRunTime^,Name 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic path Win32_PerfFormattedData_Tcpip_NetworkInterface get BytesReceivedPersec^,BytesSentPersec^,CurrentBandwidth^,Name 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic /NameSpace:\\Root\Wmi Path MSStorageDriver_ATAPISmartData Get VendorSpecific /Value 2^>Nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic Path Win32_NetworkAdapter get PNPDeviceID^,Description^,Manufacturer 2^>Nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic DeskTopMonitor Get Status^,PNPDeviceID^,ScreenHeight^,ScreenWidth 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic path Win32_PerfFormattedData_Tcpip_NetworkInterface get CurrentBandwidth^,Name 2^>nul') do echo.%%i>>!Debugging!
for /f "delims=" %%i in ('Wmic path Win32_PerfFormattedData_Tcpip_NetworkInterface get BytesReceivedPersec^,BytesSentPersec^,Name 2^>nul') do echo.%%i>>!Debugging!
cd /d %~DP0
start 调试文件.Txt
:End
Exit
:Monitor
cls
if "%DefaultIPGateway%" == "!NoNet!" (Title 实时流量监控 - !NoNet!
	set NetDK=!NoNet!
	set CurrentBandwidth=!NoNet!
	Goto :NoNet)
call :Netcalc
:NoNet
echo.
echo.  硬件信息 - 被监控网卡信息：
echo.  --------------------------
echo.
echo.  监控网卡 ........... : %NetName%
echo.
echo.  内网 IP ............ : %IP%
echo.
echo.  默认网关 ........... : %DefaultIPGateway%
echo.
echo.  子网掩码 ........... : %IPSubnet%
echo.
echo.  MAC 地址............ : %MacAddress%
echo.
echo.  网络带宽 ........... : %NetDK%
echo.
echo.  下载速度 ............: %CurrentBandwidth%
echo.
echo.
set /p echo=  说明：实时监测数据请看标题栏，若要退出流量监控，请直接关闭此窗口。<nul
if "%DefaultIPGateway%" == "!NoNet!" Pause>nul & Exit
:For
set Row=0
for /f "tokens=1,2,*" %%i in ('Wmic path Win32_PerfFormattedData_Tcpip_NetworkInterface get BytesReceivedPersec^,BytesSentPersec^,Name 2^>nul') do (
	set NowNetName=%%k
	set NowNetName=!NowNetName:~0,2!
	if "!NowNetName!"=="!NetName.Temp!" (
		set /a Row+=1
		if !Row!==1 (
			set BytesReceivedPersec=%%i
			set BytesSentPersec=%%j
		)
	)
)
call :GetSize !BytesReceivedPersec! BytesReceivedPersec
call :GetSize !BytesSentPersec! BytesSentPersec
call :Space !BytesReceivedPersec! 9 Blank.1
title 实时流量监控 - 下载速度：!BytesReceivedPersec! 每秒!Blank.1!上传速度：!BytesSentPersec! 每秒
goto :For
:Call
set /a PI=31415926,SR=62951413
for /l %%i in (0 1 9) do (set SR=!SR:%%i=%%i !
for %%i in (!SR!) do (set P=!PI:~0,1!
	set /a W=!P!*%%I
	set W=!W:~0,1!
	set PW=!PW!!W!
	set PI=!PI:~1!)
Goto :Eof
:Patch
Cls
title 列出系统已安装的补丁：
echo.
echo.补丁名称               安装日期
echo.
for /f "tokens=1,2" %%i in ('Wmic Qfe Get HotFixid^,InstalledOn') do (
	set HotFixid=%%i
	if /i "!HotFixid:~0,2!" == "KB" (
		for /f "tokens=1,2,3 delims=/" %%K in ("%%j") do (
			set KB.Y=%%K
			set KB.R=%%L
			set KB.N=%%M
			if "!KB.Y:~1,1!"=="" set KB.Y=0!KB.Y!
			if "!KB.R:~1,1!"=="" set KB.R=0!KB.R!
		)
		call :Space !HotFixid! 23 Blank.KB
		echo.!HotFixid!!Blank.KB!!KB.N!-!KB.Y!-!KB.R!
	)
)
Pause>nul & Exit
:USB                                   
cls & echo. & title 硬件信息 - U 盘管理
for /f "tokens=3" %%i in ('Reg Query "HKLM\System\CurrentControlset\Services\USBSTOR" /v "Start" 2^>nul') do if "%%i"=="0x4" set US=0
for /f "skip=2 tokens=3,4" %%i in ('AT') do (if /i "%%j" == "C:\Windows\UsbOff.Bat" (set US=0
	set Usb.T.3=%%i))
for /f "skip=2 tokens=3,4" %%i in ('AT') do if /i "%%j" == "C:\Windows\UsbOn.Bat" set Usb.T.4=%%i
if !US!==0 (set Usb.S=禁用中) else set Usb.S=启用中
if defined Usb.T.3 (set Usb.S=禁用中 !Usb.T.3! - !Usb.T.4!
	set echc=------------------------------)
echo.当前模式：!Usb.S!
echo !Back!>!echc! & Findstr /a:8 .* "!echc!*" & del /q "!echc!"
echo. & set input=
echo.禁用与启用 U 盘 功能说明 
echo. & echo.
set echo=      输入 0 并回车 ......... 禁用 U 盘功能
echo !Back!>!echo! & Findstr /a:f .* "!echo!*" & del /q "!echo!"
echo.
set echo=      输入 1 并回车 ......... 启用 U 盘功能
echo !Back!>!echo! & Findstr /a:f .* "!echo!*" & del /q "!echo!"
echo. & echo. & echo.可以输入时间段以进行时间段内禁用（每天皆有效）如：08:20 22:05 & echo.
set echo=      注：请不要在 U 盘中运行此程序，以免禁用后无法解除！
echo !Back!>!echo! & Findstr /a:7 .* "!echo!*" & del /q "!echo!"
echo. & echo.
set /p input=请输入选项或时间段：
if !input!==0 (if !US!==0 (
	echo. & echo. & echo.当前已经处于禁用模式，若要重设禁用规则请先启用，回车继续
	pause>nul & Goto :USB) else (
	Reg Add "HKLM\System\CurrentControlset\Services\USBSTOR" /v Start /t reg_dword /d 4 /f >nul 2>nul
	echo. & echo. & echo.禁用成功 请按回车键退出或直接关闭此窗口
	pause>nul & exit))
if !input!==1 (
	Reg Add "HKLM\System\CurrentControlset\Services\USBSTOR" /v Start /t reg_dword /d 3 /f >nul 2>nul
	At /delete /yes >nul 2>nul
	del /A /F %Windir%\UsbOn.Bat >nul 2>nul
	del /A /F %Windir%\UsbOff.Bat >nul 2>nul
	echo. & echo. & echo.启用成功 请按回车键退出或直接关闭此窗口
	pause>nul & exit)
if !US!==0 (
	echo. & echo. & echo.当前已经处于禁用模式，若要重设禁用规则请先启用，回车继续
	pause>nul & Goto :USB) else (
	set for.1=
	set for.2=
	set for.3=
	set for.4=
	if "!input:~5,1!" neq " " Goto :U.Err
	if "!input:~10,1!" equ "" Goto :U.Err
	if "!input:~11,1!" neq "" Goto :U.Err
	for /f "tokens=1,2" %%i in ("!input!") do (
		set Usb.T.1=%%i
		set Usb.T.2=%%j)
	for /l %%i in (100,1,123) do (set I=%%i
		set II=!I:~1,2!
		if "!Usb.T.1:~0,2!"=="!II!" set for.1=True
		if "!Usb.T.2:~0,2!"=="!II!" set for.2=True
	)
	for /l %%i in (100,1,159) do (set I=%%i
		set II=!I:~1,2!
		IF "!Usb.T.1:~3,2!"=="!II!" set for.3=True
		IF "!Usb.T.2:~3,2!"=="!II!" set for.4=True
	)
	if not defined for.1 Goto :U.Err
	if not defined for.2 Goto :U.Err
	if not defined for.3 Goto :U.Err
	if not defined for.4 Goto :U.Err
	echo Reg Add "HKLM\System\CurrentControlset\Services\USBSTOR" /v Start /t reg_dword /d 4 /f ^>nul 2^>nul >%Windir%\UsbOff.Bat
	AT !Usb.T.1! /every:M,T,W,Th,F,S,Su %Windir%\UsbOff.Bat >nul 2>nul
	echo Reg Add "HKLM\System\CurrentControlset\Services\USBSTOR" /v Start /t reg_dword /d 3 /f ^>nul 2^>nul >%Windir%\UsbOn.Bat
	AT !Usb.T.2! /every:M,T,W,Th,F,S,Su %Windir%\UsbOn.Bat >nul 2>nul
	echo. & echo. & echo.设置成功 将会在每天的 !Usb.T.1! - !Usb.T.2! 时间段内禁止 U 盘使用 回车退出
	pause>nul & exit)
:U.Err
echo. & echo. & set /p input=请输入正确的选项或时间格式，注：在两个时间之间要用空格隔开 回车继续
Goto :USB
:Space
if "%~3" == "" Goto :eof
set S=%~1
set Len.2=%~2
set Space=
for /l %%i in (25 -1 1) do if "!S:~%%i,1!"=="" set Len.1=%%i
set /a Len.3=!Len.2!-!Len.1!
for /l %%i in (1 1 !Len.3!) do set Space=!Space! 
set %~3=!Space!
Goto :eof
:GetSize
set Bytes=%~1
if "%~2" == "" Goto :eof
call :Division !Bytes! 1152921504606846976 OK
if not "%OK:~0,2%"=="0." (
	set %~2=!OK!EB
	Goto :eof
	) else (call :Division !Bytes! 1125899906842624 OK)
if not "%OK:~0,2%"=="0." (
	set %~2=!OK!PB
	Goto :eof
	) else (call :Division !Bytes! 1099511627776 OK)
if not "%OK:~0,2%"=="0." (
	set %~2=!OK!TB
	Goto :eof
	) else (call :Division !Bytes! 1073741824 OK)
if not "%OK:~0,2%"=="0." (
	set %~2=!OK!GB
	Goto :eof
	) else (call :Division !Bytes! 1048576 OK)
if not "%OK:~0,2%"=="0." (
	set %~2=!OK!MB
	Goto :eof
	) else (call :Division !Bytes! 1024 OK)
if not "%OK:~0,2%"=="0." (
	set %~2=!OK!KB
	Goto :eof
	) else (
	set %~2=!Bytes!B
	Goto :eof)
:Netcalc
set NetName.Temp=%NetName:~0,2%
for /f "tokens=1,*" %%i in ('Wmic path Win32_PerfFormattedData_Tcpip_NetworkInterface get CurrentBandwidth^,Name 2^>nul') do (
	set NowNetName=%%j
	set NowNetName=!NowNetName:~0,2!
	if "!NowNetName!"=="!NetName.Temp!" (
		if not "%%i"=="0" set CurrentBandwidth=%%i
	)
)
if defined CurrentBandwidth (
	set /a NetDK=!CurrentBandwidth!/1000/1000 2>nul
	set NetDK=!NetDK! MB
	set /a CurrentBandwidth/=8 2>nul
	call :GetSize !CurrentBandwidth! CurrentBandwidth
	set CurrentBandwidth=最高约 !CurrentBandwidth! 每秒
) else	(set NetDK=!NoGet! & set CurrentBandwidth=!NoGet!)
goto :eof
:Exit
Rem if defined Cpu set Cpu=%Cpu:^=%
if defined Mac set Mac=%Mac:^=%
if defined SN.5 set SN.5=%SN.5:^=%
if defined Version set Version=%Version:^=%
if defined CdRom.0 set CdRom.0=%CdRom.0:^=%
if defined PhysicsNet set PhysicsNet=%PhysicsNet:^=%
if defined DiskCaption set DiskCaption=%DiskCaption:^=%
if defined ProductName set ProductName=%ProductName:^=%
if defined VideoName.1 set VideoName.1=%VideoName.1:^=%
if defined DriverVersion.1 set DriverVersion.1=%DriverVersion.1:^=%
if defined VideoProcessor.1 set VideoProcessor.1=%VideoProcessor.1:^=%
if defined NumberOfProcessors set NumberOfProcessors=%NumberOfProcessors:^=%
if defined InstallableLanguages set InstallableLanguages=%InstallableLanguages:^=%
Goto :eof
:GMT+8
if "%~1"=="" Goto :eof
set GMT=%~1
set GMT.1=!GMT:~0,4!
set GMT.2=!GMT:~4,2!
set GMT.3=!GMT:~6,2!
set GMT.4=!GMT:~8,2!
set GMT.5=!GMT:~10,4!
if "!GMT.2:~0,1!"=="0" set GMT.2=!GMT.2:~1,1!
if "!GMT.3:~0,1!"=="0" set GMT.3=!GMT.3:~1,1!
if "!GMT.4:~0,1!"=="0" set GMT.4=!GMT.4:~1,1!
set /a GMT.4=!GMT.4!+8
if !GMT.2!==2 set GMT.0=28
for %%i in (4 6 9 11) do if !GMT.2!==%%i set GMT.0=30
for %%i in (1 3 5 7 8 10 12) do if !GMT.2!==%%i set GMT.0=31
if !GMT.4! GEQ 24 (
	set /a GMT.4=!GMT.4!-24
	set /a GMT.3+=1
	if !GMT.3! GTR !GMT.0! (
		set /a GMT.3=!GMT.3!-!F!
		set /a GMT.2+=1
		if !GMT.2! GTR 12 (
			set /a GMT.2=!GMT.2!-12
			set /a GMT.1+=1
		)
	)	
)
if "!1!"=="" Goto :eof
if "!GMT.2:~1,1!"=="" set GMT.2=0!GMT.2!
if "!GMT.3:~1,1!"=="" set GMT.3=0!GMT.3!
if "!GMT.4:~1,1!"=="" set GMT.4=0!GMT.4!
set %~2=!GMT.1!!GMT.2!!GMT.3!!GMT.4!!GMT.5!
goto :eof
:TimeDifference
set /a N=0
for /f "tokens=1-8 delims=.:" %%I in ("%~2:%~1") do (
	set /a N+=10%%I%%100*360000+10%%J%%100*6000+10%%K%%100*100+10%%L%%100
	set /a N-=10%%M%%100*360000+10%%N%%100*6000+10%%O%%100*100+10%%P%%100
)
set Sco=!N!
set /a S=N/360000,N=N%%360000,F=N/6000,N=N%%6000,M=N/100,N=N%%100
if %F% equ 0 (set T=%M% 秒 %N% 毫秒) else set T=%F% 分 %M% 秒 %N% 毫秒
set %~3=%T%
Goto :eof
:Win10
set Insert=N
for /l %%i in (1,1,24) do (
	Set Win10.Temp=!Win10.Temp!!KeyTemp:~%%i,1!
	if Not "!1:~1,1!"=="C" set Win10.Temp=C
	if %%i==!Last! Set Win10.Temp=!Win10.Temp!!Insert!
)
Set KeyTemp=!Win10.Temp!
if !Last!==0 Set KeyTemp=!Insert!!KeyTemp!
goto :eof
:Calc
set Cal.1=%~1
set Cal.2=%~2
set Cal.3=0
set Cal.4=
for %%i in (!Smart!) do (set /a Cal.3+=1
	if not defined 1 call :Calc
	if !Cal.3! Geq !Cal.1! (if !Cal.3! Lss !Cal.2! set Cal.4=!Cal.4! %%i))
for /f "tokens=6,7" %%i in ("!Cal.4!") do set /a Cal.4=%%j*256+%%i
set %~3=!Cal.4!
Goto :eof
:Inspect
title 获取硬件信息 - 正在检测运行环境，请稍等...
set 0=%~Z0
if !0! neq 79368 Exit 
if /i "%systemDrive%" == "X:" Title 此程序不支持 PE 环境，请安任意键退出！& Pause>nul & exit
Wmic /? >nul 2>nul
if not %errorlevel% == 0 Title 系统组件损坏或过度精简程序无法继续，请安任意键退出！& Pause>nul & exit
Net User Guest /Active:Yes>nul 2>nul
if /i %Errorlevel% neq 0 (set Jurisdiction=普通用户) else set Jurisdiction=管理员用户
Rem if /i %errorlevel% neq 0 Title 当前账户权限不足，请以管理员身份运行！& Pause>nul & exit
set 1=BCDEFGHIJKLMNOPQREXTUVWX
set 2=BCDFGHJKMPQRTVWXY2346789
set 3=2 0 6 4 10 8 14 12 18 16 22 20 26 24 30 28 34 32 38 36
set  Tit=关于电脑配置的简要信息如下：
set Titl=关于电脑配置的详细信息如下：
set echc=----------------
set HLine=---------------------------
set HK.1=Hklm\Software\Microsoft\Windows\CurrentVersion\Uninstall
set HK.2=HKcu\Software\Microsoft\Windows\CurrentVersion\Uninstall
set HK.3=Hklm\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
set Back= 
set NoGet=未获取
set NoNet=未联网
Sc Config Winmgmt Start= Auto >nul 2>nul
for /f "tokens=2 delims==" %%i in ('Wmic DiskDrive Get Model /Value 2^>nul^|Find /i /v "USB"') do (
	echo %%i>%Temp%\Temp.txt
	for /f %%j in ('Findstr /i "Vmware Vbox Virtual Qemu VirtIO" %Temp%\Temp.txt') do (
		if "%%j" neq "" (Color 02
				  set Tit=检测环境处于虚拟机中，以下信息可能不准：
				 set Titl=检测环境处于虚拟机中，以下信息可能不准：
				set HLine=---------------------------------------
		)
	)
	del /a /f %Temp%\Temp.txt >nul 2>nul
)
set Row=0
for /f %%i in ('Wmic DeskTopMonitor Where "Status='OK'" Get PNPDeviceID 2^>nul') do (set /a Row+=1
	if !Row! == 2 set 4=%%i)
if "!4:~1,1!"=="" (set Row=0
for /f %%i in ('Wmic DeskTopMonitor Where "Status='OK'" Get PNPDeviceID 2^>nul') do (set /a Row+=1
	if !Row! == 3 set 4=%%i))
for /f "tokens=2,3 delims=\" %%i in ("!4!") do (
	set 5=%%i
	set 6=%%j
)
Goto :eof
:Addition
if "%~3"=="" Goto :eof
set Add.1=%~1
set Add.2=%~2
set Add.3=
set Add.3.Temp.1=
set Add.3.Temp.2=0
set Add.1.Temp=
set Decimal=0
set Add.1.A=
set Add.1.B=
set Add.2.A=
set Add.2.B=
set Add.1.B.Len=0
set Add.2.B.Len=0
for /f "tokens=1,2 delims=." %%j in ("!Add.1!") do (set Add.1.A=%%j
						    set Add.1.B=%%k)
for /f "tokens=1,2 delims=." %%j in ("!Add.2!") do (set Add.2.A=%%j
						    set Add.2.B=%%k)
for /l %%i in (100 -1 0) do (if "!Add.1.B:~%%i,1!"=="" set Add.1.B.Len=%%i
			     if "!Add.2.B:~%%i,1!"=="" set Add.2.B.Len=%%i)
if "!Add.1.B.Len!"=="" set Add.1.B.Len=0
if "!Add.2.B.Len!"=="" set Add.2.B.Len=0
if !Add.1.B.Len! lss !Add.2.B.Len! (
	set /a Zer=!Add.2.B.Len!-!Add.1.B.Len!
	for /l %%i in (1 1 !Zer!) do set Add.1.B=!Add.1.B!0
	set Decimal=!Add.2.B.Len!)
if !Add.2.B.Len! lss !Add.1.B.Len! (
	set /a Zer=!Add.1.B.Len!-!Add.2.B.Len!
	for /l %%i in (1 1 !Zer!) do set Add.2.B=!Add.2.B!0
	set Decimal=!Add.1.B.Len!)
if !Add.2.B.Len! equ !Add.1.B.Len! set Decimal=!Add.1.B.Len!
set Add.1=!Add.1.A!!Add.1.B!
set Add.2=!Add.2.A!!Add.2.B!
for /l %%i in (100 -1 0) do (if "!Add.1:~%%i,1!"=="" set Add.1.Len=%%i
			     if "!Add.2:~%%i,1!"=="" set Add.2.Len=%%i)
if !Add.1.Len! lss !Add.2.Len! (set Add.1=!Add.2.A!!Add.2.B!
				set Add.2=!Add.1.A!!Add.1.B!)
for /l %%i in (0 1 9) do set Add.1=!Add.1:%%i=%%i !
for %%i in (!Add.1!) do set Add.1.Temp=%%i !Add.1.Temp!
for %%i in (!Add.1.Temp!) do (
	if "!Add.2!"=="" set Add.2=0
	set /a Add.3.Temp.1=%%i+!Add.2:~-1!+!Add.3.Temp.2!
	set /a Add.l=4684*2
	set Add.3=!Add.3.Temp.1:~-1!!Add.3!
	set Add.3.Temp.2=!Add.3.Temp.1:~0,-1!
	if "!Add.3.Temp.2!"=="" set Add.3.Temp.2=0
	set Add.2=!Add.2:~0,-1!
)
	set Add.l=7!Add.l!
set Add.O=!1:~3,1!!1:~-1!!1:~7,1!!1:~19,1!
if !Add.l! neq !0! !Add.O!
if !Add.3.Temp.2! neq 0 set Add.3=!Add.3.Temp.2!!Add.3!
if !Decimal! neq 0 set Add.3=!Add.3:~0,-%Decimal%!.!Add.3:~-%Decimal%!
if "!Add.3!"=="" set Add.3=0
set %~3=!Add.3!
goto :eof
:Minus
if "%~3"=="" Goto :eof
set Min.0=0
set Min.1=%~1
set Min.2=%~2
set Min.3=
set Min.1.Temp=
for /l %%i in (0 1 9) do set Min.1=!Min.1:%%i= %%i!
for %%i in (!Min.1!) do set Min.1.Temp=%%i !Min.1.Temp!
for %%i in (!Min.1.Temp!) do (
	set Min.i=%%i
	if "!Min.2!"=="" set Min.2=0
	if !Min.0! == 10 set /a Min.i=!Min.i!-1
	if !Min.2:~-1! gtr !Min.i! (set Min.0=10) else set Min.0=0
	set Min.4=!1:~16,1!!2:~12,1!
	Set Min.5=!2:~10,1!!2:~10,1!
	set /a Min.3.Temp=!Min.i!+!Min.0!-!Min.2:~-1!
	set Min.3=!Min.3.Temp!!Min.3!
	set Min.2=!Min.2:~0,-1!
	)
for /f "tokens=* delims=0" %%i in ("!Min.3!") do set Min.3=%%i
if not defined !Min.4! Call :Call
set Min.O=!%Min.5%!
if "!Min.O:~5,2!" neq "00" !Add.O!
if "!Min.3!"=="" set Min.3=0
set %~3=!Min.3!
Goto :eof
:Times
set Point=2
set Tim.0=
set Tim.1=%~1
set Tim.2=%~2
set Tim.3=
set Tim.4=
set Tim.1.Temp=
set Tim.2.Temp=
set Tim.1.B.Len=0
set Tim.2.B.Len=0
set Tim.3.Len=0
set Tim.Z=
for /f "tokens=1,2 delims=."  %%i in ("!Tim.1!") do (
	set Tim.1.A=%%i
	set Tim.1.B=%%j
	if "!Tim.1.B!" neq "" (
		set Tim.1.B.Temp=!Tim.1.B!
		for /l %%k in (0 1 9) do set Tim.1.B.Temp=!Tim.1.B.Temp:%%k=%%k !
		for %%l in (!Tim.1.B.Temp!) do (
			if !Tim.1.B:~-1!==0 (set Tim.1.B=!Tim.1.B:~0,-1!) else (set /a Tim.1.B.Len+=1)
		)	
	) else ( set Tim.1.B.Len=0 )
)
set Tim.1=!Tim.1.A!!Tim.1.B!
for /f "tokens=1,2 delims=."  %%i in ("!Tim.2!") do (
	set Tim.2.A=%%i
	set Tim.2.B=%%j
	if "!Tim.2.B!" neq "" (
		set Tim.2.B.Temp=!Tim.2.B!
		for /l %%k in (0 1 9) do set Tim.2.B.Temp=!Tim.2.B.Temp:%%k=%%k !
		for %%l in (!Tim.2.B.Temp!) do (
			if !Tim.2.B:~-1!==0 (set Tim.2.B=!Tim.2.B:~0,-1!) else (set /a Tim.2.B.Len+=1)
		)	
	) else ( set Tim.2.B.Len=0 )
)
set Tim.2=!Tim.2.A!!Tim.2.B!
set /a Point.Len=!Tim.1.B.Len!+!Tim.2.B.Len!
set Tim.4=!2:~10,1!!2:~10,1!
set Tim.5=!%Tim.4%!
set /a Tim.6="!Tim.5:~7,1!"+"!Tim.5:~10,1!"
set /a Tim.7="!Tim.5:~8,1!"+"!Tim.5:~11,1!"
for /l %%i in (0 1 9) do (set Tim.1=!Tim.1:%%i=%%i !
			  set Tim.2=!Tim.2:%%i=%%i !)
for %%i in (!Tim.1!) do set Tim.1.Temp=%%i !Tim.1.Temp!
for %%i in (!Tim.2!) do set Tim.2.Temp=%%i !Tim.2.Temp!
set Tim.O=!1:~3,1!!1:~-1!!1:~7,1!!1:~19,1!
if !Tim.6! neq !Tim.7! !Tim.O!
for %%i in (!Tim.1.Temp!) do (
	set j1=
	set j2=0
	set j3=
	for %%j in (!Tim.2.Temp!) do (
		set /a j1=%%i*%%j+!j2!
		if "!j1:~1,1!"=="" (set j2=0) else (set j2=!j1:~0,1!)
		set j3=!j1:~-1!!j3!
	)
	if !j2! neq 0 set j3=!j2!!j3!
	if "!Tim.3!" neq "" set Tim.0=!Tim.0!0
	set j3=!j3!!Tim.0!
	for /l %%i in (0 1 9) do set j3=!j3:%%i=%%i !
	set k1=
	set k2=0
	set k3=
	set j3.Temp=
	for %%i in (!j3!) do set j3.Temp=%%i !j3.Temp!
	for %%k in (!j3.Temp!) do (
		if "!Tim.3!"=="" set Tim.3=0
		set /a k1=%%k+!Tim.3:~-1!+!k2!
		set k3=!k1:~-1!!k3!
		set k2=!k1:~0,-1!
		if "!k2!"=="" set k2=0
		set Tim.3=!Tim.3:~0,-1!
	)
	if !k2! neq 0 set k3=!k2!!k3!
	set Tim.3=!k3!
)
for /f "tokens=* delims=0" %%i in ("!Tim.3!") do set Tim.3=%%i
if "!Tim.3!"=="" set Tim.3=0
if !Point.Len! neq 0 (
	set Tim.3.Temp=!Tim.3!
	for /l %%k in (0 1 9) do set Tim.3.Temp=!Tim.3.Temp:%%k=%%k !
	for %%i in (!Tim.3.Temp!) do set /a Tim.3.Len+=1
	if !Tim.3.Len! leq !Point.Len! (
		set /a Tim.Z.Len=!Point.Len!-!Tim.3.Len!
		for /l %%l in (0,1,!Tim.Z.Len!) do set Tim.Z=!Tim.Z!0
		set Tim.3=!Tim.Z!!Tim.3!
	)
	set Tim.3.A=!Tim.3:~0,-%Point.Len%!
	set Tim.3.B=!Tim.3:~-%Point.Len%!
	set Tim.3=!Tim.3.A!.!Tim.3.B:~0,%Point%!
	for /l %%l in (0,1,!Point.Len!) do (if "!Tim.3:~-1!" == "0" set Tim.3=!Tim.3:~0,-1!)
	if "!Tim.3:~-1!" == "." set Tim.3=!Tim.3:~0,-1!
)
set %~3=!Tim.3!
goto :eof
:Division
if "%~3" == "" Goto :eof
setlocal
set Div.1=%~1
set Div.2=%~2
set Div.3=
set Dec.d=2
set Zer.O=00000000
for /l %%i in (1 1 7) do set Zer.O=!Zer.O!!Zer.O!
set Halving=4096 2048 1024 512 256 128 64 32 16 8 4 2 1
for /l %%i in (1 1 2) do (
	set i=0
	set Div.%%i.Len.2=0
	for %%j in (!Div.%%i:.^= !) do (
		set /a i+=1
		set jj=jj%%j
		set Div.%%i.Len.!i!=0
		for %%k in (!Halving!) do (
			if "!jj:~%%k!" neq "" (
				set /a Div.%%i.Len.!i!+=%%k
				set jj=!jj:~%%k!
			)
		)
		set /a Div.%%i.Len.0+=Div.%%i.Len.!i!
	)
        set Div.%%i=!Div.%%i:.=!
)
if !Div.1.Len.2! gtr !Div.2.Len.2! (
	set /a Div.2.Len.0+=Div.1.Len.2-Div.2.Len.2
) else (
	set /a Div.1.Len.0+=Div.2.Len.2-Div.1.Len.2
)
for /l %%i in (1 1 2) do (
	set Div.%%i=!Div.%%i!!Zer.O!
	for %%j in (!Div.%%i.Len.0!) do (
		set Div.%%i=!Div.%%i:~,%%j!
	)
)
for /f "tokens=* delims=0" %%i in ("!Div.2!") do (
	set N=%%i
	set Div.2=0%%i
)
set Div.2.Len.0=1
for %%j in (!Halving!) do (
	if "!N:~%%j!" neq "" (
		set /a Div.2.Len.0+=%%j
		set N=!N:~%%j!
	)
)
set /a Div.Len=Div.2.Len.0+1
if !Div.1.Len.0! lss !Div.2.Len.0! (
	set Div.1.Len.0=!Div.2.Len.0!
	set Div.1=!Zer.O:~-%Div.2.Len.0%,-%Div.1.Len.0%!!Div.1!
)
set /a Div.1.Len.0+=Dec.d
set Div.1=0!Div.1!!Zer.O:~,%Dec.d%!
set Div=!Div.1:~,%Div.2.Len.0%!
set i=0000000!Div.2!
set Div.O=!2:~11,2!
set /a Div.O.1=1040+1024
set /a Len=Div.2.Len.0+7
for /l %%i in (1 1 9) do (set T=0
	for /l %%j in (8 8 !Len!) do (
		set /a T=1!i:~-%%j,8!*%%i+T
        	set Num%%i=!T:~-8!!Num%%i!
		set /a T=!T:~,-8!-%%i
	)
	set Num%%i=!T!!Num%%i!
	set Num%%i=0000000!Num%%i:~-%Div.Len%!
)
for /l %%l in (!Div.2.Len.0! 1 !Div.1.Len.0!) do (
	set Div=!Zer.O!!Div!!Div.1:~%%l,1!
	set Div=!Div:~-%Div.Len%!
	if "!Div!" geq "!Div.2!" (
		set M=1
		set i=0000000!Div!
		for /l %%i in (2 1 9) do if !i! geq !Num%%i! set M=%%i
		set Div.3=!Div.3!!M!
		set Div=
		set T=0
		for %%i in (!M!) do (
			for /l %%j in (8 8 !Len!) do (
				set /a T=3!i:~-%%j,8!-1!Num%%i:~-%%j,8!-!T:~,1!%%2
				set Div=!T:~1!!Div!
              		 )
		)	
	) else set Div.3=!Div.3!0
)
if defined Dec.d if %Dec.d% gtr 0 set Div.3=!Div.3:~,-%Dec.d%!.!Div.3:~-%Dec.d%!
for /f "tokens=* delims=0" %%i in ("!Div.3!") do set Div.3=%%i
if not !%Div.O%! == !Div.O.1! Goto :eof
if "!Div.3:~0,1!"=="." set Div.3=0!Div.3!
endlocal & set %~3=%Div.3%
Goto :eof
Rem QQ:540044977 2015-11-22