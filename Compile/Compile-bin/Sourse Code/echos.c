#include <stdio.h>
#include <windows.h>
int main(int argc,char *argv[])
{
	char *p = new char[20];
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),strtol(argv[1],&p,16));
	for(int i=2;i<argc;i++){
		printf("%s ",argv[i]);
	}
	printf("\n");
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),0x07);
	return 0;
}
