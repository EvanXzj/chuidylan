# PostgreSQL 安装及配置

本文主要包括PostgreSQL的安装、配置以及如何通过`Docker`快速启动一个数据库,以便本地开发和测试。

[PostgreSQL](https://www.postgresql.org/) 官网简介: 

> PostgreSQL is a powerful, open source object-relational database system with over 30 years of active development that has earned it a strong reputation for reliability, feature robustness, and performance.

PostgreSQL是一个功能强大的开源对象关系数据库系统，经过30多年的积极开发，在可靠性，功能稳健性和性能方面赢得了良好的声誉。

## 从发行版本安装(Ubuntu 16.04)

### 1. 安装
```bash
$ sudo apt-get update
$ sudo apt-get install postgresql
```

### 2. 连接数据库
安装完成后，数据库就启动了。切换系统用户`postgres`, 通过`psql`命令可以连接数据库:

```bash
$ sudo su - postgres        # - 表示切换相关的环境变量

$ psql                      # 连接数据库
```

### 3. 相关目录
-  数据库的数据目录`/var/lib/postgresql/<dbversion>/main`
-  Postgresql配置目录`/etc/postgresql/<dbversion>/mian`

### 4. Postgresql 服务管理命令

```bash
# 查看状态
$ sudo service postgresql status     # or systemctl status postgresql

# 停止服务
$ sudo service postgresql stop

# 启动服务
$ sudo service postgresql start

# reload
$ sudo service postgresql reload
```

### 5. 简单配置

- 修改监听的IP 和 端口

```
listen_address = 'localhost'  如果想想让远程的主机可以登录将其改为"*"即可 
#port = 5432        默认5432可不修改，如果我们有多个数据库实例就可以设置不同端口           
```

- Log相关

```
logging_collector = on    # 是否要收集日志，一般是需要设置的

log_directroy = 'pg_log'  # 日志目录

# 每天生产一个新的日志文件
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_truncate_on_rotation = off
log_rotation_age = 1d
log_rotation_size = 0

# 当日志写满一定大小后则切换一个新的日志文件
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_truncate_on_rotation = off
log_rotation_age = 0
log_rotation_size = 20M

# 保留七天的日志，循环覆盖
log_filename = 'postgresql-%a.log'
log_truncate_on_rotation = on
log_rotation_age = 1d
log_rotation_size = 0
```

- 内存相关

    1. shared_buffers: 共享内存的大小，主要用于数据块共享
    2. work_mem:    SQL读取数据时所使用的内存，使用后就释放。

    当机器的内存较足的情况下，加大这两项的数据可以提高数据的读取排序速度。

**更多详细信息请查看官方文档**

## Docker 启动 pgsql数据库

如果为了测试和开发， 我们可以通过[Docker](https://www.docker.com/)来快速启动一个测试数据库， 命令如下：

```bash
docker run -d --name postgres \
                -p 5432:5432 \
                --restart=always \
                -v $HOME/Lib/Data/pgdata:/var/lib/postgresql/data \
                -e 'POSTGRES_DB=db_name' \
                -e 'POSTGRES_USER=db_user' \
                -e 'POSTGRES_PASSWORD=db_password' \
                postgres:<db_version>
```

**注： 根据实际情况修改上面的命令中相关数据**
