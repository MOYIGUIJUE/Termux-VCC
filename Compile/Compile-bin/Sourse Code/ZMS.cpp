#include <windows.h>
#include <stdio.h>

BOOL CALLBACK EnumWindowsProc(_In_ HWND hwnd, _In_ LPARAM Lparam)
{
	HWND hDefView = FindWindowExW(hwnd, 0, L"SHELLDLL_DefView", 0);
	if (hDefView != 0) {
		// ��������һ�����ڣ�����ΪWorkerW��������
		HWND hWorkerw = FindWindowExW(0, hwnd, L"WorkerW", 0);
		ShowWindow(hWorkerw, SW_HIDE);

		return FALSE;
	}
	return TRUE;
}

/* int main(int argc, char *argv[])
{
	// ��Ƶ·����1920��1080��Ҫ����ʵ������ġ�����ʹ��GetSystemMetrics������ȡ�ֱ�������
	LPCWSTR lpParameter = L" .\\video.mp4  -noborder -x 1920 -y 1080 -loop 0";
	STARTUPINFOW si{ 0 };
	PROCESS_INFORMATION pi{ 0 };

	// �������ҵ�����ffplay��·����Ҫ����ʵ������� 
	if (CreateProcessW(L".\\ffmpeg-n5.1-latest-win64-lgpl-5.1\\bin\\ffplay.exe", (LPWSTR)lpParameter, 0, 0, 0, 0, 0, 0, &si, &pi))
	{
		Sleep(2500);												// �ȴ���Ƶ������������ɡ�����ѭ����ȡ���ڳߴ�������Sleep()

		HWND hProgman = FindWindowW(L"Progman", 0);				// �ҵ�PM����
		SendMessageTimeout(hProgman, 0x52C, 0, 0, 0, 100, 0);	// ������������Ϣ
		HWND hFfplay = FindWindowW(L"SDL_app", 0);				// �ҵ���Ƶ����
		SetParent(hFfplay, hProgman);							// ����Ƶ��������ΪPM���Ӵ���
		EnumWindows(EnumWindowsProc, 0);						// �ҵ��ڶ���WorkerW���ڲ�������
	}

	return 0;
} */

int main(int argc, char *argv[])
{
	HWND hProgman = FindWindowW(L"Progman", 0);				// �ҵ�PM����
	SendMessageTimeout(hProgman, 0x52C, 0, 0, 0, 100, 0);	// ������������Ϣ
	HWND hFfplay = FindWindowW(L"matrix", 0);				// �ҵ���Ƶ����
	SetWindowLong(hFfplay, GWL_STYLE,GetWindowLong(hFfplay, GWL_STYLE) & ~(WS_CAPTION | WS_SIZEBOX));//ȥ�����ڱ߿�
	SetParent(hFfplay, hProgman);							// ����Ƶ��������ΪPM���Ӵ���
	EnumWindows(EnumWindowsProc, 0);						// �ҵ��ڶ���WorkerW���ڲ�������
	return 0;
}


/* 
int main(int argc, char *argv[])
{
	//LPCWSTR str = L"Everything";
	HWND hwnd = FindWindowW(L"ConsoleWindowClass", L"TERMUX-VCC");
	//���ó������ʾ��С��λ��
	//MoveWindow(hwnd, 100, 100, 400, 400, false);
	//ȥ���߿�
	SetWindowLong(hwnd, GWL_STYLE,GetWindowLong(hwnd, GWL_STYLE) & ~(WS_CAPTION | WS_SIZEBOX));
}
 */