# Deploying Go Web Apps to Heroku

[Heroku](https://www.heroku.com/) 是 Salesforce 旗下云服务商，提供方便便捷的各种云服务，如服务器，数据库，监控，计算等等。并且他提供了免费版本，这使得我们这些平时想搞一些小东西的人提供了莫大的便捷，虽然他有时长和宕机的限制，但是对于个人小程序来说已经足够了。

## 1. 注册Heroku账号

点击[注册](http://heroku.com/signup)一个新账号， heroku初始免费提供`5`个应用

## 2. 安装Heroku CLI

查看[下载页面](https://devcenter.heroku.com/articles/heroku-cli#download-and-install), 选择符合自己电脑的安装方式

- 验证安装, 只要输出以下类似信息即可

```bash
heroku version
# heroku/7.22.3 darwin-x64 node-v11.10.1
```

- 使用刚刚创建的账号登录Heroku CLI

```bash
heroku login
# 根据提示输入信息即可
```

## 3. APP 源代码

```golang
package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("listening...")
	err := http.ListenAndServe(GetPort(), nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello. This is our first Go web app on Heroku!")
}

// Get the Port from the environment so we can run on Heroku
func GetPort() string {
	var port = os.Getenv("PORT")
	// Set a default port if there is nothing in the environment
	if port == "" {
		port = "9527"
		fmt.Println("INFO: No PORT environment variable detected, defaulting to " + port)
	}
	return ":" + port
}
```

## 4. 安装项目依赖(可选)

```bash
# 1. 安装godep
go get github.com/tools/godep

# 2. 进入项目根目录，执行以下命令
godep save 
```

## 5. 创建Procfile文件

使用Procfile,文本文件在您的应用程序的根目录,显式地声明应该执行什么命令来启动应用程序。
内容如下:
```txt
web: webapphr
```
web在这里很重要。它声明此流程类型将附加到Heroku的HTTP路由堆栈，并在部署时接收web流量。

## 6. 使用Git管理源代码

```bash
$ git add -A .
$ git commit -m "first commit"
```

## 7. 创建HeroKu应用

```bash
heroku create

# 输出信息大致如下：
# Creating thawing-harbor-9085… done, stack is cedar-14
# https://thawing-harbor-9085.herokuapp.com/ | https://git.heroku.com/thawing-harbor-9085.git
# Git remote heroku added
```

## 8. 部署应用

```bash
git push heroku master

# 输出信息中包含：Verifying deploy…. done. 即是发布成功
```

## 9. 测试

```bash
# 项目根目录下输入以下命令快速打开webapp
heroku open
```