
import React, {Component} from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    Image,
    TextInput,
    TouchableOpacity,
    View,
} from 'react-native';

var Dimensions = require('Dimensions');
var {width} = Dimensions.get('window');

class QQLogin extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Image source={require('./img/icon.png')} style={styles.iconStyle}></Image>

                <View style={styles.userViewStyle}>
                    <TextInput style={styles.inputStyle}
                        placeholder='请输入用户名'
                        clearButtonMode='always'
                    ></TextInput>
                    <TextInput style={styles.inputStyle}
                        placeholder='请输入密码'
                        clearButtonMode='always'
                        password={true}
                    ></TextInput>
                </View>

                <View style={styles.loginViewStyle}>
                    <Text style={styles.loginTextStyle} onPress={()=>{
                        alert('点击了');
                    }}>登 录</Text>
                </View>

                <View style={styles.settingStyle}>
                    <Text>无法登录?</Text>
                    <Text>新用户</Text>
                </View>

                <View style={styles.bottomViewStyle}>
                    <Text>其他登录方式</Text>
                    <TouchableOpacity
                        activeOpacity={0.5}
                        onPress={()=> {
                            console.log('点击');
                        }}
                        onPressIn={() => {
                            console.log('按下');
                        }}
                        onPressOut={() => {
                            console.log("抬起");
                        }}
                        onLongPress={() => {
                            console.log("长按");
                        }}
                    >
                        <Image source={require('./img/icon3.png')} style={styles.bottomImgStyle}></Image>
                    </TouchableOpacity>
                    <Image source={require('./img/icon7.png')} style={styles.bottomImgStyle}></Image>
                    <Image source={require('./img/icon8.png')} style={styles.bottomImgStyle}></Image>
                </View>
            </View>
        );
    }
}

var styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#ddd',
        alignItems: 'center',
    },
    iconStyle: {
        width: 80,
        height:80,
        marginTop: 60,
        borderRadius: 40,
        borderWidth: 3,
        borderColor: 'rgba(255, 255, 255, 0.7)',
    },
    userViewStyle: {
        marginTop: 40,
    },
    inputStyle: {
        width: width,
        height: 38,
        backgroundColor: 'white',
        marginBottom: 1,
        textAlign: 'center',
        fontSize: 16,
    },
    loginViewStyle: {
        width: width * 0.9,
        height: 40,
        backgroundColor: 'orange',
        marginTop: 20,
        alignItems: 'center',
        justifyContent: 'center',
        borderRadius: 5,
    },
    loginTextStyle: {
        color: 'white',
        fontSize: 18,
    },
    settingStyle: {
        width: width * 0.9,
        marginTop: 10,
        flexDirection: 'row',
        justifyContent: 'space-between'
    },
    bottomViewStyle: {
        position: 'absolute',
        left: 10,
        bottom: 10,
        flexDirection: 'row',
        alignItems: 'center',
    },
    bottomImgStyle: {
        marginLeft: 10,
        width: 40,
        height: 40,
        borderRadius: 20,
    },
});

// 生成模块组件并输出
module.exports = QQLogin;