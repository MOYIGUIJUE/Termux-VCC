#undef UNICODE
//����ʦ˵�ĸ�����Ŀ���Ի���û�ã��ѵ��ı����ַ���ת������ķ������Ǽ���һ��
#include<stdio.h>
#include<Windows.h>
#include<conio.h>

#include<iostream>
#include<iomanip>
using namespace std;


BOOL FindFirst(DWORD dwValue); //��ʼ�������з���ֵ�ĵ�ַ
BOOL FindNext(DWORD dwValue); //���Ѳ��ҵ��ĵ�ַ�����²���

DWORD g_arrList[1024]; //�洢�ҵ��ĵ�ַ��ֻ��1024��
int g_nListCnt; //��Ч�ĵ�ַ����
HANDLE g_hProcess; //Ŀ����̵ľ��

void ShowList(); //��ʾ��Ч�ĵ�ַ�б�
BOOL WriteMemory(DWORD dwAddr, DWORD dwValue); //�޸ĵ�ַ����ֵ

int main(int argc, char* argv[]) {
    //system("chcp 65001");
    //����ͨ��CreateProcess��Ŀ����̼��أ�Ȼ����ܷ���Ŀ����̵��ڴ�ռ�
    char szFileName[100];
    //�������ж�ȡ����������������
    if(argc > 1)
        strcpy(szFileName, argv[1]);
    else {
        printf("������Ҫ�޸ĵĳ���:");
        std::cin >> szFileName;
    }
    STARTUPINFO si;
    memset(&si, 0, sizeof(si));
    PROCESS_INFORMATION pi;
    BOOL bRet = ::CreateProcess(
            NULL,
            szFileName,
            NULL,
            NULL,
            FALSE,
            CREATE_NEW_CONSOLE,
            NULL,
            NULL,
            &si,
            &pi
    );
    g_hProcess = pi.hProcess; //��Ŀ����̵ľ��������ȫ�ֱ�����
	printf("���̾��:%#X \n",pi.hProcess);
	printf("���߳̾��:%#X \n",pi.hThread);
	printf("����ID:%d \n",pi.dwProcessId);
	printf("�߳�ID:%d \n",pi.dwThreadId);
    BOOL flag = TRUE;
    int iVal;
	char chars;
    while (flag) {
        // ��������һ��Ŀ��ֵ�������������ȶ�
        printf("�״���������ֵ:");
        std::cin >> iVal;
        //��һ�β���
        FindFirst(iVal);
        //��ʾ��ַ�б�
        ShowList();
        int nListCnt=0,count=0,num=0;
        while (g_nListCnt > 1) {
            //nListCnt = g_nListCnt;
			num++;
            printf("��%d�β���:",num);
            std::cin >> iVal;
            //��һ������
            FindNext(iVal);
            ShowList();
			if ( g_nListCnt != 1 ) {
				printf("�Ƿ��������[Y/N] - \n");
				chars=getch();
				if(chars == 78 || chars == 110 ) {
					break;
				}
			}
            /* if (nListCnt == g_nListCnt) {
                count++; //����ظ�3�ζ���ͬ���ĵ�ַ�����ٲ��ң�ѡ�����еĵ�һ���޸�
                if (count > 1)
                    break;
            } */
        }
        if ( g_nListCnt != 0 ) {
			while(1){
				int arr_num=0;
				if (g_nListCnt != 1) {
					printf("��ǰ��Ч��ַ����:%d \n��ѡ���[1-%d]�������޸�:", g_nListCnt, g_nListCnt);
					std::cin >> arr_num;
					arr_num--;
				}
				printf("Ŀ���ַΪ:%p\n", g_arrList[arr_num]);
				//��ȡ�������ֵ���޸��滻
				printf("����Ҫ�޸�Ϊ��ֵ:");
				std::cin >> iVal;
				if (WriteMemory(g_arrList[arr_num], iVal)) {
					printf("�޸ĳɹ�\n");
				}
				printf("�Ƿ�����޸�[Y/N] - \n");
				chars=getch();
				if(chars == 78 || chars == 110 ) {
						if (g_hProcess)
						{
							DWORD dwEC = 0;
							BOOL b = GetExitCodeProcess(g_hProcess, &dwEC);
							if (b)
							{
								if (!TerminateProcess(g_hProcess, dwEC))
								{ cout << "ǿ�йر�" << endl; }
							}
							CloseHandle(g_hProcess);
						}
					flag = FALSE;
					break;
				}
			}
			
        } else {
            printf("δ�ҵ���ַ\n");
        }
    }
    return 0;
}

BOOL ComparePage(DWORD dwBaseAddr, DWORD dwValue) {
    BYTE arBytes[4096];
    if (!::ReadProcessMemory(g_hProcess, (LPCVOID)dwBaseAddr, arBytes, 4096, NULL)) {
        return FALSE;
    }
    DWORD* pdw;
    //һ��DWORD4���ֽڣ����Դ�ͷ��ʼһ��ȡ4���ֽڳ��ȵ�ֵ���жԱ�
    for (int i = 0; i < (int)4 * 1024 - 3; i++) {
        pdw = (DWORD*)&arBytes[i];
        if (pdw[0] == dwValue) {
            if (g_nListCnt >= 1024)
                return FALSE;
            g_arrList[g_nListCnt++] = dwBaseAddr + i;
        }
    }
    return TRUE;
}

BOOL FindFirst(DWORD dwValue)
{
    BOOL bRet = FALSE;
    const DWORD dwOneGb = 1024 * 1024 * 1024; //����һ��GB�Ĵ�С
    const DWORD dwOnePage = 4 * 1024; //����4KBһҳ
    g_nListCnt = 0;
    if (g_hProcess == NULL)
        return FALSE;
    DWORD dwBase = 64 * 1024; //�տ�ʼ��64kb�ǲ��ܷ��ʵģ�ֱ������
    for (; dwBase < 2 * dwOneGb; dwBase += dwOnePage) {
        //��2gb�Ŀռ���ÿ����4kb��ҳ��Ѱ��
        ComparePage(dwBase, dwValue);
    }
    return TRUE;
}

BOOL FindNext(DWORD dwValue)
{
    BOOL bRet = FALSE;
    int nOrgCnt = g_nListCnt;
    g_nListCnt = 0;
    DWORD dwReadValue; //�洢��ȡֵ�ĵ�ַ
    for (int i = 0; i < nOrgCnt; i++) {
        if (::ReadProcessMemory(g_hProcess, (LPVOID)g_arrList[i], &dwReadValue, sizeof(DWORD), NULL)) {
            if (dwReadValue == dwValue) {
                g_arrList[g_nListCnt++] = g_arrList[i];
                bRet = TRUE;
            }
        }
    }
    return bRet;
}

void ShowList()
{
	int tt_i=0;
    for (int i = 0; i < g_nListCnt; i++) {
        std::cout << std::hex << g_arrList[i] << "  ";
		if(tt_i>5) { 
			tt_i=0;
			std::cout <<std::endl; 
		}
		tt_i++;
    }
	std::cout <<std::endl;
}

BOOL WriteMemory(DWORD dwAddr, DWORD dwValue)
{
    return ::WriteProcessMemory(g_hProcess, (LPVOID)dwAddr, &dwValue, sizeof(DWORD), NULL);
}
