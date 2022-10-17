#include <string.h>
#include <stdio.h>
#include <Windows.h>
#include <tlhelp32.h>    //CreateToolhelp32Snapshot

BOOL FindProcessPid(LPCSTR ProcessName, DWORD& dwPid);

int main()//我直接用控制台做了..所以这里直接main进入
{
	DWORD dwPid = 0;
	LPCSTR filename="game.exe";
		if (FindProcessPid(filename, dwPid)) {
            printf("[%s] [%d]\n", filename, dwPid);
        } else {
            printf("[%s] [Not Found]\n", filename);
        }
	
	//-------------------------
	
	
	DWORD D1 = 20; //声明要修改的参数,就是你要修改内存的值,我直接把他弄固定20了

	HWND hand;//声明窗口句柄,这样就可以用findwindow方法来找游戏进程pid

	DWORD pidwin;//声明pid

	void* ProcessHandle;//声明进程句柄,通过他可以得到绝对管理权限

	hand=FindWindow(NULL, "E:\\Desktop\\game.exe");
	//api的findwindow方法,其中两个参数是(类名,窗口名),只需要其中一个就能找到窗口句柄,没有那个可以   
	   
	GetWindowThreadProcessId(hand,&pidwin);//通过窗口句柄hand找到游戏pid
	
	printf("pid:%d \nhand:%#X",pidwin,hand);
	
	//----------------------------
	ProcessHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, dwPid);//通过pid找到进程句柄,并且得到
	//绝对控制权,PROCESS_ALL_ACCESS代表绝对控制,第二个参数总是0,第三个参数是进程pid
	  
	
	WriteProcessMemory(ProcessHandle,(LPVOID)0x64fe54, &D1, 4, NULL);
	//写进去,                  (进程句柄,欲写入地址,写入值,值长度,NULL) 最后一个参数直接NULL就得了..
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