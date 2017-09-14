import React, {
  Component
} from 'react';
import {
  StyleSheet,
  Text,
  View,
  Platform, // 识别系统
  Navigator,
  Image,
} from 'react-native';

import TabNavigator from 'react-native-tab-navigator';

var Home = require('../Home/Home');
var Shop = require('../Shop/Shop');
var Mine = require('../Mine/Mine');
var More = require('../More/More');

class Main extends Component {

  constructor(props) {
    super(props);

    this.state = {
      selectedTabItem: 'Home'
    };
  }

  render() {
    return (
      <TabNavigator>
        {this.renderItem('首页', require('../../Image/icon_tabbar_homepage.png'), require('../../Image/icon_tabbar_homepage_selected.png'), 'Home', Home, 10)}
        {this.renderItem('商家', require('../../Image/icon_tabbar_merchant_normal.png'), require('../../Image/icon_tabbar_merchant_selected.png'), 'Shop', Shop)}
        {this.renderItem('我的', require('../../Image/icon_tabbar_mine.png'), require('../../Image/icon_tabbar_mine_selected.png'), 'Mine', Mine)}
        {this.renderItem('更多', require('../../Image/icon_tabbar_misc.png'), require('../../Image/icon_tabbar_misc_selected.png'), 'More', More)}
          </TabNavigator>
    );
  }


  /*
  let tabBarHeight = 0;
  <TabNavigator
    tabBarStyle={{ height: tabBarHeight, overflow: 'hidden' }}
    sceneStyle={{ paddingBottom: tabBarHeight }}
  />
  */
  renderItem(title, renderIcon, renderSelectedIcon, selected, component, badgeText) {
    return (
      <TabNavigator.Item
      title = {title}
      selectedTitleStyle = {styles.tabTitleStyle}
      renderIcon = {() => < Image source = {renderIcon} style = {styles.tabIconStyle} />}
      renderSelectedIcon = {() => <Image source={renderSelectedIcon} style={styles.tabIconStyle} />}
      selected = {this.state.selectedTabItem === selected}
      onPress = {() => this.setState({
          selectedTabItem: selected
        })}
      renderBadge = {() => {
        if (badgeText) {
          return (
            <View style={styles.badgeContainer}>
              <Text style={styles.badgeText}>
                {badgeText}
              </Text>
            </View>
          );
        }
        return null;
      }}
        >
      <Navigator
        initialRoute = {{
          name: title,
          component: component}}
        configureScene = {
          (route) => {
            return Navigator.SceneConfigs.PushFromRight;
          }
        }
        renderScene = {
          (route, navigator) => {
            // 把模块生成具体的组件
            let Component = route.component;
            return <Component {...route.passProps} navigator={navigator} />
          }}
        />

        </TabNavigator.Item>
      );
    }
  }

  const styles = StyleSheet.create({
    tabTitleStyle: {
      color: 'orange',

    },
    tabIconStyle: {
      width: Platform.OS == 'ios' ? 30 : 25,
      height: Platform.OS == 'ios' ? 30 : 25,
    },
    badgeContainer: {
      height: 16,
      backgroundColor: 'red',
      borderRadius: 8,
      justifyContent: 'center',
      alignItems: 'center',
      position: 'absolute',
      top: 0,
      paddingLeft: 5,
      paddingRight: 5,
    },
    badgeText: {
      fontSize: 10,
      color: '#fff'
    }
  });

  module.exports = Main;
