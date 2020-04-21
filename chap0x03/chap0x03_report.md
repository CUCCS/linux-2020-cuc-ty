# 第三次作业

### 软件环境

Ubuntu 18.04 Server 64bit

### 实验问题

动手实战Systemd


# Systemd操作全程录像

[Systemd入门教程 命令篇1-4](https://asciinema.org/a/ohfMjacxupjlZkAtU8IkJv2D7)

[Systemd入门教程 命令篇5-7](https://asciinema.org/a/Dv5zqLtIdJdxLgQpvy80h437U)

[Systemd入门教程 实战篇]( https://asciinema.org/a/kQ5lqr4hDtGjQ7CCPHoCAWuCz)
# 自查清单

如何添加一个用户并使其具备sudo执行程序的权限？

- adduser username 添加用户

- 第一步：切换到root下：su，并输入密码

   第二步：输入  vi /etc/sudoers，加入一行即可

   找到  root   ALL=(ALL)   ALL

   加入一行即可：
 
   将该普通用户加入权限：

   hadoop   ALL=(ALL)    ALL


如何将一个用户添加到一个用户组？

- usermod -a -G groupA user


如何查看当前系统的分区表和文件系统详细信息？

- fdisk -l 查看分区表

- df -h 查看文件系统

如何实现开机自动挂载Virtualbox的共享目录分区？

- Virtualbox ubuntu共享文件夹中添加共享目录

  cd /mnt

  sudo mkdir win10 share

  cd win10/

  mkdir drv_d

  修改/etc/fstab文件，添加drv_d /mnt/win10/drv_d vboxsf rw,auto 0 0

基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？

- 缩减：lvreduce -L + 容量       

- 扩容：lvextend -L + 容量

如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？

- 修改systemd-networkd中Service

  ExecStartPost = 指定脚本 start

  ExecStopPost = 另一个脚本 start

如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？

- sudo systemctl vi + 脚本文件名

  配置文件中restart字段设为always

# 参考文献

[Systemd 入门教程：命令篇 by 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)

[Systemd 入门教程：实战篇 by 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)