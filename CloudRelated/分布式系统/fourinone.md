## Fourinone

### 1	Fourinone目录结构与调试

#### 1.1	Fourinone目录

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1571481906272.png" alt="1571481906272" style="zoom: 67%;" />

其中`bin`存放的是编译后的`.class`执行文件和`config.xml`文件

#### 1.2	Fourinone调试

以执行`SayHelloDemo`项目为例：

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1571482063733.png" alt="1571482063733" style="zoom:80%;" />

1）导入或编写`config.xml`文件

在执行时发现提示：

![1571482998708](C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1571482998708.png)

于是我将`Fourinone4.17.10`执行调试项目是生成的`config.xml`文件放入`bin`文件夹内

2）再继续执行`ParkServerDemo`进程：

由于该项目有包名，其执行入口必须位于包所在的文件夹内（我是这样的），然后执行：

`java packageName.className [可选参数]`

```powershell
//进入执行文件所在文件夹
cd /d D:\GithubRepos\Fourinone\bin
//执行ParkServerDemo程序（单独一个进程）
java com.fourinone.tests.SayHelloDemo.ParkServerDemo
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1571483225855.png" alt="1571483225855" style="zoom: 80%;" />

3）再执行`HelloWorker`进程（可以多执行几次，工人名字可以换几个）：

```powershell
cd /d D:\GithubRepos\Fourinone\bin
//执行HelloWorker,HelloWorker后面的三个变量均为参数
java com.fourinone.tests.SayHelloDemo.HelloWorker worker 10.82.81.231 2001
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1571483284640.png" alt="1571483284640" style="zoom:80%;" />

4）再执行`HelloCtor`进程：

```powershell
cd /d D:\GithubRepos\Fourinone\bin
//执行HelloCotr
java com.fourinone.tests.SayHello.HelloCtor
```

<img src="C:\Users\WuJianeng\AppData\Roaming\Typora\typora-user-images\1571483369063.png" alt="1571483369063" style="zoom:80%;" />