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
    TouchableOpacity,
} from 'react-native';


class ImageDemo extends Component {

    render() {
        return (
            <View style={styles.container}>

            </View>
        );
    }

}

const styles = StyleSheet.create({
    container: {
        justifyContent: 'center',
        alignItems: 'center',
        width: 300,
        height: 200,
        backgroundColor: 'red',
        marginTop: 60,
        marginLeft: 30,
        borderBottomWidth: 5,
        borderBottomColor: 'yellow',
        borderBottomLeftRadius: 30,
        borderLeftWidth: 10,
        borderLeftColor: 'green',
        borderTopLeftRadius: 20,
        borderTopWidth: 10,
        borderTopColor: 'blue',
        borderRightWidth: 20,
        borderRightColor: 'pink',
        borderTopRightRadius: 50,
        borderBottomRightRadius: 30,
        // 透明度
        // opacity: 0.5,
        // 高度,设置Z轴,可产生立体效果
        elevation: 70,
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
