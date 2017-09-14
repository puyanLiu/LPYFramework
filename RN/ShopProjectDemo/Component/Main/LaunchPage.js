import React, {
  Component
} from 'react';
import {
  StyleSheet,
  Text,
  Image,
  View,
  Dimensions,
} from 'react-native';

import Main from './Main';

var {width, height} = require('Dimensions').get('window');

class LaunchPage extends Component {
  render() {
    return (
      <Image source={require('../../Image/launchimage.png')} resizeMode='cover' style={{width: width, height: height}} />
    );
  }

  componentDidMount() {
    setTimeout(() => {
      this.props.navigator.replace({
        component: Main
      });
    }, 1500);
  }
}


module.exports = LaunchPage;
