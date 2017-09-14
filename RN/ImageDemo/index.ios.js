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

var Main = require('./NewComponent/Main');

class ImageDemo extends Component {

    render() {
        return (
            <Main></Main>
        );
    }
}

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
