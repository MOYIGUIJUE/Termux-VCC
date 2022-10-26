@echo off 

echo(%~1|findstr "^[-][1-9][0-9]*$ ^[1-9][0-9]*$ ^0$">nul || (
	echo;Uage:  %~n0 [time] - 间隔时间^(单位:毫秒^)
	exit /b
)

echo;@echo off > %tmp%\settopmost.cmd
echo;:loop >> %tmp%\settopmost.cmd
echo;nircmd win settopmost handle %%1 1 >> %tmp%\settopmost.cmd
if not %1 EQU 0 echo;Sleep %%2 >> %tmp%\settopmost.cmd
echo;goto loop >> %tmp%\settopmost.cmd

for /f "tokens=1,2 delims=," %%i in ('topmost -') do start cmd /c "%tmp%\settopmost.cmd %%i %1"
exit /b
