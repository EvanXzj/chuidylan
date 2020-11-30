# VsCode快捷键(Mac)

vscode (Visual Studio Code) 作为广受好评的开发工具，已经被越来越多的开发者当作首选的开发工具。 本文主要包括vscode的常用快捷键列表。

## 安装

进入[官网](https://code.visualstudio.com/) 下载对应平台的安装包

对于MacOS的用户可以通过brew cask 来安装

```shell
brew cask install vscode
```

## 安装插件

`Command + Shift + X` 打开插件面板（鼠标点击左侧插件按钮也行），搜索插件，点击`install`安装即可。

### 通过命令行安装插件

1. `Command + Shift + p`, 输入path, 选择： **Shell Command: install 'code' command in path**

2. ```code  --install-extension extension-id```
3. 参数列表
  
```bash
# 安装vscode插件
code --extensions-dir <dir>
    Set the root path for extensions.
code --list-extensions
    List the installed extensions.
code --install-extension (<extension-id> | <extension-vsix-path>)
    Installs an extension.
code --uninstall-extension (<extension-id> | <extension-vsix-path>)
    Uninstalls an extension.
```

## 快捷键

### 基本

    Command + X 剪切（未选中文本的情况下，剪切光标所在行）

    Command + C 复制

    Option + Up 向上移动行

    Option + Down 向下移动行

    Option + Shift + Up 向上复制行

    Option + Shift + Down 向下复制行

    Command + Shift + K 删除行

    Command + Enter 下一行插入

    Command + Shift + Enter 上一行插入

    Command + Shift + \ 跳转到匹配的括号

    Command + [ 减少缩进

    Command + ] 增加缩进

    Command + Up 跳转至文件开头

    Command + Down 跳转至文件结尾

    Command + Alt + [ 折叠代码块

    Command + Alt + ] 展开代码块

    Command + K Command + [ 折叠全部子代码块

    Command + K Command + ] 展开全部子代码块

    Command + K Command + 0 折叠全部代码块

    Command + K Command + J 展开全部代码块

    Command + / 添加、移除行注释

    Option + Shift + A 添加、移除块注释

### 多光标与选择

    Option + 点击 插入多个光标

    Command + Option + Up 向上插入光标

    Command + Option + Down 向下插入光标

    Command + U 撤销上一个光标操作

    Option + Shift + I 在所选行的行尾插入光标

    Command + I 选中当前行

    Command + Shift + L 选中所有与当前选中内容相同部分

    Command + F2 选中所有与当前选中单词相同的单词

    Command + Ctrl + Shift + Left 折叠选中

    Command + Ctrl + Shift + Right 展开选中

    Alt + Shift + 拖动鼠标 选中代码块

    Command + Shift + Option + Up 列选择 向上

    Command + Shift + Option + Down 列选择 向下

    Command + Shift + Option + Left 列选择 向左

    Command + Shift + Option + Right 列选择 向右

    Command + Shift + Option + PgUp 列选择 向上翻页

    Command + Shift + Option + PgDown 列选择 向下翻页

### 查找替换

    Command + F 查找

    Command + Option + F 替换

    Command + G 查找下一个

    Command + Shift + G 查找上一个

    Option + Enter 选中所有匹配项

    Command + D 向下选中相同内容

    Command + K Command + D 移除前一个向下选中相同内容

### 全局

    Command + Shift + P / F1 显示命令面板

    Command + P 快速打开

    Command + Shift + N 打开新窗口

    Command + W 关闭Tab

    Command + Shift + F 在文件中查找

    Control + ` 显示/隐藏终端

### 进阶

    Tab Emmet插件缩写补全

    Option + Shift + F 格式化

    Command + K Command + F 格式化选中内容

    F12 跳转到声明位置

    Option + F12 查看具体声明内容

    Command + K F12 分屏查看具体声明内容

    Command + . 快速修复

    Shift + F12 显示引用

    F2 重命名符号

    Command + Shift + . 替换为上一个值

    Command + Shift + , 替换为下一个值

    Command + K Command + X 删除行尾多余空格

    Command + K M 更改文件语言


### 文件管理

    Command + N 新建文件

    Command + O 打开文件

    Command + S 保存文件

    Command + Shift + S 另存为

    Command + Option + S 全部保存

    Command + W 关闭Tab

    Command + K Command + W 关闭全部Tab
    Command + Shift + T 重新打开被关闭的编辑器

    Command + K Enter 保持打开

    Ctrl + Tab 打开下一个

    Ctrl + Shift + Tab 打开上一个

    Command + K P 复制当前文件路径

    Command + K R 在资源管理器中查看当前文件

    Command + K O 新窗口打开当前文件

### 显示

    Command + Ctrl + F 全屏、退出全屏

    Command + Option + 1 切换编辑器分屏方式（横、竖）

    Command + + 放大

    Command + - 缩小

    Command + B 显示、隐藏侧边栏

    Command + Shift + E 显示资源管理器 或 切换焦点

    Command + Shift + F 显示搜索框

    Ctrl + Shift + G 显示Git面板

    Command + Shift + D 显示调试面板

    Command + Shift + X 显示插件面板

    Command + Shift + H 全局搜索替换

    Command + Shift + J 显示、隐藏高级搜索

    Command + Shift + C 打开新终端

    Command + Shift + U 显示输出面板

    Command + Shift + V Markdown预览窗口

    Command + K V 分屏显示 Markdown预览窗口

    Command + K Command + I 显示悬停信息

### 调试

    F9 设置 或 取消断点

    F5 开始 或 继续

    F11 进入

    Shift + F11 跳出

    F10 跳过
