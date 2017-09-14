
/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 18:34:07
*/

'use strict';

var webpack = require('webpack');
var path = require('path');

// React hot loader
// 是webpack的插件，它可以让我们在编辑react组件时，立即刷新而不会丢失状态
// 执行webpack-dev-server --progress -hot    
// --hot选项webpack-dev-server，当组件源代码改变的时候，不重新加载整个页面的情况下替换该组件
module.exports = {
	entry: [
		'webpack-dev-server/client?http://localhost:8080',
		'webpack/hot/only-dev-server',
		'./index.js'
	],
	output: {
		filename: 'bundle.js',
		publicPath: '/static/'
	},
	plugins: [
		new webpack.HotModuleReplacementPlugin(),
		new webpack.NoEmitOnErrorsPlugin()
	],
	module: {
		loaders: [
			{ 
				test: /\.js[x]?$/, 
				exclude: /node_modules/ ,
				loaders: ['react-hot-loader', 'babel-loader?presets[]=es2015&presets[]=react'],
				include: path.join(__dirname, '.')
			},
		]
	}
}; 