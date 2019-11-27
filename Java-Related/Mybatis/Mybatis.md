# Mybatis框架

## 1 框架

### 1.1 框架概念

框架是软件开发中的一套解决方案，不同的框架的解决的是不同的问题。

使用框架的好处：

​	框架封装了很多的细节，使得开发者可以使用极简的方式实现功能，大大地提高开发效率。

### 1.2 三层架构

表现层：用于展示数据

业务层：处理业务需求

持久层：和数据库交互

### 1.3 持久层技术解决方案

JDBC技术：

Connection

PreparedStatement

ResultSet

 Spring的JdbcTemplate：Spring中对jdbc的简单封装

Apache的DBUtils：和Spring的JdbcTemplate很想，也是对Jdbc的简单封装

以上都不是框架，JDBC是规范，Spring的JdbcTemplate和Apache的DBUtils都只是工具类



## 2 Mybatis框架概述

 mybatis是一个优秀的基于java的持久层框架。

​	它内部封装了jdbc，使开发者只需要关注sql语句本身，而不需要花费精力去处理加载驱动、创建连接、创建statement等复杂的过程。

​	它使用了ORM思想实现了结果集的封装。

ORM: Object Relational Mapping 对象关系映射

​			即，把数据库表和实体类以及实体类的属性对应起来，让我们把可以操作实体类就实现操作数据库表。



## 3 Mybatis入门

### 3.1 Mybatis环境搭建

1. 创建maven工程并导入坐标
2. 创建实体类和dao接口
3. 创建Mybatis主配置文件SqlMapConfig.xml
4. 创建映射配置文件IUserDao.xml

环境搭建的注意事项：

- 创建IUserDao.xml和IUserDao.java时，名称是为了和之前的知识保持一致。在Mybatis中，把持久层的操作接口名称和映射文件也叫做：Mapper。所以：IUserDao和IUserMapper是一样的。
- 在IDEA中创建目录的时候，和包是不一样的。
- mybatis的映射配置文件位置必须和dao接口的包结构相同
- 映射配置文件的mapper标签namespace属性的取值必须是dao接口的全限定类名
- 映射配置文件的操作配置(select)，id属性的取值必须是dao接口的方法名

当遵守了第三、四、五点之后，在开发中就无需再写dao的实现类。

### 3.2 Mybatis入门案例

1. 读取配置文件
2. 创建SqlSessionFactory工厂
3. 创建SqlSession对象
4. 创建Dao接口的代理对象
5. 执行dao中的方法
6. 释放资源

注意事项：

​	不要忘记在映射配置中忘记告诉mybatis要封装到哪个实体类中。

​	配置的方式：指定实体类的全限定类名

mybatis基于注解的入门案例：

​	把IUserDao.xml移除，在dao接口的方法上使用@Select注解，并且指定SQL语句。同时需要在SqlMapConfig.xml中的mapper配置时，使用class属性指定dao接口全限定类名。

明确：

​	在实际开发中，都是越简单越好，所以都是采用不写dao实现类的方式。

不管使用XML还是注解方式。