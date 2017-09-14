/**
 * superagent(http://visionmedia.github.io/superagent/ ) 是个 http 方面的库，可以发起 get 或 post 请求
 * cheerio(https://github.com/cheeriojs/cheerio ) 大家可以理解成一个 Node.js 版的 jquery，用来从网页中以 css selector 取数据，使用方式跟 jquery 一样一样的
 * eventproxy(https://github.com/JacksonTian/eventproxy )
 */

// 引入依赖
var express = require('express');
var eventproxy = require('eventproxy');
var superagent = require('superagent');
var cheerio = require('cheerio');
// url 模块是 Node.js 标准库里面的
// http://nodejs.org/api/url.html
var url = require('url');
var app = express();

var cnodeUrl = 'https://cnodejs.org/';

app.get('/', function (req, res, next) {
    superagent.get(cnodeUrl)
    .end(function (err, sres) {
        if (err) {
            return console.error(err);
        }
        var topicUrls = [];
        var items = [];
        var $ = cheerio.load(sres.text);
        // 获取首页所有的链接
        $('#topic_list .topic_title').each(function (idx, element) {
            var $element = $(element);
            // $element.attr('href') 本来的样子是 /topic/542acd7d5d28233425538b04
            // 我们用 url.resolve 来自动推断出完整 url，变成
            // https://cnodejs.org/topic/542acd7d5d28233425538b04 的形式
            // 具体请看 http://nodejs.org/api/url.html#url_url_resolve_from_to 的示例
            var href = url.resolve(cnodeUrl, $element.attr('href'));
            topicUrls.push(href);
        });
        console.log(topicUrls);

        // 得到 topicUrls 之后

        // 得到一个 eventproxy 的实例
        var ep = new eventproxy();
        // 命令 ep 重复监听 topicUrls.length 次（在这里也就是 40 次） `topic_html` 事件再行动
        ep.after('topic_html', topicUrls.length, function (topics) {
            // topics 是个数组，包含了 40 次 ep.emit('topic_html', pair) 中的那 40 个 pair
            // 开始行动
            topics = topics.map(function (topicPair) {
                // 接下来都是 jquery 的用法了
                var topicUrl = topicPair[0];
                var topicHtml = topicPair[1];
                var $ = cheerio.load(topicHtml);
                var user_href = $('.dark.reply_author').eq(0).attr('href');
                loadUser(user_href, $, topicUrl)
                return ({
                    title: $('.topic_full_title').text().trim(),
                    href: topicUrl,
                    comment1: $('.reply_content').eq(0).text().trim(),
                });
            });

            // console.log('final:');
            // console.log(topics);
            res.send(items);
        });

        function loadUser(user_href, $, topicUrl) {
            if(!user_href) {
                return;
            }
            var user_full_href = url.resolve(cnodeUrl, user_href);
            superagent.get(user_full_href)
            .end(function (err, sres) {
                var $$ = cheerio.load(sres.text);
                items.push({
                    title: $('.topic_full_title').text().trim(),
                    href: topicUrl,
                    comment1: $('.reply_content').eq(0).text().trim(),
                    author1: $('.dark.reply_author').eq(0).text().trim(),
                    user_href: user_full_href,
                    score1: $$('.user_profile .big').text().trim()
                });
                console.log({
                    title: $('.topic_full_title').text().trim(),
                    href: topicUrl,
                    comment1: $('.reply_content').eq(0).text().trim(),
                    author1: $('.dark.reply_author').eq(0).text().trim(),
                    user_href: user_full_href,
                    score1: $$('.user_profile .big').text().trim()
                });
            });
        }

        topicUrls.forEach(function (topicUrl) {
            superagent.get(topicUrl)
                .end(function (err, sres) {
                    console.log('fetch ' + topicUrl + ' successful');
                    ep.emit('topic_html', [topicUrl, sres.text]);
                });
        });
    });
});

app.listen(3000, function (req, res) {
  console.log('app is running at port 3000');
});