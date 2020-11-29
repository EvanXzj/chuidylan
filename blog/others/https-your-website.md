# 使用Let Encrypts, HTTPS你的网站(Ubuntu)

HTTPS（全称：Hyper Text Transfer Protocol over Secure Socket Layer 或 Hypertext Transfer Protocol Secure，超文本传输安全协议），是以安全为目标的HTTP通道，简单讲是HTTP的安全版

**Note:** 在申请证书之前 域名配置需存在于 nginx 的配置文件中, 且域名需要监听`80`端口;

## 1. 安装 cert 命令行工具

```bash
$ sudo add-apt-repository ppa:certbot/certbot
$ sudo apt-get update
$ # for apacha: sudo apt-get install python-certbot-apacha
$ sudo apt-get install python-certbot-nginx
```

## 2. 申请证书

```bash
$ sudo certbot --nginx -d YOUR_DOMAIN
$ sudo certbot --nginx -d YOUR_DOMAIN_A -d YOUR_DOMAIN_B # 申请多个域名证书
```

**NOTE:** 将`YOUR_DOMAIN`、`YOUR_DOMAIN_A`、`YOUR_DOMAIN_A`替换成真实的域名

## 3. 证书过期重新申请

Let Encrypts 的证书只只支持 90 天的时间, 如果过期需要从新申请, 执行以下命令:

```bash
sudo certbot renew --dry-run
```
