
import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
    View,
    Image,
} from 'react-native';

var SwiperScroll = require('react-native-swiper');
var Dimensions = require('Dimensions');
var screenWidth = Dimensions.get('window').width;

class Swiper extends Component {
    render() {
        return (
            <SwiperScroll
                height = {160}
                dot={<View style={styles.dotStyle}></View>}
                activeDot={<View style={styles.activeStyle}></View>}
                paginationStyle={styles.paginationStyle}
                loop={true}
            >
                { this.renderItem() }
            </SwiperScroll>
        )
    }

    renderItem() {
        var imgArr = this.props.imageDataArr;
        var itemArr = [];
        for(var i = 0; i < imgArr.length; i++) {
            var item = imgArr[i];
            itemArr.push(
                <View key={i} style={styles.outViewStyle}>
                    <Image source={{uri: item.imgsrc}} style={styles.imageStyle}></Image>
                    <View style={styles.titleViewStyle}>
                        <Text style={styles.titleStyle}>{item.title}</Text>
                    </View>
                </View>
            );
        }
        console.log('scrollImage' ,imgArr);
        return itemArr;
    }
}

var styles = StyleSheet.create({
    outViewStyle: {
        flex: 1,
    },
    imageStyle: {
        flex: 1,
    },
    titleViewStyle: {
        backgroundColor: 'rgba(0, 0, 0, 0.4)',
        height: 25,
        position: 'absolute',
        left: 0,
        bottom: 0,
        width: screenWidth,
        justifyContent: 'center',
    },
    titleStyle: {
        color: 'white'
    },
    dotStyle: {
        backgroundColor: 'rgba(255, 255, 255, .9)',
        width: 5,
        height: 5,
        borderRadius: 4,
        marginLeft: 3,
        marginRight: 3,
        marginTop: 3,
        marginBottom: 3,
    },
    activeStyle: {
        backgroundColor: 'orange',
        width: 8,
        height: 8,
        borderRadius: 4,
        marginLeft: 3,
        marginRight: 3,
        marginTop: 3,
        marginBottom: 3,
    },
    paginationStyle: {
        right: 10,
        bottom: 5,
        left: null,
    },
})

module.exports = Swiper;