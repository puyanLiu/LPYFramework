// 使用Node.js编写的Web服务器，响应返回'Hello World'

const http = require('http');

const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World\n');
    res.end(j);
});

server.listen(port, hostname, () => {
    console.log(`服务器运行在 http://${hostname}:${port}`);
});