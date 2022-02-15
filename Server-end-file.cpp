#include <stdlib.h>
#include <stdio.h>
#include <WinSock2.h>
#include <iostream>
#include <WS2tcpip.h>
#include <cstring>
#include <fstream>
#pragma comment(lib,"ws2_32.lib")
using namespace std;

//===============================ȫ�ֳ���=================
const int BUF_SIZE = 2048;
const int NICKNAME_LEN = 20;
const int MAX_CLIENT_COUNT = 10; //���������
//===============================ȫ�ֱ���=================
SOCKET sockSer,sockCli;
SOCKADDR_IN addrCli, addrSer;
int naddr = sizeof(SOCKADDR_IN);
char sendbuf[BUF_SIZE];//���ͻ�����
char inputbuf[BUF_SIZE];//���뻺����
char recvbuf[BUF_SIZE];//���ܻ�����
char localIP[50];//����IP��ַ
int clientCount = 0;
int back_socket[MAX_CLIENT_COUNT+1];
int Ser_htons;
struct Client
{
	SOCKET s;
	SOCKADDR_IN sin;
	char name[NICKNAME_LEN];
}Cli[MAX_CLIENT_COUNT];

//===============================��������==================

DWORD WINAPI Server_Listen_Thread(LPVOID lp);
DWORD WINAPI Recv_Thread(LPVOID lp);

void getLocalIP(char localIp[], int n);
void setColor(int color);
bool AllisNum(char str[]);  //�ж��Ƿ�Ϊλ����
int clientCount_num();
void main_command();

int main()
{
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE); 
	// ��ȡ��׼����豸���
	SetConsoleTitle("������");
	//CONSOLE_SCREEN_BUFFER_INFO bInfo; // ���ڻ�������Ϣ
	
	SMALL_RECT rc = {0,0,60,10}; // ���ô���λ�úʹ�С
	// ��ȡ���ڻ�������Ϣ
	COORD size = {0,0};
	SetConsoleWindowInfo(hOut,true ,&rc);
	SetConsoleScreenBufferSize(hOut,size); // �������û�������С
	//����socket��
	/* cout << "������˿ں�:";
	cin>>Ser_htons;cin.get(); */
	Ser_htons=56348;
	WSADATA WSAData;
	if (WSAStartup(MAKEWORD(2, 2), &WSAData) != 0)
	{
		setColor(0x0c);
		cout << "����socket��ʧ��" << endl;
		
		system("pause");
		return 0;
	}
	
	for(int i=0;i<=MAX_CLIENT_COUNT;i++)
	back_socket[i]=0;//��¼�Ͽ����׽��������±�
	
	getLocalIP(localIP, sizeof(localIP) / sizeof(char));

	setColor(0x03);
	cout << "[" << localIP << ":"<<Ser_htons<<"]��Ϊ�����ҷ�����Ѿ�����" << endl;
	setColor(0x07);
	
	sprintf(sendbuf,"������-[%s:%d]",localIP,Ser_htons);
	//strcat(sendbuf,localIP);
	SetConsoleTitle(sendbuf); // ���ڱ���
	
	//����socket
	sockSer = socket(AF_INET, SOCK_STREAM, 0);
	//��ʼ�����ص�ַ
	addrSer.sin_family = AF_INET;
	
	addrSer.sin_addr.s_addr = inet_addr(localIP);
	addrSer.sin_port = htons(Ser_htons);

	//��socket�ͱ��ص�ַ
	bind(sockSer, (SOCKADDR*)&addrSer, sizeof(SOCKADDR));

	//�������������߳�
	LPVOID *lp_link = (LPVOID*)&sockSer;
	HANDLE hT_Accept_Link= CreateThread(NULL, 0, Server_Listen_Thread, lp_link, 0, NULL);

	//ѭ����������
	main_command();
	
	closesocket(sockCli);   //�ر��׽���
	closesocket(sockSer);   //�ر��׽���
	WSACleanup();           //�ͷ��׽�����Դ;
					
    return 0;
}

DWORD WINAPI Server_Listen_Thread(LPVOID lp)
{
	SOCKET *s = (SOCKET*)lp;
	while (1)
	{
		//����socket
		listen(*s, 5);
		//��������
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
		//������accept
		Cli[clientCount].s = accept(*s, (SOCKADDR*)&Cli[clientCount].sin, &naddr);//�ӷ������׽ӿڽ����������󣬽����ܵ��ĵ�ַ�����ڻ�����
		//��ʱ������һ���µ��׽ӿ���ͻ��˵��׽ӿ����ӣ�֮���ͨ�Ŷ������ר���׽ӿ�ִ��
		
		if (Cli[clientCount].s != INVALID_SOCKET)//���ӳɹ�
		{
			char tmp[10];
			itoa(clientCount_num()+1,tmp,10);
			strcpy(sendbuf,"[���ӳɹ�],��ǰ������:");
			strcat(sendbuf,tmp);
			send(Cli[clientCount].s,sendbuf,strlen(sendbuf),0);
			
			//���տͻ�������
			recv(Cli[clientCount].s, Cli[clientCount].name, BUF_SIZE, 0);
			
			setColor(0x0a);
			back_socket[clientCount]=clientCount;
			
			LPVOID *lp_recv = (LPVOID*)&Cli[clientCount];
			
			cout <<"("<<clientCount<<")"<<"["<< Cli[clientCount].name << "](" << inet_ntoa(Cli[clientCount].sin.sin_addr) <<")���ӳɹ�����ǰ��������" << clientCount_num() << endl;
			
			setColor(0x07);
			
			CloseHandle(CreateThread(NULL, 0, Recv_Thread, lp_recv, 0, NULL));
			
			Sleep(1000);
		}

	}

}
//============================�̺߳���============================
DWORD WINAPI Recv_Thread(LPVOID lp){
	SOCKET *s = (SOCKET*)lp;
	int nrecv;
	int num=clientCount;
	char tmp[10];
	itoa(clientCount_num(),tmp,10);
			strcpy(recvbuf,"[");
			strcat(recvbuf,Cli[num].name);
			strcat(recvbuf,"]������������,��ǰ������:");
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
			strcat(recvbuf,"]�˳���������,��ǰ������:");
			itoa(clientCount_num(),tmp,10);
			strcat(recvbuf,tmp);
			cout<<"("<<num<<")"<<"["<<Cli[num].name<<"]�ѶϿ�,��ǰ������:"<<clientCount_num()<<endl;
			
			for(int i=1;i<=MAX_CLIENT_COUNT;i++){
				if (back_socket[i]!=0&&back_socket[i]!=num){
					send(Cli[i].s,recvbuf,sizeof(recvbuf), 0);
				}
			}
			memset(recvbuf,0,sizeof(recvbuf));
			
			break;
		}
		if (nrecv > 0)//������յ�����
		{
			//cout <<"("<<num<<")"<< recvbuf << endl;
			
			//ת��ÿ���ͻ���
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

//��ȡ����IPv4
void getLocalIP(char localIp[],int n)
{
	gethostname(localIp, n);
	HOSTENT *host = gethostbyname(localIp);
	//����δ�о�
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
//������ɫ
void setColor(int color)
{
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color);
}
//������Ϣ
void main_command()
	{
		setColor(0x0e);
		cout<<"���� /exit �˳�ѡ�������ͻ���\n����ͻ��˴���ѡ����ͻ��˶Ի�\n���� /0 ������Ϣ��������\n���� /file|+�ļ� �����ļ� \n";
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
					cout<<">[������:]";
					cin.getline(inputbuf,BUF_SIZE);
					//�˳���
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
						file.open(name,ios::binary|ios::in|ios::ate);   //��ʱָ�����ļ�β
						if (!file.good()) {
							cout<<"�ļ�������\n";
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
						file.read(imgData, length);  //������ֻ���������
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
						
					//��ÿ���ͻ��˷�������
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
				//�˳���
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
					file.open(name,ios::binary|ios::in|ios::ate);   //��ʱָ�����ļ�β
					if (!file.good()) {
						cout<<"�ļ�������\n";
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
					//���ļ�
					file.read(imgData, length);  //������ֻ���������
					itoa(length,len,10);
					strcat(inputbuf,"|");
					strcat(inputbuf,name);
					strcat(inputbuf,"|");
					strcat(inputbuf,len);
					
					cout<<"length:"<<length<<endl;
					
					//�����ļ�������Ϣ
					for(int j=1;j<=MAX_CLIENT_COUNT;j++)
					{
						if(command[j]!=0)
						{
							int tmp=command[j];
							send(Cli[tmp].s,inputbuf,100,0);
						}
					}
					
					
					//��ʼ����
					
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
	

	

