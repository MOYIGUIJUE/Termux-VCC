#include <windows.h>
void MoveWindow(int posx, int posy)
{
    RECT rectClient, rectWindow;
    HWND hWnd = GetConsoleWindow();
    GetClientRect(hWnd, &rectClient);
    GetWindowRect(hWnd, &rectWindow);
    MoveWindow(hWnd, posx, posy, rectClient.right - rectClient.left, rectClient.bottom - rectClient.top, TRUE);
}
int main(int argc, char *argv[])
{
	if(argc>1){
		MoveWindow(atoi(argv[1]),atoi(argv[2]));
	} else {
		MoveWindow(0,0);
	}
    return 0;
}

/* char chCmd[32];
sprintf(chCmd,"mode con cols=%d lines=%d",height,width);
system(stCmd);
 */