/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 17:51:32
*/

'use strict';

var webpack = require('webpack');

// 暴露全局变量
// 如果使用了全局变量，但并不想让他们包含在webpack打包文件里，可以配置externals
// 可以将data暴露成为一个全局变量
module.exports = {
	entry: {
		app: './main.jsx',
	},
	output: {
		filename: 'bundle.js'
	},
	module: {
		loaders: [
			{ 
				test: /\.js[x]?$/, 
				exclude: /node_modules/ ,
				loader: 'babel-loader?presets[]=es2015&presets[]=react'
			},
		]
	},
	externals: {
		'data': 'data'
	}
};

