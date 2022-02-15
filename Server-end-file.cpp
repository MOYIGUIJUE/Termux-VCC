#include <stdlib.h>
#include <stdio.h>
#include <WinSock2.h>
#include <iostream>
#include <WS2tcpip.h>
#include <cstring>
#include <fstream>
#pragma comment(lib,"ws2_32.lib")
using namespace std;

//===============================全局常量=================
const int BUF_SIZE = 2048;
const int NICKNAME_LEN = 20;
const int MAX_CLIENT_COUNT = 10; //最大连接数
//===============================全局变量=================
SOCKET sockSer,sockCli;
SOCKADDR_IN addrCli, addrSer;
int naddr = sizeof(SOCKADDR_IN);
char sendbuf[BUF_SIZE];//发送缓冲区
char inputbuf[BUF_SIZE];//输入缓冲区
char recvbuf[BUF_SIZE];//接受缓冲区
char localIP[50];//本地IP地址
int clientCount = 0;
int back_socket[MAX_CLIENT_COUNT+1];
int Ser_htons;
struct Client
{
	SOCKET s;
	SOCKADDR_IN sin;
	char name[NICKNAME_LEN];
}Cli[MAX_CLIENT_COUNT];

//===============================函数声明==================

DWORD WINAPI Server_Listen_Thread(LPVOID lp);
DWORD WINAPI Recv_Thread(LPVOID lp);

void getLocalIP(char localIp[], int n);
void setColor(int color);
bool AllisNum(char str[]);  //判断是否为位数字
int clientCount_num();
void main_command();

int main()
{
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE); 
	// 获取标准输出设备句柄
	SetConsoleTitle("服务器");
	//CONSOLE_SCREEN_BUFFER_INFO bInfo; // 窗口缓冲区信息
	
	SMALL_RECT rc = {0,0,60,10}; // 重置窗口位置和大小
	// 获取窗口缓冲区信息
	COORD size = {0,0};
	SetConsoleWindowInfo(hOut,true ,&rc);
	SetConsoleScreenBufferSize(hOut,size); // 重新设置缓冲区大小
	//载入socket库
	/* cout << "请输入端口号:";
	cin>>Ser_htons;cin.get(); */
	Ser_htons=56348;
	WSADATA WSAData;
	if (WSAStartup(MAKEWORD(2, 2), &WSAData) != 0)
	{
		setColor(0x0c);
		cout << "载入socket库失败" << endl;
		
		system("pause");
		return 0;
	}
	
	for(int i=0;i<=MAX_CLIENT_COUNT;i++)
	back_socket[i]=0;//记录断开的套接字数组下标
	
	getLocalIP(localIP, sizeof(localIP) / sizeof(char));

	setColor(0x03);
	cout << "[" << localIP << ":"<<Ser_htons<<"]作为聊天室服务端已经开启" << endl;
	setColor(0x07);
	
	sprintf(sendbuf,"服务器-[%s:%d]",localIP,Ser_htons);
	//strcat(sendbuf,localIP);
	SetConsoleTitle(sendbuf); // 窗口标题
	
	//创建socket
	sockSer = socket(AF_INET, SOCK_STREAM, 0);
	//初始化本地地址
	addrSer.sin_family = AF_INET;
	
	addrSer.sin_addr.s_addr = inet_addr(localIP);
	addrSer.sin_port = htons(Ser_htons);

	//绑定socket和本地地址
	bind(sockSer, (SOCKADDR*)&addrSer, sizeof(SOCKADDR));

	//创建接受连接线程
	LPVOID *lp_link = (LPVOID*)&sockSer;
	HANDLE hT_Accept_Link= CreateThread(NULL, 0, Server_Listen_Thread, lp_link, 0, NULL);

	//循环接收输入
	main_command();
	
	closesocket(sockCli);   //关闭套接字
	closesocket(sockSer);   //关闭套接字
	WSACleanup();           //释放套接字资源;
					
    return 0;
}

DWORD WINAPI Server_Listen_Thread(LPVOID lp)
{
	SOCKET *s = (SOCKET*)lp;
	while (1)
	{
		//监听socket
		listen(*s, 5);
		//接受连接
		//
		for(int i=1;i<=MAX_CLIENT_COUNT;i++){
			if (back_socket[i]==0){
				clientCount=i;
				break;
			}else{
				clientCount=0;
			}
		}
		if (clientCount==0) {
			Sleep(2000);
			continue;
		}
		//堵塞在accept
		Cli[clientCount].s = accept(*s, (SOCKADDR*)&Cli[clientCount].sin, &naddr);//从服务器套接口接受连接请求，将接受到的地址保存在缓冲区
		//此时创建了一个新的套接口与客户端的套接口连接，之后的通信都从这个专属套接口执行
		
		if (Cli[clientCount].s != INVALID_SOCKET)//连接成功
		{
			char tmp[10];
			itoa(clientCount_num()+1,tmp,10);
			strcpy(sendbuf,"[连接成功],当前连接数:");
			strcat(sendbuf,tmp);
			send(Cli[clientCount].s,sendbuf,strlen(sendbuf),0);
			
			//接收客户端名字
			recv(Cli[clientCount].s, Cli[clientCount].name, BUF_SIZE, 0);
			
			setColor(0x0a);
			back_socket[clientCount]=clientCount;
			
			LPVOID *lp_recv = (LPVOID*)&Cli[clientCount];
			
			cout <<"("<<clientCount<<")"<<"["<< Cli[clientCount].name << "](" << inet_ntoa(Cli[clientCount].sin.sin_addr) <<")连接成功！当前连接数：" << clientCount_num() << endl;
			
			setColor(0x07);
			
			CloseHandle(CreateThread(NULL, 0, Recv_Thread, lp_recv, 0, NULL));
			
			Sleep(1000);
		}

	}

}
//============================线程函数============================
DWORD WINAPI Recv_Thread(LPVOID lp){
	SOCKET *s = (SOCKET*)lp;
	int nrecv;
	int num=clientCount;
	char tmp[10];
	itoa(clientCount_num(),tmp,10);
			strcpy(recvbuf,"[");
			strcat(recvbuf,Cli[num].name);
			strcat(recvbuf,"]进入了聊天室,当前连接数:");
			strcat(recvbuf,tmp);
			for(int i=1;i<=MAX_CLIENT_COUNT;i++){
				if (back_socket[i]!=0&&back_socket[i]!=num){
					send(Cli[i].s,recvbuf,sizeof(recvbuf), 0);
				}
			}
			memset(recvbuf,0,sizeof(recvbuf));
	while (1)
	{
		nrecv = recv(Cli[num].s, recvbuf, sizeof(recvbuf), 0);
		if(nrecv<=0 && errno!=EINTR) {
			back_socket[num]=0;
			setColor(0x0c);
			strcpy(recvbuf,"[");
			strcat(recvbuf,Cli[num].name);
			strcat(recvbuf,"]退出了聊天室,当前连接数:");
			itoa(clientCount_num(),tmp,10);
			strcat(recvbuf,tmp);
			cout<<"("<<num<<")"<<"["<<Cli[num].name<<"]已断开,当前连接数:"<<clientCount_num()<<endl;
			
			for(int i=1;i<=MAX_CLIENT_COUNT;i++){
				if (back_socket[i]!=0&&back_socket[i]!=num){
					send(Cli[i].s,recvbuf,sizeof(recvbuf), 0);
				}
			}
			memset(recvbuf,0,sizeof(recvbuf));
			
			break;
		}
		if (nrecv > 0)//如果接收到数据
		{
			//cout <<"("<<num<<")"<< recvbuf << endl;
			
			//转发每个客户端
			for(int i=1;i<=MAX_CLIENT_COUNT;i++){
				if (back_socket[i]!=0&&back_socket[i]!=num){
					send(Cli[i].s,recvbuf,sizeof(recvbuf), 0);
				}
			}
			memset(recvbuf,0,sizeof(recvbuf));
		}
	}
	setColor(0x07);
	return 0;
}

//========================================================================
int clientCount_num(){
	int n=0;
	for (int i=1;i<=MAX_CLIENT_COUNT;i++){
		if (back_socket[i]!=0)
			n++;
	}
	return n;
}

//获取本地IPv4
void getLocalIP(char localIp[],int n)
{
	gethostname(localIp, n);
	HOSTENT *host = gethostbyname(localIp);
	//以下未研究
	in_addr PcAddr;
	for (int i = 0;;i++)
	{
		char *p = host->h_addr_list[i];
		if (NULL == p)
		{
			break;
		}
		memcpy(&(PcAddr.S_un.S_addr), p, host->h_length);
		strcpy(localIp, inet_ntoa(PcAddr));
	}
}
//设置颜色
void setColor(int color)
{
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color);
}
//发送消息
void main_command()
	{
		setColor(0x0e);
		cout<<"输入 /exit 退出选择其他客户端\n输入客户端代号选择与客户端对话\n输入 /0 发送消息给所有人\n输入 /file|+文件 发送文件 \n";
		setColor(0x07);
		while (1)
		{
			int command[MAX_CLIENT_COUNT+1]={0};
			//memset(a,0,sizeof(a));
			char a[10];
			memset(a,0,sizeof(a));
			cout<<"cmd:";cin.getline(a,10);
			if(strlen(a)==0) continue;
			char delims[]=" ";
			char *result=NULL;
			result=strtok(a,delims);
			
			int i=1;
			while (result!=NULL){
				command[i]=atoi(result);
				result=strtok(NULL,delims);
				i++;
			}
			
			if(!strcmp(a,"/0")){
				while(1){
					memset(inputbuf,0,sizeof(inputbuf));
					cout<<">[所有人:]";
					cin.getline(inputbuf,BUF_SIZE);
					//退出点
					if(strlen(inputbuf)==0) continue;
					if (strcmp(inputbuf, "/exit") == 0) break;
					if (strncmp(inputbuf,"/file|",6) == 0) 
					{
						char len[100],*name=new char[100];
						char delims[]="|";
						char *result=NULL;
						result=strtok(inputbuf,delims);
						int i=1;
						while (result!=NULL)
						{
							if (i==2) strcpy(name,result);
							result=strtok(NULL,delims);
							i++;
						}
						fstream file;
						file.open(name,ios::binary|ios::in|ios::ate);   //打开时指针在文件尾
						if (!file.good()) {
							cout<<"文件不存在\n";
							continue;
						}
						char *ext=strrchr(name,'\\');
						if (ext)
						{    
							*ext='\0';
							ext++;
						}
						if (ext != NULL) name=ext;
						delete ext;
						if (ext != NULL) name=ext;
						int length = file.tellg();
						char* imgData = new char[length];
						file.seekg(0);
						file.read(imgData, length);  //二进制只能用这个读
						itoa(length,len,10);
						strcat(inputbuf,"|");
						strcat(inputbuf,name);
						strcat(inputbuf,"|");
						strcat(inputbuf,len);
						for(int i=1;i<=MAX_CLIENT_COUNT;i++){
						if (back_socket[i]!=0){
								send(Cli[i].s,inputbuf,100,0);
							}
						}
						
						for(int i=1;i<=MAX_CLIENT_COUNT;i++){
						if (back_socket[i]!=0){
								send(Cli[i].s,imgData,length,0);
							}
						}
						cout<<"length:"<<length<<endl;
						cout<<"name:"<<name<<endl;
						memset(name,'\0',sizeof(name));
						continue;
					}
						
					//给每个客户端发送留言
					strcpy(sendbuf, "echo:");
					strcat(sendbuf, inputbuf);
					
					for(int i=1;i<=MAX_CLIENT_COUNT;i++){
						if (back_socket[i]!=0){
							send(Cli[i].s,sendbuf,sizeof(sendbuf), 0);
						}
					}
				}
				continue;
			}
			
			while(1)
			{
				memset(inputbuf,0,sizeof(inputbuf));
				cout<<">";
				for(int j=1;j<=MAX_CLIENT_COUNT;j++){
					if(!command[j]==0)
					cout<<"["<<command[j]<<"]";
				}
				cin.getline(inputbuf,BUF_SIZE);
				//退出点
				if(strlen(inputbuf)==0) continue;
				if (strcmp(inputbuf, "/exit") == 0) break;
				if (strncmp(inputbuf,"/file|",6) == 0) 
				{
					char len[100],*name=new char[100];
					char delims[]="|";
					char *result=NULL;
					result=strtok(inputbuf,delims);
					int i=1;
					while (result!=NULL)
					{
						if (i==2) strcpy(name,result);
						result=strtok(NULL,delims);
						i++;
					}
					//cout<<"inputbuf:"<<inputbuf<<endl;
					fstream file;
					file.open(name,ios::binary|ios::in|ios::ate);   //打开时指针在文件尾
					if (!file.good()) {
						cout<<"文件不存在\n";
						continue;
					}
					char *ext=strrchr(name,'\\');
						if (ext)
						{    
							*ext='\0';
							ext++;
						}
					if (ext != NULL) name=ext;
					delete ext;
					int length = file.tellg();
					char* imgData = new char[length];
					file.seekg(0);
					//读文件
					file.read(imgData, length);  //二进制只能用这个读
					itoa(length,len,10);
					strcat(inputbuf,"|");
					strcat(inputbuf,name);
					strcat(inputbuf,"|");
					strcat(inputbuf,len);
					
					cout<<"length:"<<length<<endl;
					
					//发送文件配置信息
					for(int j=1;j<=MAX_CLIENT_COUNT;j++)
					{
						if(command[j]!=0)
						{
							int tmp=command[j];
							send(Cli[tmp].s,inputbuf,100,0);
						}
					}
					
					
					//开始传输
					
					for(int j=1;j<=MAX_CLIENT_COUNT;j++)
					{
						if(command[j]!=0)
						{
							int tmp=command[j];
							send(Cli[tmp].s,imgData,length,0);
						}
					}
					cout<<"name:"<<name<<endl;
					memset(name,'\0',sizeof(name));
					continue;
				}
				
				for(int j=1;j<=MAX_CLIENT_COUNT;j++)
				{
					if(command[j]!=0)
					{
						int tmp=command[j];
						strcpy(sendbuf, "echo:");
						strcat(sendbuf, inputbuf);
						send(Cli[tmp].s, sendbuf, BUF_SIZE, 0);
					}
				}
			}
		}
	}
	

	

