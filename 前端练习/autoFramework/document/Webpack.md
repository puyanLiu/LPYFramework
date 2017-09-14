# webpack

## webpack

- 模块加载器兼打包工具，能把各种资源，例如JS（含JSX）、coffee、样式（含less/sass）、图片等都作为模块来使用和处理
- [官网](http://webpack.github.io/)
- [webpack2官网英文文档](https://webpack.js.org/configuration/)
- [webpack2官网中文文档](http://www.css88.com/doc/webpack2/)
- [webpack中文教程-简单-版本较老](http://webpackdoc.com/index.html)

## webpack安装配置

### 初始化

- webpack需要npm来安装和运行，初始化当前文件夹`npm init`，会创建`package.json`配置文件，接下来可以通过npm来管理依赖
    + [package.json属性详解](http://www.cnblogs.com/tzyy/p/5193811.html)
    + [npm scripts使用指南](http://www.ruanyifeng.com/blog/2016/10/npm_scripts.html)
    
```
  name: 包的名称
  version: 版本
  description: 描述
  main: 表示当别人引用require时的入口文件
  scripts： 定义npm脚本，当运行npm run命令时，会新创建一个Shell，并将当前目录的/node_modules/.bin/加入到PATH环境变量中，之后运行脚本命令，结束后，将PATH恢复原样
```

### 开发与发布

- 为了分别管理，npm在package.json提供如下两个字段
    + devDependencies 仅开发依赖
    + dependencies 依赖包
- 下载别人的包时，只希望下载一个发布的可运行版本，通过`npm install --production`仅下载dependencies字段中的依赖

### 安装webpack

- `npm install webpack --save-dev`

### 配置webpack

- cli命令行形式，一般会通过配置`package.json`中写入`scripts`字段的形式
- 配置`webpack.config.js`文件中写入字段，webpack在启动时会读取它

### 基本配置属性

#### entry

模块的来源，入口，起点。可传入的值如下

- 字符串`entry: '某模块'`，表示一个单一模块作为起点，将这个模块需要的东西打包成一个
- 数组`entry: ['模块1', '模块2']`，模块1与模块2互相之间并没有依赖，但还是要打包一起，webpack从左到右把各个模块及他们依赖打包在一起，然后从左到右把各个文件拼接在一起，最终达成一个包
- 对象，这种有几个入口文件，会打包成几份
```
entry: {
    入口1: '某模块',
    入口2: ['模块1', '模块2']
}

output: {
    path: path.join(__dirname, '/build'), // 打包后的文件存放的地方
    filename: "[name].js" // 打包后输出文件的文件名 [name]对应entry中的属性名
}
```

entry值的写法

- [Path模块详解](http://javascript.ruanyifeng.com/nodejs/path.html)

```
entry: path.join(__dirname, 'app/main.js'); // 仅路径拼接，会正确使用当前系统的路径分隔符
entry: path.resolve(__dirname, 'app/main.js'); // 将相对路径转为绝对路径
entry: __dirname + 'app/main.js';

// 通过context配置设置entry根目录
context: path.join(__dirname, 'app'), // 不声明context字段，默认是process.cwd() 是当前执行node命令时候的文件夹地址
entry: './main.js',
```

### output

> 控制webpack如何向硬盘写入编译文件

- output.path 规定文件被写入硬盘的位置
- output.publicPath
- output.filename 指定每个输出文件的名称（仅用于文件）
    + [name] 对应entry里边的属性名
    + [hash]
    + [chunkhash]

## 配置webpack-dev-server服务器工具

> 可以让浏览器实时刷新

### 安装

```
// 默认将在当前文件夹下启动一个websocket服务，端口号8080
npm install --save-dev webpack-dev-server
```

### 配置服务

- Node API

```
devServer: {
  port: 8888, // 设置监听端口(默认8080)
  contentBase: './build/', // 本地服务器所加载的页面所在目录
}
```

- cmd指令
  + `--progress` 显示打包过程
  + `--colors` 显示出来的进度加点颜色
  + `--content-base` 设置目录
  + `--port` 端口号
  
```
// --代表一个指令
webpack-dev-server --devtool eval-source-map --progress --colors --port 3000 --content-base ./build
```

- 将cmd指令写到package.json中

```
"scripts": {
    "build": "webpack",
    "dev": "webpack-dev-server --devtool eval-source-map --progress --colors --port 3000 --content-base ./build"
  },
```

### webpack-dev-server刷新两种模式

> webpack-dev-server自带自动刷新功能，并且提供了两种启动模式

- iframe

页面嵌套在一个iframe下，在代码改动的时候，这个iframe会重新加载

- inline 

一个小型的webpack-dev-server客户端会作为入口文件打包，这个客户端会在后端代码改变的时候刷新页面，webpack默认开启inline模式

#### 启用iframe模式

- 地址多添加webpack-dev-server
  + 例如`http://localhost:3000/webpack-dev-server/`，会仅仅刷新iframe标签内容
- 关闭默认启动的inline模式

```
"scripts": {
    "build": "webpack",
    "dev": "webpack-dev-server --devtool eval-source-map --progress --colors --no-inline --port 3000 --content-base ./build"
  },
```

### 热替换

(未完。。。。)

> 上述我们使用的两种方式，inline模式每次都会刷新整个页面，iframe模式会刷新整个iframe标签，显然这都是不是我们想要的，我们想要的是局部刷新，提高效率，节省时间

webpack-dev-server自带的Hot Module Replacement模块用来实现热替换功能，两种方式开启

- cmd
  + `--hot`
- Node API

