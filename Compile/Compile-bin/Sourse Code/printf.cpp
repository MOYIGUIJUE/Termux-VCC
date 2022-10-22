#include <windows.h>
#include <stdio.h>
#include<iostream>
#include <string>
#include <bitset>
using namespace std;
int main(int argc, char* argv[])
{
	if (argc > 1) {
		//char* p  ;
		HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
		char num[] = "-n";
		char time[] = "-t";
		char scale[] = "-a";//����
		WORD w = atoi(argv[2]);
		if (!strcmp(num, argv[1])) {
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), w);
			for (int j = 1; j <= atoi(argv[3]); j++) {
				for (int i = 4; i < argc; i++) {
					printf("%s", argv[i]);
				}
			}
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 0x07);
			return 0;
		}
		if (!strcmp(time, argv[1])) {
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), w);
			string s = argv[4];
			size_t COUNT = s.length();
			for (size_t i(0); i < COUNT; i += 1)
			{
				cout << s.substr(i, 1);
				Sleep(atoi(argv[3]));
			}
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 0x07);
			return 0;
		}
		if (!strcmp(scale, argv[1])) {
			char* stop = new char [20];
			long ans = strtol(argv[3], &stop, atoi(argv[2]));
			printf("HEX: %X\n", ans);
			printf("DEC: %d\n", ans);
			cout << "OCT: " << oct << ans << endl;
			//char s[16];
			//itoa(ans, s, 2);
			//printf("BIN %s\n", s);
			cout << "BIN: " << bitset<10>(ans) << endl;
			return 0;
		}
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), w);
		for (int i = 2; i < argc; i++) {
			printf("%s", argv[i]);
		}
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 0x07);
		return 0;
	}
	else {
		printf("Usage: printf [color] [str] \n");
		printf("	or: printf [-n] [color] [number] [str] ������ʾ�ַ�������number \n");
		printf("	or: printf [-t] [color] [time] [str] ������ʾÿ���ַ��м���ʱ��time \n");
		printf("	or: printf [-a] [scale] [number] ����[2-36]����,���� \n");
		printf("	or: printf �޲�����ʾ�˰�����Ϣ \n\n");
		printf("	color ������ɫ,��ʽ����0x0e,��ϸ����color /? \n");
		printf("	str �ַ��� \n");
		return 0;
	}

}

