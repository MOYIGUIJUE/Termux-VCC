#include<stdio.h>
#include<Windows.h>
#include<conio.h>

int cal_row(char**,int,int*,int*);				//Ϊ�����㷨�ṩҪ��ʾ����/����
char* filenames[4096];	//�ݴ�Ŀ¼���ļ���
int file_cnt = 0;//�ַ�������

int cal_row(char** filenames,int file_cnt,int* cal_col,int* col_max_arr);

int main(int argc,char *argv[])
{
	HWND hWnd = GetForegroundWindow();
	//printf("%#X -- [GetForegroundWindow] \n",hWnd);
		//�õ����洰��  
		HWND hd=GetDesktopWindow();  
		//�õ���Ļ�ϵ�һ���Ӵ���  
		hd=GetWindow(hd,GW_CHILD);  
		char s[100]={0};  
		//ѭ���õ����е��Ӵ���  
		while(hd!=NULL)  
		{  
			memset(s,0,100);  
			GetWindowText(hd,s,100);  
			//if (strstr(s,argv[1]))  
			//{  
				//cout<<s<<endl;  
				//SetWindowText(hd,"VCC");  
				//SendMessageA(hd,WM_CLOSE,0,0);
				//ShowWindow(hd, SW_HIDE);//����
			//}
			//filenames[0]=s;
			//printf("%#X %s\n",hd,s);
			filenames[file_cnt]=(char *)malloc(200);
			sprintf(filenames[file_cnt],"%X %s",hd,s);
			
			
			//snprintf(filenames[file_cnt],25,"%#X",g_arrList[i]);
			
			//printf(" - %s %d\n",filenames[file_cnt],file_cnt);
			
			hd=GetNextWindow(hd,GW_HWNDNEXT);  
			file_cnt++;
		}
		//printf("%d\n",file_cnt);
		/* for(int z=0;z<file_cnt;z++){
			printf("%s %d\n",filenames[z],z);
		} */
		
	int col = 0;
	int col_max_arr[256];
	int row = cal_row(filenames,file_cnt,&col,col_max_arr);
	//��С������int base_row = cur_file_size / col;
	int num=0;
	int colss=0;
	
	/* int show_x[row];
	for(int i=0;i<row;i++) show_x[i]=0;
	
	for(int i=0;i<file_cnt;i++){
		if(num>=row) {
			num = 0; 
			colss++ ;
			printf("---------\n");
		}
		num++;
		printf("[%d]%*s - ����ַ�������:%d - %d�� \n",i,-44,filenames[i],col_max_arr[colss],col);
		//printf("%*s\n",-col_max_arr[colss],filenames[i]);
	} */
	
	int shwo=0;
	colss=0;
	int tt=0;
	for(int i=0;i<file_cnt;i++){
		tt++;
		//printf("[%d - %d - %d]",shwo,col_max_arr[tt-1],tt-1);
		printf("%*s",-col_max_arr[tt-1],filenames[shwo]);
		shwo+=row;
		if( tt>=col || shwo+1 > file_cnt ){//��
			printf("\n");
			colss++;
			shwo=colss;
			tt=0;
		}
	}
	return 0;
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

