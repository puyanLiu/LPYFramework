import React, { Component } from 'react';
import {
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
var NewsDetail = require('./NewsDetail');

class Find extends Component {
    
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

  // 跳转到新闻详情页
    pushToNewsDetail(docid) {
        console.log(this.props);
        this.props.navigator.push({
            title: '详情页',
            component: NewsDetail,
            passProps: {docid},
            backButtonTitle: '返回',
        });
    }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={() => this.pushToNewsDetail()}>
          <Text>
          跳转到详细页
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

module.exports = Find;