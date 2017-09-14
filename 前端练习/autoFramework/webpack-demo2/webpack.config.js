/*
* @Author: liupuyan
* @Date:   2017-03-16 15:21:24
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-16 16:43:01
*/

'use strict';

var webpack = require('webpack');
// 用于提取多个入口文件的公共脚本部分，然后生成一个common.js来方便多页面之间进行复用
var commonsPlugin = new webpack.optimize.CommonsChunkPlugin('common');

module.exports = {
	// 插件项
	plugins: [
		commonsPlugin
	],
	// 页面入口文件配置
	entry: {
		detail: './src/detail.js',
		// 支持数组形式，将加载数组中的所有模块，但以最后一个模块作为输出
		index: ['./src/index.js']
	},
	// 入口文件输出项配置（即入口文件最终要生成什么名字的文件、存放到哪里）
	output: {
		path: 'dist/',
		filename: '[name].js'
	},
	module: {
		// 加载器配置（告知webpack每一种文件都需要使用什么加载器来处理）
		loaders: [ 
			{
				// .css文件使用style-loader 和 css-loader来处理
				test: /\.css$/, 
				loader: 'style-loader!css-loader'
			}, 
			{
				// .js文件使用jsx-loader 来编译处理
				test: /\.js$/,
				loader: 'jsx-loader?harmony'
			}, 
			{
				// .scss文件使用style-loader、css-loader 和 sass-loader 来编译处理
				test: /\.scss$/,
				loader: 'style!css!sass?sourceMap'
			}, 
			{
				// 图片文件使用url-loader 来处理，小于8kb的直接转为base64
				test: /\.(png|jpg)$/,
				loader: 'url-loader?limit=8192'
			}	
		]
	},
	// 其他解决方案配置
	resolve: {
		// 查找module的话从这里开始查找
		// root: './',
		// 自动扩展文件后缀名，意味着我们require模块可以省略不写后缀名
		extensions: ['.js', '.json', '.scss'],
		// 模块别名定义，方便后续直接引用别名，无须多写长长的地址
		// alias: {

		// }
	}
};