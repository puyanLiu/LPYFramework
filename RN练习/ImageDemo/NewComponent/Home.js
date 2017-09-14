import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
    View,
    ListView,
    TouchableOpacity,
    Image,
    RefreshControl,
} from 'react-native';

var Dimensions = require('Dimensions');
var screenWidth = Dimensions.get('window').width;

var NewsDetail = require('./NewsDetail');
var Swiper = require('./Swiper');
var newsList = require('../LocalData/newsList')

class Home extends Component {

    constructor(props) {
        super(props);

        this.state = {
            dataSource: new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2}),
            imageDataArr: [],
            // 是否加载数据
            isLoad: false,
            isRefreshing: false,
        };
    }

    componentDidMount() {
        this.loadDataFromNet();
    }

    // 从网络加载数据
    loadDataFromNet() {
        fetch(this.props.api_url)
            .then((response) => response.json())
            .then(response => {
                console.log(response);
                // 取出数据
                var dataArr = response[this.props.keyWord];
                this.dealWithData(dataArr);
            })
            .catch((error) => {
                // 取出本地缓存数据
                var dataArr = newsList[this.props.keyWord];
                this.dealWithData(dataArr);
            })
    }

    dealWithData(dataArr) {
        var listArr = [],
            topImageArr = [];

        for(var i = 0; i < dataArr.length; i++) {
            var item = dataArr[i];

            // 判断是否顶部广告
            if (item.hasAD == 1) {
                topImageArr = item.ads;
            } else {
                listArr.push(item);
            }
        }
        console.log(topImageArr);
        // 更新状态机
        this.setState({
            dataSource: this.state.dataSource.cloneWithRows(listArr),
            imageDataArr: topImageArr,
            isLoad: true,
            isRefreshing: false,
        });
    }

    render() {
        return (
            <ListView
                dataSource = {this.state.dataSource}
                renderRow = {this.renderRow.bind(this)}
                renderHeader = {this.renderHeader.bind(this)}
                refreshControl = {this.getRefreshControl()}
            >

            </ListView>
        );
    }

    getRefreshControl() {
        console.log('getRefreshControl', this);
        return (
            <RefreshControl
                onRefresh={this.onRefresh.bind(this)}
                 refreshing={this.state.isRefreshing}
            />
        );
    }

    onRefresh() {
        console.log('onRefresh', this);
        this.setState({
            isRefreshing: true,
        })

        this.loadDataFromNet();
    }

    renderRow(rowData) {
        return (
            <TouchableOpacity
                onPress={() => this.pushToNewsDetail(rowData.docid)}
            >
                <View style={styles.cellViewStyle}>
                    <Image source={{uri: rowData.imgsrc}} style={styles.imageStyle}></Image>
                    <View style={styles.rightViewStyle}>
                        <Text style={styles.mainTitleStyle} numberOfLines={1}>{rowData.title}</Text>
                        <Text style={styles.subTitleStyle} numberOfLines={2}>{rowData.digest}</Text>
                    </View>
                    <Text style={styles.replayStyle}>跟帖数: {rowData.replyCount}</Text>
                </View>
            </TouchableOpacity>
        );
    }

    // 跳转到新闻详情页
    pushToNewsDetail(docid) {
        console.log(this.props);
        this.props.navigator.push({
            title: '详情页',
            component: NewsDetail,
            passProps: {docid},
            backButtonTitle: '返回',
        });
    }

    renderHeader() {
        if(this.state.imageDataArr.length == 0) {
            return;
        }
        return (
            // <View></View>
            <Swiper imageDataArr={this.state.imageDataArr}/>
        );
    }
}

Home.defaultProps = {
    api_url: 'http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&fn=2&prog=LTitleA&passport=&devId=nTM86EPlcxZu09VdpTEh6aR3%2B%2FQX6x8vHBD3ne3k5bbgOrg%2FIP5DcguSDmtYyWbs&size=20&version=10.0&spever=false&net=wifi&lat=OE2o91%2BdCgD9VXeccYsfcA%3D%3D&lon=8Whxhxqf2kLzoYzuxQSj8g%3D%3D&ts=1466144911&sign=LLf1WR95qTMaen6vExFhEqcEtZMdgJGKbkCjBPvnsUt48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore',
    keyWord: 'T1348647853363',
};

var styles = StyleSheet.create({
    cellViewStyle: {
        borderBottomWidth: 0.5,
        borderBottomColor: '#ccc',
        flexDirection: 'row'
    },
    imageStyle: {
        width: 80,
        height: 80,
        margin: 10,
    },
    rightViewStyle: {
        width: screenWidth - 80 - 20,
        padding: 10,
    },
    mainTitleStyle: {
        marginBottom: 10,
        fontSize: 14,
        color: 'orange',
    },
    subTitleStyle: {
        fontSize: 12,
        color: 'gray',
    },
    replayStyle: {
        position: 'absolute',
        right: 10,
        bottom: 10,
        fontSize: 12,
        color: 'red',
    }
});

module.exports = Home;