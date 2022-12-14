@echo off
if /i "%~1"=="-h" (
	cd /d %~dp0..\..
) else if /i "%~1"=="-" ( 
	cd /d %~dp0 
) else if /i "%~1"=="-b" ( 
	cd /d %~dp0..\Compile-include
) else if /i "%~1"=="-c" ( 
	cd /d %~dp0Sourse Code
) else if /i "%~1"=="-d" (
	cd /d %Desk%
) else if /i "%~1"=="-l" (
	cd /d E:\MAIN\CCTV_History
) else if /i "%~1"=="-v" (
	goto :version
) else if /i "%~1"=="-t" (
	cd /d %~dp0..\home
) else (
	echo;Usage: vcc [arguments] -h	跳转vcc_home目录
	echo;   or: vcc [arguments] -	跳转vcc外部扩展命令目录
	echo;   or: vcc [arguments] -c	跳转vcc外部扩展命令源码目录
	echo;   or: vcc [arguments] -b	跳转vcc未启用外部扩展命令源码目录
	echo;   or: vcc [arguments] -d	跳转桌面目录并且复制桌面路径到剪切板
	echo;   or: vcc [arguments] -l	跳转备份文件目录
	echo;   or: vcc [arguments] -t	跳转home测试目录
	echo;   or: vcc [arguments] -v	查看版本信息
	echo;   or: vcc 其他都显示帮助信息
	echo;&echo;If time could stop at the moment when we first met
)
exit /b

:version
for /f "delims=:" %%a in ('findstr /n "splitline.*$" %~fs0') do set "split=%%a"
for /f "tokens=2 delims=|" %%i in ('more +%split% %~dpnx0') do set version=%%i
set "version=%version: =%"
echo;  - vcc version %version% 
printfs "  - Sourse Path: "
pushd %~dp0..\..
echos 0x03 %cd%
popd
set split=
exit /b 
rem ------------------------------------------
REM C:\WINDOWS\system32\drivers\etc\hosts
REM thisisunsafe 跳过证书
REM 192.168.111.222(网关，DNS服务器)
REM ping github.com
REM nslookup github.com 202.96.134.133
REM nslookup github.com 192.168.111.222
REM nslookup wangyueblog.com 8.8.8.8
REM 140.82.113.4 github.com (host)
REM ws://127.0.0.1:6800/jsonrpc 
REM aria2c.exe --conf-path=aria2.conf
::::splitline:::::
2022/05/30 20:32:30 2022-05-30.7z | 0.0.4 
2022/06/01 23:54:14 2022-06-01-To_Client.7z | 0.1.2 
2022/06/09 19:53:32 2022-06-09-desk.7z | 0.1.7 
2022/06/11 13:49:44 2022-06-11-gcc.zip | 0.1.9 
2022/06/11 15:59:11 2022-06-11-exec_gcc.7z | 0.2.0 
2022/06/11 20:33:46 2022-06-11-cm.7z | 0.2.1 
2022/06/11 21:18:21 2022-06-11-cm2.7z | 0.2.2 
2022/06/12 12:43:50 2022-06-12-exec.7z | 0.2.3 
2022/06/12 22:31:41 2022-06-12-termux.7z | 0.2.4 
2022/06/13  1:09:32 2022-06-13-vcc.7z | 0.2.5 
2022/06/13  1:27:18 2022-06-13-com.7z | 1.0.1 
2022/06/13 18:28:43 2022-06-13-vim.7z | 1.0.2 
2022/06/19 16:28:10 2022-06-19.7z | 1.0.4 
2022/06/21 18:13:10 2022-06-21.7z | 1.0.5 
2022/06/22 21:57:47 2022-06-22.7z | 1.0.6 
 15:46:34 | 1.0.7 
2022/06/23 16:03:12 | 1.0.8 
2022/06/23 16:26:16 | 1.0.9 
2022/06/23 18:53:07 update-vcc | 1.1.0 
2022/06/23 19:13:59 helps | 1.1.1 
2022/06/23 19:17:20 helps | 1.1.2 
2022/06/23 19:21:25 helps | 1.1.3 
2022/06/23 19:27:22 helps | 1.1.4 
2022/06/23 20:31:10 helps | 1.1.5 
2022/06/23 20:36:27 vcc | 1.1.6 
2022/06/23 20:54:28 update | 1.1.7 
2022/06/23 20:56:35 update | 1.1.8 
2022/06/23 20:57:47 update | 1.1.9 
2022/06/23 21:00:03 update | 1.2.0 
2022/06/23 21:01:17 update | 1.2.1 
2022/06/23 21:03:49 update | 1.2.2 
2022/06/23 21:05:20 update | 1.2.3 
2022/06/23 21:16:58 test | 1.2.4 
2022/06/23 21:17:57 test | 1.2.5 
2022/06/23 21:19:16 test | 1.2.6 
2022/06/23 21:21:07 test | 1.2.7 
2022/06/23 21:32:27 test | 1.2.8 
2022/07/19 17:42:28 2022-07-19.7z | 1.2.9 
2022/07/29 12:54:52 2022-07-29helpme.7z | 1.3.0 
2022/09/03 15:38:45 2022-09-03.7z | 1.3.1 
2022/09/03 23:37:33 2022-09-03-CLR.7z | 1.3.2 
2022/09/04  2:00:54 2022-09-04-FL.zip | 1.3.3 
2022/09/04 23:16:41 2022-09-04.zip | 1.3.4 
2022/09/06 14:59:47 2022-09-06-1.3.5.7z | 1.3.5 
2022/09/09 16:43:56 2022-09-09-cn.zip | 1.3.6 
2022/09/14 12:11:37 2022-09-14.7z | 1.3.7 
2022/09/20 23:31:45 2022-09-20.7z | 1.3.8 
2022/09/20 23:42:27 2022-09-20-termux.7z | 1.3.8 
2022/09/25 22:02:42 2022-09-25simple.7z | 1.3.9 
2022/09/28 23:05:33 2022-09-28.7z | 1.4.0 
2022/10/10 16:28:21 2022-10-10.7z | 1.4.1 
2022/10/11 17:21:05  | 1.4.2 
2022/10/14 16:29:00  | 1.4.3 
2022/10/20 21:49:02  | 1.4.4 
2022/10/23  1:13:47 2022-10-23-fc_printf.7z | 1.4.5 
2022/10/24 19:46:15  | 1.4.6 
2022/10/28 19:15:43  | 1.4.7 
