@echo off
setlocal enabledelayedexpansion
if "%~1" == "-vcc" (
	goto :vcc
) else if "%~1" == "-c" (
	goto :check_update
) else if "%~1" == "-v" (
	goto :show_update
) else if "%~1" == "-d" (
	goto :down_update
) else (
	echo;Usage: install [arguments] {[-c][-d]} 
	echo;   or: install [arguments] {[-vcc]} [path]
	echo;&echo;Arguments:
	echo;   -c: 	检查更新
	echo;   -d: 	更新
	echo;   -vcc		安装本程序集合到指定目录[path]
	echo;      		其余显示此帮助信息
	exit /b
)

:show_update
	printf 0x10 " GITEE "
	set /p dates_install=<%Temp%\%dates:/=-%.install
	echo; %dates_install%
	call vcc -v >nul
	printf 0x20 " LOCAL "
	pushd %~dp0..\..
	echo; SOURSE PATH IS [%CD%]
	popd
	echo;
	if "TERMUX-VCC-%version%"=="%dates_install%" (
		echo;  - 当前版本: %version%
	) else (
		echo;  - 当前版本: %version%
		echo;  - 检测到当前不是最新版本,请下载最新版本[install -d]
		echo;  - https://gitee.com/cctv3058084277/main/releases/tag/TERMUX-VCC
	)
	echo;
	echo;  Open sourse at:
	printf 0x07 "  - Gitee: "
	printf 0x03 https://gitee.com/cctv3058084277/main
	echo;
	printf 0x07 "  - Github: "
	printf 0x03 https://github.com/MOYIGUIJUE/cctv
	echo;
exit /b

:check_update
	curl www.baidu.com 2>nul>nul || (
		printf 0xc0 " ERROR "
		echo; 未连接网络
		exit /b
	)
	set num=1
	for /f "delims=" %%i in ('curl https://gitee.com/cctv3058084277/main/releases/tag/TERMUX-VCC 2^>nul ^
	 ^| sed "s/}/\n/g" ^| findstr /i "download_url tag_path" ^|sed "s/:/\n/g;s/,/\n/g" ^| sed -n "4p;36p"') do (
		set "var!num!=%%~i"
		set /a num+=1
	)
	call vcc -v >nul
	printf 0x10 " GITEE "
	echo; %var1%
	set dates=%date:~0,-3%
	del /f /q %Temp%\*.install 2>nul >nul
	echo;%var1%>%Temp%\%dates:/=-%.install
	printf 0x20 " LOCAL "
	echo; SOURSE PATH IS [%VCC_HOME%]
	echo;
	if "TERMUX-VCC-%version%"=="%var1%" (
		echo;  - 当前版本: %version% -
	) else (
		echo;  - 当前版本: %version% -
		echo;  - 检测到当前不是最新版本,请下载最新版本[install -d]
		echo;  - https:/%var2:"=%
	)
	echo;
	echo;  Open sourse at:
	printf 0x07 "  - Gitee: "
	printf 0x03 https://gitee.com/cctv3058084277/main
	echo;
	printf 0x07 "  - Github: "
	printf 0x03 https://github.com/MOYIGUIJUE/cctv
	echo;
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
	xcopy .\FILE\ "%input%\FILE\" /e /y /h /r
	copy Termux.bat "%input%"
	call exec.bat %input%
	start cmd /c "termux FILE"
	popd
exit /b
::/E 复制目录和子目录，包括空的。/Y 取消提示以确认要覆盖现有目标文件 。/H 也复制隐藏和系统文件。/R 改写只读文件。 /Q 复制时不显示文件名。

:down_update
	curl www.baidu.com 2>nul>nul || (
		echo;
		printf 0xc0 " ERROR "
		echo; 未连接网络
		exit /b
	)
pushd "%temp%"
if exist TERMUX-VCC.7z del /f /q TERMUX-VCC.7z
call down https://gitee.com/cctv3058084277/cctvpage1/releases/download/TERMUX-VCC/TERMUX-VCC.7z
call 7z x .\TERMUX-VCC.7z -o.\termux -aoa
call .\termux\termux.bat /u
popd