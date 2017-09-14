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
} from 'react-native';
import {
  Router,
  Scene,
  Reducer,
  Modal,
  Switch,
  Actions,
  ActionConst
} from 'react-native-router-flux';
import Button from "react-native-button";

import QQM_TabIcon from './components/QQM_TabIcon';
import QQM_Home from './components/QQM_Home';
import QQM_Bill from './components/QQM_Bill';
import QQM_Me from './components/QQM_Me';
import QQM_Message from './components/QQM_Message';

const reducerCreate = params => {
  const defaultReducer = new Reducer(params);
  console.log('params: ', params);
  return (state, action) => {
    console.log('action: ', action);
    return defaultReducer(state, action);
  };
};

const getSceneStyle = (props, computedProps) => {
  // console.log('getSceneStyle', props, computedProps);
  const style = {
    flex: 1,
    backgroundColor: 'white',
    shadowColor: null,
    shadowOffset: null,
    shadowOpacity: null,
    shadowRadius: null,
  };
  if (computedProps.isActive) {
    style.marginTop = computedProps.hideNavBar ? 0 : 64;
    style.marginBottom = computedProps.hideTabBar ? 0 : 50;
  }
  return style;
};

const navigationBarStyle1 = {
  backgroundColor: '#f5f5f9',
  borderBottomWidth: 0,
}

class DetailExample extends Component {
  render() {
    return (
      <Router createReducer={reducerCreate} getSceneStyle={getSceneStyle}>
        <Scene key="modal" component={Modal} >

          <Scene key="root">
            <Scene key="qqm_main" tabs initial tabBarStyle={styles.tabBarStyle}>
              <Scene key="qqm_home" tabTitle="首页" component={QQM_Home} navigationBarStyle={navigationBarStyle1} icon={QQM_TabIcon} image={require('./images/tab_home.png')} selectedImage={require('./images/tab_homeH.png')} />
              <Scene key="qqm_bill" tabTitle="账单" title="账单" component={QQM_Bill} icon={QQM_TabIcon} image={require('./images/tab_bill.png')} selectedImage={require('./images/tab_billH.png')} />
              <Scene key="qqm_me" tabTitle="我的" title="我的" component={QQM_Me} icon={QQM_TabIcon} image={require('./images/tab_me.png')} selectedImage={require('./images/tab_meH.png')} />
            </Scene>
            <Scene key="qqm_message" title="消息中心" component={QQM_Message} getPanHandlers={(params) => {
              console.log('message', params)
              alert('返回');
            }}/>
          </Scene>

          <Scene key="error" component={Error} />
        </Scene>
      </Router>
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
  tabBarStyle: {
    backgroundColor: '#f8f8f8',
    borderTopWidth: 1,
    borderTopColor: '#b2b2b2',
  },
  tabBarSelectedItemStyle: {
    backgroundColor: 'green'
  },
});

export default DetailExample;
