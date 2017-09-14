/*
* @Author: liupuyan
* @Date:   2017-03-20 17:21:11
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-21 15:01:12
*/

'use strict';

// 目标build

var path = require('path');

module.exports = {
	// __dirname 是当前运行的js所在的目录
	// process.cwd() 是当前执行node命令时候的文件夹地址
	// entry: [path.join(__dirname, 'app/main.js'), path.join(__dirname, 'app/main2.js')],
	// entry: {
	// 	main: path.resolve(__dirname, 'app/main.js'),
	// 	main2: path.join(__dirname, 'app/main2.js'),
	// },
	context: path.join(__dirname, 'app'),
	entry: {
		main: './main.js',
		main2: './main2.js'
	},
	output: {
		publicPath: '/',
		path: path.join(__dirname, '/build'), // 打包后的文件存放的地方
		filename: "[name].js" // 打包后输出文件的文件名
	},
	devServer: {
		publicPath: '/',
		hot: true
		// port: 8888, // 设置监听端口(默认8080)
		// contentBase: './build/', // 本地服务器所加载的页面所在目录
	}
};