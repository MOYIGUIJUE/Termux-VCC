#include <stdio.h>
#include <stdlib.h>

#include <windows.h>

int cal_row(char**,int,int*,int*);				//Ϊ�����㷨�ṩҪ��ʾ����/����
char* filenames[4096];	//�ݴ�Ŀ¼���ļ���
int file_cnt = 11;//�ַ�������

int cal_row(char** filenames,int file_cnt,int* cal_col,int* col_max_arr);
void set_location(int,int);

int main()
{
	char *aa1="12345fdgdfssss";
	char *aa2="asfdsgdfsfff";
	char *aa3="asdgfdfgdfsdddddd";
	char *aa4="54dfs";
	char *aa5="asdgfdfdgdsfdfff";
	char *aa6="asdgfdf";
	char *aa7="asdgfdfd";
	char *aa8="asdgfdfd";
	char *aa9="asdgfd";
	char *aa10="asdgfdfddfffff";
	filenames[0]=aa1;
	filenames[1]=aa2;
	filenames[2]=aa3;
	filenames[3]=aa4;
	filenames[4]=aa5;
	filenames[5]=aa5;
	filenames[6]=aa6;
	filenames[7]=aa7;
	filenames[8]=aa8;
	filenames[9]=aa9;
	filenames[10]=aa10;
	int col = 0;
	int col_max_arr[256];
	int row = cal_row(filenames,file_cnt,&col,col_max_arr);
	//��С������int base_row = cur_file_size / col;
	int num=0;
	int colss=0;
	int show_x[row];
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
	}
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
	printf("screen_width:%d\n",col);
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
		printf("[%d]ʣ����:[%d] ��С����:[%d]\n",i,remind_width,base_row);
		if(i == file_cnt){
			flag_succeed = 1;
		}
		//�ٷ�������пռ�
		else {
			int extra = 0;						//���������ַ���
			while(i < file_cnt){
				printf("���������ַ���:%d+=%d\n",extra,filenames_len[i]);
				extra += filenames_len[i++];
			}
			printf("���������ַ���:%d %% col:%d \n��С����:[%d] ",extra,col,base_row);
			if(extra % col){
				base_row += (extra / col + 1);
			} else {
				base_row += (extra / col);
			}
			printf("+= extra:[%d]/ col:[%d] = ��С����:[%d] \n",extra,col,base_row);
		}
		
	}
	++(*cal_col);								//�б��0��ʼ����������1
	return base_row;
}


