/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, {
    Component
} from 'react';
import {
    AppRegistry,
    Navigator,
} from 'react-native';

var Main = require('./Component/Main/Main');
var LaunchPage = require('./Component/Main/LaunchPage');

class ShopProjectDemo extends Component {
    render() {
        return (
          <Navigator
            initialRoute={{name: '主要界面', component: LaunchPage}}
            configureScene={(route) => {
              return Navigator.SceneConfigs.PushFromRight;
            }}
            renderScene={(route, navigator) => {
              let Component = route.component;
              return <Component {...route.passProps} navigator={navigator} />
            }}
             />
        );
    }
}

AppRegistry.registerComponent('ShopProjectDemo', () => ShopProjectDemo);
