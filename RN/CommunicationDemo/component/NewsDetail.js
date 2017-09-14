import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
    View,
    WebView,
} from 'react-native';

var Dimensions = require('Dimensions');
var {width} = Dimensions.get('window');

class NewsDetail extends Component {
    
    constructor(props) {
        super(props);

        this.state = {
            newsDetail: '正在加载中。。。',
        };
    }

    componentDidMount() {
        var url_api = 'http://c.m.163.com/nc/article/' + this.props.docid + '/full.html';
        console.log(url_api);
        this.getNewsDetails(url_api);
    }

    getNewsDetails(url_api) {
        fetch(url_api)
            .then((response) => response.json())
            .then(response => {
                var newsDetailData = response[this.props.docid];
                console.log(newsDetailData.body);
                if (!newsDetailData) {
                    return;
                }
                // 新闻主要内容
                var bodyData = newsDetailData.body;
                // 图片数组
                var imageData = newsDetailData.img;
                // 标题
                var newsTitle = newsDetailData.title;
                var titleHtml = '<div style="margin: 10px 5px; font-size: 18px; font-weight: bold">' + newsTitle + '</div>';
                // 发布时间和俩来源
                var source = newsDetailData.source;
                var ptime = newsDetailData.ptime;
                var subTitleHtml = '<div style="color: darkgrey; font-size: 12px; margin-left: 5px;">'
                + '<span style="margin-right: 5px; margin-top: 10px;">' + ptime + '</span>'
                + '<span>' + source + '</span></div>';

                // 变量图片数组替换body中得占位标签
                for(var i = 0; i < imageData.length; i++) {
                    // 占位标签
                    var imgRef = imageData[i].ref;
                    // 图片路径
                    var imgSrc = imageData[i].src;
                    var imgW = width - 30;
                    console.log(imgW);
                    var imgHtml = '<div style="margin-left: 10px; width: ' + imgW + 'px"><img src="' + imgSrc + '" height="auto" style="width: 100%" /></div>';
                    // 图片占位标签替换
                    bodyData = bodyData.replace(imgRef, imgHtml);
                }

                bodyData = titleHtml + subTitleHtml + bodyData;
                console.log(bodyData);

                // 更新状态机
                this.setState({
                    newsDetail: bodyData,
                });
            })
    }

    render() {
        var url_api = 'http://c.m.163.com/nc/article/' + this.props.docid + '/full.html';
        return (
            <View style={styles.container}>
                <WebView
                    automaticallyAdjustContentInsets={true}
                    startInLoadingState={true}
                    // source={{uri: url_api}}
                    source={{html: this.state.newsDetail, baseUrl: ''}}
                ></WebView>
            </View>
        );
    }
}

var styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white'
    }
});

module.exports = NewsDetail;