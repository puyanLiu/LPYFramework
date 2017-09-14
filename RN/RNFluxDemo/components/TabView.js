/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component, PropTypes } from 'react';
import {
  StyleSheet,
  Text,
  View
} from 'react-native';
import {
  Actions
} from 'react-native-router-flux';
import Button from "react-native-button";

const TabView = (props, context) => {
  const drawer = context.drawer;
  return (
    <View style={[styles.container, props.sceneStyle]}>
      <Text style={styles.welcome}>Tab {props.title}</Text>
      {props.name === 'tab1_1' && <Button onPress={Actions.tab1_2}>next screen for tab1_2</Button>}
      {props.name === 'tab2_1' && <Button onPress={Actions.tab2_2}>next screen for tab2_2</Button>}
      <Button onPress={Actions.pop}>back</Button>
      <Button onPress={() => {drawer.close(); Actions.tab1();}}>tab1</Button>
      <Button onPress={() => {drawer.close(); Actions.tab2();}}>tab2</Button>
      <Button onPress={() => {drawer.close(); Actions.tab3();}}>tab3</Button>
      <Button onPress={() => {drawer.close(); Actions.tab4();}}>tab4</Button>
      <Button onPress={() => {drawer.close(); Actions.tab5();}}>tab5</Button>
      <Button onPress={() => {drawer.close(); Actions.echo();}}>push new scene</Button>
    </View>
  );
};

TabView.contextTypes = {
  drawer: PropTypes.object,
};

TabView.propTypes = {
  name: PropTypes.string,
  sceneStyle: View.propTypes.style,
  title: PropTypes.string
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'pink',
    borderWidth: 5,
    borderColor: '#ccc',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

export default TabView;
