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

// 导入外部数据
var carData = require('./LocalData/carData.json');

class ImageDemo extends Component {

    constructor(props) {
        super(props);

        // 获取组的数据
        var getSectionData = (data, sectionID) => {
            return data[sectionID];
        };
        // 获取行的数据
        var getRowData = (data, sectionID, rowID) => {
            return data[sectionID + ":" + rowID];
        };

        this.state = {
            dataSource: new ListView.DataSource({
                getSectionData: getSectionData,
                getRowData: getRowData,
                rowHasChanged: (r1, r2) => r1 !== r2,
                sectionHeaderHasChanged: (s1, s2) => s1 !== s2,
            }),
        };
    }

    // 处理复杂操作
    componentDidMount() {
        this.loadDataFromJSON();
    }

    loadDataFromJSON() {
        var data = carData.data;

        // 定义临时变量
        // sectionIDs 存放组号
        // tmpData 存放组内容
        // rowIDs 存放行号
        var tmpData = {},
            sectionIDs = [],
            rowIDs = [],
            cars = [];

        for(var i = 0; i < data.length; i++) {
            sectionIDs.push(i);
            tmpData[i] = data[i].title;
            cars = data[i].cars;
            rowIDs[i] = [];
            for(var j = 0; j < cars.length; j++) {
                rowIDs[i].push(j);
                // 把每一行的数据存放到tmpData
                tmpData[i + ":" + j] = cars[j];
            }
        }

        console.log(tmpData);
        console.log(sectionIDs);
        console.log(rowIDs);


        // 更新状态机
        this.setState({
            dataSource: this.state.dataSource.cloneWithRowsAndSections(tmpData, sectionIDs, rowIDs),
        });

    }

    render() {
        return (
            <View style={styles.outViewStyle}>
                <View style={styles.topViewStyle}>
                    <Text style={styles.topTextStyle}>汽车品牌展示</Text>
                </View>
                <ListView
                    dataSource = {this.state.dataSource}
                    renderRow = {this.renderRow}
                    renderSectionHeader = {this.renderSectionHeader}
                >

                </ListView>
            </View>
        );
    }

    renderSectionHeader(sectionData, sectionID) {
        console.log('sectionData',sectionID ,sectionData);
        return (
            <View style={styles.sectionHeaderStyle}>
                <Text style={styles.sectionTextStyle}>{sectionData}</Text>
            </View>
        );
    }

    renderRow(rowData, sectionID, rowID) {
        console.log(rowData);
        return (
            <TouchableOpacity onPress={() => {
                alert('点击了第' + sectionID + '组,第' + rowID + '行');
            }}>
                <View style={styles.cellStyle}>
                    <Image style={styles.imgStyle} source={{uri: rowData.icon}}></Image>
                    <Text>{rowData.name}</Text>
                </View>
            </TouchableOpacity>
        );
    }
}
const styles = StyleSheet.create({
    outViewStyle: {
        flex: 1,
    },
    topViewStyle: {
        height: 64,
        backgroundColor: 'pink',
        paddingTop: 20,
        justifyContent: 'center',
        alignItems: 'center',
    },
    topTextStyle: {
        color: 'white',
        fontSize: 20,
        fontWeight: 'bold',
    },
    sectionHeaderStyle: {
        backgroundColor: '#ccc',
        height: 25,
        justifyContent: 'center',
    },
    sectionTextStyle: {
        color: 'orange',
        fontSize: 16,
        fontWeight: 'bold',
        paddingLeft: 5,
    },
    cellStyle: {
        flexDirection: 'row',
        alignItems: 'center',
        borderBottomWidth: 0.5,
        borderBottomColor: '#ddd',
        padding: 5,
        paddingLeft: 10,
    },
    imgStyle: {
        width: 50,
        height: 50,
        marginRight: 10,
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
