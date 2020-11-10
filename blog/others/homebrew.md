# 你不知道的Homebrew

> [Homebrew](https://brew.sh/) is a package manager for Mac OS. It lets you download binaries, packages, and applications with a single command.

## 安装Homebrew

```sh
# Installs Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 升级Homebrew

```sh
# Updates Homebrew
brew update
```

## 搜索包

```sh
brew seach tree
```

## 安装包

```sh
# Install Package
brew install <formula>

# For Example
brew install tree
```

## 升级包

```sh
# Upgrades one package to the latest version
brew upgrade <formula>

# Upgrades all packages to their latest version
brew upgrade

# For Example
brew upgrade tree
```

## 删除包

```sh
brew uninstall <formula>

# For Example
brew uninstall tree
```

## 清理空间

```sh
brew cleanup
```

## Brew Tap

`homebrew/core`维护一份可用包列表，在你执行`brew install` 命令时都是从这个列表进行安装的。

如果需要安装是一个第三方的包列表就需要我们使用`brew tap`命令来将此列表添加新`homebrew/core`列表中

```sh
# For Example
# Required to install MongoDB with Homebrew
brew tap mongodb/brew

# Installs MongoDB
brew install mongodb-community
```

## Brew Cask

`homebrew/cask`可以安装GUI程序， 如： Chrome， Vscode, Atom等

```sh
# 获取brew cask
brew tap caskroom/cask
brew install brew-cask

# Installs Google Chrome
brew cask install google-chrome
brew cask install visual-studio-code
```