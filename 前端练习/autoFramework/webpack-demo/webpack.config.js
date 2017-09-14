/*
* @Author: liupuyan
* @Date:   2017-03-16 11:00:18
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-16 14:33:07
*/

'use strict';

var webpack = require('webpack');

module.exports = {
	entry: './entry.js',
	output: {
		path: __dirname,
		filename: 'bundle.js'
	},
	module: {
		loaders: [
			{
				test: /\.css$/,
				loader: 'style-loader!css-loader'
			}
		]
	},
	plugins: [
		new webpack.BannerPlugin('this is file is created by admin')
	]
}
