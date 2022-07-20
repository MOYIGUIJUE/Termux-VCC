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
string file_Arr[20][100]; //���� 
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

int main(int argc, char * argv[]){
	//Ŀ¼·��
	memset(row_max_num,0,20);
	//string dir = "E:\\Desktop_copy\\table";
	string dir = argv[1];
	listFiles(dir);
	
	/* for(int i=1;i<=MAX_X;i++){
		cout<<row_max_num[i]<<" ";
	}
	cout<<endl; */
	/* cout<<"MAX_X:"<<MAX_X<<endl;
	cout<<"MAX_Y:"<<MAX_Y<<endl; */
	
	int tmp=0;
	string ttt="\\titles.tl";
	string t_sorce = argv[1]+ttt;
	ifstream in(t_sorce.c_str()); //a.txt��ָ�����ı��ļ�
	for(string str; getline(in,str);){
		tmp++;
		Title_Arr[tmp]=str;
		if ( str.length() > row_max_num[tmp] ) row_max_num[tmp] = str.length();
	}
	
	int return_len=0;
	
	print_table();
	for(int i=1;i<=MAX_X;i++){
		cout<<"| "<<Title_Arr[i]<<" ";
		return_len+=row_max_num[i]+3;
		int tmp=row_max_num[i]-Title_Arr[i].length();
		for(int n=1;n<=tmp;n++) cout<<" ";
	}
	cout<<"|"<<endl;
	
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
	
	return return_len+1;
}
 
void listFiles(string dir) {
	//��Ŀ¼�������"\\*.*"���е�һ������
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