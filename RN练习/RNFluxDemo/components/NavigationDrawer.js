/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component, PropTypes } from 'react';
import {
  Text,
  View
} from 'react-native';
import {
  Actions,
  DefaultRenderer
} from 'react-native-router-flux';
import Drawer from 'react-native-drawer';

import TabView from './TabView';

class NavigationDrawer extends Component {
  render() {
    const state = this.props.navigationState;
    const children = state.children;
    console.log('children', children, 'state', state);
    return (
      <Drawer 
        ref="navigation" 
        type="displace"
        onOpen={() => Actions.refresh({ key: state.key, open: true })}
        onClose={() => Actions.refresh({ key: state.key, open: true })}
        content={<TabView />}
        tapToClose
        openDrawerOffset={0.2}
        panCloseMask={0.2}
        negotiatePan
        tweenHandle={(radio) => {
          main: { opacity: Math.max(0.54, 1 - radio) }
        }}
        >
        <DefaultRenderer navigationState={children[0]} onNavigate={this.props.onNavigate} />
      </Drawer>
    );
  }
}

NavigationDrawer.propTypes = {
  navigationState: PropTypes.object
};

export default NavigationDrawer;
