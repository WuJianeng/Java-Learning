# Maven

****



## Maven网站

Maven官方网站：

[1]: http://maven.apache.org/	"Maven官方网站"
[2]: https://search.maven.org/#browse	"Maven中央仓库"



## 相关工具

`hamcrest`	断言（加强）

```java
AssertThat(s, allOf(...));
AssertEquals(...);
allOf(...)
anyOf(...)
is(...)
not(...)
greaterThan(...)
lessThan(...)
greaterOrEqualsThan(...)//not sure
```

`Cobertura`	代码覆盖率测试

`DbUnit`

`EasyMock`



## 相关错误

1	执行mvn test命令时报错 `-source 7或更高版本以启用diamond运算符`

是由于java等版本不一致导致的

解决办法：

1）查看project的sdk版本、Modules的language level、Platform的skd版本以及java compiler的字节码版本、每个模块的字节码版本是否一致

![1571306188303](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1571306188303.png)

![1571304090861](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1571304090861.png)

如果仍然存在问题，在pom.xml文件中加入`<properties>`部分



```xml
<project ...>
    ...
    
    <properties>
        <java.version>1.8</java.version>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>
    ...

</project>

```

