import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

/**
 * 函数式组件
 * 一个函数就是一个组件，函数式组件只能接受props而无法像类组件一样可以在constructor里面初始化state
 * 函数式组件就是一种只能接受props和提供render方法的类组件
 * 
 * @param {*} props 
 */
const HelloWorld = (props) => {
  const sayHi = (event) => alert("Hello World");
  return (
    <div onClick={sayHi}>Hello World</div>
  );
};

class Index extends Component {
  render() {
    return (
      <div>
        <HelloWorld/>
      </div>
    );
  }
}

ReactDOM.render(
  <Index />,
  document.getElementById('root')
);
