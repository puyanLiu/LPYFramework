import React, { Component, PropTypes } from 'react';
import ThemeSwitch from './ThemeSwitch.js';
import { connect } from 'react-redux.js';

class Content extends Component {

  static propTypes = {
    themeColor: PropTypes.string
  };

  /**
   * 可以通过这个方法控制组件是否重新渲染，如果返回false组件就不会重新渲染，一般用在性能优化上
   * @param {*} nextProps 
   * @param {*} nextState 
   */
  shouldComponentUpdate(nextProps, nextState) {
    if(this.props.themeColor === nextProps.themeColor)
      return false;
    return true;
  }

  render() {
    console.log('render content');
    return (
      <div>
        <h2 style={{ color: this.props.themeColor }}>This is content</h2>
        <ThemeSwitch />
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  return {
    themeColor: state.themeColor
  };
};
Content = connect(mapStateToProps)(Content);
export default Content;
