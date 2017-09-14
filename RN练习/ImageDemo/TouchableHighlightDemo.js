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
} from 'react-native';

var Dimensions = require('Dimensions');
var screenWidth = Dimensions.get('window').width;

class ImageDemo extends Component {
    render() {
        return (
            <View style={styles.container}>
                <TouchableHighlight
                    activeOpacity={0.5}
                    // underlayColor='blue'
                    onPress={() => {
                        {/*alert('点击了');*/}
                    }}
                >

                    <View style={{width: 100, height: 80, justifyContent: 'center', alignItems: 'center', backgroundColor: 'red'}}>
                        <Text>
                            点击一下
                        </Text>
                    </View>

                </TouchableHighlight>
            </View>
        );
    }
}
const styles = StyleSheet.create({
    container: {
        flex: 1,
        paddingTop: 40,
        backgroundColor: '#ccc',
    }
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);
