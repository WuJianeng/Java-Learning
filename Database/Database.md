# Databse



## 1.	数据库语言SQL

****

**SQL**:	用于数据库模式的数据**定义**子语言

​			用于**查询**和**更新**数据库的**数据操纵**子语言

### 1.1	在SQL中定义关系模式

****

#### 1.1.1	SQL中区分三种关系：

1. 存储的关系，成为表
2. 视图（view），通过计算来定义的关系。
3. 临时表，它是在执行数据查询和更新时由SQL处理程序临时构造。

#### 1.1.2     数据类型

1. 可变长度或固定长度字符串。`CHAR(n)`表示最大为n个字符的**固定长度**字符串。`VARCHAR(n)`表示最多可有n个字符的字符串，`VARCHAR`类型会使用一个结束符或者字符长度值来标志字符串的结束。
2. 固定或可变长度的位串。`BIT(n)`表示长度为n的位串，`BIT VARYING(n)`表示长度最大为n的位串。
3. 表示具有逻辑类型`BOOLEAN`。注意，其值包含`TRUE`、`FALSE`、`UNKNOWN`。
4. 时间与日期类型。对于日期，有`DATE`类型，格式为`'2019-09-18'`。对于日期，有`TIME`类型，格式为`'18:05:30.5'`。注意：`TIME`类型中秒可以有小数，且为24小时制。
5. 整数类型。`INT`和`INTEGER`均表示整数类型，它们为同义词。而`SHORTINT`也表示整型，只不过它可表示的范围更小。
6. 浮点数：`FLOATE`、`REAL`为同义词，表示典型的浮点数类型。如果需要更高精度的浮点数，可以用`DOUBLE PRECISION`类型。同时，SQL还提供特定小数点后位数的浮点数类型，例如`DECIMAL(n,d)`允许表示具有n位有效数字和小数点在有数第d位的位置（是指小数点后具有d位有效数字？）。

#### 1.1.3    简单的表定义

```sql
CREATE TABLE Movies(
	title		CHAR(100),
    year		INT,
    length		INT,
    genre		CHAR(10),
    studioName	CHAR(30),
    producerC#	INT
);
```

```sql
CREATE TABLE Moviestar(
	name		CHAR(30),
    address		VARCHAR(255),
    gender		CHAR(1),
    birthdate	DATE
);
```

#### 1.1.4	修改关系模式

1）	删除关系：

`DROP TABLE Movie;`

2)	修改操作以`ALTER TABLE`，后面可以接上几种选项

1. `ADD`后面加上属性名字和数据类型
2. `DROP`后面加上属性名字

例：

```sql
ALTER TABLE Moviestar DROP birthdate;
ALTER TABLE Moviestar ADD phone CHAR(16);
```

#### 1.1.5	默认值

如果在声明某个属性时加上`DEFAULT 类型值`，则在插入或修改元组并且元组该属性并没有赋值时，就会赋上默认值。

例：

```sql
gender CHAR(1) DEFAULT '?',
birthdate DATE DEFAULT DATE '0000-00-00'#此处DEFALUT后面需要DATE是因为不会被认为是字符串
```

#### 1.1.6	声明键

`CREATE TABLE`在定义一个存储的关系时，由两种方法将某一个属性或者一组属性定义为键。

1）	当属性列入关系模式时，声明为键。

2）	在模式声明的项目表中增加表项，声明一个或多个属性为键。

键的声明具有两种方式：

1）	`PRIMARY KEY`：不允许key为`NULL`

2）	`UNIQUE`:	允许key为`NULL`

例：

```sql
CREATE TABLE MovieStar(
	name 		CHAR(30)	PRIMARY KEY,
    address 	VARCHAR(255),
    gender		CHAR(1),
    birthdate	DTAE
);
```

```sql
CREATE TABLE MovieStar(
	name 		CHAR(30),
	address		VARCHAR(255),
	gender		CHAR(1),
	birthdate 	DATE,
	PRIMARY KEY(name)
);
```

当键由多个属性构成时，必须使用下面这种方式：

```sql
CREATE TABLE Movies(
	title 		CHAR(100),
    year		INT,
    length		INT,
    genre		CHAR(10),
    studioName	CHAR(30),
    producerC#	INT,
    PRIMARY KEY(title, year)
);
```



### 1.2	SQL的简单查询

****

例：

```sql
SELECT *
FROM Movies
WHERE studioName = 'Disney' AND year = 1990;
```

#### 1.2.1	SQL中的投影

```sql
SELECT title, length
FROM Movies
WHERE studioName = 'Disney' AND year = 1990;
```

`AS`可以给属性等起别名

```sql
SELECT title AS name, length AS duration
FROM Movies
WHERE studioName = 'Disney' AND year = 1990;
```

对输出的属性进行运算并修改名称

```sql
SELECT title, length*0.016667 AS length, 'hrs.' AS inHours	//'hrs.'为新增的属性值，inHours为属性名称
FROM Movies
WHERE studioName = 'Disney' AND year = 1990;
```

#### 1.2.2	SQL中的选择

SQL中是不区分大小写的，包括保留字、关系名、属性名和别名，只有引号当中的字符需要区分大小写。

**运算符：**

|  =   |    等于    |
| :--: | :--------: |
|  <>  |   不等于   |
|  <   |    小于    |
|  >   |    大于    |
|  <=  | 小于或等于 |
|  >=  | 大于或等于 |

字符串连接运算： 

```sql
'foo' || 'bar'	==>结果为'foobar'
```

字符串比较运算：

```sql
studioName = 'Disney'
```

逻辑运算符：

`AND`、`OR`、`NOT`

优先级：	`NOT`>`AND`>`OR`

#### 1.2.3	字符串比较

`<`、`<=`、`>`、`>=`、`=`

按照字典序进行比较

#### 1.2.4	SQL中的模式匹配

```sql
s LIKE p
s NOT LIKE p
```

其中`s`是字符串，`p`是模式。

对于模式`p`中，`%`能匹配任何长度的字符串，`_`能匹配任意一个字符。

例：

```sql
SELECT title
FROM Movies
WHERE title LIKE 'Star ____';
```

```sql
SELECT title
FROM Movies
WHere title LIKE '%''%''
```

SQL 约定，在字符串中连续两个`'`表示一个单引号，而不视为字符串的结束。

转义字符：SQL中并没有特定的转义字符，对于单个SQL允许临时将某个特定字符当成转义字符。

```sql
a LIKE 'x%%x%' ESCAPE 'x' //将'x'当作转义字符
```

#### 1.2.5	日期与时间

日期常量：`DATE '2015-09-18'`

时间常量：`TIME '18:06:07.5'`

#### 1.2.6	空值和涉及空值的比较

SQL允许属性有一个特殊值`NULL`，称作空值。

对于空值，有几种不同的解释：

1）	未知值（`value unknown`）：即知道它有一个值，但是不知道是什么

2）	不适用的值（`value inapplicable`）：”任何值在这里都没有意义

3）	保留的值（`value withheld`）：“属于某对象但无权知道的值”

当与`NULL`进行运算时，有以下几个规则：

1）	对`NULL`和任何值（包括`NULL`）进行算数运算（如`*`和`+`时），其结果仍为空值

2）	当使用比较运算符，如`>`或`=`，比较`NULL`与任意值（包括`NULL`）时，结果都为`UNKNOWN`

#### 1.2.7	布尔值`UNKNOWN`

​	`TRUE`、`FALSE`、`UNKNOWN`等均为SQL中布尔值的取值。在做下述运算时，为方便记忆，可暂时将`TRUE`当成1，`UNKNOWN`当成0.5，`FALSE`当成0。那么：

1）	布尔值之间的`AND`运算：取二者较小值

2）	`OR`运算：取二者较大值

3）	`NOT`运算：取`1-x`

#### 1.2.8	输出排序

`ORDER BY`：对查询结果按照要求来排序

排序的默认顺序为升序，但可以通过给某个属性加上保留字`DESC`使其按照降序排序

```sql
SELECT *
FROM Movies
ORDER BY title, year DESC；
```

排序时，上述`Movies`关系中所有的属性都可以作为排序的标准，但是最后并不一定会`SELECT`子句包含

### 1.3	多关系查询

****

#### 1.3.1	SQL中的积和连接

处理多个关系：在`FROM`中列出多个关系，然后就可以在`SELECT`和`WHERE`中使用这些关系中的属性。

例子：存在以下两个关系，找出电影Star Wars的制片人名字

`Movies(title, year, length, genre, studioName, producerC#)`

`MovieExec(name, address, cert#, networth)`

```sql
SELECT name
FROM Movies, MovieExec
WHERE cert# = producerC# AND title = 'Star Wars';
```

#### 2.3.2	消除属性歧义

当两个或多个关系中出现了相同的属性名称，就需要通过关系指出其具体是哪个关系中的属性。

例子：

`MovieStar(name, address, gender, birthdate)`

`MovieExec(name, address, cert#, netWorth)`

找出地址相同的影星和制片人

```sql
SELECT MovieStar.name AS starName, MovieExec.name AS execName
FROM MovieStar, MovieExec
WHERE MovieStar.address = MovieExec.address;
```

#### 2.3.3	元组变量

当查询使用到同一个关系的两个或多个元组时，可以在`FROM`中将关系列出多次，并给其定义一个别名：

```sql
SELECT Star1.name, Star2.name
FROM MovieStar AS Star1, MovieStar AS Star2 //其中，AS可以省略
WHERE Star1.address = Star2.address
	  AND Star1.name < Star2.name;
```

#### 2.3.4	多关系查询的解释

`SELECT-FROM-WHERE`类似于循环语句，从当前的关系中的每个元组进行遍历，并赋值给复制给元组变量进行替代，如果`WHERE`中的结果为`TRUE`，则产生一个由`SELECT`语句决定的结果。

#### 2.3.5	查询中的并、交、差

保留字`UNION`、`INTERSECT`、`EXCEPT`分别对应并、交、差。

当`UNION`等保留字应用于两个查询时，每个都应该用括号括起来。

例子：找出那些既是女星又同时是具有超过$10,000,000资产的制片人的名字和地址，使用下面两个关系：

`MovieStar(name, address, gender, birthdate)`

`MovieExec(name, address, cert#, netWorth)`

```sql
(SELECT name, address
From MovieStar
WHERE gender = 'F')
	INTERSECT
(SELECT name, address
FROM MovieExec
WHERE netWorth > 10000000)
```

习题P158 6.2.2根据下面的数据库模式和数据写出下面的查询：

`Product(maker, model, type)`

`PC(model, speed, ram, hd, price)`

`Laptop(model, speed, ram, hd, screen, price)`

`Printer(model, color, type, price)`

f）查询生产至少两种速度至少为3.0的电脑（PC或者笔记本电脑）的厂商。

```sql
SELECT maker
FROM(	SELECT maker, COUNT(maker) AS num
    	FROM ((SELECT maker, Product.model AS model, speed
            	FROM Product, PC
            	WHERE Product.model = PC.model AND speed > 3.0)
                	UNION
            	(SELECT maker,Product.model AS model, speed
            	FROM Product, Laptop
            	WHERE Product.model = Laptop.model AND speed > 3.0))
    	GROUP BY maker)
WHERE num >= 2;
```

