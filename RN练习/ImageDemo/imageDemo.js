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

class ImageDemo extends Component {
    render() {
        return (
            <View style={styles.container}>
                {/*加载项目中的图片*/}
                <Image source={require('./img/img_01.jpg')} style={styles.imgStyle} />

                {/*加载App中的图片*/}
                <Image source={require('image!icon')} style={{height: 50}}></Image>

                {/*加载网络上的图片*/}
                <Image source={{uri: 'http://cdn.duitang.com/uploads/item/201201/14/20120114152254_nZLUL.thumb.600_0.jpg'}} style={{width: 170, height: 150, resizeMode: 'stretch', backgroundColor: 'red'}}></Image>

                {/*加载APP中的图片*/}
                <Image source={{uri: 'icon'}} style={{width: 165, height: 165, backgroundColor: 'red', resizeMode: 'contain'}}></Image>

                {/*设置背景*/}
                <Image source={require('./img/img_01.jpg')}>
                    <Text style={{backgroundColor: 'transparent', marginTop: 30}}>我是一段文字</Text>
                </Image>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#F5FCFF',
    },
    imgStyle: {
        width: 250,
        height: 120
    }
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
