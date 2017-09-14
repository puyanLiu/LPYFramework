## Git

## Git简介

- 源代码管理工具
- GIT是Linux之父当年为了维护管理Linux的源代码写的一个工具
- Git 之前 很多使用 svn vss tfs hs ......
- [官网](https://guides.github.com/)

## Git命令操作

- 初始化一个本地git仓库

```shell
cd 定位到仓储文件夹目录
git init // 初始化一个本地的仓库
```

> 就是在本地文件夹中添加了一个.git的文件夹用于记录所有的项目变更信息

- 查看本地仓储的变更状态

```shell
git status
用于查看本地仓储的状态
第一次查看，显示的是一堆没有被跟踪的文件

git status -s // -s 是输出简要的变更日志
```

- 添加本地暂存（托管）文件

```shell
git add
可以将一个没有被跟踪的文件添加到跟踪列表

类似于node_modules这种性质的文件是不应该被跟踪

$ git add README.md
// 添加通配符匹配的文件
$ git add *.md
// 添加所有未托管的文件（忽略.gitignore清单中的列表）
$ git add --all
```

- 添加本地GIT忽略清单文件

```shell
在代码库文件夹的根目录添加一个.gitignore文件
此文件用于说明忽略的文件有哪些
// 添加OS X中系统文件.DS_Store到忽略清单，这将忽略项目任意目录下的.DS_Store文件或是文件夹
$ echo .DS_Store >> .gitignore
```

- 提交被托管的文件变化到本地仓储

```shell
git commit
将本地的变化提交的本地的仓库文件夹归档
一般在有了一个小单元的整体变化后再提交

$ git commit -m 'Initial commit(change log)'
```

- 对比差异

```shell
git diff
可以用于对比当前状态和版本库中状态的变化
```

- 提交日志

```shell
git log 
可以查看提交日志
```
- 回归到指定版本

```shell
git reset --hard
```

- 为仓储添加远端（服务器端）地址

```shell
// 添加一个远端地址并起了一个别名叫origin
$ git remote add origin https://github.com/Micua/Git.git
// 查看现有的远端列表
$ git remote -v
```

- 将本地仓储的提交记录推送到远端的master分支

```shell
$ git push -u origin master
```

- 拉取远端master分支的更新记录到本地

- 回归到指定版本