## k8s

****



### 1	安装Linux

#### 1.1	使用VirtualBox安装centOS/Ubuntu

1）下载centOS/Ubuntu镜像文件

对于`centOS`，推荐使用阿里云的镜像网站去下载：

`centOS`：(http://mirrors.aliyun.com/centos/)

`centOS官方`：http://vault.centos.org/

`Ubuntu`：(https://ubuntu.com)

2）在VortualBox中新建虚拟机，设置内存、CPU核心数等并将`.ISO`文件导入

注意：在安装完成后，应当将虚拟机设置里面系统加载顺序的硬盘更改到最前面，否则会导致重启仍然出现安装centOS界面。

对于Ubuntu，系统并没有自带`YUM`，因此需要自己安装。

1）安装基础包

```shell
sudo apt-get install build.essential
```

2）安装`yum`

```shell
sudo apt-get install yum
```

#### 1.2	配置网络yum源仓库

进入到/etc/yum.repos.d/目录（cd /etc/yum.repos.d/）
用wget下载repo文件，输入命令wget http://mirrors.aliyun.com/repo/Centos-7.repo。

注意：如果wget命令不生效，说明还没有安装wget工具，输入yum -y install wget 回车进行安装。
当前目录是/etc/yum.repos.d/，刚刚下载的Centos-7.repo也在这个目录上
备份系统原来的repo文件（mv CentOs-Base.repo CentOs-Base.repo.bak）
替换系统原理的repo文件（mv Centos-7.repo CentOs-Base.repo）
更新yum源命令（yum clean all && yum makecache）

————————————————
原文链接：https://blog.csdn.net/lpl_lpl_lpl/article/details/85621740

