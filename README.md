# linux-2020-cuc-ty
linux-2020-cuc-ty created by GitHub Classroom

# 第一次作业

### 软件环境

Virtualbox

Ubuntu 18.04 Server 64bit

### 实验问题

1.如何配置无人值守安装iso并在Virtualbox中完成自动化安装？

2.Virtualbox安装完Ubuntu之后新添加的网卡如何实现系统开机自动启用和自动获取IP？

3.如何使用sftp在虚拟机和宿主机之间传输文件？

### 实现特性

定制一个普通用户名和默认密码

定制安装OpenSSH Server

安装过程禁止自动联网更新软件包

# 有人值守安装Ubuntu系统环境时出现的问题

首次安装完成后再次打开虚拟机时还是安装系统界面，原因是我在第一次安装成功之后，误以为还需要添加ubuntu光驱，所以我手动删除了系统安装镜像盘片

![有人值守安装](/img/1.png)

# 无人值守安装

### 设置两块网卡
在设置了两块网卡后，输入 ifconfig -a 之后发现host-only网卡没有启动，之后再输入sudo ifconfig enp0s8 up sudo dhclient enp0s8 来手动启动（在这里我卡了一段时间是因为我把两个语句放在一句输入了。。）

这里获得的IP是192.168.56.101

![设置双网卡](/img/设置双网卡.png)

![查看网卡IP地址](/img/网卡IP.png)

### 下载putty并连接虚拟机

putty连接虚拟机如下图：

![putty连接](/img/putty.png)


### 把镜像文件ubuntu-18.04.4-server-amd64(1).iso 从windows复制进虚拟机

使用下载的的putty里面的psftp.exe

![复制镜像文件](/img/复制镜像文件.png)

### 挂载镜像文件

这步因为刚开始我创建的loopdir目录里面文件挂错了，但是没有找到删除目录的方法，于是又新建了loopp目录和cdd目录
