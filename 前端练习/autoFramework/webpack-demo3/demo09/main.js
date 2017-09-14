/*
* @Author: liupuyan
* @Date:   2017-03-17 13:42:11
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 14:13:11
*/

'use strict';

// 使用require.ensure来定义一个分割点
// ./a.js应该从Bundle.js分类 然后构建一个独立的文件
// webpack会把main.js和a.js构建成不同的代码块（bundle.js和0.bundle.js），并在有需要的时候从bundle.js加载1.bundle.js
require.ensure(['./a'], function(require) {
	var content = require('./a');
	document.open();
	document.write('<h1>' + content + '</h1>');
	document.close;
});