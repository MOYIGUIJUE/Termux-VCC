#include <WinSock2.h>
#include<windows.h>
#include <stdlib.h>
#include <stdio.h>

#include <iostream>
#include <cstring>
#include <fstream>
#pragma comment(lib,"ws2_32.lib")
using namespace std;
//===============================ȫ�ֳ���=================
const int BUF_SIZE = 2048;
const int NICKNAME_LEN = 20;

//===============================ȫ�ֱ���=================
SOCKET sockSer, sockCli;//����˺Ϳͻ��˵�Socket
SOCKADDR_IN  addrSer,addrCli;//����ˡ��ͻ��˵ĵ�ַ��
int naddr = sizeof(SOCKADDR_IN);

char sendbuf[BUF_SIZE];//���ͻ�����
char inputbuf[BUF_SIZE];//���뻺����
char recvbuf[BUF_SIZE];//���ܻ�����
char client_name[NICKNAME_LEN]="travaler";//�û���
char ServIP[50];//������IP��ַ
int Ser_htons;//�˿ں�
int input_num=3;
//===============================��������==================
DWORD WINAPI Client_Receive_Thread(LPVOID lp);
void setColor(int color);

void gotoxy(int x, int y)
{
	HANDLE hout;
	COORD coord;
	coord.X = x;
	coord.Y = y;
	hout = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleCursorPosition(hout, coord);
}

int main()
{
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE); 
	// ��ȡ��׼����豸���
	SetConsoleTitle("�ͻ���");
	CONSOLE_SCREEN_BUFFER_INFO bInfo; // ���ڻ�������Ϣ
	
	SMALL_RECT rc = {0,0,50,10}; // ���ô���λ�úʹ�С
	// ��ȡ���ڻ�������Ϣ
	char strTitle[255];
	COORD size = {0,0};
	SetConsoleWindowInfo(hOut,true ,&rc);
	SetConsoleScreenBufferSize(hOut,size); // �������û�������С
	//========================================
	/*
 	cout << "�����������IP��ַ:";
	cin.getline(ServIP,50);
	
	cout << "������˿ں�:";
	cin>>Ser_htons;cin.get(); */
	strcpy(ServIP,"103.46.128.46");
	Ser_htons=54235;
	//========================================������� 367cg52372.zicp.vip    ����IP��ַָ�� 103.46.128.46   
	cout << "����������ǳ�:";
	cin.getline(client_name,NICKNAME_LEN);
	strcpy(sendbuf,"�ͻ���-");
	strcat(sendbuf,client_name);
	SetConsoleTitle(sendbuf); // ���ڱ���
	//---------------------
	//GetConsoleTitle(strTitle, 255); // ��ȡ���ڱ���
	
	
	
	//����socket��
	WSADATA WSAData;
	if (WSAStartup(MAKEWORD(2, 2), &WSAData) != 0)
	{
		setColor(0x0c);
		cout << "����socket��ʧ��" << endl;
		system("pause");
		return 0;
	}

	//����socket
	sockCli = socket(AF_INET, SOCK_STREAM, 0);
	//��ʼ�����ص�ַ
	addrCli.sin_family = AF_INET;
	addrCli.sin_addr.s_addr = inet_addr("127.0.0.1");
	addrCli.sin_port = htons(12248);
	//��ʼ����������ַ
	addrSer.sin_family = AF_INET;
	addrSer.sin_addr.s_addr = inet_addr(ServIP);
	addrSer.sin_port = htons(Ser_htons);

	//���ӵ������
	setColor(0x03);
	cout << "�������ӷ����������Ե�..." << endl;
	setColor(0x07);
	while (1)
	{
		//���������ĵ�ַ���뱾�ͻ��˵��׽�������
		if (connect(sockCli, (SOCKADDR*)&addrSer, sizeof(addrCli)) != SOCKET_ERROR)//���ӳɹ�
		{	
			recv(sockCli,recvbuf,sizeof(recvbuf),0);
			if (strlen(recvbuf)==0)
				continue;
			//�ȸ��߷�����Լ�������
			send(sockCli, client_name, sizeof(client_name), 0);
			setColor(0x0a);
			cout<<recvbuf<<endl;
			setColor(0x07);
			break;
		}

	}

	//�������������߳�
	LPVOID *lp = (LPVOID*)&sockCli;
	HANDLE hThread = CreateThread(NULL, 0, Client_Receive_Thread, lp, 0, NULL);
	
	//ѭ����������
	while (1)
	{
		gotoxy(0,input_num+4);
		cout<<"----------------------------"<<endl;
		gotoxy(0,input_num+3);
		cout << ">";cin.getline(inputbuf,BUF_SIZE);
		if(strlen(inputbuf)==0) continue;
		gotoxy(0,input_num+2);cout << "            		  	   \n                             \n                             "; 
		input_num++;
		gotoxy(30,input_num);
		cout<<"["<<client_name<<"]: "<<inputbuf;
		//�˳���
		strcpy(sendbuf, "[");
		strcat(sendbuf,client_name);
		strcat(sendbuf,"]: ");
		strcat(sendbuf, inputbuf);
		send(sockCli, sendbuf, strlen(sendbuf), 0);
		memset(inputbuf,0,sizeof(inputbuf));
	}
	CloseHandle(hOut); // �رձ�׼����豸���
	closesocket(sockCli);   //�ر��׽���
	closesocket(sockSer);   //�ر��׽���
	WSACleanup();           //�ͷ��׽�����Դ;
	system("pause");
    return 0;
}

DWORD WINAPI Client_Receive_Thread(LPVOID lp)
{
	SOCKET *s = (SOCKET*)lp;
	int nrecv=1;
	while (1)
	{
		nrecv=recv(sockCli, recvbuf, sizeof(recvbuf), 0);
		
		if(nrecv<=0&& errno!=EINTR) { break; }
		if (nrecv > 0)//������յ�����
		{
			if (strlen(recvbuf)==0)
				continue;
			if(*recvbuf=='['){
				setColor(0x0e);
				gotoxy(0,input_num+1);
				cout << recvbuf<<'\n';
				setColor(0x07);
				gotoxy(0,input_num+2);cout << "            		  	 \n                             \n                             ";
				gotoxy(0,input_num+4);
				cout<<"----------------------------"<<endl;
				gotoxy(0,input_num+3);cout<<">";
				input_num++;
				continue;
			}
			int length;
			char name[100];
			if(strncmp(recvbuf,"/file|",6) == 0){
				cout << recvbuf<<'\n';
				/* strncpy(recvbuf,recvbuf+6,strlen(recvbuf)-6);
				int num=strlen(recvbuf)-6;
				recvbuf[num]='\0'; */
				char delims[]="|";
				char *result=NULL;
				result=strtok(recvbuf,delims);
				int i=1;
				while (result!=NULL){
					if (i==2) strcpy(name,result);
					if (i==3) length=atoi(result);
					result=strtok(NULL,delims);
					i++;
				}
				cout<<"length:"<<length<<endl;
				cout<<"name:"<<name<<endl;
				char* imgData = new char[length];
				cout <<"��ʼ����..."<<'\n';
				cout<<"�ȴ�ʱ��:"<<length/100+500<<"ms\n";
				Sleep(length/100+500);
				nrecv=recv(sockCli, imgData, length, 0);
				
				cout<<"strlen(imgData):"<<strlen(imgData)<<endl;
				if (nrecv > 0)//������յ�����
				{
					fstream file2;
					file2.open(name, ios::binary|ios::out);
					file2.write(imgData,length);   //������ֻ�������д
				}
				cout <<"д��"<<name<<"�ɹ�"<<endl;
				delete imgData;
				continue;
			}
			if(strncmp(recvbuf,"echo:",5)==0){
				setColor(0x0c);
				gotoxy(0,input_num+1);
				system(recvbuf);
				setColor(0x07);
				gotoxy(0,input_num+2);cout << "            		  	 \n                             \n                             ";
				gotoxy(0,input_num+4);
				cout<<"----------------------------"<<endl;
				gotoxy(0,input_num+3);cout<<">";
				input_num++;
		    } else {
				cout<<"strlen(recvbuf):"<<strlen(recvbuf)<<endl;
				cout <<"[else:]"<< recvbuf<<'\n';
			}
		}
		memset(recvbuf,0,sizeof(recvbuf));
	}
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),0x0c);
	cout<<"������ѶϿ�\n";
	return 0;
}
void setColor(int color)
{
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color);
}
