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
      rotation: new Animated.Value(0),
      fontSize: new Animated.Value(0),
    };
  }

  componentDidMount() {
    var timing = Animated.timing;
    Animated.parallel(['fadeInOpacity', 'rotation', 'fontSize'].map(property => {
      return timing(this.state[property], {
        toValue: 1,
        duration: 1000,
        easing: Easing.linear,
      });
    })).start();
  }

  render() {
    return (
      <Animated.View style={[styles.container, {
          opacity: this.state.fadeInOpacity,
          transform: [{
            rotateZ: this.state.rotation.interpolate({
              inputRange: [0, 1],
              outputRange: ['0deg', '360deg']
            })
          }]
        }]}>
        <Animated.Text style={{
            fontSize: this.state.fontSize.interpolate({
              inputRange: [0, 1],
              outputRange: [12, 26],
            })
          }}>
           悄悄的，我出现了
        </Animated.Text>
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
