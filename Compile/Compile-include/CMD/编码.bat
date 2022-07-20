@echo off
echo. 测试编码为ANSI，这行内容自动转换为ANSI编码>>ANSI.txt
echo. utf>>UTF-8.txt
powershell.exe -command "dir *.txt -R|foreach-object{(Get-Content $_.FullName -Encoding Default) | Set-Content $_.FullName -Encoding UTF8 };Write-Host '转换完成...'"
pause
