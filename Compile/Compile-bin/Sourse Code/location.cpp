#include <windows.h>
#include<stdio.h>

int main(int argc, char *argv[])
{
	RECT rect; 
	//HWND hWnd = GetConsoleWindow();
    HWND hWnd=GetForegroundWindow();
	GetWindowRect(hWnd,&rect); 
	if(argc>1){
		int size_two=rect.top;
		int size_three=rect.right-rect.left;
		int size_four=rect.bottom-rect.top;
		if( argv[2] != NULL ) {
			size_two=atoi(argv[2]);
			if( argv[3] != NULL ) {
				size_three=atoi(argv[3]);
				if( argv[4] != NULL ) size_four=atoi(argv[4]);
			}
		}
		MoveWindow(hWnd,atoi(argv[1]),size_two,size_three,size_four,TRUE); 
	} else {
		printf("%d,%d,%d,%d",rect.left,rect.top,rect.right,rect.bottom);
	}
    return 0;
}
