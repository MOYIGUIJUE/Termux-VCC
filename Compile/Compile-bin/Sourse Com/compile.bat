@echo off
cd /d %~dp1
echos 0x03 "���ڱ���[%~nx1]���Ժ�..."
if "%~x1" == ".cpp" (
	echos 0x0e "g++ \"%~nx1\" -o \"%~n1\" %lwsock32%"
	g++ "%~nx1" -o "%~n1" %lwsock32% && ( echos 0x0a ====����ɹ�==== & exit /b 1 ) || ( echos 0x0c ====����ʧ��==== & exit /b 0 )
) Else if /i "%~x1" == ".c" (
	echos 0x0e "gcc \"%~nx1\" -o \"%~n1\" %lwsock32%"
	call gcc "%~nx1" -o "%~n1" %lwsock32% && ( echos 0x0a ====����ɹ�==== & exit /b 1 ) || ( echos 0x0c ====����ʧ��==== & exit /b 0 )
) Else ( exit /b 404 )
