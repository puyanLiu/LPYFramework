/*
* @Author: liupuyan
* @Date:   2017-03-16 18:31:18
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-16 18:35:17
*/

'use strict';

// 多个入口文件
var webpack = require('webpack');

// 类似 webpack main.js bundle.js
module.exports = {
	// 入口文件
	entry: {
		bundle1: './main1.js',
		bundle2: './main2.js'
	},
	// 输出文件
	output: {
		filename: '[name].js' // name 是 entry 的key值
	}
};