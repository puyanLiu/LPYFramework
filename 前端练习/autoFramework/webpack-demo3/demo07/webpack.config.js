/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 13:50:17
*/

'use strict';
var webpack = require('webpack');
var uglifyJsPlugin = webpack.optimize.UglifyJsPlugin;

// UglifyJs插件
// webpack可以通过插件系统来扩展功能
module.exports = {
	entry: './main.js',
	output: {
		filename: 'bundle.js'
	},
	plugins: [
		new uglifyJsPlugin({
			compress: {
				warnings: false
			}
		})
	]
};