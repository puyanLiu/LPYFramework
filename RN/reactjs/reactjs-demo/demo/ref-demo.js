import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

class AutoFocusInput extends Component {

  componentDidMount() {
    this.input.focus();
  }
 
  /**
   * ref属性 
   * 获取已经挂载的元素的DOM节点
   * 
   * 能不用ref就不用
   */
  render() {
    return (
      <input ref={ (input) => this.input = input } />
    );
  }
}

ReactDOM.render(
  <AutoFocusInput />,
  document.getElementById('root')
);
