/**
 * 针对后端环境中 node 的一些单元测试方案
 * 测试框架 mocha : http://mochajs.org/
 * 断言库 should : https://github.com/tj/should.js
 * 断言库 expect https://github.com/LearnBoost/expect.js/
 * 测试率覆盖工具 istanbul : https://github.com/gotwarlost/istanbul
 * 简单 Makefile 的编写 : http://blog.csdn.net/haoel/article/details/2886
 * 
 * 安装mocha npm install mocha -g
 * -g 与 非-g 的区别，就是安装位置的区别，g 是 global 的意思。如果不加的话，则安装 mocha 在你的项目目录下面；如果加了，则这个 mocha 是安装在全局的，如果 mocha 有可执行命令的话，那么这个命令也会自动加入到你系统 $PATH 中的某个地方
 * 全局的直接运行mocha
 * 
 * 非全局
 * $ npm i mocha --save-dev，装个 mocha 到项目目录中去
 * $ ./node_modules/.bin/mocha，用刚才安装的这个特定版本的 mocha，来跑项目的测试代码
 * 
 * 覆盖率测试
 * 安装一个 istanbul : $ npm i istanbul -g
 * 执行 $ istanbul cover _mocha
 */

/**
 * 前端脚本单元测试
 * 测试框架 mocha 进行前端测试 : http://mochajs.org/
 * 全栈的断言库 chai: http://chaijs.com/
 * headless 浏览器 phantomjs: http://phantomjs.org/
 * 
 * 前端脚本的单元测试主要有两个困难需要解决。
 * 1、运行环境应当在浏览器中，可以操纵浏览器的DOM对象，且可以随意定义执行时的 html 上下文。
 * 2、测试结果应当可以直接反馈给 mocha，判断测试是否通过。
 * 
 * 搭建测试原型，用mocha自带的脚手架可以自动生成
 * cd vendor
 * mocha init . // 生成脚手架
 * 
 * 测试反馈
 * mocha没有提供一个命令行的前端脚本测试环境(因为我们的脚本文件需要运行在浏览器环境中)，因此我们使用phantomjs帮助我们搭建一个模拟环境。不重复制造轮子，这里直接使用mocha-phantomjs帮助我们在命令行运行测试
 * npm i -g mocha-phantomjs
 * 在index.html中添加兼容代码
 * <script>mocha.run()</script>
 * 
 * 命令行运行
 * mocha-phantomjs index.html
 * 
 * 基于 phanatomjs 你几乎可以调用所有的浏览器方法
 * 而 mocha-phanatomjs 也可以很便捷地将测试结果反馈到 mocha，便于后续的持续集成
 */

var fibonacci = function (n) {
  if (typeof n !== 'number') {
    throw new Error('n should be a Number');
  }
  if (n < 0) {
    throw new Error('n should >= 0');
  }
  if (n > 10) {
    throw new Error('n should <= 10');
  }
  if (n === 0) {
    return 0;
  }
  if (n === 1) {
    return 1;
  }
  return fibonacci(n-1) + fibonacci(n-2);
};

if (require.main === module) {
  // 如果是直接执行 main.js，则进入此处
  // 如果 main.js 被其他文件 require，则此处不会执行。
  var n = Number(process.argv[2]);
  console.log(process.argv);
  console.log('fibonacci(' + n + ') is', fibonacci(n));
}

exports.fibonacci = fibonacci;