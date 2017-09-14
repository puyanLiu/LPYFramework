/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Image,
} from 'react-native';

var data = require('./LocalData/bags.json');
var Dimensions = require('Dimensions');
var {width, height, scale} = Dimensions.get('window');

// 定义全局变量
var cols = 3;
var itemW = 100;
var itemH = 130;
var vMargin = (width - cols * itemW) / (cols + 1);
var hMargin = 25;


class ImageDemo extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text style={styles.textStyle} numberOfLines={6}
                      onPress={()=> {
                          alert("点击了");
                      }}>
                    哈哈哈我是文字
                    哈哈哈我是文字
                    哈哈哈我是文字
                    哈哈哈我是文字
                    哈哈哈我是文字
                    哈哈哈我是文字
                    啦啦啦
                    啦啦啦
                    啦啦啦
                    啦啦啦
                    啦啦啦
                    啦啦啦
                    啦啦啦
                    啦啦啦
                    摇一摇
                    摇一摇
                    摇一摇
                    摇一摇
                </Text>
            </View>
        );
    }

}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        flexDirection: 'row',
        flexWrap: 'wrap',
        backgroundColor: '#ccc',
    },
    textStyle: {
        color: 'green',
        backgroundColor: '#ddd',
        textAlign: 'right',
        width: 200,
        fontSize: 20,
        fontWeight: 'bold',
        // 字符间距
        letterSpacing: 5,
        // 横线位置
        textDecorationLine: 'underline',
        textDecorationStyle: 'double',
        textDecorationColor: 'black',
        // 文本方向
        writingDirection: 'ltr',
        fontFamily: 'Cochin',
        lineHeight: 50,
        fontStyle: 'italic',
        textShadowOffset: {width: 10, height: 10},
        textShadowColor: 'yellow',
        textShadowRadius: 1,
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
