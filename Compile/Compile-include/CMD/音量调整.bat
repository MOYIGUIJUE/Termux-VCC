' 2>nul&cls&@echo off&setlocal enabledelayedexpansion&mode 30,10
':1
' 2>nul&cls
' 2>nul&echo          + 增加音量
' 2>nul&echo          - 减少音量
' 2>nul&echo          0 静音开关
' 2>nul&set "key="
' 2>nul&for /f "delims=" %%a in ('xcopy /w . 2^>nul') do if not defined key set "key=%%a"
' 2>nul&if "!key:~-1!" == "+" (cscript -nologo -e:vbscript "%~f0" 棷)
' 2>nul&if "!key:~-1!" == "-" (cscript -nologo -e:vbscript "%~f0" 棶)
' 2>nul&if "!key:~-1!" == "0" (cscript -nologo -e:vbscript "%~f0" 棴)
' 2>nul&echo 
' 2>nul&goto :1

Set s = CreateObject("Wscript.Shell")
Set objArgs = WScript.Arguments
For x = 0 to objArgs.Count - 1
    s.sendkeys objArgs(x)
    s.sendkeys objArgs(x)
    s.sendkeys objArgs(x)
    s.sendkeys objArgs(x)
    s.sendkeys objArgs(x)
Next
