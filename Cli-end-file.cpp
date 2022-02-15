#include <WinSock2.h>
#include<windows.h>
#include <stdlib.h>
#include <stdio.h>

#include <iostream>
#include <cstring>
#include <fstream>
#pragma comment(lib,"ws2_32.lib")
using namespace std;
//===============================全局常量=================
const int BUF_SIZE = 2048;
const int NICKNAME_LEN = 20;

//===============================全局变量=================
SOCKET sockSer, sockCli;//服务端和客户端的Socket
SOCKADDR_IN  addrSer,addrCli;//服务端、客户端的地址包
int naddr = sizeof(SOCKADDR_IN);

char sendbuf[BUF_SIZE];//发送缓冲区
char inputbuf[BUF_SIZE];//输入缓冲区
char recvbuf[BUF_SIZE];//接受缓冲区
char client_name[NICKNAME_LEN]="travaler";//用户名
char ServIP[50];//服务器IP地址
int Ser_htons;//端口号
int input_num=3;
//===============================函数声明==================
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
	// 获取标准输出设备句柄
	SetConsoleTitle("客户端");
	CONSOLE_SCREEN_BUFFER_INFO bInfo; // 窗口缓冲区信息
	
	SMALL_RECT rc = {0,0,50,10}; // 重置窗口位置和大小
	// 获取窗口缓冲区信息
	char strTitle[255];
	COORD size = {0,0};
	SetConsoleWindowInfo(hOut,true ,&rc);
	SetConsoleScreenBufferSize(hOut,size); // 重新设置缓冲区大小
	//========================================
	/*
 	cout << "请输入服务器IP地址:";
	cin.getline(ServIP,50);
	
	cout << "请输入端口号:";
	cin>>Ser_htons;cin.get(); */
	strcpy(ServIP,"103.46.128.46");
	Ser_htons=54235;
	//========================================诊断域名 367cg52372.zicp.vip    域名IP地址指向 103.46.128.46   
	cout << "请输入你的昵称:";
	cin.getline(client_name,NICKNAME_LEN);
	strcpy(sendbuf,"客户端-");
	strcat(sendbuf,client_name);
	SetConsoleTitle(sendbuf); // 窗口标题
	//---------------------
	//GetConsoleTitle(strTitle, 255); // 获取窗口标题
	
	
	
	//载入socket库
	WSADATA WSAData;
	if (WSAStartup(MAKEWORD(2, 2), &WSAData) != 0)
	{
		setColor(0x0c);
		cout << "载入socket库失败" << endl;
		system("pause");
		return 0;
	}

	//创建socket
	sockCli = socket(AF_INET, SOCK_STREAM, 0);
	//初始化本地地址
	addrCli.sin_family = AF_INET;
	addrCli.sin_addr.s_addr = inet_addr("127.0.0.1");
	addrCli.sin_port = htons(12248);
	//初始化服务器地址
	addrSer.sin_family = AF_INET;
	addrSer.sin_addr.s_addr = inet_addr(ServIP);
	addrSer.sin_port = htons(Ser_htons);

	//连接到服务端
	setColor(0x03);
	cout << "正在连接服务器，请稍等..." << endl;
	setColor(0x07);
	while (1)
	{
		//将服务器的地址包与本客户端的套接字连接
		if (connect(sockCli, (SOCKADDR*)&addrSer, sizeof(addrCli)) != SOCKET_ERROR)//连接成功
		{	
			recv(sockCli,recvbuf,sizeof(recvbuf),0);
			if (strlen(recvbuf)==0)
				continue;
			//先告诉服务端自己的名字
			send(sockCli, client_name, sizeof(client_name), 0);
			setColor(0x0a);
			cout<<recvbuf<<endl;
			setColor(0x07);
			break;
		}

	}

	//创建接收数据线程
	LPVOID *lp = (LPVOID*)&sockCli;
	HANDLE hThread = CreateThread(NULL, 0, Client_Receive_Thread, lp, 0, NULL);
	
	//循环接收输入
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
		//退出点
		strcpy(sendbuf, "[");
		strcat(sendbuf,client_name);
		strcat(sendbuf,"]: ");
		strcat(sendbuf, inputbuf);
		send(sockCli, sendbuf, strlen(sendbuf), 0);
		memset(inputbuf,0,sizeof(inputbuf));
	}
	CloseHandle(hOut); // 关闭标准输出设备句柄
	closesocket(sockCli);   //关闭套接字
	closesocket(sockSer);   //关闭套接字
	WSACleanup();           //释放套接字资源;
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
		if (nrecv > 0)//如果接收到数据
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
				cout <<"开始接收..."<<'\n';
				cout<<"等待时间:"<<length/100+500<<"ms\n";
				Sleep(length/100+500);
				nrecv=recv(sockCli, imgData, length, 0);
				
				cout<<"strlen(imgData):"<<strlen(imgData)<<endl;
				if (nrecv > 0)//如果接收到数据
				{
					fstream file2;
					file2.open(name, ios::binary|ios::out);
					file2.write(imgData,length);   //二进制只能用这个写
				}
				cout <<"写入"<<name<<"成功"<<endl;
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
	cout<<"服务端已断开\n";
	return 0;
}
void setColor(int color)
{
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color);
}
