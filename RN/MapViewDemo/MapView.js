import React, { Component, PropTypes } from 'react';
import {
  requireNativeComponent,
} from 'react-native';

// requireNativeComponent 自动把这个组件提供给 “LPYMapManager”
var LPYMap = requireNativeComponent('LPYMap', MapView);

export default class MapView extends Component {
  static propTypes = {
    pitchEnabled: PropTypes.bool,
  };
  constructor(props) {
    super(props);
  }

  render() {
    return <LPYMap {...this.props} />;
  }
}
