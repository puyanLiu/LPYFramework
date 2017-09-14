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
  View
} from 'react-native';

// 导入类库
var Dimensions = require('Dimensions');
var {width, height, scale} = Dimensions.get('window');

/*--------------------------------------------------------------------------------------*/
class FlexBoxDemo extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={{backgroundColor: 'yellow', height: 120}}>第一个</Text>
        <Text style={{backgroundColor: 'green', height: 120}}>第二个</Text>
        <Text style={{backgroundColor: 'pink', height: 120}}>第三个</Text>
        <Text style={{backgroundColor: 'blue', height: 120}}>第四个</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'red',
        width: 375,
        height: 200,
        flexDirection: 'row',
        justifyContent: 'flex-end',
        alignItems: 'flex-end',
    },
});

/*--------------------------------------------------------------------------------------*/
class FlexBoxDemo1 extends Component {
    render() {
        return (
            <View style={styles1.container}>
                <Text style={{backgroundColor: 'yellow', height: 120, width: 100}}>第一个</Text>
                <Text style={{backgroundColor: 'green', height: 120, width: 150}}>第二个</Text>
                <Text style={{backgroundColor: 'pink', height: 120, width: 200}}>第三个</Text>
                <Text style={{backgroundColor: 'blue', height: 120, width: 120}}>第四个</Text>
            </View>
        );
    }
}

const styles1 = StyleSheet.create({
    container: {
        backgroundColor: 'red',
        flex: 1,
        flexDirection: 'row',
        flexWrap: 'wrap'
    },
});

/*--------------------------------------------------------------------------------------*/
class FlexBoxDemo2 extends Component {
    render() {
        return (
            <View style={styles2.container}>
                <Text style={{backgroundColor: 'yellow', height: 120, flex: 1}}>第一个</Text>
                <Text style={{backgroundColor: 'green', height: 100, flex: 2, alignSelf: 'flex-end'}}>第二个</Text>
                <Text style={{backgroundColor: 'pink', height: 90, flex: 1}}>第三个</Text>
                <Text style={{backgroundColor: 'blue', height: 200, flex: 1, alignSelf: 'flex-start'}}>第四个</Text>
            </View>
        );
    }
}

const styles2 = StyleSheet.create({
    container: {
        backgroundColor: 'red',
        flex: 1,
        flexDirection: 'row',
        flexWrap: 'wrap',
        alignItems: 'center'
    },
});

/*--------------------------------------------------------------------------------------*/
class FlexBoxDemo3 extends Component {
    render() {
        return (
            <View style={styles3.container}>
                <Text>当前屏幕的宽度: {Dimensions.get('window').width}</Text>
                <Text>当前屏幕的高度: {Dimensions.get('window').height}</Text>
                <Text>当前屏幕的分辨率: {Dimensions.get('window').scale}</Text>

                <Text>
                    当前的屏幕的宽度: {width + '\n'}
                    当前的屏幕的高度: {height + '\n'}
                    当前的屏幕的分辨率: {scale + '\n'}
                </Text>
            </View>
        );
    }
}

const styles3 = StyleSheet.create({
    container: {
        backgroundColor: 'red',
        justifyContent: 'center',
        alignItems: 'center'
    },
});

/*--------------------------------------------------------------------------------------*/
class FlexBoxDemo4 extends Component {
    render() {
        return (
            <View style={styles4.container}>
                {/*绝对定位*/}
                <Text style={styles4.textStyle}>绝对定位:</Text>
                <View style={styles4.innerView}>
                    <View style={styles4.testViewStyle}></View>
                </View>
                {/*相对定位*/}
                <Text style={styles4.textStyle}>相对定位:</Text>
                <View style={styles4.innerView}>
                    <View style={styles4.testViewStyle1}></View>
                </View>
            </View>
        );
    }
}

const styles4 = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'red',
    },
    textStyle: {
        color: 'white',
        marginTop: 25,
    },
    innerView: {
        width: 375,
        height: 200,
        backgroundColor: 'green'
    },
    testViewStyle: {
        width: 60,
        height: 60,
        backgroundColor: 'yellow',
        borderRadius: 30,
        position: 'absolute',
        right: 0,
        bottom: 0,
    },
    testViewStyle1: {
        width: 60,
        height: 60,
        backgroundColor: 'yellow',
        borderRadius: 30,
        left: 20
    }
});


AppRegistry.registerComponent('FlexBoxDemo', () => FlexBoxDemo3);
