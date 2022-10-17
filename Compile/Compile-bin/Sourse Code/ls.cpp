#undef UNICODE
//按老师说的改了项目属性还是没用，搜到的避免字符串转换问题的方法就是加这一句
#include<stdio.h>
#include<Windows.h>
#include<conio.h>
#include <stdlib.h>
#include<iostream>
#include<iomanip>
using namespace std;


//======
int cal_row(char**,int,int*,int*);				//为分栏算法提供要显示的行/列数
char* filenames[1024];	//暂存目录中文件名
int file_cnt;//字符串数量

int cal_row(char** filenames,int file_cnt,int* cal_col,int* col_max_arr);
void set_location(int,int);
//==========



BOOL FindFirst(DWORD dwValue); //开始查找所有符合值的地址
BOOL FindNext(DWORD dwValue); //在已查找到的地址中重新查找

DWORD g_arrList[1024]; //存储找到的地址，只存1024个
int g_nListCnt; //有效的地址个数
HANDLE g_hProcess; //目标进程的句柄

void ShowList(); //显示有效的地址列表
BOOL WriteMemory(DWORD dwAddr, DWORD dwValue); //修改地址处的值

int main(int argc, char* argv[]) {
    //system("chcp 65001");
    //首先通过CreateProcess将目标进程加载，然后才能访问目标进程的内存空间
    char szFileName[100];
    //从命令行读取参数或者请求输入
    if(argc > 1)
        strcpy(szFileName, argv[1]);
    else {
        printf("请输入要修改的程序:");
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
    g_hProcess = pi.hProcess; //将目标进程的句柄保存在全局变量中
	printf("进程句柄:%#X \n",pi.hProcess);
	printf("主线程句柄:%#X \n",pi.hThread);
	printf("进程ID:%d \n",pi.dwProcessId);
	printf("线程ID:%d \n",pi.dwThreadId);
    BOOL flag = TRUE;
    int iVal;
	char chars;
    while (flag) {
        // 接收输入一个目标值，并进行搜索比对
        printf("首次搜索的数值:");
        std::cin >> iVal;
        //第一次查找
        FindFirst(iVal);
        //显示地址列表
        ShowList();
        int nListCnt=0,count=0,num=0;
        while (g_nListCnt > 1) {
            //nListCnt = g_nListCnt;
			num++;
            printf("第%d次查找:",num);
            std::cin >> iVal;
            //下一次搜索
            FindNext(iVal);
            ShowList();
			if ( g_nListCnt != 1 ) {
				printf("是否继续查找[Y/N] - \n");
				chars=getch();
				if(chars == 78 || chars == 110 ) {
					break;
				}
			}
            /* if (nListCnt == g_nListCnt) {
                count++; //如果重复3次都是同样的地址，则不再查找，选择其中的第一个修改
                if (count > 1)
                    break;
            } */
        }
        if ( g_nListCnt != 0 ) {
			while(1){
				int arr_num=0;
				if (g_nListCnt != 1) {
					printf("当前有效地址个数:%d \n请选择第[1-%d]个尝试修改:", g_nListCnt, g_nListCnt);
					std::cin >> arr_num;
					arr_num--;
				}
				printf("目标地址为:%p\n", g_arrList[arr_num]);
				//获取输入的新值，修改替换
				printf("输入要修改为的值:");
				std::cin >> iVal;
				if (WriteMemory(g_arrList[arr_num], iVal)) {
					printf("修改成功\n");
				}
				printf("是否继续修改[Y/N] - \n");
				chars=getch();
				if(chars == 78 || chars == 110 ) {
						if (g_hProcess)
						{
							DWORD dwEC = 0;
							BOOL b = GetExitCodeProcess(g_hProcess, &dwEC);
							if (b)
							{
								if (!TerminateProcess(g_hProcess, dwEC))
								{ cout << "强行关闭" << endl; }
							}
							CloseHandle(g_hProcess);
						}
					flag = FALSE;
					break;
				}
			}
			
        } else {
            printf("未找到地址\n");
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
    //一个DWORD4个字节，所以从头开始一次取4个字节长度的值进行对比
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
    const DWORD dwOneGb = 1024 * 1024 * 1024; //定义一个GB的大小
    const DWORD dwOnePage = 4 * 1024; //定义4KB一页
    g_nListCnt = 0;
    if (g_hProcess == NULL)
        return FALSE;
    DWORD dwBase = 64 * 1024; //刚开始的64kb是不能访问的，直接跳过
    for (; dwBase < 2 * dwOneGb; dwBase += dwOnePage) {
        //在2gb的空间里每次在4kb的页中寻找
        ComparePage(dwBase, dwValue);
    }
    return TRUE;
}

BOOL FindNext(DWORD dwValue)
{
    BOOL bRet = FALSE;
    int nOrgCnt = g_nListCnt;
    g_nListCnt = 0;
    DWORD dwReadValue; //存储读取值的地址
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
	//最小行数，int base_row = cur_file_size / col;
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
		shwo+=row;//最大行93+6=99
		if( tt>=col || shwo+1 > file_cnt ){//列
			printf("\n");
			colss++; //行
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
    //获取路径名中的文件名之前的长度
	int size;
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi);
	size = csbi.srWindow.Right - csbi.srWindow.Left + 1;
    int col = size;      //获得当前窗口的宽度（字符数）
	//printf("screen_width:%d\n",col);
    int col_max = 0;
    int cur_file_size = 0;//总字符数
	int filenames_len[file_cnt];
	*cal_col = 0;
	int i = 0;
	int j = 0;
	//获得每个文件名的字符长度
	for(i = 0;i < file_cnt;++i){
		filenames_len[i] = strlen(filenames[i]) + 2;		//字符串至少带两个空格
		/*特殊情况：当最大字符串长度比屏幕宽度大时,直接返回行数:file_cnt,列数：1,最大宽度:最大的字符串长度*/
		if(filenames_len[i] > col){
			*cal_col = 1;
			col_max_arr[0] = filenames_len[i];
			return file_cnt;
		}
		cur_file_size += filenames_len[i];
		//printf("filenames_len[%d]:%d \n",i,filenames_len[i]);
	}
	//最小行数，在此基础上迭代
	int base_row = cur_file_size / col;
	if(cur_file_size % col){
		base_row++;
	}
	int flag_succeed = 0;		//标记是否排列完成
	//-----------------------------------------------------
	//开始排列
	while(!flag_succeed){
		int remind_width = col;	//当前可用宽度
		*cal_col = -1;
		for(i = 0;i < file_cnt;++i){
			/*如果剩余宽度不足以容纳当前字符串，则跳出并分配额外的行空间*/
			//printf("if filenames_len[%d]:%d > 剩余宽度remind_width:%d\n",i,filenames_len[i],remind_width);
			if(filenames_len[i] > remind_width){
				break;
			}
			//新起的一列
			if(i % base_row == 0){
				++(*cal_col);
				col_max_arr[*cal_col] = filenames_len[i];
			} else {
				col_max_arr[*cal_col] = (filenames_len[i] > col_max_arr[*cal_col]) ? filenames_len[i] : col_max_arr[*cal_col];
			}
			//最后一行，更新剩余的宽度
			if(i % base_row == base_row - 1){
				remind_width -= col_max_arr[*cal_col];
			}
		}
		//判断是否排列完成
		//printf("[%d]剩余宽度:[%d] 最小行数:[%d]\n",i,remind_width,base_row);
		if(i == file_cnt){
			flag_succeed = 1;
		}
		//再分配额外行空间
		else {
			int extra = 0;						//所需额外的字符数
			while(i < file_cnt){
				//printf("所需额外的字符数:%d+=%d\n",extra,filenames_len[i]);
				extra += filenames_len[i++];
			}
			//printf("所需额外的字符数:%d %% col:%d \n最小行数:[%d] ",extra,col,base_row);
			if(extra % col){
				base_row += (extra / col + 1);
			} else {
				base_row += (extra / col);
			}
			//printf("+= extra:[%d]/ col:[%d] = 最小行数:[%d] \n",extra,col,base_row);
		}
		
	}
	++(*cal_col);								//列标从0开始，所以最后加1
	return base_row;
}

