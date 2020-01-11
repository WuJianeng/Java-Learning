摘自：微信公众号 `程序员欣宸` 

源地址链接： [Docker下mysql主从同步极速体验](https://mp.weixin.qq.com/s/3vRU-Xt7O3TNQXlIxh8BJQ)

从本章开始，我们来实战如何在Docker下快速搭建主从同步的 MySQL 环境，《Docker下MySQL主从三部曲》由以下三章组成：

1. 本章的内容，以最快的速度搭建和体验一主二从的 MySQL 主从环境；
2. 细说第一章中的环境背后的技术细节，主要是如何制作 MySQL 主从的镜像；
3. 验证bin log参数值对主从同步的影响；

### 文章目标

写《Docker下MySQL主从三部曲》的目标，是想利用docker制作一套 MySQL 主从的镜像文件，将搭建 MySQL 主从同步环境的步骤简化到极致；

### 设置主从同步的基本操作

实战前推荐阅读《[Docker下手工配置MySQL主从](http://mp.weixin.qq.com/s?__biz=Mzg5MDIyODcyOQ==&mid=2247484119&idx=1&sn=cb18c0648ed9a3b9703b8a2b2c6a9c57&chksm=cfde9841f8a91157653adff81c15f9ae1953368277efbdfaf19db71678e2b0a6027c6616000b&scene=21#wechat_redirect)》，里面介绍了手动设置MySQL主从同步的每个步骤，可以作为本章的准备工作；

### 实战环境

1. 当前电脑的操作系统是 Ubuntu 16.04.3 LTS； 

2.  docker的版本信息如下 

```bash
Client:
 Version:      17.03.2-ce
 API version:  1.27
 Go version:   go1.7.5
 Git commit:   f5ec1e2
 Built:        Tue Jun 27 03:35:14 2017
 OS/Arch:      linux/amd64

Server:
 Version:      17.03.2-ce
 API version:  1.27 (minimum version 1.12)
 Go version:   go1.7.5
 Git commit:   f5ec1e2
 Built:        Tue Jun 27 03:35:14 2017
 OS/Arch:      linux/amd64
 Experimental: false
```

3.  docker-compose版本信息如下： 

```

docker-compose version 1.18.0, build 8dd22a9
docker-py version: 2.7.0
CPython version: 2.7.12
OpenSSL version: OpenSSL 1.0.2g  1 Mar 2016
```



### 开始极速体验

1. 创建docker-compose.yml文件，内容如下：

```yaml
version: '2'
services:
  master: 
    image: bolingcavalry/mysql-master:0.0.1
    environment:
      MYSQL_ROOT_PASSWORD: 888888
      MYSQL_REPLICATION_USER: rep
      MYSQL_REPLICATION_PASSWORD: 888888
    volumes:
     - ./master:/etc/mysql/extend.conf.d
    restart: always
  slave0: 
    image: bolingcavalry/mysql-slave:0.0.1
    depends_on:
      - master
    links: 
      - master:masterhost 
    environment:
      MYSQL_ROOT_PASSWORD: 888888
      MYSQL_MASTER_SERVICE_HOST: masterhost
      MYSQL_REPLICATION_USER: rep
      MYSQL_REPLICATION_PASSWORD: 888888
    volumes:
     - ./slave0:/etc/mysql/extend.conf.d
    restart: always
  slave1:
    image: bolingcavalry/mysql-slave:0.0.1
    depends_on:
      - master
    links:
      - master:masterhost
    environment:
      MYSQL_ROOT_PASSWORD: 888888
      MYSQL_MASTER_SERVICE_HOST: masterhost
      MYSQL_REPLICATION_USER: rep
      MYSQL_REPLICATION_PASSWORD: 888888
    volumes:
     - ./slave1:/etc/mysql/extend.conf.d
    restart: always
```

2.  在docker-compose.yml文件平级的目录创建三个文件夹，名字分别是：master、slave0、slave1； 
3.  在master文件夹下创建文件master.cnf，内容如下： 

```json

[mysqld]
log-bin=mysql-bin
server-id=1
```

4.  在slave0文件夹下创建文件slave0.cnf，内容如下： 

```json
[mysqld]
server-id=2
```

5. 在slave1文件夹下创建文件slave1.cnf，内容如下： 

```json
[mysqld]
server-id=3
```

6.  完成上述操作后，文件和文件夹的情况如下所示： 

```bash

├── docker-compose.yml
├── master
│   └── master.cnf
├── slave0
│   └── slave0.cnf
└── slave1
    └── slave1.cnf

3 directories, 4 files
```

7.  在docker-compos.yml所在目录执行命令docker-compose up -d，立即开始下载镜像然后启动容器，此过程略耗时，请耐心等待，如下： 

```bash

Creating network "dockercompose_default" with the default driver
Pulling master (bolingcavalry/mysql-master:0.0.1)...
0.0.1: Pulling from bolingcavalry/mysql-master
...
fb86dffe37e3: Pull complete
Digest: sha256:1d66de68d7855ff6447bf0896de7e04db91f6d015faa3fa6c96f76225a592c9f
Status: Downloaded newer image for bolingcavalry/mysql-master:0.0.1
Pulling slave1 (bolingcavalry/mysql-slave:0.0.1)...
0.0.1: Pulling from bolingcavalry/mysql-slave
...
353ccce48dc1: Pull complete
86282305ffa7: Pull complete
6f57fa284461: Pull complete
Creating dockercompose_master_1 ... done
Status: Downloaded newer image for bolingcavalry/mysql-slave:0.0.1
Creating dockercompose_master_1 ... 
Creating dockercompose_slave1_1 ... done
Creating dockercompose_slave0_1 ... done
```

8.  执行命令docker ps，看到三个容器的信息如下： 

```bash
CONTAINER ID        IMAGE                              COMMAND                  CREATED             STATUS              PORTS               NAMES
e54cdfd72e9e        bolingcavalry/mysql-slave:0.0.1    "docker-entrypoint..."   2 minutes ago       Up 2 minutes        3306/tcp            dockercompose_slave1_1
1d2cc65d23af        bolingcavalry/mysql-slave:0.0.1    "docker-entrypoint..."   2 minutes ago       Up 2 minutes        3306/tcp            dockercompose_slave0_1
17025c108f2b        bolingcavalry/mysql-master:0.0.1   "docker-entrypoint..."   2 minutes ago       Up 2 minutes        3306/tcp            dockercompose_master_1
```

 为了方便后面的操作，用表格将三个容器信息列出： 

| 身份     | 容器ID       |
| :------- | :----------- |
| 主库     | 17025c108f2b |
| 第一从库 | 1d2cc65d23af |
| 第二从库 | e54cdfd72e9e |

 至此，一主二从的MySQL环境就搭建好了，接下来开始验证主从同步吧； 



### 验证主从同步

1. 执行docker exec -it 17025c108f2b /bin/bash进入主库容器；
2. 进入主库容器后，执行命令 mysql -uroot -p 进入 MySQL 命令行，按照提示输入密码"888888"，成功进入；
3. 在 MySQL 命令行执行 show master status，看到主库同步状态如下：

  

```mysql
mysql> show master status;
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000003 |      154 |              |                  |                   |
+------------------+----------+--------------+------------------+-------------------+
1 row in set (0.00 sec)
```

4. 在MySQL命令行执行以下四个命令，完成创建数据库、选择数据库、创建表、新增记录等操作：

```mysql
create database test001;

use test001;

CREATE TABLE `test_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into test_table(name) values ('jerry');
```

5.  退出主库容器，执行docker exec -it 1d2cc65d23af /bin/bash进入第一从库容器； 
6.  进入第一从库容器后，执行命令mysql -uroot -p进入MySQL命令行，按照提示输入密码"888888"，成功进入； 
7.  在MySQL命令行执行show slave status\G，看到第一从库同步状态如下： 

```mysql
mysql> show slave status\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: masterhost
                  Master_User: rep
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000003
          Read_Master_Log_Pos: 905
               Relay_Log_File: 1d2cc65d23af-relay-bin.000005
                Relay_Log_Pos: 1118
        Relay_Master_Log_File: mysql-bin.000003
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
          Exec_Master_Log_Pos: 905
              Relay_Log_Space: 3040769
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 383054c7-34ae-11e8-8ac5-0242ac120002
             Master_Info_File: /var/lib/mysql/master.info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
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
           Master_TLS_Version: 
1 row in set (0.00 sec)
```

8.  MySQL 命令行执行use test001; 选中数据库； 
9. 在 MySQL 命令行执行 select * from test_table; 查询数据，结果如下：

```mysql
mysql> use test001;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> select * from test_table;
+----+-------+
| id | name  |
+----+-------+
|  1 | jerry |
+----+-------+
1 row in set (0.00 sec)
```

可以看到主库的数据已经成功同步过来了，您可以继续检查第二从库的同步状况；

至此，极速体验 MySQL 主从同步的操作就结束了，比起《[Docker下手工配置MySQL主从](http://mp.weixin.qq.com/s?__biz=Mzg5MDIyODcyOQ==&mid=2247484119&idx=1&sn=cb18c0648ed9a3b9703b8a2b2c6a9c57&chksm=cfde9841f8a91157653adff81c15f9ae1953368277efbdfaf19db71678e2b0a6027c6616000b&scene=21#wechat_redirect)》的操作步骤，本章要简单很多，接下来的章节我们一起细看简单的背后所隐藏的技术；