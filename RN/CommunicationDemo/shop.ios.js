/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  NavigatorIOS,
  NativeModules,
} from 'react-native';

import {
    Scene,
    Reducer,
    Router,
    Switch,
    TabBar,
    Modal,
    Schema,
    Actions
    } from 'react-native-router-flux';
import {
    Provider,
    connect
    } from 'react-redux';

const RNBridgeModule = NativeModules.RNBridgeModule;

var Home = require('./component/Find');

const RouterWithRedux = connect()(Router);
class ShopDemo extends Component {

  render() {
    return (
      <NavigatorIOS
          tintColor='rgba(255, 130, 1, 1.0)'
          style={styles.navStyle}
          initialRoute={{
              component: Home,
              title: 'RN首页',
              leftButtonTitle: '返回原生',
              onLeftButtonPress: () => {
                console.log('哈哈返回');
                RNBridgeModule.RNBackOC({
                  other: 'hello',
                });
              }
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

AppRegistry.registerComponent('ShopDemo', () => ShopDemo);
