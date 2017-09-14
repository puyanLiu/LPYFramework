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
    TouchableHighlight,
    ScrollView,
    ListView,
} from 'react-native';

var Dimensions = require('Dimensions');
var screenWidth = Dimensions.get('window').width;

// 引入外部数据
var shareData = require('./LocalData/shareData.json');

var cols = 3;
var itemWH = 80;
var hMargin = 25;
var vMargin = (screenWidth - cols * itemWH) / (cols + 1);

class ImageDemo extends Component {

    constructor(props) {
        super(props);

        var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
        this.state = {
            dataSource: ds.cloneWithRows(shareData.data),
        };
    }

    render() {
        return (
            <ListView
                dataSource = {this.state.dataSource}
                renderRow = {this.renderRow}
                contentContainerStyle = {styles.contentViewStyle}
            ></ListView>
        );
    }

    renderRow(rowData, rowID) {
        return (
            <TouchableOpacity style={styles.touchViewStyle}
                              onPress={() => {
                                  alert('点击');
                              }}
            >
                <View style={styles.cellViewStyle}>
                    <Image source={{uri: rowData.icon}} style={styles.imgStyle}></Image>
                    <Text style={styles.textStyle}>{rowData.title}</Text>
                </View>
            </TouchableOpacity>

        );
    }
}
const styles = StyleSheet.create({
    contentViewStyle: {
        flexDirection: 'row',
        flexWrap: 'wrap',
    },
    touchViewStyle: {
        width: itemWH,
        height: itemWH + 30,
        marginLeft: vMargin,
        marginTop: hMargin,
        justifyContent: 'center',
    },
    cellViewStyle: {
        alignItems: 'center',
    },
    imgStyle: {
        width: itemWH,
        height: itemWH,
    },
    textStyle: {
        marginTop: 10,
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
