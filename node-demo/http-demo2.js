// 一次HTTP请求分四个阶段，分别是连接、请求、应答、结束

const http = require('http');
var options = {
    host: '127.0.0.1',
    port: 80,
    path: '/',
    method: 'GET',
    headers: {
        'Content-Type': 'application/json'
    }
};
var req = http.request(options);
req.once('response', (res) => {
    var result = '';
    res.on('data', function(chunk) {
        result + chunk.toString();
    });
    res.on('end', function() {
        console.log('请求结果' + result);
    });
});
req.on('error', (e) => {
    console.log('错误' + e.message);
});
req.end();