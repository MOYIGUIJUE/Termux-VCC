#include<windows.h>
#include<stdio.h>
#include<conio.h>

#include<iostream>
#include<iomanip>
using namespace std;

void move();
void ASCII();
void setColor(int color)
{
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color);
}

char const* character[] = {"NULL", "SOH", "STX", "ETX ", "EOT ", 
                              "ENQ ", "ACK", 
                            "\\a","\\b","\\t","\\n","\\v","\\f","\\r","SO","SI", 
                              "DLE",
                            "DC1 ", "DC2", "DC3", "DC4",
                              "NAK", "SYN", "ETB", "CAN ",
                            "EM ", "SUB", "ESC", "FS ",
                              "GS ", "RS ", "US ", "(space)"};
							  
int main(int argc,char *argv[])
{
	if(argc<=1){
		printf("Usage: words [?ַ???] [Ҫ??д???ַ???] [?ַ???] - char strings[20]; \n   or: words [-key] ???ذ??¼???ASCII????ֵ\n   or: words [-asc] ??ӡASCII???? \n");
		return 1;
	}
	if(!strcmp(argv[1],"-key")){
		char chars;
		chars=getch();
		//printf("%d\n",chars);
		return chars;
	} 
	if(!strcmp(argv[1],"-asc")){
		ASCII();
		return 0;
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

void move()//????һ???жϰ??°????ĺ???
{
	char chars;//????һ??char?ͱ????洢???°?????ֵ
	chars = getch();//??ȡ???µİ???
	printf("%d",chars);
	if(chars == -32){
		chars = getch();
		if(chars == 72) 
			printf("???????ϼ?");
		if(chars == 80) 
			printf("???????¼?");		
		if(chars == 75) 
			printf("??????????");		
		if(chars == 77) 
			printf("???????Ҽ?");	
	}
	if(chars == 27) 
	printf("??????esc");
}

void ASCII()
{
   
    char c;
    int row;
    for(int i = 0; i < 32; i++)
    {
        row = i;
        while (row <= 127) {
            if (row <= 32){
                
                cout << setfill('0') << setw(2) << setbase(10)
                     << row << " = " << setw(7) << setfill(' ')
                     << character[row] << " | ";
            }
            else if (row > 32 && row < 127)
            {
                c = row;
				if (row > 99) {
				cout << setfill('0') << setw(2) << setbase(10)
                     << row << " = " << setw(6) << setfill(' ')
                     << c << " | ";
				} else {
                cout << setfill('0') << setw(2) << setbase(10)
                     << row << " = " << setw(7) << setfill(' ')
                     << c << " | ";
				}
            }
            else
                cout << setfill('0') << setw(2) << setbase(10)
                     << row << " = " << setw(6) << setfill(' ')
                     << "DEL" << " | ";
            row = row + 32;
        }
        cout << endl;
    }
} 
