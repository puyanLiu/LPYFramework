/*
* @Author: liupuyan
* @Date:   2017-03-16 11:38:05
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-16 14:16:11
*/

'use strict';

// 载入style.css
// require('!style-loader!css-loader!./style.css');

require('./style.css');

document.write('It works.');

// 添加模块
document.write(require('./module.js'));