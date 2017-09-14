/*
* @Author: liupuyan
* @Date:   2017-03-10 18:08:20
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-10 18:32:28
*/

'use strict';


// 用来创建一个HTTP服务器
var http = require('http');

// 创建一个服务器
var server = http.createServer(function(request, response) {
	console.log('come');
	console.log(request.url);

	// 处理请求和响应
	response.writeHead(200, {
		'Content-Type': 'text/html', // 告诉客户端我给你的是HTML
		'key1': 'value1'
	});

	response.write('<H1>哈哈哈</H1>');
	// 告诉服务器所有响应头和主体都已被发送，服务器应将消息视为已完成
	response.end();
});

// 启动服务
server.listen(8888, function(error) {
	console.log('成功监听8888端口');
});