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
  Easing,
  Animated,
} from 'react-native';

class AnimatedDemo extends Component {
  constructor(props) {
    super(props);
    this.state = {
      fadeInOpacity: new Animated.Value(0), // 初始值
    };
  }

  componentDidMount() {
    Animated.timing(this.state.fadeInOpacity, {
      toValue: 1,
      duration: 2500,
      easing: Easing.linear,
    }).start();
  }

  render() {
    return (
      <Animated.View style={[styles.container, {
          opacity: this.state.fadeInOpacity
        }]}>
        <Text style={styles.text}>
           悄悄的，我出现了
        </Text>
      </Animated.View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'yellow',
  },
  text: {
    fontSize: 30
  },
});

AppRegistry.registerComponent('AnimatedDemo', () => AnimatedDemo);
