import React, {
  Component
} from 'react';
import {
  StyleSheet,
  Text,
  View,
  ScrollView,
} from 'react-native';

var CommonNavBar = require('../Main/CommonNavBar');
var MoreCell = require('./MoreCell');

class More extends Component {
  render() {
    return (
      <View style={styles.container}>
        <CommonNavBar title='更多产品' rightIcon={require('../../Image/icon_mine_setting.png')} />
        <ScrollView style={styles.scrollViewStyle}>
          <View style={{marginTop: 15}}>
            <MoreCell leftTitle='扫一扫' />
          </View>
          <View style={{marginTop: 15}}>
            <MoreCell leftTitle='省流量模式' isShowSwitch={true} />
            <MoreCell leftTitle='清空缓存' rightTitle='18.22MB' />
          </View>
          <View style={{marginTop: 15}}>
            <MoreCell leftTitle='意见反馈' />
            <MoreCell leftTitle='我要应聘' rightTitle='5个iOS岗位' />
          </View>
          <View style={{marginTop: 15}}>
            <MoreCell leftTitle='精品应用' />
          </View>
        </ScrollView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  scrollViewStyle: {
    backgroundColor: '#e8e8e8',
  },
});

module.exports = More;
