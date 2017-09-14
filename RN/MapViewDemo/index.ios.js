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
} from 'react-native';

import MapView from './MapView';

class MapViewDemo extends Component {
  render() {
    return (
      <View style={styles.container}>
        <MapView pitchEnabled={false} style={{flex: 1, backgroundColor: 'green'}}/>
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
});

AppRegistry.registerComponent('MapViewDemo', () => MapViewDemo);
