/*
* @Author: liupuyan
* @Date:   2017-03-17 13:42:11
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-17 13:53:45
*/

'use strict';

document.write('<h1>Hello World</h1>');

// 通过环境变量，来启用一些只在开发环境下运行的代码
if (__DEV__) {
	document.write(new Date());
}