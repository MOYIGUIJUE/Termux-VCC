#include<iostream>
#include <string>
#include <windows.h>
using namespace std;
int main(int argc,char *argv[])
{
	char *p;
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),strtol(argv[1],&p,16));
    string s = argv[3];
    size_t COUNT = s.length();
    for (size_t i(0); i < COUNT; i += 1)
    {
        cout << s.substr(i,1);
		Sleep(atoi(argv[2]));
    }
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),0x07);
    return 0;
}
