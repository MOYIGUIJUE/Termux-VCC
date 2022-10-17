// FileName: FindProcessPid.cpp

// Function: Find Pid by ProcessName

#include <string.h>
#include <stdio.h>
#include <Windows.h>
#include <tlhelp32.h>    //CreateToolhelp32Snapshot


#define ArraySize(ptr)    (sizeof(ptr) / sizeof(ptr[0]))


BOOL FindProcessPid(LPCSTR ProcessName, DWORD& dwPid);


int main()
{
    LPCSTR ListApps[]{
        "game.exe", "cmd.exe"
    };
    DWORD dwPid = 0;

    for (int i = 0; i < ArraySize(ListApps); i++)
    {
        if (FindProcessPid(ListApps[i], dwPid))
        {
            printf("[%s] [%d]\n", ListApps[i], dwPid);
        }
        else
        {
            printf("[%s] [Not Found]\n", ListApps[i]);
        }
    }
    return 0;
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

    if (!Process32First(hProcessSnap, &pe32))
    {
        CloseHandle(hProcessSnap);          // clean the snapshot object
        return(FALSE);
    }

    BOOL    bRet = FALSE;
    do
    {
        if (!strcmp(ProcessName, pe32.szExeFile))
        {
            dwPid = pe32.th32ProcessID;
            bRet = TRUE;
            break;
        }

    } while (Process32Next(hProcessSnap, &pe32));

    CloseHandle(hProcessSnap);
    return bRet;
}