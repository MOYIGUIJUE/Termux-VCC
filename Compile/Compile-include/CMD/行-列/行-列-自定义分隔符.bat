@echo off
setlocal enabledelayedexpansion
for /F "tokens=* delims=" %%i in (1.txt) DO  (
	echo;%%i
    set "Temp_str=%%i"
)
:Split_str
for /F "tokens=1* delims= " %%i in ("!Temp_str!") DO (      
	set "char=%%i"
	REM echo;!Temp_str!
	REM echo;if "%%j"=="" 
    if "%%j"=="" (
        echo;!char!
		exit /b
    ) else (
        set "Temp_str=%%j"
        echo !char!
        goto :Split_str
    )
)




