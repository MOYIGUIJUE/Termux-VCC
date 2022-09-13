#include <windows.h>
#include <stdio.h>

BOOL CALLBACK EnumWindowsProc(_In_ HWND hwnd, _In_ LPARAM Lparam)
{
	HWND hDefView = FindWindowExW(hwnd, 0, L"SHELLDLL_DefView", 0);
	if (hDefView != 0) {
		// 找它的下一个窗口，类名为WorkerW，隐藏它
		HWND hWorkerw = FindWindowExW(0, hwnd, L"WorkerW", 0);
		ShowWindow(hWorkerw, SW_HIDE);

		return FALSE;
	}
	return TRUE;
}

/* int main(int argc, char *argv[])
{
	// 视频路径、1920和1080，要根据实际情况改。建议使用GetSystemMetrics函数获取分辨率属性
	LPCWSTR lpParameter = L" .\\video.mp4  -noborder -x 1920 -y 1080 -loop 0";
	STARTUPINFOW si{ 0 };
	PROCESS_INFORMATION pi{ 0 };

	// 下面是我电脑上ffplay的路径，要根据实际情况改 
	if (CreateProcessW(L".\\ffmpeg-n5.1-latest-win64-lgpl-5.1\\bin\\ffplay.exe", (LPWSTR)lpParameter, 0, 0, 0, 0, 0, 0, &si, &pi))
	{
		Sleep(2500);												// 等待视频播放器启动完成。可用循环获取窗口尺寸来代替Sleep()

		HWND hProgman = FindWindowW(L"Progman", 0);				// 找到PM窗口
		SendMessageTimeout(hProgman, 0x52C, 0, 0, 0, 100, 0);	// 给它发特殊消息
		HWND hFfplay = FindWindowW(L"SDL_app", 0);				// 找到视频窗口
		SetParent(hFfplay, hProgman);							// 将视频窗口设置为PM的子窗口
		EnumWindows(EnumWindowsProc, 0);						// 找到第二个WorkerW窗口并隐藏它
	}

	return 0;
} */

int main(int argc, char *argv[])
{
	HWND hProgman = FindWindowW(L"Progman", 0);				// 找到PM窗口
	SendMessageTimeout(hProgman, 0x52C, 0, 0, 0, 100, 0);	// 给它发特殊消息
	HWND hFfplay = FindWindowW(L"matrix", 0);				// 找到视频窗口
	SetWindowLong(hFfplay, GWL_STYLE,GetWindowLong(hFfplay, GWL_STYLE) & ~(WS_CAPTION | WS_SIZEBOX));//去掉窗口边框
	SetParent(hFfplay, hProgman);							// 将视频窗口设置为PM的子窗口
	EnumWindows(EnumWindowsProc, 0);						// 找到第二个WorkerW窗口并隐藏它
	return 0;
}


/* 
int main(int argc, char *argv[])
{
	//LPCWSTR str = L"Everything";
	HWND hwnd = FindWindowW(L"ConsoleWindowClass", L"TERMUX-VCC");
	//设置程序的显示大小及位置
	//MoveWindow(hwnd, 100, 100, 400, 400, false);
	//去除边框
	SetWindowLong(hwnd, GWL_STYLE,GetWindowLong(hwnd, GWL_STYLE) & ~(WS_CAPTION | WS_SIZEBOX));
}
 */