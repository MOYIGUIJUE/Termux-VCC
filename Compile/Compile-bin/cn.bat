@echo off
setlocal enabledelayedexpansion
if "%~1"=="-c" (
	call :exists %3
	if exist "!input!\Compile\Compile-bin\%~2" (
		set "file=!input!\Compile\Compile-bin\%~2"
	) else (
		set file=
		echos 0x03 ��ѡ��Ҫͬ�����ļ�
		call choose file
		if "!file!"=="" (
			echos 0x0c δѡ��Ҫͬ���ļ�
			goto :end
		)
	)
	echo;[!file!]--^>[%~dp0]
	copy /y "!file!" "%~dp0"
) else (
	echo;Usage: cn �鿴������Ϣ
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
		echos 0x03 ��ѡ�����Ŀ¼
		call chooses input
		if "!input!"=="" (
			echos 0x0c δѡ�����Ŀ¼
			goto :end
		)
	)
exit /b

:disk
	>DiskCalc1.vbs echo WSCript.Echo "�̷�" ^& Chr(9) ^& "������(GB)" ^& Chr(9) ^& "���ÿռ�(GB)" ^& Chr(9) ^& "ʣ��ռ�(GB)" ^& Chr(9) ^& "ʹ����"
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


REM 1.�鿴������Ϣ��freedisk ���Բ鿴ÿһ���̵�ʣ��ռ�
wmic diskdrive >�鿴������Ϣ
REM ���Կ��������Ӻʹ�С.
Wmic logicaldisk >���Ӻʹ�С
REM ���Կ����м����̣�ÿһ���̵��ļ�ϵͳ��ʣ��ռ�
wmic volume >ÿһ���̵��ļ�ϵͳ��ʣ��ռ�
REM ÿ���̵�ʣ��ռ�������ʵ��һ������Ҳ���Բ鿴��
fsutil volume diskfree c: >ÿһ�����������Ϣ
REM �������鿴ÿһ�����������Ϣ�Ǻܷ���
REM 2.CPU��Ϣ
wmic cpu >CPU��Ϣ
REM ������ʾ����λ�����ʼ��Ƶ�ʣ� �������̣������������Ϣ
REM 3.�ڴ���Ϣ
    wmic memorychip >�ڴ���Ϣ
REM ������ʾ���������ڴ棬����256��һ��1G�ģ��ٶ�400MHz
REM 4.BIOS��Ϣ
    wmic bios >BIOS��Ϣ
	
	
REM �鿴�������ڴ�����������
wmic memorychip list brief ���� wmic MEMPHYSICAL list brief >�ڴ���������
REM �鿴cpu 
wmic cpu list brief >cpu 
REM �鿴�����ڴ�
wmic memphysical list brief >�����ڴ�
REM �鿴�߼��ڴ�
wmic memlogical list brief >�߼��ڴ�
REM �鿴�����ڴ�
wmic memcache list brief >�����ڴ�
REM �鿴�����ڴ�
wmic pagefile list brief >�����ڴ�
REM �鿴����
wmic nic list brief >����
REM �鿴����Э��
wmic netprotocal list brief >����Э��