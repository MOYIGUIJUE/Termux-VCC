#include <windows.h>
#include<stdio.h>

int main(int argc, char *argv[])
{
	RECT rect; 
	HWND hWnd = GetConsoleWindow();
	//HANDLE hWnd = GetStdHandle(STD_OUTPUT_HANDLE);
    //HWND hWnd=GetForegroundWindow();
	GetWindowRect(hWnd,&rect); 
	if( argc>1 && argc<6 ){
		int size_one=rect.left;
		int size_two=rect.top;
		int size_three=rect.right-rect.left;
		int size_four=rect.bottom-rect.top;
		if( argv[1] != NULL ) {
			if( atoi(argv[1]) >= 0 ) size_one=atoi(argv[1]);
			if( argv[2] != NULL ) {
				if( atoi(argv[2]) >= 0 ) size_two=atoi(argv[2]);
				if( argv[3] != NULL ) {
					size_three=atoi(argv[3]);
					if( argv[4] != NULL ) size_four=atoi(argv[4]);
				}
			}
		}
		MoveWindow(hWnd,size_one,size_two,size_three,size_four,TRUE); 
		//[句柄,左上角横坐标(X),左上角竖坐标(Y),窗口宽度(width),窗口高度(height),值为真]
	} else {
		printf("%d,%d,%d,%d",rect.left,rect.top,rect.right,rect.bottom);
	}
    return 0;
}
