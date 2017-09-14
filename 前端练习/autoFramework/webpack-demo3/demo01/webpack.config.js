/*
* @Author: liupuyan
* @Date:   2017-03-16 18:08:11
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-16 18:30:38
*/

'use strict';

// 入口文件
var webpack = require('webpack');

// 类似 webpack main.js bundle.js
module.exports = {
	// 入口文件
	entry: './main.js',
	// 输出文件
	output: {
		filename: 'bundle.js'
	}
};