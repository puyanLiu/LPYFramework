/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 10:07:53
*/

'use strict';

// css-loader
module.exports = {
	entry: './main.js',
	output: {
		filename: 'bundle.js'
	},
	module: {
		// 需要两个加载器来转换css文件，css-loader读取css文件 style-loader将style标签插入到html页面，不同加载器由感叹号连接
		loaders: [
			{ test: /\.css$/, 
				loader: 'style-loader!css-loader'},
		]
	}
};