# Java

**Java成员变量数字类型，默认为0**



## 1.	IDEA



### 1.1	Eclipse自动补全

------

解决方案：

 **window** ->**Preferences...** -> **Java** -> **Editor** -> **Content** **Assist**,

勾选上**Disable insertion triggers except 'Enter'**

,这个选项的作用是除了回车键，其他键都不会将自动补全的代码自动插入到代码当中

### 1.2	IntellliJ IDEA

#### 1.2.1	使用vim编辑

IntelliJ IDEA中可以使用vim特性，搜索vim并开启即可。

#### 1.2.2	自定义背景

1)	先设置自定义背景快捷键

进入`File-->Settings-->Keymap-->搜索set Background Image`，点击右键，`Add keyboard Shortcut`，添加完快捷键后保存并关闭设置界面。

我倾向于使用`Add Mouse Shortcut`设置快捷动作为`Ctrl+Button2 Click`

2）	通过快捷键更换背景

使用快捷键即可。

其中Opacity为不透明度



## 2.	Java语言

### 1	集合框架`List`、`Set`、`Map`、`Queue`

------

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1568203823063.png" alt="1568203823063" style="zoom: 67%;" />

集合中`List`、`Set`、`Queue`、`Map`都是**接口**。因此，不能直接生成该类对象，其使用方式如下：

```Java
Public class test{
    public static void main(String[] args){
        Map<String, Integer> map = new HashMap<>();
		map.put("WuJianeng", 1);
		map.put("WuZhuanglu", 0);
		map.put("WuShengping", 2);
		map.put("ZhouFengxia", 2);
		System.out.println(map.size());
		System.out.println(map.values().toString());
		System.out.println(map.keySet().toString());
    }
}
```

**使用Map接口引用`HashMap`类生成的对象**



#### 1.1	List

实现`List`接口的类有：`ArrayList`和`LinkedList`，`ArrayList`**是数组列表**，而LinkedList**是链式列表**。

**`ArrayList`实现了`RandomAccess`接口，因此可以随机访问。**

**`RandomAccess`接口**是**没有任何方法**的**标记接口**，仅仅为了标记一个类是否实现了该接口。**实现了该接口说明该类支持随机访问**。



#### 1.2	Set

`HashSet`和`TreeSet`都实现了`Set`接口，其中`HashSet`使用的是哈希表，而`TreeSet`内部使用的是二叉树。

**Set的元素类型必须实现`Comparable`接口，或者在构造函数中提供。**

`TreeSet`实现了`SortedSet`和`NavigableSet`接口，可以进行一定的元素比较。



#### 1.3	Map

`HashSeMap`和`TreeMap`都实现了`Map`接口。



### 2	迭代器

------

`Collection`的父接口`Iterable< T >`定义了一个方法：

`Iterable< T > iterator ()`

这个方法生成了一个**迭代器**，可以用它来访问集合内的所有元素。

```Java
Collection<String> collection = new ArrayList<>();
...;
Iterator<String> iter = collection.iterator();
while(iter.hasnext()){
    String element = iter.next();
    处理element;
}
```



### 3	嵌套类

------

#### 1	静态嵌套类

```java
public class Invoice{
    private static class Item{
        String description;
        int quantity;
        double unitPrice;
        
        double price(){ return quantity * unitPrice; }
    }
    private ArrayLsit\<Item> items = new ArrayList\<>();
    ...
}
```

#### 3.2	内部类

```java
public class Network{
    public class Member{
        private String name;
        private ArrayList<Member> friends;
        
        public Member(String name){
            this.name = name;
            friends = new ArrayList<>();
        }
        
        
    }
    
    private ArrayList<Member> members = new ArrayLsit<>();
    
    public Member enroll(String name){
        Member newMember = new Member(name);
        members.add(newMember);
        return newMember;
    }
}
```

1）	**内部类可以访问外部类的实例变量：**

```java
public class Network{
    public class Member{
        ...
        public void deactivate(){
            members.remove(this);	//使用外部类的实例变量
        }
    }
    private ArrayList<Member> members = new ArrayList<>();
    ...
    
}
```

2）	**内部类可以调用外部类的方法：**

```java
public calss Network{
    public class Member{
        ...
        public void deactivate(){
            unenroll(this);	//调用外部类的方法，将自己从其网络成员中删去
        }
    }
    private ArrayList<Member> members = new ArrayList<>();
    
    public unenroll(Member m){
        members.remove(m);
    }
    
}
```



### 4	注释

------



```java
/**
*@author WuJianeng
*/
public class Test{
    /**
    *静态变量
    */
    public static String name;
    
    /**
    *@param args 当在命令行执行时，args存储命令行输入参数的入口地址
    *@return 什么都不返回
    */
    public static void main(String[] args){
        Scanner in = new Scanner(System.in);
        if(in.hasNext()){
            String s = in.next();
            System.out.printf("%s\n", s);
        }
    }
}
/**
*<a herf="http://hao123.com">address</a>
*/
```



### 5	接口

****

#### 5.1	声明接口

```java
public interface IntSequece{
    
    /**
    *接口的所有方法默认是共有方法
    */
    boolean hasNext();
    int next();
    
    /**
    *接口同样可以提供默认实现
    *@return 方法返回seq的平均值
    */
    public static double average(Intsequence seq, int n){
        int count = 0;
        double sum = 0;
        while(seq.hasNext() && count < n){
            count++;
            sum += seq.Next();
        }
        return count == 0? 0 : sum / count;
    }
}
```

#### 5.2	实现接口

```java
public class SquareSequence implemets Intsequence{
    private int i;
    
    public boolean hasNext(){
        return true;
    }
    
    public int next(){
        i++;
        return i * i;
    }
}
/**
*实现类必须将接口方法声明为public方法，因为接口要求public 级别访问
*/
```

#### 5.3	转换为接口类型

```java
IntSequence seq = new IntSequence();
double ave = average(seq, 4);
```

当子类型T的任何值不需要转换就能赋值给父类型S时，就称类型S是类型T的**父类**。

永远不存在任何为接口类型的对象。**所有对象都是类的实例。**

#### 5.4	强制类型转换和`instanceof`操作符

```java
public class DigitSequence implements IntSequence {
    private int number;

    public DigitSequence(int number){
        this.number = number;
    }

    @Override
    public boolean hasNext() {
        return number != 0;
    }

    @Override
    public int next() {
        int result = number % 10;
        number = number / 10;
        return result;
    }

    public int rest(){
        return number;
    }
}
```

上图中，`DigitSequence`类实现了`InteSequence`接口，并拥有自己的方法`rest()`。

当遇到下述问题时，应当使用强制转换。

```java
/**
*当需要调用rest()方法，而该对象被接口引用时，就需要强制转换。
IntSequence seq = new DigitSequence(2142);
DigitSequence digits = (DigitSequence)seq;
System.out.println(digits.rest());
```

如果对不是该类型的对象进行强制转换，会在编译时错误或强制类型转换异常。因此，应当使用`instanceof`操作符。

```java
IntSequence seq = new DigitSequence(2425);
if(seq instanceof DigitSequence){
    DigitSequence digits = (DigitSequence)seq;
    System.out.println(digits.rest());
}
```

**instanceof**操作符是`null`安全的，当obj是`null`时，表达式obj instanceof Type的结果是false。

#### 5.5	继承接口

接口可以继承另外一个接口。

```java
public interface Closeable{
	void close();
}
public interface Channel extends Closeable{
    boolean isOpen();
}
```

实现`Closeable`接口的类必须提供两个方法，且**他们的对象可以转换为两个接口类型**。

#### 5.6	实现多个接口

```java
public class FileSequence implements Closeable, IntSequence{
    ...
}
```

#### 5.7	常量

```java
public interface SwingConstants{
    int NORTH = 1;
    int NORTH_EAST = 2;
    int EAST = 3;
    ...
}
```

定义在接口中的所有变量自动为`public static final`。



### 6	静态方法、默认方法和私有方法

------

#### 6.1	静态方法

```java
public interface IntSequence{
    ...
    public static IntSequence digitsOf(int n){
        return new DigitSequence(n);
    }
}
/**
*方法产生IntSequence接口的某些类的示例，但是调用者无需关心它是哪个类。
*从代码中可以看出，调用时生成的是DigitSequence类型，但返回后转换为了IntSequence接口类型
*/
```

#### .6.2	默认方法

可以给接口中任意方法提供默认实现，但必须加上`default`修饰符。

```java
public interface IntSequence{
    /**
    *默认hasNext()方法返回true，即默认序列是无限长的
    default boolean hasNext(){
        return true;
    }
    int next();
}
```

默认方法的一个重要作用在于接口演化，对于一个已经搭建好的项目，该接口可能已经被许多类实现。如果在这个时候添加抽象方法，会导致其他实现该接口的类必须实现该方法，否则会出现编译错误。

而给接口该方法加上默认实现，则不会影响其他类。

#### 6.3	解决默认方法冲突的问题

若一个类实现了两个接口，其中一个接口有个默认方法，并且另外一个接口也有名称和参数类型相同的方法。此时，必须解决冲突。

```java
public interface Person{
    String getName();
    default int getId(){
        return 0;
    }
}

public interface Identified{
    default int getId(){
        return Math.abs(hashCode());
    }
}
```

由于两个接口都有`getId()`方法，当实现这两个类时，必须在该类中提供`getId()`方法，或者委托其中一个冲突方法。

```java
public class Employee implements Person, Identified{
    public int getId(){
        return Identified.super.getId();
    }
}
```

如果**一个类继承了父类并且实现了一个接口**，并且父类和接口都有同样的方法。这时，**只关心父类的方法**，而忽视接口的方法。

#### 6.4	私有方法

私有方法可以是`static`方法或者是实例方法。它主要是为接口的其他方法提供帮助类方法。



### 7	接口实例

****

#### 7.1	`Comparable`接口

如果一个类想启用对象排序，则应该实现`Comparable`接口。

Comparable接口有个特点，其有个类型参数：

```java
public interface Comparable<T>{
    int compareTo(T other);
}
```

例如，String类实现`Comparable<String>`，它的`compareTo`方法就是

```java
int compareTo(String other);
```

对于整数、浮点数等的比较不一定能返回正确结果，可能存在溢出等特殊情况。可以使用以下方法：

```java
Iteger.compare(int a, int b);
Double.compare(double a, double b);
/**
*Double.compare(double a, double b)甚至可以比较计算正负无穷和NaN.
*/
```

举例：

```java
public class Employee implements Comparable<Employee>{
    private int salary;
    
    public int compare(Employee e){
        return Integer.compare(salary, e.salary);
    }
}
/**
*方法可以访问他自己所在类对象的任何私有特性，故可以访问e.salary
*/
```

String类以及Java中许多类都实现了`Comparable`接口。因此可以使用Arrays.sort方法对任何`Comparable`对象的**数组**进行排序：

```java
String[] friends = {"Peter", "Paul", "Mary"};
Arrays.sort(friends);
```

#### 7.2	`Comparator`接口

对于`String`类，其`compare`方法不能修改，因此如果使用上述方法，则只能按照字典序进行排序。

如果想要按照自己的设定的排序方法，则可以通过过实现`Comparator`接口来完成。

有第二种`Arrays.sort`方法，它的参数是**一个数组**和**一个`comparator`**——实现了`Comparator`的实例。

```java
public interface Comparator<T>{
	int compare(T first, T second);
}
```

要按照自己的方式比较字符串，需要定义一个实现`Comparator<String>`的类：

```java
public class LengthComparator implements Comparator<String>{
    public int compare(String first, String second){
        return first.length() - second.length();
    }
}
```

下面是进行比较的实际过程：

```java
Comparator<String> comp = new LengthComparator();
/**
*@param comp 相当于传进去了String类的compare方法
Arrays.sort(friends, comp);
```

同样，`ArrayList<T>`也可以使用这种方式：

```java
ArrayList<String> list = new ArrayList<>();
list.add("Peter");
list.add("Paul");
list.add("Tom");
Comparator<String> comp = new LengthComparator();
/**
*@param comp 此处也相当于传进去了元素的比较方法
*/
list.sort(comp);
```

#### 7.3	`Runnable`接口

要想实现并发运行，应当实现`Runnable`接口，该接口只有一个方法：

```java
class HelloTask implemets Runnable{
    public void run(){
        for(int i  =0 ; i < 1000; ++i){
            System.out.println("Hello, World!");
        }
    }
}
```

如果想在新线程中执行该任务，则从`Runnable`创建线程并启动：

```java
Runnable task = new HelloTask();
Thread thread = new Thread(task);
thread.start();
```

现在`run()`方法在一个单独的线程中，并且当前线程可以处理其他工作。

#### 7.4	UI回调

在GUI(Graphical User Interface)中，当用户点击按钮、选择菜单项、拖动滑块等时，必须指定要执行的行为。

这些行为通常称为**回调**，因为当用户行为发生时，要回调某些代码。

例如，在JavaFX中，下面接口用来报告事件：

```java
public  interface EventHandler<T>{
    void handle(T event);
}
```

要指定行为，就要实现接口，其中`ActionEvent`是代表按钮单击事件：

```java
public class CancelAction implements EventHandler<ActionEvent>{
    public void hadle(ActionEvent event){
        System.out.println("Oh, noes!");
    }
}
```

然后，创建一个该类的对象并将其添加到按钮:

```java
Button cancelButton = new Button("Cancel");
cancelButton.setOnAction(new CancelAction());
```



### 8	`lambda`表达式

------

`lambda`表达式是一块代码，可以将它传递出去，这样后面就可以执行一次或多次。

在很多情况下这样一个代码块是有用的：

**·**	传递给`arrays.sort`一个比较方法

**·**	在单独的线程中运行任务

**·**	指定一个当按钮被单击时应该发生的行为

由于Java是面向对象的语言，没有函数类型。作为一种替代，函数被表达为对象，也就是实现了特定接口的类的实例。

`lambda`表达式使得以一种更便捷的语法来创建实例。

#### 8.1	`lambda`表达式语法

对于比较字符串长度的代码，之前的例子是：

````java
first.length()-second.length()
````

而`lambda`表达式则是：

```
(String first, String second) -> first.length() - second.length()
```

如果`lambda`表达式的表答体无法用一个表达式表示，则可以用`{}`包裹代码，并明确的写上`return`语句：

```java
(String first, String second) ->{
    int difference = first.length() - second.length();
    if (difference < 0) return -1;
    else if (difference > 0) return 1;
    else return 0;
}
```

如果`lambda`表达式没有参数，则提供空的小括号：

```java
Runnable task = () -> {for(int i = 0; i < 1000; ++i) doWork();}
```

如果`lambda`表达式的参数**类型**可以被推导出来，则可以省略类型：

```java
Comparator<String> comp
	= (first, second) -> first.legnth() - second.length();
```

如果某个方法只有一个参数，并且该参数类型可以推导出来，则可以省略小括号：

```java
EventAction<ActionEvent> listener = event ->
    System.out.println("Oh, noes!");
```

不需要为`lambda`表达式指定返回值类型，编译器会从`lambda`表达式中推断出类型，并且检查与期望的类型是否一致。

#### 8.2	函数式接口

当期望只有*一个抽象方法的接口对象*时，就可以提供一个`lambda`表达式。这样的接口被称为函数式接口。

对于`Arrays.sort`方法，其第二个参数要求一个Comparator接口（该接口只有一个方法）的实例。可以直接提供一个`lambda`表达式：

```java
Arrays.sort(words, 
           (first, second) -> first.length() - second.length());
```



### 9	方法引用和构造函数引用

*****

#### 9.1	方法引用

```java
Arrays.sort(strings, (x, y) -> x.compareToIgnoreCase(y));
```

也可以按照如下方式表达：

```
Arrays.sort(strings, String::compareToIgnoreCase);
```

其中，`String::compareToIgnoreCase`是**方法引用**。

如果想打印列表的全部元素。`ArrayList`类有个`forEach`方法，它会在所有元素执行一个函数：

```java
ArrayList.forEach(x - > System.out.println(x));
```

也可以写成下面这种方式：

```java
ArrayList.forEach(Sytem.out::println);
```

操作符`::`将方法名称和类或者对象名称分隔开。有以下3种使用方式：

1. 类`::`实例方法

2. 类`::`静态方法

3. 对象`::`实例方法

   第一种方式，第一个参数变成方法的接收者，并且其他参数也传递给该方法。

   第二种方式，所有的参数传递给静态方法。

   第三种方式，在给定的对象上调用方法，并且参数传给实例方法

#### 9.2	构造函数引用

暂时放一会儿，有点不懂



### 10	使用`lambda`表达式

****

#### 10.1	实现延迟执行

延迟代码的原因：

**·**	在另外一个单独的线程中执行代码

**·**	多次运行代码

**·**	在算法的恰当时刻运行代码

**·**	当某些情况发生时运行代码

**·**	只有在需要时才运行代码

比如，想要将一个行为重复n次。将行为和次数传递给`repeat`方法：

```java
repeat(10, () -> System.out.println("Hello, World!\n"));
```

要接受`lambda`表达式，就必须选择（在极少数情况下，需要提供）函数式接口。在这种情况下，可以选择`Runnable`接口：

```java
public void repeat(int n, Runnable action){
    for(int i = 0; i < n; ++i){
        action.run();
    }
}
```

结合上面的`lambda`表达式，当`action.run()`被调用时，`lambda`表达体被执行。

如果想要告诉`action`在第几次迭代时发生，需要选择一个函数式接口。该函数式接口具有`int`类型参数，返回值为`void`。可以使用下一节中的标准接口：

```java
public interface IntConsumer{
    void accept(int value);
}
```

改进后的`repeat`方法：

```java
public static void repeat(int n, IntComsumer action){
    for(int i = 0; i < n; ++i)	action.accept(i);
}
```

下面是调用过程：

```java
repeat(10, i -> System.out.println("Countdown: " + (9 - i)));
```

#### 10.2	选择函数式接口

###### 															表 10-1	常用函数式接口

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1568451680752.png" alt="1568451680752" style="zoom: 80%;" />	

###### 															表 10-2	常用函数式接口

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1568452155356.png" alt="1568452155356" style="zoom:67%;" /> 

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1568452250797.png" alt="1568452250797" style="zoom:67%;" /> 

#### 10.3	实现自己的函数式接口

...

### 11	`lambda`表达式和变量作用域

****

#### 11.1	`lambda`表达式的作用域

`lambda`表达式的方法体与嵌套代码块有着**相同**的作用域。

在`lambda`表达式中不允许声明一个与局部变量同名的参数或局部变量。

例如：

```java
int first;
Comparator<String> comp = (first, second) -> first.length() - second.length();
/**
*错误，fisrt已经定义过了，不允许重名
*/
```

#### 3.7.2	访问来自闭合作用域的变量

```java
public static void repeatMessage(String text, int count){
    Runnable task = () -> {
        for(int i = 0; i < count; ++i)
            System.out.println(text);
    }
    new Thread(tesk).start();
}
/**
*lambda表达式中引用了text、count等来自闭合作用域的变量
*/
```

要求：`text`、`count`等来自闭合作用域的变量，其值不能更改。或者说`lambda`表达式中**只能引用那些值不会改变的变量**。

```java
for(String arg : args){
	new Thread( () -> System.out.println(arg) ).start();
}
```

此处`lambda`表达式可以使用arg变量，因为对于循环中每一次的arg，它是不会改变的。

下面情况不能使用该变量：

```java
for(int i = 0; i < 100; ++i){
    new Thread( () -> System.out.println(i)) ).start();
}
```

因为此处`i`的作用域是整个循环，而上个增强循环中`arg`在每次迭代过程中都会创建新的`arg`变量，并从`args`数组中将下一个值赋给`arg`。

同样，`lambda`表达式不能改变任何来自于外部闭合作用域中的变量值。



### 12	高阶函数

****

**处理或返回函数的函数**被称为**高阶函数**。

#### 12.1	返回函数的方法

调用下面的`compareInDirection`方法可以返回一个`Comparator`比较器，而且其升序或者降序是由`compareInDirection`方法传递进的参数决定的。

```java
public static Comparator<String> compareInDirection(int direction){
    return (x,y) -> direction * x.compareTo(y);
}
```

结果可以传递给另外一个期望这个接口的方法：

```java
Arrays.sort(friends, compareInDirection(1));
ArrayList.sort(compareInDirection(0));
```

`compareInDirection`方法会返回一个`Comparator<String>`类的接口，且其`int compare（String first, String second)`方法会遵循`(x,y) -> direction * x.compareTo(y)`方式。

#### 12.2	修改函数的方法

不明白

#### 12.3	`Comparator`方法

暂时放着，等待后续消化



### 13	局部类和匿名类

****

#### 13.1	局部类

可以在方法内部定义一个类。这样的类被称为**局部类**。

当一个类实现了接口并且方法的调用者只关心接口，而不是类时：

```java
public static IntSequence randomInts(int low, int high)
```

因为`IntSequence`是个接口，所以方法必须返回实现该接口的某个类的对象。

调用者并不关心类，因此可以在方法内部声明：

```java
private static Random generator = new Random();

public static IntSequence randomInts(int low, int high){
    /**
    *内部类没有声明public或者protected，因为对于方法外部而言，其是不可访问的
    */
    class RandomSequence implements IntSequence{
        public boolean hasNext(){
            return true;
        }
        public int next(){
            return low + generator.nextInt(high - low + 1);
        }
    }
    return new RandomSequence();
}
```

#### 13.2	匿名类

上节内部类可以改写成匿名类：

```java
public static IntSequence randomInts(int low, int high){
    return new IntSequence(){
        public int next(){
            return low + generator.nextInt(high - low + 1);
        }
        public boolean hasNext(){
            return true;
        }
    }
}
```

表达式：`new Interface() { methods }`



### 14	继承一个类

****

所有类都是`Object`类的子类，它提供了`toString()`、`hashCode()`、`equals()`、`clone()`方法。

#### 14.3	方法覆盖

可以给计划覆盖的父类方法打上`@override`注解，这样可以避免类型错误（出错编译器会报错）。

注意：

​	覆盖一个方法时，子类方法的可见性至少应该与父类方法一样。特别是，如果父类方法是`public`，那么子类方法必须是`public`。即子类继承自父类的方法不能将方法的访问权限缩小。

#### 14.4	子类的构造

```java
public Manager(String name, double salary){
	super(name, salary);
	bonus = 0;
}
```

这里，关键字`super`表示调用父类`Employee`的构造函数。

**父类的构造函数必须是子类构造函数中的第一条语句。**

**如果子类没有明确调用父类的构造函数，则父类必须有一个没有参数的、被隐式调用的构造函数。**

#### 14.5	父类赋值

```java
Manager boss = new Manager(...);
Employee empl = boss;
```

#### 14.6	转换

```java
Employee empl = new Manager(...);
if(empl instanceof Manager){
    Manager mgr = (Manager)empl;
    mgr.setBonus(1000);
}
```

#### 14.7	`final`方法和类

**当将一个方法声明为`final`时，子类不可以覆盖它（即子类不能重写父类的包含关键字`final`的方法）。**

当一个类声明为`final`时，它**不能被继承**。

#### 14.8	抽象方法和类

一个类可以定义没有实现的方法，强迫子类去实现。这样的方法以及所属类被称为**抽象方法和抽象类**。

抽象方法和抽象类必须加上`abstract`标记。

```java
public abstract class Person{
    private String name;
    
    public Person(String name)	{this.name = name;}
    public final String getName()	{return this.name;}
    
    public abstract int getId();
}
```

对于任何要继承`Person`类的子类，必须覆盖`getId()`方法，否则其必须声明为`abstract`类，即抽象类。

#### 14.9	受保护访问

声明为`protected`的方法和变量，只有其子类和处于同一包的其他类可以访问。

#### 14.10	匿名子类

```java
ArrayList<String> name = new ArrayList<String>(100){
    public void add(int index, String element){
        super.add(index, element);
        System.out.printf("Adding %s at %d\n", element, index);
    }
};
```

紧跟父类名称后面圆括号里的参数被传进了父类`ArrayListM<String>`的构造函数当中。

#### 14.11	继承和默认方法

若某个类继承了一个类并实现了一个接口，且父类和接口含有一个同名方法。在这种情况下，子类默认调用父类的方法。

```java
public interface Named{
    default String getName()	{return "";}
}
public class Person{
    ...
    public String getName()	{return name;}
}
public class Student extends Person implements Named{
    ...
}
```

#### 14.12	带`super`的方法表达式

`super::instanceWork`

```java
public class Worker{
    public void work(){
        for(int i = 0; i< 100; ++i)	System.out.println("Working");
    }
}
public class ConcurrentWorker extends Worker{
    public void work(){
        Thread t = new Thread(super::work);
        t.start();
    }
}
```

以`Runnable`对象构造线程，`Runnable`对象的`run()`方法调用父类的`work`方法。



### 15	`Object`终极父类

****

Java中所有的类都直接或者间接的继承自`Object`类。

`Object`类包含以下方法：

```java
String toString();				//产生一个表示该对象的字符串，默认是返回类名+哈希码
boolean equals(Object other);	//如果对象与other对象相等，返回true，否则返回false
int hashCode();					//返回该对象的哈希码
Class<?> getClass();			//返回该对象所属的Class对象
protected Object clone();		//拷贝该对象。默认是浅拷贝
protected void finalize();		//当垃圾回收器回收该对象时，调用该方法。
wait、notify、notifyAll			//后续会有
```

#### 15.1	`toString`方法

```java
public class Manager extends Employee{
    ...
    public String toString(){
        return super.toString()	+ "[bonus=" + bonus + "]";
    }
}
```

当一个对象和一个字符串连接时，自动调用对象的`toString`方法。

```java
Point p = new Point(10, 20);
String message = "The current position is " + p;
//与p.toString()连接
```

#### 15.2	`equals`方法

`equals()`方法用来测试一个对象是否和另外一个对象相等。

在`Object`类中，`equals`方法判断两个对象引用是否相同。

如果需要基于状态相等的相等性测试，则需要覆盖`equals()`方法。即，只有当两个对象的内容相同时，才认为他们相等。比如，`String`类就覆盖了`equals()`方法，只有当两个对象的字符串内容相同时，才认为它们两个相等。

对于下例中的`Item`类，只要他们的描述和价格相等，即可认为他们相等。

```java
public class Item{
    private String description;
    private double price;
    
    public equals(Obejct otherObject){
        if(this == otherObject) return true;
        
        //如果参数为null，必须返回false
        if(otherObject == null) return false;
        //检查otherObject是否是Item类型
        if(getClass() != otherObject.getClass()) return false;
        //检查实例变量值是否相同
        Item other = (Item) otherObject;
        return Objects.equals(description, other.description)
            && price == other.price;//对于double类型的数，这样比较不一定准确
    }
    public int hashCode()	{...}//应当提供hash方法
}
    
    
```

在`equals`方法中，下面是一些常规步骤:

| 1.    一般认为两个对象的相等是完全相同，这个检测耗费比较小   |
| ------------------------------------------------------------ |
| 2.    当与`null`比较时，所有的`equals`方法都要返回`false`    |
| 3.    由于覆盖了`Object`类的`equals`方法，而`Object`方法的参数类型也是`Object`类的，因此需要先将其转换成实际类型。在转换之前，先使用`getClass`方法，或者`instanceof`操作进行类型检查 |
| 4.比较实例变量。对于基本类型使用`==`操作符。对于`double`类型值，如果担心正负无穷大和`NaN`，那么可以使用`Double.equals`方法。对于对象，使用`Object.equals`方法，它是`null`安全的。 |

当在子类中定义`equals`方法时，可以先调用父类的`equals`方法。若两个对象其父类检查没通过，那么他们一定不相等。

#### 15.3	`hashCode`方法

`hash code`是一个整数，来源于对象。如果x、y是两个不同的对象，那么`x.hashCode()`和`y.hashCode()`**很可能**不同。

`hashCode`和`equals`方法必须是兼容的。即若两个对象`equals`返回`true`，则其`hashCode`返回结果必须相同。

在自定义的`hashCode`方法中，可以直接联合各实例变量的哈希码。例：

```java
public class Item{
    ...
    /**
    *Objects类的hash方法的参数是一个可变参数，该方法会计算每个参数的哈希码，
    *并将它们组合起来，该方法是空指针安全的
    */
    public int hashCode(){
    	return Objects.hash(description, price);
    }
}
```

接口中定义默认的`hashCode`、`equals`、`toString`等方法无效，因为类比接口优先（`Class win`）。所有类继承自`Object`类。

#### 15.4	克隆对象

`Clone`方法的目的就是要创建一个”克隆“的对象—**—拥有与原对象相同的状态的不同对象**。

```java
Employee cloneOfFred = fred.clone();
cloneOfFred.raeseSalary(10);	//对象fred不会改变
```

在`Object`类中，clone方法被声明为`protected`，所以如果想要让类用户克隆实例，就必须覆盖它。

`Object.clone`方法做的是浅拷贝。它简单的从原对象拷贝所有实例变量到被拷贝对象里。

如果实例变量都是基本类型的或者不会改变，就没有问题。但是，对于其他的实例变量，原对象将与被拷贝对象共享可变的状态。

```java
public final class Message{
    private String sender;
    private ArrayList<String> recipients;
    private String text;
    ...
    public void addRecipient(String recipient) {...};
}
```

如果对`Message`对象做浅拷贝，则原对象和克隆对象将共享`recipients`列表。

```java
Message specialOffer = ...;
Message cloneOfSpecialOffer = specialOffer.clone();
```

如图所示：

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1568548292643.png" alt="1568548292643" style="zoom:80%;" />

因此，`Message`类需要覆盖`clone`方法，进行深拷贝。

当时先一个类时，需考虑三种情况：

	1.	是否提供`clone`方法；
 	2.	如果不提供`clone`方法，那么继承父类的`clone`方法是都可以接受；
 	3.	如果不接受继承父类的`clone`方法，那么就要提供实现深拷贝的`clone`方法。

对于第一种方法，类将继承`clone`方法，但由于它是`protected`的，没有对象可以调用它。

对于第二种方法，该类必须实现`Cloneable`接口。这是一个没有任何方法的接口，称作**标签（tagging或者marker）接口**。`Object.clone`方法执行浅拷贝之前，会检查这个接口是否实现，如果未实现，会抛出`cloneNotSupportedException`异常。

```java
public class Employee implements Cloneable{
    ...
    public Employee clone() throws CloneNotSupportedException{
        return (Employee) super.clone();
    }
}
```

由于`Object.clone`返回的是`Object`类对象，需要转换为`Employee`类型



### 16	枚举

****

```java
public enum Size { SMALL, MEDIUM, LARGE, EXTRA_LARGE};
```

#### 16.1	枚举方法

每个枚举类型都有固定的实例集，因此对于枚举类型的值，不需要`equals`方法，直接使用`==`即可。

不需要提供`toString`方法，它会自动产生枚举对象的名称——例如，”`SMALL`"，“`MEDIUM`”等。

每个枚举类型都有一个静态方法`values`，该方法返回一个按照其声明次序排列的包含所有枚举实例的数组。

```java
Size[] allValues = SIZE.values();
```

`ordinal`方法返回实例在枚举（`enum`）声明中的位置，从位置0开始。在有新的常量插入枚举类型中时，values可能会偏移。

每个枚举类型E自动实现了`Comparable<E>`接口，仅允许比较自己的对象。其是基于序数值的。

