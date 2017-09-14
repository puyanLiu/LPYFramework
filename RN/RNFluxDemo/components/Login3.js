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

class Login3 extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Login3 page： {this.props.data}
        </Text>
        <Button onPress={Actions.pop}>back</Button>
        <Button onPress={() => Actions.popTo('loginModal2')}>to Login2</Button>
        <Button onPress={() => Actions.popTo('loginModal')}>to Login</Button>
        <Button onPress={() => Actions.popTo('root')}>to Root</Button>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'blue',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

export default Login3;
