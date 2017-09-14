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

class Register extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Register page
        </Text>
        <Button onPress={Actions.home}>进入主页</Button>
        <Button onPress={Actions.pop}>back</Button>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

export default Register;
