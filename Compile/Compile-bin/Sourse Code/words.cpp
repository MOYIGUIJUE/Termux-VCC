//#include<iostream>
#include<windows.h>
#include<stdio.h>
#include<conio.h>
//using namespace std;

void move();
void setColor(int color)
{
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color);
}

int main(int argc,char *argv[])
{
	if(argc<=1){
		printf("Usage: words [�ַ���] [Ҫ��д���ַ���] [�ַ���] \n       char strings[20]; \n");
		return 1;
	}
    char strings[20];
    char chars;
	int num=0;
	//cout<<argv[1]<<" "<<strlen(argv[2])<<" "<<argv[3]<<endl;
	//cout<<argv[1];
	printf("%s",argv[1]);
	for(int i=0;i<strlen(argv[2])+2;i++) printf(" ");//cout<<" ";
	//cout<<argv[3];
	printf("%s",argv[3]);
	for(int i=0;i<strlen(argv[3])+strlen(argv[2])+1;i++) printf("\b");//cout<<'\b';
    while ( chars=getch() )
    {
		//printf("%d",chars);
		if(chars == 27) 
			break;
		if(chars == 13) 
			continue;
		if (chars=='\b') {
			if(num<=0) continue;
			num--;
			strings[num]='\0';
			for(int i=0;i<=num;i++){
				//cout<<'\b';
				printf("\b");
			}
			//cout<<strings<<" \b";
			printf("%s \b",strings);
			//cout<<"\""<<strings<<"\"=strings["<<num<<"]=chars:"<<chars<<endl;
		} else {
			if(num>strlen(argv[2])-1) continue;
			strings[num]=chars;
			strings[num+1]='\0';
			for(int i=0;i<num;i++){
				//cout<<'\b';
				printf("\b");
			}
			//cout<<strings;
			printf("%s",strings);
			//cout<<"\""<<strings<<"\"=strings["<<num<<"]=chars:"<<chars<<endl;
			num++;
		}
		
		if (!strcmp(strings,argv[2])) {
			setColor(0x0a);
			for(int i=0;i<num;i++){
				//cout<<'\b';
				printf("\b");
			}
			//cout<<strings;
			printf("%s",strings);
			setColor(0x07);
			break;
		}
    }
	//cout<<endl;
	printf("\n");
	return 0;
}

void move()//����һ���жϰ��°����ĺ���
{
	char chars;//����һ��char�ͱ����洢���°�����ֵ
	chars = getch();//��ȡ���µİ���
	printf("%d",chars);
	if(chars == -32){
		chars = getch();
		if(chars == 72) 
			printf("�������ϼ�");
		if(chars == 80) 
			printf("�������¼�");		
		if(chars == 75) 
			printf("���������");		
		if(chars == 77) 
			printf("�������Ҽ�");	
	}
	if(chars == 27) 
	printf("������esc");
}
