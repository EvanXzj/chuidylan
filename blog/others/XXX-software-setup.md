# XXX Software Setup

XXX 软件搭建过程，你懂的！ 放飞自我~~~

## 1. 登录服务器

```sh
ssh username@ip
```

## 2. 下载Brook文件

```sh
# 根据最新版本替换url
wget https://github.com/txthinking/brook/releases/download/v20190205/brook

# 增加可执行权限
chmod +x brook

# 根据配置文件中的command来移动文件
mv brook /usr/local/bin/
```

## 3. 安装supervisor

```sh
apt install supervisor
```

## 4. 编辑supervisor配置文件

**PS**: 修改`PORT`和`PASSWORD`信息,将其命名为`ssserver.conf`, 然后将其放到`/etc/supervisor/conf.d`目录中即可。

```conf
; supervisor config file
[program:ssserver]
command=/usr/local/bin/brook ssserver -l 0.0.0.0:PORT -p "PASSWORD"
autostart=true                                              ; start at supervisord start (default: true)
startsecs=1                                                 ; # of secs prog must stay up to be running (def. 1)
startretries=3                                              ; max # of serial start failures when starting (default 3)
autorestart=true                                            ; when to restart if exited after running (def: unexpected)
exitcodes=0,2                                               ; 'expected' exit codes used with autorestart (default 0,2)
stopsignal=QUIT                                             ; signal used to kill process (default TERM)
stopwaitsecs=10                                             ; max num secs to wait b4 SIGKILL (default 10)
stopasgroup=false                                           ; send stop signal to the UNIX process group (default false)
killasgroup=false                                           ; SIGKILL the UNIX process group (def false)
redirect_stderr=true                                        ; redirect proc stderr to stdout (default false)
stdout_logfile=/tmp/brook.stdout.log                        ; stdout log path, NONE for none                             ; default AUTO
stdout_logfile_maxbytes=1MB                                 ; max # logfile bytes b4 rotation (default 50MB)
stdout_logfile_backups=10                                   ; # of stdout logfile backups (0 means none, default 10)
stdout_capture_maxbytes=1MB                                 ; number of bytes in 'capturemode' (default 0)
stdout_events_enabled=false                                 ; emit events on stdout writes (default false)
stderr_logfile=/tmp/brook.stderr.log                        ; stderr log path, NONE for none                             ; default AUTO
stderr_logfile_maxbytes=1MB                                 ; max # logfile bytes b4 rotation (default 50MB)
stderr_logfile_backups=10                                   ; # of stderr logfile backups (0 means none, default 10)
stderr_capture_maxbytes=1MB                                 ; number of bytes in 'capturemode' (default 0)
stderr_events_enabled=false                                 ; emit events on stderr writes (default false)
```

## 5. 重启supervisor

```sh
service supervisor restart

# 查看ssserver进程是否正常运行
supervisorctl status
# ssserver                         RUNNING   pid 2824, uptime 0:15:28
# RUNNING 表示成功运行了
```

## 6. 根据上面填写的PORT和PASSWORD填写Shadowsocks服务器配置即可
