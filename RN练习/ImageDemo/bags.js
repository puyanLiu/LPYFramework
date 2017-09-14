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
                {this.renderItems()}
            </View>
        );
    }

    renderItems() {
        var itemArr = [];
        for(var i = 0; i < data.length; i++) {
            var item= data[i];
            itemArr.push(
                <View style={styles.viewStyle} key={i}>
                    <Image source={{uri: item.icon}} style={styles.imageStyle}></Image>
                    <Text>{item.title}</Text>
                </View>
            )
        }
        return itemArr;
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        flexDirection: 'row',
        flexWrap: 'wrap',
        backgroundColor: 'green',
    },
    viewStyle: {
        width: itemW,
        height: itemH,
        flexDirection: 'column',
        marginTop: hMargin,
        marginLeft: vMargin,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#ccc',
    },
    imageStyle: {
        width: itemW - 20,
        height: itemW - 20,
    }
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
