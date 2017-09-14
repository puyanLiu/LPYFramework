/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 13:59:06
*/

'use strict';
var webpack = require('webpack');
var devFlagPlugin = new webpack.DefinePlugin({
	__DEV__: JSON.stringify(JSON.parse(process.env.DEBUG || 'false'))
});

// 环境标记
// 运行 env DEBUG=true webpack-dev-server
module.exports = {
	entry: './main.js',
	output: {
		filename: 'bundle.js'
	},
	plugins: [
		devFlagPlugin
	]
};