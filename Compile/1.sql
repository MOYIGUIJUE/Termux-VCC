/* CREATE TABLE 类别表
( 类别号 char(10) primary key,             
 类别名称 varchar(10));
GO */
CREATE TABLE 商品表
( 商品编号 char(10) primary key,                 
 商品名称 varchar(10),  
 商品价格 int, 
 详情信息 varchar(20),
 商品图片 image,
 类别号 char(10)
FOREIGN KEY(类别号) REFERENCES 类别表(类别号)
);
go
CREATE TABLE 会员表
( 会员编号varchar(10)  primary key,                 
 会员姓名varchar(10),  
 会员性别char(4),
 会员邮箱varchar(20),
);
go 
CREATE TABLE 联系方式表
(会员编号 varchar(10) primary key,
电话 varchar(20),                 
  邮编 varchar(10),  
地址 char(20)
FOREIGN KEY(会员编号) REFERENCES 会员表(会员编号)
GO
CREATE TABLE 状态表
( 状态号 char(10)primary key,                 
 状态名 varchar(10));

go
CREATE TABLE 厂家表
( 厂家编号 char(10) primary key,                 
 厂家名称 char(10));
go 
CREATE TABLE 生产表
(
商品编号 char(10),
厂家编号 char(10),
上架时间 date,
primary key(商品编号,厂家编号),
FOREIGN KEY(商品编号) REFERENCES 商品表(商品编号),
FOREIGN KEY(厂家编号) REFERENCES 厂家表(厂家编号));
go 
CREATE TABLE 仓库表
( 商品编号 char(10)primary key,
	库存量 int,
	FOREIGN KEY(商品编号) REFERENCES 商品表(商品编号)
);
go 
CREATE TABLE 订购表
(订单编号  varchar(10),
会员编号 varchar(10),
商品编号 char(10),
数量 int,
提交时间 date,
状态号 char(10),
primary key(订单编号,会员编号,商品编号,状态号),
FOREIGN KEY(会员编号) REFERENCES 会员表(会员编号),
FOREIGN KEY(商品编号) REFERENCES 商品表(商品编号),
FOREIGN KEY(状态号) REFERENCES 状态表(状态号));
go 
CREATE VIEW 订单总价
 AS
  SELECT
    订单编号,商品名称,商品价格,数量,会员姓名,电话,会员邮箱,地址, 商品价格*数量 As 总价
  FROM
    订购表,商品表,会员表,联系方式表
  WHERE 订购表.商品编号=商品表.商品编号 AND 订购表.会员编号=会员表.会员编号 AND 会员表.会员编号=联系方式表.会员编号
 
