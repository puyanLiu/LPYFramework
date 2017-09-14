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
      anim: [1, 2, 3].map(() => new Animated.Value(0))
    };
  }

  componentDidMount() {
    var timing = Animated.timing;
    Animated.sequence([
      Animated.stagger(200, this.state.anim.map(left => {
        return timing(left, {
          toValue: 1,
        });
      }).concat(
        this.state.anim.map(left => {
          return timing(left, {
            toValue: 0,
          })
        })
      ), // 三个View滚动到右边再还原，每个动作间隔200ms
    ),

    Animated.delay(400), // 延迟400ms,配合sequence使用
    timing(this.state.anim[0], {
      toValue: 1,
    }),
    timing(this.state.anim[1], {
      toValue: -1,
    }),
    timing(this.state.anim[2], {
      toValue: 0.5,
    }),
    Animated.delay(400),
    Animated.parallel(this.state.anim.map((anim) => timing(anim, {
      toValue: 0
    }))) // 同时回到原位置
    ]).start();
  }

  render() {
    var views = this.state.anim.map((value, index) => {
      return (
        <Animated.View key={index} style={[styles.demo, styles['demo' + index], {
            left: value.interpolate({
              inputRange: [0, 1],
              outputRange: [0, 200],
            })
          }]}>
          <Text style={styles.text}>
            我是第{index + 1}个View
          </Text>
        </Animated.View>
      );
    });
    return (
      <View style={styles.container}>
        <Text>
          sequence/delay/stagger/parallel演示
        </Text>
        { views }
      </View>
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
  demo0: {
    backgroundColor: 'pink',
    marginTop: 20,
  },
  demo1: {
    backgroundColor: 'red',
    marginTop: 20,
  },
  demo2: {
    backgroundColor: 'green',
    marginTop: 20,
  },
});

AppRegistry.registerComponent('AnimatedDemo', () => AnimatedDemo);
