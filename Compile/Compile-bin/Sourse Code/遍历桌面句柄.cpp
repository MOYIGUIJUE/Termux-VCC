#include<stdio.h>
#include<Windows.h>
#include<conio.h>
#include<iostream>
using namespace std;
int main(int argc,char *argv[])
{
	if ( argc == 1 ) argv[1] = "Termux";
	HWND hWnd = ::GetForegroundWindow();
	printf("hWnd:%#X\n",hWnd);
		//得到桌面窗口  
		HWND hd=GetDesktopWindow();  
	  
		//得到屏幕上第一个子窗口  
		hd=GetWindow(hd,GW_CHILD);  
		char s[200]={0};  
		//循环得到所有的子窗口  
		while(hd!=NULL)  
		{  
			memset(s,0,200);  
			GetWindowText(hd,s,200);  
			if (strstr(s,argv[1]))  
			{  
				cout<<s<<endl;  
				SetWindowText(hd,"VCC");  
				SendMessageA(hd,WM_CLOSE,0,0);
				//ShowWindow(hd, SW_HIDE);//隐藏
			}
			cout<<s<<" - ";  
			printf("%#X\n",hd);
			hd=GetNextWindow(hd,GW_HWNDNEXT);  
		}  
	
	int a=8498;
	while(a!=0){
		cout<<a<<" - "<<&a;
		getchar();
		a--;
	}
	return 0;
}
