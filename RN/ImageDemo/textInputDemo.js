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
                <TextInput
                    // value="我是默认值"
                    style={styles.textInputStyle}
                    keyboardType='number-pad'
                    placeholder='占位文字'
                    placeholderTextColor='blue'
                    clearButtonMode='always'
                    // multiline={true}
                    // secureTextEntry={true}
                    password={true}
                    onChange={(event)=> {
                        alert(event.value);
                    }}
                >

                </TextInput>
            </View>
        );
    }

}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    textInputStyle: {
        width: 350,
        height: 38,
        marginTop: 60,
        borderWidth: 1,
        borderColor: 'orange',
        borderRadius: 6,
        paddingLeft: 20,
        color: 'red',
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
