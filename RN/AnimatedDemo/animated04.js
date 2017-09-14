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
      rotation: new Animated.Value(0),
    };
  }

  /*
 spring  //弹跳
 linear  //线性
 easeInEaseOut  //缓入缓出
 easeIn  //缓入
 easeOut  //缓出
 keyboard  //键入
   */
  startAnimation() {
    this.state.rotation.setValue(0),
    Animated.timing(this.state.rotation, {
      toValue: 1,
      duration: 2000,
      easing: Easing.spring
    }).start(() => this.startAnimation());
  }

  componentDidMount() {
    this.startAnimation();
  }

  render() {
    return (
      <Animated.View style={[styles.container, {
          transform: [{
            rotateZ: this.state.rotation.interpolate({
              inputRange: [0, 1],
              outputRange: ['0deg', '360deg']
            })
          }]
        }]}>
        <Animated.Text>
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
