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

class Login2 extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Login2 page： {this.props.data}
        </Text>
        <Button onPress={Actions.loginModal3}>Login3</Button>
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
    backgroundColor: 'yellow',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

export default Login2;
