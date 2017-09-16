import React, { Component, PropTypes } from 'react';
import ThemeSwitch from './ThemeSwitch.js';
import { connect } from 'react-redux';

class Content extends Component {

  static propTypes = {
    themeColor: PropTypes.string
  };

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
