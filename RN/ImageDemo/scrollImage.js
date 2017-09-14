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

// 导入本地数据
var imageData = require('./LocalData/imageData.json');
var Dimensions = require('Dimensions');
var screenWidth = Dimensions.get('window').width;

// 导入计时器类库    npm i react-timer-mixin --save
// 导入计时器
var TimerMixin = require('react-timer-mixin');

class ImageDemo extends Component {

    constructor(props) {
        super(props);
        this.state = {
            currentPage: 0,
        };
    }

    render() {
        return (
            <View style={styles.container}>
                <ScrollView ref="scrollView"
                            horizontal={true}
                            pagingEnabled={true}
                            bounces={false}
                            showsHorizontalScrollIndicator={false}
                            onMomentumScrollEnd={(e) => this.scroll(e)} // 当一帧滚动结束
                            onScrollBeginDrag={(e) => this.scrollBeginDrag(e)} // 开始拖拽
                            onScrollEndDrag={(e) => this.scrollEndDrag(e)} // 结束拖拽
                            onScroll={(e) => this.scroll(e)} // 滚动过程调用
                            scrollEventThrottle={5}
                >
                    { this.renderItems() }
                </ScrollView>

                <View style={styles.pageViewStyle}>
                    { this.renderPageCircle() }
                </View>
            </View>
        );
    }

    // 处理复杂的异步操作: 定时器 或 请求网络数据 或 大批量的数据处理
    componentDidMount() {
        // 开启定时器
        this.startTimer();
    }

    startTimer() {
        var scrollView = this.refs.scrollView;
        var that = this;
        this.timer = setInterval(function() {
            var activePage;
            var imgDataArr = imageData.data;
            if (that.state.currentPage + 1 > imgDataArr.length - 1) {
                activePage = 0;
            } else {
                activePage = that.state.currentPage + 1;
            }
            var offsetX = activePage * screenWidth;
            scrollView.scrollResponderScrollTo({x: offsetX, y: 0, animated: true});
            that.setState({
                currentPage: activePage,
            });
        }, this.props.durationTime);
    }

    scroll(e) {
        // 水平偏移量
        var offsetX = e.nativeEvent.contentOffset.x;
        // 当前页码
        var currentPage = offsetX / screenWidth + 0.5;
        // 更新状态机
        this.setState({
            currentPage: parseInt(currentPage)
        });
    }

    scrollBeginDrag(e) {
        clearInterval(this.timer);
    }

    scrollEndDrag(e) {
        this.startTimer();
    }

    renderItems() {
        var itemArr = [];
        var imgDataArr = imageData.data;
        for(var i = 0; i < imgDataArr.length; i++) {
            var item = imgDataArr[i];
            itemArr.push(
                <Image key={i} source={{uri: item.img}} style={styles.imgStyle}></Image>
            );
        }
        return itemArr;
    }

    renderPageCircle() {
        var itemArr = [], style;
        var imgDataArr = imageData.data;
        for(var i = 0; i < imgDataArr.length; i++) {
            var item = imgDataArr[i];
            style = this.state.currentPage == i ? {color: 'orange'} : {color: 'white'};
            itemArr.push(
                <Text key={i} style={[styles.pageCircle, style]}>&bull;</Text>
            );
        }
        return itemArr;
    }
}

ImageDemo.defaultProps = {
    durationTime: 1000,
};

const styles = StyleSheet.create({
    container: {
        // flex: 1,
        paddingTop: 40,
        backgroundColor: '#ccc',
    },
    imgStyle: {
        width: screenWidth,
        height: 140,
        backgroundColor: 'red',
        marginBottom: 5,
    },
    pageViewStyle: {
        flexDirection: 'row',
        justifyContent: 'center',
        position: 'absolute',
        bottom: 5,
        width: screenWidth,
    },
    pageCircle: {
        fontSize: 18,
        marginRight: 5,
        backgroundColor: 'transparent'
    },

});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
