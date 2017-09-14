/*
* @Author: liupuyan
* @Date:   2017-03-17 13:42:11
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 14:20:44
*/

'use strict';

// 使用bundle-loader来分离代码
// 从另一个代码块中去加载a.js
// webpack会将main.js构建成bundle.js，a.js构建成0.bundle.js
var load = require('bundle-loader!./a.js');

load(function(file) {
	document.open();
	document.write('<h1>' + file + '</h1>');
	document.close();
});