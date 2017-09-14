/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 10:29:06
*/

'use strict';

// image-loader
module.exports = {
	entry: './main.js',
	output: {
		filename: 'bundle.js'
	},
	module: {
		// url-loader可以转换image文件，如果图片大小小于8192字节，将会转化成一个base64的Data URL，否则就转化成普通的URL
		// // ?标记是用来将参数传到加载器里面去的
		loaders: [
			{ test: /\.(png|jpg)$/, 
				loader: 'url-loader?limit=8192'},
		]
	}
};