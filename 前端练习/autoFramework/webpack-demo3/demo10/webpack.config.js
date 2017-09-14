/*
* @Author: liupuyan
* @Date:   2017-03-16 18:38:27
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 14:16:11
*/

'use strict';

// 使用bundle-loader来分离代码
module.exports = {
	entry: './main.js',
	output: {
		filename: 'bundle.js'
	}
};