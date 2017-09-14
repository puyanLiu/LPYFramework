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

class ImageDemo extends Component {
    constructor(props) {
        super(props);

        // 创建数据源
        // 当有任意两个不相等,才创建
        var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
        this.state = {
            dataSource: ds.cloneWithRows(['哈哈', '啦啦', '呜呜', '习习', '一一']),
        };
    }

    render() {
        return (
            <ListView
                dataSource = {this.state.dataSource}
                // this.renderRow 隐式函数 默认会把所有的参数往下传递
                renderRow = {this.renderRow} // 根据数据,创建一个具体的cell返回
            >

            </ListView>
        );
    }

    // 返回具体的一行
    renderRow(rowData, sectionID, rowID, highlightRow) {
        return (
            <View>
                <Text>内容 {rowData} 在第{sectionID}组 第{rowID}行</Text>
            </View>
        );
    }
}
const styles = StyleSheet.create({

});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
