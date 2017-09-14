/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 14:38:04
*/

'use strict';

var webpack = require('webpack');
var CommonsChunkPlugin = require('webpack/lib/optimize/CommonsChunkPlugin');
// var commonsPlugin = new webpack.optimize.CommonsChunkPlugin('common');

// 公用代码块
// 当多个脚本含有相同代码块的时候，可以使用CommonsChunkPlugin将相同的部分提取出去，分离成一个文件
module.exports = {
	entry: {
		bundle1: './main1.jsx',
		bundle2: './main2.jsx'
	},
	output: {
		filename: '[name].js'
	},
	module: {
		loaders: [
			{
				test: /\.js[x]?$/, 
				exclude: /node_modules/ ,
				loader: 'babel-loader?presets[]=es2015&presets[]=react'
			}
		]
	},
	plugins: [
		new CommonsChunkPlugin('init')
	]
};