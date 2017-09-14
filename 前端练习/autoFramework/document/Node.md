# Node

## Node基本介绍

- 它不是JS文件，也不是JS框架，而是服务端的一个JS运行时（Server side Javascript runtime）
- 主要用于开发Web应用程序
- Node.js是一个轻内核（本身没有什么功能）的东东，所有的功能都要功能包提供
- node官方提供了一些最基础的包

## NVM

- Node Version Manager(Node的版本管理工具)
- 因为node的版本比较多，有时候需要依赖多个版本，并要求自由切换
- 使用
    + nvm use [对应的版本号]
    + nvm install <version> 安装
    + nvm uninstall <version> 卸载
    + nvm list 查看已经安装版本
- [官网](https://github.com/creationix/nvm)

  ```bash
  $ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash
  $ echo '. ~/.nvm/nvm.sh' >> .bash_profile
  $ nvm install stable
  $ nvm alias default stable
  ```

## NPM

- Node Package Manager(Node应用程序依赖包的管理工具)，安装卸载更新之类的操作
- [官网](https://www.npmjs.com/)
- npm管理包非常方便
- 使用
    + npm install xxx -g 全局安装包
        * 如果安装的是一个工具，工具需要在很多地方都能用，这种情况一般全局安装
    + npm install xxx
    + 安装一个包到项目本地，必须要连网
    + 安装完成后项目根目录下会多出一个node_modules文件夹，下载下来的包全部都在里面
    + 由于需要记录项目依赖那些东西，所有需要一个配置文件”package.json“，可以通过npm init命令生成
    + npm install xxx --sava可将我们安装的包名字和版本记录到配置文件中的dependencies节点中（普通的项目依赖）
    + npm install xxx --sava-dev可将我们安装的包名字和版本记录到配置文件中的devDependencies节点中（开发阶段用到的包）

## Node用途

- 开发Web应用程序
    + 做动态网站
    + 开发提供数据的服务端API
- 前端开发工具基础
    + Node.js给前端乃至整个开发行业带来一场工业革命

## 环境变量

- 环境变量就是操作系统提供的系统级别用于存储变量的地方
- 系统变量和用户变量
    + 系统变量指的是所用当前系统用户共享的变量
    + 自己的电脑一般只有一个用户
    + 建议将自己配置的环境变量放在用户变量中，用户变量比较干净
- 环境变量的变量名是不区分大小写的
- 变量间运行相互引用
- 特殊值：
    + PATH变量（不区分大小写）
    + PATH 相当于一个路径的引用
    + 只要添加到PATH变量中的路径，都可以在任何目录下搜索


