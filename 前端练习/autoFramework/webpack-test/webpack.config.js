/*
* @Author: liupuyan
* @Date:   2017-03-20 11:23:58
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-20 14:58:15
*/

'use strict';

var webpack = require('webpack');
var path = require('path');
var fs = require('fs');

var entryPath = './app/views';
var entris = fs.readdirSync(entryPath).reduce(function(o, filename) {
	!/\./.test(filename) && 
	(o[filename] = './' + path.join(entryPath, filename, filename + '.jsx'));
	return o;
}, {});

var outputDir = './dist';

var plugins = [
	// CommonsChunkPlugin插件根据各个生成的模块中共用的模块，然后打包成一个common.js文件
	new webpack.optimize.CommonsChunkPlugin({
		name: 'commons',
		filename: 'js/commons.js',
	}),
	// ProvidePlugin插件可以定义一个共用的入口，比如下面的React，它会在每个文件自动require('react')，所以在文件中不需要require('react')，也可以使用React
	new webpack.ProvidePlugin({
		React: 'react',
		ReactDOM: 'react-dom',
		reqwest: 'reqwest'
	}),
];

// 定义函数判断是否在当前生产环境
var isProduction = function() {
	return process.env.NODE_ENV === 'production';
};

var config = {
	entry: entris,
	output: {
		path: outputDir,
		filename: 'js/[name].bundle.js',
		publicPath: isProduction() ? 'http://******' : 'http://localhost:3000'
	}, 
	module: {
		loaders: [
			{
				test: /\.html$/,
				loader: 'file?name=views/[name].[ext]'
			},
			{
				test: /\.(jpe?g|png|gif|svg)$/,
				loader: 'url?limit=1024&name=img/[name].[ext]'
			}
		]
	},
	plugins: plugins,
	resolve: {
		extensions: ['.js', '.jsx']
	},
};

module.exports = config;