@echo off
setlocal enabledelayedexpansion
if "%~1"=="-c" (
	call :exists %3
	if exist "!input!\Compile\Compile-bin\%~2" (
		set "file=!input!\Compile\Compile-bin\%~2"
	) else (
		set file=
		echos 0x03 请选择要同步的文件
		call choose file
		if "!file!"=="" (
			echos 0x0c 未选择要同步文件
			goto :end
		)
	)
	echo;[!file!]--^>[%~dp0]
	copy /y "!file!" "%~dp0"
) else (
	echo;Usage: cn 查看磁盘信息
	echo;   or: cn [arguments] {[-c]} [file] [path]
	echo;
	call :disk
)

:end
popd
set input=
set file=
exit /b

:exists
	if exist "%~1" (
		set "input=%~1"
	) else (
		set input=
		echos 0x03 请选择更新目录
		call chooses input
		if "!input!"=="" (
			echos 0x0c 未选择更新目录
			goto :end
		)
	)
exit /b

:disk
	>DiskCalc1.vbs echo WSCript.Echo "盘符" ^& Chr(9) ^& "总容量(GB)" ^& Chr(9) ^& "已用空间(GB)" ^& Chr(9) ^& "剩余空间(GB)" ^& Chr(9) ^& "使用率"
	>DiskCalc2.vbs echo DeviceID = Wscript.Arguments(0)
	>>DiskCalc2.vbs echo SizeAvail = Wscript.Arguments(1) / (1024 * 1024 * 1024)
	>>DiskCalc2.vbs echo SizeTotal = Wscript.Arguments(2) / (1024 * 1024 * 1024)
	>>DiskCalc2.vbs echo SizeUsed = SizeTotal - SizeAvail
	>>DiskCalc2.vbs echo SizeRate = SizeUsed / SizeTotal * 100
	>>DiskCalc2.vbs echo WSCript.Echo DeviceID ^& Chr(9) ^& Round(SizeTotal,1) ^& Chr(9) ^& Chr(9) ^& Round(SizeUsed,1) ^& Chr(9) ^& Chr(9) ^& _
	>>DiskCalc2.vbs echo Round(SizeAvail,1) ^& Chr(9) ^& Chr(9) ^& Round(SizeRate,1) ^& "%%"
	cscript //nologo DiskCalc1.vbs
	(for /f "tokens=1-3" %%a in ('wmic LogicalDisk get DeviceID ^, Size ^, FreeSpace ^| findstr ":"') do (
		set /a num+=1
		cscript //nologo DiskCalc2.vbs %%a %%b %%c
	))
	del DiskCalc*.vbs
exit /b
REM wmic LogicalDisk where "DeviceID='H:'" get DeviceID ^, Size ^, FreeSpace ^| findstr ":"
REM wmic LogicalDisk get DeviceID , Size , FreeSpace | findstr ":"


REM 1.查看磁盘信息：freedisk 可以查看每一个盘的剩余空间
wmic diskdrive >查看磁盘信息
REM 可以看出来牌子和大小.
Wmic logicaldisk >牌子和大小
REM 可以看到有几个盘，每一个盘的文件系统和剩余空间
wmic volume >每一个盘的文件系统和剩余空间
REM 每个盘的剩余空间量，其实上一个命令也可以查看的
fsutil volume diskfree c: >每一个卷的容量信息
REM 这个命令查看每一个卷的容量信息是很方便
REM 2.CPU信息
wmic cpu >CPU信息
REM 上面显示的有位宽，最大始终频率， 生产厂商，二级缓存等信息
REM 3.内存信息
    wmic memorychip >内存信息
REM 可以显示出来三条内存，两条256，一条1G的，速度400MHz
REM 4.BIOS信息
    wmic bios >BIOS信息
	
	
REM 查看主板上内存条的数量。
wmic memorychip list brief 或者 wmic MEMPHYSICAL list brief >内存条的数量
REM 查看cpu 
wmic cpu list brief >cpu 
REM 查看物理内存
wmic memphysical list brief >物理内存
REM 查看逻辑内存
wmic memlogical list brief >逻辑内存
REM 查看缓存内存
wmic memcache list brief >缓存内存
REM 查看虚拟内存
wmic pagefile list brief >虚拟内存
REM 查看网卡
wmic nic list brief >网卡
REM 查看网络协议
wmic netprotocal list brief >网络协议