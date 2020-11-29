# Ubuntu 16.04 初始化设置

当你第一次创建ubuntu 16.04版本的服务器时，有一些配置步骤作为基础配置的一部分是需要你尽早设置的，这将增加服务器的安全性和可用性，并为后续操作提供坚实的基础。

## 01. Terminal 远程登录云服务主机

1. 登录[阿里云服务控制台](https://www.aliyun.com/?spm=5176.2020520101.aliyun_topbar.1.35444df5jMZ9pr)
2. 页面左侧找到```云服务器ECS```, 点击找到服务器```实例```
3. 复制```公有IP地址```
4. 本地打开```Terminal```, 通过下面命令登录

    ```bash
    ssh username@ip
    ```

5. 密码验证， 输入购买时设定的服务器密码，如果忘记了，可以在实例界面重置密码

## 02. 管理用户 

1. 添加用户

    ```bash
    $ sudo adduser username  # 然后根据提示输入信息
    ```

2. 赋予新用户sudo权限
 
    ```bash
    $ sudo usermod -aG sudo username
    
    # annother way
    # $ visudo
    #
    # add this line below ' User privilege specification area'
    # usernmae  ALL=(ALL:ALL) ALL
    # 用户名     所有主机 = （所有用户可执行命令：所有组可执行命令） 所有命令
    ```

3. 修改用户密码

    ```bash
    $ sudo passwd username
    ```

4. 删除用户

    ```bash
    $ sudo deluser username 

    # 连同用户home目录一起删除 
    $ sudo deluser --remove-home newuser

    # 如果该用户用于sudo权限， 通过visudo命令，删除对应用户对应行记录即可 
    ```

## 03. SSH Auth  无密码登录（安全可靠）

1. 在本地生成秘钥

    ```bash
    ssh-keygen       # 不要输入密码

    # 默认在用户.ssh目录下。
    ```

2. 将公钥上传至远程服务器

    ```bash
    mkdir .ssh
    touch  .ssh/authorized_keys
    # 手动复制本地公钥内容到`authorized_keys`

    # ssh 命令方式（推荐）
    ssh-copy-id username@host
    ```

3. 修改文件权限

    ```bash
    chmod 777 .ssh
    chomd 644 .ssh/authorized_keys
    ```

4. 禁用root用户SSH 登录

    ```bash
    # 修改 PermitRootLogin no
    vim /etc/ssh/sshd_config [etcsshsshdconfig]
    ```

5. 禁用基于密码的登录

    ```bash
    # 添加 `PasswordAuthentication no`, 保存退出
    sudo vim /etc/ssh/ssh_config

    # 重启ssh auth 服务
    sudo service ssh restart
    ```

## 04. 设置sudo 不需要输入密码

```bash
sudo vim /etc/sudoers

# 修改对应一行
# %sudo   ALL=(ALL:ALL) NOPASSWD: NOPASSWD: ALL

# 详情请参考 man sudoers
```

## 05. 安装Docker

1. 参照 [docker官网](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
2. 将 用户添加到`docker`组

    ```bash
    sudo usermod -aG docker username
    ```

## 06. 阿里云服务器公网开放端口

1. 登录阿里云服务器控制台
2. 实例操作点击`更多`选择`安全组配置`，进入实例安全组配置界面选择`配置规则`
3. 点击`添加安全组规则`， 在弹出界面输入参数
4. 重启服务

## 07. 参考文章

- [How to Add and Delete Users on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-16-04)
- [How To Edit the Sudoers File on Ubuntu and CentOS](https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file-on-ubuntu-and-centos)
- [How To Set Up SSH Keys on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-1604)
