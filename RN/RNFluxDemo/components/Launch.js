/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View
} from 'react-native';
import {
  Actions
} from 'react-native-router-flux';
import Button from "react-native-button";

class Launch extends Component {
  render() {
    return (
      <View {...this.props} style={styles.container}>
        <Text>Launch page</Text>
        <Button onPress={() => Actions.login({data: '我是传递过来的数据', title: '我是传递过来的标题'})}>Go to Login page</Button>
        <Button onPress={() => Actions.register()}>Go to Register page</Button>
        <Button onPress={() => Actions.register2()}>Go to Register page without animation</Button>
        <Button onPress={() => Actions.register3()}>Go to Register page Animation vertical</Button>
        <Button onPress={() => Actions.register4()}>Go to Register page Animation leftToRight</Button>
        <Button onPress={() => Actions.error("出现错误啦！！！")}>Popup error</Button>
        <Button onPress={() => Actions.tabbar()}>Go to TabBar page</Button>
        <Button onPress={Actions.switcher}>Go to switcher page</Button>
        <Button onPress={Actions.pop}>back</Button>
        <Button></Button>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'orange',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

export default Launch;
