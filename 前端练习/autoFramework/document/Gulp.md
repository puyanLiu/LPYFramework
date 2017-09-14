# 前端自动化的工作流环境

## 常见的前端工程构建工具

- Gulp
- FIS
- Grunt

## Gulp

- gulp是前端开发过程中一种基于流的代码创建工具，是自动化项目的构建利器，不仅能对网站资源进行优化，而且在开发过程中很多重复的任务能够使用正确的工具自动完成
- gulp是基于Node.js的自动任务运行器
- 能自动化的完成javascript、coffee、sass、less、html/image、css等文件的测试、检查、合并、压缩、格式化、浏览器自动刷新、部署文件生成，并监听文件在改动后重复指定的这些步骤
    + less -> css
    + css压缩
    + js混淆
    + html压缩
    + img图片优化
    + 。。。。
- [官网](http://gulpjs.com/)
- [中文网](http://www.gulpjs.com.cn/)

## 目标

- 搭建一个自动化的工作流环境
    + 自动编译
    + 自动合并
    + 自动刷新
    + 自动部署
    
## 入门指南

- 安装Node.js
    + 通过brew安装node和npm，安装Nodejs过程会自动安装npm(node packages manager)
    + npm 3 以前的版本文件依赖是层级依赖
    + npm 3 以后的版本文件依赖是平行依赖
    + gulp本身是node的模块

- 全局安装gulp

```shell
npm install --global gulp（或者npm install -g gulp）
```

- 作为项目的开发依赖(devDependencies)安装

```shell
npm install --save-dev gulp
```

- 在项目根目录下创建一个名为`gulpfile.js`文件，此文件是gulp入口文件

```shell
var gulp = require('gulp');

gulp.task('default', function() {
  // 将你的默认的任务代码放在这
});
```

- 运行gulp

```shell
gulp
// 默认的名为 default 的任务（task）将会被运行，在这里，这个任务并未做任何事情
```

## 操作过程

- 首先通过 gulp.src() 方法获取到想要处理的文件流
- 然后把文件流通过 pipe 方法导入到 gulp 的插件中
- 最后把经过插件处理后的流再通过pipe方法导入到 gulp.dest() 方法中
- gulp.dest() 方法则把流中的内容写入到文件中

## 流（Stream）

- 单来说就是建立在面向对象基础上的一种抽象的处理数据的工具
- 在流中，定义了一些处理数据的基本操作，如读取数据，写入数据等
- 只需要对流进行所有操作的，而不用关心流的另一头数据的真正流向
- 而gulp正是通过流和代码优于配置的策略来尽量简化任务编写的工作。这看起来有点像jQuery的方法，把动作串起来创建构建任务

## gulp API
> [gulp API](http://www.gulpjs.com.cn/docs/api/)

- `gulp.src(globs[, options])`
    + src方法是指定需要处理的源文件的路径，gulp借鉴了Unix操作系统的管道(pipe)思想，前一级的输出，直接变成后一级的输入
    + globs需要处理的源文件匹配符路径，类型String 或 StringArray
    + options 类型Object
        * options.buffer 类型Boolean，默认ture，设置为false，将返回file.content的流并且不缓冲文件，处理大文件时非常有用
        * options.read 类型Boolean，默认true，设置false，将不执行读取文件操作，返回null
        * options.base 类型String，设置输出路径以某个路径的某个组成部分为基础向后拼接

        ```
        gulp.src('client/js/**/*.js') // 匹配 'client/js/somedir/somefile.js' 并且将 `base` 解析为 `client/js/`
          .pipe(minify())
          .pipe(gulp.dest('build'));  // 写入 'build/somedir/somefile.js'

        gulp.src('client/js/**/*.js', { base: 'client' })
          .pipe(minify())
          .pipe(gulp.dest('build'));  // 写入 'build/js/somedir/somefile.js'
        ```

- `gulp.dest(path[, options])`
    + dest方法是指定处理完后文件输出的路径
    + path 类型String 或 Function，指定文件输出路径，或者定义函数返回文件输出路径
    + options 类型Object
        * options.cwd 类型String，默认process.cwd()：前脚本的工作目录的路径，当文件输出路径为相对路径将会用到
        * options.mode 类型String，默认0777，指定被创建文件夹的权限
- `gulp.task(name[, deps], fn)`
    + task定义一个gulp任务
    + name 类型String，指定任务的名称（不应该有空格）
    + deps 类型StringArray，一个包含任务列表的数组，这些任务会在你当前任务运行之前完成
    + fn 类型Function，该函数定义任务所要执行的一些操作
- `gulp.watch(glob [, opts], tasks)` or `gulp.watch(glob [, opts, cb])`
    + watch方法是用于监听文件变化，文件一修改就会执行指定的任务
    + glob 类型String 或 StringArray，需要处理的源文件匹配符路径
    + opts 类型Object
    + tasks 类型StringArray，需要执行的任务的名称数组
    + cb(event) 类型Function，每个文件变化执行的回调函数，callback会被传入一个名为event的对象，这个对象描述了所监控到的变化

    ```
    var watcher = gulp.watch('js/**/*.js', ['uglify','reload']);
    watcher.on('change', function(event) {
      console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    });

    gulp.watch('js/**/*.js', function(event) {
      console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
    ```

## 基本使用
- 定义一个任务
- 复制（单个/多个）文件
- gulp.src(globs[, options])的文件路径匹配规则（gulp内部使用了node-glob模块来实现其文件匹配功能）
    + [node-glob语法](https://github.com/isaacs/node-glob)
    + globs参数是文件匹配模式（类似正则表达式），用来匹配文件路径（包括文件名），或者具体的文件路径。当有多个匹配模式时，该参数可以为一个数组
    + globs的匹配语法和规则
        * * 匹配所有文件
        * ** 匹配0个或多个子文件夹
        * {} 匹配多个属性
        * ? 匹配文件路径中的一个字符(不会匹配路径分隔符)
        * […] 匹配方括号中出现的字符中的任意一个，当方括号中第一个字符为 ^ 或 !时，则表示不匹配方括号中出现的其他字符中的任意一个。类似js正则表达式中的用法
        * !(pattern|pattern|pattern) 排除文件
        * ?(pattern|pattern|pattern) 匹配括号中给定的任一参数0次或1次
        * +(pattern|pattern|pattern) 匹配括号中给定的任一参数至少1次
        * *(pattern|pattern|pattern) 匹配括号中给定的任一参数0次或多次
        * @(pattern|pattern|pattern) 匹配括号中给定的任一参数1次
    + 例子
    
    ```
    * 能匹配 a.js,x.y,abc,abc/,但不能匹配a/b.js
    *.* 能匹配 a.js,style.css,a.b,x.y
    */*/*.js 能匹配 a/b/c.js,x/y/z.js,不能匹配a/b.js,a/b/c/d.js
    ** 能匹配 abc,a/b.js,a/b/c.js,x/y/z,x/y/z/a.b,能用来匹配所有的目录和文件，
    src/**/*.js(包含src的0个或多个子文件夹下的js文件)
    **/*.js 能匹配 foo.js,a/foo.js,a/b/foo.js,a/b/c/foo.js
    a/**/z 能匹配 a/z,a/b/z,a/b/c/z,a/d/g/h/j/k/z
    a/**b/z 能匹配 a/b/z,a/sb/z,但不能匹配a/x/sb/z,因为只有单**单独出现才能匹配多级目录
    ?.js 能匹配 a.js,b.js,c.js
    a?? 能匹配 a.b,abc,但不能匹配ab/,因为它不会匹配路径分隔符
    [xyz].js 只能匹配 x.js,y.js,z.js,不会匹配xy.js,xyz.js等,整个中括号只代表一个字符
    [^xyz].js 能匹配 a.js,b.js,c.js等,不能匹配x.js,y.js,z.js
    ```

- 默认任务
    + gulp中的任务名有个特殊值`default`
- 文件监视自动执行任务

## gulp插件列表
- [gulp插件](http://gulpjs.com/plugins/)
- [npm查看所有插件](https://www.npmjs.com/browse/keyword/gulpplugin)

## 常用插件
- [编译Less：gulp-less](https://www.npmjs.com/package/gulp-less)
- [压缩css：gulp-cssnano](https://github.com/ben-eb/gulp-cssnano)
- [浏览器同步测试工具官网：Browsersync](https://browsersync.io/docs/gulp)
- [浏览器同步测试工具中文网：Browsersync](http://www.browsersync.cn/docs/gulp/)
- [Javascript合并：gulp-concat](https://github.com/contra/gulp-concat)
- [Javascript压缩混淆：gulp-uglify](https://github.com/terinjokes/gulp-uglify)
- [压缩html：gulp-htmlmin](https://github.com/jonschlinkert/gulp-htmlmin)
    + 可以压缩页面js、css，去除页面空格、注释，删除多余属性等操作
- [根据浏览器版本自动处理浏览器前缀：gulp-autoprefixer](https://github.com/sindresorhus/gulp-autoprefixer)
- [编译 Jade: gulp-jade](https://www.npmjs.com/package/gulp-jade)
- [创建本地服务器：gulp-connect](https://www.npmjs.com/package/gulp-connect)
- [重命名文件：gulp-rename](https://www.npmjs.com/package/gulp-rename)
- [最小化 css 文件：gulp-minify-css](https://www.npmjs.com/package/gulp-minify-css)
- [压缩html文件 gulp-minify-html](https://www.npmjs.com/package/gulp-minify-html)
- [最小化图像：gulp-imagemin](https://www.npmjs.com/package/gulp-imagemin)



