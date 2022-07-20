#include <windows.h>
int main(int argc,char *argv[])
{
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE); 
	// 获取标准输出设备句柄
	//SetConsoleTitle("mode");// 窗口标题
	//CONSOLE_SCREEN_BUFFER_INFO bInfo; // 窗口缓冲区信息
	SMALL_RECT rc = {0,0,atoi(argv[1]),atoi(argv[2])}; // 重置窗口位置和大小
	// 获取窗口缓冲区信息
	COORD size = {atoi(argv[1])+1,200};
	SetConsoleWindowInfo(hOut,true ,&rc);
	SetConsoleScreenBufferSize(hOut,size); // 重新设置缓冲区大小
	SetConsoleWindowInfo(hOut,true ,&rc);
	return 0; 
} 
