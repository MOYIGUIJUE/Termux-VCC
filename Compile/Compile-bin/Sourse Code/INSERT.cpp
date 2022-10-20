#include <Windows.h>
#include <stdio.h>

int main(int argc,char *argv[]){
	if(argc>1){
		HANDLE hStdin = GetStdHandle(STD_INPUT_HANDLE);  
        DWORD mode;  
        GetConsoleMode(hStdin, &mode);  
        mode &= ENABLE_QUICK_EDIT_MODE; //���ٱ༭ģʽ
        mode &= ENABLE_INSERT_MODE;     //����ģʽ
        mode &= ENABLE_MOUSE_INPUT;
        SetConsoleMode(hStdin, mode);  
	} else {
		HANDLE hStdin = GetStdHandle(STD_INPUT_HANDLE);  
        DWORD mode;  
        GetConsoleMode(hStdin, &mode);  
        mode &= ~ENABLE_QUICK_EDIT_MODE;  //�Ƴ����ٱ༭ģʽ
        mode &= ~ENABLE_INSERT_MODE;      //�Ƴ�����ģʽ
        mode &= ~ENABLE_MOUSE_INPUT;
        SetConsoleMode(hStdin, mode);  
	}
	return 0;
}

/*
  �˳��򽫻���ʾ���ʹ�� SetCurrentConsoleFontEx �������Ŀ���̨����Ϊ�����塱��
  ��һ����Ҫע�⣬���ĵ���������ǵȿ����壬���ǵȿ�������޸ĺ󶼻���Ĭ�����塣
  g++ t.cpp -finput-charset=GBK
*/

		/* HWND hwnd=FindWindow("H-SMILE-FRAME",0);
			ShowWindow(hwnd,SW_HIDE);
			hwnd=FindWindow("H-SMILE-FRAME","ToDesk");
			ShowWindow(hwnd,SW_HIDE); */
			//���������������ʾ�Ĳ�һ���ǳ������ʵ����
			//�Ƽ�ʹ��SPY++����Process Monitor�鿴���ڵı���
			/*SW_FORCEMINIMIZE����WindowNT5.0����С�����ڣ���ʹӵ�д��ڵ��̱߳�����Ҳ����С�����ڴ������߳���С������ʱ��ʹ�����������nCmdShow=11��
			SW_HIDE�����ش��ڲ������������ڡ�nCmdShow=0��
			SW_MAXIMIZE�����ָ���Ĵ��ڡ�nCmdShow=3��
			SW_MINIMIZE����С��ָ���Ĵ��ڲ��Ҽ�����Z���е���һ�����㴰�ڡ�nCmdShow=6��
			SW_RESTORE�������ʾ���ڡ����������С������󻯣���ϵͳ�����ڻָ���ԭ���ĳߴ��λ�á��ڻָ���С������ʱ��Ӧ�ó���Ӧ��ָ�������־��nCmdShow=9��
			SW_SHOW���ڴ���ԭ����λ����ԭ���ĳߴ缤�����ʾ���ڡ�nCmdShow=5��
			SW_SHOWDEFAULT��������STARTUPINFO�ṹ��ָ����SW_FLAG��־�趨��ʾ״̬��STARTUPINFO �ṹ��������Ӧ�ó���ĳ��򴫵ݸ�CreateProcess�����ġ�nCmdShow=10��
			SW_SHOWMAXIMIZED������ڲ�������󻯡�nCmdShow=3��
			SW_SHOWMINIMIZED������ڲ�������С����nCmdShow=2��
			SW_SHOWMINNOACTIVE��������С�����������Ȼά�ּ���״̬��nCmdShow=7��
			SW_SHOWNA���Դ���ԭ����״̬��ʾ���ڡ��������Ȼά�ּ���״̬��nCmdShow=8��
			SW_SHOWNOACTIVATE���Դ������һ�εĴ�С��״̬��ʾ���ڡ��������Ȼά�ּ���״̬��nCmdShow=4��
			SW_SHOWNORMAL�������ʾһ�����ڡ�������ڱ���С������󻯣�ϵͳ����ָ���ԭ���ĳߴ�ʹ�С��Ӧ�ó����ڵ�һ����ʾ���ڵ�ʱ��Ӧ��ָ���˱�־��nCmdShow=1��
			*/