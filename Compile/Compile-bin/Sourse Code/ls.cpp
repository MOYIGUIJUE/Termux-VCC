#undef UNICODE
//����ʦ˵�ĸ�����Ŀ���Ի���û�ã��ѵ��ı����ַ���ת������ķ������Ǽ���һ��
#include<stdio.h>
#include<Windows.h>
#include<conio.h>
#include <stdlib.h>
#include<iostream>
#include<iomanip>
using namespace std;


//======
int cal_row(char**,int,int*,int*);				//Ϊ�����㷨�ṩҪ��ʾ����/����
char* filenames[1024];	//�ݴ�Ŀ¼���ļ���
int file_cnt;//�ַ�������

int cal_row(char** filenames,int file_cnt,int* cal_col,int* col_max_arr);
void set_location(int,int);
//==========



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
		tt_i++;
        printf("0X%*X",-12,g_arrList[i]);
		if(tt_i>5) {
			tt_i=0;
			printf("\n");
		}
    }
	printf("\n");
	
	//=====
	
	char* tmp;
	file_cnt=g_nListCnt;
	
	for (int i = 0; i < g_nListCnt; i++) {
		filenames[i]=new char[25];
		snprintf(filenames[i],25,"%#X",g_arrList[i]);
		//printf("%s  ",filenames[i]);
	}
	
	
	
	
	int col = 0;
	int col_max_arr[1024];
	int row = cal_row(filenames,file_cnt,&col,col_max_arr);
	//��С������int base_row = cur_file_size / col;
	int num=0;
	int colss=0;
	int show_x[row];
	for(int i=0;i<row;i++) show_x[i]=0;
	
	int shwo=0;
	colss=0;
	int tt=0;
	/* for(int i=0;i<file_cnt;i++)
		printf("[%d|%s]",i,filenames[i]);
	printf("\n\n"); */
	
	for(int i=0;i<file_cnt;i++){
		tt++;
		//printf("[%d-%d-%d]",shwo,col_max_arr[tt-1],tt-1);
		printf("%*s",-col_max_arr[tt-1],filenames[shwo]);
		shwo+=row;//�����93+6=99
		if( tt>=col || shwo+1 > file_cnt ){//��
			printf("\n");
			colss++; //��
			shwo=colss;
			tt=0;
		}
	}
	
	printf("\n");
	//=======
}

BOOL WriteMemory(DWORD dwAddr, DWORD dwValue)
{
    return ::WriteProcessMemory(g_hProcess, (LPVOID)dwAddr, &dwValue, sizeof(DWORD), NULL);
}


int cal_row(char** filenames,int file_cnt,int* cal_col,int* col_max_arr)
{
    //��ȡ·�����е��ļ���֮ǰ�ĳ���
	int size;
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi);
	size = csbi.srWindow.Right - csbi.srWindow.Left + 1;
    int col = size;      //��õ�ǰ���ڵĿ�ȣ��ַ�����
	//printf("screen_width:%d\n",col);
    int col_max = 0;
    int cur_file_size = 0;//���ַ���
	int filenames_len[file_cnt];
	*cal_col = 0;
	int i = 0;
	int j = 0;
	//���ÿ���ļ������ַ�����
	for(i = 0;i < file_cnt;++i){
		filenames_len[i] = strlen(filenames[i]) + 2;		//�ַ������ٴ������ո�
		/*���������������ַ������ȱ���Ļ��ȴ�ʱ,ֱ�ӷ�������:file_cnt,������1,�����:�����ַ�������*/
		if(filenames_len[i] > col){
			*cal_col = 1;
			col_max_arr[0] = filenames_len[i];
			return file_cnt;
		}
		cur_file_size += filenames_len[i];
		//printf("filenames_len[%d]:%d \n",i,filenames_len[i]);
	}
	//��С�������ڴ˻����ϵ���
	int base_row = cur_file_size / col;
	if(cur_file_size % col){
		base_row++;
	}
	int flag_succeed = 0;		//����Ƿ��������
	//-----------------------------------------------------
	//��ʼ����
	while(!flag_succeed){
		int remind_width = col;	//��ǰ���ÿ��
		*cal_col = -1;
		for(i = 0;i < file_cnt;++i){
			/*���ʣ���Ȳ��������ɵ�ǰ�ַ����������������������пռ�*/
			//printf("if filenames_len[%d]:%d > ʣ����remind_width:%d\n",i,filenames_len[i],remind_width);
			if(filenames_len[i] > remind_width){
				break;
			}
			//�����һ��
			if(i % base_row == 0){
				++(*cal_col);
				col_max_arr[*cal_col] = filenames_len[i];
			} else {
				col_max_arr[*cal_col] = (filenames_len[i] > col_max_arr[*cal_col]) ? filenames_len[i] : col_max_arr[*cal_col];
			}
			//���һ�У�����ʣ��Ŀ��
			if(i % base_row == base_row - 1){
				remind_width -= col_max_arr[*cal_col];
			}
		}
		//�ж��Ƿ��������
		//printf("[%d]ʣ����:[%d] ��С����:[%d]\n",i,remind_width,base_row);
		if(i == file_cnt){
			flag_succeed = 1;
		}
		//�ٷ�������пռ�
		else {
			int extra = 0;						//���������ַ���
			while(i < file_cnt){
				//printf("���������ַ���:%d+=%d\n",extra,filenames_len[i]);
				extra += filenames_len[i++];
			}
			//printf("���������ַ���:%d %% col:%d \n��С����:[%d] ",extra,col,base_row);
			if(extra % col){
				base_row += (extra / col + 1);
			} else {
				base_row += (extra / col);
			}
			//printf("+= extra:[%d]/ col:[%d] = ��С����:[%d] \n",extra,col,base_row);
		}
		
	}
	++(*cal_col);								//�б��0��ʼ����������1
	return base_row;
}

