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
  TouchableOpacity,
  NativeModules,
  // NativeAppEventEmitter
  NativeEventEmitter
} from 'react-native';

const RNBridgeModule = NativeModules.RNBridgeModule;
const Emitter =  new NativeEventEmitter(RNBridgeModule);
var subscription; // 订阅者

class CommunicationDemo extends Component {

  constructor(props) {
    super(props);
    this.state = {
      events: '',
      msg: '',
    };
  }

  componentDidMount() {
    console.log('------------开始订阅通知');

    subscription = Emitter.addListener('OCInvokeRNEvent', (bodyInfo) => {
      console.log('原生调用RN');
      let errorCode = bodyInfo.errorCode;
      if (errorCode === 0) {
        this.setState({
          msg: bodyInfo.name
        });
      } else {
        this.setState({
          msg: bodyInfo.msg
        });
      }
    });
  }

  componentWillUnmount() {
    console.log('------------移除订阅通知');
    subscription.remove();
  }

  async updateEvents() {
    try {
      var events = RNBridgeModule.RNInvokeOCPromise({name: 'xiaozhang'});
      console.log('----------', events);
      this.setState({events: events});
    } catch (e) {
      this.setState({events: e.message})
    } finally {

    }
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          返回数据：{`${this.state.events}`}
        </Text>

        <TouchableOpacity onPress={() => {
          RNBridgeModule.RNInvokeOCCallBack({"name": "xiaowang", "age": 18}, (error, events) => {
            if (error) {
              console.error(error);
            } else {
              this.setState({events: events});
            }
          })
        }}>
          <Text>
            RN调用iOS原生方法 callback回调
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => this.updateEvents()}>
          <Text>
            RN调用iOS原生方法 promise回调
          </Text>
        </TouchableOpacity>

        <Text style={styles.welcome}>
          iOS调用RN方法 返回数据：{`${this.state.msg}`}
        </Text>
        <TouchableOpacity onPress={() => RNBridgeModule.OCInvokeRN({'name': 'xiaowang'})}>
          <Text>
            iOS调用RN方法
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => RNBridgeModule.RNInvokeOCOpenOCVC('NativeViewController')}>
          <Text>
            RN跳转到原生界面
          </Text>
        </TouchableOpacity>
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
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
});

AppRegistry.registerComponent('CommunicationDemo', () => CommunicationDemo);
