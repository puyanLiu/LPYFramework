import React, { Component, PropTypes } from 'react';
import HeaderTop from './HeaderTop.js';

class Header extends Component {

  static propTypes = {
    themeColor: PropTypes.string,
    headerTitle: PropTypes.string,
    onChangeHeaderTitle: PropTypes.func
  };

  _handleChangeHeaderTitle() {
    if(this.props.onChangeHeaderTitle) {
      this.props.onChangeHeaderTitle('哈哈被改变的文字');
    }
  }

  render() {
    console.log('render header');
    return (
      <div>
        <h2 style={{ color: this.props.themeColor }}>{this.props.headerTitle}</h2>
        <HeaderTop />
        <button style={{ color: this.props.themeColor}} 
         onClick={this._handleChangeHeaderTitle.bind(this)}>改变文字 哈哈</button>
      </div>
    );
  }
}

export default Header;
