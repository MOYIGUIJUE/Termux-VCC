@echo off
echo. ���Ա���ΪANSI�����������Զ�ת��ΪANSI����>>ANSI.txt
echo. utf>>UTF-8.txt
powershell.exe -command "dir *.txt -R|foreach-object{(Get-Content $_.FullName -Encoding Default) | Set-Content $_.FullName -Encoding UTF8 };Write-Host 'ת�����...'"
pause
