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
    TextInput,
} from 'react-native';

// 导入外部的js文件
var QQLogin = require('./QQLogin');

class ImageDemo extends Component {
    render() {
        return (
            // 生成组件
            <QQLogin/>
        );
    }

}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
