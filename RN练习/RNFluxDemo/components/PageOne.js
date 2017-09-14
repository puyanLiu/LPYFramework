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

class PageOne extends Component {
  render() {
    // 路由跳转传递参数
    const goToPageTwo = () => Actions.PageTwo({text: 'hello world！我是通过PageOne传递的'});
    return (
      <View style={styles.container}>
        <Text style={styles.welcome} onPress={goToPageTwo}>
          This is PageOne! 点我有惊喜哦
        </Text>
      </View>
    );

    // 路由跳转不传递参数
    // return (
    //   <View style={styles.container}>
    //     <Text style={styles.welcome} onPress={Actions.PageTwo}>
    //       This is PageOne!
    //     </Text>
    //   </View>
    // );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'orange',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

export default PageOne;
