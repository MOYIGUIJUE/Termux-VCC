#include <windows.h>
#include<stdio.h>
#define IDR_PAUSE 12
#define IDR_START 13

LPCTSTR szAppClassName  = TEXT("�������");
LPCTSTR szAppWindowName = TEXT("�������");
HMENU hmenu;//�˵����
NOTIFYICONDATA nid;

LRESULT CALLBACK WndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    UINT WM_TASKBARCREATED;
    POINT pt;//���ڽ����������
    int xx;//���ڽ��ղ˵�ѡ���ֵ

    // ��Ҫ�޸�TaskbarCreated������ϵͳ�������Զ������Ϣ
    WM_TASKBARCREATED = RegisterWindowMessage(TEXT("TaskbarCreated"));
    switch (message)
    {
    case WM_CREATE://���ڴ���ʱ�����Ϣ.
        nid.cbSize = sizeof(nid);
        nid.hWnd = hwnd;
        nid.uID = 0;
        nid.uFlags = NIF_ICON | NIF_MESSAGE | NIF_TIP;
        nid.uCallbackMessage = WM_USER;
        nid.hIcon = LoadIcon(NULL, IDI_APPLICATION);
        lstrcpy(nid.szTip, szAppClassName);
        Shell_NotifyIcon(NIM_ADD, &nid);
        hmenu=CreatePopupMenu();//���ɲ˵�
        AppendMenu(hmenu,MF_STRING,IDR_PAUSE,TEXT("TERMUX"));//Ϊ�˵��������ѡ��
        AppendMenu(hmenu,MF_STRING,IDR_START,TEXT("�˳�"));
        break;
    case WM_USER://����ʹ�øó���ʱ�����Ϣ.
        if (lParam == WM_LBUTTONDBLCLK)
            system("start %VCC_HOME%\\termux.bat");
        if (lParam == WM_RBUTTONDOWN)
        {
            GetCursorPos(&pt);//ȡ�������
            ::SetForegroundWindow(hwnd);//����ڲ˵��ⵥ������˵�����ʧ������
            //EnableMenuItem(hmenu,IDR_PAUSE,MF_GRAYED);//�ò˵��е�ĳһ����
            xx=TrackPopupMenu(hmenu,TPM_RETURNCMD,pt.x,pt.y,NULL,hwnd,NULL);//��ʾ�˵�����ȡѡ��ID
            if(xx==IDR_PAUSE) {
				system("start %VCC_HOME%\\termux.bat");
			}
            if(xx==IDR_START) {
				SendMessage(hwnd, WM_CLOSE, wParam, lParam);
			}
            if(xx==0) PostMessage(hwnd,WM_LBUTTONDOWN,NULL,NULL);
            //MessageBox(hwnd, TEXT("�Ҽ�"), szAppName, MB_OK);
        }
        break;
    case WM_DESTROY://��������ʱ�����Ϣ.
        Shell_NotifyIcon(NIM_DELETE, &nid);
        PostQuitMessage(0);
        break;
    default:
        /*
        * ��ֹ��Explorer.exe �����Ժ󣬳�����ϵͳϵͳ�����е�ͼ�����ʧ
        *
        * ԭ��Explorer.exe �����������ؽ�ϵͳ����������ϵͳ������������ʱ�����ϵͳ������
        * ע�����TaskbarCreated ��Ϣ�Ķ������ڷ���һ����Ϣ������ֻ��Ҫ��׽�����Ϣ�����ؽ�ϵ
        * ͳ���̵�ͼ�꼴�ɡ�
        */
        if (message == WM_TASKBARCREATED)
            SendMessage(hwnd, WM_CREATE, wParam, lParam);
        break;
    }
    return DefWindowProc(hwnd, message, wParam, lParam);
}

int main(int argc, char *argv[])
{
    HWND hwnd;
    MSG msg;
    WNDCLASS wndclass;

    HWND handle = FindWindow(NULL, szAppWindowName);
    if (handle != NULL)
    {
        MessageBox(NULL, TEXT("Application is already running"), szAppClassName, MB_ICONERROR);
        return 0;
    }

    wndclass.style = CS_HREDRAW | CS_VREDRAW;
    wndclass.lpfnWndProc = WndProc;
    wndclass.cbClsExtra = 0;
    wndclass.cbWndExtra = 0;
    wndclass.hInstance = NULL;
    wndclass.hIcon = LoadIcon(NULL, IDI_APPLICATION);
    wndclass.hCursor = LoadCursor(NULL, IDC_ARROW);
    wndclass.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
    wndclass.lpszMenuName = NULL;
    wndclass.lpszClassName = szAppClassName;

    if (!RegisterClass(&wndclass))
    {
        MessageBox(NULL, TEXT("This program requires Windows NT!"), szAppClassName, MB_ICONERROR);
        return 0;
    }
		
    // �˴�ʹ��WS_EX_TOOLWINDOW ������������ʾ���������ϵĴ��ڳ���ť
    hwnd = CreateWindowEx(WS_EX_TOOLWINDOW,
        szAppClassName, szAppWindowName,
        WS_POPUP,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
        NULL, NULL, NULL, NULL);

    ShowWindow(hwnd, 0);
    UpdateWindow(hwnd);

    //��Ϣѭ��
    while (GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return 0;
}