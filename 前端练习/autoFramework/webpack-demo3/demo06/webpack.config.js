/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 13:45:41
*/

'use strict';

// CSS模块
module.exports = {
	entry: './main.jsx',
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
			{ 
				test: /\.css$/,
				loader: 'style-loader!css-loader?modules' 
				// css-loader?modules（查询参数模块）可以将CSS模块规范化。这就是意味着模块的css默认是局部作用域
			},
		]
	}
};