## JDK源码分析（简单分析）



### 1	`java.lang`

#### 1.1	`Object`——所有类的父类

*****

主要方法：

##### 1.1.1	`getClass()`

```java
public final native Class<?> getClass();
```

带有`native`标记的方法为原生方法，它调用自系统的C/C++语言库。

`getClass()`方法为`final`方法，由于`Object`类被所有类继承，则所有类的`getClass`方法实现是一样的。

##### 1.1.2	`equals(Object obj)`

```java
public boolean equals(Object obj) {
        return (this == obj);
    }
```

注意：

1）由于所有类都继承自`Object`类。而如果子类不重写`Override`该方法，那么只有当两个引用自同一个对象时，才会返回`true`。

2）重写时，参数名称不能更改！！！参数必须为`Object obj`，否则就不是重写，而是重载。

##### 1.1.3	`toString()`

```java
public String toString() {
        return getClass().getName() + "@" + Integer.toHexString(hashCode());
    }
```

默认实现为返回该类的`类名+"@"+16位哈希值`

在`System.out.println()`等输出时，如果传入的参数包含对象，可以直接调用对应的`toString`方法输出。而如果`toString`方法没有重写的话，那么输出就会是`类名+"@"+16位哈希值`。

因此，`toString()`方法最好也重写。



#### 1.2	String

****

实现了`Serializable`、`Comparable<String>`、`CharSequence`接口

##### 1.2.1	成员变量`char value[]`

```java
private final char value[];
```

从成员变量`value[]`可以看出，`String`还是基于字符数组来存储的。

##### 1.2.2	构造函数

```java
//使用平台的默认字符集解码指定的字节数组来构造新的String
String(byte[] bytes)
//构造一个新的String用指定的字符集解码指定的字节数组解码charset 
String(byte[] bytes, Charset charset)
```

##### 1.2.3	`compareTo(String anotherString)`

按照字典序比较两个两个字符串的大小

小于则值为小于0，等于则值为0，大于则值大于0

##### 1.2.4	`startsWith(String prefix)`

测定是否以指定的前缀开头

```java
public boolean startsWith(String prefix);

//在指定位置开始判断是否为前缀
public boolean startsWith(String prefix, int toffset);

    
```

##### 1.2.5	`endsWith(String suffix)`

判断参数是否为后缀

##### 1.2.6	`indexOf(String str)`

返回指定子串的第一次出现的字符串的索引

##### 1.2.7	`substring(int beginIndex, int endIndex)`

```java
public String substring(int beginIndex, int endIndex);
```

返回该字符串的子串，且包含从`beginIndex`到`endIndex-1`之间的字符串。

##### 1.2.8	`replace(char oldChar, char newChar)`

```java
public String replace(char oldChar, char newChar);
```

返回从原字符串中将指定的字符`oldChar`全部替换为`newChar`。

##### 1.2.9	`split(String regex, int limit)`

```java
public String[] split(String regex, int limit);
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1571389362141.png" alt="1571389362141" style="zoom:80%;" />

##### 1.2.10	`join(CharSequence delimiter, CharSequence... elements)`

```java
public static String join(CharSequence delimiter, CharSequence... elements);
```

`delimiter`是分隔符，`elements`是要加入的元素

```java
String message = String.join("-", "Java","is","cool");
//返回"Java-is-cool"
```

##### 1.2.11	`join(CharSequence delimiter, Iterable<? extends CharSequence> elements)` 

```java
public static String join(CharSequence delimiter,
                          Iterable<? extends CharSequence> elements);
```

##### 1.2.12	`toLowerCase(Locale locale)`

基于指定的字符集映射转换成小写字符串

```java
public String toLowerCase(Lacale locale);
//使用默认语言环境的规则
public String toLowerCase();
//转换为大写字符串
public String toUpperCase(Locale locale);
public String toUpperCase();
```

##### 1.2.13	`trim()`

```java
//删除任何前导和尾随空格
public String trim();
```



#### 1.3	`StringBuilder`

****

`StringBuilder`是线程安全，可变的字符序列。

##### 1.3.1	构造方法

```java
//构造一个没有字符的字符串缓冲区，初始容量为16个字符
StringBuffer();
//构造一个包含与指定的相同字符的字符串缓冲区
StringBuffer(CharSequence seq);
//指定字符串缓冲区的初始容量
StringBuffer(int capacity);
StringBuffer(String str);
```

##### 1.3.2	`length()`

返回字符串长度

```java
public int length();
```

##### 1.3.3	`capacity()`

返回当前容量。容量是新插入字符可用的存储量。

```java
public int capacity();
```

##### 1.3.4	`append()`

```java
public StringBuffer append(Object obj);
public StringBuffer append(String str);
public StringBuffer append(...);
//将参数添加到该字符串末尾，会将指定参数转为obj.toString()然后再添加到字符串末尾
```

##### 1.3.5	`delete(int start, int end)`

```java
public StringBuffer delete(int start, int end);
```

删除指定范围内的字符串

##### 1.3.6	`replace(int start, int end, String str)`

```java
public StringBuffer replace(int start, int end, String str);
```

用字符串`str`替换指定区域范围的字符串

##### 1.3.7	`substring(int start)`

```java
public string substring(int start);
```

返回一个从`start`位置开始的子串

##### 1.3.8	`substring(int start, int end)`

```java
public String substring(int start, int end);
```

##### 1.3.9	`insert()`

##### 1.3.10	reverse()

```java
public StringBuffer reverse();
```

将字符串反转



1.4	`StringBuilder`

****

线程不安全，可变的字符序列。

##### 1.4.1	构造方法

```java
StringBuilder();
StringBuilder(CharSequence seq);
//确定字符串缓冲区容量
StringBuilder(int capacity);
StringBuilder(String str);
```

##### 1.4.2	`append()`

```java
public StringBuilder append(...);
//可以将大多数类的对象添加到字符串缓冲区对象中
```

##### 1.4.3	`capacity()`

返回容量

##### 1.4.4	`length()`

返回长度

##### 1.4.5	`delete(int start, int end)`

删除指定的子串

##### 1.4.6	`replace(int start, int end, String str)`

将指定区域的子串替换成`str`

##### 1.4.7	`reverse()`

将字符序列反转