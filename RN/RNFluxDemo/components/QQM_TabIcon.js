/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component, PropTypes } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
} from 'react-native';

const QQM_TabIcon = (props) => {
  console.log('props', props);
  return (
    <View style={styles.container}>
      <Image source={props.selected ? props.selectedImage : props.image} style={styles.imageStyle} />
      <Text style={[styles.textStyle, {color: props.selected ? '#ff8500' : '#8b8b8b'}]}>
        {props.tabTitle}
      </Text>
    </View>
  )
};

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center',
  },
  imageStyle: {
    width: 21,
    height: 20,
  },
  textStyle: {
    fontSize: 10,
    marginTop: 7,
  }
});

QQM_TabIcon.propTypes = {
  selected: PropTypes.bool,
  title: PropTypes.string,
};

export default QQM_TabIcon;
