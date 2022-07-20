@echo off & setlocal enabledelayedexpansion & mode con cols=54 lines=6
chcp 936 & rem Only tested under Chinese Simplified
set "sp=¡¡" & set "cc=¡ö!sp!"
for %%a in (4 1 2 1 2 1 4 2 1 2 1 2 1 2 1 2 4 2 5 2 6 2 4 2 5 1 2
1 4 2 1 2 5 2 3 2 8 2 4 1 7 2 1 2 1 2 1 2 5 1 5 1 8 1 4 2 4) do (
  set "cc=!cc:~-1!!cc:~0,1!"
  for /l %%i in (1,1,%%a) do set "dgts=!dgts!!cc:~-1!"
)
for /l %%z in () do (
  if "!time:~7,1!" neq "!sec!" (
    set "sec=!time:~7,1!" & set "oc="
    for /l %%h in (0,1,4) do (
      for %%d in (0 sp 1 sp : sp 3 sp 4 sp : sp 6 sp 7) do (
        if "%%d"==":" (set /a "tt=%%h&1"&if "!tt!"=="0" (set oc=!oc!!sp!) else set oc=!oc!¡ñ) else (
          if "%%d"=="sp" (set oc=!oc!!sp!) else (
            set "timeP=!time: =0!"&set /a s=!timeP:~%%d,1!*15+%%h*3
            for %%o in (!s!) do set "oc=!oc!!dgts:~%%o,3!"
))))&cls & set /p=!oc!<nul))


:::::::::::::::::Old:::::::::::::::::::

@echo off & setlocal enabledelayedexpansion & mode con cols=27 lines=6 & color 0a
set "cc=# "
for %%a in (4 1 2 1 2 1 4 2 1 2 1 2 1 2 1 2 4 2 5 2 6 2 4 2 5 1 2
1 4 2 1 2 5 2 3 2 8 2 4 1 7 2 1 2 1 2 1 2 5 1 5 1 8 1 4 2 4) do (
  set "cc=!cc:~-1!!cc:~0,1!"
  for /l %%i in (1,1,%%a) do set "dgts=!dgts!!cc:~-1!"
)
for /l %%z in (0 0 0) do (
  if "!time:~7,1!" neq "!sec!" (
    set "sec=!time:~7,1!" & set "oc="
    for /l %%h in (0,1,4) do (
      for %%d in (0 sp 1 sp : sp 3 sp 4 sp : sp 6 sp 7) do (
        if "%%d"==":" (set /a "tt=%%h&1"&if "!tt!"=="0" (set oc=!oc! ) else set oc=!oc!*) else (
          if "%%d"=="sp" (set oc=!oc! ) else (
            set "timeP=!time: =0!"&set /a s=!timeP:~%%d,1!*15+%%h*3
            for %%o in (!s!) do set "oc=!oc!!dgts:~%%o,3!"
))))&cls & set /p=!oc!<nul))