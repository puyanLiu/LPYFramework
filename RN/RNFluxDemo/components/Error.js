/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Animated,
  Dimensions
} from 'react-native';
import {
  Actions
} from 'react-native-router-flux';
import Button from "react-native-button";

var { height: deviceHeight } = Dimensions.get('window');

class Error extends Component {
  constructor(props) {
    super(props);

    this.state = {
      offsetY: new Animated.Value(-deviceHeight)
    };
  }

  componentDidMount() {
    Animated.timing(this.state.offsetY, {
      duration: 150,
      toValue: 0
    }).start();
  }

  closeModal() {
    Animated.timing(this.state.offsetY, {
      duration: 150,
      toValue: -deviceHeight
    }).start(Actions.pop);
  }

  render() {
    return (
      <Animated.View style={[styles.container, {transform: [{translateY: this.state.offsetY}]}]}>
        <View style={{ width: 250, height: 250, justifyContent: 'center', alignItems: 'center', backgroundColor: 'white'}}>
          <Text style={styles.welcome}>
            Error: {this.props.data}
          </Text>
           <Button onPress={this.closeModal.bind(this)}>Close</Button>
        </View>
      </Animated.View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(52,52,52,0.5)',
    position: 'absolute',
    top: 0,
    left: 0,
    bottom: 0,
    right: 0,
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

export default Error;
