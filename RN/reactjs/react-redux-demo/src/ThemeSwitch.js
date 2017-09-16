import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux.js';

class ThemeSwitch extends Component {

  static propTypes = {
    themeColor: PropTypes.string,
    onSwitchColor: PropTypes.func
  };

   /**
   * 可以通过这个方法控制组件是否重新渲染，如果返回false组件就不会重新渲染，一般用在性能优化上
   * @param {*} nextProps 
   * @param {*} nextState 
   */
//   shouldComponentUpdate(nextProps, nextState) {
//     if(this.props.themeColor === nextProps.themeColor)
//       return false;
//     return true;
//   }

  _handleSwitchColor(color) {
      if(this.props.onSwitchColor) {
          this.props.onSwitchColor(color);
      }
  }

  render() {
    console.log('render themeSwitch');
    return (
      <div>
          <button style={{ color: this.props.themeColor }}
           onClick={this._handleSwitchColor.bind(this, 'red')}>Red</button>
          <button style={{ color: this.props.themeColor }}
           onClick={this._handleSwitchColor.bind(this, 'blue')}>Blue</button>
      </div>
    );
  }
}

const mapStateToProps = (state) => {
    return {
        themeColor: state.themeColor
    };
};
const mapDispatchToProps = (dispatch) => {
    return {
        onSwitchColor: (color) => {
            dispatch({ type: 'CHANGE_COLOR', themeColor: color });
        }
    };
};
ThemeSwitch = connect(mapStateToProps, mapDispatchToProps)(ThemeSwitch);
export default ThemeSwitch;
