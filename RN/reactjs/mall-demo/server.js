'use strict';

const webpack = require('webpack');
const webpackDevServer = require('webpack-dev-server');
const devConfig = require('./webpack.config.dev.js');
const prodConfig = require('./webpack.config.prod.js');
const openBrowser = require('react-dev-utils/openBrowser');

const isDevelopment = process.env.NODE_ENV === 'development';
const port = isDevelopment ? 8080 : 9090; 
const host = "localhost";
const protocol = 'http';

function baseConfig(config, contentBase) {
    // config.entry.unshift("webpack-dev-server/client?http://localhost:8080/", "webpack/hot/dev-server");
    config.entry.unshift(`webpack-dev-server/client?${protocol}://${host}:${port}/`, "webpack/hot/dev-server");
    return new webpackDevServer(webpack(config), {
        historyApiFallback: true,
        hot: true,
        inline: true,
        contentBase: contentBase,
        stats: { colors: true } // 用颜色标识
    });
}

let server;
if(isDevelopment) {
    console.log("development...");
    server = baseConfig(devConfig, "./src");
} else {
    console.log("production...");
    server = baseConfig(prodConfig, "./dist");
}

server.listen(port, host, function(err) {
    if(err) {
        console.log(err);
    }
    console.log("listening on " + process.env.NODE_ENV + " port:" + port);
    openBrowser(`${protocol}://${host}:${port}/`);
});