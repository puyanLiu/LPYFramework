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
  TouchableOpacity
} from 'react-native';

const NavButton = (props) => {
  console.log('NavButton', props);
  const navStyle = props.type === 'left' ? {left: 0} : {right: 0};
  const width = props.width > 0 ? {width: props.width} : {};
  const height = props.height > 0 ? {height : props.height} : {};
  return (
    <TouchableOpacity style={[styles.imageContainerStyle, navStyle]} onPress={props.onPress}>
      <View style={styles.leftImageContainerStyle}>
      {props.source && <Image source={props.source} style={[styles.imageStyle, width, height]} />}
      {props.title && <Text>{props.title}</Text>}
      </View> 
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  imageContainerStyle: {
    width: 50,
    height: 40,
    justifyContent: 'center',
    alignItems: 'center',
    position: 'absolute',
    top: 0,
  },
  imageStyle: {
    width: 21, 
    height: 19,
  },
});

NavButton.propTypes = {
  type: PropTypes.string,
};

export default NavButton;
