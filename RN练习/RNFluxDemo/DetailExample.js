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

import EchoView from './components/EchoView';
import Error from './components/Error';
import Home from './components/Home';
import Launch from './components/Launch';
import Login from './components/Login';
import Login2 from './components/Login2';
import Login3 from './components/Login3';
import NavigationDrawer from './components/NavigationDrawer';
import Register from './components/Register';
import TabIcon from './components/TabIcon';
import TabView from './components/TabView';


const reducerCreate = params => {
  const defaultReducer = new Reducer(params);
  console.log('params: ', params);
  return (state, action) => {
    console.log('action: ', action);
    return defaultReducer(state, action);
  };
};

const getSceneStyle = (props, computedProps) => {
  console.log('getSceneStyle', props, computedProps);
  const style = {
    flex: 1,
    backgroundColor: 'red',
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

let currentSwitchPage = 'text1';
const SwitcherPage = (props) => (
  <View>
    <Text style={{ marginTop: 100, textAlign: 'center'}}>咚咚咚，当前为文本内容是: {props.text}</Text>
    <Button onPress={() => {
      currentSwitchPage = (currentSwitchPage === 'text1' ? 'text2' : 'text1');
      Actions.refresh({ key: 'switcher' });
    }}>点我看看有啥好玩的</Button>
    <Button onPress={() => {
      Actions.launch({ type: ActionConst.RESET });
    }}>Exit</Button>
  </View>
);


class DetailExample extends Component {
  render() {
    return (
      <Router createReducer={reducerCreate} getSceneStyle={getSceneStyle}>
        <Scene key="modal" component={Modal} >
          <Scene key="root" hideNavBar hideTabBar>
            <Scene key="echo" component={EchoView} clone getTitle={(navState) => navState.key} />
            <Scene key="launch" component={Launch} title="Launch" />
            {
              /*Switch有问题*/
            }
            <Scene key="switcher" component={Switch} selector={() => { return 'text1';}} >
              <Scene key="text1" text="text1" component={(props) => <SwitcherPage {...props} text={currentSwitchPage} />} />
              <Scene key="text2" text="text2" component={(props) => <SwitcherPage {...props} text={currentSwitchPage} />} />
            </Scene>
            
            <Scene key="register" component={Register} title="Register" />
            <Scene key="register2" component={Register} title="Register" duration={1} />
            <Scene key="register3" component={Register} title="Register" direction="vertical" />
            <Scene key="register4" component={Register} title="Register" direction="leftToRight" />
            <Scene key="home" component={Home} title="Home" type={ActionConst.REPLACE} />

            <Scene key="login" direction="vertical" hideTabBar>
              <Scene key="loginModal" component={Login} title="Login" direction="vertical" />
              <Scene key="loginModal2" component={Login2} title="Login2" hideNavBar panHandles={null} />
              <Scene key="loginModal3" component={Login3} title="Login3" hideNavBar panHandles={null} />
            </Scene>

            <Scene key="tabbar" component={NavigationDrawer}>
              <Scene key="main" tabs tabBarStyle={styles.tabBarStyle} tabBarSelectedItemStyle={styles.tabBarSelectedItemStyle} >
                <Scene key="tab1" title="tab1 title1" icon={TabIcon} navigationBarStyle={{backgroundColor: 'purple'}} titleStyle={{color: 'white'}}>
                  <Scene key="tab1_1" component={TabView} title="tab1_1 title1_1" onRight={() => alert('right button')} rightTitle="right" />
                  <Scene key="tab1_2" component={TabView} title="tab1_2 title1_2" titleStyle={{color: 'black'}} />
                </Scene>
                <Scene key="tab2" title="tab2 title2" icon={TabIcon} initial>
                  <Scene key="tab2_1" component={TabView} title="tab2_1 title2_1" renderRightButton={() => <Text>Right</Text>} />
                  <Scene key="tab2_2" component={TabView} title="tab2_2 title2_2" hideBackImage onBack={() => alert('left button')} backTitle="left" duration={1} panHandles={null} />
                </Scene>
                <Scene key="tab3" component={TabView} title="tab3 title3" icon={TabIcon}></Scene>
                <Scene key="tab4" component={TabView} title="tab4 title4" icon={TabIcon}></Scene>
                <Scene key="tab5" component={TabView} title="tab5 title5" icon={TabIcon} hideNavBar></Scene>
              </Scene>
            </Scene>
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
    backgroundColor: 'orange',
  },
  tabBarSelectedItemStyle: {
    backgroundColor: 'green'
  },
});

export default DetailExample;
