import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import CommentApp from './CommentApp.js';

class Header extends Component {
  render() {
    return (
      <div>
        <h2>This is header</h2>
        <Title />
      </div>
    );
  }
}

class Title extends Component {

  /**
   * 子组件要获取context里面的内容的话，就必须写contextTypes来声明和验证你需要获取的状态的类型，
   * 也是必写的，如果不写就无法获取context里面的状态
   */
  static contextTypes = {
    themeColor: PropTypes.string
  }
  
  render() {
    return (
      <div>
        <h1 style={{color: this.context.themeColor}}>This is title</h1>
      </div>
    );
  }
}

class Main extends Component {
  render() {
    return (
      <div>
        <h2>This is main</h2>
        <Content />
      </div>
    );
  }
}

class Content extends Component {
  render() {
    return (
      <div>
        <h2>This is content</h2>
      </div>
    );
  }
}

/**
 * context
 * 某个组件只要往自己的 context 里面放了某些状态，
 * 这个组件之下的所有子组件都直接访问这个状态而不需要通过中间组件的传递。
 * 一个组件的 context 只有它的子组件能够访问，它的父组件是不能访问到的，
 * 你可以理解每个组件的 context 就是瀑布的源头，只能往下流不能往上飞
 */
class Index extends Component {
  
  /**
   * 作用跟propsTypes验证组件props参数的作用类似
   * 不过它是验证getChildContext返回的对象
   * 
   * 如果给组件设置context，那么childContextTypes是必写的
   */
  static childContextTypes = {
    themeColor: PropTypes.string
  }

  constructor() {
    super();
    this.state = {
      themeColor: 'red'
    }
  }

  componentWillMount() {
    this.setState({
      themeColor: 'green'
    });
  }

  /**
   * 设置context的过程，它返回的对象就是context，所有的子组件都可以访问到这个对象
   */
  getChildContext() {
    return { themeColor: this.state.themeColor }
  }

  render() {
    return (
      <div>
        <Header />
        <Main />
      </div>
    );
  }
}

ReactDOM.render(
  <Index />,
  document.getElementById('root')
);
