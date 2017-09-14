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
  Image,
  TouchableOpacity
} from 'react-native';
import {
  Actions
} from 'react-native-router-flux';
import Button from "react-native-button";
import NavButton from './NavButton';

class QQM_Home extends Component {

  componentDidMount() {
    console.log('QQM_Home', this.props);
    this.props.navigationState.renderLeftButton = () => <NavButton source={require('../images/signIn.png')} type="left" width={21} height={19} onPress={() => this._onLeftClick()} />
    this.props.navigationState.renderRightButton = () => <NavButton source={require('../images/message.png')} type="right" width={21} height={17} onPress={() => this._onRightClick()} />
  }

  _onLeftClick() {
    alert('点击了左边');
  }

  _onRightClick() {
    Actions.qqm_message();
  }

  render() {
    return (
      <View style={[styles.container, this.props.style]}>
        <Text style={styles.welcome}>
          Home
        </Text>
        <Button onPress={Actions.loginModal2}>Login2</Button>
        <Button onPress={() => Actions.refresh({title: '哈哈标题被改变啦'})}>change title</Button>
        <Button onPress={Actions.pop}>back</Button>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f9',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
});

export default QQM_Home;
