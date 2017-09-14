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

const TabIcon = (props) => {
  console.log('props', props);
  return (
    <Text style={{color: props.selected ? 'red' : 'blue'}}>
      {props.title}
    </Text>
  )
};

TabIcon.propTypes = {
  selected: PropTypes.bool,
  title: PropTypes.string,
};

export default TabIcon;
