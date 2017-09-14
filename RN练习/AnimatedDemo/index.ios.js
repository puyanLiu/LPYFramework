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
      bounceValue: new Animated.Value(0),
    };
  }

  componentDidMount() {
    this.state.bounceValue.setValue(1.5);
    Animated.spring(
      this.state.bounceValue, {
        toValue: 0.8,
        friction: 1,
      }
    ).start();
  }

  render() {
    return (
      <Animated.Image
        source={{uri: 'http://i.imgur.com/XMKOH81.jpg'}}
        style={{flex: 1,
        transform: [{
          scale: this.state.bounceValue
        },]}}>
      </Animated.Image>
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
