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
    ScrollView,
} from 'react-native';


class ImageDemo extends Component {

    render() {
        return (
            <View style={styles.container}>
                <ScrollView
                    horizontal={false}
                    // pagingEnabled={true}
                    scrollEnabled={true}
                    // showsVerticalScrollIndicator={false}
                    scrollsToTop={true}
                >
                    { this.renderItems() }
                </ScrollView>
            </View>
        );
    }

    renderItems() {
        var itemArr = [];
        var colorArr = ['red', 'green', 'blue', 'yellow', 'purple', 'pink', 'orange'];
        for(var i = 0; i < colorArr.length; i++) {
            itemArr.push(
                <View key={i} style={[styles.viewStyle, {backgroundColor: colorArr[i]}]}>
                    <Text>{i}</Text>
                </View>
            );
        }
        return itemArr;
    }

}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    viewStyle: {
        width: 375,
        height: 120,
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
