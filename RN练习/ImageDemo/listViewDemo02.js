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

// 导入数据
var  wineData = require('./LocalData/wineData.json');

class ImageDemo extends Component {

    constructor(props) {
        super(props);

        var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
        this.state = {
            dataSource: ds.cloneWithRows(wineData),
        };
    }

    render() {
        return (
            <ListView
                dataSource = {this.state.dataSource}
                renderRow = {this.renderRow}
            ></ListView>
        );
    }

    renderRow(rowData, sectionID, rowID, highlightRow) {
        console.log(rowData);

        return (
            <TouchableOpacity
                onPress={() => {
                    alert('点击了第' + sectionID + '组, 第' + rowID + '行');
                }}
            >
                <View style={styles.cellViewStyle}>
                    <Image source={{uri: rowData.image}} style={styles.imgStyle}></Image>
                    <View style={styles.rightViewStyle}>
                        <Text style={styles.nameStyle}>
                            {rowData.name}
                        </Text>
                        <Text style={styles.moneyStyle}>
                            ￥{rowData.money}
                        </Text>
                    </View>
                </View>
            </TouchableOpacity>
        );
    }

}
const styles = StyleSheet.create({
    cellViewStyle: {
        flexDirection: 'row',
        borderBottomColor: '#ddd',
        borderBottomWidth: 0.5,
    },
    imgStyle: {
        width: 60,
        height: 60,
        margin: 10,
    },
    rightViewStyle: {
        justifyContent: 'center',
        width: screenWidth - 60 - 20,
    },
    nameStyle: {
        fontSize: 14,
        marginRight: 10,
        marginBottom: 10,
    },
    moneyStyle: {
        color: 'red'
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
