#include <string.h>
#include <stdio.h>
#include <Windows.h>
#include <tlhelp32.h>    //CreateToolhelp32Snapshot

BOOL FindProcessPid(LPCSTR ProcessName, DWORD& dwPid);

int main()//��ֱ���ÿ���̨����..��������ֱ��main����
{
	DWORD dwPid = 0;
	LPCSTR filename="game.exe";
		if (FindProcessPid(filename, dwPid)) {
            printf("[%s] [%d]\n", filename, dwPid);
        } else {
            printf("[%s] [Not Found]\n", filename);
        }
	
	//-------------------------
	
	
	DWORD D1 = 20; //����Ҫ�޸ĵĲ���,������Ҫ�޸��ڴ��ֵ,��ֱ�Ӱ���Ū�̶�20��

	HWND hand;//�������ھ��,�����Ϳ�����findwindow����������Ϸ����pid

	DWORD pidwin;//����pid

	void* ProcessHandle;//�������̾��,ͨ�������Եõ����Թ���Ȩ��

	hand=FindWindow(NULL, "E:\\Desktop\\game.exe");
	//api��findwindow����,��������������(����,������),ֻ��Ҫ����һ�������ҵ����ھ��,û���Ǹ�����   
	   
	GetWindowThreadProcessId(hand,&pidwin);//ͨ�����ھ��hand�ҵ���Ϸpid
	
	printf("pid:%d \nhand:%#X",pidwin,hand);
	
	//----------------------------
	ProcessHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, dwPid);//ͨ��pid�ҵ����̾��,���ҵõ�
	//���Կ���Ȩ,PROCESS_ALL_ACCESS������Կ���,�ڶ�����������0,�����������ǽ���pid
	  
	
	WriteProcessMemory(ProcessHandle,(LPVOID)0x64fe54, &D1, 4, NULL);
	//д��ȥ,                  (���̾��,��д���ַ,д��ֵ,ֵ����,NULL) ���һ������ֱ��NULL�͵���..
	return NULL;
}

BOOL FindProcessPid(LPCSTR ProcessName, DWORD& dwPid)
{
    HANDLE hProcessSnap;
    PROCESSENTRY32 pe32;

    // Take a snapshot of all processes in the system.
    hProcessSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (hProcessSnap == INVALID_HANDLE_VALUE)
    {
        return(FALSE);
    }

    pe32.dwSize = sizeof(PROCESSENTRY32);

    if (!Process32First(hProcessSnap, &pe32)) {
        CloseHandle(hProcessSnap);          // clean the snapshot object
        return(FALSE);
    }

    BOOL bRet = FALSE;
    do {
        if (!strcmp(ProcessName, pe32.szExeFile)) {
            dwPid = pe32.th32ProcessID;
            bRet = TRUE;
            break;
        }
	} while (Process32Next(hProcessSnap, &pe32));

    CloseHandle(hProcessSnap);
    return bRet;
}