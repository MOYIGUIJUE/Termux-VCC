#include <windows.h>
#include <stdio.h>
int main(int argc,char *argv[])
{
	char *p;
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),strtol(argv[1],&p,16));
	for(int j=1;j<=atoi(argv[2]);j++){
		for(int i=3;i<argc;i++){
			printf("%s",argv[i]);
		}
	}
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),0x07);
	return 0;
}

