/* CREATE TABLE ����
( ���� char(10) primary key,             
 ������� varchar(10));
GO */
CREATE TABLE ��Ʒ��
( ��Ʒ��� char(10) primary key,                 
 ��Ʒ���� varchar(10),  
 ��Ʒ�۸� int, 
 ������Ϣ varchar(20),
 ��ƷͼƬ image,
 ���� char(10)
FOREIGN KEY(����) REFERENCES ����(����)
);
go
CREATE TABLE ��Ա��
( ��Ա���varchar(10)  primary key,                 
 ��Ա����varchar(10),  
 ��Ա�Ա�char(4),
 ��Ա����varchar(20),
);
go 
CREATE TABLE ��ϵ��ʽ��
(��Ա��� varchar(10) primary key,
�绰 varchar(20),                 
  �ʱ� varchar(10),  
��ַ char(20)
FOREIGN KEY(��Ա���) REFERENCES ��Ա��(��Ա���)
GO
CREATE TABLE ״̬��
( ״̬�� char(10)primary key,                 
 ״̬�� varchar(10));

go
CREATE TABLE ���ұ�
( ���ұ�� char(10) primary key,                 
 �������� char(10));
go 
CREATE TABLE ������
(
��Ʒ��� char(10),
���ұ�� char(10),
�ϼ�ʱ�� date,
primary key(��Ʒ���,���ұ��),
FOREIGN KEY(��Ʒ���) REFERENCES ��Ʒ��(��Ʒ���),
FOREIGN KEY(���ұ��) REFERENCES ���ұ�(���ұ��));
go 
CREATE TABLE �ֿ��
( ��Ʒ��� char(10)primary key,
	����� int,
	FOREIGN KEY(��Ʒ���) REFERENCES ��Ʒ��(��Ʒ���)
);
go 
CREATE TABLE ������
(�������  varchar(10),
��Ա��� varchar(10),
��Ʒ��� char(10),
���� int,
�ύʱ�� date,
״̬�� char(10),
primary key(�������,��Ա���,��Ʒ���,״̬��),
FOREIGN KEY(��Ա���) REFERENCES ��Ա��(��Ա���),
FOREIGN KEY(��Ʒ���) REFERENCES ��Ʒ��(��Ʒ���),
FOREIGN KEY(״̬��) REFERENCES ״̬��(״̬��));
go 
CREATE VIEW �����ܼ�
 AS
  SELECT
    �������,��Ʒ����,��Ʒ�۸�,����,��Ա����,�绰,��Ա����,��ַ, ��Ʒ�۸�*���� As �ܼ�
  FROM
    ������,��Ʒ��,��Ա��,��ϵ��ʽ��
  WHERE ������.��Ʒ���=��Ʒ��.��Ʒ��� AND ������.��Ա���=��Ա��.��Ա��� AND ��Ա��.��Ա���=��ϵ��ʽ��.��Ա���
 
