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
    TabBarIOS,

} from 'react-native';

var Dimensions = require('Dimensions');
var screenWidth = Dimensions.get('window').width;


class ImageDemo extends Component {

    constructor(props) {
        super(props);

        this.state = {
            selectedTabIndex: 0,
        };
    }

    render() {
        return (
            <View style={styles.container}>
                <View style={styles.topViewStyle}>
                    <Text style={styles.topTextStyle}>Tab的切换</Text>
                </View>
                <TabBarIOS
                    tintColor="orange"
                    // barTintColor="black"
                    translucent={true}
                >
                    <TabBarIOS.Item
                        systemIcon="bookmarks"
                        selected = {this.state.selectedTabIndex == 0}
                        onPress = {() => {
                            this.setState({
                                selectedTabIndex: 0,
                            });
                        }}
                    >
                        <View style={[styles.childViewStyle, {backgroundColor: 'red'}]}><Text>首页</Text></View>
                    </TabBarIOS.Item>
                    <TabBarIOS.Item
                        systemIcon="downloads"
                        selected = {this.state.selectedTabIndex == 1}
                        onPress = {() => {
                            this.setState({
                                selectedTabIndex: 1,
                            });
                        }}
                    >
                        <View style={[styles.childViewStyle, {backgroundColor: 'green'}]}><Text>第二页</Text></View>
                    </TabBarIOS.Item>
                    <TabBarIOS.Item
                        systemIcon="history"
                        selected = {this.state.selectedTabIndex == 2}
                        onPress = {() => {
                            this.setState({
                                selectedTabIndex: 2,
                            });
                        }}
                    >
                        <View style={[styles.childViewStyle, {backgroundColor: 'yellow'}]}><Text>第三页</Text></View>
                    </TabBarIOS.Item>
                    <TabBarIOS.Item
                        systemIcon="search"
                        selected = {this.state.selectedTabIndex == 3}
                        onPress = {() => {
                            this.setState({
                                selectedTabIndex: 3,
                            });
                        }}
                    >
                        <View style={[styles.childViewStyle, {backgroundColor: 'blue'}]}><Text>第四页</Text></View>
                    </TabBarIOS.Item>
                </TabBarIOS>
            </View>
        );
    }
}
const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    topViewStyle: {
        height: 64,
        paddingTop: 20,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'pink',
    },
    topTextStyle: {
        fontSize: 20,
        fontWeight: 'bold',
    },
    childViewStyle: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
