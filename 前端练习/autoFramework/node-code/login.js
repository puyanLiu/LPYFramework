/*
* @Author: liupuyan
* @Date:   2017-03-10 18:33:15
* @Last Modified by:   liupuyan
* @Last Modified time: 2017-03-13 15:43:59
*/

'use strict';


// 可以用来创建一个HTTP服务器
var http = require('http');

// 创建一个服务
var server = http.createServer(function(request, response) {
	var requestUrl = request.url;
	console.log(requestUrl);
	switch(requestUrl) {
		case '/login':
			// 请求登录界面
			 console.log('请求登录界面');
			 login(request, response);
			break;
		case '/post':
			// 提交表单数据
			console.log('提交表单数据');
			post(request, response);
			break;
		default: 
			response.writeHead(404, {});
			response.end();
			break;
	}
});

// 启动服务
server.listen(8888, function(error) {
	console.log('成功监听8888端口');
});

function loginHtml(response) {
	response.write('<!DOCTYPE html>');
	response.write('<html lang="en">');
	response.write('    <head>');
	response.write('        <meta charset="utf-8">');
	response.write('        <title>登录表单</title>');
	response.write('    </head>');
	response.write('    <body>');
	response.write('    	<form action="/post" method="post">');
	response.write('    		<table border="1">');
	response.write('	    		<tr>');
	response.write('	    			<td>用户名</td>');
	response.write('	    			<td><input type="text" name="username" id="" placeholder="请输入用户名"></td>');
	response.write('	    		</tr>');
	response.write('	    		<tr>');
	response.write('	    			<td>密码</td>');
	response.write('	    			<td><input type="text" name="password" id="" placeholder="请输入密码"></td>');
	response.write('	    		</tr>');
	response.write('	    		<tr>');
	response.write('	    			<td></td>');
	response.write('	    			<td><input type="submit" value="提交"></td>');
	response.write('	    		</tr>');
	response.write('	    	</table>');
	response.write('    	</form>');
	response.write('    </body>');
	response.write('</html>');
}

function login(request, response) {
	response.writeHead(200, {
		'Content-Type': 'text/html'
	});
	loginHtml(response);
	response.end();
}

var querystring = require('querystring');
function post(request, response) {
	var postData = ''; // http传递的都是字符串
	request.on('data', function(part) {
		console.log(part);
		postData += part;
	});
	request.on('end', function() {
		var obj = querystring.parse(postData); // 将字符串转换为对象
		console.log(obj);
		if (obj.username === 'admin' && obj.password === '123') {
			response.writeHead(200, {
				'Content-Type': 'text/html'
			});
			response.end('<h1>登录成功</h1>');
		} else {
			response.writeHead(200, {
				'Content-Type': 'text/html'
			});
			loginHtml(response);
			response.end();
		}
	});
}