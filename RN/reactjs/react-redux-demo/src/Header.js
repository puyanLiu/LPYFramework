import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux.js';
import HeaderTop from './HeaderTop.js';

class Header extends Component {

  static propTypes = {
    themeColor: PropTypes.string,
    headerTitle: PropTypes.string,
    onChangeHeaderTitle: PropTypes.func
  };

  /**
   * 可以通过这个方法控制组件是否重新渲染，如果返回false组件就不会重新渲染，一般用在性能优化上
   * @param {*} nextProps 
   * @param {*} nextState 
   */
  shouldComponentUpdate(nextProps, nextState) {
    if(this.props.headerTitle === nextProps.headerTitle && this.props.themeColor === nextProps.themeColor)
      return false;
    return true;
  }

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
         onClick={this._handleChangeHeaderTitle.bind(this)}>改变文字</button>
      </div>
    );
  }
}

const mapStateToProps = (state) => {
    return {
        themeColor: state.themeColor,
        headerTitle: state.headerTitle
    };
};
const mapDispatchToProps = (dispatch) => {
    return {
        onChangeHeaderTitle: (headerTitle) => {
            dispatch({ type: 'CHANGE_HEADERTITLE', headerTitle: headerTitle });
        }
    };
};
Header = connect(mapStateToProps, mapDispatchToProps)(Header);
export default Header;
