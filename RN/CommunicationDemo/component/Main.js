import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
    View,
    TabBarIOS,
    NavigatorIOS,
} from 'react-native';

// 引入外部文件
var Home = require('./Home');
var Find = require('./Find');
var Message = require('./Message');
var Mine = require('./Mine');

class Main extends Component {

    constructor(props) {
        super(props);

        this.state = {
            selectTabItem: 'Home',
        };
    }

    render() {
        return (
            <TabBarIOS
                tintColor='rgba(255, 130, 1, 1.0)'
            >
                {this.renderTabBarItem(require('image!tabbar_home'), '首页', 'Home', this.renderHomeNav)}
                {this.renderTabBarItem(require('image!tabbar_discover'), '发现', 'Find', this.renderFindNav)}
                {this.renderTabBarItem(require('image!tabbar_message_center'), '消息', 'Message', this.renderMessageNav)}
                {this.renderTabBarItem(require('image!tabbar_profile'), '我的', 'Mine', this.renderMineNav)}
            </TabBarIOS>
        );
    }

    renderTabBarItem(icon, title, selectedName, navigator) {
        return (
            <TabBarIOS.Item
                icon={icon}
                title={title}
                selected={this.state.selectTabItem == selectedName}
                onPress={() => {
                    this.setState({
                        selectTabItem: selectedName
                    });
                }}
            >
                { navigator && typeof navigator == 'function' && navigator() }
            </TabBarIOS.Item>
        );
    }

    renderHomeNav() {
        return (
            <NavigatorIOS
                tintColor='rgba(255, 130, 1, 1.0)'
                style={styles.navStyle}
                initialRoute={{
                    component: Home,
                    title: '首页',
                    leftButtonIcon: require('image!navigationbar_friendattention'),
                    rightButtonIcon: require('image!navigationbar_pop'),
                    backButtonTitle: '返回',
                }}
            ></NavigatorIOS>
        );
    }

    renderFindNav() {
        return (
            <NavigatorIOS
                tintColor='rgba(255, 130, 1, 1.0)'
                style={styles.navStyle}
                initialRoute={{
                    component: Find,
                    title: '发现',
                }}
            ></NavigatorIOS>
        );
    }

    renderMessageNav() {
        return (
            <NavigatorIOS
                tintColor='rgba(255, 130, 1, 1.0)'
                style={styles.navStyle}
                initialRoute={{
                    component: Message,
                    title: '消息',
                }}
            ></NavigatorIOS>
        );
    }

    renderMineNav() {
        return (
            <NavigatorIOS
                tintColor='rgba(255, 130, 1, 1.0)'
                style={styles.navStyle}
                initialRoute={{
                    component: Mine,
                    title: '我的',
                }}
            ></NavigatorIOS>
        );
    }
}

var styles = StyleSheet.create({
    navStyle: {
        flex: 1,
    },
});

// 输出模块
module.exports = Main;