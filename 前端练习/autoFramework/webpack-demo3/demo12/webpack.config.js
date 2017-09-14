/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 15:34:43
*/

'use strict';

var webpack = require('webpack');
var jquery = require('jquery');
var CommonsChunkPlugin = require('webpack/lib/optimize/CommonsChunkPlugin');

// 第三方代码块
// 用CommononsChunckPlugin提取第三方库将其分离成一个文件
module.exports = {
	entry: {
		app: './main.js',
		vendor: ['jquery'],
	},
	output: {
		filename: '[name].js'
	},
	plugins: [
		new CommonsChunkPlugin(/* chunkName = */'vendor')
	]
};