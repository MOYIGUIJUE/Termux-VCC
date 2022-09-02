@echo off & title &cls
modes 87 20
colors 0x70
more +15 %~dpnx0
colors 0x07
modes 89 22
set .=
set /p ".=%used%@%COMPUTERNAME%[%cd%]$ " 
REM printf 0x0a %used%@%COMPUTERNAME%
REM printf 0x09 [%cd%]
REM printf 0x07 "$ "
REM set /p.=
%.%
set .=
exit /b
.
                 ______                                               
                /_  __/__  _________ ___  __  ___  __                 
                 / / / _ \/ ___/ __ `__ \/ / / / |/_/                 
                / / /  __/ /  / / / / / / /_/ />  <                   
               /_/  \___/_/  /_/ /_/ /_/\__,_/_/|_|                   
.                                                                     
.                                                                     