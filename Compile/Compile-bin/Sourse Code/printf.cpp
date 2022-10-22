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
		char scale[] = "-a";//进制
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
		printf("	or: printf [-n] [color] [number] [str] 设置显示字符串次数number \n");
		printf("	or: printf [-t] [color] [time] [str] 设置显示每个字符中间间隔时间time \n");
		printf("	or: printf [-a] [scale] [number] 进制[2-36]进制,数字 \n");
		printf("	or: printf 无参数显示此帮助信息 \n\n");
		printf("	color 字体颜色,格式比如0x0e,详细参照color /? \n");
		printf("	str 字符串 \n");
		return 0;
	}

}

