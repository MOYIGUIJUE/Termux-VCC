#include <windows.h>
#include <stdio.h>
using namespace std;
int main(int argc,char *argv[])
{
	int c=0;
	char str[]="-c";
	char strs[]="/c";
	char help[]="/?";
	for(int i=0;i<argc;i++){
		if (!strcmp(str,argv[i])||!strcmp(strs,argv[i])){
			if(argv[i+1]==NULL){
				MessageBox(NULL, argv[i-1], "Title",MB_OKCANCEL);
			}else{
				MessageBox(NULL, argv[i+1], "Title",MB_OKCANCEL);
			}
			c++;
		}
		if (!strcmp(help,argv[i])){
			printf("MSG [/C] [-C]\n  /C          ѡ��ȷ����ȡ����ť \n  ���Ӳ���Ĭ��ֻ��ȷ����ť");
			c++;
		}
	}
	
	if(c==0)
	{
		MessageBox(NULL, argv[1], "",MB_OK);
	}
	return 0;
}
