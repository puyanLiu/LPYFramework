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

class PageTwo extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          This is PageTwo!
        </Text>
        <Text style={styles.welcome}>
          {this.props.text}
        </Text>
        <Text style={styles.welcome} onPress={() => Actions.pop()}>
          点我返回哦
        </Text>
        <Text style={styles.welcome} onPress={() => Actions.refresh({text: '我被刷新啦'})}>
          点我会被刷新哦
        </Text>
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

export default PageTwo;
