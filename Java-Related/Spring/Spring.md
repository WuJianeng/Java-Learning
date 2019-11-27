# Spring



## 0	Spring框架安装

### 0.1	使用maven添加Spring框架

```xml
<properties>
    <springframework.version>3.2.18.RELEASE</springframework.version>
  </properties>
<dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.7</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context</artifactId>
      <version>${springframework.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-core</artifactId>
      <version>${springframework.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context-support</artifactId>
      <version>${springframework.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-test</artifactId>
      <version>${springframework.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-beans</artifactId>
      <version>${springframework.version}</version>
    </dependency>
    <dependency>
      <groupId>com.github.stefanbirkner</groupId>
      <artifactId>system-rules</artifactId>
      <version>1.4.0</version>
    </dependency>
</dependencies>
```

部分spring依赖非必须，可以在需要时再添加



### 0.2	遇到的问题

#### 0.2.1	找不到依赖注入的配置文件

在引入xml配置文件后，经测试提示`Failed to load ApplicationContext`

```java
@ImportResource("classpath:CDConfig.xml")
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1574170219110.png" alt="1574170219110" style="zoom:80%;" />![1574170264239](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1574170264239.png)

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1574170219110.png" alt="1574170219110" style="zoom:80%;" />![1574170264239](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1574170264239.png)查看`Caused by`这一行可以发现报错找不到文件。

原因:

该文件应该存放到`src/main/resources/`下的`CDConfig.xml`处。

