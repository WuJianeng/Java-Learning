摘自：微信公众号 `程序员欣宸` 

源地址链接：  [Docker下手工配置MySQL主从](https://mp.weixin.qq.com/s?__biz=Mzg5MDIyODcyOQ==&mid=2247484119&idx=1&sn=cb18c0648ed9a3b9703b8a2b2c6a9c57&chksm=cfde9841f8a91157653adff81c15f9ae1953368277efbdfaf19db71678e2b0a6027c6616000b&scene=0&xtrack=1&key=09084f502895ddad4882a50033d8eac6e435677cb619844e58f484d0e06270f141d85f5539b6e1c409eff8ba630f844adc2b6506819c20102cf0a222985c9d6999d9089feb83257de4247423f2ded8b6&ascene=1&uin=MjI3MTc1MjgyOQ%3D%3D&devicetype=Windows+10&version=62070158&lang=zh_CN&exportkey=AZpOTJ9El8ZF3SFcevWmOF0%3D&pass_ticket=9cnQkJwK9vZTX5emm9qyJm5tb9AmOt8nXgGpclW%2BLe4LQmUR8GdletJ%2BbvyKocsS )

本章在 Docker 环境下创建两个 MySQL 容器，再配置成一主一从，今天的配置都是手工输入命令完成的，这么做是为了熟悉 MySQL 主从配置的基本步骤，为接下来的实战打好基础，后面的章节中，我们自制 MySQL 主从镜像，实现以最简化的方式搭建一个 MySQL 主从环境；

动手前我们先将所有步骤逐一列举出来：

### master容器上的操作步骤列表

1. 创建master容器；
2. 配置master，开启log-bin，设置server-id；
3. 重启容器；
4. 创建用于同步的用户账号；
5. 授权用户同步；
6. 刷新权限；
7. 查看状态；

### slave容器上的操作步骤列表

1. 创建slave容器；
2. 设置server-id；
3. 重启容器；
4. 设置同步；
5. 启动同步；
6. 查看状态；

接下来我们就开始实战吧；

### 实战环境

1. 当前电脑的操作系统是Ubuntu 16.04.3 LTS；
2. docker 的版本信息如下：

```
Client: Version:      17.03.2-ce 
	API version:  1.27 
	Go version:   go1.7.5 
	Git commit:   f5ec1e2 
	Built:        Tue Jun 27 03:35:14 2017 
	OS/Arch:      linux/amd64
	
Server: 
	Version:      17.03.2-ce 
	API version:  1.27 (minimum version 1.12) 
	Go version:   go1.7.5 Git commit:   f5ec1e2 
	Built:        Tue Jun 27 03:35:14 2017 
	OS/Arch:      linux/amd64 Experimental: false
```

### master操作

1. 创建 master 容器，在 docker 环境执行以下命令：

```bash
docker run \
--name master \
-e MYSQL_ROOT_PASSWORD=888888 \
-idt \mysql:5.7.21
```

2. 执行 docker exec -it master /bin/bash 进入容器；
3. 执行命令 cat /etc/hosts查看容器的IP地址，如下：

```bash
root@8415bf7ba565:/# cat /etc/hosts
127.0.0.1       localhost
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnetff00::0 ip6-mcastprefix
ff02::1 ip6-allnodesff02::2 ip6-allrouters
172.17.0.2      8415bf7ba565
```

如上所示，master容器在docker环境下的 IP 地址为 172.17.0.2，“8415bf7ba565” 是容器的 ID ，这个 ID 在宿主机执行 docker ps 命令时可以看到；

4. 执行 apt-get update 更新 apt；
5. 执行 apt-get install -y vim安装vim工具
6. 打开文件 /etc/mysql/my.cnf，在尾部新增三行，内容如下：

```bash
[mysqld]
log-bin=mysql-bin
server-id=1
```

以上配置的作用是开启bin-log，并且设置自己在集群中的id；

7. 执行exit命令退出容器，再执行docker restart master重启容器；

8. 重启成功后再次进入master容器，执行命令mysql -uroot -p进入mysql命令行，按照提示输入密码"888888"，成功进入，如下图：![img](D:\GitRepo\Learning-Notes\CloudRelated\Docker\pictures\docker_mysql_master.png)
9. 执行以下命令，创建用于同步的用户账号rep，密码是888888：

```mysql
CREATE USER 'rep'@'%' IDENTIFIED BY '888888';
```

10. 执行以下命令，授权用户同步：

```
GRANT REPLICATION SLAVE ON *.* TO 'rep'@'%';
```

11. 执行以下命令刷新权限：

```
flush privileges;
```

12. 执行命令show master status;查看同步状态，如下，请关注下表的File和Position这两个字段的值 ：

```
mysql> CREATE USER 'rep'@'%' IDENTIFIED BY '888888';
Query OK, 0 rows affected (0.00 sec)
mysql> GRANT REPLICATION SLAVE ON *.* TO 'rep'@'%';Query OK, 0 rows affected (1.62 sec)
mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)
mysql> show master status;
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000001 |      745 |              |                  |                   |
+------------------+----------+--------------+------------------+-------------------+
1 row in set (0.00 sec)
```

1. 与master相关的三个重要参数如下表所示，在设置slave的时候会用到：

| 参数名          | 参数值           |
| :-------------- | :--------------- |
| master IP地址   | 172.17.0.2       |
| bin log文件名   | mysql-bin.000001 |
| bin log执行位置 | 745              |

至此，master已经设置成功，接下来设置slave吧，

### slave操作步

1. 创建slave容器，在docker环境执行以下命令：

```bash
docker run \
--name slave \
-e MYSQL_ROOT_PASSWORD=888888 \
-idt \
mysql:5.7.21
```

1. 执行docker exec -it slave /bin/bash进入容器
2. 执行apt-get update更新apt；
3. 执行apt-get install -y vim安装vim工具；
4. 打开文件/etc/mysql/my.cnf，在尾部新增两行，内容如下：

```bash
[mysqld]
server-id=2
```

以上配置的作用是设置自己在集群中的id；6. 执行exit命令退出容器，再执行docker restart slave重启容器；7. 重启成功后再次进入slave容器，执行命令mysql -uroot -p进入mysql命令行，按照提示输入密码"888888"，成功进入；8. 在MySQL的命令行执行以下命令，设置主从同步的参数：

```bash
CHANGE MASTER TO MASTER_HOST='172.17.0.2', \
MASTER_USER='rep', \
MASTER_PASSWORD='888888', \
MASTER_LOG_FILE='mysql-bin.000001', \
MASTER_LOG_POS=745;
```

MASTER_HOST是master的IP地址；MASTER_USER和MASTER_PASSWORD是master授权的同步账号和密码；MASTER_LOG_FILE是master的bin log文件名；MASTER_LOG_POS是bin log同步的位置；9. 在MySQL命令行执行start slave;启动同步；10. 在MySQL命令行执行show slave status\G查看同步状态，如下:

```bash
mysql> CHANGE MASTER TO MASTER_HOST='172.17.0.2', \    -> MASTER_USER='rep', \    -> MASTER_PASSWORD='888888', \    -> MASTER_LOG_FILE='mysql-bin.000001', \    -> MASTER_LOG_POS=745;Query OK, 0 rows affected, 2 warnings (1.68 sec)mysql> start slave;Query OK, 0 rows affected (0.04 sec)
mysql> show slave status\G
*************************** 1. row ***************************               Slave_IO_State: Waiting for master to send event                 
Master_Host: 172.17.0.2                  
Master_User: rep                  
Master_Port: 3306                
Connect_Retry: 60              
Master_Log_File: mysql-bin.000001          
Read_Master_Log_Pos: 745               
Relay_Log_File: a2adc636bc4e-relay-bin.000002                
Relay_Log_Pos: 320        
Relay_Master_Log_File: mysql-bin.000001             
Slave_IO_Running: Yes            
Slave_SQL_Running: Yes              
Replicate_Do_DB:           
Replicate_Ignore_DB:            
Replicate_Do_Table:        
Replicate_Ignore_Table:       
Replicate_Wild_Do_Table:   
Replicate_Wild_Ignore_Table:                    
Last_Errno: 0                   
Last_Error:                  
Skip_Counter: 0          
Exec_Master_Log_Pos: 745              
Relay_Log_Space: 534              
Until_Condition: None               
Until_Log_File:                 
Until_Log_Pos: 0           
Master_SSL_Allowed: No           
Master_SSL_CA_File:            
Master_SSL_CA_Path:               
Master_SSL_Cert:             
Master_SSL_Cipher:                
Master_SSL_Key:         
Seconds_Behind_Master: 0Master_SSL_Verify_Server_Cert: No                
Last_IO_Errno: 0                
Last_IO_Error:                
Last_SQL_Errno: 0               
Last_SQL_Error:   
Replicate_Ignore_Server_Ids:              
Master_Server_Id: 1                  
Master_UUID: c4a1fd87-33ca-11e8-8bdf-0242ac110002             
Master_Info_File: /var/lib/mysql/master.info                    
SQL_Delay: 0          
SQL_Remaining_Delay: NULL      
Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates           Master_Retry_Count: 86400                  
Master_Bind:       
Last_IO_Error_Timestamp:      
Last_SQL_Error_Timestamp:                
Master_SSL_Crl:            
Master_SSL_Crlpath:            
Retrieved_Gtid_Set:             
Executed_Gtid_Set:                 
Auto_Position: 0         
Replicate_Rewrite_DB:                  
Channel_Name:            
Master_TLS_Version: 1 row in set (0.00 sec)
```

检查以上信息中的 Slave_IO_Running 和 Slave_SQL_Running 两个字段的值，如果都是Yes就表示同步启动成功，否则代表启动失败，Slave_SQL_Running_State 字段会说明失败原因；

至此，MySQL 主从同步已经完成，接下来一起验证一下吧；

### 验证主从同步

1. 进入master容器的MySQL命令行，执行以下四个命令，完成创建数据库、选择数据库、创建表、新增记录等操作：

```
create database test001;use test001;CREATE TABLE `test_table` (  `id` int(11) NOT NULL AUTO_INCREMENT,  `name` varchar(100) DEFAULT NULL,  PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;insert into test_table(name) values ('jerry');
```

1. 进入slave容器的MySQL命令行，选择test001数据库，可以看到表test_table和记录都已经同步过来了，如下：

```
mysql> show databases;
+--------------------+| Database|+--------------------+| 
information_schema
mysql
performance_schema
sys
test001
+--------------------+
5 rows in set (0.05 sec)
mysql> use test001;
Reading table information for completion of table and column namesYou can turn off this feature to get a quicker startup with -ADatabase changed
mysql> select * from test_table;
+----+-------+| id | name  |+----+-------+|
1 | jerry |
+----+-------+
1 row in set (0.00 sec)
```

至此，Docker 下手工配置 MySQL 主从的实战就完成了，经过这次实战我们熟悉了整个设置的过程，接下来的章节我们将这些配置都做进自制的镜像中，实现支持主从同步的docker镜像，这样容器启动后无需设置就支持同步了；