@echo off
setlocal enabledelayedexpansion
if "%~1" == "-vcc" (
	goto :vcc
) else if "%~1" == "-c" (
	goto :check_update
) else (
	echo;Usage: install [arguments] {[-c]} {[-v][-d]}
	echo;   or: install [arguments] {[-vcc]} [path]
	echo;&echo;Arguments:
	echo;   -c: 	������
	echo;   -vcc		��װ�����򼯺ϵ�ָ��Ŀ¼[path]
	echo;      		������ʾ�˰�����Ϣ
	exit /b
)

:check_update
	curl www.baidu.com 2>nul>nul || (
		echo;�������
		exit /b
	)	
	set num=1
	for /f "delims=" %%i in ('curl https://gitee.com/cctv3058084277/main/releases/tag/TERMUX-VCC 2^>nul ^
	 ^| sed "s/}/\n/g" ^| find /i "download_url" ^|sed "s/:/\n/g;s/,/\n/g" ^| sed -n "4p;6p"') do (
		set "var!num!=%%~i"
		set /a num+=1
	)
	call vcc -v >nul
	echo;
	printf 0x10 " GITEE "
	echos 0x07 " %var2%"
	printf 0x20 " LOCAL "
	echos 0x03 " TERMUX-VCC-%version%.exe"
	echo;
	if "TERMUX-VCC-%version%.exe"=="%var2%" ( 
		printf 0x07 "  - ��ǰ�����°汾 "
		echos 0x0b %version% 
		echo;  - https://gitee.com%var1%
	) else (
		echo;  - ��⵽��ǰ�������°汾,�Ƿ��������°汾
		start https://gitee.com/cctv3058084277/main/releases/tag/TERMUX-VCC
		pause >nul
		pushd %~dp0..\..
			echo;  - down https://gitee.com... - !cd!
			down https://gitee.com%var1%
			TERMUX-VCC-%version%.exe
		popd
	)
exit /b



:vcc
	pushd %~dp0..\..
	if exist "%~2" (
		set "input=%~2"
		goto :input
	)
	set input=
	echos 0x03 ��ѡ��װĿ¼,��װĿ¼���ܰ����ո�
	call chooses input
	if "%input%"=="" (
		echos 0x0c δѡ��װĿ¼
		popd
		exit /b
	)
	:input
	echo;��װĿ¼:%input%
	xcopy .\Compile\ "%input%\Compile\" /e /y /h /r
	copy Termux.bat "%input%"
	exec.bat %input%
	popd
exit /b
::/E ����Ŀ¼����Ŀ¼�������յġ�/Y ȡ����ʾ��ȷ��Ҫ��������Ŀ���ļ� ��/H Ҳ�������غ�ϵͳ�ļ���/R ��дֻ���ļ��� /Q ����ʱ����ʾ�ļ�����
