#include<Windows.h>
#include<stdio.h>

int main(int argc, char *argv[])
{
	if(argc>1){
		HWND hwnd=GetForegroundWindow();//ֱ�ӻ��ǰ�����ڵľ��
		HINSTANCE hInstance = GetModuleHandle(argv[0]);
		SendMessage(hwnd,WM_SETICON,ICON_SMALL,(LPARAM)LoadImage(hInstance,TEXT(argv[1]),IMAGE_ICON, 32, 32, LR_LOADFROMFILE));
	} else {
		printf("Usage: %s \"IconFile\" Set Current Console Icon",argv[0]);
	}
	return 0;
}

//HICON hIcon = (HICON)LoadImage(hInstance, TEXT("small.ico"), IMAGE_ICON, 0, 0, 0);
//SendMessage(hwnd, WM_SETICON, ICON_BIG, hIcon );
/* 
SendMessage(hwnd, WM_SETICON, TRUE,  (LPARAM)LoadIcon((HINSTANCE) GetWindowLongPtr(hwnd, GWLP_HINSTANCE),MAKEINTRESOURCE(idi)));
SendMessage(hwnd, WM_SETICON, FALSE, (LPARAM)LoadIcon((HINSTANCE) GetWindowLongPtr(hwnd, GWLP_HINSTANCE),MAKEINTRESOURCE(idi)));
 */
/* #include <iostream>
#include <windows.h> 
#include <stdlib.h>
#include <bitset>

using namespace std;

int main(int argc, char *argv[])
{
	
	//���ó���ͼ��
	HWND hwnd = GetForegroundWindow();
	HINSTANCE hInstance = GetModuleHandle(argv[0]);
	//ʹ���ⲿ��Դ
	SendMessage(hwnd,WM_SETICON,ICON_SMALL,(LPARAM)LoadIcon(hInstance,TEXT("gdg.ico")));
	
	//ʹ��ϵͳ��׼ͼ��
	//SendMessage(hwnd,WM_SETICON,ICON_SMALL,(LPARAM)LoadIcon(NULL,MAKEINTRESOURCE(IDI_WARNING)));
	//SendMessage(hwnd,WM_SETICON,ICON_SMALL,(LPARAM)LoadIcon(NULL,TEXT("gdg.ico")));
	
	return 0;
} */


/* 
HANDLE LoadImage(
    HINSTANCE hinst,     // �����س����ⲿ��Դ��NULL,����һ�㴫AfxGetInstanceHandle()
    LPCTSTR lpszName,    // ͼƬ���ƻ�ȫ·��
    UINT uType,          // ͼƬ����:IMAGE_BITMAP��IMAGE_ICON��IMAGE_CURSOR
    int cxDesired,
    int cyDesired,
    UINT fuLoad          // һ��ΪLR_DEFAULTCOLOR | LR_CREATEDIBSECTION
);

cxDesired�� cyDesired��
��Image��ʵ�ʳߴ���أ�cxDesired=0��cyDesired=0����fuLoad��ָ��LR_DEFAULTSIZE��
��ָ����С���أ� cxDesired��cyDesired��Ϊ0����fuLoad��ָ��LR_DEFAULTSIZE��Image�����ʵ�ʴ�С���š�
��WindowsϵͳĬ�ϵ�Icon��Cursor��С(һ��Ϊ32x32)����Icon��Cursor��cxDesired=0��cyDesired=0�� fuLoadָ��LR_DEFAULTSIZE��Image�����ʵ�ʴ�С���š�
ע��: LR_DEFAULTSIZEֻ��Icon��Cursor�����ã���Bitmap�������á�

fuLoad:
���Ӷ����ڳ����Image�ļ�(.bmp,.ico)���أ���ָ����־LR_LOADFROMFILE��

ʾ��
1.����Icon��Դ
��WindowsϵͳĬ�ϵ�Icon��С����

HICON hIcon = (HICON)::LoadImage(
        AfxGetInstanceHandle(), 
        MAKEINTRESOURCE(IDI_ICON1),
        IMAGE_ICON,
        0, 0,
        LR_DEFAULTCOLOR | LR_CREATEDIBSECTION | LR_DEFAULTSIZE);

2.���ر��ش��̵�Icon�ļ�
��ʵ�ʴ�С����

HICON hIcon = (HICON)::LoadImage(
        AfxGetInstanceHandle(), 
        TEXT("D:\\Butterfly.ico"),
        IMAGE_ICON,
        0, 0,
        LR_DEFAULTCOLOR | LR_CREATEDIBSECTION | LR_LOADFROMFILE);

3.���ر��ش��̵�Bitmap�ļ�
��ָ����С����

HBITMAP hBitmap = (HBITMAP)::LoadImage(
        NULL, 
        TEXT("D:\\001.bmp"), 
        IMAGE_BITMAP, 
        50, 50, 
        LR_DEFAULTCOLOR | LR_CREATEDIBSECTION | LR_LOADFROMFILE); */

/* 

SendMessage(hwnd,WM_SETICON,ICON_SMALL,(LPARAM)LoadIcon(NULL,IDI_APPLICATION));

IDI_APPLICATION
MAKEINTRESOURCE(32512)	Ĭ�ϳ���ͼ��
IDI_ASTERISK
MAKEINTRESOURCE(32516)	Asteriskͼ�꣬
��IDI_INFORMATION��ͬ
IDI_ERROR
MAKEINTRESOURCE(32513)	Hand-shapedͼ��
IDI_EXCLAMATION
MAKEINTRESOURCE(32515)	��̾��ͼ�꣬
��IDI_WARNING��ͬ
IDI_HAND
MAKEINTRESOURCE(32513)	Hand-shapedͼ�꣬
��IDI_ERROR��ͬ
IDI_INFORMATION
MAKEINTRESOURCE(32516)	Asteriskͼ��
IDI_QUESTION
MAKEINTRESOURCE(32514)	���ʺ�ͼ��
IDI_SHIELD
MAKEINTRESOURCE(32518)	��ȫɡͼ��
IDI_WARNING
MAKEINTRESOURCE(32515)	��̾��ͼ��
IDI_WINLOGO
MAKEINTRESOURCE(32517)	Ĭ�ϳ���ͼ�꣬
Win2000��Windows logoͼ�� 

*/