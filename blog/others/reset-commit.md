# 撤销Commit

做笔记，做笔记， 做笔记。

## 撤销commit

通常我写完代码之后就会执行以下命令：

```sh
git add -A //添加所有文件

git commit -m "注解信息"
```

执行完成之后突然发现有的文件的修改不应该在这次commit提交，所以想要撤回commit。之前我的做法是使用**sourcetree** 来完成。 用着用着感觉好麻烦，所以就好好看了下`git reset`命令。

其实我们可以这么做：

```bash
git reset --soft HEAD^
```

上面命令中的`HEAD^`的意思是上一个版本，也可以写成`HEAD~1`； `HEAD^^`就上上次的版本，可以使用`HEAD~2`， 依次类推即可。所以如果你进行了`N(N >= 1)`次commit回滚，可以使用`HEAD~N`


### 参数解释

- `--mixed` 

  不删除工作空间改动代码，撤销commit，并且撤销git add . 操作

  这个为默认参数,`git reset --mixed HEAD^`和 `git reset HEAD^ `效果是一样的。

- `--soft  `

  不删除工作空间改动代码，撤销commit，不撤销`git add`. 

- `--hard`

  删除工作空间改动代码，撤销commit，撤销`git add` . 

  注意完成这个操作后，就恢复到了上一次的commit状态。

## 修改commit的注释

如果commit注释写错了，只是想改一下注释，只需要

```bash
git commit --amend
```

此时会进入默认vim编辑器，修改注释完毕后保存就好了。

## 添加漏加的改动

```bash
git add file

git commit --amend --no-edit
```
`--no-edit` 参数可以让我们不用进入vim编辑器， 使用原有信息直接修改。

## 撤销本地的所有更改

撤销本地的所有更改，平时我都是通过vscode编辑器自带的git可视化工具来处理的，略嫌麻烦。

```bash
git reset HEAD .  # 撤销暂存区的修改。注意命令最后面有一个点

git checkout .  && git clean -xdf  # 撤销工作区的所有更改(包括新增的文件和目录)。注意命令最后面有一个点

### 或者使用：
git add -A && git reset --hard HEAD
```