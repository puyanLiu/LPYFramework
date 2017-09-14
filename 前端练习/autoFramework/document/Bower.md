# Bower

## Bower简介

- Bower就是用来管理项目中所有的依赖，主要用于Web页面开发时使用的包管理，比如jQuery，bootstrap
- [官网](https://bower.io/)

## Bower安装

```shell
npm install -g bower
```

## Bower常用命令

```shell
$ # 初始化一个Bower的配置文件
$ bower init
$ # 安装一个包
$ bower install jquery
$ # GitHub shorthand
$ bower install desandro/masonry
$ # Git endpoint
$ bower install git://github.com/user/package.git
$ # URL
$ bower install http://example.com/script.js
$ # 安装一个包并将其添加到配置文件
$ bower install jquery --save
$ # 卸载一个包
$ bower uninstall jquery
$ # 更新所有的包
$ bower update
```
