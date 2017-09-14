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

class Echo extends Component {
  render() {
    console.log('navigationState', this.props.navigationState);
    return (
      <View style={[styles.container, this.props.sceneStyle]}>
        <Text style={styles.instructions}>key: {this.props.navigationState.key}</Text>
        <Text style={styles.instructions}>sceneKey: {this.props.navigationState.sceneKey}</Text>
        
        <Button style={styles.smaller} onPress={() => Actions.echo()}>
          push new scene hideNavBar = inherit hideTabBar = inherit
        </Button>

        <Button style={styles.smaller} onPress={() => Actions.echo({hideNavBar: true, hideTabBar: true})}>
          push new scene hideNavBar = true hideTabBar = true
        </Button>

        <Button style={styles.smaller} onPress={() => Actions.echo({hideNavBar: true, hideTabBar: false})}>
          push new scene hideNavBar = true hideTabBar = false
        </Button>

        <Button style={styles.smaller} onPress={() => Actions.echo({hideNavBar: false, hideTabBar: true})}>
          push new scene hideNavBar = false hideTabBar = true
        </Button>

        <Button style={styles.smaller} onPress={() => Actions.echo({hideNavBar: false, hideTabBar: false})}>
          push new scene hideNavBar = false hideTabBar = false
        </Button>

        <Button style={styles.smaller} onPress={() => Actions.pop()}>
        pop
        </Button>
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
  instructions: {
      textAlign: "center",
      color: "#333333",
      marginBottom: 5,
  },
  smaller: {
      marginBottom: 5,
      fontSize: 12,
  },
});

export default Echo;
