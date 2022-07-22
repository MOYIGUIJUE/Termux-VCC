/*
	���Ŀ¼����������ļ���·�����������Ŀ¼���������Ŀ¼
*/
#include <iostream>
#include <io.h>
#include <string>
#include <fstream>

using namespace std;

void listFiles(string dir);

int file_num=0; //�ļ�����
int row_max_num[20]; //�������
int MAX_X=0;
int MAX_Y=0;
string file_Arr[100][20]; //���� 
string Title_Arr[20]; //�������� 

void print_table(){
	for(int i=1;i<=MAX_X;i++){
		cout<<"+";
		for(int j=1;j<=row_max_num[i]+2;j++){
			cout<<"-";
		}
	}
	cout<<"+"<<endl;
}

void tables(){
	//��ӡ���
	print_table();
	for(int i=1;i<=MAX_X;i++){
		cout<<"| "<<Title_Arr[i]<<" ";
		int tmp=row_max_num[i]-Title_Arr[i].length();
		for(int n=1;n<=tmp;n++) cout<<" ";
	}
	cout<<"|"<<endl;
	//----------ͷ��
	print_table();
	for(int j=1;j<=MAX_Y;j++){
		for(int i=1;i<=MAX_X;i++){
			cout<<"| "<<file_Arr[i][j]<<" ";
			int tmp=row_max_num[i]-file_Arr[i][j].length();
			for(int n=1;n<=tmp;n++) cout<<" ";
		}
		cout<<"|"<<endl;
	}
	print_table();
}

int main(int argc, char * argv[]){
	memset(row_max_num,0,20);
	string dir;
	if(!strcmp(argv[2],"from")) {
		dir = argv[3];
	} else {
		cout<<"Error for you parameter!"<<endl;
		return 0;
	}
	listFiles(dir);
	
	/* cout<<"MAX_X:"<<MAX_X<<endl;
	cout<<"MAX_Y:"<<MAX_Y<<endl; */
	//�ѱ���д������
	int tmp=0;
	string ttt="\\titles.tl";
	string t_sorce = argv[3]+ttt;
	ifstream in(t_sorce.c_str()); //a.txt��ָ�����ı��ļ�
	for(string str; getline(in,str);){
		tmp++;
		//cout<<"Title_Arr["<<tmp<<"]="<<str<<endl;
		Title_Arr[tmp]=str;
		if ( str.length() > row_max_num[tmp] ) row_max_num[tmp] = str.length();
	}
	//----------------------
	//cout<<argc<<":"<<argv[1]<<endl;
	
	
	string input_x[20];
	string input_y[20];
	
			char delims[]=",";
			char *result=NULL;
			result=strtok(argv[1],delims);
			
			int nn=1;
			while (result!=NULL){
				input_x[nn]=result;
				result=strtok(NULL,delims);
				nn++;
			}
	int select_x[nn];
	int select_y[nn];
	int t=0;
	for (int j=1;j<nn;j++){
		for(int i=1;i<=MAX_X;i++){
			if( input_x[j] == Title_Arr[i] ) {
				//cout<<i<<"-----"<<input_x[j]<<endl;
				t++;
				select_x[t]=i;
			}
		}
	}
	//cout<<"nn:"<<nn<<endl;
	
	//-----------select------------
	for (int i=1;i<nn;i++){
		cout<<"+";
		for(int j=1;j<=row_max_num[select_x[i]]+2;j++){
			cout<<"-";
		}
	}
	cout<<"+"<<endl;
	
	for (int i=1;i<nn;i++){
		cout<<"| "<<Title_Arr[select_x[i]]<<" ";
		int tmp=row_max_num[select_x[i]]-Title_Arr[select_x[i]].length();
		for(int n=1;n<=tmp;n++) cout<<" ";
	}
	cout<<"|"<<endl;
	
	for (int i=1;i<nn;i++){
		cout<<"+";
		for(int j=1;j<=row_max_num[select_x[i]]+2;j++){
			cout<<"-";
		}
	}
	cout<<"+"<<endl;
	
	for(int j=1;j<=MAX_Y;j++){
		for(int i=1;i<nn;i++){
			cout<<"| "<<file_Arr[select_x[i]][j]<<" ";
			int tmp=row_max_num[select_x[i]]-file_Arr[select_x[i]][j].length();
			for(int n=1;n<=tmp;n++) cout<<" ";
		}
		cout<<"|"<<endl;
	}
	
	for (int i=1;i<nn;i++){
		cout<<"+";
		for(int j=1;j<=row_max_num[select_x[i]]+2;j++){
			cout<<"-";
		}
	}
	cout<<"+"<<endl;
	//----------------------
	
	
	return 1;
}
 
void listFiles(string dir) {
	//��Ŀ¼�������"\\*.tb"���е�һ������
	string newDir = dir + "\\*.tb";
	//���ڲ��ҵľ��
	intptr_t handle;
	struct _finddata_t fileinfo;
	//��һ�β���
	handle = _findfirst(newDir.c_str(), &fileinfo);
 
	if (handle == -1) {
		cout << "���ļ�" << endl;
		system("pause");
		return;
	}
	
	int X(0),Y(0);
	
	do //�����ļ�
	{
		if (fileinfo.attrib & _A_SUBDIR) {//���Ϊ�ļ��У������ļ���·�����ٴα���
			/* if (strcmp(fileinfo.name, ".") == 0 || strcmp(fileinfo.name, "..") == 0)
				continue;
 
			// ��Ŀ¼�������"\\"����������Ŀ¼��������һ������
			newDir = dir + "\\" + fileinfo.name;
			listFiles(newDir.c_str()); */
			continue;
		}
		else{
			X++;
			Y=0;
			string file_path = dir + "\\" + fileinfo.name;
			//cout << file_path.c_str() << endl;
				ifstream in(file_path.c_str()); //a.txt��ָ�����ı��ļ�
				for(string str; getline(in,str);){//getline()���ж�ȡ�ı�
					Y++;
					file_Arr[X][Y]=str;
					//cout<<"file_Arr["<<X<<"]["<<Y<<"]="<<str<<"|"<<str.length()<<endl;
					if ( str.length() > row_max_num[X] ) row_max_num[X] = str.length();
				}
				if ( Y > MAX_Y ) MAX_Y = Y;
		}
	} while (!_findnext(handle, &fileinfo));
	
	MAX_X = X;
	
	_findclose(handle);
	return;
}