#include <windows.h>
#include <stdio.h>
#include<iostream>
#include <string>
using namespace std;
int main(int argc,char *argv[])
{
	if(argc>1){
		char *p;
		HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
		char num[]="-n";
		char time[]="-t";
		if (!strcmp(num,argv[1])){
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),strtol(argv[2],&p,16));
			for(int j=1;j<=atoi(argv[3]);j++){
				for(int i=4;i<argc;i++){
					printf("%s",argv[i]);
				}
			}
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),0x07);
			return 0;
		}
		if (!strcmp(time,argv[1])){
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),strtol(argv[2],&p,16));
			string s = argv[4];
			size_t COUNT = s.length();
			for (size_t i(0); i < COUNT; i += 1)
			{
				cout << s.substr(i,1);
				Sleep(atoi(argv[3]));
			}
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),0x07);
			return 0;
		}
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),strtol(argv[1],&p,16));
		for(int i=2;i<argc;i++){
			printf("%s",argv[i]);
		}
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),0x07);
		return 0;
	} else {
		printf("Usage: printf [color] [str] \n");
		printf("	or: printf [-n] [color] [number] [str] ������ʾ�ַ�������number \n");
		printf("	or: printf [-t] [color] [time] [str] ������ʾÿ���ַ��м���ʱ��time \n");
		printf("	or: printf �޲�����ʾ�˰�����Ϣ \n\n");
		printf("	color ������ɫ,��ʽ����0x0e,��ϸ����color /? \n");
		printf("	str �ַ��� \n");
		return 0;
	}
	
}

