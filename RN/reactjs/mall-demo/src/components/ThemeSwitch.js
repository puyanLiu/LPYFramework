import React, { Component, PropTypes } from 'react';

class ThemeSwitch extends Component {

  static propTypes = {
    themeColor: PropTypes.string,
    onSwitchColor: PropTypes.func
  };

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

export default ThemeSwitch;
