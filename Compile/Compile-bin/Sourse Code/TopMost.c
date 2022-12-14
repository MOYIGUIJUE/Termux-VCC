#include <windows.h>
#include<stdio.h>
int main(int argc, char *argv[])
{
	//HWND hWnd = ::GetForegroundWindow();
	HWND hWnd = GetConsoleWindow();
	//HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	if( argc == 2 ) { printf("%d,%X",hWnd,hWnd); return 0; } //打印控制台窗口句柄
	SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 100, 100, SWP_NOMOVE | SWP_NOSIZE);
	return 0;
}

/* void TopWindow(HWND &hWnd) {
	SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
}
int main() {
	HWND hWnd=GetForegroundWindow();
	while(1){
		TopWindow(hWnd);
		Sleep(100);
	}
} 

//将当前线程附到新的置顶线程上，再置顶
#include <windows.h>

// windows置顶窗体终极方案

BOOL OnForceShow(HWND hWnd)
{
	HWND hForeWnd = NULL;
	DWORD dwForeID = 0;
	DWORD dwCurID = 0;

	hForeWnd = ::GetForegroundWindow();
	dwCurID = ::GetCurrentThreadId();
	dwForeID = ::GetWindowThreadProcessId(hForeWnd, NULL);
	::AttachThreadInput(dwCurID, dwForeID, TRUE);
	::ShowWindow(hWnd, SW_SHOWNORMAL);
	::SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE);
	::SetWindowPos(hWnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE);
	::SetForegroundWindow(hWnd);
	// 将前台窗口线程贴附到当前线程（也就是程序A中的调用线程）
	::AttachThreadInput(dwCurID, dwForeID, FALSE);

	return TRUE;
}


int main(int argc, char *argv[])
{

	HWND hWnd = ::GetForegroundWindow();
	if (OnForceShow(hWnd))
		return TRUE;

	::SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 100, 100, SWP_NOMOVE | SWP_NOSIZE);
	return FALSE;
}


*/