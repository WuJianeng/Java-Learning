# Mysql知识点

参考自《Mysql必知必会》以及网上的教程等等



## 1	使用Mysql

### 1.1	选择数据库

格式： USE [DatabaseName]

```sql
USE mysql;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573548076049.png" alt="1573548076049" style="zoom:80%;" />

### 1.2	了解数据库和表

#### 1.2.1	显示数据库列表

```sql
SHOW DATABASES;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573548286067.png" alt="1573548286067" style="zoom:80%;" />

#### 1.2.2	显示可用的表

显示当前先择的数据库内可用的表（需要提前选中某个数据库）：

```sql
SHOW TABLES;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573548353316.png" alt="1573548353316" style="zoom:80%;" />

#### 1.2.3	显示表的字段信息

显示某个表的每个字段的详细信息：

```
SHOW COLUMNS FROM user;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573548692910.png" alt="1573548692910" style="zoom:80%;" />

等效方法：

```
DESCRIBE user;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573548833044.png" alt="1573548833044" style="zoom:80%;" />

#### 1.2.4	其他SHOW语句

（1）SHOW STATUS，用于显示广泛的服务器状态信息

（2）SHOW CREATE DATABASE和SHOW CREATE TABLE，分别用来显示创建特定数据库或表的MySQL语句

（3）SHOW GRANTS，用来显示授予用于（所有用户或特定用户）的安全权限

（4）SHOW ERRORS和SHOW WARNINGS，用来显示服务器错误或警告信息。



## 2	检索数据

### 2.1	SELECT语句

从一个或多个表中检索信息

### 2.2	检索单个列

```sql
SELECT prod_name
FROM products;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573558866608.png" alt="1573558866608" style="zoom:80%;" />

### 2.3	检索多个列

```sql
SELECT prod_id, prod_name, prod_price
FROM products;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573558945255.png" alt="1573558945255" style="zoom:80%;" />

### 2.4	检索所有列

```sql
SELECT *
FROM products;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573559005434.png" alt="1573559005434" style="zoom: 67%;" />

除非确实需要表中的每个列，否则最好不要使用通配符*。检索不需要的列会降低检索和应用程序的性能。

### 2.5	检索不同的行

```sql
SELECT DISTINCT vend_id
FROM products;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573559168173.png" alt="1573559168173" style="zoom:80%;" />![1573559371253](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573559371253.png)

使用`DISTINCT`关键字会去除重复的值

### 2.6	限制结果

```sql
SELECT prod_name
FROM products
LIMIT 5;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573559400549.png" alt="1573559400549" style="zoom: 80%;" />

LIMIT 5指示MySQL返回**不多于**5行。

LIMIT 5,5指示MySQl返回从第5行开始的5行。其中第一个数表示开始的位置，第二个数表示要检索的行数。

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573559638766.png" alt="1573559638766" style="zoom:80%;" />

从上图中也可以看出，数据库的第一行为行0，即行计数从0开始。

### 2.7	使用完全限定的表名

```sql
SELECT products.prod_name
FROM products;
```

```sql
SELECT products.pro_name
FROM crashcourse.products;
```

其中crashcourse是数据库名称，products是表名。



## 3	排序检索数据

### 3.1	排序数据

ORDER BY子句可以对一个或多个列进行排序

```sql
SELECT prod_name
FROM products
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573711780685.png" alt="1573711780685" style="zoom:80%;" />

### 3.2	按多个列排序

```sql
SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price, prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573712157264.png" alt="1573712157264" style="zoom:80%;" />

对于上述例子：

先按照prod_price进行排序，对于prod_price相同的列再按照prod_name进行排序。

### 3.3	指定排序方向

数据的排序方向默认为升序。如果要进行降序排序，则应当指定DESC关键字。

```sql
SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price DESC, prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573712397512.png" alt="1573712397512" style="zoom:80%;" />

从例子中可以看出：

整体先按照prod_price降序进行排序，对于prod_price相同的行，按照prod_name升序进行排序。

**DESC**只应用在直接位于其前面的列名。

与DESC相反的升序排序关键字为ASC，但升序是默认的，故一般不使用。



## 4	过滤数据

### 4.1	使用WHERE子句

只检索所需数据需要指定搜索条件，搜索条件又称为过滤条件。

```sql
SELECT prod_name, prod_price
FROM products
WHERE prod_price = 2.50;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573712863087.png" alt="1573712863087" style="zoom:80%;" />

### 4.2	WHERE子语句操作符

- [ ] 表1	WHERE子语句操作符

| 操作符  |     说明     |
| :-----: | :----------: |
|    =    |     等于     |
|   <>    |    不等于    |
|   !=    |    不等于    |
|    <    |     小于     |
|   <=    |   小于等于   |
|    >    |     大于     |
|   >=    |   大于等于   |
| BETWEEN | 在指定值之间 |

#### 4.2.1	检查单个值

```sql
SELECT prod_name, prod_price
FROM products
WHERE prod_name = 'fuses';
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573713378429.png" alt="1573713378429" style="zoom:80%;" />

#### 4.2.2	不匹配检查

```sql
SELECT vend_id, prod_name
FROM products
WHERE vend_id <> 1003;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573713563887.png" alt="1573713563887" style="zoom:80%;" />

对于字符串，需要使用单引号，而数值则不需要。

#### 4.2.3	范围值检查

为了检查值处于某个范围时，可以使用BETWEEN操作符。

```sql
SELECT prod_name, prod_price
FROM products
WHERE prod_price BETWEEN 5 AND 10;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573713805919.png" alt="1573713805919" style="zoom:80%;" />

#### 4.2.4	空值检查

当一个列不包含值时，称其为包含空值NULL。

```sql
SELECT prod_name
FROM products
WHERE prod_price IS NULL;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573714009936.png" alt="1573714009936" style="zoom:80%;" />

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573714063430.png" alt="1573714063430" style="zoom:80%;" />



## 5	数据过滤

### 5.1	组合WHERE子句

MySQL允许WHERE子句中使用多个条件进行组合，可以使用AND、OR。

#### 5.1.1	AND操作符

```sql
SELECT prod_id, prod_price, prod_name
FROM products
WHERE vend_id = 1003 AND prod_price <= 10;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573714268399.png" alt="1573714268399" style="zoom:80%;" />

#### 5.1.2	OR操作符

```sql
SELECT prod_name, prod_price, vend_id
FROM products
WHERE vend_id = 1002 OR vend_id = 1003;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573714411664.png" alt="1573714411664" style="zoom:80%;" />

#### 5.1.3	计算次序

当一个WHERE子句中包含AND和OR操作符时，AND操作符具有更高的优先级。

```sql
SELECT prod_name, prod_price
FROM products
WHERE vend_id = 1002 OR vend_id = 1003 AND prod_price >= 10;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573714643217.png" alt="1573714643217" style="zoom:80%;" />

可以使用圆括号明确地分组相应的操作符。

```sql
SELECT prod_name, prod_price
FROM products
WHERE (vend_id = 1002 OR vend_id = 1003) AND prod_price >= 10;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573714964616.png" alt="1573714964616" style="zoom:80%;" />

### 5.2	IN操作符

**IN**操作符用来指定条件范围，范围中的每个条件都可以进行匹配。

IN取合法值的由逗号分隔的清单，全部都括在圆括号中。

```sql
SELECT prod_name, prod_price, vend_id
FROM products
WHERE vend_id IN (1002, 1003, 1001)
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573715189128.png" alt="1573715189128" style="zoom:80%;" />

### 5.3	NOT操作符

NOT用来否定它之后所跟的任何条件。

```sql
SELECT prod_name, prod_price, vend_id
FROM products
WHERE vend_id NOT IN (1002, 1003)
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573715378519.png" alt="1573715378519" style="zoom:80%;" />

**MySQL只支持对IN、BETWEEN、EXISTS子句取反**



## 6	用通配符进行过滤

### 6.1	LIKE操作符

通配符（wildcard）：用来匹配值的一部分的特殊字符。

搜索模式（search pattern）：由字面值、通配值或两者组合构成的搜索条件。

#### 6.1.1	百分号（%）通配符

百分号%表示任何字符出现任意次数。

例如查找jet开头的产品：

```sql
SELECT prod_name
FROM products
WHERE prod_name LIKE 'jet%';
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573716043671.png" alt="1573716043671" style="zoom:80%;" />

注意：根据MySQL的配置方式，MySQL中搜索可以是区分大小写的。

注意：百分号%不能够匹配NULL。

#### 6.1.2	下划线`_`通配符

下划线`_`只匹配单个字符。

```sql
SELECT prod_name
FROm products
WHERE prod_name LIKE '_ ton anvil';
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573716352627.png" alt="1573716352627" style="zoom:80%;" />

#### 6.1.3	使用通配符的技巧

使用通配符搜索的处理一般要比前面的搜索方式所花时间长。

以下一些方法可以缩短搜索时间：

- 不要过度使用通配符。如果其他操作符可以达到同样的目的，应当使用其他操作符。
- 除非绝对有必要，否则不要把通配符放在搜索模式的开始处。把通配符放在开始处的搜索速度是最慢的。
- 注意通配符的位置，否则不会返回正确的数据



## 7	用正则表达式进行搜索

### 7.1	正则表达式介绍

正则表达式是用来匹配文本的特殊的串（字符集合）。

### 7.2	使用MySQL正则表达式

MySQl使用WHERE子句对正则表达式提供初步支持，允许指定正则表达式过滤SELECT检索出的数据。

#### 7.2.1	基本字符匹配

```sql
SELECT prod_name
FROM products
WHERE prod_name REGEXP '1000'
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573717064143.png" alt="1573717064143" style="zoom:80%;" />

```sql
SELECT prod_name
FROM products
WHERE prod_name REGEXP '.000'
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573717155295.png" alt="1573717155295" style="zoom:80%;" />

MySQL中的正则表达式匹配不区分大小写，为区分大小写，可使用BINARY关键字。

如：

```sql
WHERE prod_name REGEXP BINARY 'JetPack .000'
```

#### 7.2.2	进行OR匹配

```sql
SELECT prod_name
FROM products
WHERE prod_name REGEXP '1000|2000'
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573717443106.png" alt="1573717443106" style="zoom:80%;" />

#### 7.2.3	匹配几个字符之一

```sql
SELECT prod_name
FROM products
WHERE prod_name REGEXP '[123] ton'
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573717714040.png" alt="1573717714040" style="zoom:80%;" />

字符集合也可以被否定，即，匹配除指定字符外的任何字符。

**[^123]**

#### 7.2.4	匹配范围

集合可以用来定义要匹配的一个或多个字符。

**[0-9]与[0123456789]等效**

**[a-z]**可以匹配任何字母字符。

```sql
SELECT prod_name
FROM products
WHERE prod_name REGEXP '[0-5] Ton'
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573718045359.png" alt="1573718045359" style="zoom:80%;" />

#### 7.2.5	匹配特殊字符

如果要匹配特殊字符，像[、]、-、.、等，可以使用转义字符\\\\。

```sql
SELECT vend_name
FROM vendors
WHERE vend_name REGEXP '\\.'
ORDER BY vend_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573718292263.png" alt="1573718292263" style="zoom:80%;" />

同时，转义字符\\\\还可以用来引用元字符（具有特殊含义的字符）：

| 元字符 |   说明   |
| :----: | :------: |
|  \\\f  |   换页   |
|  \\\n  |   换行   |
|  \\\r  |   回车   |
|  \\\t  |   制表   |
|  \\\v  | 纵向制表 |

对于反斜杠\本身，需要使用\\\\\

#### 7.2.6	匹配字符类

|     类     |                          说明                          |
| :--------: | :----------------------------------------------------: |
| [:alnum:]  |            任意字母和数字（同[a-zA-Z0-9]）             |
| [:alpha:]  |                 任意字母（同[a-zA-Z]）                 |
| [:blank:]  |                 空格和制表（同[\\\t]）                 |
| [:cntrl:]  |            ASCII控制字符（ASCII0到31和127）            |
| [:digit:]  |                  任意数字（同[0-9]）                   |
| [:graph:]  |             与[:print:]相同，但不包括空格              |
| [:lower:]  |                      任意小写字母                      |
| [:print:]  |                     任意可打印字符                     |
| [:punct:]  |       既不在[:alnum:]又不在[:cntrl:]中的任意字符       |
| [:space:]  | 包括空格在内的任意空白字符（同[\\\f\\\n\\\r\\\t\\\v]） |
| [:upper:]  |                任意大写字母（同[A-Z]）                 |
| [:xdigit:] |           任意十六进制数字（同[a-fA-F0-9]）            |

#### 7.2.7	匹配多个实例

以下字符可以对匹配次数进行控制：

| 元字符 |           说明           |
| :----: | :----------------------: |
|   *    |     0或者多个怕匹配      |
|   +    |      1或者多个匹配       |
|   ?    |       0或者1个匹配       |
|  {n}   |         n个匹配          |
| {n, }  |      不少于n个匹配       |
| {n,m}  | n到m个匹配（m不超过255） |

```sql
SELECT prod_name
FROM products
WHERE prod_name REGEXP '\\([0-9] sticks?\\)'
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573719438072.png" alt="1573719438072" style="zoom:80%;" />

```sql
SELECT prod_name
FROM products
WHERE prod_name REGEXP '[[:digit:]]{4}'
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573719630608.png" alt="1573719630608" style="zoom:80%;" />

[:digit:]要求匹配任意数字，因而它是一个数字集合。

{4}要求它前面的**字符**（任意数字）出现4次，所以[[:digit:]]{4}匹配连在一起的任意4位数字。

#### 7.2.8	定位符

为了匹配**特定位置**的文本，需要使用定位符：

| 元字符  |    说明    |
| :-----: | :--------: |
|    ^    | 文本的开始 |
|    $    | 文本的结尾 |
| [[:<:]] |  词的开始  |
| [[:>:]] |  词的结束  |

```sql
SELECT prod_name
FROM products
WHERE prod_name REGEXP '^[[:digit:]\\.]'
ORDER BY prod_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573720004809.png" alt="1573720004809" style="zoom:80%;" />



## 8	创建计算字段

### 8.1	计算字段

由于某些原因，存储在表中的数据都不是应用程序所需要的。需要从数据库中检索出转换、计算或格式化过的数据。

计算字段是运行时在SELECT子句中创建的。

### 8.2	拼接字段

使用拼接可以将值联结到一起构成单个值。

MySQL的SELECT子句中，可以使用`Concat()`函数来拼接列。

```sql
SELECT Concat(vend_name, '(', vend_country, ')')
FROM vendors
ORDER BY vend_name;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573720740509.png" alt="1573720740509" style="zoom:80%;" />

使用`RTrim()`函数可以去掉右边的所有空格。

使用`LTrim()`函数可以去掉左边所有的空格。

使用`Trim()`函数可以去掉两边所有的空格。

**使用别名**：

别名是一个字段或值的替换名，使用`AS`关键字赋予。

```sql
SELECT Concat(RTrim(vend_name), '(', RTrim(vend_country), ')') AS vend_title
FROM vendors
ORDER BY vend_name;
```



### 8.3	执行算术计算

```sql
SELECT prod_id, quantity, item_price, 
		quantity*item_price AS expanded_price
FROM orderitems
WHERE order_num = 20005;
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1573721417969.png" alt="1573721417969" style="zoom:80%;" />

算术运算包括：加减乘除，+-*/。

圆括号可以用来区分优先顺序。

## 22	使用视图

视图是虚拟的表，它不包含表中应该有的任何列或者数据，它包含的是一个SQL查询

- 视图用`CREATE VIEW viewname`语句来创建
- 使用`SHOW CREATE VIEW viewname`来查看创建视图的语句
- 用`DROP VIEW viewname`来删除视图
- 更新视图，`DROP OR REPLACE VIEW。
