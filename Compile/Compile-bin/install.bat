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
	echo;   -c: 	检查更新
	echo;   -vcc		安装本程序集合到指定目录[path]
	echo;      		其余显示此帮助信息
	exit /b
)

:check_update
	curl www.baidu.com 2>nul>nul || (
		echo;网络错误
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
		printf 0x07 "  - 当前是最新版本 "
		echos 0x0b %version% 
		echo;  - https://gitee.com%var1%
	) else (
		echo;  - 检测到当前不是最新版本,是否下载最新版本
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
	echos 0x03 请选择安装目录,安装目录不能包含空格
	call chooses input
	if "%input%"=="" (
		echos 0x0c 未选择安装目录
		popd
		exit /b
	)
	:input
	echo;安装目录:%input%
	xcopy .\Compile\ "%input%\Compile\" /e /y /h /r
	copy Termux.bat "%input%"
	exec.bat %input%
	popd
exit /b
::/E 复制目录和子目录，包括空的。/Y 取消提示以确认要覆盖现有目标文件 。/H 也复制隐藏和系统文件。/R 改写只读文件。 /Q 复制时不显示文件名。
