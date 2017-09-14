/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 09:46:53
*/

'use strict';

// Babel-loader
module.exports = {
	entry: './main.jsx',
	output: {
		filename: 'bundle.js'
	},
	module: {
		// 加载babel-loader，处理js或者jsx结尾的文件
		loaders: [
			{ test: /\.js[x]?$/, 
				exclude: /node_modules/ ,
				loader: 'babel-loader?presets[]=es2015&presets[]=react'},
		]
	}
};