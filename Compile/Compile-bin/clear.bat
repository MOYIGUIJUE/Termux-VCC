@echo off & title &cls
modes 87 20
colors 0x70
more +11 %~dpnx0
colors 0x07
modes 89 22
set .=
set /p ".=%used%@%COMPUTERNAME%[%cd%]$ " 
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