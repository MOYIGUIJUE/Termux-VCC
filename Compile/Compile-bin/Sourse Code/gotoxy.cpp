#include <stdio.h>
#include <windows.h>
#include <stdlib.h>
using namespace std;

int main(int argc,char *argv[])
{
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	COORD coordScreen = {0, 0}; //¹â±êÎ»ÖÃ
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	if(argc>1){
		if(!strcmp(argv[1],"-l")){
			HANDLE hout;
			COORD coord;
			coord.X = atoi(argv[2]);
			coord.Y = atoi(argv[3]);
			hout = GetStdHandle(STD_OUTPUT_HANDLE);
			SetConsoleCursorPosition(hout, coord);
		} else {
			if (GetConsoleScreenBufferInfo(hConsole, &csbi))
			{
				HANDLE hout;
				COORD coord;
				coord.X = csbi.dwCursorPosition.X + atoi(argv[1]);
				coord.Y = csbi.dwCursorPosition.Y + atoi(argv[2]);
				hout = GetStdHandle(STD_OUTPUT_HANDLE);
				SetConsoleCursorPosition(hout, coord);
			}
		}
	} else {
		if (GetConsoleScreenBufferInfo(hConsole, &csbi))
			return csbi.dwCursorPosition.X;
	}
	return csbi.dwCursorPosition.Y;
}
