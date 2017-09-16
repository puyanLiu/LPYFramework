import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

/**
 * 组件的挂载
 * React.js将组件渲染，并且构造DOM元素然后塞入页面的过程
 * 组件初始化->挂载到页面上
 * constructor()
 * componentWillMount() // 组件挂载开始之前，在组件调用render方法之前调用
 * render() 
 * componentDidMount() // 组件挂载完成后，在DOM元素塞入页面以后调用
 * componentWillUnmount() // 组件对应的DOM元素从页面中删除之前调用
 */

class Header extends Component {
  /**
   * 一般情况，所有关于组件自身的状态的初始化工作都会放在constructor里面去做
   */
  constructor() {
    super();
    console.log('constructor');
    this.state = {
      date: new Date()
    };
  }

  /**
   * 一些组件启动的动作，包括像Ajax数据的拉取操作、一些定时器的启动等，就可以在componentWillMount里面进行
   */
  componentWillMount() {
    console.log('componentWillMount');
    this.timer = setInterval(() => {
      // setState只能在已经挂载或者正在挂载的组件上调用
      this.setState({ date: new Date() });
    }, 1000);
  }

  render() {
    console.log('render');
    return (
      <div>
        <h1 className='title'>现在的时间是</h1>
        {this.state.date.toLocaleTimeString()}
      </div>
    );
  }

  /**
   * 有些组件的启动工作室依赖DOM的，例如动画的启动，而在componentWillMount的时候组件还没有挂载完成，因此没法进行这些启动工作，
   * 这时候就把这些操作放在componentDidMount当中
   */
  componentDidMount() {
    console.log('componentDidMount');
  }

  /**
   * 组件销毁调用，做一些数据清理工作
   */
  componentWillUnmount() {
    console.log('componentWillUnmount');
    // 清除该组件的定时器和其他数据清理工作
    clearInterval(this.timer);
  }
}

class Index extends Component {
  constructor() {
    super();
    this.state = {
      isShowHeader: true
    }
  }

  _handleShowOrHide() {
    this.setState({
      isShowHeader: !this.state.isShowHeader
    });
  }

  render() {
    return (
      <div>
        { this.state.isShowHeader ? <Header /> : null }
        <button onClick={this._handleShowOrHide.bind(this)}>
          显示或者隐藏标题
        </button>
      </div>
    );
  }
}

ReactDOM.render(
  <Index />,
  document.getElementById('root')
);
